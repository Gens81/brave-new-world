arch 65816
hirom

table "menu.tbl", ltr


;#########################################################################;
;                                                                         ;
;	Esper menu redefined                                                  ;
;                                                                         ;
;#########################################################################;

; Initialize esper data menu

org $c358c1
	JSL C34E2D      ; Load V-shift data
	nop
	TRB $46         ; Set anim index
	JSR $597D       ; Load navig data
	JMP $5986       ; Relocate cursor

org $c3592a
	lda #$0068		; blinking cursor whe exit submenu

; Load vertical shift values for BG1 text in skill menus
org $c0ec20
C34E2D:	LDX $00         ; Index: 0
C34E2F:	LDA.L C34E7F,X  ; Stats V-Data
		STA $7E9849,X   ; Save in RAM
		INX             ; Index +1
		CPX #$0012      ; At skills?
		BNE C34E2F      ; Loop if not
C34E3D:	LDA.L C34E7F,X  ; Skill V-Data
		STA $7E9849,X   ; Save in RAM
		INX             ; Index +1
		TDC             ; Clear A
		LDA $49         ; Top BG1 row
		ASL A           ; x2
		ASL A           ; x4
		ASL A           ; x8
		ASL A           ; x16
		AND #$FF        ; ...
		REP #$20        ; 16-bit A
		CLC             ; Prepare ADC
		ADC.L C34E7F,X  ; Add V-Data
		STA $7E9849,X   ; Save in RAM
		SEP #$20        ; 8-bit A
		INX             ; Index +1
		INX             ; Index +1
		CPX #$005A      ; Past list?
		BNE C34E3D      ; Loop if not
C34E63:	LDA.L C34E7F,X  ; Bottom V-Data
		STA $7E9849,X   ; Save in RAM
		INX             ; Index +1
		CPX #$005E      ; End of table?
		BNE C34E63      ; Loop if not
		LDA #$C0        ; Scrollbar: Off
		RTL

; BG1 V-Shift table for skill menus (condenses text)
C34E7F:	db $3F,$00,$00  ; LV
		db $0C,$04,$00  ; HP
		db $0C,$08,$00  ; MP
		db $0A,$0C,$00  ; Nothing
		db $01,$0C,$00  ; Nothing
		db $0D,$08,$00  ; Nothing
		
		db $04,$94,$FF  ; Ability row A
		db $04,$94,$FF  ; Ability row B
		db $04,$94,$FF  ; Ability row C
		db $08,$98,$FF  ; Ability row D
		db $08,$98,$FF  ; Ability row E
		db $08,$9c,$FF  ; Ability row F
		db $08,$a0,$FF  ; Ability row G
		db $04,$a0,$FF  ; Ability row H
		db $04,$a0,$FF  ; Ability row I
		db $04,$A4,$FF  ; Ability row J
		db $04,$A4,$FF  ; Ability row K
		db $08,$b0,$FF  ; Ability row L
		db $08,$A8,$FF  ; Ability row M
		db $0c,$ac,$FF  ; Ability row N
		db $10,$b0,$ff  ; Ability row O
		db $0c,$Ae,$FF
		db $00         ; End 


; which number option finger cursor allow EL bonus
org $C33BE2
	cmp #$04		; row index description msg bouns print

org $C33BE9
	jmp SummonDescription
	
; ------------------------------------------------------------------------
; Helper for Summon Descriptions (in freespace)

org $C3f46B           ; 29 bytes, we'll use 24 >.>
SummonDescription:    ; Load Esper summon description
  LDX #$FE40 
  STX $E7             ; Set ptr loc LBs
  LDX #$3940
  STX $EB             ; Set text loc LBs
  LDA #$CF            ; Pointer/text bank
  STA $E9             ; Set ptr loc HB
  STA $ED             ; Set text loc HB
  LDA #$10
  TRB $45             ; Description: On
  RTS                 ;   It expects (in a roundabout way) this value to be in the X
                      ;   register in the event a character tries to equip an Esper
                      ;   that doesn't belong to them, because it needs an offset to
                      ;   a region of memory where there will be a large swath of
                      ;   values below #$80 /shrug
warnpc $c3f480

					  
org $C3876B 
padbyte $FF : pad $C3877F

; Fork: Esper effect
org $C35C09 
	LDX #EsperDescPointers      ; CF/FE40
	STX $E7         ; Set ptr loc LBs
	LDX $00     	 ; CF/3940
	STX $EB         ; Set text loc LBs
	LDA #$CB        ; Bank: CF
	STA $E9         ; Set ptr loc HB
	LDA #$CB        ; ...
	STA $ED         ; Set text loc HB
	RTS

