arch 65816
hirom
table "menu.tbl", ltr



;###################################;
;
; Changing "[actor] has it" into "You have equipped"
;
; 4D: Sustain esper data menu (12 free bytes)
org $C358CE
	JSR $5983       ; Handle D-Pad
	JSR $5B93       ; Load description
	LDA $08         ; No-autofire keys
	BIT #$80        ; Pushing A?
	BEQ not_pushing ; Branch if not
	TDC             ; Clear A
	jmp Pressed_A   ; support Spell Bank and EL Bonus Selection
can_equip_fork:	
	BNE not_pushing ; Branch if not
	LDA $99         ; Viewed esper
	JSR $5574       ; Choose palette
	STA $E0         ; Memorize esper
	LDA $FC         ; Esper palette
	CMP #$20        ; Is esper color white?
	BEQ is_white    ; Branch if it is
;org $C358EC
	jsl actor_chk	; Go to check if actor and esper equipped actor are the same
	cmp $FD			; actor and esper equipped actor are the same? 
	beq is_the_same	; Is the same so you can unequip
	JSR $0EC0       ; Play buzzer
	jmp rmv_from_actor
is_the_same:
	jsr $0EB2
	jmp unequip_esper

padbyte $FF
Pad $C35902
warnpc $C35902



org $C35902
is_white:
org $C3590A
not_pushing:
org $C3f798
Pressed_A:
org $C3f79c
JMP can_equip_fork

; 34: Wait while showing who holds esper (Changes to gain space and)
org $C3293A
C3293A:  LDY $20		; Timer expired?
         BNE C32947		; Exit if not
         JSL C0EE4A		; Jump long and blank messages
         JMP $5913		; Exit submenu
C32947:  RTS

; Unequip from sub-menu
unequip_esper:
	jsr $2908		;
	ldy #$0000		;
	jmp C326FB		;

; Set Exit delay
C326F5:	jsr $7fd9			; Print string
		LDY #$0020			; Frames: 32
C326FB: STY $20				; Set exit delay
C326FC:	LDA #$34			; C3/293A
		STA $26				; Next: Late exit
		jsr $0F11			; Queue text upload	
		rts	
		
padbyte $FF
Pad $C32966
warnpc $C32966

org $C31ff4
	JSR clear_bg1_skill
	
ORG $C326F5
clear_bg1_skill:
	lda #$10  
	tsb $45   
	ldx #$0b00
	jsr $6a4e 
	jmp $0f11
	
padbyte $FF
pad $C32706


; Draw "<actor> has it!" in esper data menu (20 free bytes)
org $C3559A
rmv_from_actor:  

	JML print_rmv_actor	; Go to print <Can't Equip or [Equip from <Actor>] 
actor_name:
	LDA $1602,X			; Character's name; displaced from calling function
actor_letters:
	CMP #$FF        	; Terminator?
	BEQ C355CE      	; Done if so
	STA $2180       	; Add to string
	INX             	; Point to next
	DEY             	; One less left
	BNE actor_name    	; Loop till last
C355CE: 
;	jml Switch_Esper
	lda #$BF			; load <?>
	sta $2180			; Save
	STZ $2180       	; End string
	jsr $7fd9			; print string
	jsr $0F11			; Queue text upload
	tdc
	sta $26
	jmp C3F0CB			; Initialize Remove selection

; Navigation data (Remove esper submenu)
navi_data:
	db $81			; Never Wraps
	db $00			; Initial column
	db $00			; Initial row
	db $02			; 2 column
	db $01			; 1 rows

esp_crsr:
	dw $1C0F		; Yes
	dw $1C3F		; No

padbyte $FF
Pad $C355D4	
warnpc $C355D4


; Start remove selection (2 free bytes)
org $C3F0CB
C3F0CB:
	TDC				; Clear A
	LDA $26			; Menu command
	CMP #$1E		; Back to Esper sub menu?
	BEQ .back		; Branch if so
	REP #$20		; 16-bit A
	ASL A			; Double it
	TAX				; Index it
	SEP #$20		; 8-bit A
	JSL C0ED60		; Handle Switch Esper
	CMP #$20		; Remove flag on?
	BEQ .remove		; Branch if so
	JSR $11B0		; Handle anim queue
	JSR $134D		; Update screen/pad
	JSR $02DB		; Check event timer
	BRA C3F0CB
.back
	jmp $28F2			; C328F2
.remove
	jmp is_white

	
;********************************************************
;	In C328F2 there's the code to restore Esper submenu
;
;	TDC             ; Clear A
;	LDA $4B         ; Selected slot
;	TAX             ; Index it
;	LDA $7E9D89,X   ; Esper in slot
;	CMP #$FF        ; None?
;	BEQ C32908      ; Unequip if so
;	STA $99         ; Memorize esper
;	JSR C35897      ; Init submenu
;	LDA #$4D        ; C3/58CE
;	STA $26         ; Next: Data menu
;	RTS

padbyte $FF
Pad $C3F0F4
warnpc $C3F0F5

; Handle Switch Esper
org $C0ED60
C0ED60:	JMP (C0ED63,X)
C0ED63: dw C0ED67	; 01 Invoke switch esper
		dw C0ED80	; 02 Sustain Switch Esper
		
; Invoke Switch
C0ED67:	jsr C0EE18			; Navigation data
		jsr C0EE24			; Relocate cursor
		LDY #C0EE0D			; Yes pointer
		JSL C302F9			; Draw text
		LDY #C0EE13			; No pointer
		JSL C302F9			; Draw text
		LDA #$01			; Sustain
		STA $26
		RTL

