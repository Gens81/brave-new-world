hirom
table table_c3.tbl,rtl
; header

; BNW Versioning

org $C338C9 : LDA #$28 ; yellow font
org $C33BB8 : dw $78D1 : db "  Brave New World 2.1.0",$00
org $C33BD7 : db $81,$9A ; correct first letter of "Battle Msg Speed" label
