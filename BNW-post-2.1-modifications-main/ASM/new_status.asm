arch 65816
hirom
table "menu.tbl",ltr

;;-----------------------------------------------------
;;-----------------------------------------------------
;;
;;						Status menu
;;
;;-----------------------------------------------------
;;-----------------------------------------------------
macro FakeC3(addr)
	phk						; push 
	per $0006				; push return
	pea $96EE				; push address
	jml $c3<addr>			; jump to address
endmacro
macro FakeShortC2(addr)
	phk						; push 
	per $0006				; push return
	pea $fffe				; push address
	jml $c2<addr>			; jump to address
endmacro

org $C3625E
	ldx #$0A40				; Y-X pos status effect in status menu
	
;--------------------------------------------------
;Windows
;
;	First value: Start print position
;	Second value: Height
;	Third value: Lenght
;--------------------------------------------------

org $C35f79
	dw $5B6D,$0D0B			;Bottom box
	dw $58f3,$0707			;Technique Box
	dw $588b,$091c			;Top box
	dw $58c7,$1200			;Middle box
	dw $6087,$1207			;???

org $C3FC2B
	dw $5B4B,$0D0f

; Pointers manager
org $C35D41
	LDA #$20								; White text
	sta $29
	ldx #slashes							; Start pointer address
	ldy #Stats_BG1-slashes					; Pointers to read (2 bytes each pointer)
	jsr $69ba								; Prepare print
	lda #$24								; Blue Text
	sta $29
	ldx #charapoint							; Start pointer address
	ldy #slashes-charapoint					; Pointers to read (2 bytes each pointer)
	jmp New_Blue							; Jump to sub routine that add new pointers instead of "prepare print"
	rts
	LDA #$2C								; Blue text
	sta $29
	ldx #statusstats						; Start pointer address
	ldy #charapoint-statusstats				; Pointers to read (2 bytes each pointer)
	jsr $69ba								; "prepare print"
	lda #$2C								; Load Blue Palette  
	sta $29   								; Store on $29
	ldx #Stats_BG1							; Start pointer address
	ldy #$000A								; Pointers to read (2 bytes each pointer)
	jsr $69ba								; Prepare print
	rts
warnpc $C35D77




org $c3f33a
	lda #$24	; Blue Next EL
org $C3F277
	dw $3A59 : db "Next  ",$00
org $C3fc53
	LDX #$3A65						; Next EL value
org $C3FC64							; Avoid print EP value					
	nop
	nop
	nop
	nop
	nop
	nop
org $C3FC6B
	JMP $02F9						; JMP instead of JSR and avoid print EP
org $C3FC83
	dw $3aaf : db "EP",$00
org $C3F2C7
	dw $3a19 : db "EL",$00

org $c3f385
	JSR Print_EL_Value
	
org $C38750
Print_EL_Value:
	SEP #$20
	LDA $26
	CMP #$0B
	BEQ .status
	CMP #$0C
	BEQ .status
	REP #$20
	lda [$ef]
	CLC
	RTS
.status
	REP #$20
	lda [$ef]
	CLC
	ADC #$00B4
	RTS
	
padbyte $FF
pad $C38777						; erase the rest of the old routine



;Pointers table
org $C36437
statusstats:
	dw #statusvigor
	dw #statusstamina
	dw #statusmagic
	dw #statusspeed
;	dw #statusexp

	
charapoint:
	dw #statusLV
	dw #statusHP
	dw #statusPM
	dw #statusnextlv	

slashes:
	dw #statusslash
	dw #statusslash2

Stats_BG1:
	dw #statusattack
	dw #statusdefense
	dw #statusmagicdefense
	dw #statusevade
	dw #statusmagicevade
	
;Data

