hirom
; header

; BNW - Gau Stepping
; Bropedio (July 7, 2019)
;
; Fixes bug causing Gau to step forward for some attacks,
; but never step back (if all targets are missed). The
; bug seems to be caused by a mis-attribution of the
; attack animations as "Magitech" commands. The fix
; changes the specified Magitech range end point used by
; the $C21DBF subroutine.

org $C21DE0 : db $84 ; Start Lore/EnemyAttack range with spell ID 84 (Exploder)
