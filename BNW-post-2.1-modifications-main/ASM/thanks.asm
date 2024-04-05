arch 65816
hirom

table "menu.tbl", ltr ; Tabella per le stringhe di testo
; Intro tileset enlarged
org $c0fcb0
	stz $ee								; From original routine
	ldy #$71b8							; Vram address
	rep #$20							; 16-bit A
	tya
	sta $002116							; Set
another_one:
	lda.l missing_letters,x				; Enlarge tileset
	sta $002118							; Set byte in vram
	inx									; Inc X
	inx									; Inc twice
	cpx #letters_end-missing_letters	; Done?
	bne another_one						; Branch if not
	ldy #$7000							; Vram address
	rtl
	
org $cef480
missing_letters:
	incbin "../gfx/missing_letters.bin"
letters_end:	
warnpc $cef600



; Build "THE END" Tilemap
org $cb5850
nowea:
	incbin "../gfx/nowea.bin"		; In loving memory
nowea_end:
warnpc $cb5ec5
	
	
org $e5f46b			
	lda #$e6        ; BG1 H-Scroll Lo-byte
	sta $210d       ; Set
	lda #$00        ; BG1 H-Scroll Hi-Byte
	sta $210d       ; Set
	lda #$a8        ; BG1 V-Scroll Lo-byte
	sta $210e       ; Set
	lda #$00        ; BG1 V-Scroll Hi-Byte
	sta $210e       ; Set
	lda #$cb        ; BG2 H-Scroll Lo-byte
	sta $210f       ; Set
	lda #$00        ; BG2 H-Scroll Hi-Byte
	sta $210f       ; Set
	lda #$ad        ; BG2 V-Scroll Lo-byte
	sta $2110       ; Set
	
warnpc $e5f48e	

org $e5f7bd
	lda #$57		; BG1 V-Pos
	sta $1b00		; Set
	lda #$18        ; ???
	sta $1b01       ; 
	lda #$10        ; ???
	sta $1b02       ; 
	lda #$38        ; BG1 Highness
	sta $1b03       ; Set
	lda #$32        ; BG1 L-Side
	sta $1b04       ; Set
	lda #$ce        ; BG1 R-Side
	sta $1b05       ; Set
	
warnpc $e5f7db

org $e5f554
; The end and bg 2 tileset
	ldx $00			; Vram address $0000
	stx	$2116		; Set
	LDA #$01		; 2Rx1B to PPU
	STA $4300		; Set DMA mode
	LDA #$18		; $2118
	STA $4301		; To VRAM
	ldx #$6300		; $6300
	stx $4302		; Set src address
	lda #$e9		; Bank: $E9
	sta $4304		; Set src Bank
	ldx #$0d00		; Bytes: 3328
	stx $4305		; Set data size
	lda #$01		; Channel: 0
	sta $420b		; Move data
	ldx #$fe00		; $fe00
	stx $4302		; Set src address
	lda #$c9		; Bank: $c9
	sta $4304		; Set src Bank
	ldx #$0100		; Bytes: 256
	stx $4305		; Set data size
	lda #$01		; Channel: 0
	sta $420b		; Move data	
; Nowea text
	ldx #nowea					; 
	stx $4302					; Set src address
	lda #$cb					; Bank
	sta $4304					; Set src Bank
	ldx #nowea_end-nowea		; Bytes: 256
	stx $4305					; Set data size
	lda #$01					; Channel: 0
	sta $420b					; Move data
	
	
; Palette for above	
	lda #$00		; CGram address $0000
	sta	$2121		; Set
	STA $4300		; 1Rx1B to PPU - Set DMA mode
	LDA #$22		; $2122
	STA $4301		; To CGRAM
	ldx #$ff00		; $ff00
	stx $4302		; Set src address
	lda #$c9		; Bank: $c9
	sta $4304		; Set src Bank
	ldx #$0100		; Bytes: 256
	stx $4305		; Set data size
	lda #$01		; Channel: 0
	sta $420b		; Move data	

	ldx #$0000
	txy
.loop	
	lda.l $c9ff80,X
	sta $24
	and #$1f
	asl
	asl
	sta $08c0,y
	lda.l $c9ff81,X
	lsr
	ror $24
	lsr
	ror $24
	asl
	asl
	sta $08c4,y
	lda $24
	and #$f8
	lsr 
	sta $08c2,y
	lda #$00
	sta $0800,y
	sta $0801,y
	sta $0802,y	
	sta $0803,y	
	sta $0804,y
	sta $0805,y	
	sta $0980,x
	sta $0981,x
	iny
	iny
	iny
	iny
	iny
	iny
	inx
	inx
	cpx #$0020
	bne .loop

	ldx $00
	txy
