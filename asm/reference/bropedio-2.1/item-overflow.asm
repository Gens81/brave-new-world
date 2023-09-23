hirom

; Fix Item Buffer Overflow
; Was causing some items to get eaten up when Weapon Swapping too
; many times in a row.

org $C112D5 : CPX #$0050 ; wipe entire "pending item transfer" buffer
