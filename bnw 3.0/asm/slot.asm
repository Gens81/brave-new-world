arch 65816
hirom
table "menu.tbl",ltr 
macro FakeC3(addr)
	phk								; push 
	per $0006						; push return
	pea $96EE						; push address
	jml $c3<addr>					; jump to address
endmacro

org $d4ff00
; Bank pointer
actor_bank:
	db $d5,$d6,$d5,$d6
	db $d5,$d6,$d5,$d6
; Address pointer
actor_address:
	dw $03c0,$6dc0,$1a60,$8320
	dw $0400,$6f00,$1ba0,$8460

actor_sprite:
; Prepare destination address
	LDA #$7E			; Destination Bank
	STA $ED				; Set
	LDX #$9049			; Destination Address
	STX $EB				; Set

; Prepare and transfwer data	
actor_grafix:
	TDC					; Clear A
	TAX					;	^ X
	TAY
	STX $f3				; Save as a print counter
	
.loop
	PHX					; Push X index on stack
	LDA.l actor_bank,x	; Actor GFX Bank
	STA $E9				; Set
	REP #$20       		; 16-bit A
	TXA					; Transfer x to A
	ASL					; Double it
	TAX					; Index it
	LDA.l actor_address,x	; Actor GFX address
	STA $E7				; Set
	JSR write_in_ram	; Write in Ram 
	CLC					; Prepare ADD
	LDA #$0180			; Next GFX address
	ADC $E7				; Set
	STA $E7
	JSR write_in_ram	; Printe next tile
	PLX					; Restore index
	INX                 ; Inc Index
	SEP #$20
	CPX #$0004          ; Done?
	BNE .loop           ; Branch if not
	
.loop3	
	PHX					; Push X index on stack
	LDA.l actor_bank,x	; Actor GFX Bank
	STA $E9				; Set
	REP #$20       		; 16-bit A
	TXA					; Transfer x to A
	ASL					; Double it
	TAX					; Index it
	LDA.l actor_address,x	; Actor GFX address
	STA $E7				; Set
	jsr write_in_ram	; Printe next tile
	TDC					; Clear A
	TAY					;	^ Y
.loop2
	STA [$eb],y			; Start print blank tile
	INY					; Inc index
	INY					; Inc twice
	CPY #$0040			; Tile clear?
	BNE .loop2			; Branch if not
	jsr add_40			; Go to add $40 on Ram address
	SEP #$20			; 8 bit-A
	PLX					; Restore counter
	INX					; Inc index
	CPX #$0008			; Done?
	BNE .loop3			; Branch if not
	JSL transfer		; Transfer in VRAM
	RTL
	
write_in_ram:
	LDY $00             ; Clear Index
.loop
	LDA [$e7],Y         ; Load GFX
	STA [$eb],y         ; Set in Ram
	INY                 ; Inc Y
	INY                 ; Inc twice
	CPY #$0040          ; Tiles done?
	BNE .loop           ; Branch if not
add_40:
	TYA
	clc
	ADC $eb
	STA $eb
	RTS
	
warnpc $d50000

; Free up space - old Draw MP cost in corner of magic menu
; Routine back to Skill menu
org $C351C6
C351C6:	
	JSR $11b0						; CLear sprite immediatly - don't wait resfresh loop
	LDA $4212					    ; PPU status
    AND #$40    				    ; H-Blank?
    BEQ C351C6     					; Loop if not
	JSR $0efd						; Queue Refresh BG1
	JSR $134d						; Refresh
	JMP $4DBC						; Condense text

; 31: Sustain slot menu
sustain_slot:
	LDA #$10        				; Description: On
	TRB $45         				; Set menu flag
	JSR $0EFD      					; Queue list upload
	JSR handle_slot					; Handle D-Pad
	JSR C34D9B      				; Load description
	JSR $27E2						; Manage Y function
	LDA $09         				; No-autofire keys
	BIT #$80        				; Pushing B?
	BEQ C329A4      				; Exit if not
	JSR $29A5       				; Leave submenu
	JSL actor_sprite
C329A4: 
	RTS

padbyte $ff
pad $C35203


; Misc Data
org $c3023d
	dw sustain_slot					; 31: Sustain Slot

org $c31b75
	jsr C34C80						; Build Skill Menu
org $c32d2d
	jsr C34C80						; Build Skill Menu

; MAgic Menu link
org $c32148
	jsr C34B82						; Magic Navi Data
org $c32d36
	jsr C34B82						;		^
org $c32155
	jmp C34B8B						; Relocate cursor
org $c32819
	JSR C34B88						; Handle D-Pad Magic Menu
org $c3216b
	jmp C34D7F

; Bushido link
org $C320F0
	JSR C34BCE						; Navi Data
	JSR C34BD7						; Relocate cursor
	
org $c32995	
	JSR C34BD4						; Handle D-Pad

	
; Blitz link
org $C32107
	JSR C34BCE						; Navi Data
	JSR C34BD7						; Relocate cursor
	
org $c3297e
	JSR C34BD4						; Handle D-Pad	

org $c35a77
	jsr C355D4

