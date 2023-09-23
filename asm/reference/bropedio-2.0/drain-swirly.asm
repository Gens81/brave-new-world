hirom
; header

; BNW - Fix Drain Swirly
; Bropedio (August 23, 2019)
;
; When a new black magic spell (Dark) was added, the
; range of black magic spells got slightly larger.
; This range is hard-coded in the animation bank to
; indicate which pre-magic swirly animation is played.

org $C1ABA6 : CMP #$19 ; increase black magic range by 1
