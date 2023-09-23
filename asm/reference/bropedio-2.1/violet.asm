hirom
; header

; Name: Violet
; Author: Bropedio
; Date: August 1, 2020

; Description =======================================
; Change Cyan's child's sprite from male to female,
; so "Hunter" can become "Violet"

; Code ==============================================

; Violet Dies (assumes "Dead Boy" sprite converted to "Dead Girl"
org $CB12C8 : db $2D,$83 ; When pulling Violet from bed, switch to "dead" earlier
; org $C4329F : db $03 ; Make Violet face up in bed, at first

; Violet boards Phantom Train
org $C4348C : db $27 ; Replace boy sprite with girl

; Cyan's Dream
org $C432A6 : db $27 ; Replace boy sprite with girl
org $C432B8 : db $27 ; Replace boy sprite with girl
org $C432EE : db $27 ; Replace boy sprite with girl
org $C43312 : db $27 ; Replace boy sprite with girl
org $C43336 : db $27 ; Replace boy sprite with girl
