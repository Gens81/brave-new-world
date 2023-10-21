arch 65816
hirom

org $c3031c
	jsl change_palette_fft

; Keep Magic Icon white	in btl menu
org $C165F3
	jsl btl_palette

; Keep Item icon white in btl menu
org $C16578
	jsl icon_btl_palette

; Keep Lore icon white in btl menu
org $C16670
	jsl lore_btl_palette

org $C4B6d9
change_palette_fft:
	cmp #$ED			; Cmp if icon
	BCS	no_change_fft	; grater or equal?
	cmp #$D0
	BEQ change_fft
	cmp #$D7
	BCC no_change_fft
change_fft:	
	LDA #$38
	BRA color_change_fft
no_change_fft:	
	lda $29
color_change_fft:	
	sta [$eb],y
	rtl
warnpc $C4B6EE


org $D095F0
lore_btl_palette:
	lda $E6f7e5,X
	bra line_skipped
icon_btl_palette:
	lda $d2b300,x	; Load letter
	bra line_skipped
btl_palette:
	lda $effc00,x	; Load letter
line_skipped:
	cmp #$ED		; Cmp if icon
	BCS	letter		; grater or equal?
	cmp #$D7
	BCC letter
	XBA				; Change HI with LO bytes
	LDA #$35		; Load #$39 and load white color palette
	XBA				; Change Hi with LO byte
	RTL
letter:
	XBA				; Change HI with LO bytes
	LDA $56			; Load palette and bring back user color palette
	XBA				; Change Hi with LO byte
	RTL
	
; Change palettes subroutine
	
back_from_magic:
	
	jsr grey_palette
	jml $c156e9

back_from_throw:
	jsr grey_palette
	jml $c156e0

back_from_item:
	stz $7baf
	stz $7bb5
	jsr grey_palette+2
	rtl

back_from_tool:
	jsr grey_palette
	LDA #$21	
	STA $7BF0
	TDC 
	JML $C15A2C

back_from_rage:
	jsr grey_palette
	jsl $c18a14
	rtl
	
use_something:
	jsr grey_palette
	lda $7a84
	rtl

go_in_sub_menu:
	inc $96
	inc $2f41
	jsr white_palette
	rtl

use_slot:
	jsr grey_palette
	lda $7b92
	rtl
	
use_magic:
	jsr grey_palette
	lda $7ae8
	beq .yes
	jml $c181c4
.yes
	jml $c181c8
	
exit_magic:
	inc $96
	stz $7B7D
	jsr white_palette
	rtl

	
; Grey Palette

grey_palette:
	inc $96
	phx
	tdc
	tax
.loop
	lda Grey+2,x
	sta $7E2A,X
	inx
	cpx #$0004
	bne .loop 
	plx
	rts

; White palette

white_palette:
	phx
	tdc
	tax
.loop
	lda white_fft+2,x
	sta $7E2A,X
	inx
	cpx #$0004
	bne .loop 
	plx
	rts

	
org $c0814e
	jmp changeshadow_fft
	nop
	nop
	nop
user_color:
	STA $7E7404
	LDA $1D55
white_color:
	STA $7E7202
	STA $7E7402
	STA $7E7206
	STA $7E7406

	
warnpc $c0816B

		
org $c0de00
	
changeshadow_fft:
	lda $0564
	bne .white
	lda #$4210		; set light gray color (default color used in the small font palette)
	sta $7e7204
	jmp user_color
.white
	lda $00
	sta $7e7204
	sta $7e7404
	stz $0100
	LDA #$7fff
	jmp white_color

; Btl quotes shadow	
org $C199AC
	ldx #$4210

; Output all save files
org $C31632
    JSR $6C60      ; Load grayscale
    LDA #$20        ; Channel: 5
    TRB $43         ; Halt HDMA-5
    LDY #$0002      ; Y: 2
    STY $37         ; Set BG1 Y-Pos
    LDY $1D55       ; User font color
    STY $E7         ; Memorize it
    LDY #$0ca6      ; Color: brown
    STY $1D55       ; Set user's font
         
; Fork: Reset font color
org $C3239B
    LDY #$0ca6      ; Color: brown
    STY $1D55       ; Put in options

; Reset game data for Load menu
org $C3709E
    LDY #$0ca6      ; Color: brown
	
org $D8E7d0 ; Extending palette
MenuPalette_fft:
;   BCG  Shadow --- Colour
; 1st row
dw $0000,$4210,$39CE,$0CA6		;User editable color 
dw $0000,$0000,$2108,$3DEF		;Grey font for unavailable choiches
dw $0000,$4210,$39CE,$3544		;Yellow font
dw $0000,$4210,$39ce,$10cd		;Dark Red font 

