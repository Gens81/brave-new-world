                                         arch 65816
hirom

;;-----------------------------------------------------
;;-----------------------------------------------------
;;
;;						Status menu
;;
;;-----------------------------------------------------
;;-----------------------------------------------------

;--------------------------------------------------
;Windows
;
;	First value: Start print position
;	Second value: Height
;	Third value: Lenght
;--------------------------------------------------

org $C35f79
	db $4b,$5d,$1c,$05	;Bottom box
	db $af,$5b,$07,$07	;Technique Box
	db $8b,$58,$1c,$09	;Top box
	db $c7,$58,$00,$12	;Middle box
	db $87,$60,$07,$12	;???

; Pointers manager
org $c35d60	; Blue text
	ldx #statusstats						; Start pointer address
	ldy #charapoint-statusstats				; Pointers to read (2 bytes each pointer)

org $C35D52	; Blue text
	ldx #charapoint							; Start pointer address
	ldy #slashes-charapoint					; Pointers to read (2 bytes each pointer)

org $C35D45	; White text
	ldx #slashes							; Start pointer address
	ldy #LVMPPlaceHolder-slashes			; Pointers to read (2 bytes each pointer)

org $c35d69	; Yellow Text text (BG3)
	lda #$34								; Load Yellow Palette  
	sta $29   								; Store on $29
	ldx #LVMPPlaceHolder					; Start pointer address
	ldy #$0004								; Pointers to read (2 bytes each pointer)
	jsr $69ba						; Jump to sub routine that add new pointers instead of "prepare print"
	rts

warnpc $C3652D

;Pointers table
org $C36437
statusstats:
	dw #statusvigor
	dw #statusstamina
	dw #statusmagic
	dw #statusevade
	dw #statusmagicevade
	dw #statusspeed
	dw #statusattack
	dw #statusdefense
	dw #statusmagicdefense
	dw #statusexp
	dw #statusnextlv
	
charapoint:
	dw #statusLV
	dw #statusHP
	dw #statusPM

slashes:
	dw #statusslash
	dw #statusslash2

LVMPPlaceHolder:
	dw #LVPlaceHolder
	dw #MPPlaceHolder

;Data

statusslash:
	db $ab,$39,$c0,$00

statusslash2:
	db $eb,$39,$c0,$00

statusLV:
	db $5d,$39,"LV",$00
	
statusHP:
	db $9d,$39,"HP",$00
	
statusPM:
	db $dd,$39,"MP",$00
	
statusexp:
	db $cd,$7a,"Exp.",$00
	
statusnextlv:
	db $4d,$7b,"Next LV",$00
	
statusvigor:
	db $4d,$7c,"Vigor",$00
	
statusmagic:
	db $cd,$7c,"Magic",$00
	
statusspeed:
	db $4d,$7d,"Speed",$00
	
statusstamina:
	db $cd,$7d,"Stamina",$00
	
statusattack:
	db $4d,$7f,"Attack",$00
	
statusdefense:
	db $cd,$7f,"Defense",$00
	
statusmagicdefense:	
	db $eb,$7f,"M.Defense",$00
	
statusevade:
	db $4d,$88,"Evade",$00
	
statusmagicevade:
	db $6b,$88,"M.Evade",$00


	
LVPlaceHolder:
	db $b7,$39," ",$00
MPPlaceHolder:
	db $f7,$39," ",$00
	
	
padbyte $ff
pad $c3651b
warnpc $C3651c

;---------------------------------------------------------------------;
;                                                                     ;
;       Hack that print stats difference in yellow colour             ;
;                                                                     ;
;---------------------------------------------------------------------;                                                                     ;

org $D8E7F0 ; Extending palette
MenuPalette:

db $00,$00,$00,$00,$ce,$39,$ff,$7f,$00,$00,$00,$00,$08,$21,$ef,$3d
db $00,$00,$00,$00,$ce,$39,$bf,$03,$00,$00,$00,$00,$ce,$39,$60,$6f	;1st row