statusslash:		dw $3ADB		: db "/",$00
statusslash2:		dw $3B1B		: db "/",$00
statusLV:			dw $3959		: db "LV",$00
statusHP:			dw $3ACD		: db "HP",$00
statusPM:			dw $3B0D		: db "MP",$00
;statusexp:			dw $3acd-64		: db "Exp.",$00
statusnextlv:		dw $3999		: db "Next  ",$00
statusvigor:		dw $7c4d		: db "Vigor",$00
statusmagic:		dw $7ccd		: db "Magic",$00
statusspeed:		dw $7d4d		: db "Speed",$00
statusstamina:		dw $7Dcd		: db "Stamina",$00
statusattack:		dw $7e4d		: db "Attack",$00
statusdefense:		dw $7ecd		: db "Defense",$00
statusmagicdefense:	dw $7f4d		: db "M.Defense",$00
statusevade:		dw $7fcd		: db "Evade",$00
statusmagicevade:	dw $884D		: db "M.Evade",$00


new_sub_pointer:
	LDA #$10				; duplicated from C3/1EF7
	TRB $45
	JSR $0EFD
	CLC
	JMP $8983				; originally pointed by C3/02A3
reset_item_desc:
	PHA
	LDA $26
	CMP #$5E
	BEQ .wait
	LSR
	CMP #$32
	BEQ .wait
	STZ $3649,X				; resets the item description display
.wait
	PLA
	RTS

New_Blue:
	jsr $69ba							; Jump to sub routine that add new pointers instead of "prepare print"
	;lda #$24							; Load Blue Palette  
	;sta $29   							; Store on $29
	;ldx #Info							; Start pointer address
	;ldy #$0004							; Pointers to read (2 bytes each pointer)
	;jsr $69ba							; Prepare print
	jsl C4B6D5							; Jump and print new text
	rts
	
STATUS_PRTRT:
	PHX          					    ; Queue index
    TYX             					; Member slot
    LDA $26								; Status flag?
	CMP #$0B							; Init Status?
	BEQ .status							; Branch if so
	CMP #$0C							; Sustain Status?
	BEQ .status							; Branch if so
	LDA #$02       						; Portrait bit
	JMP $0AF5							; Jump back
.status
	REP #$20							; 16 bit-A
	LDA #$0010							; Portrait X-Pos
	JMP $0B0B							; Jump Back
	
padbyte $ff
pad $C3651A
warnpc $C3651A

org $C30AF1
	JMP STATUS_PRTRT					; Jump from the original routine to change portrait position in status menu


org $C3FC47
	LDA #$001A							; Portrait Y-pos


;$00	;Ramuh    
;$01	;Ifrit     
;$02	;Shiva     
;$03	;Siren     
;$04	;Terrato  
;$05	;Shoat    
;$06	;Maduin   
;$07	;Bismark  
;$08	;Stray    
;$09	;Palidor  
;$0a	;Tritoch  
;$0b	;Odin     
;$0c	;Loki	 
;$0d	;Bahamut  
;$0e	;Crusader 
;$0f	;Ragnarok 
;$10	;Alexandr 
;$11	;Kirin    
;$12	;ZoneSeek 
;$13	;Carbunkl 
;$14	;Phantom  
;$15	;Seraph   
;$16	;Golem    
;$17	;Unicorn  
;$18	;Fenrir   
;$19	;Starlet  
;$1a	;Phoenix  
;	
;org $C4B700
org $C4B6EE
C4B6D5:
	lda #$2c							; Blue text
	sta $29                             ;
	ldx #Info                       	; statuses pointer
	ldy #$0006                          ; Pointers q.ty
	jsr C369BA                          ; Prepare print
	
	lda #$28							; Grey text
	sta $29                             ;
	ldx #statuses                       ; Statuses pointer
	ldy #$0038                          ; Pointers q.ty
	jsr C369BA                          ; Prepare print
	rtl
	
light_up_statuses:
	LDX $00								; Clear X
	STX $DA                             ;   ^   $DA Equip index counter
.second_loop
	STX $DE                             ;   ^   $DE Item Value Index Counter
	STX $DC                             ;   ^   $DC Check Byte counter
.loop	
	PHY									; Save Equip Index
	LDA $161F,Y							; load item id
	CMP #$FF							; $FF (empty) item value?
	BEQ .empty_slot						; Branch if so	
	CMP #$66							; Cursed Shield?
	BEQ .empty_slot						; Branch if so
	JSR take_item_index					; go to index and keep bit
