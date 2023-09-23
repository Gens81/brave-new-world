hirom
; header

; BNW - Phantom Toggles Vanish (Fix)
; Bropedio (July 9, 2019)
;
; The bug appears to be caused by whatever patch repurposed
; the "Lvl?" flag on $11A4 ($40). One check for that flag
; was left over in the hit determination routine, causing
; "Vanish" to be added to "statuses to clear" whenever the
; bit is set.

org $C22232 : NOP #2 ; remove branch op for Lvl? flag
