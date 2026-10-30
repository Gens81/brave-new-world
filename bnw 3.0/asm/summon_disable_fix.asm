arch 65816
hirom

!summonFree = $D4CFC3

; HACK DESCRIPTION:
;   Wait until action actually executes to flag a Summon as spent
;   (specifically, the moment when caster MP is decremented)

org $C232E0 ; update caster MP when casting
  JSL SummonDisableHelper
  NOP
  NOP

org $C24DA0 ; location where summons get unflagged when queueing the action
  NOP
  NOP
  NOP
  NOP
  NOP
  NOP

org !summonFree
SummonDisableHelper:
    STA $3C08,X          ; (displaced) attacker MP = attacker MP - spell MP cost
    CPY #$08
    BCS ++               ; exit if caster is a monster
    SEP #$20             ; 8-bit A
    LDA $B5
    CMP #$19             ; command = Summon?
    BNE +                ; exit if not
    LDA $3018,Y
    TSB $3F2E            ; make character ineligible to use Esper again this battle
  + REP #$20             ; 16-bit A
 ++ LDA #$0080           ; (displaced)
    RTL
