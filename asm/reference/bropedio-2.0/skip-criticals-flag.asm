hirom
; header

; BNW - No Critical Flag
; Bropedio (July 16, 2019)
;
; Built on top of another damage multiplier patch
; Also requires the removal of Imp Critical functionality
; Also, fix Morph increasing item effectiveness

; ####################################
; Check flags to skip critical hits

org $C233E5       ; overwrites unused Imp Critical code
SkipCrit:
  LDA $11A7       ; special flags 4
  BIT #$20        ; "never critical"
  BNE .none       ; if ^, skip critical handling
padbyte $EA
pad $C233F2
warnpc $C233F3

org $C23414
.none

; ####################################
; Replace/Shorten Multipliers Handling
; Pull apart increment routine for reuse below

org $C2370B
Multipliers:
  PHY
  LDY $3414       ; allow dmg modification
  BEQ .end        ; exit if not allowed
  LDY $BC
  JSR IncByY
  STY $BC
.end
  PLY
  RTS

IncByY:
  BEQ .exit
  STA $EE
  LSR $EE
.loop
  CLC
  ADC $EE
  BCC .next
  TDC             ; clear damage
  DEC             ; maximum damage
.next
  DEY
  BNE .loop
.exit
  RTS

padbyte $FF
pad $C23733

; ###################################
; Exploder patch adjustment
; The entire hook is shifted to remove the now-unnecessary STZ $BC
; This creates just enough space to fix the current patch in line

org $C23FFC
  TYX              ; copy attacker index (vanilla code)
  LDA #$10
  TSB $B0          ; use step-forward animation
  STZ $3414        ; fixed dmg
  REP #$20         ; 16-bit A
  LDA $A4          ; targets
  PHA              ; store
  LDA $3018,X      ; attacker bit
  STA $B8          ; set as temp target
  JSR $57C2        ; process animation
  JSR $63DB        ; process animation
  LDA $01,S        ; original targets
  STA $B8          ; set as temp targets
  JSR $57C2        ; process animation
  PLA              ; original targets
  ORA $3018,X      ; add caster
  STA $A4          ; update targets
  LDA $3BF4,X      ; caster's current HP
  CPX #$08         ; if monster attacker, carry set
  JSR HelpExplode  ; increment dmg before saving
  JMP $35AD

org $C2A8D2
HelpExplode:
  BCS .reg         ; skip increment if monster attacker
  LDY $11A6        ; use battle power as increment
  JSR IncByY       ; A = A + (A/2 * Y)
.reg
  STA $11B0        ; save [modified] HP-based dmg
  RTS
