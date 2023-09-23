hirom
; header

; BNW - X-Fight Crits
; Bropedio
;
; This patch allows X-Fight to do critical hits

org $C229FE
EndWeapon:  RTS     ; skip offering check to set ignore crit

padbyte $FF         ; old offering and imp critical handling are
pad $C22A37         ; unused, so this space (56 bytes) is free.
