hirom

; BNW - Rich Man Hang
; Bropedio (October 10, 2019)
;
; Correct bug causing lag when entering the Rich Man's house
; in South Figaro (during Locke's scenario)

; Reduce song count back down
org $C53C5E : db $55

; Remove pointer overwriting "Silence" samples
org $C53F95 : db $00,$00,$00
