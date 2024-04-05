arch 65816
hirom

table "menu.tbl", ltr


;#########################################################################;
;                                                                         ;
;	Esper menu redefined                                                  ;
;                                                                         ;
;#########################################################################;

; Refresh BG1 Tilemap B after "Handle Esper Selectione" while holding Yes
org $C327EF
C327EF:	LDA $0D			; Key
		BIT #$40		; Holding ?
		BEQ .skip		; Branch if not
		JMP check_for_y	; Jump to chek Y button
.skip
		JMP C358D7		; Jump to go on with regular code

		
warnpc $C327FB

; 1E: Handle esper selection
org $C328D3
C328D3:	LDA #$10        ; Description: On
        TRB $45         ; Set menu flag
        LDA #$04        ; List type: Espers
        STA $2A         ; Set redraw mode
        JSR $0EFD       ; Queue list upload
        JSR $1F64       ; Handle L and R
        BCS C32928      ; Exit if pushed
        JSR $4C1E       ; Handle D-Pad
        JSR $56DF       ; Load description
		LDA $08         ; No-autofire keys
        BIT #$80        ; Pushing A?
        BEQ C3291B      ; Branch if not
        JSR $0EB2       ; Sound: Click
C328F2: TDC             ; Clear A
        LDA $4B         ; Selected slot
        TAX             ; Index it
        LDA $7E9D89,X   ; Esper in slot
        CMP #$FF        ; None?
        BEQ C32908      ; Unequip if so
        STA $99         ; Memorize esper
		JSR SelectEsperSplice	; Load Cursor pos., store and Init submenu
        LDA #$4D        ; C3/58CE
        STA $26         ; Next: Data menu
        RTS
		
; Fork: Unequip esper
C32908: LDA #$FF        ; Value for empty
        STA $E0         ; Set esper to equip
        JSR C32929      ; Clear esper held
        JSR $546C       ; Redraw esper list
        JSR $0F11       ; Queue desc upload (BG1 Tilemap B)
        JSR $1368       ; Refresh held esper
        JMP $0EFD       ; Queue list upload (BG1 Tilemap A)
;		JSR $1488
;		JMP $0F4D
		
; Fork: Handle B
C3291B: LDA $09        		; No-autofire keys
        BIT #$80       		; Pushing B?
        BEQ C32928     		; Exit if not
        LDA #$08       		; Blinker: Off
        TRB $46        		; Set menu flag
        JSR $29A5			; Leave submenu
C32928:	RTS

; Equip and draw selected esper
C32929: TDC          		; Clear A
		LDA $28      		; Member slot
		ASL A        		; Double it
		TAX          		; Index it
		LDY $6D,X    		; Actor's address
		LDA $E0      		; Chosen esper
		STA $001E,Y   		; Assign to actor
		LDA $E0       		; ...
		JMP DrawEsperHook	; include esper equip bonuses
	
; 34: Wait while showing who holds esper (Changes to gain space and)

C3293A: LDY $20				; Timer expired?
        BNE C32947			; Exit if not
        JSL C0EE4A			; Jump long and blank messages
        JMP C35913			; Exit submenu
C32947: RTS

; Unequip from sub-menu
unequip_esper:
		jsr $2908			; Equip and draw selected esper
		ldy #$0000			; Clear Y
		jmp C326FB			; Exit Delay

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

; Draw "<actor> has it!" in esper data menu (20 free bytes)
org $C3559A
C3559A:  
	JML C0DD68			; Go to print <Can't Equip or [Equip from <Actor>] 
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

; Add charchter name on desc
org $C356e2
	jmp C35ADC

org $C35ADC
C35ADC:
	jml C9FD10		; Print who can equip esper

; Load skill or item description	
org $c9fd10
C9FD10:	LDX #$9EC9      	; 7E/9EC9
		STX $2181       	; Set WRAM LBs
		TDC             	; Clear A
		LDA $4B         	; List slot
		TAX             	; Index it
		LDA $7E9D89,X   	; Skill or item
		PHA					; Save for after
		CMP #$FF        	; Empty slot?
		BEQ C3576D      	; Blank if so
		REP #$20        	; 16-bit A
		ASL A           	; Double it
		TAY             	; Index it
		LDA [$E7],Y     	; Relative ptr
		TAY             	; Index it
		SEP #$20        	; 8-bit A
.loop	
		LDA [$EB],Y     	; Text character
		BEQ C3574F      	; Branch if 00h
		STA $2180       	; Add to string
		INY             	; Index +1
		BRA .loop			; Do next char
C3574F:	tdc
		PLA 				; Restore Esper ID
		ASL
		TAX
		rep #$20
		LDA.l esper_equip,X	; get equippability byte for esper/character pair 
		stz $e0				; Terra
		ldx $00				; Esper done:0
