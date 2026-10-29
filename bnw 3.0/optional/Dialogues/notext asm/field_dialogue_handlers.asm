; This runs through a set of rules to determine if the given dialogue
;   event is one that should be displayed. The rules for this are
;   as follows:
;   * if dialogue is enabled, show dialogue
;   * else if it is a coral chest (Ebot's Rock), show dialogue
;   * else if it contains a multiple choice option, show dialogue
;   * else if it is for a treasure chest (GP or Item), show dialogue
;   * else do not show

org !freespace

CheckConfig:
  lda $00			  ; $1D4E
  bit #$20
  rts

CheckDialogue:
  phy
  jsr CheckConfig
  bne .found          ; show dialogue if enabled in config
  jsr CheckCoral
  beq .found          ; show dialogue if it's a coral chest
  jsr !loadtext       ; preload the current dialog, but do not display
  ldy $00             ; start at first character of text
.loop                 ; v---------------------------------<
  lda [$C9],Y         ; Load letter at index Y            |
  beq .return         ; - exit if EOS is reached          |
  cmp #$15            ; - is it a choice control code?    |
  beq .found          ;   => found one, break out of loop |
  cmp #$19            ; - is it a GP control code?        |
  beq .found          ;   => found one, break out of loop |
  cmp #$1A            ; - is it an item control code?     |
  beq .found          ;   => found one, break out of loop |
  iny                 ; - else, increment index           |
  bra .loop           ; Check next character -------------^
.found
  lda #$FF
  bra .return
.return
  ply
  rts

; This is an absolute cop-out workaround, but my other efforts
;   to detect coral chests were not working out. Just checks
;   that the current map ID matches the teleport caves in
;   Ebot's Rock, as no other dialogues occur there normally.

CheckCoral:
  rep #$20
  lda $82             ; Check current map ID
  cmp #$0194          ; Is it Ebot's Rock?
  sep #$20
  rts

Cleanup:
  stz $D0
  stz $BC
  stz $0564
  stz $CB
  stz $C9
  stz $0568
  jmp AdvanceQueue    ; The end of the 48 handler, see optimize_dialog.asm

DialogueEnd:
  db $FF


; The following adds new text event handler wrappers and slices them
;   into the event code jump table

; The space freed up by optimize_dialog.asm
!recycledspace = RecycledSpace

; The text loading subroutine set up for the 48 and 4B handlers in
;   optimize_dialog.asm
!loadtext = $A475

; $C0 General actions jump table
org $C098EA           ; Dialogue without wait
  dw Action48

org $C098F0           ; Dialogue, wait for input
  dw Action4B

org !recycledspace    ; Next chunk conveniently packs into 30 of the
                      ;   31B just freed up, so that's a nice bonus

Action48:
  jsr CheckWhitelist  ; Check if dialogue should be displayed
  bne ShortCircuit    ; Exit if not
  jmp Handler48       ; Call original handler if so (optimize_dialog.asm)

Action4B:
  jsr CheckWhitelist  ; Check if dialogue should be displayed
  bne ShortCircuit    ; Exit if not
  jmp Handler4B       ; Call original handler if so (optimize_dialog.asm)

ShortCircuit:         ; Default behaviour for both
  jmp Cleanup         ; Tidy, skip dialogue, advance to the next event in the queue
                      ;   (see dialogue_exceptions.asm)

CheckWhitelist:
  tdc
  jsr CheckDialogue   ; Will set A to #$FF if the current dialogue is one that
                      ;   needs to be displayed (see dialogue_exceptions.asm)
  cmp #$FF
  rts

