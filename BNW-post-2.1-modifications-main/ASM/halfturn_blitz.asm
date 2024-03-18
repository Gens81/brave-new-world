arch 65816
hirom

!free = $EFFBDA ; point this at a big chunk

; patches utilizing consecutive freespace:

!HalfTurnBlitz_freespace = !free

; next = HalfTurnBlitzFailure_EOF

warnpc $EFFC00

org $C215A5
  JSL BlitzSlice
  NOP

org !HalfTurnBlitz_freespace
BlitzSlice:
  LDA #$43
  STA $3401         ; Set to display text "Incorrect Blitz input!"
  JSR HalfATBY      ; set ATB to 50%
  RTL

; A wrapper for $C1/8A0E for when you have character index
; loaded in Y instead of X. This is used in a few other
; patches as well.

HalfATBY:
  PHX
  TYX
  JSL $C18A0E         ; set ATB to 50%
  PLX
  RTS

HalfATBBlitz_EOF:

; Half turn stumble

org $C217BD
    JSL StumbleHook

org HalfATBBlitz_EOF
StumbleHook:
    JSL $C18A0E     ; set ATB to 50%
    LDA #$20        ; [displaced]
    STA $B5         ; [displaced]
    RTL
HalfATBStumble_EOF:
warnpc $EFFC00

