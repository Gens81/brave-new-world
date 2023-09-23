hirom
; header

; Enemy Special Status Attack Bugfix
; Bropedio
;
; This patch corrects a bug that was incorrectly giving
; some enemy specials the "Miss if Protected Against
; Instant Death" flag. Specifically, the bug causes
; enemy specials that set sleep to miss death-immune targets.

org $C26761
SpecialStatus: STA $11AA,X    ; store updated status byte
               BPL .finish    ; if possible death bit not set, branch
               JSR DeathMiss  ; else, set death miss flag
.finish        LDA #$10
               TSB $11A4      ; use stamina in evasion formula
               RTS
db $FF
warnpc $C26771


org $C261E9
DeathMiss:     TXA            ; A = status byte index
               BNE .end       ; death status is on status byte 0
               LDA #$02
               TSB $11A2      ; set "miss if protected against death" flag
.end           RTS
warnpc $C261F3
