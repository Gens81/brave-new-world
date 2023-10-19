arch 65816
hirom

table "menu.tbl", ltr ; Tabella per le stringhe di testo

; Window layout for Sell menu and main shop menu
org $C3BC1B
	dw $588B,$0107  ; 09x04 at $588B (Title)
	dw $589D,$0113  ; 21x04 at $589D (Dialogue)
	dw $594B,$0210  ; 18x04 at $598B (Options)
	dw $596F,$020A  ; 12x04 at $59AF (GP)
	dw $5A4B,$111C  ; 30x18 at $5A8B (Items)

; Window layout for Buy menu
	dw $608B,$0107  ; 09x04 at $608B (Title)
	dw $609D,$0113  ; 21x04 at $609D (Dialogue)
	dw $614B,$0d1c  ; 30x14 at $618B (Items)
	dw $650B,$061c  ; 30x08 at $650B (Actors)

; Window layout for shop order menus
	dw $688B,$0107  ; 09x04 at $688B (Title)
	dw $689D,$0113  ; 21x04 at $689D (Dialogue)
	dw $694B,$0711  ; 19x09 at $698B (Item)
	dw $6B8B,$041C  ; 30x05 at $6BCB (Description)
	dw $6D0B,$061C  ; 30x08 at $6D0B (Actors)
	dw $6971,$0709  ; 11x09 at $69B1 (Amounts)

; Window layout for shop "Hold Y" menu
org $C3fbb4
	dw $714b,$071c	; Title
	dw $750b,$061c	; Values
	dw $708b,$011c	; Description
	dw $738b,$041c	; Actors

; BG3 text shifting table for shop
Org $C3C037
	db $1F,$08,$00  ; Title
	db $08,$08,$00  ; Item 1
	db $0C,$0C,$00  ; Item 2
	db $0C,$10,$00  ; Item 3
	db $0C,$14,$00  ; Item 4
	db $0C,$18,$00  ; Item 5
	db $0C,$1C,$00  ; Item 6
	db $0C,$20,$00  ; Item 7
	db $0C,$24,$00  ; Item 8
	db $0C,$28,$00  ; Nothing
	db $0C,$2C,$00  ; Nothing
	db $0C,$30,$00  ; Nothing
	db $0C,$34,$00  ; Nothing
	db $0C,$38,$00  ; Nothing
	db $0C,$3C,$00  ; Nothing
	db $0C,$40,$00  ; Nothing
	db $00          ; End
	
;Buy_Sell_Exit Cursor value	
org $C3B89a
	dw $2a08	;Buy
	dw $2a30	;Sell
	dw $2a60	;Exit	

;Weapon cursor value
org $C3b8b4
	dw $2a00
	dw $3600
	dw $4200
	dw $4e00
	dw $5a00
	dw $6600
	dw $7200
	dw $7e00

;Rows in sell menu
org $C3BBe9
	LDA #$0B	;11 rows
	

org $C3b858
	LDX #$0029	; Cursor in selling item sub menu
org $c3b65a
	LDX #$0029	; Cursor in selling item sub menu

;shop fixes to tools and scrolls value

;rearrange new shop data and gain enough space for fix ninja scroll data and
;add HDMA scroll item menu data

;Pointers

org $C3B98A
	dw #holdy
	
org $c3f885
	dw #shopynamebox
org	$C3F88B
	dw #shopystatbox
org	$C3F891
	dw #shopydescritionbox
org	$C3F897
	dw #shopycharabox	
	
org $C3f905

	LDY #shopvigor				;pointer
	JSR $02f9					;Subroutine that print letter
	LDY #shopspeed			
	JSR $02f9
	LDY #shopstamina		
	JSR $02f9
	LDY #shopmagic
	JSR $02f9
	LDY #shopstatdefense
	JSR $02f9
	LDY #shopmdef
	JSR $02f9
	LDY #shopevade			
	JSR $02f9
	LDY #shopmevade			
	JSR $02f9
	LDY #shopattack
	JSR $02f9


org $C3F9E4
	dw #shopatthyphens
org	$C3FA0F
	LDY #shopdefhyphens
	JSR $02F9
	LDY #shopmdefhyphens
	JSR $02F9
	DW  $0680
	dw #shopquestionmarks

;Text data
org $C3FB0A

holdy:
	db $1F,$79,"Whatcha need?     ",$00
shopvigor:
	db $0d,$82,"Vigor",$00
shopspeed:
	db $0d,$83,"Speed",$00
shopstamina:
	db $8d,$83,"Stamina",$00
shopmagic:
	db $8d,$82,"Magic",$00
shopstatdefense:
	db $2b,$82,"Defense",$00
shopmdef:
	db $2b,$83,"M.Def.",$00
shopevade:
	db $ab,$82,"Evade",$00
shopmevade:
	db $ab,$83,"M.Evade",$00
shopattack:
	db $2b,$81,"Attack",$00
