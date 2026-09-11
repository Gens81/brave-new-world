arch 65816
hirom

org $C244B7
  JSR VanishFloat
  NOP

org $C2FC3F      ; once per strike handler for effect $25 (Quake)
  LDA #$08       ; unused flag; now: "Ignores Floating"
  TRB $B3
  RTS

VanishFloat:
; If we're in here, we've already confirmed the attack is nonphysical and the
; target has Vanish status. Now we just need to check if the the target is floating
; and if it's a grounded attack, and if so, skip the part where Vanish is wiped
; from the target.

  BNE .skip      ; displaced from calling location - skip routine if attack inflicts Vanish
  LDA $3EF8,Y    ; check if target is floating
  BPL .proceed   ; clear vanish if not
  LDA #$0008
  BIT $B3        ; test "Ignores Floating" flag
  BEQ .skip      ; if set, preserve Vanish
.proceed
  LDA #$0010
  TSB $F4        ; otherwise, mark vanish status to be removed
.skip
  RTS

print pc

padbyte $FF
pad $C2FC6B    ; reclaim remaining code from Seibaby's "Quake untargets floating enemies" hack as freespace
