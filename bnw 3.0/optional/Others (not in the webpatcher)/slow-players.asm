;For Brave New World

;concept: Nowea
;coding: Seibaby
; Altered for NHTx3 by Synchysi
; Updated for BNW 2.1 by Sir Newton Fig

;Original formula: (ATB multiplier) * 1.5 * (Speed + 20) / 16
;New enemy formula: (ATB multiplier) * 3 * (Speed + 20) / 16
;New player formula: (ATB multiplier) * (Speed + 51) / 24

;xkas 0.06
hirom         ;don't change this
;header       ;uncomment if headered ROM

!free = $C28A60

;ATB multipliers
!slow = 55
!normal = 70
!haste = 85
;Universal Speed bonus
!bonus = 51

org $C209D2
atb:
  ;Set ATB multipliers
  PHP
  LDY.b #!slow    ;ATB multiplier = 60 if slowed
  LDA $3EF8,X
  BIT #$04
  BNE .skip       ;Branch if Slow
  LDY.b #!normal  ;ATB multiplier = 75 normally
  BIT #$08
  BEQ .skip       ;Branch if not Haste
  LDY.b #!haste   ;ATB multiplier = 90 if hasted
  .skip
  TYA 
  STA $3ADD,X     ;save the ATB multiplier
  PHX
  PHY
  PHA

  ;Check if monster or character
  CPX #$08
  BCC .character

  ;For monsters: Multiply ATB multiplier by 3
  LSR
  CLC
  ADC $01,S
  STA $01,S
  ;For monsters: add 20 Speed 
  LDA #$14
  CLC
  LDY #$10
  BRA .addSpeed

  .character
  LDA #!bonus     ;Universal Speed bonus
  LDY #$18

  ;Add 51 to Speed
  .addSpeed
  ADC $3B19,X     ;Speed
  XBA             ;Speed + Bonus in top byte of Accumulator

  ;Multiply by Slow/Normal/Haste constant
  PLA             ;bottom byte of A is now Slow/Normal/Haste Constant
  JSR $4781       ;Let C be the Slow/Normal/Haste constant, equal to
                 ; 60, 75, or 90, respectively.
                 ; for characters and enemies:
                 ; A = (Speed + 51) * C
  JMP SpeedCalcContinued

org !free
SpeedCalcContinued:
  TYX				; Y = divisor for speed calculation
  JSR $4792		; Divide by 16 if an enemy, 24 if a player
  PLY
  PLX
  REP #$20
  STA $3AC8,X     ;Save as amount by which to increase ATB timer.
  PLP 
  RTS
  print bytes

org $C25A9B
  ADC #$55
  NOP
