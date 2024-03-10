hirom

table "menu.tbl",ltr

org $C3028B
	dw rage_stats_init		; 58: unused duplicate
	dw rage_stats_sustain	; 59: bogus

; Init Rage
org $C321d6
	jsr active_y
	
org $C37f7b
	active_y:
	jsr $5391
	lda #$01
	LDY #C36111							; C3/6510
	Jmp $1173							; Queue OAM fn
warnpc $c37f88

; 1D: Sustain Rage menu
org $C328BA
C328BA: LDA #$03        ; List type: Rages
        STA $2A         ; Set redraw mode
        JSR $FCBE
		JSR $0EFD	    ; Queue list upload
        JSR $1F64       ; Handle L and R
        BCS C328D2      ; Exit if pushed
        JSR $4C52       ; Handle D-Pad
		JSR C39FA7		; Handle Pad
C328D2: RTS

warnpc $C328D3
	
org $C39FA7
; Sustain Rage menu - Handle Pad
; Handle B
C39FA7: LDA $09         ; No-autofire keys
        BIT #$80        ; Pushing B?
        BEQ C39FB0      ; Exit if not	 
        JMP $29A5       ; Leave submenu		

; Handle Y
C39FB0:	LDA $09			; No autofire keys	 
		BIT #$40		; Pushing Y?
		BEQ C39FBA      ; Exit if not
		LDA $4B			; Rage slot
		TAX				; index
		LDA $7E9D89,X	; Rage
		CMP #$FF		; 
		BNE .learned    
		JMP $2862		; Unusable
.learned		        
		jsr $0eb2		; click noise
		LDA #$58		; 58: init Rage sub-menu
		STA $26			; Queue 
C39FBA: RTS

 
        
; 58: Init Rage sub-menu
rage_stats_init: 
		lda #$20					; cursor: blank and Inactive D-PAD effect on refreshing Desc.
		STA $45						; set menu flag------------------------|
		lda #$C0					; scrollbar: off                       |
		trb $46						; set anim index                       |
		JSR $6a15					; clear bg1 map A                      |
		LDX #$4A00					; $7E/8249                             |
		JSR $6A4E					; clear bg3 map b	                   |
		jsr draw_rage				; print rage name                      |
		jsr title_rage				; print title and laber text           |
		jsr rage_light_up			; light up label and print elements    |
		jsr $0E28					; Upload BG1 tilemaps A and B          |
		jsr $0E36					; Upload BG1 tilemaps B and C          |
		lda #$59					; 59: Rage Stats sustain               |
		sta $26						; Set                                  |
		RTS	                        ;                                      |=> Usually it should be used TRS or TSB
									;									   |=> With STA we waste less byte
rage_stats_sustain:			        ;                                      |
		jsr $0F4D					; Upload BG3 tilemaps A and B          |
		lda $09						; no-autofire                          |
		bit #$40					; pushing Y?                           |
		beq sustain_y				; exit if not                          |
		JSR $6A15     				; Clear BG1 map A                      |
		LDX #$4A00					; $7E/8249                             |
		JSR $6A4E					; clear bg3 map b	                   |
		JSR $53A7      				; Draw Rage list                       |
		jsr $0eb2					; click noise                          |
        JSR $091F   		    	; Create scrollbar		               |
		lda #$04					; Cursor & Desc.                       |
		STA $45						; On---------------------------------- |
		lda #$1D					; 1D: sustain rage menu
		sta $26						; Set
sustain_y:
        rts

title_rage:
		lda #$2c					; palette
		sta $29						; color: blue
		LDX #title_txt				; Title text pointer
		LDY #$000A					; 5 pointers
		JSR $69BA					; Print muli string
		LDA #$24					; palette
		STA $29						; color: grey
		LDX #rage_label				; LAbel text pointer
		LDY #title_txt-rage_label	; 20 pointers
		JMP $69BA

