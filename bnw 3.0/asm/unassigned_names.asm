;Notes:
;
;$0E-$3F Scratchpad RAM
;
;$BA-$BC Dialog Window
;---------------------
;    $BA Enable Dialog Window ($01 = open, $80 = close)
;    $BB Dialog Window Size ($00: smallest, $05: fully open)
;    $BC Dialog Window Top Y Position ($01: top, $12: bottom)
;
;$BD-$D3 Dialog Text
;-------------------
;    $BD Current Dialog Character
;    $BE Next Dialog Character
;    $BF Text's Current X Position on Dialog Window ($04-$E0)
;    $C0 Width of Current Word
;  + $C1 Pointer to Next Tile in VRAM (+$3800)
;  + $C3 Pointer to Current Tile in VRAM (+$3800)
;    $C5 Text Graphics Needs to be Copied to VRAM
;  + $C6 Unused (set to #$0700)
;    $C8 Max X Position on Dialog Window (always $E0?)
; ++ $C9 Pointer to Current Dialog Character
;    $CC current region of dialog window that needs to be cleared in VRAM (starts at 9, decrements once per frame)
;        9 = none, waiting for keypress
;        +-----------+-----------+
;        |     8     |     7     |
;        +-----------+-----------+
;        |     6     |     5     |
;        +-----------+-----------+
;        |     4     |     3     |
;        +-----------+-----------+
;        |     2     |     1     |
;        +-----------+-----------+
;        0 = none, no text displayed (or map name displayed)
;  + $CD Character to Display (top byte is for extra characters from FF6j)
;    $CF eppppppp
;        e: text buffer is empty
;        p: dialog text buffer position (+$7E9183)
;  + $D0 Dialog Index
;    $D2 -
;    $D3 Keypress State (decrements when button is pressed or released)
;        0 = not waiting for keypress
;        1 = waiting for keypress
;        2 = waiting for key release

hirom

!free = $D25312

org $C082CC
	JML LeaderHook

org !free
LeaderHook:
	CMP #$18
	BEQ .leader
	CMP #$17 
	BNE .notparam
	JMP .param			; too far for a branch
.notparam:
	CMP #$10			; displaced original
	BCS .other
	JML $C082D0			; $02-$0F: vanilla name handler
.other:
	JML $C08302			; original BCS target

; Special Dialog Byte $18: "Party Leader: "

; Displays the name of the current party's leader: the first usable entry of the party list ($0803,$0805,$0807,$0809)
; Gau and Umaro are skipped. The list stops at the $07B0 marker, so other parties' characters never speak.
; Prints nothing if nobody qualifies.

.leader:
	LDY $00
.next:
	LDX.w $0803,Y		; $0803 is the start of the "party list pointers". So X is the pointer to the object data of the first character in the party. 
	CPX.w #$07B0		; $07B0 is an end-of-party marker (pointer to object 48)
	BEQ .skip			; Each object has $29 bytes in the object list. so if we divide the pointer by $29, we can get the object number (character number)
	STX.w $4204			; Dividend = X
	LDA #$29			; Divisor = $29
	STA.w $4206			; Starts the divide
	NOP					; Wait for the divide
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	LDA.w $4214			; Store the result
	CMP #$0E
	BCS .nextslot		; Empty or >= 14
	CMP #$0B
	BEQ .nextslot		; Gau
	CMP #$0D
	BEQ .nextslot		; Umaro

	; Valid actor means: copy the name (as in C0/82D2), then append ": "
	; This code is copied from the existing dialog printing code

.copyname:
	STA.w $4202
	LDA #$25
	STA.w $4203
	NOP
	NOP
	NOP
	NOP
	LDY.w $4216
	LDX $00
.copy:
	LDA.w $1602,Y
	SEC
	SBC #$60
	CMP #$9F
	BEQ .end
	STA.l $7E9183,X
	INY
	INX
	CPX.w #$0006
	BNE .copy
.end:
	LDA #$61             ; ':'
	STA.l $7E9183,X
	INX
	LDA #$7F             ; Space
	STA.l $7E9183,X
	INX
	TDC
	STA.l $7E9183,X
	STZ $CF
	JML $C08263

.nextslot:
	INY
	INY
	CPY.w #$0008		; Don't check more than four slots
	BNE .next
.skip:
	JML $C0829D			; Print nothing, advance dialog pointer by 1

; Special Dialog Byte $17: "CaseWord Actor: "

; Displays name of a character picked from the CaseWord at $1EB4 (set by event commands)
; Must be immediately followed by a parameter byte. For some reason parameters $00 and $01 don't work, so we start from $02.
;	Parameter = $02, Table 1: Used for final talk with Kefka (CA/078C event)
;	Parameter = $03, Table 2: Used for final talk with Kefka (CA/0D35 event)
;	Parameter = $04, Table 3: Used for final talk with Kefka (CA/0DC8 event)
;	Parameter = $05, Table 4: Used for Post-Sealed Gate scene in the Imperial Camp (CB/2627 event)
; Add $08 to invert the CaseWord: pick the first one in the table who is NOT in the CaseWord. (Only used for Post-Sealed Gate scene in the Imperial Camp.)
; Prints nothing if nobody qualifies.

.param:
	LDA $BE				; Parameter byte ($BE Next Dialog Character)
	STA $1E				; Bit 3 = invert; Bits 0-2 = table ($0E-$3F Scratchpad RAM)
	INC $C9				; The parameter is consumed: Dialog pointer + 1 ($C9 Pointer to Current Dialog Character)
	BNE +
	INC $CA
	BNE +
	INC $CB
+
	CMP #$10			; A is still the parameter: reject anything above $0F
	BCS .badparam
	REP #$20			; 16-bit mode
	AND #$0007			; Table number 2-6
	DEC
	DEC
	CMP #$0005
	BCS .badparam		; Unsigned values below 2 wrap and fail too
	ASL
	TAX
	LDA.l TablePtrs,X	; Address of the table inside this bank
	TAX
	SEP #$20			; 8-bit mode
.entry:
	LDA.l $D20000,X		; character number, $FF = end of table
	CMP #$FF
	BEQ .skip
	STA $1F
	STZ $20
	LDY $1F				; Y = character number
	REP #$20			; 16-bit mode
	LDA.w $1EB4			; CaseWord: bit n = character n
.shift:
	CPY.w #$0000
	BEQ .tested
	LSR
	DEY
	BRA .shift
.tested:
	SEP #$20			; 8-bit mode
	AND #$01			; 1 = in the CaseWord
	STA $20
	LDA $1E
	AND #$08
	BNE .invert          ; bit 3 = invert
	LDA $20
	BNE .pick            ; normal: first one who is in the CaseWord
	BRA .more
.invert:
	LDA $20
	BNE .more            ; inverted: first one who is NOT in the CaseWord
.pick:
	LDA $1F
	JMP .copyname
.more:
	INX
	BRA .entry

.badparam:
	SEP #$20			; 8-bit mode
	JMP .skip

; Actor ID #'s for reference
	; Character $00 (TERRA )
	; Character $01 (LOCKE )
	; Character $02 (CYAN  )
	; Character $03 (SHADOW)
	; Character $04 (EDGAR )
	; Character $05 (SABIN )
	; Character $06 (CELES )
	; Character $07 (STRAGO)
	; Character $08 (RELM  )
	; Character $09 (SETZER)
	; Character $0A (MOG   )
	; Character $0B (GAU   )
	; Character $0C (GOGO  )
	; Character $0D (UMARO )

TablePtrs:				; Index = (Parameter & 7) - 2
	dw Table1&$FFFF, Table2&$FFFF, Table3&$FFFF, Table4&$FFFF, Table5&$FFFF

Table1:					; Parameter = $02
	db $00,$01,$04,$06,$05,$02,$03,$07,$08,$09,$0A,$0B,$0C,$0D,$FF
Table2:					; Parameter = $03
	db $00,$04,$05,$03,$08,$0A,$0C,$0D,$0B,$09,$07,$02,$06,$01,$FF
Table3:					; Parameter = $04
	db $01,$06,$02,$07,$09,$0B,$0D,$0C,$0A,$08,$03,$05,$04,$00,$FF
Table4:					; Parameter = $05
	db $01,$02,$04,$05,$09,$FF
Table5:					; Parameter = $06
	db $00,$01,$03,$04,$05,$06,$07,$08,$09,$0A,$0C,$FF
