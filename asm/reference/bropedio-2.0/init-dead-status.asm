hirom

; FF3 - Dead Character Permastatus Fix
; Bropedio (November 5, 2019)
;
; Setting "Death" or "Petrify" status will strip
; characters of other statuses. Typically, this
; happens mid-battle, so any permanent equipment
; statuses will be preserved due to the character
; having gained "immunity" to them. However, at
; battle start, characters don't yet have immunity,
; so if a character is dead to start, setting that
; status will strip them of their equipment statuses
; before immunity gets set.
;
; This patch inserts a two-phase approach to setting
; initial character statuses. First, all statuses
; except "Death" and "Petrify" are set. Then, the
; status immunity routine is run. Finally, the status
; routine is called once again, with any "Death" or
; "Petrify" statuses marked to be set.

; FF3 - Monster Entering Battlefield Status Fix
; Bropedio (November 5, 2019)
;
; When battle initializes, any enemy that is hidden
; or otherwise inactive will have its immunities set,
; but not its statuses. When the enemy enters the
; battle later (via scripting), it will be immune
; to any statuses that are meant to be innate (eg.
; Float, Safe, Shell).
;
; This patch adds special handling to apply any
; pending "status-to-set" when an entity enters
; the battlefield in this way, without respecting
; immunities. These bytes will have been set at
; battle initialization, but never processed until
; the enemy enters battle. The downside is that
; the statuses will not have their regular on-set
; routines called, so the following statuses are
; specifically omitted from being set in this way:
;
; Zombie, Muddle, Clear, Imp, Petrify, Death, Sleep
; Condemned, Morph, Stop, Reflect, Freeze

!free_1 = $C2656A
!warn_1 = $C2659E

!free_2 = $C2FB60
!warn_2 = $C2FB80

; ##########################################
; Delay setting death status at battle start

org $C224A4 : JSR DoubleStatusSet

; ##########################################
; Skip redundant immunity routine

org $C224B8 : NOP #3

; ##########################################
; Set pending statuses when entity enters battle

org $C21492 : JSR EnterBattleState

; ##########################################
; New routine sets initial status in phases

org !free_1
DoubleStatusSet:         ; 38 bytes
  LDY #$06               ; prepare character loop
.loop_1
  LDA $3DD4,Y            ; status-to-set 1
  PHA                    ; store it
  AND #$3F               ; omit Death/Zombie
  STA $3DD4,Y            ; update status-to-set 1 
  DEY #2                 ; point to next entity
  BPL .loop_1            ; loop through all 10
  JSR $4391              ; update statuses (phase 1)
  JSR $26C9              ; set status immunities
  LDY #$00               ; prepare reverse loop
.loop_2
  PLA                    ; get initial status-to-set 1
  AND #$C0               ; isolate Death/Zombie
  STA $3DD4,Y            ; update status-to-set 1
  INY #2                 ; point to next entity
  CPY #$08               ; past character range
  BCC .loop_2            ; process all 4 characters
  JMP $4391              ; update statuses (phase 2)
warnpc !warn_1

org !free_2
EnterBattleState:        ; 29 bytes
  PHP                    ; store flags (8-bit)
  REP #$20               ; 16-bit A
  LDA $3DE8,X            ; status-to-set 3-4
  AND #$F56F             ; remove problematic statuses
  ORA $3EF8,X            ; combine with status 3-4
  STA $3EF8,X            ; update status 3-4
  LDA $3DD4,X            ; status-to-set 1-2
  AND #$5E0D             ; remove problematic statuses
  ORA $3EE4,X            ; combine with status 1-2
  STA $3EE4,X            ; update status 1-2
  PLP                    ; restore flags (8-bit)
  RTS                    ; exit with status 1 in A
warnpc !warn_2


