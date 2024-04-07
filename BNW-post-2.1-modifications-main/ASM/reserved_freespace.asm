hirom

; This assembly file "reserves" freespace by padding them with an
; unconventional padding byte

padbyte $EE

; -----------------------------------------------------------------------------
; Core
; -----------------------------------------------------------------------------

; summon descriptions
org $CB52FC : pad $CB5790 ; 1172 bytes

; animal descriptions (secondary screen)
org $D8EE47 : pad $D8F000 ; 441 bytes

; custom event scripting
org $ED8BFC : pad $ED8E5B ; 607 bytes

; -----------------------------------------------------------------------------
; Alt Patches
; -----------------------------------------------------------------------------

; abridged_beta
org $C0DAF9 : pad $C0DB01 ; 8 bytes

; notext_noswitch
org $C0FF18 : pad $C0FF8E ; 118 bytes

; choreography
org $C23AC5 : pad $C23AEE ; 41 bytes

; new_game_plus (Bropedio's randomizer)
org $C3F612 : pad $C3F646 ; 52 bytes