; Draw Blitz inputs and menu title, create portrait
org $C355DA
C355D4:  JSR $6A15  			    ; Clear BG1 map A
         JSR $55EA  			    ; Draw inputs
         LDA #$2C 				    ; Palette 3
         STA $29      				; Color: Blue
         JSR $61AC    				; Create portrait
         JMP $0F4D   			   	; Queue BG3 upload
warnpc $c355ea

; Dance link	
org $C321E0
	JSR C34BCE						; Navi Data
	JSR C34BD7						; Relocate cursor

org $c35aa8
	JSR C34BD4						; Handle D-Pad

org $c35774

	JSR $578A						; Draw Dance

; Draw Dance list and menu title, create portrait
C35774:  JSR $6A15    				; Clear BG1 map A
		 LDA #$20					; White colour
		 STA $29					; Set
         JSR C3578A     			; Draw Dance list
         JSR $61AC	     			; Create portrait
         JMP $0F4D	     			; Queue BG3 upload

; Build and draw Dance list
C3578A:  JSR $5620  	   			; Build Dance list
         JSR $83F7	     			; Define $E5, $E6
         INC $E6        			; BG1 write row +1
         STZ $E5        			; Dance slot: 1
         LDY #$0004     			; Rows left: 4
C35797:  PHY            			; Save counter
         JSR C357AA     			; Draw 2 dances
         LDA $E6        			; BG1 write row
         INC A          			; Go 1 row down
         INC A          			; Go 1 row down
         INC A          			; Go 1 row down
         INC A          			; Go 1 row down
         AND #$1F       			; Stay in limits
         STA $E6        			; Save changes
         PLY            			; Rows left
         DEY            			; One less left
         BNE C35797     			; Loop till last
         RTS

; Draw a row of two Dance names
C357AA:  JSR C357C1     			; Define source
         LDX #$0003     			; X: 3
         JSR C357D0     			; Draw Dance A
         INC $E5        			; Dance slot +1
         JSR C357C1     			; Define source
         LDX #$0011     			; X: 17
         JSR C357D0     			; Draw Dance B
         INC $E5        			; Dance slot +1
         RTS

; Set source for loading Dance name
C357C1:  LDY #$000C      			; Letters: 12
         STY $EB         			; Set src size
         LDY #$FE15      			; E6/FE15
         STY $EF         			; Set src LBs
         LDA #$E6        			; Bank: E6
         STA $F1         			; Set src HB
         RTS

; Draw Dance name
C357D0:  LDA $E6         			; BG1 write row
         JSR $809F      			; Compute map ptr
         REP #$20        			; 16-bit A
         TXA             			; ...
         STA $7E9E89     			; Set position
         SEP #$20        			; 8-bit A
         TDC             			; Clear A
         LDA $E5         			; Dance slot
         TAX             			; Index it
         LDA $7E9D89,X   			; Dance in slot
         CMP #$FF        			; Empty slot?
         BEQ C357F0      			; Blank if so
         JSR $8467      			; Load name
         JMP $7FD9      			; Draw name

; Fork: Blank Dance slot
C357F0:  LDY #$000C      			; Spaces: 12
         LDX #$9E8B      			; 7E/9E8B
         STX $2181       			; Set WRAM LBs
         LDA #$FF        			; Space char
C357FB:  STA $2180       			; Add to string
         DEY             			; One less left
         BNE C357FB      			; Loop till last
         STZ $2180       			; End string
         JMP $7FD9      			; Draw 12 spaces

; Set to delete portrait in Skills menu
C35807:  TDC             			; Clear A
         LDA $60         			; Queue index
         TAX             			; Index it
         LDA #$FF        			; Null value
         STA $7E35C9,X   			; Portrait: Off
		 JSR C351C6					; Refresh screen and load HDMA Table
         RTS

warnpc $C35812

org $C329BF
	JMP C35807						; Delete portrait


; Lore link
org $c32185
	jsr C34BF4						; Navi data
	jsr C34BFD						; Relocate cursor

org $c3289a
	jsr C34BFA						; Handle D-pad

org $C35A87
	JSR $5203						; Draw lores, etc.

org $C35203
	JSR $6A15						; Clear BG1 map A
	JSR $523C						; Draw Lore list


; Espers link
org $c320ca
	JSR C34C18     					; Load navig data
	JSR C34C21     					; Relocate cursor
org $c35932					
	JSR C34C18     					; Load navig data

org $c328e3				
	jsr C34C1E						; Handle D-Pad
	
org $c3594c					
	JSR C34C21     					; Relocate cursor
	
; Rage link				
org $c321bd				
	jsr C34C4C						; Navi Data
	jsr C34C55						; relocate cursor
org $c328c9				
	jsr C34C52						; Handle D-pad
	
; Skills link				
org $c31e89				
	jsr C34D3D						; Set skill colours
org $c329b2				
	jsr C34D27						; Draw actor info

	
; Navigation data for Skills menu
org $C34B6F
C34B6F:  db $80         			; Wraps vertically
         db $00         			; Initial column
         db $01         			; Initial row
         db $01         			; 1 column
         db $08         			; 8 rows
		 
; Cursor positions for Skills menu
C34B74:  dw $1400     				; Espers
         dw $2100     				; Magic
         dw $4100     				; SwdTech
         dw $5100     				; Blitz
         dw $6100     				; Lore
         dw $7100     				; Rage
         dw $8100     				; Dance
		 dw $9100					; Slot