; Sustain Switch
; Handle A	
C0ED80:	jsr C0EE20			; Handle D-Pad
		lda $08				; No-autofire keys
		bit #$80			; Pushing A?
		BEQ C0EDB8			; Branch if not
		LDA $4D				; On Yes?
		BNE C0EDB8+6		; exit if not
		JSR C0EE42			; Play click
		JSR C0EE2C			; Blank messages		
		REP #$20			; 16 bit-A
		LDA #$161E			; Equipped esper base position
		CLC					; Prepare addition
		ADC $FD				; Possessor ID
		TAX					; Idex it
		SEP #$20			; 8 bit-A
		LDA #$FF			; Remove esper
		STA $00,X			; ^
		JSL actor_id		; Jump long and bring actual actor id
		REP #$20			; 16 bit-A
		CLC					; Prepare addition
		ADC #$161E			; Equipped esper position
		SEP #$20			; 8 bit-A
		TAX					; Index it
		LDA $99				; Viewed esper
		STA $00,X			; Save in actual actor SRAM
		STA $E0				; Memorize for redraw
		LDA #$20			; Remove "flag" on
		RTL
; Handle B
C0EDB8:	LDA $09				; No-autofire keys
		BIT #$80			; Pushing B?
		BEQ C0EDE3			; Branch if not
		JSR C0EE42			; Play click
		JSR C0EE2C			; Blank messages
		LDA $8E				; Old cursor column
		STA $4D				; Set onscreen col
		LDY $8E				; Old cursor loc
		STY $4F				; Set as current
		LDA $90				; Old scroll pos
		STA $4A				; Set as current
		LDA $4A				; ...
		STA $E0				; Memorize it...
		LDA $50				; List row
		SEC    				; Prepare SBC
		SBC $E0				; Deduct scroll pos
		STA $4E				; Set cursor row
		JSL C34C24			; Relocate cursor
		LDA #$1E
		STA $26
C0EDE3: RTL	

; Equip from another actor routines

; Text
C0EDE4: dw $40CD : db "                           ",$00
C0EE02: dw $4151 : db "   ",$00
C0EE08: dw $415D : db "  ",$00
C0EE0D: dw $4151 : db "Yes",$00
C0EE13: dw $415D : db "No",$00 


; Load navigation data
C0EE18:	LDY #navi_data			; Navigation dataaddress
		JSL.l C305FE			; Load navig data
		RTS
		
; Handle D-Pad
C0EE20:	JSl.l C3072D			; Handle D-Pad	
C0EE24:	LDY #esp_crsr			; Cursor Position address
		JSL.l C30640			; Relocate cursor
		RTS

; Blank Messages
C0EE2C:	LDY #C0EDE4			; Yes pointer
		JSL C302F9			; Blank message
		LDY #C0EE02			; No pointer
		JSL C302F9			; Blank message
		LDY #C0EE08			; Text pointer
		JSl C302F9			; Blank message	
		RTS
		
; Play click sound
C0EE42: LDA #$20        ; APU command
        STA $002140     ; Set I/O port 0
        RTS
C0EE4A: JSR C0EE2C
		RTL

; Jump from long
org $C3feB6
C34C24:	jsr $064B	      ; Relocate cursor
		rtl
	
org $C3FFD8
C305FE:	jsr $05FE
		rtl
C30640:	jsr $0640
		rtl
C3072D: jsr $072D
		rtl
C302F9:	STY $E7			; Set src LBs
        LDA #$C0		; Bank: C4
        STA $E9			; Set src HB
		jsr $02fF
		rtl


	
org $c0dd68
print_rmv_actor:
	LDA #$10			; Reset/Stop desc
	TSB $45				; Set menu flag
	LDA #$20        	; Palette 0
	STA $29         	; Color: User's
	REP #$20        	; 16-bit A
	LDA #$40CD      	; Tilemap ptr
	STA $7E9E89     	; Set position
	LDA #$9E8B      	; 7E/9E8B
	STA $2181       	; Set WRAM LBs
	SEP #$20        	; 8-bit A
	
	LDX $00         	; Letter: 1st
	BIT $FB				; Is esper equippable?
	BPL +               ; Branch if not

load_next:
	LDA.L Equip_from,X	; Message letter
	BEQ done      		; Done if end
	STA $2180       	; Add to string
	INX             	; Point to next
	BRA load_next   	; Do next letter	
	
done:
	LDX $FD				; Actor ID
	LDY #$0006      	; Letters: 6
	JML actor_name		; Actor name letters

cant_letter:	
+	LDA.l NoEqTxt,X
	STA $2180         ; Print the current letter.
	BEQ .exit         ; If the letter written was null ($00), exit.
	INX               ; Go to the next letter.
	BRA cant_letter
.exit
	JML C326F5
	
NoEqTxt:
  db "Can't equip!",$00
  

actor_chk:	bit $fb			; esper equippable?
			bpl terra_cant  ; uneqippable esper and branch 
actor_id:	phx
			tdc
			tax
			lda $28			; load actor index
			tax				; index it
			lda $69,x		; load actor ID
			sta $211B		; set multiplicand LB 
			stz $211B		; clear HB
			lda #$25		; set multiplier
			sta $211C		; ...
			lda $2135		; product Hi-Byte
			XBA				; exchange with lo-byte
			lda $2134		; product Lo-Byte = which actor are you in
			plx				; clear X
			rtl
Equip_from:
	db "Take it from ",$00
	
terra_cant:
	inc $fd			; inc id check and make no equal to Terra ID
	rtl
	

