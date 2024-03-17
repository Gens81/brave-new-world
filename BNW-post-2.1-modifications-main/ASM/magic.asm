arch 65816
hirom

table "menu.tbl", ltr ; Tabella per le stringhe di testo

org $C3F786
	jsr C350A2
	
;Restore original opcodes -> Now MP will be always showed up 
ORG $C34c80
		STZ $9E         ; No MP by Magic
		JSR $0F89      ; Stop VRAM DMA B

; Draw text in spell slot of Magic menu
ORG $C34FC4
C34FC4:	LDA $E6			; BG1 write row
		INC A			; Go 1 row down
		JSR $809F		; Compute map ptr
		REP #$20		; 16-bit A
		TXA				; ...
		STA $7E9E89		; Set position
		SEP #$20		; 8-bit A
		JSR $50EC		; Spell
		JSR $514D		; Handle graying
		JSR $50EC		; Spell
		CMP #$FF		; None?
		BEQ C3501A		; Blank if so
		JSR C350A2		; Spell mastery
		CMP #$FF		; Fully learned?
		BNE C3501A		; Blank if not

; Fork: Draw spell plus MP cost
C34FEB:	JSR $50EC			; Spell
		JSR $8467			; Load name
		LDX #$9E93			; 7E/9E92
		STX $2181 			; Set WRAM LBs
		JSR $50EC 			; Spell
		JSR $510D 			; Define MP cost
		JSR $04E0 			; Turn into text
		LDA #$D3   			; Tens digit	
		STA $2180  			; Add to string
		LDA #$FF   			; Free space	
		STA $2180  			; Add to string
		LDA $F8    			; Tens digit	
		STA $2180  			; Add to string
		LDA $F9				; Ones digit
		STA $2180  			; add to string
		LDA #$FF   			; space character
		STA $2180  			; add to string
		STZ $2180  			; end string
		JMP $7FD9  			; draw string

; Fork: Blank spell slot
C3501A: JMP CanLrn
		TDC             ; Clear A
        LDA $E5         ; Spell slot
        TAX             ; Index it
        LDA #$FF        ; Spell: None
        STA $7E9D89,X   ; Assign to slot
        JSR $51B9       ; Disable spell
        LDY #$000d		; Letters: 12
        LDX #$9E8B      ; 7E/9E8B
        STX $2181       ; Set WRAM LBs
        LDA #$FF        ; Space char
C35032: STA $2180       ; Add to string
        DEY             ; One less left
        BNE C35032      ; Loop till last
        STZ $2180       ; End string
        JMP $7FD9       ; Draw 11 spaces

		
; Fork: Draw spell plus percentage
 
C3503E: JSR $50EC			; Spell
        JSR $8467			; Load name
        LDX #$9E92			; 7E/9E92
        STX $2181 			; Set WRAM LBs
        JSR $50EC			; Spell
        JSR C350A2			; Spell mastery
        CMP #$FF  			; Fully learned?
        BEQ C34FEB			; Branch if so
        PHA       			; Save mastery
        LDA #$2C			; Palette 3
        STA $29				; Color: Bluish
		LDA #$FF			; Blankspace
		STA $2180 			; Add to string		 
        LDA #$D3  			; Char: "…"
        STA $2180 			; Add to string
        PLA       			; Spell mastery
        JSR $04E0			; Turn into text
		LDA #$FF			; Blankspace
		STA $2180 			; Add to string		 
        LDA $F8   			; Tens digit
        STA $2180 			; Add to string
        LDA $F9   			; Ones digit
        STA $2180			; Add to string
        LDA #$CD			; Char: "%"
        STA $2180 			; Add to string
C35082: STZ $2180 			; End string
        JMP $7FD9			; Draw string



; Get spell's mastery percentage
C350A2: STA $E0         ; Save spell
        JSR $4EDD       ; Define Y
        LDA $0000,Y     ; Actor
        CMP #$0C        ; Gogo?
        BEQ C350C5      ; Branch if so
C350AE: STA $4202       ; Set multiplicand
        LDA #$36        ; Spell list size
        STA $4203       ; Set multiplier
        TDC             ; Clear A
        LDA $E0         ; Spell
        REP #$20        ; 16-bit A
        ADC $4216       ; Add product
        TAX             ; Index sum
        SEP #$20        ; 8-bit A
        LDA $1A6E,X     ; Spell mastery
        RTS