.next_bit
	PHX									; Save Item Value Index
	LDA $D85006,X						; load item function
	JSR check_byte						; Jump and check if the value return active label
.avoid_check
	plx									; Restore Item Value Index
	INX									; Inc X for next value 
	INC $DE								; Inc $DE counter
	LDA $DE								; Load in A
	BIT #$04							; Counter It's 4?
	BEQ .next_bit						; Branch if not
.second_bit
	PHX
	LDA $D85008,X						; load item function
	JSR check_byte						; Jump and check if the value return active label
	plx									; Restore Item Value Index
	INX									; Inc X for next value
	INC $DE								; Inc $DE Counter 
	LDA $DE								; Load in A
	CMP #$05							; Counter it's 5?
	BNE .second_bit						; Branch to check anoter flag if not
	LDA $D85014,X						; load item function	
	jsr check_byte						; Jump and check if the value return active label
.empty_slot	
	PLY									; Restore Equip Index
	INY									; Inc Y index for next 
	INC $DA								; Inc $DA Counter
	ldx $00								; Clear X for next
	LDA $DA								; Load $DA counter
	CMP #$06							; 6 item done? 
	BNE .second_loop					; Branch if not
	RTL                                 ; Go Back

take_item_index:
	STA $211B							; low byte
	STZ $211B                           ; keep only low byte
	LDA #$1E                            ; multiplier
	STA $211C                           ; store to get  
	LDA $2135                           ; Get Mid Byte
	xba                                 ; exchange A
	LDA $2134                           ; Get Lo-Byte
	TAX									; Index It
	TDC									; Clear A
	RTS

check_byte:
; Blocks
	
	STA $DF								; Save A in scratch
	LDX $DC								; Load check byte counter
.next_bit	
	LDA.l statuses_bitmask,x			; Load Bit to check
	BIT $DF								; Check Bit - active flag
	BEQ .not_active						; Branch if not
	PHX									; Save check byte index
	TDC									; Clear A
	TXA 								; X To A
	ASL                                 ; Double it to pick pointer
	TAX                                 ; Index it
	REP #$20							; 16-bit A
	LDA.l statuses,x                    ; Load pointer
	TAY                                 ; Index it
	SEP #$20							; 8-bit A
	JSR C402F9                          ; Go to print
	PLX                                 ; Restore Check byte Index
	CPX #$0009							; You are here if bit it's true 
	BEQ .Block_Sap						; Regen Bit true? branch if so
	CPX #$000A                          ; You are here if bit it's true
	BEQ .Block_Slow                     ; Haste Bit true? branch if so
.not_active                                 
	inx                                 ; Increment index
	CPX #$0004							; Compare index
	BEQ .next_status                    ; Branch if so
	CPX #$0009                          ; Compare index
	BEQ .next_status                    ; Branch if so
	CPX #$000F                          ; Compare index
	BEQ .next_status                    ; Branch if so
	CPX #$0017                          ; Compare index
	BEQ .next_status	                ; Branch if so
	CPX #$0019                          ; Compare index
	BEQ .next_status                    ; Branch if so
	CPX #$001A                          ; Compare index
	BEQ .next_status                    ; Branch and check new cycle bit
	bra .next_bit                       ; Branch to another bit in the same cycle
.next_status
	STX $DC								; Save check byte counter
	RTS
	
.Block_Sap
	PHX                                 ; Save X
	LDY #sap                            ; Load Sap pointer
	bra .print                          ; Branche to print
.Block_Slow                             
	PHX                                 ; Save X
	LDY #slow                           ; Load Slow pointer
.print	
	JSR C402F9                          ; Go to print
	PLX									; Restore X
	BRA .not_active						; Branch and continue
	
	
