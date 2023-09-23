hirom

; Level Cap Patch (for Gen)
; Bropedio

org $C26073 : CMP #$1E ; Max out level at 30
org $C2A6E0 : CMP #$14 ; Max out EL at 20
