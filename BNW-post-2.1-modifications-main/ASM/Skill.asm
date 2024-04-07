arch 65816
hirom

; Init Bushido Menu
org $C320fd
	jsr pbshdo
	
; Init Blitz Menu
org $C32114	
	jsr pblitz

; Init Magic Menu
org $C32125
	jsr pmagic

; Init Lore Menu
org $c3219e
	JSR plore

; Setting Skills property address on $0100
org $C35A6A
pmagic:	LDX #$6AC0		; Magic at $C4/6AC0
		BRA goprev 
pesper: JSR $5452 	    ; Draw espers, etc.
		LDX #$6DB4		; Esper at $C4/6DB4
		BRA goprev			
pblitz: JSR $55D4   	; Draw inputs, etc.	
		LDX #$6FD6		; Blitz at $C4/6FD6
		BRA goprev		 
pbshdo:	JSR $52D7   	; Draw techs, etc.
		LDX #$6F66		; Bushido at $C4/6F66
		BRA goprev		 
plore:	JSR $51F9   	; Draw lores, etc.
		LDX #$725A		; Lore at $C4/725A	 
goprev:	STX $0100		; Store
		LDA #$C4		; Bank
		STA $0102
		RTS

; From Bushido
Bpwrtrgt:
	jsr $5700      ; Load description
	jmp compute_null		; Routine that manage Y button	
	
Blitzpwrtrgt:
	jsr $5715		; Load Descritpion
	jmp compute_null		; Routine that manage Y button	

Lorepertrgt:
	jsr $56eb		; Load Descritpion
	jmp compute_null		; Routine that manage Y button		

Dancepwrtrgt:
	
	jsr $4bd4					; Handle D-Pad
	
	lda $0D
	bit #$40		           	; holding Y?	
	BEQ .exit					; Branch if not
	lda $c0						; 2nd desc must be show
	bne .animal_desc			; Branch if so
	jsr reset_vwf				; Clear Desc to show 2nd desc
	inc $C0						; Active animal desc flag
.animal_desc
	LDX #animal_dance_pointers
	STX $E7          			; store pointer offset
	LDX $00    					; use base offset for text
	STX $EB          			; ^ will be added to Y index
	LDA #$D8         			; bank
	STA $ED		 				; text bank
	STA $E9          			; pointer bank
	lda #$10					; Desc on
	trb $45						; Set
	jmp $572a					; Print animal desc
.exit
	lda $C0						; Already reset animal desc?
	beq .do_not_reset			; Branch if so
	stz $C0						; Reset flag
	jsr reset_vwf				; Reset vwf
.do_not_reset
	jmp $fcb5					; Go to print normal desc.

warnpc $C35ae1

org $C3fC99
reset_vwf:
	lda #$10					; Desc of
	tsb $45						; Set
	jmp $11b0					; Reset VWF

; Sustain blitz
org $C32981
	jsr Blitzpwrtrgt			; Active Power and target
	
; Sustain Lore
org $C3289D
	jsr Lorepertrgt				; Active power and target
	
; Sustain Dance
org $C328AA
	jsr $0EFD					; Upload BG	
	jsr Dancepwrtrgt			; Go to load Desc
	
warnpc $c328b1

; Dance 2nd screen

org $D8EE47
animal_dance_pointers:
	dw #a_wind
	dw #a_forest
	dw #a_desert
	dw #a_love
	dw #a_earth
	dw #a_water
	dw #a_dusk
	dw #a_snowman
	
animal_dance_text:
a_wind:		db	$14," Cock",$07,"rice:Non-e",$E1,"ment",$E2,$EB,"mg|Igno",$F1,$E0,"def.,",$F7,$E5,$E0,"[P",$E5,"r",$F5,"y]",$00
a_forest:	db	$14," Raccoon:Cu",$F1,$E0,"HP to max|L",$F5,"t",$E0,"most ba",$F4,"st",$07,"use",$E0,"- party",$00
a_desert:	db	$14," Meerk",$07,":|S",$E5,$E0,"[Image]/[Haste]",$0E," party",$00
a_love:		db	$14," Tapir:Cu",$F1,$E0,"MP|L",$F5,"t",$E0,$E2,"l ba",$F4,"st",$07,"use",$E0,"- party",$00
a_earth:	db	$14," Wil",$F4,"Boars:Non-e",$E1,"ment",$E2,$EB,"mg|Igno",$F1,$E0,"def., groun",$F4,$07,$F0,"ck",$00
a_water:	db	$14," Toxic Frog:",$FD,"/",$EF,",",$F7,$E5,$E0,"[Poison]",$00
a_dusk:		db	$14," Womb",$07,":Non-e",$E1,"ment",$E2,$EB,"mg|Igno",$F1,$E0,"def., groun",$F4,$07,$F0,"ck",$03,"- ",$E2,"l foes",$00
a_snowman:	db	$14," Ice Rabbit:Cu",$F1,$E0,"HP to max|S",$E5,$E0,"[Image]",$0E," party",$00
	
warnpc $D8EFFE