.loop2
	lda.l $c9ff60,X
	sta $24
	and #$1f
	asl
	sta $0920,y
	lda.l $c9ff61,X
	lsr
	ror $24
	lsr
	ror $24
	asl
	sta $0924,y
	lda $24
	and #$f8
	lsr
	lsr
	sta $0922,y
	lda #$00
	sta $0860,y
	sta $0861,y
	sta $0862,y	
	sta $0863,y	
	sta $0864,y
	sta $0865,y	
	sta $09a0,x
	sta $09a1,x
	iny
	iny
	iny
	iny
	iny
	iny
	inx
	inx
	cpx #$0020
	bne .loop2


;org $e5f694
blank_bg1:
		PHY			; Push Y
		ldx #$4000  ; Vram address
		stx $2116   ; Set
		ldx $00     ; Clear X
.blank	ldy #$242e  ; Palette and tilemap tile
		sty $2118   ; Set
		inx         ; In x
		cpx #$0200  ; Blank all BG1?
		bne .blank  ; Branch if not
		
; Build BG1
		
		ldx #$4066	; Vram address $8000
		lda #$20	; Load Increment Vram address value
		sta $00fe	; Store
		lda	$00		; Clear A lo-byte
		ldy #$2400	; Palette and tilemap tile
text:	stx $2116	; Set Vram address 
.text	sty $2118	; Set tile	
		iny			; Inc tilemap
		inc			; Inc counter
		cmp #$0d	; 1 row done?
		bne .text	; Branch if not
		rep #$20	; 16-bit a
		txa			; X->A (40X2)
		clc			; Prepare adc
		adc $00fe	; Add $0020 to A 
		tax			; A->X
		lda $00		; Clear A
		sep #$20	; 8-bit A
		iny			; Inc Y
		iny			;	^
		iny			;	^ go in the new line
		cpx #$40c6	; Done 4th row?
		bne text
		
; In loving memory....
		ldx #$40e5	; Vram address
		lda	#$00	; Clear A lo-byte
		ldy #$2470	; Palette and tilemap tile
text2:	stx $2116	; Set Vram address 
.text	sty $2118	; Set tile	
		iny			; Inc tilemap
		inc			; Inc counter
		cmp #$0f	; done?
		bne .text	; Branch if not

		ldx #$4104	; Vram address
		lda	#$00	; Clear A lo-byte
text3:	stx $2116	; Set Vram address 
.text	sty $2118	; Set tile	
		iny			; Inc tilemap
		inc			; Inc counter
		cmp #$11	; done?
		bne .text	; Branch if not

text4:	ldx #$4128	; Vram address $A000
		stx $2116
		lda	#$00	; Clear A lo-byte
		ldy #$2490	; Palette and tilemap tile
.text	sty $2118	; Set tile	
		iny			; Inc tilemap
		inc			; Inc counter
		cmp #$08	; done?
		bne .text	; Branch if not				
		ldy #$6490
		sty $2118
				
; Build BG2
		
		ldx #$5000	; Vram address $A000
		txa			; Clear A lo-byte
again:	ldy #$2c30	; Palette and tilemap tile
		phy			; Push for after
wave:	stx $2116	; Set Vram address 
.wave	sty $2118	; Set tile	
		iny			; Inc tilemap
		inc			; Inc counter
		cmp #$10	; 1 row done?
		bne .wave	; Branch if not
		rep #$20	; 16-bit a
		txa			; X->A (50X0)
		clc			; Prepare adc
		adc $00fe	; Add $0020 to A 
		tax			; A->X
		lda $00		; Clear A
		sep #$20	; 8-bit A
		cpx #$5080	; Done 4th row?
		beq .next	; Second round
		cpx #$5100	; Done all GFX?
		beq .end	; Branch if so
		bne wave	; Otherwise another row
.next	sty $2118	; Print last to build sky beneath word
		ply			; Restore origina tilemap byte
		bra wave	; 2nd round
.end	
		ldx #$5090	; Vram address $A000
		lda #$00	; Clear A lo-byte
again2:	ldy #$2c98	; Palette and tilemap tile
wave2:	stx $2116	; Set Vram address 
.wave	sty $2118	; Set tile	
		iny			; Inc tilemap
		inc			; Inc counter
		cmp #$04	; 1 row done?
		bne .wave	; Branch if not
		rep #$20	; 16-bit a
		txa			; X->A (50X0)
		clc			; Prepare adc
		adc $00fe	; Add $0020 to A 
		tax			; A->X
		lda $00		; Clear A
		sep #$20	; 8-bit A
		cpx #$50d0	; Done 2nd row?
		beq .next
		cpx #$5110
		beq .end
		bne wave2
.next	ldy #$2c98
		bra wave2
.end	ply
		
padbyte $ea
pad $e5f7a8		
warnpc $e5f7a8




org $e5fa4c
	cpy #$0080		; Extending wave effect

org $c9fe00
	incbin "../gfx/c9fe00_the_end.bin"

org $e96300
	incbin "../gfx/e96300_the_end.bin"