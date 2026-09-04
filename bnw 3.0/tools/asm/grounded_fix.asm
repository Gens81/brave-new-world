arch 65816
hirom

; C2/44AD: A9 10 00     LDA #$10
; C2/44B0: 24 F8        BIT $F8
; C2/44B2: F0 07        BEQ $44BB   (branch if target not vanished)
; C2/44B4: 2C AA 11     BIT $11AA
; C2/44B7: D0 02        BNE $44BB   (branch if attack causes Clear)
; C2/44B9: 04 F4        TSB $F4     (mark Clear status to be cleared)

org $C244B7
  JSR VanishFloat
  NOP

org $C2FC3F      ; once per strike handler for effect $25 (Quake)
  LDA #$08       ; unused flag; now: "Ignores Floating"
  TRB $B3
  RTS

VanishFloat:
; If we're in here, we've already confirmed the attack is nonphysical and the
; target has Vanish status. Now we just need to check if the the enemy is floating
; and if it's a grounded attack, and if so, skip the part where Vanish is wiped
; from the target.

  BNE .skip      ; displaced from calling location - skip routine if attack inflicts Vanish
  LDA #$0008
  BIT $B3        ; test "Ignores Floating" flag
  BEQ .skip      ; if set, preserve Vanish
.proceed
  LDA #$0010
  TSB $F4        ; otherwise, mark vanish status to be removed
.skip
  RTS

padbyte $FF
pad $C2FC6B    ; reclaim remaining code from Seibaby's "Quake untargets floating enemies" hack as freespace
