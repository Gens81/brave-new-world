hirom

org $C3611D
C36111:

org $C4a700
statuses_bitmask:

org $C4A7E0
Rages:

macro FakeC3(addr)
	phk					; push 
	per $0006				; push return
	pea $96EE				; push address
	jml $c3<addr>			; jump to address
endmacro

table "menu.tbl",ltr

!Innate_Pos = #$84CF

org $c3fcad
	JSR $0E28				; Upload b1 one immediatly instead of queueing
	
org $C3028B
	dw rage_stats_init		; 58: unused duplicate
;	dw rage_stats_sustain	; 59: bogus

; Init Rage
org $C321d6
	jsr active_y			; Active Y sprite
	jsl clear_for_flags		; Clear byte necessary to check scrolling List

org $C4FFF4
clear_for_flags:	
	lda #$1d				; Sustain Rage
	sta $26					; Set
	JML new_palette			; load grey palette to grey out rages name	
	
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
        JSR $4C54       ; Handle D-Pad
		JSR C39FA7		; Handle Pad
C328D2: RTS

warnpc $C328D3
	
org $C39FA7
; Sustain Rage menu - Handle Pad
; Handle B
C39FA7: LDA $09         ; No-autofire keys
        BIT #$80        ; Pushing B?
        BEQ C39FB0      ; Exit if not
		jsl restore_palette				; Jump and restore yellow palette		
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
		inc $26						; Active delete Y flag
		lda #$0C					; cursor: blank.
		trb $45						; set menu flag------------------------|
		lda #$C0					; scrollbar: off                       |
		trb $46						; set anim index                       |
		STZ $0140					; Clear Undead flag		
		JSR $6a15					; clear bg1 map A   
		jsr $0EFD					; Upload BG1 tilemaps A 
		JSR $134D   				; Update screen/pad	
		LDY #Undead_Sprite			; Pointer
		JSR $1173					; Queue			
stay:	
		LDX #$4A00					; $7E/8249          
		Jsr $6A4E					; clear bg3 map b	
		jsr draw_rage				; print rage name                  
		jsr title_rage				; print title and label text       
		jsr rage_light_up			; light up label and print elements
		jsr $0F4D					; Upload BG3 tilemaps A and B			
		lda $0d						; no-autofire                          |
		bit #$40					; holding Y?                           |
		bne sustain_y				; exit if not                          |
		STZ $0140
		LDX #$4A00					; $7E/8249          
		Jsr $6A4E					; clear bg3 map b
		JSR $53A7      				; Draw Rage list		
		jsr $0eb2					; click noise                          |
        JSR $091F   		    	; Create scrollbar		               |
		lda #$04					; Cursor & Desc.                       |
		STA $45						; On---------------------------------- |
		jsr $7f80					; Queue Y sprite
		jmp $6512					; Rebuild list accordingly wiht Veldt encounter
sustain_y:
        JSL check_if_null			; Jump and redo D-Pad if on an available rage
checked:
		JSR $FCBE					; Reload desc
		JSR $11B0      				; Handle anim queue
		JSR $134D      				; Update screen/pad
		JSR $02DB      				; Check event timer
        BRA stay


title_rage:
		lda #$2c					; palette
		sta $29						; color: blue
		LDX #title_txt				; Title text pointer
		LDY #$0008					; 4 pointers
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
	dw #rage_sap
	
	dw #rage_stop
; 	dw #rage_regen 
;	dw #rage_haste
;	dw #rage_float
;	dw #rage_shell
;	dw #rage_safe	
;	dw #rage_reflect	
	dw #rage_slow
	dw #rage_sap
;	dw #rage_undead
;	dw #rage_sap2
		
title_txt:
	dw #weak_txt
	dw #absorb_txt
	dw #blocks_txt
	dw #innate_txt