; Load navigation data for Magic menu
C34B82:  LDY #C34BA9  				; C3/4BA9
         JMP $05FE     			 	; Load navig data

; Handle D-Pad and cursor memory for Magic menu
C34B88:  JSR $81C7      		 	; Handle D-Pad
C34B8B:  LDY #C34BAE    			; C3/4BAE
         JSR $0648      			; Relocate cursor
         TDC            			; Clear A
         LDA $28        			; Member slot
         ASL A          			; Double it
         TAX            			; Index it
         LDA $4F        			; List column
         STA $023E,X    			; Remember it
         LDA $50        			; List row
         STA $023F,X    			; Remember it
         LDA $28        			; Member slot
         TAX            			; Index it
         LDA $4A        			; Scroll position
         STA $0246,X    			; Remember it
         RTS

; Navigation data for Magic menu
C34BA9:  db $01        				; Wraps horizontally
         db $00        				; Initial column
         db $00        				; Initial row
         db $02        				; 2 columns
         db $08        				; 8 rows

; Cursor positions for Magic menu
C34BAE:  dw $7408      				; Spell 1
         dw $7478      				; Spell 2
         dw $8008      				; Spell 3
         dw $8078      				; Spell 4
         dw $8C08      				; Spell 5
         dw $8C78      				; Spell 6
         dw $9808      				; Spell 7
         dw $9878      				; Spell 8
         dw $A408      				; Spell 9
         dw $A478      				; Spell 10
         dw $B008      				; Spell 11
         dw $B078      				; Spell 12
         dw $BC08      				; Spell 13
         dw $BC78      				; Spell 14
         dw $C808      				; Spell 15
         dw $C878      				; Spell 16

; Load navigation data for SwdTech, Blitz, or Dance menu
C34BCE:  LDY #C34BDF			    ; C3/4BDF
         JMP $05FE      			; Load navig data

; Handle D-Pad for SwdTech, Blitz, or Dance menu
C34BD4:  JSR $072D   				; Handle D-Pad
C34BD7:  LDY #C34BE4 				; C3/4BE4
         STY $E7     				; ...
         JMP $0640   				; Relocate cursor

; Navigation data for SwdTech, Blitz, and Dance menus
C34BDF:  db $00  	   		    	; Wraps on all sides
         db $00     			    ; Initial column
         db $00     			    ; Initial row
         db $02     			    ; 2 columns
         db $04     		    	; 4 rows

; Cursor positions for SwdTech, Blitz, and Dance menus
C34BE4:  dw $7408      				; Skill 1
         dw $7478      				; Skill 2
         dw $8C08      				; Skill 3
         dw $8C78      				; Skill 4
         dw $A408      				; Skill 5
         dw $A478      				; Skill 6
         dw $BC08      				; Skill 7
         dw $BC78      				; Skill 8

; Load navigation data for Lore menu
C34BF4:  LDY #C34C03 		  		; C3/4C03
         JMP $05FE    				; Load navig data

; Handle D-Pad for Lore menu
C34BFA:  JSR $81C7    				; Handle D-Pad
C34BFD:  LDY #C34C08  				; C3/4C08
         JMP $0648    				; Relocate cursor

; Navigation data for Lore menu
C34C03:  db $01       	 			; Wraps horizontally
         db $00       	 			; Initial column
         db $00       	 			; Initial row
         db $01       	 			; 1 column
         db $08       	 			; 8 rows

; Cursor positions for Lore menu
C34C08:  dw $7408     			    ; Spell 1
         dw $8008    			    ; Spell 2
         dw $8C08    			    ; Spell 3
         dw $9808    			    ; Spell 4
         dw $A408    			    ; Spell 5
         dw $B008    			    ; Spell 6
         dw $BC08    			    ; Spell 7
         dw $C808    			    ; Spell 8

; Load navigation data for Espers menu
C34C18:  LDY #C34C27   				; C3/4C27
         JMP $05FE      			; Load navig data

; Handle D-Pad for Espers menu
C34C1E:  JSR $81C7   			    ; Handle D-Pad
C34C21:  LDY #C34C2C  				; C3/4C2C
         JMP $0648  			    ; Relocate cursor

; Navigation data for Espers menu
C34C27:  db $01         			; Wraps horizontally
         db $00         			; Initial column
         db $00         			; Initial row
         db $02         			; 2 columns
         db $08         			; 8 rows

; Cursor positions for Espers menu
C34C2C:  dw $7208       			; Esper 1
         dw $7278       			; Esper 2
         dw $7e08       			; Esper 3
         dw $7e78       			; Esper 4
         dw $8a08       			; Esper 5
         dw $8a78       			; Esper 6
         dw $9608       			; Esper 7
         dw $9678       			; Esper 8
         dw $A208       			; Esper 9
         dw $A278       			; Esper 10
         dw $ae08       			; Esper 11
         dw $ae78       			; Esper 12
         dw $Ba08       			; Esper 13
         dw $Ba78       			; Esper 14
         dw $C608       			; Esper 15
         dw $C678       			; Esper 16

