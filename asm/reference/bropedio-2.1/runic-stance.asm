hirom
; header

; Name: Runic Stance
; Author: Bropedio
; Date: July 20, 2020

; ############################################
; Description
;
; Celes should enter (and remain in) "Defend"
; stance while Runic is active.

; ############################################
; Variables

!freespace = $C145A6
!freerange = $C145B4
!freespace2 = $C1FFFA
!freerange2 = $C20001
!freespace3 = $C4F26A
!freerange3 = $C4F280

; ############################################
; Code

org $C1B78B : dw RunicPrep
org $C1B7BF : dw RunicAbsorb
org $C1AB8E : JSL StanceCheck

org !freespace
RunicAbsorb:
  JSR $BAB7      ; regular runic absorb animation
  JSR $BCA6      ; get first target index
  CMP #$04       ; is absorber a monster?
  JMP $AB92      ; reset sprite to default if not
warnpc !freerange

org !freespace2
RunicPrep:
  JSR $BAAA      ; regular runic prep animation 
  JMP $914D      ; set sprite to "ready"
warnpc !freerange2

org !freespace3
StanceCheck:     ; 21 bytes
  LDA ($78),Y    ; attacker index (vanilla code)
  ASL            ; index * 2
  TAY            ; index it
  LDA $3E4C,Y    ; runic byte
  LSR            ; shift $04 (runic) -> $02
  ORA $3AA1,Y    ; defend byte
  BIT #$02       ; is runic or defend set?
  SEC            ; default to abort
  BNE .abort     ; exit/abort if either set
  TYA            ; attacker index * 2
  LSR            ; restore index
  CMP #$04       ; in character range (abort if carry set)
.abort
  RTL
warnpc !freerange3

; ############################################
; EOF