rage_blind:			dw $860F-$40	: db $5d,$5e,$5f,$00
rage_poison:    	dw $860F-$40+8	: db $49,$4a,$4b,$00
rage_mute:       	dw $860F-$40+16	: db $30,$27,$33,$00
rage_muddle:     	dw $864F-$40	: db $30,$31,$32,$33,$00
rage_berserk:    	dw $864F-$40+8	: db $34,$35,$36,$37,$00	
rage_sleep:			dw $864F-$40+16	: db $2a,$2b,$29,$00
rage_stop:       	dw $868F-$40	: db $40,$41,$00
rage_petrify:    	dw $868F-$40+8	: db $2c,$2d,$2e,$2f,$00
rage_death:      	dw $868F-$40+16	: db $46,$38,$48,$00
rage_imp:        	dw $86CF-$40	: db $56,$29,$00
rage_slow:			dw $86CF-$40+8	: db $2A,$4c,$4D,$00
rage_sap:			dw $86CF-$40+16	: db $28,$29,$00
;rage_safe:      	dw $84CF	: db $28,$45,$00
;rage_haste:   		dw $84CF+8	: db $42,$43,$44,$00
;rage_regen:     	dw $84CF+16	: db $20,$21,$22,$00
;rage_shell:     	dw $850F	: db $53,$54,$55,$00
;rage_reflect:   	dw $850F+8	: db $20,$25,$26,$52,$00
;rage_sap2:			dw $850F+16	: db $28,$29,$00
;rage_float:			dw $854F	: db $50,$51,$52,$00
;rage_undead:    	dw $854F+8	: db $3E,$5A,$5B,$00

	
weak_txt:	dw $862B-$80 : db "Weakness",$00	; 3913
absorb_txt:	dw $84AB : db "Absorb",$00		; 3993
no_damage:	dw $84AB : db "No Damage",$00	; 3a13
blocks_txt:	dw $85CF-$40 : db "Blocks",$00		; 3b13	
innate_txt:	dw $848F : db "Innate",$00		; 3b93			

rage_light_up:
		TDC						; Clear A
		TAX                     ; A to X
		STX $DC                 ; Clear $DC
		STX $DE                 ;	^	$DE
		LDA $4B					; Rage in slot
		TAX						; Index it
		LDA $7E9D89,X			; Rage ID - Multiplicand
		STA $211B				; Set Low-Byte
		STZ $211B				; Clear Hi-Byte
		LDA #$20				; Multiplier
		STA $211C				; Set Low-Byte
		STA $211C       		; ...
		LDX $2134				; Monster index
		LDA #$20				; User Color
		STA $29					; Set
		LDX $2134				; Monster index
		LDA $CF0016,X			; Block byte "Stop"
		AND #$10				; Check Bit - Can block Stop?
		BEQ .not_stop			; Branch if not
		LDY #rage_stop			; Label pointer
		JSR $02F9				; Print
.not_stop
;		LDX $2134				; Monster index
;		LDA $CF001C,X			; Innate byte "Sap"
;		AND #$40				; Check Bit - Innate Sap?
;		BEQ .not_sap			; Branch if not
;		LDY #rage_sap2			; Label pointer
;		JSR $02F9               ; Print
;.not_sap
		LDA #$05				; Counter
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

;		LDA #$03                ; Counter
;		STA $DC                 ; Set
		LDA $CF001D,X			; Blocks byte
		STA $DF					; Save for later
		AND #$10				; Stop?
		BEQ .not				; Branch if not
		LDY #rage_stop			; Stop ptr
		JSR $02F9				; Print
.not		
		LDA $DF					; Load value
		AND #$02				; Sap?
		BEQ .not_sap			; Branch if not
		LDY #rage_sap			; Pointer
		BRA .print				; Print
.not_sap
		LDA $DF                	; Load value
		AND #$08               	; Slow?
		BEQ .not_slow          	; Branch if not
		LDY #rage_slow         	; Pointer
.print
		JSR $02F9               ; Print		
.not_slow
		JSL PrintInnate
		JSR $7FD9               ; Print	
		LDX $2134
		TDC                     ; Clear A
		LDA $CF0017,X			; Absorb byte
		BEQ .NoDamage			; Null Byte = No elements
		BRA .Absorb				; Skip and keep absorb
.NoDamage		
		LDA $CF0018,X			; No Damage byte
		PHA
		LDA #$2C
		STA $29
		LDY #no_damage
		JSR $02F9
		PLA
.Absorb		
		LDX #$84EB				; Element Pointer
		JSR C388AE				; Build List
		JSR C388F8				; Draw List 
		LDX $2134				; Monster index
		TDC                     ; Clear A
		LDA $CF0019,X			; Weakness byte
		LDX #$866B-$80				; Element Pointer
		JSR C388AE				; Build List
		JMP C388F8				; Draw List 
		
		
		
check_rage:
		STA $DF						; Set to check
.next_bit
		LDX $DD						; Load index
		LDA.l statuses_bitmask,X	; Load Bitmask value
		BIT $DF						; Check
		BEQ .not_active				; Branch if not return an active label