statuses_bitmask:
	db $01   ; Blind
	db $04   ; Poison
	db $20   ; Mute
	db $40   ; Petrify

	db $01   ; Death
	db $08   ; Imp
	db $10   ; Berserk
	db $20   ; Muddle
	db $80   ; Sleep

	db $02   ; Regen (Block Sap)
	db $08   ; Haste (Block Slow)
	db $10   ; Stop
	db $20   ; Shell
	db $40   ; Safe
	db $80   ; Reflect

	db $01   ; ATK +
	db $02   ; Mag +
	db $10   ; HP/MP +
	db $10   ; HP/MP +
	db $04   ; HP ++
	db $08   ; HP +++
	db $20   ; MP ++
	db $40	 ; MP +++

	db $02	 ; Counter
	db $40	 ; Cover
	
	db $10	 ; Auto Berserk

Info:
	dw #Auto
	dw #Blocks
	dw #Bonus

statuses:
	dw #blind
	dw #poison
	dw #mute
	dw #petrify

	dw #death	
	dw #imp
	dw #berserk
	dw #muddle	
	dw #sleep

	dw #regen
	dw #haste
	dw #stop	
	dw #shell
	dw #safe
	dw #reflect

	dw #atk
	dw #mag
	dw #HP_label
	dw #MP_label
	dw #plus_HP_1
	dw #plus_HP_2
	dw #plus_MP_1
	dw #plus_MP_2
	
	dw #counter
	dw #cover
	
	dw #brsrk_auto
	

	dw #slow
	dw #sap




	

Auto:		dw $7E6F : db "Auto",$00
Blocks:		dw $7c6F : db "Blocks",$00
Bonus:		dw $7f6F : db "Bonus",$00

poison:     dw $3C31 : db $49,$4a,$4b,$00				
sleep:      dw $3C39 : db $2a,$2b,$29,$00
blind:		dw $3C3F : db $5d,$5e,$5f,$00

berserk:    dw $3C71 : db $34,$35,$36,$37,$00
mute:       dw $3C79 : db $30,$27,$33,$00
imp:        dw $3C7F : db $56,$29,$00

muddle:     dw $3CB1 : db $30,$31,$32,$33,$00
death:      dw $3CB9 : db $46,$47,$48,$00
stop:       dw $3CBF : db $40,$41,$00

petrify:    dw $3CF1 : db $2c,$2d,$2e,$2f,$00
slow:		dw $3CF9 : db $2A,$4c,$4D,$00
sap:		dw $3CFF : db $28,$29,$00

brsrk_auto: dw $3DB1 : db $34,$35,$36,$37,$00
safe:       dw $3DB9 : db $28,$45,$00
shell:      dw $3DBF : db $53,$54,$55,$00
reflect:    dw $3DF1 : db $20,$25,$26,$52,$00
haste:      dw $3DF9 : db $42,$43,$44,$00
regen:      dw $3DFF : db $20,$21,$22,$00

atk:        dw $3e71 : db $38,$39,$3A,$00
mag:        dw $3e7B : db $3B,$3C,$3D,$00
cover:      dw $3eb1 : db $57,$58,$59,$00
counter:    dw $3eBB : db $57,$5a,$5B,$5C,$00
HP_label:	dw $3eF1 : db $4E,$4F,$00
MP_label:   dw $3eFB : db $3E,$4F,$00
plus_HP_1:  dw $3eF1 : db $4E,$4F,$CA,$00
plus_HP_2:  dw $3eF1 : db $4E,$4F,$CA,$3F,$00
plus_MP_1:  dw $3eFB : db $3E,$4F,$CA,$00
plus_MP_2:	dw $3EFB : db $3E,$4F,$CA,$3F,$00		

WARNPC $C4b900

org $C4a700
;Prepare write
C402F9:  

	LDA #$20		; White text
	STA $29			; Save
	STY $E7         ; Set src LBs
	LDA #$C4        ; Bank: C3
	STA $E9         ; Set src HB
	%FakeC3(02FF)	; Draw string

	RTS
	
; Draw multiple strings using consecutive pointers
C369BA:  STX $F1         	; Set ptrs loc
         STY $EF         	; Set counter
         LDA #$C4        	; Bank: C3
         STA $F3         	; Set loc HB
         LDY $00         	; Index: 0
