hirom
; header

; Fix BNW Angle Bug
; Bropedio

; The implementation of assassin's Alphabetical Rage patch
; places a subroutine in C2 on top of angle data

!free4bytes = $C22A33

org $C2FCCD : dw $7641,$776B ; fix vanilla data

org !free4bytes
LongByteDivision:
  JSR $5217
  RTL

org $C353D2 : JSL LongByteDivision
