hirom
; header

; ########################################################################
; BNW - Green Cherry Rage Status Fix
; Bropedio

!rage_clr = 659D  ; 33 bytes, freespace
!clear_q = 462F   ; Address of existing clear-queue handler

org $C22917
ImmunityFix:
  STA $3330,X     ; clear correct immunities byte

org $C228C1
  STA $3C6C,X     ; revert to vanilla code here (status removal moved)

org $C2!clear_q
ClearQueue:       ; currently used by petrify and death set

org $C24710
  dw $!clear_q    ; clear queue on dance clear

org $C24720
  dw $!rage_clr

org $C2!rage_clr
Rage1:
  PHX             ; save X
  REP #$10        ; 16-bit XY
  LDA $33A8,Y     ; get monster #
  ASL
  ASL
  ASL
  ASL
  ASL             ; monster # * 32
  TAX             ; X = monster index
  LDA $CF001B,X   ; invert monster status bytes 1-2 
  TSB $F4         ; add to "status to clear"
  LDA $CF001D,X   ; monster status bytes 3-4
  PHA
  LSR
  TDC
  ROR
  ORA $01,S       ; move permanent float bit to byte4:bit7
  TSB $F6         ; add to "status to clear"
  JMP Rage2

org $C245E5
Rage2:
  PLA             ; clean up stack
  SEP #$10        ; 8-bit XY
  TYA
  LSR
  TAX             ; place character index in X
  INC $2F30,X     ; set flag to re-calculate character properties
  PLX             ; restore X
  BRA ClearQueue  ; set flag to clear pending attacks