;		PHX							; Save check byte index
		TDC							; Clear A
		TXA 						; X To A
		ASL                         ; Double it to pick pointer
		TAX                         ; Index it
		REP #$20					; 16-bit A
		LDA.l rage_label,x          ; Load pointer
		TAY                         ; Index it
		SEP #$20					; 8-bit A
		JSR $02F9                   ; Go to print
;		PLX                         ; Restore Check byte Index
;		CPX #$000b					; You are here if bit it's true 
;		BEQ .Block_Sap				; Regen Bit true? branch if so
;		CPX #$000c                  ; You are here if bit it's true
;		BEQ .Block_Slow             ; Haste Bit true? branch if so
.not_active 		
		DEC $DC						; Decrease byte counter
		BEQ .next_status            ; Check done? Branch if so
		INC $DD                     ; Increase Blocks Routine counter
		BRA .next_bit               ; Check next bit
.next_status
		INC $DD                     ; Increase Blocks Routine counter
		LDX $2134					; Monster index
		RTS
		
;.Block_Sap
;		PHX                         ; Save X
;		LDY #rage_sap               ; Load Sap pointer
;		bra .print                  ; Branche to print
;.Block_Slow                         
;		PHX                         ; Save X
;		LDY #rage_slow              ; Load Slow pointer
;.print	
;		JSR $02F9 	                ; Go to print
;		PLX							; Restore X
;		BRA .not_active				; Branch and continue	
		

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
Innate:
	DB $01		; Float
	DB $02      ; Regen
	DB $20      ; Shell
	DB $40      ; Safe
	DB $08      ; Haste
	DB $80      ; Reflect

InnatePtr:	
	DW #Float
	DW #Regen
	DW #Shell
	DW #Safe
	DW #Haste
	DW #Reflect
	
InnSap:		db "Sap",$00
Float:		db "Float",$00
Regen:      db "Regen",$00
Shell:      db "Shell",$00
Safe:       db "Safe",$00
Haste:      db "Haste",$00
Reflect:    db "Reflect",$00

Undead_Sprite:
	JSL Undead_Sprite_Hook
	RTS
	
PADBYTE $FF
PAD $C3A20A
warnpc $C3A20A

org $D4FE50
PrintInnate:
.innate
	LDY #$CF00
	STY $D1
	LDY $2134
	LDA #$1C					; Byte $1C
	STA	$D0                 	; $D0 = CF001C	
	LDA [$D0],Y					; Load value
	AND #$40					; Sap?
	BEQ .not_sap				; Branch if not	
	LDX #$9E8B 					; 7E/9E8B
	STX $2181  					; Set WRAM LBs	
	LDX $00
	REP #$20
	LDA !Innate_Pos
	STA $7E9E89
	SEP #$20
.loop_sap	
	LDA.L InnSap,X
	BEQ .active_flag
	STA $2180
	INX
	BRA .loop_sap

.active_flag
	INC $0170
	BRA .next_innate
	
.not_sap
	LDX #$9E8B 					; 7E/9E8B
	STX $2181  					; Set WRAM LBs	
	REP #$20                    ;
	LDA !Innate_Pos             ;
	STA $7E9E89                 ;
	SEP #$20                    ;


.next_innate
	LDX $00						; Clear X
	STX $DD                     ; ClearCounter index
	INC $D0						; Next byte
	LDA [$D0],Y					; Load value
	STA $DF						; Checkbyte
	DEC $D0						; Prev byte
	LDA #$05
	STA $DC
	
.next_bit
	LDX $DD						; Load index
	LDA.l Innate,X				; Load Bitmask value
	BIT $DF						; Check
	BEQ .not_active				; Branch if not return an active label
	PHX							; Save check byte index
	TDC							; Clear A
	TXA 						; X To A
	ASL                         ; Double it to pick pointer
	TAX                         ; Index it
	REP #$20					; 16-bit A
	LDA.l InnatePtr,x	        ; Load pointer
	TAX                         ; Index it
	SEP #$20					; 8-bit A
		
	
	LDA $0170
	BEQ .continue_innate
	LDA #$D1
	STA $2180

.continue_innate
	LDA $C30000,X
	BEQ .end_innate
	STA $2180
	INX
	BRA .continue_innate
.end_innate
	INC $0170
	PLX                         ; Restore Check byte Index