org $c3fd96
DrawEsperMP:
  LDA #$FF
  STA $2180         ; 3 spaces
  STA $2180
  STA $2180
  STZ $2180         ; EOS
  RTS
padbyte $FF : pad $C3fdd1
warnpc $c3fdd1
	
org $c3f7b6
	cmp #$04		; on which row bonus must be given to actor
org $c35a18
	jsr $7fd9		; In Vanilla go to a C35a84 routine that print learning percentage - in BNW JMP $C37fd9 is set at destination address 
	
	
org $c35a24
	CMP #$0017      ; How many spell must be print

org $C35a29
; Fork: Draw esper bonus message
	SEP #$20        ; 8-bit A
	LDA $D86E00,X   ; Esper bonus
	CMP #$FF        ; None?
	BEQ C35A67      ; Blank if so
	STA $4202       ; Set multiplicand
	LDA #$09        ; Text length
	STA $4203       ; Set multiplier
	jsr $f382		; Write Unspent, Available EL and set EL word next to q.ty
	jsr $7fd9		; Draw spend q.ty string
	ldy #$4793		; Bonus string Pos
	jsr $3519		; Set pos, Wram
	LDX $4216       ; Index product
	LDY #$0009      ; Letters: 9
loop:
	LDA $CFFEAE,X   ; Bonus char
	STA $2180       ; Add to string
	INX             ; Point to next
	DEY             ; One less left
	BNE loop		; Loop till last
	STZ $2180       ; End string
	LDA $7e4412		; Esper colour
	cmp #$28		; Grey?
	beq C35A67		; Unavailable EL so branch
	lda #$20		; User colour
C35A67:
	sta $29			; Set colour
	JMP $7FD9       ; Draw string
	
padbyte $ff
pad $c35ae1
warnpc $c35ae1


;Inserted in another asm C3/FC20 - C3/F277

;org $c3f430		
;	ldy #$4711			; El bonus position
;	JSR $3519			; Set pos, WRAM
;	bra new_print
;back:
;	rts
;
;warnpc $c3f43b
;
;org $c3f46b
;new_print:
;	jsl print_new		; go to load string
;	jsr $7fd9			; Draw string
;	jsl print_new2		; go to load string
;	bra back
	
;org $c0ed10
;print_new:
;	lda #$24			; blue color
;	sta $29				; store
;	LDX $00				; Char index: 0
;.loop
;	LDA.L EL_Bonus,X	; "EL Bonus" char
;	STA $2180			; Add to string
;	INX					; Point to next
;	CPX #$0009			; Done all 14?
;	BNE .loop			; Loop if not
;	STZ $2180
;	rtl
;	
;print_new2:	
;	ldy #$47bb			; "EL text" bottom position
;	JSR PosWRAM			; Set pos, WRAM
;	LDX $00				; Char index: 0
;.loop2
;	LDA.L ELavlbl,X		; "At..." char
;	STA $2180			; Add to string
;	INX					; Point to next
;	CPX #$0002			; Done all?
;	BNE .loop2			; Loop if not
;	STZ $2180
;	rtl
;
;ELavlbl: db "EL",$00
;
;
;PosWRAM:
;	LDX #$9E89      ; 7E/9E89
;	STX $2181       ; Set WRAM LBs
;	REP #$20        ; 16-bit A
;	TYA             ; Tilemap ptr
;	SEP #$20        ; 8-bit A
;	STA $2180       ; Set position LB
;	XBA             ; Switch to HB
;	STA $2180       ; Set position HB
;	TDC             ; Clear A
;	LDY $67         ; Actor address
;	RTS
;

;org $c3f30f
;available:	db "  Unspent",$00
;warnpc $c3f31b

;org $c3f3f2
;	ldy #$472F			; available position
;org $C3F3FA
;	LDA.l available,X 	; get "available" txt

org $c3599f :	lda #$24
org $c359a3	:	ldy #learnlabel
org $c359a9	:	ldy #splabel
org $c3fd7c	:	ldy #thirty

org $C35Ca7
splabel:	dw $462f : db "SP",$00
learnlabel:	dw $4435 : db " Learn",$00
thirty:		dw $463B : db "/30",$00
EL_Bonus:	db "EL Bonus ",$00				;fd86

org $C3F41A 
	LDY #$47b5	; Unspent EL quantity coordinates
	
