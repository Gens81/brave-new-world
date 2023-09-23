hirom
; header

; BNW - Petrify Heal
; Bropedio, August 4, 2020

; Description =================================
; Hitting a petrified target with the Remedy spell
; should both remove petrify status, and do healing,
; but a hardcoded petrify check automatically nulls
; all healing and damage. Fix so that damage/healing
; can be done if the petrify status will be lifted
; by the attack.

; Variables ===================================
!freespace = $C2514F
!freerange = $C25159

; Code ========================================
org $C20B9D : JSR PetrifyHelp

org !freespace
PetrifyHelp:
  LDA $3DFC,Y        ; status-to-clear 1
  EOR #$FF           ; status-to-not-clear 1
  AND $3EE4,Y        ; current-status-keep 1
  RTS
warnpc !freerange