C369C4:  REP #$20        	; 16-bit A
         LDA [$F1],Y     	; Text pointer
         STA $E7         	; Set src LBs
         PHY             	; Save index
         SEP #$20        	; 8-bit A
         LDA #$C4        	; Bank: C3
         STA $E9         	; Set src HB
		 %FakeC3(02FF)	; Draw string
         PLY             	; String index
         INY             	; Index +1
         INY             	; Index +1
         CPY $EF         	; None left?
         BNE C369C4      	; Loop if not
		 RTS
		 
; Set to condense BG1 text in Status menu
Condense_Status_txt:
	LDA #$02        ; 1Rx2B to PPU
	STA $4360       ; Set DMA mode
	LDA #$0E        ; $2112
	STA $4361       ; To BG3 V-Scroll
	LDY #HDMA_Table ; 
	STY $4362       ; Set src LBs
	LDA #$C4        ; Bank: C3
	STA $4364       ; Set src HB
	LDA #$C4        ; ...
	STA $4367       ; Set indir HB
	LDA #$40        ; Channel: 6
	TSB $43         ; Queue HDMA-6
	RTL
	
;New HDMA Table

HDMA_Table:
db $17,$00,$00
db $08,$04,$00
db $08,$04,$00
db $10,$04,$00
db $08,$04,$00
db $0c,$04,$00
db $0c,$04,$00
db $0c,$04,$00
db $18,$08,$00
db $18,$08,$00
db $0c,$08,$00
db $10,$08,$00
db $0c,$08,$00
db $00

warnpc $C4a7E0


org $C302A3
	dw #new_sub_pointer

org $C3A897
	JSR reset_item_desc		; Jump to new subroutine C3/FA3B
	
; 0B: Initialize Status menu
org $C31C46
	JSR $352F  			      ; Reset/Stop stuff
	JSR $620B 			      ; Set to shift text
	JSR $26F5

org $C326F5
	JSL Condense_Status_txt		; Draw menu; portrait
	JSR $5D05					; Draw menu; portrait
	RTS

org $c3632A
	jsl Condense_Status_txt
	jsr $620b
	
	

;---------------------------------------------------------------------;
;                                                                     ;
;       Hack that print stats difference in yellow colour             ;
;                                                                     ;
;---------------------------------------------------------------------;                                                                     ;

org $D8E7D0 ; Extending palette
MenuPalette:
;   BCG  Shadow --- Colour
; 1st row
dw $0000,$1084,$39CE,$7FFF		;user editable color 
dw $0000,$0000,$2108,$3DEF		;gray font for unavailable choiches
dw $0000,$0000,$39CE,$03BF		;yellow font
dw $0000,$0000,$39CE,$6F60		;light blue font 

; 2nd row
dw $0000,$0000,$39CE,$6F60		;light blue font
dw $0000,$7FFF,$1084,$7FFF		;7FFF is replaced by user font in game. 3rd code is the VWF description shadow
dw $0000,$0000,$39CE,$7FFF		;white font
dw $0000,$0000,$39CE,$6F60		;ligth blue font

; 3rd row
dw $0000,$0000,$2108,$3DEF		;gray font
dw $0000,$0000,$2108,$3DEF		;gray font
dw $0000,$0000,$2108,$3DEF		;gray font
dw $0000,$0000,$2108,$3DEF		;gray font

; 4th row

dw $0000,$3C00,$2108,$3DEF		;gray font with blue shadow (Esper equipped from other actor)
dw $0000,$3868,$39CE,$7FFF		;gray font with purple shadow
dw $0000,$3868,$39CE,$7FFF		;gray font with purple shadow
dw $0000,$3868,$39CE,$7FFF		;gray font with purple shadow

; 5th row

dw $0000,$1084,$5294,$7FFF		;white font with gray shadow
dw $0000,$1084,$5294,$7FFF		;white font with gray shadow
dw $0000,$0000,$39CE,$7FFF		;white font with black shadow
dw $0000,$1084,$5294,$7FFF		;white font with gray shadow

; 6th row
Yellow:
dw $0000,$0000,$39CE,$03BF		;yellow font (esper bonus points)
dw $FFFF,$FFFF,$FFFF,$FFFF		;null
dw $FFFF,$FFFF,$FFFF,$FFFF		;null
dw $FFFF,$FFFF,$FFFF,$FFFF		;null