org $c3f751
	ldx #$4637	; unspent SP quantity coordinates
	
; Navigation data for esper data menu
org $C3598C
	db $80          ; Wraps vertically
	db $00          ; Initial column
	db $00          ; Initial row
	db $01          ; 1 column
	db $05          ; 6 rows
	
; Cursor positions for esper data menu
org $C35991
	dw $7210        ; Esper
	dw $7e18        ; Spell A
	dw $8a18        ; Spell B
	dw $9618        ; Spell C
	dw $c418        ; Bonus
	dw $c810        ; 
	dw $B818        ; 

; rearrange esper code to avoid redundant text on screen
org $d86e00
	db $01,$02,$0f,$07,$0a,$16,$0c,$0c,$ff,$ff,$0c
	db $01,$00,$0f,$05,$0a,$18,$0d,$0d,$ff,$ff,$0d
	db $01,$01,$0f,$06,$0a,$26,$0f,$0f,$ff,$ff,$0f
	db $0a,$1a,$0a,$20,$0f,$33,$06,$06,$ff,$ff,$06
	db $0a,$18,$14,$0c,$19,$1e,$00,$00,$ff,$ff,$00
	db $05,$03,$0f,$04,$0f,$0d,$0f,$0f,$ff,$ff,$0f
	db $05,$1c,$0a,$1b,$0f,$08,$08,$08,$ff,$ff,$08
	db $0a,$11,$0a,$34,$0a,$30,$0c,$0c,$ff,$ff,$0c
	db $0a,$1f,$0a,$1d,$0a,$29,$0e,$0e,$ff,$ff,$0e
	db $0a,$29,$0f,$24,$19,$27,$05,$05,$ff,$ff,$05
	db $14,$09,$14,$0a,$19,$0b,$0e,$0e,$ff,$ff,$0e
	db $14,$10,$19,$12,$00,$ff,$0e,$0e,$ff,$ff,$0e
	db $00,$ff,$00,$ff,$00,$ff,$0e,$0e,$ff,$ff,$0e
	db $14,$13,$19,$0f,$00,$ff,$01,$01,$ff,$ff,$01
	db $0a,$16,$14,$17,$19,$15,$00,$00,$ff,$ff,$00
	db $1e,$14,$00,$ff,$00,$ff,$01,$01,$ff,$ff,$01
	db $19,$0e,$00,$ff,$00,$ff,$09,$09,$ff,$ff,$09
	db $01,$2d,$0f,$2e,$0a,$30,$0a,$0a,$ff,$ff,$0a
	db $0f,$2a,$14,$19,$00,$ff,$04,$04,$ff,$ff,$04
	db $0a,$21,$0a,$28,$0f,$23,$0b,$0b,$ff,$ff,$0b
	db $05,$2c,$0a,$29,$0f,$24,$07,$07,$ff,$ff,$07
	db $0a,$34,$0f,$2e,$19,$32,$02,$02,$ff,$ff,$02
	db $0a,$26,$0f,$22,$00,$ff,$03,$03,$ff,$ff,$03
	db $05,$2b,$0f,$2e,$0f,$33,$0a,$0a,$ff,$ff,$0a
	db $0a,$34,$0f,$2a,$19,$25,$0d,$0d,$ff,$ff,$0d
	db $0f,$33,$14,$2f,$19,$35,$0e,$0e,$ff,$ff,$0e
	db $14,$09,$14,$2f,$19,$31,$02,$02,$ff,$ff,$02
	db $ff,$ff,$ff,$ff,$ff,$ff,$ff,$c2
	db $20,$e0,$9e,$07,$f0,$0d,$e0,$da
	db $07,$f0,$08,$bf,$01,$50,$d8,$5c
	db $97,$9b,$c3,$5c,$a3,$9b,$c3,$a9
	db $00,$00,$e0,$9e,$07,$f0,$1d,$e0
	db $da,$07,$f0,$18,$e0,$28,$14,$f0
	db $13,$e0,$0a,$14,$f0,$0e,$e0,$46
	db $14,$f0,$09,$e0,$82,$14,$f0,$04
	db $bf,$01,$50,$d8,$5c,$30,$55,$c2


; Navigation data for Espers menu
org $C34C27
	db $01          ; Wraps horizontally
	db $00          ; Initial column
	db $00          ; Initial row
	db $02          ; 2 columns
	db $08          ; 8 rows

