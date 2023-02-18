arch 65816
hirom

table "menu.tbl", ltr ; Tabella per le stringhe di testo

;;--------------------------------------------------
;;Item box dimension
;;	First value: Start print position X assis
;;  Second value: Start print position Y assis
;;	Third value: Height
;;	Fourth value: Lenght
;;--------------------------------------------------

org $C37E13
	db $8B,$58,$04,$01	;Item window
	db $97,$58,$16,$01	;Use_Arrange_Rare window
	db $4b,$59,$1c,$02	;Description window
	db $4b,$5a,$1c,$11	;Item List window
	
;;--------------------------------------------------
;;Cursor position
;;	First: Y Assis
;;	Second value: X Assis
;;--------------------------------------------------

org $C37D9D

;Use
dw $0f40

;Arrange
dw $0f68

;Rare
dw $0fb0

; Load navigation data & Handle D-Pad for Item, Colosseum, or Sell menu

org $C37D1C
	LDY #Navigation_Data 	; C3/7D2B
	JMP $05FE				; Load navig data
	JSR $81C7				; Handle D-Pad
	LDY #Cursor_Position	; C3/7D30
	JMP $0648				; Relocate cursor
	
padbyte $FF
pad $c37d43

; Cursor positions for rare item menu
org $C37D58
	dw $4a08        ; Item 1
	dw $4a78        ; Item 2
	dw $5608        ; Item 3
	dw $5678        ; Item 4
	dw $6208        ; Item 5
	dw $6278        ; Item 6
	dw $6e08        ; Item 7
	dw $6e78        ; Item 8
	dw $7a08        ; Item 9
	dw $7a78        ; Item 10
	dw $8608        ; Item 11
	dw $8678        ; Item 12
	dw $9208        ; Item 13
	dw $9278        ; Item 14
	dw $9e08        ; Item 15
	dw $9e78        ; Item 16
	dw $aa08        ; Item 17
	dw $aa78        ; Item 18
	dw $b608        ; Item 19
	dw $b678        ; Item 20
	
	
; HDMA Tables
; First Value are the scanlines

; BG1 H-Shift table for inventory-style menus
org $C37EDA
	db $1C,$00,$01  ; Value to change for moving up the scroll menu
	db $2F,$00,$01  ; Value to change for moving up the scroll menu
	db $80,$00,$00  ; Items
	db $1E,$00,$01  ; Nothing
	db $00          ; End

; BG1 V-Shift table for inventory-style menus
;org $C37EE7
	db $17,$80,$00  ; Value to change for moving up the scroll menu
	db $08,$00,$00  ; Nothing?
	db $0C,$04,$00  ; Nothing?
	db $0C,$08,$00  ; Nothing?
	db $08,$80,$00  ; Nothing?
	db $08,$00,$00  ; Nothing?
	db $04,$bC,$FF  ; Item row 1
	db $04,$bC,$FF  ; 
	db $04,$bC,$FF  ; 
	db $04,$c0,$FF  ; Item row 2
	db $04,$c0,$FF  ; 
	db $04,$c0,$FF  ; 
	db $04,$c4,$FF  ; Item row 3
	db $04,$c4,$FF  ; 
	db $04,$c4,$FF  ; 
	db $04,$c8,$FF  ; Item row 4
	db $04,$c8,$FF  ; 
	db $04,$c8,$FF  ; 
	db $04,$cC,$FF  ; Item row 5
	db $04,$cC,$FF  ; 
	db $04,$cC,$FF  ; 
	db $04,$d0,$FF  ; Item row 6
	db $04,$d0,$FF  ; 
	db $04,$d0,$FF  ; 
	db $04,$d4,$FF  ; Item row 7
	db $04,$d4,$FF  ; 
	db $04,$d4,$FF  ; 
	db $04,$d8,$FF  ; Item row 8
	db $04,$d8,$FF  ; 
	db $04,$d8,$FF  ; 
	db $04,$dC,$FF  ; Item row 9
	db $04,$dC,$FF  ; 
	db $04,$dC,$FF  ; 
	db $04,$e0,$FF  ; Item row 10
	db $04,$e0,$FF  ; 
	db $04,$e0,$FF  ; 
	db $04,$e4,$FF  ; Item row 11
	db $04,$e4,$FF  ; 
	db $04,$e4,$FF  ; 
;Closing table data
	db $1E,$00,$00  ; Nothing
	db $00          ; End


; Navigation data & Cursor positions for Item, Colosseum, and Sell menus

;C37D2B:
Navigation_Data:
	db $01          ; Wraps horizontally
	db $00          ; Initial column
	db $00          ; Initial row
	db $01          ; 1 column
	db $0B          ; 11 rows