db $00,$00,$00,$00,$ce,$39,$60,$6f,$00,$00,$ff,$7f,$00,$00,$ff,$7f
db $00,$00,$00,$5c,$08,$21,$ef,$3d,$00,$00,$00,$00,$ce,$39,$60,$6F	;2nd row

db $00,$00,$00,$00,$08,$21,$ef,$3d,$00,$00,$00,$00,$08,$21,$ef,$3d
db $00,$00,$00,$00,$08,$21,$ef,$3d,$00,$00,$00,$00,$08,$21,$ef,$3d	;3rd row

db $00,$00,$00,$3c,$08,$21,$ef,$3d,$00,$00,$68,$38,$ce,$39,$ff,$7f
db $00,$00,$68,$38,$ce,$39,$ff,$7f,$00,$00,$68,$38,$ce,$39,$ff,$7f	;4th row

db $00,$00,$10,$42,$94,$52,$ff,$7f,$00,$00,$10,$42,$94,$52,$ff,$7f
db $00,$00,$10,$42,$94,$52,$ff,$7f,$00,$00,$10,$42,$94,$52,$ff,$7f	;5th row

db $00,$00,$00,$00,$ce,$39,$bf,$03									;6th row

Org $c36bee
	rep #$20			; 16 bit A
	lda MenuPalette,x	; Load Palette Data
	sta $7e3049,x		; Store in RAM
	sep #$20			; 8 bit A
	sta $2122			; Put LB in CGRAM
	xba					; Switch to HB
	sta $2122			; Put HB in CGRAM
	inx					; Index +1
	inx					; Index +1
	cpx #$00a8			; Set 88 colors
	

; Define labels
	
!plus = $d4
!TurnIntoText16bit = $052E
!TurnIntoText8bit = $04E0
!Draw5Digits = $049A
!Draw4Digits = $0490
!Draw3Digits = $04C0
!Draw2Digits = $04B6
!StatCoord = $C3FDD1
!StatOffset = $C3FDE0
!Make1ESBCValue = $FEC0
!StatDiff = $FDEC		; StatOffset + 12
!HpMpDiff = $FE3E

org $C3FDD1
; StatCoord
	dw $7CDF				; magic     (11A0)  
	dw $7DDF				; stamina   (11A2)
	dw $7D5F				; speed     (11A4)
	dw $7C5F				; vigor     (11A6)
	dw $885F				; evade     (11A8)
	dw $887F				; m.evade   (11AA)

org $C3FDE0
; StatOffset
	db $00,$0A				; HP
	db $01,$0E				; MP
	db $09,$1D				; Magic
	db $08,$1C				; Stamina
	db $07,$1B				; Speed
	db $06,$1A				; Vigor

StatDiff:
	LDA #$28				; load BG3 yellow color
	STA $29                 ; store
.loop	
	PHX						; save index X
	TDC						; zero B
	PHA						; save 0 high byte
	LDA !StatOffset,X		; init data offset for stat
	PHA						; save ^ with zero hibyte
	LDA !StatOffset+1,X		; data offset for stat
	REP #$21				; 16-bit A, clear carry
	ADC $67					; add to actor data offset
	TAY						; index offset to stat
	LDA !StatCoord-4,X      ; load ram coord (-4 because X start with a value by 4 to be the same as offset)
	STA $EB                 ; store for the print routine
	PLA						; get init data offset again
	CLC						; clear carry
	ADC $000100				; add offset to init data block
	TAX						; index to init data stat
	TDC : DEC				; FFFF in A
	STA $F7					; default to blanks
	STA $F8					; default to blanks (return blank space in the stats if difference is 0)
	SEP #$21				; 8-bit A, set carry
	LDA $0000,Y				; current stat value
	SBC $ED7CA0,X			; subtract init value
	BEQ .zero				; exit if no change
	JSR !TurnIntoText8bit	; turn into text (8-bit)
	DEY						; point to last cleared zero digit
	LDA #!plus				; plus character
	STA $00F7,Y				; place plus in front of number
