hirom
; header

; BNW - Palidor Redux
; Bropedio (August 2, 2019)
;
; NOTE: This patch is compatible with Vanilla FF6, aside
; from the wait time set for Palidor ($70, instead of $E0)
;
; Make Palidor jump faster, and keep characters in sync  with each other.
; The wait timer for Palidor has been reduced to match the regular Jump
; timer (nATB), and while flying on Palidor, characters' wait times will
; increment at the same rate, ensuring that they land in quick succession.
;
; Additionally, make character behavior more consistent -- uncontrollable
; and controllable characters will all gain ATB while riding Palidor, but
; unlike in vanilla, the uncontrollable characters will not use their turn
; until they've landed.
;
; This patch also fixes some bugs that mistakenly reset the Palidor caster
; and riders' wait times to the max.
;
; This patch also fixes a glaring bug: Palidor in vanilla leaves riders
; "unhidden", which makes their ATB behavior inconsistent, allows them
; be to targeted by attacks, and lets them run from battle.
;
; Frees "Palidor was summoned this turn" flag ($3A46:$10)
; Requires 30 bytes freespace

!long_free = $C0D990     ; 56 bytes

; ##########################################################
; For BNW - Lower Palidor wait time to match Jump

org $C20B7D : LDA #$70   ; shorten Palidor wait time

; ##########################################################
; Align wait time increments for all Palidor riders, so
; everyone lands at the same time.

org $C21195
  JSL WaitTimer

; ##########################################################
; New Code in C0

org !long_free           ; 30 bytes

WaitTimer:               ; 14 bytes
  LDA $3204,X            ; load 3204,X and 3205,X
  BPL .flying            ; branch if entity is riding Palidor
  LDA $3AC8,X            ; ATB timer incrementor
  LSR                    ; divided by two
  RTL
.flying
  LDA #$00C8             ; use fixed ATB increment while flying
  RTL

BetterPaliFlags:         ; 16 bytes
  BMI .done              ; if not landing, return
  ORA #$80               ; "has landed since boarding Palidor"
  STA $3205,X            ; set "has landed" bit
  LDA $3AA0,X            ; get battle flow byte
  BPL .done              ; skip setting flag if no extra turn
  ORA #$08               ; set bit 3 to preserve ATB
  STA $3AA0,X            ; update battle flow byte
.done
  RTL

ClearWaitQ:              ; 26 bytes
  LDY $3A64              ; current wait queue index
.loop
  TXA                    ; put this rider's index in A
  CMP $3720,Y            ; is this rider in wait queue here?
  BNE .next              ; if not, branch
  LDA #$FF               ; null
  STA $3720,Y            ; set this wait queue entry to null
.next
  INY                    ; get next wait queue index
  CPY $3A65              ; is this lower than the next unfilled entry?
  BCC .loop              ; continue loop if so
  LDA $3205,X            ; vanilla code
  AND #$7F               ; vanilla code
  RTL

; ##########################################################
; Clear Wait Queue for riders, so any pending command inputs
; don't have their wait times added to Palidor's, which would
; cause them to get out of sync with the other riders.

org $C20B72
  JSL ClearWaitQ
  NOP

; ##########################################################
; Before starting Palidor Landing turn, set bit to freeze
; ATB in position. This will ensure uncontrollable characters
; like Umaro or Gau get to take action right away.

org $C2019B
  JSL BetterPaliFlags
  NOP

; ##########################################################
; Shift some branches in post-turn handling. Notably, the
; Palidor caster no longer has their wait timer reset, and
; it's no longer assumed that the caster will be riding.

org $C201AA
  LDA $3205,X          ; some update flags
  BPL .palidor         ; branch if riding Palidor
  LDA $32CC,X          ; entity's action queue entry point
  INC
  BNE .valid           ; branch if not null (queue unfinished)
  LDA #$FF             ; null wait time
  STA $322C,X          ; set wait time
  STZ $3AB5,X          ; zero wait timer gauge
  LDA $3AA0,X          ; some character data
  BIT #$08             ; is ATB gauge stopped
  BNE .counter         ; branch if so
.palidor
  INC $3219,X          ; is ATB gauge at max
  BNE .counter         ; branch if not
  DEC $3219,X          ; return ATB to 255
.counter
  LDA #$80             ; "Currently processing queue"
  TRB $B0              ; unset ^ bit
  JMP $0267            ; execute animation queue
  NOP #2               ; 2 free bytes
.valid
  STX $3406            ; entity is first in line for action queue
  RTS                  ; this RTS is a branch destination
warnpc $C201DA

; ##########################################################
; In some end-of-turn handling, pass Umaro through the same
; handling as Ragers/Dancers, rather than skipping him altogether.
; This ensures he takes his reserve turn after landing.

org $C20928
  BEQ Uncontrolled

org $C20986
Uncontrolled:

; ##########################################################
; When ATB fills, if the "freeze ATB/allow wait timer" flag
; is set already, don't clear current wait timers. This prevents
; riders from getting out of sync wait times if their ATB
; fills while in the air.

org $C211D4
GetATurn:
  LDA #$08             ; "ATB frozen, wait timer enabled"
  BIT $3AA0,X          ; is ^ set already (not normal)
  BNE .get_turn        ; if so, skip wait timer reset & auto-attack queue [?]
  JSR $11B4            ; else, set the bit "ATB frozen, wait timer enabled"
  LSR
  LSR                  ; move $02 into carry ("entity controllable")
  STZ $3AB5,X          ; zero the wait timer
  LDA #$FF             ; "null"
  STA $322C,X          ; null the wait threshold
  BCC QueueWait        ; queue waiting if uncontrollable
.get_turn

org $C2120E
QueueWait:

; ##########################################################
; Rewrite Palidor once-per-strike handler. Now, remove dead targets.

org $C241F6
PalidorStrike:         ; 29 bytes
  TYX                  ; save Y
  LDY #$12             ; use Y for loop through entities
.loop
  PEA $80C0            ; "Petrify", "Sleep"
  PEA $2210            ; "Stop", "Hide", "Freeze"
  JSR $5864            ; clear carry if any are set (also sets 8-bit A)
  BCS .next            ; branch if valid target
  REP #$20             ; 16-bit A
  LDA $3018,Y          ; unique bit
  TRB $A2              ; remove from targets
  TRB $A4              ; remove from targets
.next
  DEY
  DEY                  ; get next entity index
  BPL .loop            ; loop through all entities
  TXY                  ; restore Y
  RTS
PaliHide:              ; 6 bytes
  JSR $464C            ; sets "Palidor target" bit in $3204,Y (vanilla)
  JMP $1F00            ; sets "hide" status on target
warnpc $C2421C

; ##########################################################
; Set Palidor targets to "Hide" in per-target hook. This
; keeps them from being targeted, keeps their ATB functioning
; correctly, and prevents running from battle while in the air.

org $C23936
  JSR PaliHide