rage_label:
	dw #rage_blind
	dw #rage_poison
	dw #rage_imp
	dw #rage_petrify
	dw #rage_death 
	dw #rage_mute
	dw #rage_berserk
	dw #rage_muddle	
	dw #rage_sleep 
	dw #rage_stop
 	dw #rage_regen 
	dw #rage_haste
	dw #rage_float
	dw #rage_shell
	dw #rage_safe	
	dw #rage_reflect	
	dw #rage_slow
	dw #rage_sap
	dw #rage_undead
	dw #rage_sap2
		
title_txt:
	dw #weak_txt
	dw #absorb_txt
	dw #no_damage
	dw #blocks_txt
	dw #innate_txt


rage_blind:			dw $84d1-2	: db $5d,$5e,$5f,$00
rage_poison:    	dw $84d7-2	: db $49,$4a,$4b,$00
rage_imp:        	dw $84df-2	: db $56,$29,$00
rage_mute:       	dw $8511-2	: db $30,$27,$33,$00
rage_muddle:     	dw $8517-2	: db $30,$31,$32,$33,$00
rage_berserk:    	dw $851f-2	: db $34,$35,$36,$37,$00	
rage_sleep:			dw $8551-2	: db $2a,$2b,$29,$00
rage_petrify:    	dw $8557-2	: db $2c,$2d,$2e,$2f,$00
rage_death:      	dw $855f-2	: db $46,$38,$48,$00
rage_stop:       	dw $8591-2	: db $40,$41,$00
rage_slow:			dw $8597-2	: db $2A,$4c,$4D,$00
rage_sap:			dw $859f-2	: db $28,$29,$00
rage_safe:      	dw $8651-2	: db $28,$45,$00
rage_haste:   		dw $8657-2	: db $42,$43,$44,$00
rage_regen:     	dw $865f-2	: db $20,$21,$22,$00
rage_shell:     	dw $8691-2	: db $53,$54,$55,$00
rage_reflect:   	dw $8697-2	: db $20,$25,$26,$52,$00
rage_sap2:			dw $869F-2	: db $28,$29,$00
rage_float:			dw $86D1-2	: db $50,$51,$52,$00
rage_undead:    	dw $86D7-2	: db $3E,$5A,$5B,$00


	
weak_txt:	dw $862B : db "Weakness",$00	; 3913
absorb_txt:	dw $84AB : db "Absorb",$00		; 3993
no_damage:	dw $856B : db "No Damage",$00	; 3a13
blocks_txt:	dw $848F : db "Blocks",$00		; 3b13
innate_txt:	dw $860F : db "Innate",$00		; 3b93		
		
draw_rage:
		JSR $5409				; define source
		lda $4b					; slot
		sta $e5					; rage slot?
		ldx #$840D				; Pointer
		JSR $541E				; draw rage name
		rts

rage_light_up:
		TDC						; Clear A
		TAX                     ; A to X
		STX $DC                 ; Clear $DC
		STX $DE                 ;	^	$DE
		LDA $4B					; Rage in slot
		TAX						; Index it
		LDA $C4A7E0,X			; Rage ID - Multiplicand
		STA $211B				; Set Low-Byte
		STZ $211B				; Clear Hi-Byte
		LDA #$20				; Multiplier
		STA $211C				; Set Low-Byte
		LDX $2134				; Load results and index it
		LDA #$20				; User Color
		STA $29					; Set
		LDA $CF0012,X			; Undead byte
		AND #$80				; Check Bit - Undead?
		BEQ .not_undead			; Branch if not
		LDY #rage_undead		; Label pointer		
		JSR $02F9				; Print
.not_undead
		LDX $2134				; Monster index
		LDA $CF0016,X			; Block byte "Stop"
		AND #$10				; Check Bit - Can block Stop?
		BEQ .not_stop			; Branch if not
		LDY #rage_stop			; Label pointer
		JSR $02F9				; Print
.not_stop
		LDX $2134				; Monster index
		LDA $CF001C,X			; Innate byte "Sap"
		AND #$40				; Check Bit - Innate Sap?
		BEQ .not_sap			; Branch if not
		LDY #rage_sap2			; Label pointer
		JSR $02F9               ; Print
