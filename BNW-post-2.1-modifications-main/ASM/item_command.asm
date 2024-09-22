arch 65816
hirom

;table "menu.tbl", ltr
macro ShortC1(addr)
	PHK
	PER $0006
	PEA $002B
	JML $C1<addr>
endmacro
	
;$4B00
;#########################################################################
;
; In this routine the code load entire item menu into a buffer and use it
; as it is 
; In this position we rearrange the code and change loading sequence
;
;
; c2549e ldx #$00ff 	; index
; c254a1 lda $1969,x	; load quantity item
; c254a4 sta $2e75  	; save
; c254a7 lda $1869,x	; load item ID

org $C254A1
C254A1:
	STX $0110					; save X ($00FF)
loop256:		
	JSL Colosseum_or_not		; go to bring item id and rearrange menu
	NOP		
	NOP		
	JSR $54CD					;Copy info of item held in A to a 5-byte buffer, 
								; spanning $2E72 - $2E76.  Then copy buffer to
								; our current menu position.
	DEX							; dec X
	BPL loop256					; do for all item
		
org $C20000						; Begin of Battle
	jmp c23992					; jump to clear rearrange id before begin battle
org $c23992		
c23992:		
	stz $0100					
	stz $0101					;Clear Rearrange ID
	jmp $000C


org $C4B520
other:
	plx							; Restore sub index
	cpx #$ffff                  ; If $FFFF a cycle are done and a reset can be done (maybe a faster and wasteless way to do)
	beq avoidbug                ; Branch to reset (jmp is better?)
	cmp #$69                    ; Everything but not Weapon, shield or stars?
	bcs cont                    ; Save if so
	bra goback                  ; Pick up next if not
avoidbug:                       
	bra next                    ; (jmp is better?)


weapons:                        
	plx							; restore sub-index
	cmp #$69					; ID less than 69?
	bcc maybe_star				; it is so it's a weapon or shield and branch to save
	bra goback					; it's not so pick up next ID
maybe_star:
	cmp #$41
	bne other_star
	bra goback
other_star:	
	cmp #$43
	bne maybe_rod
	bra goback
maybe_rod:
	cmp #$35					; In rod consumable range?
	bcc cont					; branch to item consumable check if not
	cmp #$38					; in rod consumable range?
	bcs cont					; branch to item consumable check if not	
	bra goback	
	
RearrangeBMenu:
	phx							; save X
	ldx $0110					; load loop index X (first time same as original X)
	cpx #$ffff					; Cycle finish?			
	beq next					; Branch if so
loopit:				
	lda $1969,x					; load quantity item
    sta $2e75  					; save
	lda $1869,x					; load item ID
	bra arrange					; go to rearrange conditional code			
goback:				
	cpx #$0000					; is X 0?
	beq next					; cycle is finish - branch if so	
	dex							; decrease X
	stx $0110					; save X
	bra loopit					; branch and load next
next:				
	ldx #$0100					; $00FF x
	stx $0110					; save
	inc $0100					; increase $0100 for next cycle 
	rep #$20					; 16 bit-A
	dex							; Dec X
	stx $0110					; Save 
	plx							; restore original X
	sep #$20					; 8 bit-A
	bra RearrangeBMenu			; Pick up next ID
cont:	
	rep #$20					; 16 bit-A
	dex							; dec X
	stx $0110					; save X
	plx							; restore original X
	rtl
;	jmp save_inventory	
arrange:		
	sep #$20					; 8 bit-A
	phx							; save sub-index X
	ldx $0100					; load cycle index

	cpx #$0005					; other (means everything but not stars or weapon)?
	beq other                   ; branch
	cpx #$0006                  ; Star?
	beq star                    ; branch
	cpx #$0007                  ; weapon?
	beq rod
	cpx #$0008
	beq weapons			        ; branch 
	
	cpx #$0000					; empty slot cycle
	beq empty					; branch
	cpx #$0001					; empty slot done -> to do: whatelse except consumable, weapon and shields
	beq whatelse				; branch
	cpx #$0002					; weapon and shields
	beq weapon_shields			; branch
	cpx #$0003					; rod
	beq rod						; branch
	
	
item:
	plx							; restore sub-index
	cmp #$FF					; Blank?
	beq goback					; branch if so
	cmp #$E7					; item ID is below?
	bcc goback					; go back and pick up next value if it is
	bra cont					; item ID is greater than $E7 so it's a consumable
				
empty:				
	plx							; restore sub-index
	cmp #$FF					; empty slot?
	beq cont					; branch if so	
	bra goback					; go back and pick up next value if not
			
whatelse:				
	plx							; restore sub-index
	cmp #$E7					; item ID is greater or equal?
	bcs goback					; go back and pick up next value if not
	cmp #$69					; item ID is below?
	bcc goback					; go back and pick up next value if it is
	bra cont					; item ID is between $69 and $E6 so it's not a weapon, shield or consumable
	