; Load navigation data for Rage menu
C34C4C:  LDY #C34C5B     			; C3/4C5B
         JMP $05FE      			; Load navig data

; Handle D-Pad for Rage menu
C34C52:  JSR $81C7      			; Handle D-Pad
C34C55:  LDY #C34C60   				; C3/4C60
         JMP $0648     				; Relocate cursor

; Navigation data for Rage menu
C34C5B:  db $01          			; Wraps horizontally
         db $00          			; Initial column
         db $00          			; Initial row
         db $02          			; 2 columns
         db $08          			; 8 rows

; Cursor positions for Rage menu
C34C60:  dw $7418        			; Rage 1
         dw $7488        			; Rage 2
         dw $8018        			; Rage 3
         dw $8088        			; Rage 4
         dw $8C18        			; Rage 5
         dw $8C88        			; Rage 6
         dw $9818        			; Rage 7
         dw $9888        			; Rage 8
         dw $A418        			; Rage 9
         dw $A488        			; Rage 10
         dw $B018        			; Rage 11
         dw $B088        			; Rage 12
         dw $BC18        			; Rage 13
         dw $BC88        			; Rage 14
         dw $C818        			; Rage 15
         dw $C888        			; Rage 16
		 
;org $C34C80
C34C80:  
	STZ $9E							; No MP by Magic
	JSR $0F89						; Stop VRAM DMA B
	LDA #$01						; 64x32 at $0000
	STA $2107						; Set BG1 map loc
	JSR $6A28						; Clear BG2 map A
	JSR $6A2D						; Clear BG2 map B
	TDC								; Clear A
	TAX								; 	^	X
.loop		
	PHX								; Push X into Stack -> Counter
	REP #$20						; 16-bit A	
	TXA								; Swap Counter to A
	ASL								; Double it
	TAX								; MAke the counter be the index
	LDA.l C34D16,X					; Pick Pointer from Table
	TAY								; Swap into Y
	SEP #$20						; 8-bit A
	JSR $0341						; Draw box
	PLX								; Pull X from Stack
	INX								; Increase Counter
	CPX #$0008						; All Done?
	BNE .loop						; Loop if not
	JSR $0E52      					; Upload windows
	JSR C34D27     					; Draw actor info
	JSR $0E28      					; Upload BG1 A+B
	JSR $6A3C      					; Clear BG3 map A
	JSR $6A41      					; Clear BG3 map B
	JSR $6A46      					; Clear BG3 map C
	JSR $A662      					; Build desc map
	JSR C34D3D     					; Set skill colors
C34CDE:	
	TDC								; Clear A
	TAX								; 	^	X
.loop		
	PHX								; Push X into Stack -> Counter
	LDA $79,X						; Pick Palette from Espers to Dance
	STA $29							; Set
	REP #$20						; 16-bit A	
	TXA								; Swap Counter to A
	ASL								; Double it
	TAX								; MAke the counter be the index
	LDA.l skill_pointer_tbl,X		; Pick Pointer from Table
	TAY								; Swap into Y
	SEP #$20						; 8-bit A
	JSR $02f9						; Print word
	PLX								; Pull X from Stack
	INX								; Increase Counter
	CPX #$0008						; All Done?
	BNE .loop						; Loop if not
	JMP $0E6E						; Upload BG3 A+B
	
C320A5:  dw $20B3					; Espers
         dw $211C					; Magic
         dw $20EE					; SwdTech
         dw $2105					; Blitz
         dw $216E					; Lore
         dw $21A6					; Rage
         dw $21DE					; Dance
		 dw init_slot				; Slot

; Box Pointers
C34D16:  dw #C34DA4    					; (Upper submenus)
		 dw #C34DA0    					; (Lower submenus)
		 dw #C34DA8    					; (Stats)
		 dw #C34D9C    					; (Bottom)
		 dw #C34D98    					; (Top)
		 dw #C34DB0    					; (Stats)
		 dw #C34DAC    					; (List) 
		 dw #C34DB8    					; (Description)

; Draw actor info in Skills menu, including blue text
C34D27:  JSR $6A15       			; Clear BG1 map A
         JSR $6A19       			; Clear BG1 map B
         LDA #$24        			; Palette 1
         STA $29         			; Color: Blue
         LDX #C35C81     			; Text ptrs loc
         LDY #$0006      			; Strings: 3
         JSR $69BA       			; Draw "LV/HP/MP"
         JMP $4EE5       			; Draw actor info

; Assign a palette to each submenu in Skills menu
C34D3D:  JSL CB4D3D					; Assign a palette to each submenu in Skills menu
		 RTS

; Battle commands that unlock a skill menu
C34D78:  db $02         			; Magic (unlocks Espers)
         db $02         			; Magic (unlocks Magic)
         db $07         			; SwdTech
         db $0A         			; Blitz
         db $0C         			; Lore
         db $10         			; Rage
         db $13         			; Dance
		 db $0F						; Slot

; Draw Magic list and blue "MP…" and create portrait
C34D7F:  JSR $6A15    				; Clear BG1 map A
         JSR $4F1C    				; Build spell list
         JSR $4F87    				; Draw spell list
         LDA #$2C     				; Palette 3
         STA $29      				; Color: Blue
         JSR $61AC    				; Create portrait
         JMP $0F4D    				; Queue BG3 upload