shopquestionmarks:
	db $3f,$81,$bf,$bf,$bf,$00	 		;Question marks 
shopatthyphens:
	db $3f,$81,"  -",$00				;Attack hyphens
shopdefhyphens:
	db $3f,$82,"  -",$00				;Defense hyphens
shopmdefhyphens:
	db $3f,$83,"  -",$00				;M.Defense hyphens
shopynamebox: 
	db $4b,$71,$1c,$07				;BCG
shopystatbox:
	db $0b,$75,$1c,$06				;BCG
shopydescritionbox:
	db $8b,$70,$1c,$01				;BCG
shopycharabox:
	db $8b,$73,$1c,$04				;BCG	
	
padbyte $ff
pad $C3fb9f
warnpc $c3fb9f


org $c3fa8d						; set 0 on item and - on tools and scroll
	LDX $2134					; load index
	LDA $D85000,x				; get ID
	AND #$07					; get class
	CMP #$06					; item or scroll?
	BNE skip_all_dashes			; branch if not
	jmp set_100_scroll			; Jump to new code instead of Shop 0 Attack value
is_item:
	LDY #shop0defense			; 0 on defense (only item)
	jsr $02f9                   
	LDY #shop0mdefense          ; 0 on m.defense (only item)
	jsr $02f9
skip_all_dashes:
	RTS
warnpc $c3faac


org $c3fba9
shop0attack:
	db $3f,$81,"  0",$00		;0 set instead of - in the item shop
shop0defense:
	db $3f,$82,"  0",$00		;0 set instead of - in the item shop
shop0mdefense:
	db $3f,$83,"  0",$00		;0 set instead of - in the item shop
shop100attack:
	db $3f,$81,"100",$00		;100 set in the item shop

set_100_scroll:
	LDA $D85000,x				; get ID
	CMP #$16                    ; is scroll?
	BEQ scroll                  ; branch if so
	ldy #shop0attack			; Load "0" attack value in Shop Menu
	jsr $02f9
	jmp is_item					; go back
	
scroll:
	ldy	#shop0attack			; Load "0" attack value in Shop Menu
	cpx #$1482					; is smoke bomb?
	beq smoke_bomb              ; branch if so
	ldy	#shop100attack          ; load 100 attack instead of 0
smoke_bomb:                     
	jsr $02f9	                
	LDY #shopdefhyphens         ; load def hyphens
	jsr $02f9                   
	LDY #shopmdefhyphens        ; load m.def hyphens
	jsr $02f9                   
	jmp skip_all_dashes			; Go back



warnpc $c3fbef


;Stats value

org $C3F972
	db $23,$83	;Speed value

org $C3F987
	db $a3,$83	;Stamina value

org $C3F9A1
	db $a3,$82	;Magic value
	
org $C3FA29
	db $bf,$82	;Evade value
	
org $C3FA44
	db $bf,$83	;M.Evade

org $C3F9CE
	db $3f,$82	;Defense value

org $C3F9DE
	db $3f,$83	;M.Defense Value

;;-------------------------------------------------------
;;-------------------------------------------------------
;;
;;Setting animated sprite on tool and throwing item
;;
;;-------------------------------------------------------
;;-------------------------------------------------------

;Setting new routine that can avoid equip unequippable item
org $c2552c							;Start btl routine and set equippable item 
	jml avoid_btl_equip_routine		;Jump to routine that unequip throwing item
	
org $c39b91							;Start equip menu routine 
	jml avoid_menu_equip_routine	;Jump to routine that unequip throwing item
	nop								;Erasing old data
	nop								;Erasing old data
	
org $d86f30							;New routines
avoid_menu_equip_routine:
	rep #$20						;16-bit A
	cpx #$079e						;Is Shuriken in stock?	
	beq 13							;Skip to $C39ba3 if is it
	cpx #$07da						;Is Ninja Star in stock?	
	beq 08                          ;Skip to $C39ba3 if is it
	lda $d85001,x					;Load Compatibility item
	jml $c39b97						;Go on Check
	jml $c39ba3						;Go on to next item

avoid_btl_equip_routine:
	lda #$0000						;Set no equippable character item in Accumulator
	cpx #$079e						;Is Shuriken in stock?
	beq 29							;Skip to $c25530
	cpx #$07da						;Is Ninja star in stock?
	beq 24							;Skip to $c25530
	cpx #$1428						;Is Ninja scroll water in stock?
	beq 19							;Skip to $c25530
	cpx #$140a						;Is Ninja scroll fire in stock?
	beq 14							;Skip to $c25530
	cpx #$1446						;Is Ninja scroll bolt in stock?
	beq 09							;Skip to $c25530
	cpx #$1482						;Is Ninja scroll smoke in stock?
	beq 04							;Skip to $c25530
	lda $d85001,x 					;Set Item's equippable characters
	jml $c25530						;Go on check if onscreen character can equip item