;7th row
White:
dw $0000,$0000,$39CE,$7FFF		;white font

org $C36BEE
	rep #$20			; 16 bit A
	lda MenuPalette,x	; Load Palette Data
	sta $7E3049,x		; Store in RAM
	sep #$20			; 8 bit A
	sta $2122			; Put LB in CGRAM
	xba					; Switch to HB
	sta $2122			; Put HB in CGRAM
	inx					; Index +1
	inx					; Index +1
	cpx #$00C8			; Set 120 colors


; Try to load Elements in the main menu

; 04: Initialize main menu
org $C31A8A
	JSR $352F      ; Reset/Stop stuff
	JSR $1BA8      ; Load portraits
	JSR $0F89      ; Stop VRAM DMA B
	JSR $3A6B      ; Set Win2 bounds
	LDA #$04        ; Channel: 2
	TSB $43         ; Queue Win1 HDMA
	JSR $0F89      ; Again...
	JSR $6904      ; Reset BGs' X/Y
	LDA #$03        ; 64x64 at $0000
	STA $2107       ; Set BG1 map loc
	LDA #$43        ; 64x64 at $4000
	STA $2109       ; Set BG3 map loc
	LDA #$C0        ; Channels: 6, 7
	TRB $43         ; Halt HDMA 6+7
	LDA #$02        ; Main cursor: On
	STA $46         ; Bar/Blinker: Off
	JSR $30F5      ; Draw menu
	LDA #$00        ; Min slot: 0
	LDY #$2F42     ; C3/2F42
	JSR $1173      ; Queue D-Pad fn
	JSR $07B0      ; Queue cursor OAM
	JSR $354E      ; HDMA: MS desig.
	LDY #$0002      ; Y: 2
	STY $37         ; Set BG1 Y-Pos
	JSR $36A3      ; Set to shift BG3
	LDA #$05        ; C3/1DA4
	STA $27         ; Queue: Sustain menu
	lda #$01		; C3/1D7E
    sta $26         ; Next: Fade-in
	JMP BRT			;

org $C38E29
BRT:
glyphs:
	phx
	ldx $00
pick_white_color:
	LDA White,x
	sta $7E3109,x
	inx
	cpx #$0008
	bne pick_white_color
	plx
	JSR $A9A9      ; Upload elements
	JSR $1BA8	   ; Go to unfreeze CGRAM and refresh and allow to load portrait GFX
	JMP $3541      ; BRT:1 + NMI

;padbyte $FF
;pad $C32706
;warnpc $C32706

org $C4B4F0
C4B500:
	phx
	ldx $00
pick_color:
	LDA Yellow,x
	sta $7E30E9,x
	inx
	cpx #$0008
	bne pick_color
	plx
	rtl

org $C32554
	lda $9f
	sta $27

;-------------------------------------------------------------------------------;
;                                                                               ;
; Change the print routine and allow to keep the glyphs white - some shadow     ;
; letter and accent for the italian translation                                 ;
;                                                                               ;
;-------------------------------------------------------------------------------;
org $C3031c
	jsl change_palette		; Go to print letter and accent or shadow
	
org $C9fcf0
change_palette:
    cmp #$ED        ; Cmp if icon
    BCS no_change   ; greater or equal?
    cmp #$CF
    BEQ change
    cmp #$D7
    BCC no_change
change:    
    LDA #$38
    BRA color_change
no_change:    
    lda $29
color_change:    
    sta [$EB],y
    rtl

org $C0814E
    jsr changeshadow
    nop
    nop
    nop
    
warnpc $C08154

org $C0DE00
changeshadow:
	lda #$1084		; set dark gray color
	sta $7E7204
	rts
	
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
	dw $7FDF				; evade     (11A8)
	dw $885F				; m.evade   (11AA)

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
	LDY #$0006				; how many spaces to skip
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
	LDX #$3B25				; load MP offset (A instead of X because 
	LDY $F1					; load MP "flag"
	CPY #$0001				; is true?
	BEQ .MP					; branch if so
	LDX #$3AE5				; load HP offset