; Window layout for main Skills menu
C34D98:  dw $588B,$0407 			 ; 09x06 at $588B (Upper submenus)
C34D9C:  dw $5A0B,$0c07 			 ; 09x12 at $5A0B (Lower submenus)
C34DA0:  dw $59CB,$051C 			 ; 30x07 at $59CB (Stats)
C34DA4:  dw $5B8B,$0C1C 			 ; 30x14 at $5B8B (Bottom)
C34DA8:  dw $588B,$031C 			 ; 30x05 at $588B (Top)

; Window layout for Skills submenus
C34DAC:  dw $61CB,$051C 			 ; 30x07 at $61CB (Stats)
C34DB0:  dw $638B,$0C1C 			 ; 30x14 at $638B (List)
C34DB8:  dw $608B,$031C				 ; 30x05 at $608B (Description)

; Skill sub menu pointer table
skill_pointer_tbl:
	dw #C35C3A						; Esper
	dw #C35C42						; Magic
	dw #C35C4A						; Bushido
	dw #C35C54						; Blitz
	dw #C35C5C						; Lore
	dw #C35C64						; Rage
	dw #C35C6C						; Dance
	dw #C35C75						; Slot


; Init Slot Menu
init_slot:
	STZ $4A        					; List scroll: 0
	JSR slot_navi  					; Load navig data
	JSR reloc_curs					; Relocate cursor
	LDY #$0100     					; X: 256
	STY $39        					; Set BG2 X-Pos
	STY $3D        					; Set BG3 X-Pos
	JSL draw_inputs					; Go to Sub long and load palette for sprites and load sprite gfx into VRAM
	LDX #$BFE5						; Slot skill property address
	JSR $5a8d						; Set address and bank
	JSR $61AC      					; Create portrait	
	LDA #$01        				; Min slot: 8	
    LDY #slot_sprite  				; Queue sprite Pointer 
    JSR $1173     					; Queue OAM fn
    LDA #$31						; C3/F6A4
	STA $26							; Next: Sustain menu
	RTS

; Load Slot description
C34D9B:
	LDX #CFFB30  					; Pointer table
    STX $E7      					; Set ptr loc LBs
    LDX #CFFB40  					; Text Table
    STX $EB      					; Set text loc LBs
    LDA #$CF     					; Bank: CB
    STA $E9      					; Set ptr loc HB
    LDA #$CF     					; ...
    STA $ED      					; Set text loc HB
    JMP $572A    					; Load description

padbyte $ff
pad $c34dbc
warnpc $c34dbc

; Invoke skill submenu
org $c3209b
	JMP (C320A5,X)  				; Invoke menu

; Load navigation data for Slot
org $c355c9							; 16 free bytes
slot_navi:
	LDY #navi_data 					; Pointer
	JMP $05FE   					; Load navig data

; Handle D-Pad for Slot menu
handle_slot:  
	JSR $072D     					; Handle D-Pad
reloc_curs:
	LDY #cursor_pos					; Pointer
	STY $E7							; ...
	JMP $0640  					    ; Relocate cursor
warnpc $c355da 

; Navigation data 
org $c3295f							; 7 free bytes
navi_data:
	db $00        					; Wraps on all sides
	db $00         					; Initial column
	db $00         					; Initial row
	db $02         					; 2 columns
	db $03         					; 3 rows
	
warnpc $c32966

org $C3f6a5
cursor_pos:
; Cursor positions for SwdTech, Blitz, and Dance menus
	dw $7008      					; Skill 1
	dw $7078      					; Skill 2
	dw $9208      					; Skill 3
	dw $9278      					; Skill 4
	dw $b408      					; Skill 5
	dw $b478      					; Skill 6

slot_sprite:
	JSL $ED79DD
	RTS

warnpc $c3f6cb


; Fill Palette with new colours
org $d8e870
d8e870:
	dw $0000,$0000,$39CE,$03BF		; yellow font (esper bonus points) 47A6 for green
	dw $4E73,$5EF7,$77BD,$7C80		; Colour for slot img
	dw $131C,$19B3,$08FD,$7FFF		; 	^
	dw $FFFF,$FFFF,$FFFF,$FFFF		; null

; Just a link	
org $C35C81
C35C81:

; Draw Slot list

org $C4A7C1
draw_string:
	JSL new_hdma_table					; Change the HDMA table from scrollable list into a fitter one
	LDX #slot_string					; Pointer Table
	LDY #slot_string_end-slot_string	; Pointer Q.ty
	LDA #$20							; White colour
	STA $29								; Set
	JSR $A76E							; Multiple Print
	LDY #go_fishX3						; losing spin
	STY $e7								; Set pointer
	lda #$28							; Grey colour
	sta $29								; set
	jmp C4FFD3							; single print and create slot list
warnpc $C4A7E0

; Create list
org $C4FFD3
C4FFD3:
	JSR $a75c							; Single print
	LDX #$9D89  					    ; 7E/9D89
	STX $2181
	LDX $00
.loop
	LDA.l databank,X
	STA $2180
	INX
	CPX #$0006
	BNE .loop
	RTL