weapon_shields:		
	plx							; restore sub-index
	cmp #$69					; item ID is greater or equal?
	bcs goback					; go back and pick up next value if it is
	cmp #$35					; In rod consumable range?
	bcc cont					; branch to item consumable check if not
	cmp #$38					; in rod consumable range?
	bcs cont					; branch to item consumable check if not	
	jmp goback	

star:                           ;
	plx                         ; restore sub-index
	cmp #$41                    ; Shuriken?
	beq cont                    ; Branch to save if so
	cmp #$43                    ; Ninja Star?
	beq cont                    ; Branch to save if so
	jmp goback                  ; Pick up new ID if not	
rod: 	
	plx							; restore sub-index
	cmp #$35					; In rod consumable range?
	bcs under38					; branch to item consumable check if not
	jmp goback	
under38:		
	cmp #$38					; in rod consumable range?
	bcc cont					; branch to item consumable check if not	
	jmp goback					; item ID is below $69 so it's a weapon or shield
	


; Pressing A and Enter item menu

	item_btl_menu:
	inc $96
	inc $2f41
	ldy $62ca                   ; Charachter pos. index
	lda #$00                    ; prepare to clear
	sta $8947,y                 ; finger position (list position)
	sta $894F,y                 ; finger position (1-4)
	STZ $0100					; clear rearrange flag	
	jmp transfer_equip
	rtl

; Pressing A in weapon sub menu
item_rearrange:
	STZ $0100					; clear rearrange flag
	PHA							; Save A
	PHX							; 	^  X
	PHY							;	^  Y
	jsl item_arrange			; reload btl menu
	PLY							; Restore Y
	PLX                         ; 	^     X
	PLA                         ; 	^     A
	rts
	
weapon_sub:
	INC $7B02					; Active weapon sub menu flag
	STX $7B03					; (?)				
	INC $0100					; "Active" weapon rearrange flag
    REP #$30					; Set 16-bit Accumulator, 16-bit X and Y
    PHY							; Save Y
	LDY #$2B81					; Prepare move from SRAM to 7E2B81 ram address
	jsr item_rearrange+3		; go to reload btl menu (Put weapon on top)(+3 to avoid clear flag)
	PLY							; restore y
	SEP #$20                    ; 8-bit A
	STZ $0100                   ; Clear rearrange flag
	RTL

exit_weapon_sub:
	STZ $7BB5                   ; (?)
	STZ $7B02                   ; Clear weapon sub menu flag
	jsr item_rearrange          ; Reload btl menu (Put item on top) 
	RTL                         
	
exit_menu:                      
	stz $7baf                   ; (?)
	stz $7bb5                   ; (?)
	bra ex                      ; (?)
exit_weapon_sub_b:               
	STZ $7B02                   ; Clear weapon sub menu flag
	STZ $890C                   ; (?)
	jsr item_rearrange          ; (?)
ex:	PHY                         ; Save Y
	ldy $62ca                   ; Charachter pos. index
	lda #$00                    ; prepare to clear
	sta $8947,y                 ; finger position (list position)
	sta $894F,y                 ; finger position (1-4)
	PLY                         ; Restore Y
	RTL                         

rebuild_item:         			; Change equipped hand          
	JSR item_rearrange          ; Reload btl menu (Put item on top) 
	stx $7b05                   ; (?)
	lda $7b00                   ; (?)
	RTL                         

from_equip_to_item_by_a:        ; Trying to equip unequippable item
	inc $95                     ; (?)
	stz $96                     ; (?)
	jsr item_rearrange          ; Reload btl menu (Put item on top) 
	jmp ex                      
	
;save_inventory:
	
item_id:
	LDA $2686,X					; load item ID
	STA $FF						; save
	TDC							; Clear A
	TAX							; index it
	JSR .check_id		
	RTL		
		
.check_id		
	CPX #$00FF					; all 255 item done?
	BEQ .finish					; branch if so
	LDA $1869,X					; load item id
	CMP $FF						; same as equipped?
	BEQ .finish					; branch if not
	INX							; inc X
	BRA .check_id				; go to check
.finish
	RTS

; Copy BTL RAM ID in SRAM 

; from equip
switch_item:
	STA $602D,y					; save equipped item in temporary
	inc $64DB					; (?)
	LDA $3A97					; $FF?
	BNE not						; Branch if not - not in Colosseum Battle

transfer_equip:
	PHA							; Save A
	PHX							; 	^  X
	PHY							;	^  Y
	TDC							; Clear A
	TAX							;	^   X
	TAY							;	^   Y
