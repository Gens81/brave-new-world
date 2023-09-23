hirom
; header

; Tank Defend Bonus - BNW 2.0.1
; Bropedio

; Description =======================================
; Apply on top of Tank+Spank patch to double chance
; of covering healthy allies when in "defend" mode.

; Variables =========================================

!freespace = $C0DA0A
!freerange = $C0DA18

; Code ==============================================

org $C212AB : JSL DefendBetter

org !freespace
DefendBetter:          ; [13 bytes]
  SEP #$20             ; 8-bit A
  LDA $3AA1,X          ; knight's special flags
  LSR #2               ; shift "defending" flag to carry
  LDA #$C0             ; 192 (cover threshold / 255)
  BCC .done            ; branch if not defending
  LSR                  ; 96 (lower cover threshold / 255)
.done
  RTL
warnpc !freerange
