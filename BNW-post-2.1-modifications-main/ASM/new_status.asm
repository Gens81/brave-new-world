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
	
; Draw windows for non-shifted Status menu
org $C35D17
	JSR $6A15       ; Clear BG1 map A
	JSR $6A1E	    ; Clear BG1 map C
	JSR $6A23       ; Clear BG1 map D
	JSR $6A3C       ; Clear BG3 map A
	JSR $6A41       ; Clear BG3 map B
	JSR $FC20       ; Draw Stats window
	LDY #$5F81      ; C3/5F81
	JSR $0341       ; Draw main window
	LDY #$5F79      ; C3/5F79
	JSR $0341       ; Draw title window
	LDY #$5F7D      ; C3/5F7D
	JSR $0341       ; Draw cmd window
	RTS
	
; Upload tilemaps for Status menu
org $C35D77
	JSR $0E52      ; Upload BG2 A+B
	JSR $0E28      ; Upload BG1 A+B
	JSR $0E6E      ; Upload BG3 A+B
	JMP $0E36      ; Upload BG1 C+D
		 
; Draw blue text and non-blue symbols in Status menu
org $C35D3C
C35D3C:
	JSR C35D41      ; LV, HP, MP, %, /
	BRA C35D5C      ; Rest of blue text

; Handle member switching in Status menu
org $C35D83
	JSR $5D41      ; Draw "MP" + "/"
	JSR $5F8D      ; Draw actor info
	JSR $61A2      ; Create portrait
	LDY #$0000      ; $0000 = BG1a
	STY $14         ; Set VRAM ptr A
	LDY #$3849      ; 7E/3849
	STY $16         ; Set src-a LBs
	LDY #$0800      ; Bytes: 2048
	STY $12         ; Set src-a size
	LDY #$4000      ; $8000 = BG3a
	STY $1B         ; Set VRAM ptr B
	LDY #$7849      ; 7E/7849
	STY $1D         ; Set src-b LBs
	LDY #$0800      ; Bytes: 2048
	STY $19         ; Set src-b size
	JSR $11B0       ; Swap portraits
	JSR $1368       ; Trigger NMI
	LDY $00         ; Null value
	STY $1B         ; Dequeue BG3a
	LDY #$0800      ; $9000 = BG1b
	STY $14         ; Set VRAM ptr
	LDY #$4849      ; 7E/4849
	STY $16         ; Set src LBs
	JMP $1368       ; Upload BG1b
		 
; Draw LV, HP, MP, and non-blue symbols in Status menu
; Pointers manager
org $C35D41
C35D41:
	LDA #$20								; White text
	sta $29
	ldx #slashes							; Start pointer address
	ldy #Stats_BG1-slashes					; Pointers to read (2 bytes each pointer)
	jsr $69ba								; Prepare print
	lda #$2C								; Blue Text
	sta $29
	ldx #charapoint							; Start pointer address
	ldy #slashes-charapoint					; Pointers to read (2 bytes each pointer)
	jmp New_Blue							; Jump to sub routine that add new pointers instead of "prepare print"
	rts
C35D5C:
	LDA #$24								; Blue text
	sta $29
	ldx #statusstats						; Start pointer address
	ldy #charapoint-statusstats				; Pointers to read (2 bytes each pointer)
	jsr $69ba								; "prepare print"
	lda #$24								; Load Blue Palette  
	sta $29   								; Store on $29
	ldx #Stats_BG1							; Start pointer address
	ldy #$000A								; Pointers to read (2 bytes each pointer)
	jsr $69ba								; Prepare print
	rts
warnpc $C35D77

;Windows layout
org $C35f79
	dw $5B6D,$0D0B			; (Title)
	dw $58f3,$0707			; (Commands)
	dw $588b,$091c			; (Main)
	dw $58c7,$1200			; (Gogo, L part)
	dw $6087,$1207			; (Gogo, R part)
	
org $C3F3FF     
Print_EL_Value: 
	SEP #$20    ; 8 bit-A
	LDA $26     ; Menu flag
	CMP #$0B    ; Init Status?
	BEQ .status ; Branch if so
	CMP #$0C    ; Sustain Status?
	BEQ .status ; Branch if so
	CMP #$42	; Airship Status?
	BEQ .status ; Branch if so
	REP #$20    ; 16 bit-A
	lda [$ef]   ; Tilemap position for level display 
	CLC         ; Clear carry
	RTS
.status
	REP #$20    ; 16 bit-A
	lda [$ef]   ; Tilemap position for level display
	CLC			; Clear carry 	
	ADC #$00B4  ; ADC
	RTS
	
warnpc $C3F41E




;Pointers table
org $C36437
statusstats:
;	dw #Command
	dw #statusvigor
	dw #statusstamina
	dw #statusmagic
	dw #statusspeed
	
charapoint:
	dw #statusLV
	dw #statusHP
	dw #statusPM
	dw #statusnextlv	
	dw #Xp
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