.transfer				
	LDA $2686,Y					; load item ID in battle list RAM
	STA $1869,X					; Save SRAM Item ID
	LDA $2689,Y					; load item quantity in battle list ram
	STA $1969,X					; Save SRAM Item ID
	inx							; increment X to get new SRAM Item ID
	iny							; increment Y to get new BTL RAM Item ID
	iny             			; 	^
	iny             			; 	^
	iny             			;	^
	iny             			; 	^
	CPX #$0100					; All 255 item done?
	BNE .transfer				; branch if not
	TDC
	TAX
	TAY
	JSR item_rearrange	
	PLY	                		; Restore Y
	PLX	                		; 	^     X
	PLA	                		; 	^     A
not:
	RTL

;Check if in Colosseum 

Colosseum_or_not:
	LDA $3A97				; $FF?
	CMP #$00FF
	BNE .not				; Branch if not - not in Colosseum Battle
	lda $1969,x				; load quantity item
    sta $2e75  				; save
	lda $1869,x				; load item ID
	RTL						; Return to original
.not
	JMP RearrangeBMenu		; Jump and rearrange battle menu

warnpc $C4B6E0	
	
; Pressing B in weapon sub menu

org $C25158
item_arrange:
	JSR $546E					;Construct in-battle Item menu, equipment sub-menus, and
								;possessed Tools bitfield, based off of equipped and
								;possessed items.
	RTL

warnpc $c25162


; Press A in weapon sub menu
ORG $C18F53						; Press A on L/R-Hand and activate weapons
	jsl weapon_sub
	nop
	nop

org $C18E5F						; Press A on L/R-Hand and go back to item
	JSL rebuild_item
	nop
	nop


org $c18a89
	JSL from_equip_to_item_by_a	; Set initial item index when you try to equip unequippable weapon

; Press B
ORG $C18E17						; Press B on L/R-Hand and go back to item
	jsl exit_weapon_sub
	nop
	nop
	
ORG $C1894C
	JSL exit_menu
	nop
	nop
	jmp $56f2
	jsl exit_weapon_sub_b
	nop
	nop
	lda #$0a
	
warnpc $c1895d

org $C18B4D
QueueSwap:          			; 84 bytes original sub routine
	BCS .right   				; branch if right-hand
	CMP $2B9A,Y  				; compare w/ left-hand equip id
	BRA .continue				
.right				
	CMP $2B86,Y  				; compare w/ right-hand equip id
.continue				
	BEQ .finish+3  				; branch if same (no reserve item)
	PHA          				; store swap-in item id
	LDA $62CA    				; character slot number
	ASL          				; x2
	TAY          				; use as index to data
	PLA          				; restore swap-in item id
	STA $32F4,Y  				; store in character's reserve
	LDA $2689,X  				; swap-in item quantity
	CMP #$02     				; less than 2? 
	BCC .empty				
	DEC 						; decrement quantity
	STA $2689,X
	BRA .finish		
.empty		
	LDA #$FF		
	STA $2686,X		
	STZ $2689,X					; clear quantity
.finish		
	STZ $890C   				; reset equipment swap mode
	STZ $7BAF   				; unfreeze item menu cursor
	STZ $7BB5   				; unfreeze equip menu cursor
	STZ $7B02   				; unset item swapping flag
	JSR $7E19   				; set "Defend" command, queue menu close, set Y
	LDA $7B00   				; column position (1 = left, 2 = right)
	DEC         				; shift down for mode id
	STA $2BB0,Y      			; set subcommand (default $FF triggers defend)
	CLC            				; indicate no item usage
	RTS
	
warnpc $C18B9A

; switch item and de/increment quantity

org $C14498

	JSL switch_item				; go to switch item from menu to hand
	NOP
	NOP
	JMP $4445
	RTS

warnpc $C144A2

; decrease usable item

org $C1717C
	LDA $2689,X					; load item quantity
	CMP #$02                    ; less than 2?
	BCC less_than_2             ; branch if so
	DEC $2689,X                 ; decrease 1
	JSL transfer_equip			; go to save quanity in SRAM
	RTS                         ; go back
less_than_2:
	LDA #$FF                    ; load Blank
	STA $2686,X                 ; save
	JSL transfer_equip			; go to save quanity in SRAM
	RTS                         ;
	
padbyte $FF
Pad $C1719A	
warnpc $C1719B

; press A and enter Item Menu

org $C17BFF

	JSL item_btl_menu
	nop

;fix item duplication bug in kefka tiers
org $C24a73
    jmp C23AEE                    ; Jump to clear ID and init new transition phase on Kefka
org $C23AEE
C23AEE:
    stz $0100                    
    stz $0101                    ;Clear Rearrange ID
    jmp $0016                    ;do start of battle initialization function, then
                                ;proceed with main battle loop