C38529: LSR A          		; Actor can use?
        BCC .skip     		; Skip if not
        PHA            		; Save compat.
        SEP #$20       		; 8-bit A
        LDA $E0        		; Current actor
		
		jsr .print 

        REP #$20       		; 16-bit A
        PLA            		; Compatibility
.skip:	SEP #$20       		; 8-bit A
        INC $E0        		; Actor number +1
        REP #$20       		; 16-bit A
        INX            		; Esper done +1
        CPX #$001E     		; Done all?
        BNE C38529     		; Loop if not
        SEP #$20       		; 8-bit A
        LDA #$FF       		; Terminator
        STA $2180      		; End list		
		jml $C3574F		
		
		

.print  phx
		sta $211b
		stz $211b
		lda #$25
		sta $211c
		ldx $2134
		lda #$ff
        STA $2180      		; Add to list
		ldy $00
		inx #2
.loop		
		lda $1600,X
		cmp #$FF
		beq .end
        STA $2180      		; Add to list
		inx
		iny
		cpy #$0006
		beq .end
		bra .loop
.end
		plx
		rts
		
C3576D: JML $C3576D		

warnpc $C9FE00
org $d86f80
esper_equip:
	dw $0042	; 	Ramuh	
	dw $0102	; 	Ifrit	
	dw $00C0	; 	Shiva	
	dw $0050	; 	Siren	
	dw $0420	; 	Terrato	
	dw $0600	; 	Shoat	
	dw $0401	; 	Maduin	
	dw $0005	; 	Bismark	
	dw $0820	; 	Stray	
	dw $0410	; 	Palidor	
	dw $0001	; 	Tritoch	
	dw $0080	; 	Odin	
	dw $0000	; 	Loki	
	dw $0100	; 	Bahamut	
	dw $0044	; 	Crusader
	dw $0001	; 	Ragnarok
	dw $0040	; 	Alexande
	dw $0006	; 	Kirin	
	dw $0100	; 	Zoneseek
	dw $0081	; 	Carbuncl
	dw $0048	; 	Phantom	
	dw $0240	; 	Seraph	
	dw $0030	; 	Golem	
	dw $0001	; 	Unicorn	
	dw $0808	; 	Fenrir	
	dw $0300	; 	Starlet	
	dw $0003	; 	Phoenix	
	
warnpc $d87000


; Character esper data table. See below for specifics.
;EsperData:
;  db $C0,$84,$88,$04 ;1 Terra
;  db $03,$00,$02,$04 ;2 Locke
;  db $80,$40,$02,$00 ;4 Cyan
;  db $00,$00,$10,$01 ;8 Shadow
;  db $08,$02,$C0,$00 ;10 Edgar
;  db $10,$01,$40,$00 ;20 Sabin
;  db $0D,$40,$31,$00 ;40 Celes
;  db $04,$08,$0C,$00 ;80 Strago
;  db $02,$20,$04,$02 ;1 Relm
;  db $20,$00,$20,$02 ;2 Setzer
;  db $70,$02,$00,$00 ;4 Mog
;  db $00,$01,$00,$01 ;8 Gau
;  db $00,$00,$00,$00 ; Gogo
;  db $00,$00,$00,$00 ; Umaro
;  db $00,$00,$00,$00 ; Slot 15
;  db $00,$00,$00,$00 ; Slot 16

; Byte 1        Byte 2         Byte 3         Byte 4
; $01: Ramuh    $01: Stray     $01: Alexandr  $01: Fenrir
; $02: Ifrit    $02: Palidor   $02: Kirin     $02: Starlet
; $04: Shiva    $04: Tritoch   $04: Zoneseek  $04: Phoenix
; $08: Siren    $08: Odin      $08: Carbunkle $08: N/A
; $10: Terrato  $10: Raiden    $10: Phantom   $10: N/A
; $20: Shoat    $20: Bahamut   $20: Seraph    $20: N/A
; $40: Maduin   $40: Crusader  $40: Golem     $40: N/A
; $80: Bismark  $80: Ragnarok  $80: Unicorn   $80: N/A

org $C35897
; Initialize esper data menu
C35897: LDY $4F         ; Cursor position
        STY $8E         ; Set return loc
        LDA $4A         ; Scroll position
        STA $90         ; Set return loc
        JSR $5B54		; Load esper info
        JSR $599F		; Draw esper info
        JSR $0F11		; Queue its upload
        JSR $1368		; Upload it now
        JSR $0EFD		; Requeue esper list
        REP #$20        ; 16-bit A
        LDA #$0100      ; BG1 H-Shift: 256
        STA $7E9A10     ; Hide esper list
        SEP #$20        ; 8-bit A
		JSL InitEsperDataSlice
        LDA #$07        ; BG1 VRAM row: 7
        STA $49         ; Save for V-Shift
		JSL C0EC20      ; Load V-shift data
		LDY #C36122		; $C3/6122
		JSR $1173		; Create Blinking Y
		JMP C35986      ; Relocate cursor