;;-----------------------------------------------------
;;
;;Fix Tools bug
;;
;;-----------------------------------------------------

;Fix print routine
org $c3f9b6 : lda $d85000,x  ;Load Item Code
org $c3f9ba : and #$07       ;Check if #$00 is set
org $c3f9bc : beq $39	     ;Branch if is it (fixed, original code excludes print routine)

;Set Attack print value
org $d863ec : db $00,$10,$10    ;Autocrossbow 
org $d8631a : db $00,$10,$10    ;Noiseblaster 
org $d86338 : db $00,$10,$10    ;Bio Blaster
org $d863b0 : db $00,$10,$10    ;Drill value
org $d86356 : db $00,$10,$10    ;Flash value
org $d86392 : db $00,$10,$10    ;Defibrillator

;Set value number
org $d86400 : db $b4        ;Autocrossbow 
org $d8632e : db $00        ;Noiseblaster 
org $d8634c : db $2d        ;Bio Blaster
org $d863c4 : db $c8        ;Drill value
org $d8636a : db $3c        ;Flash value
org $d863a6 : db $0a        ;Defibrillator

;;-----------------------------------------------------
;;
;;Fix Scroll bug and set Shadow&Gogo animated sprite
;;
;;-----------------------------------------------------

;Set Attack print value

org $d8579e : db $11,$08,$10	;Shuriken
org $d857da : db $11,$08,$10	;Ninja Star
org $d86428 : db $16,$08,$10	;Ninja scroll water
org $d8640a : db $16,$08,$10	;Ninja scroll fire
org $d86446 : db $16,$08,$10	;Ninja scroll bolt
org $d86482 : db $16,$08,$10	;Ninja scroll smoke

;Set value number
org $d86428+20 : db $00		;Ninja scroll water
org $d8640a+20 : db $00		;Ninja scroll fire
org $d86446+20 : db $00		;Ninja scroll bolt
org $d86482+20 : db $00		;Ninja scroll smoke

;;-----------------------------------------------------
;;
;;		Lag Bug
;;
;;-----------------------------------------------------

org $C3F8AC
lda #$10        ; reset/stop desc
        tsb $45            ; set menu flags
        lda $0D
        bit #$40        ; holding Y?
        bne shop_handle_y ; branch if not
        jsr $0f39        ; queue text upload
        ;jsr $1368
        jsr $b8a6        ; handle d-pad
        jsr check_stats
        jsr $bc84        ; draw quantity owned
        jsr $bca8        ; draw quantity worn
        bra shop_handle_b
;Handle hold Y
shop_handle_y:
        jsr $b8a6        ; handle d-pad
        jsr check_stats
        jsr $0f4d        ; queue text upload 2
		jsr BG_Scroll
        sep #$20        ; 8-bit A
        lda #$04        ; bit 2
        trb $45            ; set bit in menu flags A
        jsr gear_desc
not_press_y_this_frame:
        rts
;Fork: Handle B
shop_handle_b:
        stz $3c
        stz $3e
        lda #$04
        tsb $45
		LDA $09        ; No-autofire keys
		BIT #$80       ; Pushing B?
		BEQ shop_handle_a     ; Branch if not
		JSR $0EA9      ; Sound: Cursor
		JMP $B760      ; Exit submenu
;Fork: Handle A
shop_handle_a:
		LDA $08        ; No-autofire keys
		BIT #$80       ; Pushing A?
        beq not_pushing_a
		JSR $B82F      ; Set buy limit
		JSR $B7E6      ; Test GP, stock
not_pushing_a:
        rts
		
		
		
warnpc $C3F8FF

ORG $C3B4C8
BG_Scroll:
	rep #$20        ; 16-bit A
	lda #$0100        ; BG2 scroll position
    sta $3b            ; BG2 Y position
    sta $3d            ; BG3 X position
	rts
warnpc $C3B4E6

org $C3F93F
check_stats:

org $C3FAAD
gear_desc:


; Initialize Buy menu
org $C3B7A3
C3B7A3:  JSR $B8A0      ; Load navig data
         JSR $B8A9      ; Relocate cursor
         LDA #$08        ; Arm waving: On
         TRB $47         ; Never off...
         JSR $C09A      ; Create actors
         JSR $C23B      ; Create signs
C3B7B3:  LDY #$0100      ; X: 256
         STY $39         ; Set BG2 X-Pos
         LDY $00         ; Y: 0
         STY $3B         ; Set BG2 Y-Pos
         JSR $B986      ; Draw all text
         JSR $BCFD      ; Build sign list
         LDA #$26        ; C3/B4BD
		 JMP C3B4D2		; Go to queue Hold Y sprite
	
org $C3B4D2
C3B4D2:
    STA $26         ; Next: Buy list
    LDY #C3B4DA		; C3/B4DA
	JMP $1173		; Queue OAM fn
C3B4DA:
	JSL EDFD12
	RTS