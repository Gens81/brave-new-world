org EndBattle

; Display custom dialogue box: Got the magicite "X" where X is the
;   name of the Esper granted.
;
; Intended for use with randomizers, where you otherwise won't know
;   which Esper you've received until looking at your menu.

Action86:
  jsr CheckConfig     ; Defined in field_dialogue_handlers.asm
  bne .default        ; Skip special handler if patch disabled
  rep #$20
  lda #EsperMessage   ; Pointer to message
  sta $C9             ; Store pointer
  sep #$20
  tdc
  lda #$C0            ; Bank for message
  sta $CB             ; Store bank
  lda #$01
  sta $0568           ; Text is ready to go
  lda #$01
  sta $BC             ; Text at the top
  sta $BA             ; Open dialogue box
  lda $EB             ; Event code esper index
  sec
  sbc #$36            ; Actual esper ID
  sta $40             ; Store the Esper ID for later retrieval
  jsr $ADBD           ; Call regular add Esper handler (now a subroutine)
  lda #$01            ;
  sta $EB             ; Prepare a "wait for dialogue" event on the stack
  lda #$00            ;   ...
  sta $EC             ;   ...
  sta $ED             ;   ...
  lda #$02            ;   Advance event queue 2 bytes
  jmp $B1A3           ;   Queue it
.default
  jsr $ADB8           ; Call the regular Action 86 handler from the start
  lda #$02
  jmp $9B5C           ; Advance event queue 2 bytes

EsperMessage:         ; \n\t{4}Got the magicite "<esper>"
  db $01,$14,$04,$26,$48,$84,$83,$80,$D4,$40,$42,$3C,$A5,$80,$73,$1B,$62

EndEsper:
  db $00

org $C0840F           ; Former control code for "spell learned"
EsperControlCode:
  php
  sep #$30
  cmp #$1B
  bne $844B
  lda $40             ; Index of Esper to add
  rep 3 : asl A       ; x8, names are 8 chars long
  tax
  ldy #$00
  lda #$7E
  pha
  plb
.next_char
  lda $E6F6E1,X       ; Esper name
  sec
  sbc #$60
  sta $9183,Y
  cmp #$9F            ; Did we reach an $FF?
  beq .eos
  inx                 ; character pointer ++
  iny                 ; character counter ++
  cpy #$08            ; have we read 8 characters yet?
  bne .next_char      ; read the next one if not
.eos
  tdc
  sta $9183,Y         ; store an EOS
  tdc
  pha
  plb
  stz $CF
  plp
  jmp $8263
warnpc $C0844B        ; lemme know if I run into the next piece of code, ok?

; Slice handler into jump table
org $C09966           ; Give Esper to party
  dw Action86

; Turn the bulk of the existing handler into a subroutine that the above code may call.
org $C0ADD2           ; End of general action 86, "give esper"
  rts                 ; Turn into a subroutine
  padbyte $FF
  pad $C0ADD7         ; Erase the rest of the handler