warnpc $C350C5

org $c3f592
CanLrn:	JSR $50EC		; Spell
		CMP #$32		; Rerise?
		BEQ .rerise		; Branch if so
.Cannot	JMP C3501A+3	; Print blank if not

.rerise	PHY				; Save Y
		LDY $67			; Actor index in Y
		LDA $0000,Y		; Load Actor ID
		PLY				; Restore Y
		CMP	#$03		; Relm?
		BEQ .CanLrn		; Branch if so
		CMP #$08		; Shadow?
		BEQ .CanLrn		; Branch if so
		BRA .Cannot		; Print blank
.CanLrn	JMP C3503E		; Print spel plus percentage



ORG $C350C5
C350C5:					; Placeholder to avoid compiling issues

; Erase Fork: Handle Y, moving down 1A: Sustain Magic Menu
org $C327E2

PADBYTE $FF :	PAD $C327FE
warnpc $C327FE

org $C3020F
	dw C327F2

; Queue pushing Y OAM fn	
org $C32097
	JSR C327E5			; Jump to routine that load sprite when entering skill submenu
	
org $C35975	
	JSR C327E2

org $C32d75
	JMP C327EF
	
	
org $C3a20A
C327E2:
	JSR $0F11
	BRA skip
C327E5:
	LDA $4B
	ASL
skip:
	PHA
	TDC
	LDY #C36122			; $C3/6122
	JSR $1173			; Queue OAM fn
	TDC
	PLA
	RTS
	
C327EF:
	JSR $3541
	BRA skip

PADBYTE $FF
PAD $C3A222
warnpc $C3A222

; Initialize Magic menu
org $C3211C
	JSR $2130      ; Create scrollbar
	JSR $2148      ; Load nav data, etc.
	JSR $2158      ; Draw spells, etc.
	JSR C32802
	JSR $0F4D      ; Queue BG3 upload
	LDA #$1A        ; C3/27E2
	STA $26         ; Next: Sustain menu
	RTS

org $C327E2	
; 1A: Sustain Magic menu

C327F2:  LDA #$10        ; Description: On
		 TRB $45         ; Set menu flag
		 LDA #$01        ; List type: Magic
         STA $2A         ; Set redraw mode
         JSR $0EFD      ; Queue list upload
         LDA $021E       ; Frame counter
         ROR A           ; Even value?
         BCC C327F8      ; Favor desc if so
         JSR $0F75      ; Queue cost upload
         BRA C327FB      ; Skip a line
C327F8:  JSR $A991      ; Queue desc upload
C327FB:  JSR $1F64      ; Handle L and R
         BCS C32861      ; Exit if pushed
         JSR $4B88      ; Handle D-Pad
         JSR $56E5      ; Load description
		 JSR Y_spec


		 
PADBYTE $EA :	PAD $C32822
warnpc $C32822		 
org $C3281f
C32822:

org $c3fda5

; Holding Y
Y_spec:	 lda $0D
         bit #$40           	; holding Y?	
		 BEQ C32802				; Branch if not
		 LDA #$10				; Description off
		 TSB $45				; Set
		 STA $C0				; Set power and target flag
		 jsr $6a41
		 jsl power_target_title	; Jump to write power and target
		 JSR $0f75				; Upload BG3 tilemap B
		 JSR $0EFD				; Upload BG1 tilemap A
		 RTS					; Go to original routine
C32802:	 LDA $C0				; Cleared tilemap B BG3?
		 BEQ C3X822				; Branch if so
		 STZ $C0				; Clear flag
		 JSR $0F4D				; Upload 
		 JMP $A662				; Build VEF tilemap
C3X822:	 RTS

warnpc $c3fdd1

org $C3f69b
C3F69B:	 LDY #$0400      ; $0800
         STY $1b         ; Set VRAM ptr
         LDY #$4049      ; 7E/4049
         STY $1d         ; Set src LBs
         LDA #$7E        ; Bank: 7E
         STA $1f         ; Set src HB
         LDY #$0800      ; Bytes: 4096
         STY $19         ; Set data size
         RTS	
		 
warnpc $C3F6B0


org $C32861
C32861:

org $C36122
C36122:
	JSL EDFD68		; Jump to routine that print y button
	RTS
warnpc $c36128

ORG $C350DB
	JSR C350AE
	
org $c3f7d1 
	jsr C350A2

org $C4b97b
power_target_title:	
	ldy #$0004					; Pointers
	lda #$2C					; Light blue colour
	sta $29						; Set
	ldx #target_power_ptr		; Pointer's pointer
	JSR C369BA					; Print multiple string
	lda #$20					; User colour
	sta $29						; Set
	jsl get_target				; Jump and get Target type 
	RTL
	
target_power_ptr:
	dw #target
	dw #power

	
target:		dw $8123 : db "Target",$00
power:		dw $810d : db "Power",$00

warnpc $c4b9ce

org $C0DEF2
effect_pointers:
	dw #Free
	dw #Single
	dw #One_Foe
	dw #Foes
	dw #Foe_Group
	dw #All_Foes
	dw #One_Ally
	dw #Allies
	dw #Ally_Group
	dw #Party
	dw #All
	dw #Warp_t

effect:
Free:		db "Free",$00
Single:		db "Single",$00
One_Foe:	db "One Foe",$00
Foes:		db "Foe(s)",$00
Foe_Group:	db "Foe Group",$00
All_Foes:	db "All Foes",$00
One_Ally:	db "One Ally",$00
Allies:		db "Allies",$00
Ally_Group:	db "Ally Group",$00
Party:		db "Party",$00
All:		db "All",$00
Warp_t:		db "-",$00
	
warnpc $C0DF6B

org $CCFE80
get_target:
	TDC						; Clear A
	LDA $0100				; Load Spell Target address
	STA $E7					; Store 
	CLC						; Prepare ADC
	ADC #$06				; Take Power Address
	STA $F5					; Store
	LDX $0101				; Load Spell Bank
	STX $E8					; Store
	STX $F6					; Store
	LDA $4B					; Cursor position
	TAX						; Index
	LDA $7E9D89,x			; Skill
	CMP #$FF				; Skill?
	BNE .begin				; Branch if so
	RTL						; Back
.begin						; Compute multiply by $0E
	rep #$20				; 16-bit A
	sta $FE					; Temporary
	asl						; *2
	asl						; *4
	asl						; *8
	sec						; Prepare SBC
	sbc $FE					; *7
	asl						; *14
	TAY						; Index multiply by 0E
	TDC						; Clear A
	SEP #$20				; 8-bit A
	lda [$E7],Y				; Load Target
	PHA						; Push A
	jmp bushido				; Jump and check if bushido
.normal_power
	lda [$F5],y				; Load Power
	BEQ .zero				; Branch if 0
	%FakeC3(04E0)			; Convert Blank leading 0
	bra .not0				; Branch to print
.zero
	ldX	#$ffff				; Blank decimal and hundred values
	STX $f7					; set
	LDA #$c4				; Convert Blank into -
	sta $f9					; Set
.not0	
	LDX #$8119      		; Power number position
    %FakeC3(04C0)	   		; Draw 3 digits
.bushido_compute
	TDC						; Clear A
	PLA						; Restore Target
	jsr convert				; Eventually convert
;---------------------------------
; Some skills can't match bitmask
;--------------------------------
.bitmask
	CMP #$01				; Reflect?
	BNE .free				; Branch if not - may be free target
	LDA #$41				; Turn into "Single" target active
	BRA .skip				; Branch and avoid bitmask and print "Single"
.free
	cmp #$21				; Not Reflect, It's Cure?
	BNE .bushido_blitz		; Branch if not
	lda #$61				; Turn into "Free" target active
	bra .skip				; Check
.bushido_blitz
	cmp #$7E				; Bushido and Blitz use $7E instead of $6E for All Foes 
	bne .skip				; Branch if not
	lda #$6E				; Convert if so
.skip
	STA $FF					; Save in $FF
	LDX #$FFFF				; Load index
.loop
	INX						; iNC x
	LDA.l bitmask,x			; Load bitmask
	JSR convert
	CMP $FF					; Same as $FF?
	BNE .loop				; Loop untill last
	TXA						; Transfer X to A
	ASL						; Double it
	TAX						; Index it
	rep #$20				; 16-bit A
	LDA.l effect_pointers,x	; Load pointer
	STA $E7					; Save address for print			
	LDY #$8131				; Load $7E/80F1 for single string print
	%FakeC3(3519)			; Prepare print from $7E/9E89 ram address
	TAY						; After JSR A will be $0000, clear Y
	LDA #$C0				; string to print Bank
	STA $E9					; Save