statusslash:		dw $7ADB+64		: db "/",$00
statusslash2:		dw $7B1B+64		: db "/",$00
statusLV:			dw $7959+64		: db "LV",$00
statusHP:			dw $7ACD+64		: db "HP",$00
statusPM:			dw $7B0D+64		: db "MP",$00
statusnextlv:		dw $7967+64		: db "Next",$00
statusvigor:		dw $3bCd+128	: db "Vigor",$00
statusmagic:		dw $3c4d+128	: db "Magic",$00
statusspeed:		dw $3ccd+128	: db "Speed",$00
statusstamina:		dw $3D4d+128	: db "Stamina",$00
statusattack:		dw $3dcd+128	: db "Attack",$00
statusdefense:		dw $3e4d+128	: db "Defense",$00
statusmagicdefense:	dw $3f4d+128	: db "M.Defense",$00
statusevade:		dw $3ecd+128	: db "Evade",$00
statusmagicevade:	dw $484D		: db "M.Evade",$00
Xp:					dw $79AB+64		: db "XP",$00
;Command:			dw $3935		: db "Command",$00


new_sub_pointer:			; duplicated from C3/1EF7
	LDA #$10				; Description: On 
	TRB $45					; Set menu flag 
	JSR $0EFD				; Queue list upload 
	CLC						; Clear carry
	JMP $8983				; originally pointed by C3/02A3
reset_item_desc:
	PHA						; Push A
	LDA $26                 ; Menu cmd 
	CMP #$5E                ; Sustain shifted gear menu?
	BEQ .wait               ; Branch if so
	LSR                     ; half A
	CMP #$32                ; Sustain non--shifted gear menu?
	BEQ .wait               ; Branch if so
	STZ $3649,X				; resets the item description display
.wait
	PLA						; pull A
	RTS

New_Blue:
	jsr $69ba							; Jump to sub routine that add new pointers instead of "prepare print"
	jsl C4B6EE							; Jump and print new text
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




;****************************************************;
;                       							 ;
; Init/Sustain Status							     ;
;                        							 ;
;****************************************************;

; 42: Initialize Lineup's Status menu
org $C3631D
C3631D:  JSR $352F       		; Reset/Stop stuff
         LDA $0200       		; Menu number
         STA $22         		; Memorize it
         STZ $0200       		; Actor arrows: Off...
         STZ $25         		; Never read...
         LDA #$40        		; Channel: 6
         TRB $43         		; Halt HDMA-6...
         JSR $620B       		; Set to shift text
         JSR $6354       		; Draw menu; portrait
         LDA #$01        		; C3/1D7E
         STA $26         		; Next: Fade-in
         LDA #$43        		; C3/633F
         STA $27         		; Queue: Sustain menu
         JMP C36100      		; BRT:1 + NMI

; 43: Sustain Lineup's Status menu
C3633F:	LDA $09         		; No-autofire keys
		BIT #$80        		; Pushing B?
		BEQ C36353      		; Exit if not
		JSR $0EA9       		; Sound: Cursor
		LDA $4C         		; Menu return cmd
		STA $27         		; Queue menu exit
		STZ $26         		; Next: Fade-out		
		JMP EndRtn
C36353: JMP Handle_Y_Handle_Y
WARNpc $C36354

ORG $C3650A
EndRtn:	STZ $C5					; Clear status/elements Flag
		LDA $22         		; Former menu
		STA $0200       		; Set as current
		RTS       
	
warnpc $C3651A
; Set portrait's X position for Lineup's Status menu
org $C3638E
C3638E:  LDA $1850,Y     		; Actor info
         BIT #$20        		; Back row?
         BEQ C3639C      		; Branch if not
         REP #$20        		; 16-bit A
         LDA #$0010      		; X: 16
         BRA C363A1      		; Skip 2 lines
C3639C:  REP #$20        		; 16-bit A
         LDA #$0010      		; X: 16
C363A1:  STA $33CA,X     		; Set sprite's
         SEP #$20        		; 8-bit A
         RTS
; Set portrait's X position for Lineup menu		 
org $C37AF7
	LDA #$0010			 ; X: 16
	
; Queue pushing Y OAM function
org $C36102
C36100:
	JSR $a9a9							; Load Elements GFX
	LDA #$05							; Cursor and unfreeze CGRAM
	TSB $45								; Set
C36102:
	JSR $0e44							; Upload BG1 C+D -> Due to clear BG1 VRAM and condense text 
	JSL Condense_Status_txt				; Draw menu; portrait
	LDA #$01        					; Min slot: 8
	LDY #C36111							; C3/6510
	JSR $1173							; Queue OAM fn
	JMP $3541							; BRT:1 + NMI

C36111:
	JSL EDFCB0							; Jump to create pushing button
	RTS
padbyte $FF : pad $c36127

warnpc $c36128		 

