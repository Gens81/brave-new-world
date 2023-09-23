hirom

; BNW - Hidon Always
; Bropedio (October 8, 2019)
;
; Upon speaking to Leeroy in Thamasa, Hidon will
; now reappear 100% of the time (rather than 12.5%).

; ###########################################
; Point all 50% branches to "Hidon Reappears"

org $CB73FE
  db $BD : dl $01740A
  db $BD : dl $01740A
  db $BD : dl $01740A