; 2nd row
dw $0000,$4210,$39ce,$10cd		;Dark Red font
dw $0000,$7fff,$4210,$7fff		;Should be white -> 7fff should be rplaced by user font in game. 3rd code is the VWF description shadow
white_no_box:
dw $0000,$0000,$39ce,$7fff		;White font
dw $0000,$0000,$39ce,$6f60		;Light blue font

; 3rd row
dw $0000,$0000,$2108,$3def		;Gray font
dw $0000,$0000,$2108,$3def		;Gray font
dw $0000,$0000,$2108,$3def		;Gray font
dw $0000,$0000,$2108,$3def		;Gray font

; 4th row

dw $0000,$3c00,$2108,$3def		;Gray font with blue shadow (Esper equipped from other actor)
dw $0000,$3868,$39ce,$7fff		;Gray font with purple shadow
dw $0000,$3868,$39ce,$7fff		;Gray font with purple shadow
dw $0000,$3868,$39ce,$7fff		;Gray font with purple shadow

; 5th row
Grey:
dw $0000,$4210,$5294,$7fff		;White font with gray shadow
dw $0000,$4210,$5294,$7fff		;White font with gray shadow
dw $0000,$0000,$39ce,$7fff		;White font with black shadow
dw $0000,$4210,$5294,$7fff		;White font with gray shadow

; 6th row
Yellow_fft:
dw $0000,$4210,$39ce,$3544		;Yellow font (esper bonus points)
dw $ffff,$ffff,$ffff,$ffff		;Null
dw $ffff,$ffff,$ffff,$ffff		;Null
dw $ffff,$ffff,$ffff,$ffff		;Null

;7th row
white_fft:
dW $0000,$0000,$39ce,$7fff		;White font

; Btl Palette
org $EEB15F
dw $0000,$4210,$5294,$7fff		;User Color


Org $c36bee
	rep #$20			; 16 bit A
	lda MenuPalette_fft,x	; Load Palette Data
	sta $7e3049,x		; Store in RAM
	sep #$20			; 8 bit A
	sta $2122			; Put LB in CGRAM
	xba					; Switch to HB
	sta $2122			; Put HB in CGRAM
	inx					; Index +1
	inx					; Index +1
	cpx #$00C8			; Set 88 colors

org $C4b4f0
C4B500_fft:
	phx
	ldx $00
pick_color_fft:
	LDA Yellow_fft,x
	sta $7E30E9,x
	inx
	cpx #$0008
	bne pick_color_fft
	plx
	rtl

; Init Main menu - Load white for glyphs	
org $C31AD3
	jmp glyphs_fft
org $C38E29	
	glyphs_fft:
	phx
	ldx $00
pick_white_color_fft:
	LDA white_fft,x
	sta $7E3109,x
	inx
	cpx #$0008
	bne pick_white_color_fft
	plx
	JSR $A9A9      ; Upload elements
	JSR $1BA8	   ; Go to unfreeze CGRAM and refresh and allow to load portrait GFX
	JMP $3541      ; BRT:1 + NMI
	

;-------------------------------------------
;
; Change palette on the fly in battle menu
;
;-------------------------------------------

;Press B in Magic menu? (change to grey)
org $c181f1   
	jml back_from_magic
	nop
	
warnpc $c181f6


; Press B in Throw menu? (change to grey)
org $c1872f
	jml back_from_throw
	nop
	
warnpc $c18734


; Press B in Item Menu? (change to grey)

org $C1894C
	jsl back_from_item
	nop
	nop
	
warnpc $c18952

; Press B in tool menu? (change to grey)

org $c1881C
	jml back_from_tool
	nop
	rts

org $c18524
	jsl back_from_rage
	nop
	
org $c18a14
	jsr $5704
	rtl
	
	
; Press A in Throw menu and throw/use a tool/launch a magic (Change to grey palette)

org $c16f09
	jsl use_something
	nop
	
; Press A and enter in sub menu (Change to white palette)

org $c17bff
	jsl go_in_sub_menu
	nop

; Use slot (Change to grey palette)
org $c17f1a
	jsl use_slot
	nop

; Use Magic
org $c181bf
	jml use_magic
	
; Exit Magic

org $c16f55
	jsl exit_magic
	nop

; New checkmark	
Org $C3FD5E
	LDX $00					; clear x
next_value:
	LDA.l new_checkmark,x   ; load checkmark value
	STA $2180               ; send to vram
	INX                     ; inc index
	CPX #$0005              ; loop finish?
	BNE next_value          ; pick next value to print
	STZ $2180               ; stop 
	JMP $7FD9               ; prepare print

new_checkmark:
	db $60                  ; 1st Tile
	db $61                  ; 2nd Tile
	db $62                  ; 3rd Tile
	db $63                  ; 4th Tile
	db $64                  ; 5th Tile

warnpc $C3FD79


	
