hirom
; header

; Bropedio

; Description
; Cover allies on correct side, based on attacker
; facing direction, rather than intended target

org $C1BD8B : JSR DetermineRight : BCS $05

org $C18FDA
DetermineRight:
  PHY            ; save offset to character target
  JSR $BC89      ; set attacker in $10
  LDA $10        ; attacker index
  BPL .character ; branch if character
  ASL            ; double monster index, remove monster flag (set carry)
  SBC #$08       ; get monster index 0-10
  TAY            ; index it
  LDA $80F3,Y    ; flipped due to formation
  EOR $617E,Y    ; toggle with muddle/control flipped
  INC            ; toggle lowest bit "Horizontal Flip"
  BRA .done
.character
  TAY            ; character index
  LDA $7B10,Y    ; character facing right (bit 0)
.done
  LSR            ; carry: Facing right
  PLY            ; restore offset to character target
  RTS
warnpc $C19103

; #########################
; Fix sprite priority after cover

org $C1C225 : BEQ $05
org $C1C22A : NOP #2