.not_sap
		LDA #$04				; Counter
		STA $DC					; Set
		LDX $00					; Load $0000 in X
		STX $DD					; Clear $DD
		LDX $2134				; Monster Index
		LDA $CF0014,X			; Blocks byte 1
		JSR check_rage			; Check and light up
		LDA #$05                ; Counter
		STA $DC                 ; Set
		LDA $CF0015,X			; Blocks byte 2
		JSR check_rage			; Check and light up

		LDA #$07                ; Counter
		STA $DC                 ; Set
		LDA $CF001D,X			; Blocks byte
		JSR check_rage			; Check and light up
		
		TDC                     ; Clear A
		LDA $CF0017,X			; Absorb byte
		LDX #$84EB				; Element Pointer
		JSR C388AE				; Build List
		JSR C388F8				; Draw List 
		TDC                     ; Clear A
		LDX $2134				; Monster index
		LDA $CF0018,X			; No Damage byte
		LDX #$85AB				; Element Pointer
		JSR C388AE				; Build List
		JSR C388F8				; Draw List 
		LDX $2134				; Monster index
		TDC                     ; Clear A
		LDA $CF0019,X			; Weakness byte
		LDX #$866B				; Element Pointer
		JSR C388AE				; Build List
		JMP C388F8				; Draw List 
		
check_rage:
		STA $DF						; Set to check
.next_bit
		LDX $DD						; Load index
		LDA.l statuses_bitmask,X	; Load Bitmask value
		BIT $DF						; Check
		BEQ .not_active				; Branch if not return an active label
		PHX							; Save check byte index
		TDC							; Clear A
		TXA 						; X To A
		ASL                         ; Double it to pick pointer
		TAX                         ; Index it
		REP #$20					; 16-bit A
		LDA.l rage_label,x          ; Load pointer
		TAY                         ; Index it
		SEP #$20					; 8-bit A
		JSR $02F9                   ; Go to print
		PLX                         ; Restore Check byte Index
		CPX #$000a					; You are here if bit it's true 
		BEQ .Block_Sap				; Regen Bit true? branch if so
		CPX #$000b                  ; You are here if bit it's true
		BEQ .Block_Slow             ; Haste Bit true? branch if so
.not_active 		
		DEC $DC						; Decrease byte counter
		BEQ .next_status            ; Check done? Branch if so
		INC $DD                     ; Increase Blocks Routine counter
		BRA .next_bit               ; Check next bit
.next_status
		INC $DD                     ; Increase Blocks Routine counter
		LDX $2134					; Monster index
		RTS
		
.Block_Sap
		PHX                         ; Save X
		LDY #rage_sap               ; Load Sap pointer
		bra .print                  ; Branche to print
.Block_Slow                         
		PHX                         ; Save X
		LDY #rage_slow              ; Load Slow pointer
.print	
		JSR $02F9 	                ; Go to print
		PLX							; Restore X
		BRA .not_active				; Branch and continue	
		
		



; $CF0000 Data monster
; Data Size $20
; Byte $12 Undead
;	Bit $80
;	
;	Blocks
;   Byte $14		                  Byte $15						 Byte $16
;	$01=Blind		$10=/             $01=Death	   $10=Berserk       $01=/        $10=Stop   
;	$02=Slow/Sap    $20=Imp           $02=/        $20=Muddle        $02=/        $20=/
;	$04=Poison      $40=Petrify       $04=/        $40=              $04=/        $40=/      
;	$08=/           $80=Sap/Slow      $08=Mute     $80=Sleep         $08=/        $80=/  

;   Byte $17 Absorb - $18 No DMG - $19 Weakness
;	$01=Fire	$10=Wind 
;	$02=Ice     $20=Pearl
;	$04=Bolt    $40=Earth
;	$08=Poison  $80=Water
;
;	Byte $1D innate
;	$01=Float	$10=      
;	$02=Regen   $20=Shell
;	$04=/       $40=Safe  
;	$08=Haste   $80=Reflect



PADBYTE $FF
PAD $C3A205
warnpc $C3A205