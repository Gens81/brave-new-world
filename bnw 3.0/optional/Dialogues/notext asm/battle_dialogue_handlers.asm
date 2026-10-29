org DialogueEnd

; Relocation of code from Battle Event handler 01
;   (don't ask me what this all does)

Battle01:
  SEP #$10
  TDC
  TAX
  REP #$20
  LDA #$0100
  PHA
  PLD
- LDA $02,X
  STA $4D83,X
  LDA $06,X
  STA $4D87,X
  LDA $0A,X
  STA $4D8B,X
  LDA $0E,X
  STA $4D8F,X
  TXA
  CLC
  ADC #$0010
  TAX
  CPX #$C0
  BNE -
  LDA #$0000
  PHA
  PLD
  SEP #$20
  REP #$10
  RTL

EndBattle:
  db $FF

; Combat dialogue handlers - short circuit if text off

org $C196D6           ; Display message
  JSL Battle01        ; Moved out of bank to make space for the below
  JSR $022A
  RTS

TextEnabled:
  lda $00             ; Check config for text switch $1D4E
  bit #$20
  rts

BattleMsg:
  jsr TextEnabled
  bne .default        ; Display message if text enabled
  inc $8F             ; Increment event queue to skip dialogue pointer
  jmp $FF47           ; Treat dialogue event like a NOP
.default
  jmp $96C1           ; Call original handler

Open:
  jsr TextEnabled
  bne .default        ; Open dialogue box if text enabled
  jmp $FF47           ; Treat dialogue event like a NOP
.default
  jmp $4312           ; Call original handler

Close:
  jsr TextEnabled
  bne .default        ; Close dialogue box if text enabled
  jmp $FF47           ; Treat dialogue event like a NOP
.default
  jmp $96AD           ; Call original handler

  padbyte $FF
  pad $C1970C         ; Clear out the rest of this (former) subroutine


; Slice new handlers into jump table

org $C1FDC0
  dw BattleMsg

org $C1FDDE
  dw Close

org $C1FDE0
  dw Open