.not_active 		
	DEC $DC						; Decrease byteCounter
	BEQ .finish		            ; Check done? Branch if so
	INC $DD                     ; Increase Blocks RoutineCounter
	BRA .next_bit               ; Check next bit
.finish
	LDA $0170
	BNE .yes_innate
	LDX $00						; Clear X
	LDA #$C4					; "-"
	STA $2180                	; Add to string
.ClearInnate
	LDA #$FF
	STA $2180
	INX 
	CPX #$000C
	BNE .ClearInnate	
.yes_innate	
	STZ $2180
	STZ $0170
	RTL
	
org $D0FC40
Undead_Sprite_Hook:
; Update arrow for gear data menu
			TAX             ; Index mode
			JMP (.handle,X)  ; Handle mode

; Jump table for the above
.handle:	dw .init       ; Initialize sprite
			dw .sust       ; Sustain sprite
		 
; Mode 0: Initialize 
.init:		
			LDA #$01
			STA $0140
			LDX $2D         		; Queue index
			REP #$20        		; 16-bit A
;			BEQ .delete
			LDA #table_UD
			STA $32C9,X		    ; Set sprite's
			SEP #$20        	; 8-bit A
			LDA #$D0       		; Bank: $D0
			STA $35CA,X    		; Set ptr HB
			%FakeC3(1206)	   	; Set pose timer
			INC $3649,X    		; Mode +1
			LDA #$01       		; Pans with BG1
			STA $364A,X     	; Set sprite flags
		 
; Mode 1: Sustain 
.sust:		LDA $0140			; Undead flag disabled?
			BEQ .delete			; Branch if so
			JSL prepare_index	; Get monster index
			LDA $CF0012,X		; Undead byte
			AND #$80			; Check Bit - Undead?
			BNE .show			; Branch if not
			LDX $2D          ;
			LDA #$EF         ; Load Cursor's X
			BRA .skip
.show			
			LDX $2D          ;
			LDA #$FC         ; Load Cursor's X
.skip
			STA $33CA,X      ; Set sprite's
			LDA #$ED         ; Load Cursor's Y
			STA $344A,X      ; Set sprite's
			%FakeC3(1221)    ; Define OAM
			SEC              ; Set to requeue
			RTL              ; Exit
.delete		STZ $0140
			CLC
			RTL

; Animation table
table_UD:		dw #spr_UD      ; Show portrait
				db $FE          ; Freeze
				
; OAM for portrait			
spr_UD:			db $01					; Sprite to show
				dw $8090,$2E2A			; Undead

prepare_index:
		TDC						; Clear A
		TAX                     ; A to X
		LDA $4B					; Rage in slot
		TAX						; Index it
		LDA $7E9D89,X			; Rage ID - Multiplicand
		REP #$20
		ASL #5					; Multiply by 20
		TAX
		SEP #$20
		RTL
warnpc $D0FD00


ORG $C36512
	JSL $c4ffce					; rebuild rage list
	Jmp $21d9					; Set Sustain rage menu

org $c4ff72
C4FF72:
org $c4ffce
	ldy #$0100					; BG allign
	bra C4FF72 					; rebuild list
	
org $C3F6B6
draw_rage:
		JSR $5409				; define source
		lda $4b					; slot
		sta $e5					; rage slot?
		ldx #$840F				; Pointer
		JSR $541E				; draw rage name
no_light:
		rts
warnpc $C3F6CB

; Skip rage if unavailable
org $cb57e5
rearrange_buffer:
	LDY #$9DC9      ; WRAM buffer address
	STY $E7		    ; set ^
	LDA #$7E		; WRAM Bank
	STA $E9
	TDC				; Clear A
	TAY				; Clear Y
.loop	
	LDA [$E7],y		; Load Rage ID
	CMP #$FF		; Null?
	BEQ .pick_next	; Branch and take next
	STA $7E9D89,x	; Save
	INX				; Inc Rages pos
.pick_next
	INY				; Inc Y
	CPY #$0040		; Done 64 rages from buffer pos?
	BNE .loop		; Branch if not
	STX $FC			; Save limit ID slot position into stack - *COUNTER*
	PHX				; Push X
	CPX #$0040		; Rages done?
	BEQ .done		; branch if so
	TDC				; clear A
	TAY				; clear Y - reset WRAM buffer counter
	DEY				; Dec Y to allow loop