databank:	
	db $01
	db $05
	db $02
	db $04
	db $03
	db $00	
	
warnpc $C50000

org $c47a1b	
slot_string:
	dw #trifecta
	dw #jackpot
	dw #solitaire
	dw #roulette
	dw #blackjack
	dw #go_fish
	dw #trifectaX3
	dw #jackpotX3
	dw #solitaireX3
	dw #rouletteX3
	dw #blackjackX3
slot_string_end:
warnpc $c47a40

org $c4b4b5
trifecta:		dw $388f : db "Trifecta",$00
jackpot:		dw $38ab : db "Jackpot",$00
solitaire:		dw $3a0f : db "Solitaire",$00
roulette:		dw $3a2b : db "Roulette",$00
blackjack:		dw $3b8f : db "Blackjack",$00
go_fish:		dw $3bab : db "Go Fish",$00
trifectaX3:		dw $3913+4 : db $c9,"3",$00
jackpotX3:		dw $392f+4 : db $c9,"3",$00
solitaireX3:	dw $3a93+4 : db $c9,"3",$00
rouletteX3:		dw $3aaf+4 : db $c9,"3",$00
blackjackX3:	dw $3c13+4 : db $c9,"3",$00
go_fishX3:		dw $3c2b : db "(Losing Spin)",$00

warnpc $c4b520


org $c0ed08
new_hdma_table:
	ldx $00								; Index: 0
.loop
	lda.l table,x						; V-data
	sta $7e985b,X						; Save in ram
	inx 								; Inc counter
	cpx #$0037							; Table done?
	bne .loop							; Branch if not
	rtl 

table:
	db $04,$96,$ff						; Row 1
	db $04,$96,$ff						; Row 1
	db $04,$96,$ff						; Row 1
	db $04,$98,$ff						; Row 2
	db $04,$98,$ff						; Row 2
	db $04,$98,$ff						; Row 2
	db $08,$a4,$ff						; Row 3
	db $08,$a4,$ff						; Row 3
	db $08,$a4,$ff						; Row 3
	db $06,$a6,$ff						; Row 4
	db $06,$a6,$ff						; Row 4
	db $06,$a6,$ff						; Row 4
	db $04,$b2,$ff						; Row 5
	db $04,$b2,$ff						; Row 5
	db $04,$b2,$ff						; Row 5
	db $04,$b4,$ff						; Row 6
	db $04,$b4,$ff						; Row 6
	db $04,$b4,$ff						; Row 6	
	db $00
	
warnpc $c0ed60

org $c0de1d
restore_hdma:
	sta $7e35c9,X						; Portrait: Off
.C3846E	
	LDA $4212						    ; PPU status
    AND #$40    					    ; H-Blank?
    BEQ .C3846E      					; Loop if not
	%FakeC3(0efd)						; Queue Refresh BG1
	%FakeC3(134d)						; Refresh
	ldx $00								; Index: 0
.loop
	lda.l $c34e91,x						; V-data
	sta $7e985b,X						; Save in ram
	inx									; Inc X
	cpx #$0046                          ; Done?
	bne .loop                           ; Branch if not
	rtl
warnpc $c0de5a

; Set new skills submenu limit
org $c31e95
	cpx #$0008
	
org $C35C3A
C35C3A:  dw $790D : db "Espers",$00
C35C42:  dw $798D : db "Magic",$00
C35C4A:  dw $7A8D : db "Bushido",$00
C35C54:  dw $7B0D : db "Blitz",$00
C35C5C:  dw $7B8D : db "Lore",$00
C35C64:  dw $7C0D : db "Rage",$00
C35C6C:  dw $7C8D : db "Dance",$00
C35C75:  dw $7D0D : db "Slot",$00

warnpc $C35C81

org $Cb5790
; Assign a palette to each submenu in Skills menu
CB4D3D:  LDA #$24       			; Gray palette
         LDX $00        			; 1st: Espers
CB4D41:  STA $79,X      			; Disable menu
         INX            			; Menu slot +1
         CPX #$0008     			; Done Dance?
         BNE CB4D41     			; Loop if not
         %FakeC3(4EDD)      		; Actor's address
         PHY            			; Memorize it
         LDX #$0004     			; Commands: 4
CB4D50:  PHX            			; Save counter
         LDX $00        			; 1st: Espers
CB4D53:  LDA $0016,Y    			; Actor's command
         CMP.L C34D78,X 			; Unlocks submenu?
         BNE CB4D60     			; Skip menu if not
         LDA #$20       			; Color: User's
         STA $79,X      			; Enable menu
CB4D60:  INX            			; Menu slot +1
         CPX #$0008     			; Done Dance?
         BNE CB4D53     			; Loop if not
         INY            			; Cmd slot +1
         PLX            			; Loop counter
         DEX            			; One less cmd
         BNE CB4D50     			; Loop till last
         PLY            			; Actor's address
		 LDA $0023,Y				; Relic 1
		 CMP #$d6					; Heiji's coin?
		 BEQ .grey_slot				; Branch if so
		 LDA $0024,Y				; Relic 2
		 CMP #$d6					; Heiji's coin?		 
         BNE .slot_not_grey			; Branch if not
.grey_slot		 
		 LDA #$24					; Grey out Slot
		 STA $80					; Set