;C37D30: 
Cursor_Position: 
	dw $4a08        ; Item 1
	dw $5608        ; Item 2
	dw $6208        ; Item 3
	dw $6e08        ; Item 4
	dw $7a08        ; Item 5
	dw $8608        ; Item 6
	dw $9208        ; Item 7
	dw $9e08        ; Item 8
	dw $aa08        ; Item 9
	dw $b608        ; Item 10
	dw $c208		; Item 11
	
padbyte $FF
pad $C37f87
warnpc $C37f87

org $c30854
	adc #$0A				; Extend blinking finger to 1 up line	

org $c37e35
	ldy #Item_Description	; Moving item descritpion HDMA data table in another section

org $c37f8b
	ldy #$000b				; How many lines must be loaded in the BG1 Tilemap

Org $c37ec6
	cpx #$007E				; BG1 V-Shift table size

org $c37ed4					; Closing Table data size
	cpx #$0082

org $C31af3
	LDA #$0B				; Onscreen rows: 11

org $c31b19
	lda #$0085				; Extend scroll triangle cursor
org $c31b20
	lda #$0046				; Triangle cursor starting point

org $c3265f
	lda #$0085				; Extend scroll triangle cursor (from USE ARRANGE RARE to scroll)
org $c32666
	lda #$0046				; Triangle cursor starting point (from USE ARRANGE RARE to scroll)

org $c3bc0a
	lda #$0085				; Extend scroll triangle cursor (Shop menu)
org $c3bc11
	lda #$0046				; Triangle cursor starting point (Shop menu)
	
org $c309b1
	adc #$0085				; ADD to complete below half cursor scroll


;;-----------------------------------------------------
;;
;;Colosseum
;;
;;-----------------------------------------------------

; Window layout for Colosseum item menu
org $C3AD8A
	dw $588B,$0109  ; 11x04 at $588B (Title)
	dw $58A1,$0111  ; 19x04 at $58A1 ("Select...")
	dw $594B,$021C  ; 30x05 at $598B (Description)
	dw $5A4B,$111C  ; 30x17 at $5ACB (Items)

; Positioned text for Colosseum
org $C3AD9A
	dw $78cd : db "Colosseum",$00
	dw $78e3 : db "Select an Item",$00

;Change words position
org $C3B251
    db $EB,$78        ;Right item
org $C3B261
    db $CD,$78        ;Left item

;Change box dimension
org $C3B33F
	db $8b,$58,$0d,$01	;Left Item
	db $a9,$58,$0d,$01	;Right Item

;Moving challenger data
org $c3aefa
	ldy #$7c51

org $C3B427
	db $cd,$78,"?????????????",$00
	
;Fix gradient scale

org $D4CB42
;upper side
	dw $e001,$e702,$e603,$e503,$e403,$e302,$e203,$e103
	dw $e003,$e102,$e201,$e301,$e401,$e501,$e601,$e701

;bottom side
	dw $e070,$ea01,$e903,$e804,$e704,$e604,$e504,$e404
	dw $e304,$e204,$e104,$e004,$e104,$e204,$e304,$e404
	dw $e504,$e604,$e704,$e804,$e904,$ea02

;;-----------------------------------------------
;;Inside item submenu
;;-----------------------------------------------
org $C3331e
	ldy #$391b		;1 Name position
	
org $C3336a
	ldy #$3a9b		;2 Name position

org $C333B6
	ldy #$3c1b		;3 Name position

org $c33402
	ldy #$3d9b		;4 Name position

;Windows sizes
;	first value x start assis print
;	second value y start assis print
;	third value wide sizes
;	fourth value height sizes
 
org $C38A3B
	db $9d,$58,$13,$18	;Stats window
	db $8b,$58,$0e,$01	;Item window
	db $4b,$59,$07,$03	;Owned window

org $C38A54
	db $cd,$78  	;Move Item name 1 line up

;------------------------------------------------------
;Hide rare counter item and expand description box
;------------------------------------------------------

org $c3837f 
    ldx #$7ac5        ;Set rare item counter out of bounds and hide it
    
org $c38e4a
    db $c5,$7a,$ff,$ff,$ff,$00    ;Set blank tile over the numbers


;------------------------------------------------------------------
;Cinematic&Title Program&GFX
;------------------------------------------------------------------
check bankcross off
org $C2686C
	incbin "../asm/C2686C_Cinematic_Program.bin"		;Cinematic Program
	
org $D8f000
	incbin "../asm/D8F000_Cinematic_Title_Isle_GFX.bin"	;Cinematic, Title, Isle GFX & Tilemap Properties
check bankcross on

