hirom
; header

; BNW - EP Gain Display Bug
; Bropedio (September 9, 2019)
;
; This fixes a bug in the EP system. It would be better to make the
; bugfix to the original patch by inserting the `BIT #$0008` immediately
; after the `LDA $F1`.
;
; REQUIRES: parry-counter-cross.asm

!free = $C2661B   ; 9 bytes 

org $C2A715
  STZ $E8
  LDA $F1
  JSR FixItUp

org !free
FixItUp:          ; 9 bytes
  BIT #$0008
  BEQ .exit
  JMP $A674
.exit
  RTS