.MP
	STX $EB                 ; store on $EB for draw routine
	SEP #$20                ; 8-bit A
	JSR $049A				; draw 5 digits (16 bit)	
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
	TDC 					; Clear X
	TAX
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
	LDX #$7EdF			; Defense stat position
	JSR !Draw3Digits	
	LDA $11BB				; M.Defense Value
	JSR !TurnIntoText8bit
	LDX #$7f5F			; M.Defense stat position
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
	LDX #$7e5F			; Attack Text position
	JSR $0486				; Draw 3 digits
	LDY #$38CD				; Text position
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
;	LDA $0011,X				; Experience LB
;	STA $F1					; Memorize it
;	LDA $0012,X				; Experience MB
;	STA $F2					; Memorize it
;	LDA $0013,X				; Experience HB
;	STA $F3					; Memorize it
;	JSR $0582				; Turn into text
;	LDX #$7AD9				; Text position
;	JSR $04A3				; Draw 8 digits
	JSR $60A0				; Get needed exp
	JSR $0582				; Turn into text
	LDX #$39A3				; Text position
	JSR Digits_6			; Draw 6 digits
	JSL.l C4B500			; reload yellow palette
	JSR !HpMpDiff	        ; go to routine that set Hp/Mp difference
	JSR !StatDiff	        ; go to routine that set stats difference	
	LDX $0102	            ; load $0102 (ship status menu portrait values) 
	STX $1E	                ; store
	STZ $47					; Ailments: Off
	JSR $11B0				; Hide ail. icons
	JSR $625B				; Display status
	REP #$20				; 16 bit-A
	LDA $67					; Charachter
	SBC #$1600				; Subtract base
	TAY						; Index it
	SEP #$20				; 8 bit-A
	JSL light_up_statuses	; jump on the subroutine that light up text
	RTS

; Draw 6 digits
Digits_6:
	LDY #$0008      ; Digits: 8
    STY $E0         ; Set counter
    LDY #$0002      ; Skipped: 1
    JMP $04C7       ; Draw text

warnpc $C36096
org $C36096
	dw $395F		; LV value
	dw $3AD3		; Current HP
	dw $3ADD		; Max HP
	dw $3B13		; Current MP
	dw $3B1D		; Max MP
	
org $C39382
	JSR PowHelper			; here just to avoid crash
	
;org $c3FC47
;	JSR Portrait_position
	
org $c36102
	ldy #$7975		; Gogo Tech
	JSR $4598		;
	ldy #$79f5		; Gogo Tech
	JSR $459E		;
	LDY #$7a75		; Gogo Tech
	JSR $45A5		;
	ldy #$7af5		; Gogo Tech

; Navigation data for non-shifted Status menu
org $C3370E
	db $80          ; Wraps vertically
	db $00          ; Initial column
	db $00          ; Initial row
	db $01          ; 1 column
	db $04          ; 4 rows

; Cursor positions for non-shifted Status menu
	dw $1CA0        ; Command 1
	dw $28A0        ; Command 2
	dw $34A0        ; Command 3
	dw $41A0        ; Command 4
	
; Text shifting table for BG3
org $C3622A
	db $27,$00,$00  ; Status
	db $0C,$04,$00  ; Cmd choice A
	db $0C,$08,$00  ; Cmd choice B
	db $0C,$0C,$00  ; Cmd choice C
	db $0C,$10,$00  ; Cmd choice D
	db $0C,$14,$00  ; Command A
	db $0C,$18,$00  ; Command B
	db $0C,$1C,$00  ; Command C
	db $0C,$20,$00  ; Command D
	db $0C,$24,$00  ; Needed exp.
	db $0C,$28,$00  ; Bat.Pwr
	db $0C,$2C,$00  ; Defense
	db $0C,$30,$00  ; Evade
	db $0C,$34,$00  ; Mag.Def
	db $0C,$38,$00  ; MBlock
	db $0C,$3C,$00  ; Nothing
	db $00          ; End

; Set a section of Status menu to mask wrapping Gogo portrait
org $C35F50  
	LDX #$610A      ; Tilemap ptr
	
