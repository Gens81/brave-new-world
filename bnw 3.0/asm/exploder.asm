arch 65816
hirom

!explode_free = $C0D8E6 ; 9 bytes freespace out of bank

org $C2371A
  IncByY:

org $C23FFC
  TYX              ; copy attacker index (vanilla code)
  LDA #$10
  TSB $B0          ; use step-forward animation
  STZ $3414        ; fixed dmg
  REP #$20         ; 16-bit A
  LDA $A4          ; targets
  PHA              ; store
  LDA $3018,X      ; attacker bit
  STA $B8          ; set as temp target
  JSR $57C2        ; process animation
  JSR $63DB        ; process animation
  LDA $01,S        ; original targets
  STA $B8          ; set as temp targets
  JSR $57C2        ; process animation
  PLA              ; original targets
  JSL PrepExplode  
  NOP              ; erase displaced byte
  BCS .reg         ; skip increment if monster attacker
  JSR HelpExplode  ; modify damage if player attacker
.reg
  STA $11B0        ; save [modified] HP-based dmg
  JMP $35AD


org $C2A8D2
HelpExplode:      
  DEC A            ; reduce damage to CurrentHP - 1
  STA $33D0,X      ; assign reduced damage to Attacker damage taken
  INC A            ; increase damage back to CurrentHP
  LDY $11A6        ; use battle power as increment
  JSR IncByY       ; (IncByY routine) A = A + (A/2 * Y)
  RTS

org !explode_free
PrepExplode:
  LDA $3BF4,X      ; caster's current HP
  STA $33D0,X      ; assign damage to Attacker damage taken
  CPX #$08         ; if monster attacker, carry set
  RTL