.zero
	LDY #$0003				; how many digits to write
	STY $E0					; set counter for how many digits
	LDY #$0008				; how many spaces to skip
	TDC						; zero A/B
	TAX						; zero X counter
	JSR $04D0				; draw 3 digits (8-bit)
	PLX                     ; take X
	INX                     ; increment x
	INX                     ; increment x twice
	CPX #$000C              ; are all the values done?
	BMI .loop               ; branch if not
	RTS                     ; return to the original routine

HpMpDiff:
	LDA #$34	            ; load BG1 yellow color
	STA $29	                ; store
	REP #$20                ; 16-bit A
	LDA $1E                 ; load 1E (necessary to save portrait value in the ship status menu)
	STA $0102               ; store
	SEP #$20                ; 8-bit A
	LDX #$0000				; clear X 
.loop	
	PHX						; save index X
	TDC						; zero B
	PHA						; save 0 high byte
	LDA !StatOffset,X		; init data offset for stat
	PHA						; save ^ with zero hibyte
	LDA !StatOffset+1,X		; data offset for stat
	REP #$21				; 16-bit A, clear carry
	ADC $67					; add to actor data offset
	TAY						; index offset to stat
	PLA						; get init data offset again
	CLC						; clear carry
	ADC $000100				; add offset to init data block
	TAX						; index to init data stat
	TDC : DEC				; FFFF in A
	STA $F7					; default to blanks
	STA $F9					; default to blanks
	STA $FA					; default to blanks	(return blank space in the stats if difference is 0)
	JSR !Make1ESBCValue		; jump on sub routine that add all the Hp/Mp level progression values
	PHY						; save Y
	LDA $ED7CA0,X			; load init value
	REP #$21                ; 16-bit A
	ADC $1E                 ; add to $1E
	STA $1E                 ; store
	LDA $0001,Y				; current stat value
	AND #$3FFF				; clear % improvement flag from the stat value 
	SEC						; set carry flag
	SBC $1E					; subtract all the extra values
	BEQ .zero				; branch if result is 0
	STA $F3					; store on $F3 for turn in text routine
	SEP #$20				; 8-bit A
	JSR !TurnIntoText16bit	; turn into text (16 bit)
	DEY						; decrease Y 
	LDA #!plus              ; load arrow value
	STA $00F7,Y             ; save on $F7+Y (that set the symbol next to the 1st value)
.zero
	LDX #$39F9				; load MP offset (A instead of X because 
	LDY $F1					; load MP "flag"
	CPY #$0001				; is true?
	BEQ .MP					; branch if so
	LDX #$39B9				; load HP offset
.MP
	STX $EB                 ; store on $EB for draw routine
	SEP #$20                ; 8-bit A
	JSR $0490				; draw 4 digits (16 bit)	
	LDA #$01				; load $01 in A
	STA $F1					; make $F0 flag true
	PLY						; take Y (probably unnecessary)
	PLX						; take X
	INX                     ; increment X
	INX                     ; increment X twice
	CPX #$0004              ; check if the routine have made Hp&Mp difference operation
	BMI .loop				; branch if not
	RTS 
	
org $C3FEC0
Make1ESBCValue:
	STZ $1E				; clear $1E	
	STZ $1F				; clear $1F	
	PHX					; save X
	PHY					; save Y
	LDA #$0007			; load #$07
	SEC					; set carry flag
	ADC $67				; add actor data offset and take LV value ram offset
	TAY					; index offset
	TDC					; clear A
	SEP #$21			; 8-bit A, set carry
	LDA $0000,Y			; load reached LV value
	STA $1B				; store in $1B and make a counter
	LDX #$0000			; clear X
	.loop               
	SEP #$21            ; 8-bit A, set carry flag (necessary for the loop)
	TDC                 ; clear A
	LDA $1B             ; load counter
	DEC                 ; decrease
	STA $1B             ; save counter
	CMP $00             ; is the counter 0?
	BEQ .end            ; branch to end if so	
	LDA $E6F4A0,X		; load LV Hp progression value
	LDY $F1				; load $F1
	CPY #$0001			; check if $F1 flag is true
	BNE .HP				; branch if not
	LDA $E6F502,X		; load LV MP progression value
