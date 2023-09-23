hirom
; header

; BNW - Fix for Formation Pack Selection
; Bropedio (July 6, 2019)
;
; This would be best fixed via Seibaby's 10-step encounter
; patch, but I'm including it here for completion.
;
; The bug was that this particular random number code is
; not used for encounter rate; it is used for formation
; pack selection. Since the 10-step patch code was added
; here, the formation rates were wrong, particularly for
; the rarest formations.

org $C0C4A9          ; revert to vanilla
  JSL $C0FD00
  CLC
  ADC $1FA3