warnpc $c358ce

; Changing "[actor] has it" into "You have equipped"
; 4D: Sustain esper data menu (12 free bytes)
org $C358CE
		JSR active_desc		; Active description, handle d-pad and load desc
		JMP C327EF			; Jump to avoid press A while pressing Y
C358D7:	LDA $08         	; No-autofire keys
		BIT #$80       		; Pushing A?
		BEQ C3590A			; Branch if not
		TDC            		; Clear A
		jmp check_slot  	; support Spell Bank and EL Bonus Selection
can_equip_fork:	
		BNE C3590A			; Branch if not Esper slot
		LDA $99         	; Viewed esper
		JSR $5574      		; Choose palette
		STA $E0         	; Memorize esper
		LDA $FC         	; Esper palette
		CMP #$20        	; Is esper color white?
		BEQ C35902			; Branch if it is
		jsl actor_chk		; Go to check if actor and esper equipped actor are the same
		cmp $FD				; actor and esper equipped actor are the same? 
		beq is_the_same		; Is the same so you can unequip
		JSR $0eb2       	; Play menu sound
		jmp C3559A			; Draw <Actor Has it or Can't equip>
is_the_same:
		jsr $0EB2
		jmp unequip_esper
	
; Fork: Equip esper
C35902:	jsr $0eb2	; Sound click
		jsr C32929	; Equip/Draw esper
		BRA C35913      ; Exit submenu

; Fork: Handle B
C3590A: LDA $09         ; No-autofire keys
        BIT #$80        ; Pushing B?
        BEQ C3597C      ; Exit if not
        JSR $0EA9       ; Sound: Cursor
C35913: LDA #$10        ; Reset/Stop desc
        TSB $45         ; Set menu flag
        LDA $5F         ; Top BG1 write row
        STA $49         ; Restore it
        JSR $546C       ; Draw esper list
        JSR $091F       ; Create scrollbar
        REP #$20        ; 16-bit A
        LDA #$1300      ; V-Speed: 16 px
        STA $7E354A,X   ; Set scrollbar's
        LDA #$0068      ; Y: 96
        STA $7E34CA,X   ; Set scrollbar's
        SEP #$20        ; 8-bit A
        JSR $4C18       ; Load navig data
        LDA $8E         ; Old cursor column
        STA $4D         ; Set onscreen col
        LDY $8E         ; Old cursor loc
        STY $4F         ; Set as current
        LDA $90         ; Old scroll pos
        STA $4A         ; Set as current
        LDA $4A         ; ...
        STA $E0         ; Memorize it...
        LDA $50         ; List row
        SEC             ; Prepare SBC
        SBC $E0         ; Deduct scroll pos
        STA $4E         ; Set cursor row
        JSR $4C21       ; Relocate cursor
        LDA #$05        ; Top row
        STA $5C         ; Set scroll limit
        LDA #$08        ; Onscreen rows: 8
        STA $5A         ; Set rows per page
        LDA #$02        ; Onscreen cols: 2
        STA $5B         ; Set cols per page
        JSR $0EFD       ; Queue list upload (BG1 Tilemap A)
        JSR $1368       ; Refresh esper list
        REP #$20        ; 16-bit A
        TDC             ; BG1 H-Shift: 0
        STA $7E9A10     ; Unhide esper list
        SEP #$20        ; 8-bit A
        LDY #$0100      ; X: 256
        STY $39         ; Set BG2 X-Pos
        STY $3D         ; Set BG3 X-Pos
        JSR $4E2D       ; Load V-shift data
		JSR C3A20A		; In Magic ASM - Transfer to RAM BG1 Tilemap B (Desc)
        LDA #$1E        ; C3/28D3
        STA $26         ; Next: Esper choice
		RTS				; Back to loop
C3597C:	JMP check_for_y	; Jump to routine that can return the target_power data
	

; Load navigation data for esper data menu
C35980:	LDY #C3598F     ; C3/598C
		JMP $05FE      ; Load navig data

; Handle D-Pad for esper data menu
C35983: JSR $072D		; Handle D-Pad
C35986: LDY #C35994		; C3/5991
        JMP $0640		; Relocate cursor	
; Navigation data for esper data menu
C3598F:
	db $80          ; Wraps vertically
	db $00          ; Initial column
	db $00          ; Initial row
	db $01          ; 1 column
	db $05          ; 6 rows
	
; Cursor positions for esper data menu
C35994:
	dw $7210        ; Esper
	dw $7e18        ; Spell A
	dw $8a18        ; Spell B
	dw $9618        ; Spell C
	dw $c418        ; Bonus