.HP
	REP #$21			; 16-bit A, clear carry
	ADC $1E				; add LV progression to $1F
	STA $1E				; store on $1F
	INX					; increment X
	BRA .loop			; branch and continue the loop
.end 
	PLY					; restore Y
	PLX					; restore X
	RTS					; return




	
org $C35FCB
PrintValueRoutine:				
	LDA $0000,Y				; load actor ID
	STA $004202				; set multiplicand
	LDA #$16				; size of init data block
	STA $004203				; get offset to actor init data
	LDX #$0000				; Clear X
	LDA #$20				; load White palette
	STA $29					; store
	REP #$20                ; 16-bit A
	LDA $4216               ; load product
	STA $0100               ; store on $0100 for statdiff routines
	SEP #$20                ; 8-bit A
.loop 
	LDA $11A0,X				; Load stat indexed value
	PHX						; Save index X
	JSR !TurnIntoText8bit	; Go to routine that turn values into text
	PLX						; Take index X
	REP #$20				; 16 bit A
	LDA !StatCoord,X		; Load indexed stat coord in A
	SEP #$20				; 8 bit A
	PHX						; Save index X
	TAX						; Transfer to X
	JSR !Draw3Digits		; Go to the routine that print the value
	PLX						; Take index X
	INX						; Increment X
	INX						; Increment X
	CPX #$000C				; Check if m.evade (11AA) is already done (11A0 + 000B = 11AB)
	BMI .loop				; Branch to loop and load stat value and coord.
	LDA $11BA				; Defense value
	JSR !TurnIntoText8bit
	LDX #$7FDF				; Defense stat position
	JSR !Draw3Digits	
	LDA $11BB				; M.Defense Value
	JSR !TurnIntoText8bit
	LDX #$7FFF				; M.Defense stat position
	JSR !Draw3Digits
	JSR $9371				; Define Attack
;C36002 BNW new data
	BRA Skip				; skip over unused code, now freespace for helper function
PowHelper:	
	LDX #$300C				; use addresses $300C and $300D for hand Battle Powers
	STX $E0					; save in temp variable
	LDX $CE					; just want bottom half, top half will be ignored
	CLC	
	LDA $A0					; check for Gauntlet, setting Zero Flag accordingly
	NOP	
	RTS	
	Skip:	
	JSR $052E				; [vanilla] unchanged, left for context
;C36010 'Till here
	LDX #$7F5F				; Text position
	JSR $0486				; Draw 3 digits
	LDY #$78DB				; Text position
	JSR $34CF				; Draw actor name
	LDY #$399D				; Text position
	JSR $34E5				; Actor class...
	JSR $F3BF				; EP Text
	JSR $FC4B				; Next EL 
	JSR $6102				; Draw commands
	LDA #$20				; Palette 0
	STA $29					; Color: User's
	LDX #$6096				; Coords tbl ptr
	JSR $0C6C				; Draw LV, HP, MP
	LDX $67					; Actor's address
	LDA $0011,X				; Experience LB
	STA $F1					; Memorize it
	LDA $0012,X				; Experience MB
	STA $F2					; Memorize it
	LDA $0013,X				; Experience HB
	STA $F3					; Memorize it
	JSR $0582				; Turn into text
	LDX #$7AD9				; Text position
	JSR $04A3				; Draw 8 digits
	JSR $60A0				; Get needed exp
	JSR $0582				; Turn into text
	LDX #$7B5B				; Text position
	JSR $04AC				; Draw 8 digits
	JSR $6BE8				; reload palette
	JSR !HpMpDiff	        ; go to routine that set Hp/Mp difference
	JSR !StatDiff	        ; go to routine that set stats difference	
	LDX $0102	            ; load $0102 (ship status menu portrait values) 
	STX $1E	                ; store
	SEP #$20	            ; 8-bit A
	STZ $47					; Ailments: Off
	JSR $11B0				; Hide ail. icons
	JMP $625B				; Display status

warnpc $C36096

org $C39382
	JSR PowHelper			; here just to avoid crash