; 0B: Initialize Status menu
ORG $C31C46
C31C46:  JSR $352F      				; Reset/Stop stuff
         JSR C3620B      				; Set to condense text
         JSR clear_flags
         JSR $1C5D      				; Init cursor data
         LDA #$01        				; C3/1D7E
         STA $26         				; Next: Fade-in
         LDA #$0C        				; C3/21F5
         STA $27        				; Queue: Sustain menu
         JMP C36102

; 0C Sustain Status menu
org $C321F5

; Handle R
org $C32218
	jsr Clear_BG_L_R

;Handle L
org $C3223E
	jsr Clear_BG_L_R
		 
;[...]
; Fork: Handle B
org $C32244
	NOP
	LDA $09         					; No-autofire keys
	JMP Handle_Y						; Load B button test and jump
	JSR $0EA9							; Sound: Cursor
	LDA #$04        					; C3/1A8A
	STA $27        						; Queue main menu
	STZ $26      						; Next: Fade-out
	RTS

; Fork: Handle Gogo 
warnpc $C32254

; Fork: Handle Y
org $C3F646
;C3F646:
;	JSR $0F39					        ; Set to redraw cmds
;	JMP $0F25							; Refresh BG3 Tilemap A
	
clear_flags:
	STZ $C5								; Clear Elements/Status Flag
	STZ $CB								; Clear Sap/Regen flag
	JMP $5D05      						; Draw menu; portrait

Clear_BG_L_R:
	DEC $C5
	JSR $6A3C                           ; Jump to clear BG3 A
	JSR $1C5D     						; Init cursor data								
	RTS
	
Handle_Y:		 				
	BIT #$80							; Pushing B?
	BEQ .Handle_Y						; Branch if not
	STZ $C5								; Clear status/elements Flag
	JMP $224A							; Go to exit menu
.Handle_Y				
	LDA $09								; No-autofire
	BIT #$40							; Pushing Y?
	BEQ .not							; Branch if not
	LDA $C5								; Status/elements flag
	BEQ .status							; Branch if status on
	DEC $C5								; Reset flag if not
	BRA .elements
.status				
	JSR $0Eb2							; Sound: click
	JSR ClearBg3Status					; Jump to clear BG3 A
	JSL C4B6EE							; Reprint Statuses
	JSL light_up_statuses				; Light_up statuses
	bra .not
.elements	
	JSR $0Eb2							; Sound: click
	JSR ClearBg3Status					; Jump to clear BG3 A
	JSL Elements_routine				; Loads Element Glyph

.not 				
	LDA $26								; menu flag
	CMP #$43							; Lineup status?
	BEQ .lineup							; Branch if so
	JMP $2254							; Go to handle GOGO
.lineup
	JSR $0F39					        ; Set to redraw cmds
	RTS

ClearBg3Status:
	LDX #$4400							; $7E7B49
	JSR $6A4E							; Jump to clear BG3 A
	rts
	
warnpc $C3F6B0



!Multiple_string_bank = #$C4
!Single_string_Bank = #$C4

; 6A: Sustain shifted Status menu
org $c363D5
	JSR Gogo_commands2

org $C4B6EE

; Statuses & Title
C4B6EE:
	lda $C5								; Elements flag
	bne Elem_flag_on					; Branch if Active
	lda #$24							; Grey text
	sta $29                             ; Set
	ldx #statuses                       ; Statuses pointer
	ldy #$0038                          ; Pointers q.ty
	jsr C369BA                          ; Prepare print
	ldx #Info                       	; statuses pointer	
	ldy #$0006                          ; Pointers q.ty
print:
	lda #$2C							; Blue text
	sta $29                             ; Set
	jsr C369BA                          ; Prepare print
Elem_flag_on: 
	rtl
elements_title:
	ldx #Elements						; Pointers
	ldy #$0008							; Q.ty
	bra print							; Multiple print

;************************;
;                        ;
; Elements Routine	     ;
;                        ;
;************************;

ElementsBitmask:
	db $80								; Water
	db $40								; Earth
	db $20								; Holy
	db $10								; Wind
	db $08								; Dark
	db $04								; Bolt
	db $02								; Ice
	db $01								; Fire
	
Elements_routine:
	LDX $00								; Clear X
	stx $D8                             ; Clear $D8-D9
	stx $DA                             ; ^     $DA-DB for elements bit	
.loop	
	LDA.l ElementsBitmask,x             ; Load Element bits
	STA $DC                             ; Save for test
	LDA $11B6                           ; Absorb Bits
	AND $DC                             ; Can Absorb?
	BEQ .NoDMG                          ; Check next if can't
	TSB $D9                             ; Set in $D9 if Can
	BRA .Next                           ; Check next element
.NoDMG
	LDA $11B7                           ; No DMG Bits
	AND $DC                             ; Can nullify (No Damage)?
	BEQ .HalfDMG                        ; Check next if can't
	TSB $DA                             ; Set in $DA if Can
	BRA .Next	                        ; Check next element
