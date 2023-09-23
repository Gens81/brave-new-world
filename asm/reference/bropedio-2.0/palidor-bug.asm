hirom
; header

; BNW - Palidor Bugfix
; Bropedio (July 20, 2019)
;
; The beginning of Palidor's once-per-strike special
; effect seems to have been overwritten by some other
; code.
;
; Uses freespace created by the "esper-level-simplify" patch
; Frees old Imp handling space: $C241E6-$C241F6

!free_c2 = $C261A8 ; 22 bytes

org $C233A3
  JSR ImpDamage

org !free_c2
ImpDamage:          ; 22 bytes
  LDA $B5           ; command id
  CMP #$01          ; is command "Item"
  BEQ .skip         ; exit if so
  LDA $3EE4,X       ; status byte 1
  BIT #$20          ; "imp"
  BEQ .skip         ; exit if not imped
  LSR $11B1         ; half damage (high byte)
  ROR $11B0         ; half damage (low byte)
.skip
  JMP $14AD         ; continue to hitting back check

org $C241F6
PalidorSpecial:     ; restore vanilla code
  LDA #$10
  TSB $3A46         ; set "Palidor summoned this turn"
  REP #$20          ; 16-bit A
