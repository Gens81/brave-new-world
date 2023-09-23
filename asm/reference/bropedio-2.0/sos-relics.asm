hirom
; header

; BNW - SOS Relics Reset
; Bropedio (July 29, 2019)
;
; On death, SOS Relics are recharged, so their effect can be
; reapplied when the character next enters "Near Fatal" status.

!free_start = $C2FAA4 ; 13 bytes
!free_warn =  $C2FAB2

org $C24603
  JSR SOSReset      ; jump from "Death - set" hook

org !free_start
SOSReset:           ; 13 bytes
  JSR $4598         ; relocate vanilla code (clear some statuses)
  LDA #$0002        ; "SOS status can activate" flag
  ORA $3205,Y       ; set it again
  STA $3205,Y       ; save updated flags
  RTS
warnpc !free_warn