.HalfDMG
	LDA $11B9                           ; Half DMG Bits
	AND $DC                             ; Can Half?
	BEQ .Weak                           ; Check next if can't
	TSB $D8                             ; Set in $D8 if Can
.Weak
	LDA $11B8                           ; Weakness Bits
	AND $DC                             ; Weak?
	BEQ .Next                           ; Check next if not
	TSB $DB                             ; Set in $DB if is it
.Next
	inx                                 ; Inc index
	CPX #$0008                          ; All elements done?
	BNE .loop                           ; Loop if not
	LDA $D8                             ; Load acquired Half Damage Bit
	AND $DB                             ; Also weak?
	TRB $D8                             ; Clear in Half Damage
	TRB $DB	                            ; Clear in Weak
	JSL C38936                          ; Go to print Glyphs
	jmp elements_title                  ; Go to print title and go back


	
light_up_statuses:
	STZ $CB
	LDX $00								; Clear X
	STX $DE                             ;   ^   $DE Item Value Index Counter
	STX $DC                             ;   ^   $DC Check Byte counter
	LDA $C5                             ; Elements flag
	BNE .active                         ; Branch if Active
	LDY $67								; Actor index address
	LDA $1E,Y							; Load Esper spot
	CMP #$FF							; Empty value?	
	BEQ .empty							; Skip index routine and light up label routine
	JSR esper_index						; Go to bring Esper Index
	JSR esper_light_up					; Go to light up label
.empty    
	LDX $00
.loop									; Item Equipped loop (6)	
	STZ $DE                             ; Clear $DE Item Value Index Counter
	STZ $DC                             ;   ^   $DC Check Byte counter
	LDA $11C6,X							; Equip value
	PHX									; Save Index
	CMP #$FF							; Empty?
	BEQ .skip							; Branch if so
	CMP #$66							; Cursed Shiedl?
	BNE .light_up						; Branch if not
	INC $CB								; Active Cursed Shield Flag	
.light_up
	JSR take_item_index                 ; Go to bring Esper Index
	JSR item_light_up	                ; Go to light up label
.skip
	PLX									; Restore
	INX									; Inc index
	CPX #$0006							; Done 6 item?
	BNE .loop                           ; Branch if not
	LDA $CB								; Cursed flag active?
	BEQ .end                            ; Branch if not
	DEC $CB								; Switch off Cursed flag
	LDY #regen                          ; Regen Label
	LDA #$24                            ; Grey out
	JSR C402F9+2                        ; Go to print
	LDY #sap                            ; Sap pointer
	LDA #$20                            ; White colour
	JSR C402F9+2                        ; Go to print
.end	
	INC $C5								; Active Item Flag
	RTL                                 ; Go back
.active
	INC $C5                             ; Inc $C5 due to restore from DEC $C5 when L o R are pushed
	JMP Elements_routine                ; Go to print elements


; Routine that index the esper value (part 1/2)		 


esper_index:
	STA $211B							; low byte
	STZ $211B                           ; keep only low byte
	LDA #$0A							; multiplier
	JMP take_item_index+8				; Go and keep Esper Index (next Routine have a RTS)

; Routine that index the esper value (part 2/2)	or index item equipped value 

take_item_index:
	STA $211B							; low byte
	STZ $211B                           ; keep only low byte
	LDA #$1E                            ; multiplier
	STA $211C                           ; store to get  
	LDX $2134                           ; Get Mid Byte
	TDC									; Clear A
	RTS
	
;****************************************************;
;                       							 ;
; Routine that light up esper labels				 ;
;                        							 ;
;****************************************************;

esper_light_up:	
	LDA $C0D690,X						; 1st byte esper 
	JSR check_byte						; Jump and check if the value return active label 
	LDA $C0D691,X						; 2nd byte esper
	JSR check_byte						; Jump and check if the value return active label
	LDA $C0D692,X						; 3rd byte esper
	JSR check_byte						; Jump and check if the value return active label
	LDA $C0D693,X						; 4th byte esper
	JSR check_byte						; Jump and check if the value return active label
	
	RTS

;****************************************************;
;                       							 ;
; Routine that light up item equipped labels		 ;
;                        							 ;
;****************************************************;

item_light_up:
	LDA $D85006,X						; load item function from $D85006 to $D85009
	JSR check_byte						; Jump and check if the value return active label
	INX									; Inc X for next value 
	INC $DE								; Inc $DE counter
	LDA $DE								; Load in A
	BIT #$04							; Counter It's 4?
	BEQ item_light_up					; Branch if not
	
.second_bit
	LDA $D85008,X						; load item function in $D85000C
	JSR check_byte						; Jump and check if the value return active label
	INX									; Inc X for next value
	INC $DE								; Inc $DE Counter 
	LDA $DE								; Load in A
	CMP #$05							; Counter it's 5?
	BNE .second_bit						; Branch to check anoter flag if not
	LDA $D85014,X						; load item function in $D85019
	jmp check_byte						; Jump and check if the value return active label


