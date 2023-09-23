hirom

; Fair Spinning
; Bropedio
;
; This patch prevents pause buffering during Setzers slot
; machine selection

!freespace = $C18EFE ; Equipswap code that never runs
!freerange = $C18F0C

; ##############################################
; New Code (C1 Helpers)

org !freespace
CloseSlotsHelp:
  STA $7BC4     ; vanilla code (moved)
  STZ $EC0F     ; enable pausing (after slot machine)
  RTS
OpenSlotsHelp:
  INC $EC0F     ; disable pausing (during slot machine)
  JMP $5A4A     ; vanilla code (moved)
warnpc !freerange

; ##############################################
; When Opening Slots, Disable Pausing

org $C15618 : JMP OpenSlotsHelp

; ##############################################
; When Closing Slots, Re-enable Pausing

org $C156B1 : JSR CloseSlotsHelp