warnpc $c3599f		 

; Load vertical shift values for BG1 text in skill menus
org $c0ec20
C0EC20:	LDX $00         ; Index: 0
C0EC21:	LDA.L C0EC74,X  ; Stats V-Data
		STA $7E9849,X   ; Save in RAM
		INX             ; Index +1
		CPX #$0012      ; At skills?
		BNE C0EC21      ; Loop if not
C0EC30:	LDA.L C0EC74,X  ; Skill V-Data
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
		ADC.L C0EC74,X  ; Add V-Data
		STA $7E9849,X   ; Save in RAM
		SEP #$20        ; 8-bit A
		INX             ; Index +1
		INX             ; Index +1
		CPX #$005A      ; Past list?
		BNE C0EC30      ; Loop if not
C0EC56:	LDA.L C0EC74,X  ; Bottom V-Data
		STA $7E9849,X   ; Save in RAM
		INX             ; Index +1
		CPX #$005e      ; End of table?
		BNE C0EC56      ; Loop if not
		LDA #$C0        ; Scrollbar: Off
		TRB $46         ; Set anim index		
		phk				; push 
		per $0006		; push return
		pea $96EE		; push address
		jml C35980		; Load navig data

		RTL

; BG1 V-Shift table for skill menus (condenses text)
C0EC74:	db $3F,$00,$00  ; LV
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
		LDA $50				; List row
		STA $4E				; Set cursor row		
		JSL C30677			; Relocate cursor
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
		
warnpc $c0eea0

org $c0dd68
C0DD68:
		LDA #$10			; Reset/Stop desc
		TSB $45				; Set menu flag
		LDA $0D				; Handle Button
		BIT #$40			; Pushing Y?
		BEQ .not
		JSL clear_pwr_trgt	; Routine that clear Desc box from target and power text
.not	
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
+		LDA.l NoEqTxt,X
		STA $2180         ; Print the current letter.
		BEQ .exit         ; If the letter written was null ($00), exit.
		INX               ; Go to the next letter.
		BRA cant_letter
.exit
		JML C326F5
	
NoEqTxt:  db "Can't equip!",$00

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

org $c0de10
clear_pwr_trgt:
	tdc				; Clear A
	tax             ; Clear X
.loop
	sta $7E810D,x   ; Clear Ram
	inx             ; Inc X
	cpx #$0040      ; Finish?
	bne .loop       ; Branch if not
	rtl

	
; which number option finger cursor allow EL bonus
org $C33BE2
	cmp #$04		; row index description msg bouns print

org $C33BE9
	jmp SummonDescription
	
; ------------------------------------------------------------------------
; Helper for Summon Descriptions (in freespace)

org $C3f46B           ; 29 bytes, we'll use 24 >.>
SummonDescription:    ; Load Esper summon description
  LDX #EsperDescPointers 
  STX $E7             ; Set ptr loc LBs
  LDX $00
  STX $EB             ; Set text loc LBs
  LDA #$Cb            ; Pointer/text bank
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

org $c0ee50
DrawEsperMP:
	LDA #$FF
	STA $2180       	; 3 spaces
	STA $2180
	STA $2180
	LDA $99     	    ; Current Esper
	ADC #$36  	        ; Get attack ID
	PHX
	phk					; push 
	per $0006			; push return
	pea $96EE			; push address
	jml $c350F5     	; Compute index
	LDX $2134       	; Load it
	LDA $C46AC5,X   	; Base MP cost
	PLX
	phk						; push 
	per $0006				; push return
	pea $96EE				; push address
	jml $C304E0       	; Turns A into displayable digits
	LDA $F8         	; tens digit
	STA $2180
	LDA $F9         	; ones digit
	STA $2180
	LDA #$FF        	; space
	STA $2180
	LDA #$8C   		    ; M
	STA $2180
	LDA #$8F        	; P
	STA $2180
	STZ $2180       	; EOS
	RTL
warnpc $c0eea0

org $c3fd96
	jsl DrawEsperMP
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
pad $c35adc
warnpc $c35adc


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

org $C35Ca7
splabel:	dw $462f : db "SP",$00
learnlabel:	dw $4435 : db " Learn",$00
thirty:		dw $463B : db "/30",$00
EL_Bonus:	db "EL Bonus ",$00				;fd86

org $C3F41A 
	LDY #$47b5	; Unspent EL quantity coordinates
	
org $c3f751
	ldx #$4637	; unspent SP quantity coordinates


org $c3599f :	lda #$24
org $c359a3	:	ldy #learnlabel
org $c359a9	:	ldy #splabel
org $c3fd7c	:	ldy #thirty

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
;org $C32900
;    JSR SelectEsperSplice  ; perform splice after selecting esper
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