;****************************************************************************;
;                       													 ;
; Routine that check if item osper can light up a label and do it if can	 ;
;                        													 ;
;****************************************************************************;
check_byte:	
	PHX									; Item or esper index
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
	CPX #$000A							; You are here if bit it's true 
	BEQ .Block_Sap						; Regen Bit true? branch if so
	CPX #$000B                          ; You are here if bit it's true
	BEQ .Block_Slow                     ; Haste Bit true? branch if so
.not_active                                 
	inx                                 ; Increment index
	CPX #$0004							; Compare index
	BEQ .next_status                    ; Branch if so
	CPX #$0009                          ; Compare index
	BEQ .next_status                    ; Branch if so
	CPX #$00010                          ; Compare index
	BEQ .next_status                    ; Branch if so
	CPX #$0018							; Compare index
	BEQ .next_status	                ; Branch if so
	CPX #$001a                          ; Compare index
	BEQ .next_status                    ; Branch if so
	CPX #$001B                          ; Compare index
	BEQ .next_status                    ; Branch and check new cycle bit
	bra .next_bit                       ; Branch to another bit in the same cycle
.next_status
	STX $DC								; Save check byte counter
	PLX									; Restore Item or esper index
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

; New titles Pointers

Info:
	dw #Auto
	dw #Blocks
	dw #Bonus

Elements:
	dw #Half
	dw #No_Dmg
	dw #Absorb
	dw #Weak

; New title and labels
	
Half:		dw $7D6F+64		 : db "Half Damage",$00
No_Dmg:		dw $7BEF+64		 : db "Absorb",$00
Absorb:		dw $7CAF+64		 : db "No Damage",$00
Weak:		dw $7E2F+64		 : db "Weakness",$00
Auto:		dw $7D6F+64		 : db "Auto",$00
Blocks:		dw $7BEF+64		 : db "Blocks",$00
Bonus:		dw $7E6F+64		 : db "Bonus",$00
blind:		dw $7C2F+64		 : db $5d,$5e,$5f,$00
poison:     dw $7C2F+64+6	 : db $49,$4a,$4b,$00
imp:        dw $7C2F+64+14	 : db $56,$29,$00
mute:       dw $7C6F+64		 : db $30,$27,$33,$00
muddle:     dw $7C6F+64+6	 : db $30,$31,$32,$33,$00
berserk:    dw $7C6F+64+14	 : db $34,$35,$36,$37,$00				
sleep:      dw $7CAF+64		 : db $2a,$2b,$29,$00
petrify:    dw $7CAF+64+6	 : db $2c,$2d,$2e,$2f,$00
death:      dw $7CAF+64+14	 : db $46,$38,$48,$00
stop:       dw $7CEF+64		 : db $40,$41,$00
slow:		dw $7CEF+64+6	 : db $2A,$4c,$4D,$00
sap:		dw $7CEF+64+14	 : db $28,$29,$00
safe:       dw $7DAF+64		 : db $28,$45,$00
haste:      dw $7DAF+64+6	 : db $42,$43,$44,$00
regen:      dw $7DAF+64+14	 : db $20,$21,$22,$00
shell:      dw $7DEF+64		 : db $53,$54,$55,$00
brsrk_auto: dw $7DEF+64+6	 : db $34,$35,$36,$37,$00
reflect:    dw $7DEF+64+14	 : db $20,$25,$26,$52,$00
atk:        dw $7EAF+64		 : db $38,$39,$3A,$00
HP_label:	dw $7EAF+64+6	 : db $4E,$4F,$00
plus_HP_1:  dw $7EAF+64+6	 : db $4E,$4F,$ca,$00
plus_HP_2:  dw $7EAF+64+6	 : db $4E,$4F,$ca,$d1,$00
counter:    dw $7EAF+64+14	 : db $57,$3E,$3F,$59,$00
mag:        dw $7EEF+64		 : db $3B,$3C,$3D,$00
MP_label:   dw $7EEF+64+6	 : db $47,$4F,$00
plus_MP_1:  dw $7EEF+64+6	 : db $47,$4F,$ca,$00
plus_MP_2:	dw $7EEF+64+6	 : db $47,$4F,$ca,$d1,$00
cover:      dw $7EEF+64+14	 : db $57,$58,$59,$00
empty_stat:	dw $7EEF		 : db $00
padbyte $FF
pad $C4B9CF

WARNPC $C4b9CF


org $C4a700
statuses_bitmask:
	db $01   ; Blind
	db $04   ; Poison
	db $20   ; Imp
	db $40   ; Petrify
	
	db $01   ; Death (repel condemned)
	db $08   ; Mute
	db $10   ; Berserk
	db $20   ; Muddle
	db $80   ; Sleep
	
	db $10	 ; Stop
	db $02   ; Regen (Block Sap)
	db $08   ; Haste (Block Slow)
	db $01	 ; Float 
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

