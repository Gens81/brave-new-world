hirom

; This assembly file "reserves" freespace for important alt patches by padding
; them with an unconventional padding byte

padbyte $EE

;idle time reducer

org $C0DAF9 : pad $C0DB01 ; 8 bytes

; notext_noswitch

org $C0FF18 : pad $C0FF8E ; 118 bytes

; choreography

org $C23AC5 : pad $C23AEE ; 41 bytes

; new_game_plus (Bropedio's randomizer)

org $C3F612 : pad $C3F646 ; 52 bytes
