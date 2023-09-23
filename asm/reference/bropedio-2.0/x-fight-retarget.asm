hirom
; header

; BNW - X Fight Retarget if Target Dead
; Bropedio (August 11, 2019)
;
; In vanilla, the offering causes the Fight command to strike
; 4 times, randomized after the first. In BNW, X-Fight no longer
; randomizes, but the "don't retarget if targets are dead/invalid"
; flag is still set by default for every strike after the first.
;
; This patch resets that flag for X-Fight strikes.

!long_free = $C0D9D0     ; 27 bytes freespace

org $C231B6
  JSL HandleXFight

org !long_free
HandleXFight:            ; 27 bytes
  LDA #$20               ; "First strike of turn"
  TRB $B2                ; test and clear
  BNE .retarget          ; if set, exit without setting "no retarget"
  LDA $B5                ; command ID
  BNE .no_retarget       ; if not "Fight", set "no retarget"
  LDA #$01               ; odd bit set for right-hand swings
  BIT $3A70              ; # of hits remaining (after this one)
  BNE .retarget          ; if right-hand, skip setting "no retarget"
  LDA $3B68,X            ; right-hand battle power
  BNE .no_retarget       ; if nonzero, lefthand is dualwield, so no retarget
.retarget
  LDA #$20               ; prepare BIT check (and clear zero flag)
  RTL
.no_retarget
  TDC                    ; set zero flag
  RTL
