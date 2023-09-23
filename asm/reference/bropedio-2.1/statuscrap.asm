hirom
; header

; Status Crap - BNW 2.0.1
; Seibaby

; Issue =====================================
; Status relics remove the status when equipped,
; essentially replacing status removal items.

; Code ======================================
; Skip removing statuses when gear is equipped.
; Status will be removed at start of battle,
; instead.
org $C391CB : NOP #3 
