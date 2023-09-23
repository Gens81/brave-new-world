hirom
; header

; BNW - Shock display
; Bropedio (July 11, 2019)
;
; Show damage numbers when Shock causes self-damage
; Rather than directly modifying attacker's HP, instead
; add damage value to the attacker's "Damage Taken" bytes.
; Then allow the regular damage handling process both the
; damage reduction, death (if necessary) and visual dmg numbers.

org $C23EFE
  STA $33D0,Y       ; store in damage taken for target
  LDA $3AA1,Y       ; get attacker flags
  BIT #$0020        ; "back row"
  BEQ .exit         ; exit if not ^
  LSR $11B0         ; else, halve damage
.exit
  RTS

warnpc $C23F10
padbyte $FF : pad $C23F0F
