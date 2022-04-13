arch 65816
hirom

table "menu.tbl", ltr ; Tabella per le stringhe di testo

;;-----------------------------------------------------
;;
;;Colosseum
;;
;;-----------------------------------------------------

;Change words position
org $C3B251
    db $EB,$78        ;Right item
org $C3B261
    db $CD,$78        ;Left item

;Change box dimension
org $C3B33F
	db $8b,$58,$0d,$01	;Left Item
	db $a9,$58,$0d,$01	;Right Item

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


org $C38A4C
	dw #Itemowned
	
org $C3fe04
Itemowned:
	db $8d,$79,"Owned:",$00

;Windows sizes
;	first value x start assis print
;	second value y start assis print
;	third value wide sizes
;	fourth value height sizes
 
org $C38A3B
	db $9d,$58,$13,$18	;Stats window
	db $8b,$58,$0c,$01	;Item window
	db $4b,$59,$07,$03	;Owned window

org $C38A54
	db $cb,$78			;Move Item name 1 line up 
org $C38a7c
	db $13,$7a			;Move quantity 1 line up

;------------------------------------------------------
;Hide rare counter item and expand description box
;------------------------------------------------------

org $c3837f 
    ldx #$7ac5        ;Set rare item conunter out of bounds and hide it
    
org $c38e4a
    db $bf,$7a,$00    ;$00 should deny 3 blank tiles print and allow description text to show up
	
;;-----------------------------------------------------
;;
;;Fix Tools bug
;;
;;-----------------------------------------------------

;Set Attack print value
org $d863ec : db $01,$10,$10    ;Autocrossbow 
org $d8631a : db $01,$10,$10    ;Noiseblaster 
org $d86338 : db $01,$10,$10    ;Bio Blaster
org $d863b0 : db $01,$10,$10    ;Drill value
org $d86356 : db $01,$10,$10    ;Flash value
org $d86392 : db $01,$10,$10    ;Defibrillator

;Set value number
org $d86400 : db $b4        ;Autocrossbow 
org $d8632e : db $00        ;Noiseblaster 
org $d8634c : db $2d        ;Bio Blaster
org $d863c4 : db $c8        ;Drill value
org $d8636a : db $3c        ;Flash value
org $d863a6 : db $0a        ;Defibrillator

;;-----------------------------------------------------
;;
;;Fix Scroll bug
;;
;;-----------------------------------------------------

;Set Attack print value
org $d8579e : db $11,$08,$10	;Shuriken
org $d86428 : db $11,$08,$10	;Ninja scroll water
org $d8640a : db $11,$08,$10	;Ninja scroll fire
org $d86446 : db $11,$08,$10	;Ninja scroll bolt
org $d86482 : db $11,$08,$10	;Ninja scroll smoke

;Set value number
org $d86428+20 : db $64		;Ninja scroll water
org $d8640a+20 : db $64		;Ninja scroll fire
org $d86446+20 : db $64		;Ninja scroll bolt
org $d86482+20 : db $00		;Ninja scroll smoke