; pointers
statuses:
	dw #blind
	dw #poison
	dw #imp
	dw #petrify
	
	dw #death	
	dw #mute
	dw #berserk
	dw #muddle	
	dw #sleep
	
	dw #stop
	dw #regen
	dw #haste
	dw #empty_stat
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

	
;Prepare write
C402F9:  

	LDA #$20					; White text
	STA $29						; Save
	STY $E7       				; Set src LBs
	LDA !Single_string_Bank     ; Bank
	STA $E9        				; Set src HB
	%FakeC3(02FF)				; Draw string

	RTS
	
; Draw multiple strings using consecutive pointers
C369BA: STX $F1        		 	; Set ptrs loc
        STY $EF       			  	; Set counter
        LDA !Multiple_string_bank  ; Bank
        STA $F3         			; Set loc HB
        LDY $00         			; Index: 0
C369C4: REP #$20        			; 16-bit A
        LDA [$F1],Y     			; Text pointer
        STA $E7         			; Set src LBs
        PHY             			; Save index
        SEP #$20        			; 8-bit A
        LDA !Multiple_string_bank  ; Bank: C4
        STA $E9         			; Set src HB
		%FakeC3(02FF)				; Draw string
        PLY             			; String index
        INY             			; Index +1
        INY             			; Index +1
        CPY $EF         			; None left?
        BNE C369C4      			; Loop if not
		RTS
		
; Set to condense BG1 text in Status menu
Condense_Status_txt:
	LDA #$02        				; 1Rx2B to PPU
	STA $4360       				; Set DMA mode
	LDA #$12        				; $2112
	STA $4361       				; To BG3 H-Scroll
	LDY #HDMA_Table 				; Table ptr
	STY $4362       				; Set src LBs
	LDA #$C4        				; Bank: C4
	STA $4364       				; Set src HB
	LDA #$C4        				; ...
	STA $4367       				; Set indir HB
	LDA #$40        				; Channel: 6
	TSB $43         				; Queue HDMA-6
	RTL

;New HDMA Table

HDMA_Table:
db $17,$09,$00
db $48,$0c,$00
db $68,$10,$00
db $00

PADBYTE $FF
PAD $C4a7E0
warnpc $C4a7E0

org $C302A3
	dw #new_sub_pointer

org $C3A897
	JSR reset_item_desc		; Jump to new subroutine C3/FA3B

	
	

;---------------------------------------------------------------------;
;                                                                     ;
;       Hack that print stats difference in yellow colour             ;
;                                                                     ;
;---------------------------------------------------------------------;                                                                     ;

org $D8E7D0 ; Extending palette
MenuPalette:
;   BCG  Shadow --- Colour
; 1st row
dw $0000,$0000,$39CE,$7FFF		; user editable color 
dw $0000,$0000,$2108,$3DEF		; gray font for unavailable choiches
dw $0000,$0000,$39CE,$03BF		; yellow font
dw $0000,$0000,$39CE,$6F60		; light blue font 

; 2nd row
dw $0000,$0000,$39CE,$6F60		; light blue font
dw $0000,$7FFF,$1084,$7FFF		; 7FFF is replaced by user font in game. 3rd code is the VWF description shadow
dw $0000,$0000,$39CE,$7FFF		; white font
dw $0000,$0000,$39CE,$6F60		; light blue font

; 3rd row
dw $0000,$0000,$2108,$3DEF		; gray font
dw $0000,$0000,$2108,$3DEF		; gray font
dw $0000,$0000,$2108,$3DEF		; gray font
dw $0000,$0000,$2108,$3DEF		; gray font

; 4th row

dw $0000,$3C00,$2108,$3DEF		; gray font with blue shadow (Esper equipped from other actor)
dw $0000,$3868,$39CE,$7FFF		; gray font with purple shadow
dw $0000,$3868,$39CE,$7FFF		; gray font with purple shadow
dw $0000,$3868,$39CE,$7FFF		; gray font with purple shadow

; 5th row

dw $0000,$1084,$5294,$7FFF		; white font with gray shadow
dw $0000,$1084,$5294,$7FFF		; white font with gray shadow
dw $0000,$1084,$5294,$7FFF		; white font with black shadow
dw $0000,$1084,$5294,$7FFF		; white font with gray shadow

; 6th row
Yellow:
dw $0000,$0000,$39CE,$03BF		; yellow font (esper bonus points)
dw $FFFF,$FFFF,$FFFF,$FFFF		; null
dw $FFFF,$FFFF,$FFFF,$FFFF		; null
dw $FFFF,$FFFF,$FFFF,$FFFF		; null

;7th row
White:
dw $0000,$0000,$39CE,$7FFF		;white font


