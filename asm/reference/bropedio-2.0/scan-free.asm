hirom
; header

; BNW - Free Scan
; Bropedio (July 11, 2019)
;
; Make Scan a free action, but only for characters.

org $C23C5B
  LDA $05,S     ; attacker index
  TAX           ; place in X
  CPX #$08      ; monster range
  BCS .done     ; skip free turn if monster
  JSR $3CB8     ; use steal subroutine to set ATB refill flag 
.done
  STZ $341A     ; prevent counterattack
  TYX           ; put target index in X
  LDA #$27      ; scan command id
  JMP $4E91     ; queue scan command in global action queue
warnpc $C23C6F
