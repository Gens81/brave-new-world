hirom
; header

; BNW - Jump Better
; Bropedio (September 7, 2019)
;
; Re-enable special effects when jumping
; Always jump with right hand if present
; REQUIRES: "mug-better" (special effect limitations)

org $C21805
  CLC             ; point to right hand
  NOP #2

org $C2180B
  JSL $C3F726     ; skip [STZ $11A9] in long helper
