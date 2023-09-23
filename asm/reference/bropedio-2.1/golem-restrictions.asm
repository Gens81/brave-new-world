hirom
; header

; Name: Golem Restrictions
; Author: Bropedio
; Date: July 20, 2020

; ###########################################
; Description
;
; Golem should not block attacks that deal
; no damage (only set status).
;
; The intended target's elemental properties
; should not affect the damage taken by Golem
;
; When Golem (or Doggy) blocks, the intended
; target's defenses should not apply: Row,
; Defend, Safe/Shell, Morph, Self-Dmg.

; ###########################################
; Golem Restrictions
;
; Skip Golem if no battle power, and remove
; element from attack if Golem blocks

org $C22296 : JSR GolemRestrict

org $C20AEF
GolemRestrict:
  ORA $3A37        ; check Golem's HP hibyte [moved]
  BEQ .exit        ; exit if no Golem
  LDA $11A6        ; battle power of attack
  BEQ .exit        ; exit without Golem if no damage
  STZ $11A1        ; remove elemental properties
.exit
  RTS
warnpc $C20B00

; ###########################################
; Rewrite entire target damage modification routine
; to address Golem issue and reduce code size.
;
; Note: The $11A7:80 flag is no longer used here
; to check for sap/regen -- use $B3:80 instead.

; Remove BNW dmg reduction helper
org $C250F4
padbyte $FF
pad $C25105

; Rewrite morph damage reduction routine
org $C2A65A
HandleMorph:
  LDA $3EF9,Y      ; status byte 4
  BIT #$08         ; "Morphed"
  BEQ .exit        ; branch if not ^
  LDA $3B40,Y      ; Stamina
  CMP #$60         ; > 96
  BCC .valid       ; branch if not ^
  LDA #$60         ; else, use max 96
.valid
  ASL $F0          ; double damage
  ROL $F1          ; double damage
  JSR InvertMulti  ; invert stamina and multiply
.exit
  RTS
warnpc $C2A675

; Shift/reorganize existing BNW variance routine
org $C2A770
Variance:
  LDA $11A4        ; attack flags
  LSR              ; carry: "Healing"
  BCS .vanilla     ; use vanilla variance for healing
  CPY #$08         ; monster range
  BCC .fancy       ; use vanilla variance for monsters
.vanilla
  JSR $4B5A        ; random(255)
  ORA #$E0         ; random(224-255)
  JMP MultiplyDmg  ; multiply E8 * Damage, then add 1
.fancy
  PHP              ; store flags
  LDA $11A2        ; attack flags
  LSR              ; carry: physical
  LDA $3B40,Y      ; load stamina
  BCC .magic       ; branch if "magical" damage
  LDA $3B2C,Y      ; load vigor
  LSR              ; divide by 2 (vigor is stored doubled)
.magic
  PHA              ; store stat (stam or vig/2) on stack
  LSR              ; / 2
  LSR              ; / 4
  STA $E8          ; E8 = stat/4
  LDA #$1E         ; A = 30
  SEC : SBC $E8    ; A = 30 - stat/4 (this is the variance range)
  BCC .store       ; if negative, immediately store this value as E8
  INC              ; exclusive range
  JSR $4B65        ; rand(0...max_variance)
.store
  STA $E8          ; E8 = random variance OR negative diff between hi and lo
  PLA              ; restore stat
  EOR #$FF         ; 255 - stat
  SEC : SBC $E8    ; A = (255 - stat) - random_variance
  STA $E8          ; if E8 is negative, A will equal the low bound           

  REP #$20         ; 16-bit A
  LDA $F0          ; damage
  JSR $47B7        ; E8 * damage
  LDA $E8          ; product low bytes
  PHX              ; store X
  LDX #$E1         ; 225
  JSR $4792        ; E8 * damage / 225
  STA $F0          ; update damage
  CLC              ; clear carry
  LDX $EA          ; product high byte
  BEQ .finish      ; branch if no overflow
.loop
  LDA #$0123       ; 0x10000 / 225 = 0x123
  ADC $F0          ; add to existing damage
  STA $F0          ; update damage
  DEX              ; decrement overflow
  BNE .loop        ; loop till all overflow gone
.finish
  INC $F0          ; dmg + 1
  PLX              ; restore X
  PLP              ; restore flags
  RTS
warnpc $C2A7D7

; Rewrite damage modification routine to save
; space. Large change is to reuse the X/256
; multiplication helper.
org $C20C9D
ExitTop:
  RTS
TargetDamageMod:
  REP #$20         ; 16-bit A
  LDA $11B0        ; maximum dmg
  STA $F0          ; set target dmg
  SEP #$20         ; 8-bit A,X/Y
  LDA $3414        ; "Modify Damage"
  BPL ExitTop      ; branch if no ^
  JSR Variance     ; apply damage variance

.golem_dog
  LDA $3A82        ; golem bits
  AND $3A83        ; dog bits
  ASL              ; carry: "No golem/dog"
  LDA $11A2        ; attack flags
  BIT #$20         ; check "Piercing"
  BCS .player      ; branch if not Golem/Dog
  BNE ExitTop      ; exit if Golem/Dog and Piercing
  LDA #$C0         ; else, use 192 defense
  JMP InvertMulti  ; exit after defense reduction

.player
  BNE .morph       ; branch if piercing
  LSR              ; carry: "physical" ($11A2 still in A)
  LDA $3BB9,Y      ; magic defense
  BCC .defense     ; branch if "magical"

.backrow
  LDA $3AA1,Y      ; target flags
  BIT #$20         ; "Backrow" flag
  BEQ .physical    ; branch if no ^
  LDA #$C0         ; 192 (75%)
  JSR MultiplyDmg  ; multiply 75% * Damage, then add 1
.physical
  LDA $3BB8,Y      ; else load physical defense

.defense
  JSR InvertMulti  ; (255-defense) * dmg / 256 + 1

.shields
  LDA $3EF8,Y      ; status byte 3
  BCS .safe        ; branch if "physical"
  ASL              ; shift byte 3 (safe->shell)
.safe
  ASL              ; shift safe/shell into N
  BPL .defending   ; branch if not safe/shell
  LDA #$AA         ; else, 66% multiplier
  JSR MultiplyDmg  ; multiply 66% * Damage, then add 1

.defending
  LDA $3AA1,Y      ; target flags
  BIT #$02         ; "Defending"
  BEQ .morph       ; branch if not ^
  LSR $F1          ; halve dmg
  ROR $F0          ; halve dmg

.morph
  JSR HandleMorph  ; get multiplier based on stamina

.periodic
  PHP              ; save 8-bit A on stack
  REP #$20         ; 16-bit A
  LDA $B2          ; attack bytes (looking at $B3)
  BPL .exit        ; exit if "Ignore Vanish" (sap/regen/poison)

.self-dmg
  LDA $11A4        ; attack flags
  LSR              ; carry: "Healing"
  LDA $F0          ; damage so far
  BCS .increment   ; branch if "Healing"
  CPY #$08         ; target is monster
  BCS .increment   ; branch if ^
  CPX #$08         ; attacker is monster
  BCS .increment   ; branch if ^
  LSR #2           ; dmg / 4

.increment
  JSR $370B        ; only exist via special effects at this point
  STA $F0          ; final modified damage

.exit
  PLP              ; restore 8-bit A
  RTS
warnpc $C20D3A
org $C20D39
InvertMulti:
  EOR #$FF         ; invert and set multiplier before 0D3D below
MultiplyDmg:
  STA $E8          ; set multiplier before to 0D3D below

