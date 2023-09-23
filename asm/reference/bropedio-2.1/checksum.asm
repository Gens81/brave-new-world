hirom

; BNW - Checksum Fix
;
; Manually patch the correct checksum (and inverse checksum)
; for the master patch.

org $C0FFDE : dw $B8A8 ; checksum
org $C0FFDC : dw $4757 ; checksum complement