; Load color gauge palette
org $C3395E
		LDX $00         ; Color index: 0
        LDA #$40        ; CGRAM: $0080
        STA $2121       ; To BG pal 4
C33965: REP #$20        ; 16-bit A
        LDA $D8E850,X   ; Font color
        STA $7E30C9,X   ; Save in RAM
        SEP #$20        ; 8-bit A
        STA $2122       ; Put LB in CGRAM
        XBA             ; Switch to HB
        STA $2122       ; Put HB in CGRAM
        INX             ; Color index +1
        INX             ; Color index +1
        CPX #$0020      ; Done 16 colors?
        BNE C33965      ; Loop if not
        RTS
		
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


; Load Elements GFX in the main menu

; 04: Initialize main menu
org $C31A8A
	JSR $352F       		; Reset/Stop stuff
	JSR $1BA8       		; Load portraits
	JSR $0F89       		; Stop VRAM DMA B
	JSR $3A6B       		; Set Win2 bounds
	LDA #$04        		; Channel: 2
	TSB $43         		; Queue Win1 HDMA
	JSR $0F89       		; Again...
	JSR $6904       		; Reset BGs' X/Y
	LDA #$03        		; 64x64 at $0000
	STA $2107       		; Set BG1 map loc
	LDA #$43        		; 64x64 at $4000
	STA $2109       		; Set BG3 map loc
	LDA #$C0        		; Channels: 6, 7
	TRB $43         		; Halt HDMA 6+7
	LDA #$02        		; Main cursor: On
	STA $46         		; Bar/Blinker: Off
	JSR $30F5       		; Draw menu
	LDA #$00        		; Min slot: 0
	LDY #$2F42      		; C3/2F42
	JSR $1173       		; Queue D-Pad fn
	JSR $07B0       		; Queue cursor OAM
	JSR $354E       		; HDMA: MS desig.
	LDY #$0002      		; Y: 2
	STY $37         		; Set BG1 Y-Pos
	JSR $36A3       		; Set to shift BG3
	LDA #$05        		; C3/1DA4
	STA $27         		; Queue: Sustain menu
	lda #$01				; C3/1D7E
    sta $26         		; Next: Fade-in
	JMP BRT					; Go to set white palette on BG1 $3C

org $C3F577
BRT:
glyphs:
	phx                     ; Push X
	ldx $00                 ; Clear X
pick_white_color:          
	LDA Yellow,x            ; Load yellow and White colour 
	sta $7E30E9,x           ; Save in RAM (Temporary - Same Save Menu Palette Ram Address)
	inx                     ; Inc X
	cpx #$0038              ; Done 20 colours?
	bne pick_white_color    ; Branch if not
	plx                     ; Restore X
	JSR $A9A9      			; Load elements GFX in VRAM
	JSR $1BA8	   			; Go to unfreeze CGRAM and refresh and allow to load portrait GFX
	JMP $3541      			; BRT:1 + NMI


; Probably Bugfix
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
    cmp #$ED          		; Cmp if icon - Value over Ranged icon
    BCS no_change			; Branch if greater or equal
    cmp #$D0            	; Star value?
    BEQ change            	; Branch if so
    cmp #$D7            	; Cmp if icon - Value below 
    BCC no_change      		; Branch if so
    LDA #$38            	; White colour
    BRA color_change   		; Go to save in ram
no_change:    
    lda $29               	; User colour
color_change:    
    sta [$EB],y           	; Save in Ram
    rtl
change: 
    LDA #$34            ; Yellow colour
    bra color_change    ; Go to save in ram

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
	dw $3C5F+128					; magic     (11A0)  
	dw $3D5F+128					; stamina   (11A2)
	dw $3CDF+128					; speed     (11A4)
	dw $3BDF+128					; vigor     (11A6)
	dw $3EDF+128					; evade     (11A8)
	dw $485F						; m.evade   (11AA)

org $C3FDE0
; StatOffset
	db $00,$0A				; HP
	db $01,$0E				; MP
	db $09,$1D				; Magic
	db $08,$1C				; Stamina
	db $07,$1B				; Speed
	db $06,$1A				; Vigor

StatDiff:
	LDA #$34				; load BG3 yellow color
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
	LDA #$28	            ; load BG3 yellow color
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
	LDX #$7B25+64			; load MP offset (A instead of X because 
	LDY $F1					; load MP "flag"
	CPY #$0001				; is true?
	BEQ .MP					; branch if so
	LDX #$7AE5+64			; load HP offset
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
		LDX #$3E5F+128			; Defense stat position
		JSR !Draw3Digits	
		LDA $11BB				; M.Defense Value
		JSR !TurnIntoText8bit
		LDX #$3F5F+128			; M.Defense stat position
		JSR !Draw3Digits
		JSR $9371				; Define Attack
		BRA Skip				; skip over unused code, now freespace for helper function
