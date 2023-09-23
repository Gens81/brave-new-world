hirom
; header

; Name: Rigged Colosseum
; Author: Bropedio
; Date: July 20, 2020
; 
; =================================================
; Requires
; Freespace cleared by `weapon-swap-stop.asm` patch
;
; =================================================
; Description
;
; Upon losing a colosseum battle, the wagered item should be
; returned to the players inventory. The vanilla implementation
; only incentivizes saving and resetting repeatedly.

; =================================================
; Variables

!freespace = $C23C04
!freerange = $C23C13

; =================================================
; Code

org $C24827 : JSR RiggedColosseum

org !freespace
RiggedColosseum:
  LDA $3A97         ; $FF if colosseum, $00 otherwise
  BEQ .rts          ; exit if not colosseum
  STA $0205         ; clear wager item (so not billed)
.rts
  RTS
warnpc !freerange

; =================================================
; EOF
