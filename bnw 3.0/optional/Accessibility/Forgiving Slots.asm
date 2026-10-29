arch 65816
hirom

; (Return a value based on our 3 slot results: 0 for 7-7-Bar, 7 when we don't
;  have three matching symbols [Lagomorph], or Symbol value + 1 when we have
;  a matching triplet)
;
; C2/B4A3: A5 36        LDA $36     (get slot 1 [aka reel 1] symbol)
; C2/B4A5: C5 37        CMP $37     (compare to slot 2 symbol)
; C2/B4A7: D0 06        BNE $B4AF   (branch if they don't match)
; C2/B4A9: C5 38        CMP $38     (if they do, compare to slot 3 symbol)
; C2/B4AB: D0 02        BNE $B4AF   (branch if that is different)
; C2/B4AD: 1A           INC         (if they're all the same, just return
;                                    the symbol value + 1)
; C2/B4AE: 6B           RTL
;
;
; C2/B4AF: 05 37        ORA $37
; C2/B4B1: D0 08        BNE $B4BB   (branch if either slot 1 or 2 isn't "7")
; C2/B4B3: A5 38        LDA $38     (only reach here if Slot 1 and 2 are both "7")
; C2/B4B5: C9 02        CMP #$02
; C2/B4B7: D0 02        BNE $B4BB   (branch if slot 3 isn't "Bar")
; C2/B4B9: 7B           TDC         (if it is, return 0)
; C2/B4BA: 6B           RTL
;
;
; C2/B4BB: A9 07        LDA #$07    (return 7 for Lagomorph?)
; C2/B4BD: 6B           RTL

org $c2b4a3
SlotHandler:
  LDA $36               ; load reel 1
  CMP $37               ; compare with reel 2
  BNE .gofish           ; Go Fish if they don't match
  CMP $38               ; compare with reel 3
  BEQ .reel1            ; return reel 1 result if all match
  JSR Rage              ; otherwise, get an RNG roll
  BCS .gofish           ; 1/3: Go Fish
.reel1
  LDA $36               ; load and return reel 1
  INC
  RTL
.gofish                 ; load and return Go Fish
  LDA #$07
  RTL

org $C23978
Rage:                   ; RNG: 2/3 chance carry clear