.slot_not_grey
		 LDA $0000,Y    			; Actor
         CMP #$0C       			; Gogo?
         BNE CB4D77     			; Exit if not
         LDA #$24       			; Gray palette
         STA $79        			; Disable Espers
CB4D77:  RTL
warnpc $cb5850


; Slot Description Pointer
org $CFFB40
CFFB30:
    dw Gofish-Gofish
    dw Trifecta-Gofish
    dw Solitaire-Gofish
    dw Blackjack-Gofish
    dw Magicite-Gofish
    dw Jackpot-Gofish
	
; Slot description
CFFB40:
Gofish:
    db "Cure",$E0,"HP",$00
Trifecta:
    db "Ground dmg|Set",$E0,"[Sap]",$00
Solitaire:
    db "Non-elemental dmg|Set",$E0,"[Blind]",$00
Blackjack:
    db "Non-elemental dmg|Ignore",$E0,"def.",$00
Magicite:
    db "Summon",$E0,"random esper",$00
Jackpot:
    db "Cure",$E0,"HP|Revive",$E0,"allies",$00

warnpc $cffc00

; Hi-Row sprite GFX
org $D095F0
D095F0:
	incbin "../gfx/D095F0_slot.bin"
D095F0_end:
	
warnpc $D09800

; Low-Row sprite GFX
org $E684A0
E684A0:
	incbin "../gfx/E684A0_slot.bin"
E684A0_end:
	
; Draw Inputs, load new palette and sprite gfx 
draw_inputs:
	JSL draw_string					; Draw inputs, create list etc.

;change_pal_load_gfx
.WaitForVBlank
	ldx #$0020						; Counter
.palette_loop	
	lda d8e870,X					; Palette data
	sta $7e31e9,X					; Store
	dex								; Dec. counter
	bne .palette_loop				; Branch untill last
    LDA #$01       					; CGRAM: Freeze
    TRB $45         				; Set NMI flag
	%FakeC3(14D2)					; Refresh CGRAM
	LDA #$01						; CGRAM: Unfreexe
	TSB $45							; Set NMI flag

; Transfer data to WRAM
.loop_top	
	LDA.l D095F0,X
	STA $7E9049,X
	INX
	CPX #$0200
	BNE .loop_top
	LDX $00	
.loop_bottom	
	LDA.l E684A0,X
	STA $7E9249,X
	INX
	CPX #$0200
	BNE .loop_bottom

; Prepare DMA transfer Slot Sprite WRAM to VRAM
transfer:	
	LDY #$3000						; Set
	STY $14							; Set
	LDX #$9049						; A address
	STX $16							; Set
	LDA #$7E						; A Bank
	STA $18							; Set
	LDX #$0400						; Size
	STX $12

; VRAM Config
	LDA #$80
	STA $2115           			; VRAM increment

WaitForVBlank:
    LDA $4212     					; PPU status
    AND #$80    					; VBlank?
    BEQ WaitForVBlank				; Branch if not	
	
	%FakeC3(1488)					; Transfer 
	RTL
warnpc $e68780

;C36CE9

org $C4BFE5
; Target bitmask
	db $2E          ; Go Fish - Party
	db $6E			; Trifecta - All Foes
	db $6E          ; Solitaire - All Foes
	db $6E          ; Blackjack - All Foes
	db $00          ; Roulette - -
	db $2E          ; Jackpot - Party

; Power Bitmask	
	db $0A
	db $5A
	db $4B
	db $24
	db $00	
	db $0A
	
org $CCFE80
get_target:
	TDC						; Clear A
	LDA $0100				; Load Spell Target address
	STA $E7					; Store 
	CLC						; Prepare ADC
	ADC #$06				; Take Power Address
	STA $F5					; Store
	LDX $0101				; Load Spell Bank
	STX $E8					; Store
	STX $F6					; Store
	lda $26					; Id menu
	cmp #$31				; Slot menu?
	bne .begin				; Branch to avoid $0E multiplier index
	lda $ff
	bra .slot
.begin						; Compute multiply by $0E
	lda $ff					; Load index
	rep #$20				; 16-bit A
	sta $0103				; Temporary
	asl						; *2
	asl						; *4
	asl						; *8
	sec						; Prepare SBC
	sbc $0103				; *7
	asl						; *14		
.slot
	TAY						; Index multiply by 0E
	TDC						; Clear A
	SEP #$20				; 8-bit A
	lda [$E7],Y				; Load Target
	PHA						; Push A
	jmp bushido				; Jump and check if bushido
.normal_power
	lda [$F5],y				; Load Power
	BEQ .zero				; Branch if 0
	%FakeC3(04E0)			; Convert Blank leading 0
	bra .not0				; Branch to print
.zero
	ldX	#$ffff				; Blank decimal and hundred values
	STX $f7					; set
	LDA #$c4				; Convert Blank into -
	sta $f9					; Set
.not0	
	LDX #$8119      		; Power number position
    %FakeC3(04C0)	   		; Draw 3 digits
.bushido_compute
	TDC						; Clear A
	PLA						; Restore Target
	jsr convert				; Eventually convert
