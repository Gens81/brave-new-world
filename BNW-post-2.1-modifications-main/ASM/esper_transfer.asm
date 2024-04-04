arch 65816
hirom
table "menu.tbl", ltr

org $C3f69b
active_desc:
	LDA #$10        ; Description: On
	TRB $45         ; Set menu flag
	JSR C35983    	; Handle D-Pad
	jmp $5B93       ; Load description

warnpc $C3F6B0	


org $C3876b
check_for_y:
	jsl chek_if_shown
	jmp compute_null
.rts
	rts

el_bonus:
	jsr $a662			; go to redraw desc
	jsr $a991			; Set to upload VWF description, freeze CGRAM
	jmp $0F4D			; refresh bg3 tilemap b


padbyte $FF
pad $c3877f	
warnpc $c3877f	

org $c479e0
chek_if_shown:	
	LDA $4B					; Cursor pos
	BNE .not_esper			; Branch if not esper slot
	ldx #$6DB4				; Esper at $C4/6DB4
	bra .push_y
.not_esper
	LDX #$6AC0				; Magic at $C4/6AC0
.push_y
	stx $0100
	LDA #$C4				; Bank
	STA $0102
	rtl

warnpc $c47a40


org $C3f798
check_slot:
org $C3f79c
JMP can_equip_fork


;Rearrange esper data to fit power target hack
org $C30243
	dw C3293A		; Old Wait while showing who holds esper


org $C31ff4
	JSR clear_bg1_skill
	
ORG $C326F5
clear_bg1_skill:
	lda #$10  
	tsb $45 
	lda #$C0
	trb $46
	ldx #$0b00
	jsr $6a4e 
	jmp $0f11
	
padbyte $FF
pad $C32706

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
	jmp C328F2			; C328F2
.remove
	jmp C35902

	
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



; Jump from long
org $C3feB6
C30677:
		jsr $0677	      ; Set cursor slot
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


	
