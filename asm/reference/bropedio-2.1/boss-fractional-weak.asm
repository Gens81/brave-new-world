hirom

; Allow fractional damage to hurt bosses a little
; Bropedio

!free = $C250F4
!stop = $C25105

; Redirect fractional routine to new location
org $C23E2D : dw Fractional

; Clear old fractional routine
padbyte $FF : org $C23C6E : pad $C23C75

org !free
Fractional:
  LDA $3C80,Y     ; monster bits
  BIT #$04        ; "boss" flag
  BEQ .exit       ; exit if no boss flag
  LDA #$80        ; "fractional dmg"
  TRB $11A4       ; remove from spell flags
.exit
  RTS
warnpc !stop+1