;---------------------------------
; Some skills can't match bitmask
;--------------------------------
.bitmask
	CMP #$01				; Reflect?
	BNE .free				; Branch if not - may be free target
	LDA #$41				; Turn into "Single" target active
	BRA .skip				; Branch and avoid bitmask and print "Single"
.free
	cmp #$21				; Not Reflect, It's Cure?
	BNE .bushido_blitz		; Branch if not
	lda #$61				; Turn into "Free" target active
	bra .skip				; Check
.bushido_blitz
	cmp #$7E				; Bushido and Blitz use $7E instead of $6E for All Foes 
	bne .skip				; Branch if not
	lda #$6E				; Convert if so
.skip
	STA $FF					; Save in $FF
	LDX #$FFFF				; Load index
.loop
	INX						; iNC x
	LDA.l bitmask,x			; Load bitmask
	JSR convert
	CMP $FF					; Same as $FF?
	BNE .loop				; Loop untill last
	TXA						; Transfer X to A
	ASL						; Double it
	TAX						; Index it
	rep #$20				; 16-bit A
	LDA.l effect_pointers,x	; Load pointer
	STA $E7					; Save address for print			
	LDY #$8131				; Load $7E/80F1 for single string print
	%FakeC3(3519)			; Prepare print from $7E/9E89 ram address
	TAY						; After JSR A will be $0000, clear Y
	LDA #$C0				; string to print Bank
	STA $E9					; Save
.print
	LDA	[$E7],y				; Load string
	beq .end				; 'Till $00
	STA $2180				; Set
	iny						; Inc index
	bra .print				; Loop
.end
	stz $2180				; End String
	%FakeC3(7FD9)			; Print string
.back	
	RTL
convert:
	CMP #$53				; Need to be changed?
	BNE .rts				; Branch if not
	LDA $26					; Menu flag
	CMP #$3E				; Bushido?
	BNE .blitz				; Branch if so
	LDA $4b					; Cursor pos.
	CMP #$03				; Flurry?
	BEQ .rts				; Leave it 
	CMP #$06				; Tempest?
	BEQ .rts				; Leave it
	BRA .one_foe			; Change in One Foe 
.blitz
	CMP #$33 				; Blitz?
	bne .rts				; Branch if not
.one_foe
	lda #$43				; Convert
.rts
	rts
	
bushido:
	LDA $26					; Menu flag
	CMP #$3E				; Bushido?
	bne .back				; Branch if not
	jmp compute_bushido
.back
	jmp get_target_normal_power



bitmask:
	db $61	; Free
	db $41	; Single
	db $43	; One Foe
	db $53	; Foe(s)
	db $6A	; Foe Group
	db $6e	; All Foes
	db $03	; One Ally
	db $3e	; Allies
	db $2a	; Ally Group
	db $2e	; Party
	db $04	; All
	db $00	; Warp_t

compute_bushido:
	PhY						; Push Y
	LDA $11AC				; R-Hand
	STA $F3
	cmp #$0B				; Weapon?
	BCS .weapon				; Branch if so
	LDA $11AD				; L-Hand
	BEQ .no_weapon			; Empty hand so add base attack and compute
	CLC 
	ADC	$F3					; Add R-Hand
.weapon	
	CLC
	adc $11ad	
	REP #$20				; 16-bit A
	CLC
	adc $11cc				; Add attack base
	PHA						; store a
	LSR         		    ; A / 2
	CLC         		    ; clear carry
	ADC $01,S   		    ; add A
	STA $01,S   		    ; save result to stack
	PLA          		   ; A * 1.5
	bra .compute
.no_weapon
	CLC
	adc $F3					; add R-Hand
	REP #$20				; 16-bit A
	CLC
	adc $11cc				; Add base attack
.compute	
	ply
	SEP #$10				; 8-BIT X,Y
	ldx $4B					; Load finger pos.
	cpx #$01				; Mindblow?
	beq .mindblow			; Branch if so
	cpx #$06				; On Tempest?
	beq .tempest			; Branch if so
	CPX #$00				; On Dispatch?
	BEQ .dispatch			; Branch if so
	cpx #$03				; On flurry?
	bne .not_from_above		; Branch if not
	LSR						; Power /2
.dispatch
	LSR						; Power /4 (/2)
	LSR						; Power /8 (/4)
	STA $f3					; Save
	ASl						; Double it
	clc						; Prepare ADC
	adc $f3					; Make it X3
	bra .skip_tempest
.tempest
	lsr						; Half power
.skip_tempest	
	STA $F3					; Save value

	SEP #$20				; 8-bit A
	REP #$10				; 16-bit x,y
	TDC						; Clear A
	TAX						; Transfer a to x
	LDA #$05				; Digits: 5
	STA $E0					; Set counter
	LDY #$FFFE				; Ram index: -2
	%FakeC3(0535)			; Turn into text (16-bit)
	
	LDX #$8119
	%FakeC3(04c0)
	jmp get_target_bushido_compute
.not_from_above
	REP #$10				; 16-bit x,y
	SEP #$20				; 8-bit A
	jmp bushido_back

.mindblow
	REP #$10				; 16-bit x,y
	SEP #$20				; 8-bit A
	jmp get_target_zero
	
warnpc $CD0000

org $C0DEF2
effect_pointers: