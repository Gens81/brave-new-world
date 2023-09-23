hirom
; header

; BNW - Spell Damage Respect Row
; Bropedio

org $C23392
HandleRowFlags:
  JSR GetRowFlag  ; if respect row, #10 will be set in A
  ASL             ; move respect row flag to #20
  AND #$20        ; if respect row, A = #20, else, A = #00

org $C26522
  JMP $2BDA       ; physical dmg formula skips row check for now

GetRowFlag:
  LDA $B3
  EOR #$FF        ; flip bits, so #20 goes from "ignore row" to "respect row"
  LSR             ; move "respect row" bit to #10
  ORA $11A7       ; combine with 11A7's "respect row" bit
  RTS

padbyte $FF
pad $C2653A
