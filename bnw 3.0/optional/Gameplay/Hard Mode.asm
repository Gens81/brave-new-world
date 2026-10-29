hirom

; NHT - Speedy Enemies

org $C209D3 : LDY #$37 ; lower ATB multiplier when slowed
org $C209DC : LDY #$46 ; lower ATB multiplier when normal
org $C209E2 : LDY #$55 ; lower ATB multiplier when hasted
org $C209ED : ASL      ; double enemy multipliers

org $C25A9B
  ADC #$55             ; use constant for timed status/ticks
  NOP
