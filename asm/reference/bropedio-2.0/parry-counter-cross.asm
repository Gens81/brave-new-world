hirom

; BNW - Parry & Counter & North Cross
; Bropedio (October 3, 2019)
;
; The parry & counter patch was accidentally wiped
; by the patch to prevent dmg increments when
; hitting targets in the back. Additionally, the new
; North Cross effect requires a JSL somewhere in the
; same code area. I've combined the two here, to make
; use of the freespace from the hitting-back removal.
;
; REQUIRES: Hitting-back removal
; REQUIRES "inform-miss-3" (for !fail bytes)
; INCLUDES: N.Cross Redux
; INCLUDES: Part of parry-counter patch
;
; North Cross Redux
;
; Changes the behavior of N.Cross so that the order
; of targeting is:
;
; 1. All possible targets are selected
; 2. Targets have chance to evade via stamina
; 3. Of remaining targets, only 1-2 are hit
;
; Frees 11 bytes ($C2661B)

!parry_counter = $C25E37
!ncross_long = $C0D940     ; 36 bytes
!miss = $3A5A              ; miss msg bitmask
!fail = $3A5C              ; fail msg bitmask

; #################################################
; Clear once-per-strike N.Cross hook

org $C24333 : dw $3E8A   ; RTS per-strike hook

; #################################################
; Add long helper and clear remaining N.Cross code

org $C2414D
PostCheckHelp:           ; replace 11 bytes
  JSR $522A              ; pick a random target
  STA $E8                ; save for now
  LDA $A4                ; remaining targets
  JSR $522A              ; pick another target
  RTL
warnpc $C24159

org $C2661B
padbyte $FF
pad $C26626              ; clear 11 bytes

; ##############################################
; North Cross target filtering
; (runs immediately before status phase)

org !ncross_long
NorthCrossMiss:          ; 36 bytes
  PHP
  LDA $11A9              ; special effect
  CMP #$52               ; "N.Cross" special index
  BNE .exit              ; exit if not "N.Cross"
  REP #$20               ; 16-bit A
  LDA !miss              ; get "missed" targets
  STA !fail              ; use "failed" message
  LDA $A4                ; remaining targets
  TSB !miss              ; set all as missed
  PHX                    ; store X
  JSL PostCheckHelp      ; will change X
  PLX                    ; restore X
  ORA $E8                ; combine both targets
  STA $A4                ; set as new targets
  TRB !miss              ; remove from "missed" targets
.exit
  PLP
  RTL

; ###############################################
; Shift vanilla code before status evasion check
; to make room for Parry/Counter and N.Cross helpers

org $C2343C
ParryCounterCross:
  JSL NorthCrossMiss
  JSR ParryCounter
  REP #$20
  LDY #$12
.loop
  LDA $3018,Y
  TRB $A4
  BEQ .next
warnpc $C2344F
org $C2346C
.next
  DEY
  DEY
  BPL .loop

; ########################################
; Shorten existing Parry/Counter helper

org !parry_counter
ParryCounter:
  LDY $C0
  LDA $3018,Y
  BIT $3A5A
  BEQ .exit
  JSR $35E3
.exit
  RTS
