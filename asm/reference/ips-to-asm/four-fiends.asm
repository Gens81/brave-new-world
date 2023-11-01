hirom

; Four Fiends (Song)
;
; Add support for playing the Four Fiends song from FFIV
; for designated formations. In BNW, this song is used
; for all WoR dragon battles.

; ########################################################################
; Song index table

org $C2BF41 : db $25 ; Add "four fiends" song index to song lookup

; ########################################################################
; Pointer and Instrument definitions for track $25 (FF4 - Four Fiends)

org $C53F05 : dl FourFiends
org $C54437 : dw $001C,$000D,$0016,$0012,$002F

; ########################################################################
; End of Battle Animation frame data (used as freespace)
; Binary for Four Fiends song

org $D4F646
FourFiends:
  incbin bin/four-fiends.bin

