hirom

; BNW - Morph Tier Fix
; Bropedio (October 8, 2019)
;
; It appears that a piece of the morph reversion code
; that was removed with the morth gauge/counter has
; caused unusual behavior when a previously morphed
; Terra moves between tiers of the final battle.

!unused_morph_timer_routine = $C2121E
!morph_timer_routine_end = $C2123C

org $C20AE3 : JMP ToggleMorphByte

org !unused_morph_timer_routine
ToggleMorphByte:
  PLP              ; restore carry flag (if just reverted)
  PLX              ; restore actor's index
  TXA              ; copy index into A
  BCC .morphed     ; branch if just morphed
  LDA #$FF         ; null
.morphed
  STA $3EE2        ; set morphed actor to null or X
  RTS
warnpc !morph_timer_routine_end

