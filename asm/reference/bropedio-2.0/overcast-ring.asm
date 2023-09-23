hirom
; header

; BNW - Overcast Ring
; Bropedio (July 26, 2019)
;
; To avoid the un-revivable state caused by dying while undead,
; give undead characters the Overcast flag as well, so death
; sets Zombie instead (if not immune).

!free = $C26626       ; 10 bytes

org !free
FullUndead:           ; 10 bytes
  STA $3C95,X         ; (vanilla code)
  BPL .skip           ; branch if not undead
  TXY                 ; JSR below indexes by Y
  JSR SetOvercast     ; else, set overcast bit
.skip
  RTS

org $C228D4
  JSR FullUndead

org $C23D1E
SetOvercast:

org $D869EC : db $65  ; remove "Zombie" immunity from Ghost Ring
