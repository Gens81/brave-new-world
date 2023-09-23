hirom
; header

; BNW - Double GP
; Bropedio (July 20, 2019)
;
; When experience gains are toggled off, award players
; with twice the amount of GP they would otherwise receive.

org $C25E10
DoubleGP:
  LDA $1D4D           ; config byte
  BIT #$08            ; "gain exp" flag
  BNE .skip           ; branch if experience on
  ASL $2F3E           ; else, double GP reward
  ROL $2F3F
  ROL $2F40
.skip
  LDY #$0006          ; shifted vanilla code below
.loop
  LDA $3018,Y
  BIT $3A74
  BEQ .next
  BRA .continue

org $C25E49
.continue

org $C25E73
.next

org $C25E75
  BPL .loop
