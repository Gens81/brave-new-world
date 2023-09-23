hirom
table table_c3.tbl,rtl
; header

; BNW - Randomize Party
; Bropedio (August 22, 2019)
;
; For the final battle against Kefka, only allow the
; player to select their first 4 characters in the
; line-up. After those four, the line-up will now be
; shuffled/randomized for an extra challenge.

!free_space = $C3F5C0

; ###############################################
; Modify existing line-up code to allow only 4 selections,
; and add a hook to shuffle the remaining characters when
; the player presses "Start" or selects "End"

org $C3AC33
  LDX #$0004          ; limit user selected list to 4
org $C3AA8F
  JSR MaybeAdd        ; add chosen character if not at max
  LDA $4A             ; (vanilla code)
  CMP #$04            ; go to "End" after selecting 4
org $C3AA9C
  JSR ShuffleList     ; randomize remaining lineup order

; ###############################################
; Change lineup menu heading

org $C3AC98 : dw $391D : db "Select party",$00

; ###############################################
; New Code

org !free_space

MaybeAdd:
  LDA $4A             ; currently selected
  CMP #$04            ; already maxed out
  BEQ .exit           ; exit (and point to End) if ^
  JSR $AAB2           ; add chosen character (vanilla)
.exit
  RTS

ShuffleList:
  LDY #$000B          ; start with 12th slot
.loop
  TYA                 ; place range in A
  JSR RandomInRange   ; random number from 0 to A
  TAX                 ; store as slot to swap
  JSR SwapSlots       ; swap slots X and Y
  DEY                 ; point to next lowest slot
  BNE .loop           ; peform random swaps for each slot
  JSR $AACA           ; continue to "End" vanilla code
  RTS

RandomInRange:        ; 18 bytes
  INC                 ; include A in possible random number
  STA $4202           ; first multiplicand (range)
  JSL $C0FD00         ; random number
  STA $4203           ; second multiplicand
  NOP #4              ; wait for calc
  LDA $4217           ; get hi byte of product
  RTS

SwapSlots:            ; 35 bytes
  PHB                 ; store current bank
  LDA #$7E            ; replace with $7E
  PHA
  PLB
  LDA $AA8D,X         ; slot X's palette
  PHA                 ; store on stack
  LDA $AA8D,Y         ; slot Y's palette
  STA $AA8D,X         ; replace X's
  PLA                 ; get X's palette
  STA $AA8D,Y         ; replace Y's
  LDA $9D8A,X         ; slot X's id
  PHA                 ; store on stack
  LDA $9D8A,Y         ; slot Y's id
  STA $9D8A,X         ; replace X's
  PLA                 ; get X's id
  STA $9D8A,Y         ; replace Y's
  PLB                 ; restore bank
  RTS
