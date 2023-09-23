hirom

; BNW - Checksum Fix
; Bropedio (December 31, 2019)
;
; Manually patch the correct checksum (and inverse checksum)
; for the master patch.

org $C0FFDC : dw $8D1D ; checksum complement
org $C0FFDE : dw $72E2 ; checksum
