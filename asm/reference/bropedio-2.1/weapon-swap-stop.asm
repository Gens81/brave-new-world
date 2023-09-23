hirom
; header

; BNW - Weapon Swap
; Bropedio (July 19, 2019)
; * Support for HP/MP, Statuses
; * Detect 2-hand/dual-wield properties
; * Consume 1/2 turn for each equip swap
; * Also consume 1/2 turns for row, defend
;
; Changelog:
; July 30, 2020 -- Add handling to not set "Stop" status from equipment
;               -- Remove previous "Stop immunity" patch
;
; Vanilla does not recalculate statuses or Max HP/MP on equipment
; swap. This presents a problem for BNW, since several weapons/shields
; modify these properties. Even in vanilla, this was a bug with the
; cursed shield, which could be swapped in without incurring any of its
; negative statuses.
;
; In addition to supporting weapon swap (when it's finished), this
; patch fixes a hole in the `green-cherry-full-fix` that would prevent
; equipment statuses from persisting when a rage sharing their status
; is removed.
;
; Note: There is a substantial amount of weapon swap code that
; never runs, due to the game disabling the equipment menu when
; an item is selected first. Since this code never runs, I have
; not implemented these changes for that particular code path.
; The branch that never happens: $C18E5A
;
; Battle RAM
; $2E6E (1 byte) - Bitmask for which characters are unequipping
; $2E6F-$2E72 (3 bytes) - Free. Was for genji effect

!unequip = $2E6E  ; 1 RAM byte

; #############################################
; Remove Old Stop Immunity Patch

org $C2265B : ORA #$80 : XBA ; revert to vanilla code
org $C226A0 : AND #$FE78 ; allow "Stop" immunity (EE -> FE)
; padbyte $FF : org $C23C04 : pad $C23C12 ; unused code, avoid overwriting

; #############################################
; Reenable Weapon Swap
; Remove $10 bit from the following data bytes to reenable equipment swap

org $ED7CB5 : db $02 ; Terra
org $ED7CCB : db $00 ; Locke
org $ED7CE1 : db $03 ; Cyan
org $ED7CF7 : db $00 ; Shadow
org $ED7D0D : db $02 ; Edgar
org $ED7D23 : db $02 ; Sabin
org $ED7D39 : db $01 ; Celes
org $ED7D4F : db $03 ; Strago
org $ED7D65 : db $01 ; Relm
org $ED7D7B : db $02 ; Setzer
org $ED7D91 : db $01 ; Mog
org $ED7DA7 : db $00 ; Gau
org $ED7DBD : db $0D ; Gogo

; #############################################
; Set Dual Wield flags on battle inventory items

org $C25528
  JSL FlagDual      ; set item flags for 2-hand and dual-wield

; ############################################
; Fix checks for dual-wield support
; This change makes $2E6E,X (has Gengi Glove) obsolete, so
; those bytes are no longer set. They initialize to $FF
; The empty code now contains a helper routine for "Defend"

org $C22883
  BRA GenjiSkip     ; skip gengi glove effect setting
LongUpdate:
  JSR $2095         ; long access to run equipment updates
  RTL
  NOP #4
GenjiSkip:
warnpc $C2288E
  
org $C14B87         ; code draws valid swaps in yellow
  LDA $890E         ; still-equipped item's flags
  JSR DrawDual      ; set carry if not able to dual wield
  BCS $0F           ; branch if no dual wield

org $C189E4         ; code determines if swap can execute
  LDA $7B3C         ; still-equipped item's flags
  JSR SwapDual      ; set carry if not able to dual wield
  BCS $11           ; branch if no dual wield

; ############################################
; Only update equipment status when swap executes
; One exception is when swapping left and right hand
; equips with each other -- in that case, the update
; flag is set immediately, without incurring a turn.
; Use free space for swap finishing helper

org $C18DFC
  NOP #5            ; no status update when equipment first selected

org $C18A0C         ; skip setting status update flag (until command code)
  CLC               ; clear carry to indicate valid equipment
  RTS

HalfTurn:           ; 6 bytes
  LDA #$7E          ; half-full ATB
  STA $3219,X       ; set new ATB value
  RTL

warnpc $C18A19
padbyte $FF         ; frees 4 bytes
pad $C18A18

; ############################################
; Delay weapon swap until command executes, so
; battle equipment does not get out of sync
; with out-of-battle equipment.
;
; Store swap-in item id in $32F4,X (item reserve).
; If weapon swap is interrupted, this item will be
; returned to inventory.
;
; Route weapon swap through "Defend" command, using
; attack id to indicate mode:
; $FF: Defend, $00: Righthand, $01: Lefthand

org $C18A90
ValidSwap:
  LDA $7B00         ; selected item column
  LSR               ; carry set if righthand (left column)
  LDA $2686,X       ; swap-in item id 
  JMP QueueSwap
  NOP #3
warnpc $C18A9E

org $C18B4D
QueueSwap:          ; 84 bytes
  BCS .right        ; branch if right-hand
  CMP $2B9A,Y       ; compare w/ left-hand equip id
  BRA .continue
.right
  CMP $2B86,Y       ; compare w/ right-hand equip id
.continue
  BEQ .finish       ; branch if same (no reserve item)
  PHA               ; store swap-in item id
  LDA $62CA         ; character slot number
  ASL               ; x2
  TAY               ; use as index to data
  PLA               ; restore swap-in item id
  STA $32F4,Y       ; store in character's reserve
  LDA $2689,X       ; swap-in item quantity
  CMP #$02          ; less than 2? 
  BCC .empty
  DEC $2689,X       ; decrement quantity
  BRA .finish
.empty
  LDA #$FF
  STA $2686,X       ; clear item id
  LDA #$80          ; "unusable in battle"
  STA $2687,X       ; set item flags
  STZ $2688,X       ; zero targeting
  STZ $2689,X       ; zero quantity
  STZ $268A,X       ; zero equip blacklist
.finish
  STZ $890C         ; reset equipment swap mode
  STZ $7BAF         ; unfreeze item menu cursor
  STZ $7BB5         ; unfreeze equip menu cursor
  STZ $7B02         ; unset item swapping flag
  JSR $7E19         ; set "Defend" command, queue menu close, set Y
  LDA $7B00         ; column position (1 = left, 2 = right)
  DEC               ; shift down for mode id
  STA $2BB0,Y       ; set subcommand (default $FF triggers defend)
  CLC               ; indicate no item usage
  RTS

; Handle the "Defend" command executing

SwapOrDefend:       ; 104 bytes
  LDA $B6           ; subcommand (item id)
  BPL SwapMode      ; branch if not mode $FF (defend)
  LDA #$02          ; "defending" flag
  RTL               ; exit
SwapMode:
  TYA               ; character slot * 2
  LSR               ; character slot * 1
  TAX               ; index to *5 table
  INC $2F30,X       ; set flag to recalculate equip properties
  LDA $C14B67,X     ; item data index (x * 5)
  LDX $B6           ; check swap mode
  BEQ .offset       ; branch if right-hand mode
  ADC #$14          ; add left-hand data offset
.offset
  TAX               ; index to equipment data
  LDA $32F4,Y       ; reserve (swap-in) item id
  XBA               ; store temporarily
  LDA $2B86,X       ; swap-out equip id
  STA $32F4,Y       ; set as new reserve item
  CMP #$FF          ; empty?
  BEQ .equip        ; if ^, skip unequip handling
  LDA $3018,Y       ; unique bit for character
  TSB $3A8C         ; return equip to inventory at turn end
  TSB !unequip      ; flag equipment update to remove statuses
.equip
  XBA               ; restore swap-in item
  STA $2B86,X       ; set equip id
  CMP #$FF          ; empty?
  BEQ .unequip      ; if ^, reset equip data to empty
  JSL ItemLookup    ; copy item data into $2E72-2E76
  LDA $2E73         ; item flags
  STA $2B87,X       ; set equip flags
  LDA $2E74
  STA $2B88,X       ; set equip targeting
  LDA #$01          ; only one item
  STA $2B89,X       ; set equip quantity
  LDA $2E76
  STA $2B8A,X       ; set equip blacklist
  BRA .finish
.unequip
  LDA #$80
  STA $2B87,X       ; set unusable in battle
  STZ $2B88,X       ; zero targeting
  STZ $2B89,X       ; zero quantity
  STZ $2B8A,X       ; zero equip blacklist
.finish
  JSL LongUpdate    ; process equipment updates immediately
  TDC               ; don't set "defending" on return
  RTL

; Clear statuses of swapped-out equipment

ClearStatus:        ; 42 bytes
  LDA #$FF          ; prepare to toggle equipment statuses
  EOR $3C6C,Y       ; inverted equipment status 2
  AND $D85019,X     ; unequip status 2
  AND $3EE5,Y       ; lost statuses that are currently set
  STA $3DFD,Y       ; set status-to-clear 2
  LDA $3C6D,Y       ; equipment status 3
  EOR #$FF          ; inverted equipment status 3
  AND $D85008,X     ; unequip status 3
  LSR               ; shift permanent float into Carry
  BCC .clear3       ; branch if no float
  PHA               ; save potential clears
  LDA #$80          ; float bit
  STA $3E11,Y       ; set status-to-clear 4
  PLA               ; restore shifted potential clears
.clear3
  ASL               ; shift byte 3 back (without permanent float)
  AND $3EF8,Y       ; remove not-set statuses
  STA $3E10,Y       ; set status-to-clear 3
  RTL

; Set equipment statuses

SetStatus:          ; 54 bytes
  LDA $3EE5,X       ; current status 2
  EOR #$FF          ; inverted current status 2
  AND $3C6C,X       ; equipment statuses that are not set
  ORA $3DD5,X       ; combine with status-to-set 2
  STA $3DD5,X       ; update status-to-set 2
  LSR 
  BCC .byte3        ; branch if Condemned not marked to be set
  LDA $3204,X       ; special turn flags
  AND #$EF          ; turn off bit 4
  STA $3204,X       ; if setting Condemned, omit "disable condemned"
.byte3
  LDA $3C6D,X       ; equipment status 3
  LSR               ; shift permanent float into Carry
  BCC .set3         ; branch if not set
  LDA #$80          ; float bit
  ORA $3DE9,X       ; combine with status-to-set 4
  STA $3DE9,X       ; update status-to-set 4
.set3
  LDA $3EF8,X       ; current status 3
  EOR #$FF          ; unset statuses 3
  AND $3C6D,X       ; equipment statuses that aren't set
  AND #$EF          ; equipment statuses other than "Stop" that aren't set ; TODO: Make sure there's space for this
  ORA $3DE8,X       ; combine with status-to-set 3
  STA $3DE8,X       ; update status-to-set 3
  RTL

; Update HP/MP based on equipment (16-bit A)

NewMaxHP:           ; 45 bytes
  LDA $160B,Y       ; get max HP
  JSL HPLookup      ; get max HP after equipment/relic boosts
  CMP #$2710
  BCC .notover
  LDA #$270F        ; if it was >= 10000, make it 9999
.notover
  STA $3C1C,X       ; max HP
  CMP $3BF4,X       ; compare to current HP
  BCS .mp
  STA $3BF4,X       ; if current HP too high, set to Max
.mp
  LDA $160F,Y       ; get maximum MP
  JSL HPLookup      ; get max MP after equipment/relic boosts
  CMP #$03E8
  BCC .notover2
  LDA #$03E7        ; if it was >= 1000, make it 999
.notover2
  STA $3C30,X       ; max MP
  RTL

; Additional helpers

DrawDual:           ; 14 bytes
  ORA $2D           ; combine with swap-in item flags
  BRA CanDual       ; branch to check flags
SwapDual:
  ORA $7B3A         ; combine with swap-in item flags
CanDual:
  LSR               ; "block dual wield" in carry
  BCS .nope         ; exit with carry set
  EOR #$FF          ; toggle "allow dual wield" flag
  LSR               ; "not allow dual wield" in carry
.nope
  RTS

FlagDual:           ; 21 bytes
  LDA $D8500C,X     ; battle effect byte 2
  AND #$18          ; dual wield / two-handed
  CMP #$18
  BEQ .end          ; branch if doesn't enable or block dual wield
  LSR
  LSR
  LSR               ; bit 1: enable dual wield, bit 0: block dual wield
  TSB $2E73         ; set in item flags buffer
.end
  REP #$21          ; displaced vanilla code
  STZ $EE           ; displaced vanilla code
  RTL

warnpc $C18CB8
padbyte $FF
pad $C18CB7

; ############################################
; Defend/Row/WeaponSwap Command handling
; Changed to consume 1/2 turns only, and
; flag equipment update for WeaponSwap,
; which enters with the "Defend" command id.

org $C2196B
  JSL SwapOrDefend  ; prep status-to-clear and return 0 or 2
  JSR $5BAB         ; set defend flag (or no flag)
  TYX               ; setup indexes properly for self-hit
  BRA HalfSelf      ; flag half-turn self-hit
  NOP
warnpc $C21977

org $C21955
HalfSelf:
  JSL HalfTurn      ; reset ATB to 50%
  BRA SelfHit       ; execute self-hit
warnpc $C2195C

org $C21964
SelfHit:            ; load command data and hit self (Runic)


; ############################################
; Status/HP/MP update handling hooks

org $C24391
UpdateStatus:

org $C22675
AddImmunity:

org $C220D5
Interrupt:
  JSR Extra

; ############################################
; Rearranged initialize-battle-stat routine
; Extracts status and HP/MP subroutines for reuse
; Also makes room for helper "Extra" for equipment update

org $C227A8
BattleInit:         ; 93 bytes
  PHP
  REP #$30          ; Set 16-bit Accumulator & Index Registers
  STZ !unequip      ; zero needs-unequip byte
  LDY $3010,X       ; get offset to character info block
  LDA $1609,Y       ; get current HP
  STA $3BF4,X       ; HP
  LDA $160D,Y       ; get current MP
  STA $3C08,X       ; MP
  JSL NewMaxHP
  LDA $3018,X       ; Holds character bit mask
  BIT $B8           ; is this character a Colosseum combatant
  BEQ .status1      ; branch if neither
  LDA $3C1C,X       ; Max HP
  STA $3BF4,X       ; HP
  LDA $3C30,X       ; Max MP
  STA $3C08,X       ; MP
  LDA $1614,Y       ; outside battle statuses 1-2 (1 and 4)
  AND #$FF2D
  STA $1614,Y       ; remove Clear, Petrify, Death, Zombie
.status1
  LDA $1614,Y       ; outside battle statuses 1-2 (1 and 4)
  SEP #$20
  STA $3DD4,X       ; Status to set byte 1
  BIT #$08
  BEQ .status4      ; If not set M-Tek
  LDA #$1D
  STA $3F20         ; save MagiTek as default last command for Mimic
  LDA #$83
  STA $3F21         ; save Fire Beam as default last attack for Mimic
.status4
  XBA               ; outside battle status 2
  AND #$C0          ; only keep Dog Block and Float
  STA $3DE9,X       ; Status to set byte 4
  JSL SetStatus     ; add equipment statuses to set
  LDA $1608,Y
  STA $3B18,X       ; Level
  PLP 
  RTS 

Extra:              ; 47 bytes
  PHX               ; store X
  REP #$30          ; 16-bit A,X,Y
  LDY $3010,X       ; Y = offset to character block
  JSL NewMaxHP      ; update in-battle max HP/MP
  SEP #$20          ; 8-bit A
  LDA $3018,X       ; character's unique bit
  TRB !unequip      ; clear unequip flag
  BEQ .skip         ; skip to set status if wasn't set
  LDA $32F4,X       ; unequip item id (currently in reserve)
  JSR $2B63         ; multiply A (item id) by 30
  PHX               ; prepare X<->Y swap
  TAX               ; item data offset in X
  PLY               ; character index in Y
  JSL ClearStatus   ; clear unequip status, then set equip status
  TYX               ; character index back in X
.skip
  JSL SetStatus     ; set equip statuses
  SEP #$10          ; 8-bit X,Y
  PLX               ; restore X
  JSR UpdateStatus
  JMP AddImmunity

ItemLookup:         ; 4 bytes
  JSR $54DC         ; copy item data into $2E72-2E76 (long access)
  RTL

HPLookup:           ; 4 bytes
  JSR $283C         ; get max HP after equipment/relic boosts
  RTL

warnpc $C2283D
padbyte $FF
pad $C2283C