; Cursor positions for Espers menu
org $C34C2C
	dw $7208        ; Esper 1
	dw $7278        ; Esper 2
	dw $7e08        ; Esper 3
	dw $7e78        ; Esper 4
	dw $8a08        ; Esper 5
	dw $8a78        ; Esper 6
	dw $9608        ; Esper 7
	dw $9678        ; Esper 8
	dw $A208        ; Esper 9
	dw $A278        ; Esper 10
	dw $ae08        ; Esper 11
	dw $ae78        ; Esper 12
	dw $Ba08        ; Esper 13
	dw $Ba78        ; Esper 14
	dw $C608        ; Esper 15
	dw $C678        ; Esper 16

; shrink esper list by 1 line to have just 26 slots for 26 total espers

org $C320D0
	LDA #$05        ; Top row: Carbuncle's
	STA $5C         ; Set scroll limit

org $C320BA        
	LDA #$1300      ; V-Speed: 19 px
	STA $7E354A,X   ; Set scrollbar's
	
org $c35950	
	LDA #$05        ; Top row: Carbuncle's
	STA $5C         ; Set scroll limit

org $c35923
	LDA #$1300      ; V-Speed: 19 px
	STA $7E354A,X   ; Set scrollbar's
	
; -----------------------------------------------------------------------------
; Synopsis: Enables batch spending of SP/EL instead of having to reopen the
;           esper submenu for every single expenditure
;     Base: BNW 2.2b14
;   Author: Fëanor
; Creation: 2023-05-16
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Description
; -----------------------------------------------------------------------------
; This hack consists of a primary and an auxiliary splice. The primary splice
; overwrites the following jump instruction
;
;   JMP $5913     ; exits back out to the esper selection menu
;
; within the routine that handles spending SP and EP in two places. Instead of
; returning to the esper selection menu, the screen is redrawn by calling
;
;   JSR $599F     ; draw esper info
;   JSR $0F11     ; queue its upload
;   JMP $1368     ; upload it now
;
; This change alone, however, is not sufficient to do a proper redraw! When
; drawing the esper submenu, the last stored pointer index ($4B) is used to
; determine which esper is currently selected. As the pointer index has since
; been updated, the wrong esper info will be drawn on screen.
;
; To fix this, an auxiliary splice is inserted into the routine that handles
; the esper selection. It stores the pointer index of the selected esper in
; scratchpad RAM which is then retrieved in the primary slice to set the
; correct pointer index before doing the redraw.
; -----------------------------------------------------------------------------

!free_a = $C3F4AA     ; 7 bytes of free space in C3 required
!warn_a = !free_a+7   ; 7 bytes available

!free_b = $C3F6D2     ; 13 bytes of free space in C3 required
!warn_b = !free_b+14  ; 14 bytes available

!index  = $4B         ; holds pointer index
!tmp    = $98         ; used to temporarily store pointer index

; -----------------------------------------------------------------------------
; Handle esper selection
; -----------------------------------------------------------------------------
; C3/28D3:
;   ...
;   ...
;   CMP #$FF               ; None?
;   BEQ $2908              ; Unequip if so
;   STA $99                ; Memorize esper
org $C32900
    JSR SelectEsperSplice  ; perform splice after selecting esper
;   LDA #$4D               ; C3/58CE
;   STA $26                ; Next: Data menu
;   RTS
; -----------------------------------------------------------------------------
; brave-new-world/asm/banks/c3.asm
; -----------------------------------------------------------------------------
; Pressed_A:
;   ...
;   ...
;   SEP #$20            ; 8-bit A
;   LDA #$FF            ; "learned"
;   STA $1A6E,X         ; set spell learned
org $C3F80C
    JMP SpendingSplice  ; perform splice after spending SP
; .nope
; BzztPlayer:
;   JMP $0EC0           ; sound: Bzzt
;   ...
;   ...
;   JSL Do_Esper_Lvl    ; and apply esper boost
;   JSR $0ECE           ; sound: "cha-ching"
;   JSR $4EED           ; redraw HP/MP on the status screen
org $C3F84C
    JMP SpendingSplice  ; perform splice after spending EL
; -----------------------------------------------------------------------------

org !free_a
SelectEsperSplice:
    LDA !index      ; load pointer index
    STA !tmp        ; store it
    JMP $5897       ; init submenu
warnpc !warn_a

org !free_b
SpendingSplice:
    LDA !tmp        ; retrieve stored pointer index
    STA !index      ; restore pointer index
    JSR $599F       ; draw esper info
    JSR $0F11       ; queue its upload
    JMP $1368       ; upload it now
warnpc !warn_b