.print
	LDA	[$E7],y				; Load string
	beq .end				; 'Till $00
	STA $2180				; Set
	iny						; Inc index
	bra .print				; Loop
.end
	stz $2180				; End String
	%FakeC3(7FD9)			; Print string
.back	
	RTL
convert:
	CMP #$53				; Need to be changed?
	BNE .rts				; Branch if not
	LDA $26					; Menu flag
	CMP #$3E				; Bushido?
	BNE .blitz				; Branch if so
	LDA $4b					; Cursor pos.
	CMP #$03				; Flurry?
	BEQ .rts				; Leave it 
	CMP #$06				; Tempest?
	BEQ .rts				; Leave it
	BRA .one_foe			; Change in One Foe 
.blitz
	CMP #$33 				; Blitz?
	bne .rts				; Branch if not
.one_foe
	lda #$43				; Convert
.rts
	rts
	
bushido:
	LDA $26					; Menu flag
	CMP #$3E				; Bushido?
	bne .back				; Branch if not
	jmp compute_bushido
.back
	jmp get_target_normal_power



bitmask:
	db $61	; Free
	db $41	; Single
	db $43	; One Foe
	db $53	; Foe(s)
	db $6A	; Foe Group
	db $6e	; All Foes
	db $03	; One Ally
	db $3e	; Allies
	db $2a	; Ally Group
	db $2e	; Party
	db $04	; All
	db $00	; Warp_t

compute_bushido:
	PhY						; Push Y
	LDA $11AC				; R-Hand
	STA $F3
	cmp #$0B				; Weapon?
	BCS .weapon				; Branch if so
	LDA $11AD				; L-Hand
	BEQ .no_weapon			; Empty hand so add base attack and compute
	CLC 
	ADC	$F3					; Add R-Hand
.weapon	
	CLC
	adc $11ad	
	REP #$20				; 16-bit A
	CLC
	adc $11cc				; Add attack base
	PHA						; store a
	LSR         		    ; A / 2
	CLC         		    ; clear carry
	ADC $01,S   		    ; add A
	STA $01,S   		    ; save result to stack
	PLA          		   ; A * 1.5
	bra .compute
.no_weapon
	CLC
	adc $F3					; add R-Hand
	REP #$20				; 16-bit A
	CLC
	adc $11cc				; Add base attack
.compute	
	ply
	SEP #$10				; 8-BIT X,Y
	ldx $4B					; Load finger pos.
	cpx #$06				; On Tempest?
	beq .tempest			; Branch if so
	CPX #$00				; On Dispatch?
	BEQ .dispatch			; Branch if so
	cpx #$03				; On flurry?
	bne .not_from_above		; Branch if not
	LSR						; Power /2
.dispatch
	LSR						; Power /4 (/2)
	LSR						; Power /8 (/4)
	STA $f3					; Save
	ASl						; Double it
	clc						; Prepare ADC
	adc $f3					; Make it X3
	bra .skip_tempest
.tempest
	lsr						; Half power
.skip_tempest	
	STA $F3					; Save value

	SEP #$20				; 8-bit A
	REP #$10				; 16-bit x,y
	TDC						; Clear A
	TAX						; Transfer a to x
	LDA #$05				; Digits: 5
	STA $E0					; Set counter
	LDY #$FFFE				; Ram index: -2
	%FakeC3(0535)			; Turn into text (16-bit)
	
	LDX #$8119
	%FakeC3(04c0)
	jmp get_target_bushido_compute
.not_from_above
	REP #$10				; 16-bit x,y
	SEP #$20				; 8-bit A
	jmp bushido_back
	
warnpc $CD0000



;Rage:
;26=1d
;LDA $4B					; Rage in slot
;		TAX						; Index it
;		LDA $C4A7E0,X			; Rage ID - Multiplicand
;		STA $211B				; Set Low-Byte
;		STZ $211B				; Clear Hi-Byte
;		LDA #$20				; Multiplier
;