.next
	INY				; WRAM buffer start pos.
	LDA [$E7],y		; Load Rage ID
	CMP #$FF		; Unavailable Rage?
	BNE .next		; branch to next of not
	CPY #$0040		; Done 64 rages from Buffer?
	BEQ .finish		; Branch if so
	PHX				; Push ID slot position into stack
	TYX				; Transfer ID buffer position to X
	LDA Rages,X		; Load Rage ID
	TAX				; Transfer to X
	LDA $7EAA8D,X	; Check if you have encountered the rage
	PLX				; Pull ID slot position from stack
	CMP #$00		; A = $00 (not encoutered yet)?
	BEQ .next		; branch to next if so
	STA $7E9D89,x	; Save in slot position
	INC $FC			; Inc limit
	INX				; Inc Rage slot pos
	CPX #$0040		; Done 64 rage from slot pos.?
	bne .next		; Go to next if not
	beq .done		; Finish if so
.finish	
	
	LDA #$FF		; load $FF to blank anavailable rages
.blank_next	
	STA $7E9D89,X	; save in slot position
	INX				; inc counter
	CPX #$0040		; slot poitione end?
	BNE .blank_next	; go to next if not
.done
	PLX
	STX $FE
	RTL
warnpc $CB5850


org $d4cf70
new_palette:
	TDC
	TAX
.loop
	lda $7E3055,X
	STA $7E305D,X
	INX
	CPX #$0004
	BNE .loop
	RTL

restore_palette:
	TDC
	TAX
.loop
	lda $7E30ED,X
	STA $7E305D,X
	INX
	CPX #$0004
	BNE .loop
	RTL

check_if_null:
	
;	LDA $4B							; Actual slot
;	CLC								; Prepare ADC
;	ADC #$10						; Add $10
;	CMP $FC							; Over limit?
;	BCS .prepare_R_L				; Branch if so
;	BRA .continue					; Branch if not
;.prepare_R_L
;	LDA $4D							; Column
;	CLC								; Prepare ADD
;	ADC #$30						; Set limit
;	STA $4B
;
;.continue
;	%FakeC3(1F64)					; Handle L and R
;    BCS .exit						; Exit if pushed	
	
	LDA $FC							; Limit
	SEC                             ; Prepare SBC
	SBC $4B                         ; Get value
	DEC                             ; Adjust Value
	BEQ .downlast                   ; Branch if $00 - Last Rage
	CMP #$01                        ; Is 1 to last?
	BNE .up                         ; Branch if not
	LDA $4D
	
.not_column2	
	LDA $0B        					; Semi-auto keys
    BIT #$04        				; Pushing down?
    BEQ .up							; Branch if not
	RTL
	
.downlast
	LDA $4D							; Column 2?
	BEQ .not_column2				; Branch if not
	LDA $0B        					; Semi-auto keys
    BIT #$04        				; Pushing down?
    BEQ .right						; Branch if not
	RTL
.right	
	BIT #$01						; Pushing right?
	BEQ .up							; Branch if not
	RTL

.up	
	%FakeC3(4C54)       			; Handle D-Pad
	
.exit
	RTL

warnpc $d4d000

!RageList = $CFC050
; #########################################################################
; Build Rage List
;
; Rewritten by Assassin for "Alphabetical Rage" patch. Included notes:
;   Generates alphabetical Rage list under the Skills menu.  Loops for all 256 enemies.
;   Function C3/5418 still needs to process this list to display the names.  I tweaked that
;   routine to make sure it preserves the ordering established here.

org $C353C1
BuildRageList:
  LDX #$9DC9       ; WRAM buffer address
  STX $2181        ; set ^
  SEP #$10         ; 8-bit X/Y
  LDX $00          ; zero iterator
.loop
  LDA $C4A7E0,X    ; next sorted rage ID
  TAY              ; index it
  PHX              ; store iterator
  CLC              ; $C25217 treats carry as bit 9 of A
  JSL $C22A33  ; X: byte index, A: bitmask for this rage bit
  BIT $1D2C,X      ; compare to known rages
  BEQ .null        ; branch if not learned yet
  TYA              ; else, get rage ID
  BRA .save        ; and branch to save it
.null
  LDA #$FF         ; "null" entry
.save
  STA $2180        ; store rage in menu
  PLX              ; restore iterator
  INX              ; next sorted rage index
  BNE .loop        ; loop until 256 rollover TODO: Update this for BNW
  REP #$10         ; 16-bit X/Y
  JSL rearrange_buffer	; Go to sort rage list
  RTS              ; [fill empty space]
warnpc $C353EE+1

; Rage List
org $CFC050