hirom
; header

; BNW - Quickfill (Seibaby)
; Bropedio (July 12, 2019)
;
; This patch implements Seibaby's quickfill patch,
; with one small change:
;
; Rather than checking for the "menu open" flag, we
; instead check for the characters' individual
; battle menu positions, which are updated as soon
; as ATB reaches 100%. This ensures that no additional
; quick-loops take place once any character's battle
; menu is ready to open.

!freespace = $EFFBC8

org $C2112C
BattleFrameLoop:
  CMP $0E         ; compare backup counter to frame count
  BEQ .exit       ; if already ran this frame, exit (this is a change)
  JSL EveryOther  ; determine if x2 speed
  BEQ .exit       ; if slower speed, exit every other frame
org $C21190
.exit

org !freespace
EveryOther:       ; 18 bytes
  XBA             ; save frame count in B
  LDX #$03        ; loop through all 4 characters
.loop
  LDA $4001,X     ; character's battle menu order
  INC             ; inactive menus are #$FF
  BNE .slower     ; if active, skip every other frame
  DEX             ; get next character index
  BPL .loop       ; loop until negative
  RTL             ; if none active, return without Z set
.slower
  XBA             ; get frame count again
  INC             ; advance one
  CMP $0E         ; compare to current frame
  RTL             ; if last loop was last frame, return Z set