PowHelper:	
		LDX #$300C				; use addresses $300C and $300D for hand Battle Powers
		STX $E0					; save in temp variable
		LDX $CE					; just want bottom half, top half will be ignored
		CLC	
		LDA $A0					; check for Gauntlet, setting Zero Flag accordingly
		NOP	
		RTS	
Skip:	JSR $052E				; [vanilla] unchanged, left for context
		LDX #$3ddF+128			; Attack Text position
		JSR $0486				; Draw 3 digits
		LDY #$78CD+64			; Text position
		JSR $34CF				; Draw actor name
		LDY #$399D				; Text position
		JSR $34E5				; Actor class...
		JSR C3F3BF				; EP Text
		JSR $FC4B				; Next EL 
		JSR Gogo_commands		; Draw commands
		LDA #$20				; Palette 0
		STA $29					; Color: User's
		LDX #$6096				; Coords tbl ptr
		JSR $0C6C				; Draw LV, HP, MP
		LDX $67					; Actor's address
		JSR $60A0				; Get needed exp
		JSR $0582				; Turn into text
		LDX #$799F+64			; Text position
		JSR Digits_6			; Draw 6 digits
		JSR !HpMpDiff	        ; go to routine that set Hp/Mp difference
		JSR !StatDiff	        ; go to routine that set stats difference	
		LDX $0102	            ; load $0102 (ship status menu portrait values) 
		STX $1E	                ; store
		STZ $47					; Ailments: Off
		JSR $11B0				; Hide ail. icons
		JSR $625B				; Display status
		JSL light_up_statuses	; jump on the subroutine that light up text
		RTS

; Draw 6 digits
Digits_6:
	LDY #$0008      			; Digits: 8
    STY $E0         			; Set counter
    LDY #$0002      			; Skipped: 1
    JMP $04C7       			; Draw text

warnpc $C36096
org $C36096
	dw $7999+64					; LV value
	dw $7AD3+64					; Current HP
	dw $7ADD+64					; Max HP
	dw $7B13+64					; Current MP
	dw $7B1D+64					; Max MP
	
org $C39382
	JSR PowHelper				; here just to avoid crash
	

; Gogo command ptr	
org $c38366
Gogo_commands2:
	JSR Gogo_commands			; Print cmds
	JMP $0EFD               	; Set to redraw cmds
Gogo_commands:	
	ldy #$3975					; Gogo Tech ptr
	JSR $4598		
	ldy #$39f5					; Gogo Tech ptr
	JSR $459E		
	LDY #$3a75					; Gogo Tech ptr
	JSR $45A5		
	ldy #$3af5					; Gogo Tech ptr
	JSR $45AD
	RTS

warnpc $C38385

; Gogo List command ptr
org $c35f1C
C35F1C:
    BPL .gray          ; branch if no Runic support
    BRA .white         ; display the command lit up
.bushido
    CMP #$07           ; "Bushido"
    BNE .sketch        ; branch if not ^
    LDA $11DA          ; right hand properties
    ORA $11DB          ; left hand properties
    BIT #$02           ; "Bushido Allowed"
    BEQ .gray          ; branch to disable if no ^
    BRA .white         ; else branch to show
.sketch
    CMP #$0D           ; "Sketch"
    BNE .white         ; enable if not ^ (or other previous)
    LDA $11C6          ; right hand equipment slot
    JSL $C2FBFD        ; C: Not a brush
    BCC .white         ; branch if is brush
    LDA $11C7          ; left hand equipment slot
    JSL $C2FBFD        ; C: Not a brush
    BCS .gray          ; branch if ^
.white
    JMP C37D2B
.gray
    JMP $7D2F
C35F4C:
    STA $29
    PLA                ; restore command ID
    RTS
warnpc $C35F50

    
ORG $C37D2B
C37D2B:
    LDA #$20        ; user color palette (white)
    BRA .skip
; C37D2F
    LDA $27         ; Menu flag
    CMP #$48        ; Short?
    BNE .short      ; Branch if so
    LDA #$24        ; Palette grey (BG3)
    bra .skip       ; Skip 1 line
.short    
    LDA #$28        ; Palette: Grey (BG1)
.skip
    JMP C35F4C      ; Go back
    

warnpc $C37d43

ORG $C35EB7		
	LDY #$40C9      			; Tilemap ptr
	
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

; Set to condense BG1 text in Status menu
org $C3620B
C3620B:  LDA #$02        ; 1Rx2B to PPU
         STA $4350       ; Set DMA mode
         LDA #$0E        ; $210E
         STA $4351       ; To BG1 V-Scroll
         LDY #C3622A     ; C3/622A
         STY $4352       ; Set src LBs
         LDA #$C3        ; Bank: C3
         STA $4354       ; Set src HB
         LDA #$C3        ; ...
         STA $4357       ; Set indir HB
         LDA #$20        ; Channel: 5
         TSB $43         ; Queue HDMA-5
         RTS
	
; Text shifting table for BG1
C3622A:
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
	