;------------------------------------------------------------------
;New consumable icon
;------------------------------------------------------------------	
org $C326E3
.loop	
	lda.l icon,x	; load icon value
	phx         ; save X
	sta $e0     ; save value on e0
	jsr $2706   ; 
	plx         ; restore X
	inx         ; increase X
	cpx #$0012  ; all icon checked?
	bne .loop   ; branch if not
	rts         ; return
	
padbyte $FF
pad $C32706
warnpc $C32706

org $C0FF9A
icon:
	db $eb	;item
	db $e1	;rod
	db $db	;knife
	db $dc	;sword
	db $dd	;spear
	db $de	;claw
	db $df	;katana
	db $e0	;casino
	db $e2	;brush
	db $ec	;ranged
	db $e3	;other
	db $d8	;tool
	db $d9	;star
	db $da	;scroll
	db $e4	;shield
	db $e5	;helmet
	db $e6	;armor
	db $e7	;relic

warnpc $C32965

org $D26F8C
	db "Ranged "
;------------------------------------------------------------------
;Load empty tiles on category item in battle inventory
;------------------------------------------------------------------

org $c16534
  cmp #$EB
  
;------------------------------------------------------------------
;Fix equip menu gfx bug
;------------------------------------------------------------------	

org $C3906c
	LDY #draw_equip_box1
org $C39072
	LDY #draw_equip_box2
org $C39078
	LDY #draw_equip_box3
org $C3907E
	LDY #draw_equip_box4

; Moving 1 tile down all the bg2 tilemaps box & up by 6 pixel
; Set text position and load actor data address

org $C3946D  
	REP #$20        ; 16-bit A
	TXA             ; Tilemap ptr
	STA $7E9E89     ; Set position
	SEP #$20        ; 8-bit A
; Moving 6 pixels up bg2
	PHA
	LDA #$06
	STA $3B
	PLA
	JMP $93F2      ; Load address
; Load and draw equipped item's name 
	JSR $8FE1      ; Load item name
	JMP $7FD9      ; Draw item name
; Boxes Data
draw_equip_box1:
	db $8b,$5b,$1c,$0d
draw_equip_box2:
	db $8b,$58,$1c,$0a
draw_equip_box3:
	db $8b,$58,$1c,$01
draw_equip_box4:
	db $8b,$58,$06,$01

warnpc $c39496

org $c39edc
	jmp $947f
org $c39efa
	jmp $947f
org $c3940d
	jmp $947f
org $c3916e
	jmp $947f
org $c3918c
	jmp $947f
org $c391a9
	jmp $947f

;Fixed Dumpty script (conditional Safe>Shell)

org $CF95C0
db $15

;Deleted Intangir from formation 338 2nd slot to avoid transfering its weaknesses to Intangir Z

org $CF75D1 
db $FF

org $CF75D7
db $00

;Wounded
org $C3371B
	db " KO    "

;scroll fixing on lore menus

org $C32175
	LDA #$1800	;v-speed 24 pixel

org $C3218B
    LDA #$04	;scroll limit at line 12 (Tsunami)

; Lore Battle Menu

org $C18336 : CMP #$08    ; lore menu length 12 (4 shown on first page + 8 scrolling)
org $C1838F : LDA #$08    ; lore menu scrollbar flash
org $C18393 : LDX #$0500  ; scrollbar reaching the end of the menu correctly

;Adding Muddle to Siren Song

org $C46DE9
	db $30

;Fix to totally drain Serpent Trench water pool

org $CA8AD5
	db $F7

;;Mute magitek sound in Cyan's dream
;org $CB93EF
;	db $FD,$FD
;org $CB93F8
;	db $FD,$FD
;org $CB9400
;	db $FD,$FD
;org $CB9408
;	db $FD,$FD
;org $CB9410
;	db $FD,$FD
	
;Changing element tiles to print in inventory sub-menu

org $D8E90E
	db $FD,$FA,$F6,$F9,$EF,$F8,$FB,$FC,$00		; water, earth, holy, wind, dark, bolt, ice, fire
	
; Mosaic effect mitigation

org $C00E82  
	db $0F, $1F, $2F, $3F, $2F, $1F, $2F, $3F, $2F, $1F, $2F, $3F, $2F, $1F, $2F, $3F, $2F, $1F, $2F, $3F, $2F, $1F, $2F, $3F, $2F, $1F, $2F, $3F, $2F, $1F
	
; fix an hard to trigger bug that can softlock the game moving char sprite offscreen

org $CACBAD
	db $FD

; centered "save" on save/load game screen

org $C31600
	dw #Savesave
	
org $C31A24	
Savesave:
	db $65,$79,"Save",$00

;Brave New World data
org $C33BB8
	db $d1,$78,"Brave New World 2.2 b14",$00
