hirom

; BNW - Umaro Charge Row
; Bropedio (November 6, 2019)
;
; Add the "respect row" flag for Umaro's charge/tackle
; attack (for balance purposes).

!free = $C20557 ; 6 bytes freespace

org $C21684 : JSR UmaroRow

org !free
UmaroRow:
  TSB $11A2       ; set ignore defense (vanilla)
  TRB $B3         ; clear "ignore row" flag
  RTS
