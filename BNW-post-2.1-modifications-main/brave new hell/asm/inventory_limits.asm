hirom
; header

; Cap max items at 20, rather than 99
; Bropedio

; #################################################
; Change all checks for 99 to checks for 20

org $C39D8D : CMP #$14
org $C3B836 : LDA #$14
org $C3B840 : CMP #$14
org $C1448B : CMP #$14
org $C1448F : LDA #$14
org $C0A024 : CMP #$14
org $C0AD25 : CMP #$14

; Code that has been overwritten, or never runs
; org $C18BE4 : CMP #$14
; org $C18C99 : CMP #$14
; org $C19035 : CMP #$14
; org $C190FC : CMP #$14