hirom
!free = $C23C82

org $C20C19
  JSL ElementalWeakHelper

org !free
ElementalWeakHelper:
  REP #$20         ; 16-bit A
  LDA $F0          ; load damage
  LSR              ; half damage
  CLC
  ADC $F0          ; damage = 1.5x
  STA $F0
  SEP #$20         ; 8-bit A
  RTL