arch 65816
hirom

;;-----------------------------------------------------;;
;;-----------------------------------------------------;;
;;                                                     ;; 
;;			Equip menu                     ;; 
;;                                                     ;; 
;;-----------------------------------------------------;;
;;-----------------------------------------------------;;

;; Add unequip esper function on remove option
;; Handle "EMPTY" selection in Equip menu
;org $C3969F
;	JSR unequip_esper	; Unequip Esper
;	JSR $90b5			; Redo text, status
;	STZ $4D				; Cursor: "USE"
;	RTS
;
;; Unequip esper
;org $C326F5
;unequip_esper:
;	LDA $28				; Member slot
;	ASL A				; Double it
;	TAX					; Index it
;	LDY $6D,X			; Actor's address
;	LDA #$FF			; Chosen esper
;	STA $001E,Y			; Assign to actor
;	jsr $96a8			; Remove Gear
;	rts
;warnpc $C32706
; Changing HDMA table and rearrange text position

; Initialize variables for Equip menu
; Last 3 routines are included from C3/A1C3 offset relic routine
; originally in Equip Menu area

org $C31BDD
C31BDD:
	JMP $FC74	   ; Set new HDMA TABLE

org $C3FC74
	LDY #C395D8
	STY $4352
	LDA #$C0
	STA $4354
	JSR $8E50      ; Load navig data
	JSR $8E59      ; Relocate cursor
	JMP $07B0      ; Queue cursor OAM

padbyte $FF
pad $C3FC88

warnpc $C3FCA0 	
	
;New HDMA table

org $C0ECC5
C395D8:
	db $0f,$00,$00
	db $0c,$04,$00
	db $0e,$06,$00
	db $12,$0a,$00
	db $0c,$0c,$00
	db $0c,$10,$00
	db $0c,$14,$00
	db $08,$1c,$00
	db $0c,$20,$00
	db $0c,$24,$00
	db $0c,$28,$00
	db $0c,$2c,$00
	db $0c,$30,$00
	db $0c,$34,$00
	db $0c,$38,$00
	db $0c,$3c,$00
	db $0c,$40,$00
	db $00
	
;org $C30247
;    dw #C39621      ; Sustain Equip - Update entry 36 in C301DB jump table

org $C30285				; Sub routine menu table
	dw C39E50			; 55: Handle selection of gear slot to fill
	dw C398CF	    	; 56: Handle manual gear removal
	dw BrowseGear		; 57: New Gear Browsing (unified equip menu)
	
org $C39E4B
; Set text colour to yellow
C39E4B:  LDA #$28        ; Palette 2
         STA $29         ; Color: Yellow
         RTS             ; ^ For "Equip"
		 
; 55: Handle selection of gear slot to fill
C39E50: LDA #$10		; Desc: On
		TRB $45			; Set Menu flag
		JSR $9E14       ; Queue text upload (routine test and check a timer and choose if desc or text must be shown before)
		JSR $8E72       ; Handle D-Pad
		JSR $9F6A       ; Load description for equipped gear
		JSR DrawHands   ; Recolor hand names


		LDA $08         ; No-autofire keys
        BIT #$80        ; Pushing A?
        BEQ C398B4      ; Branch if not
        JSR $0EB2       ; Sound: Click
        LDA $4B         ; Cursor position
        STA $5F         ; Set body slot
        LDA $4E         ; Cursor row
        STA $5E         ; Set cursor row
        LDA $4D         ; Get cursor column
        STA $5D         ; Save cursor column
        LDA $11D8       ; Get gear effects 
        STA $F0         ; And save
        LDA #$57        ; C3/990F
        STA $26         ; Next: Item list
        JSR $9B59       ; Build item list
        JSR $A150       ; Sort it by power
        JSR $9AEB       ; Cursor & Scrollbar
        LDA #$55        ; Return here if..
        STA $27         ; ..list is empty
        LDA #$10        ; Description: Off
        TSB $45         ; Set menu flag
        JSR $6A15       ; Blank item list
        JSR $1368       ; Trigger NMI
        JSR $9CAC       ; Draw item list
        JSR $9233       ; Draw stat preview
		JSR $9E23		; Refresh BG3 Tilemap A
		JMP $1368		; Trigger NMI
         
; Fork: Handle B
C398B4:  LDA $09         ; No-autofire keys
         BIT #$80        ; Pushing B?
         BEQ C39EC4      ; Branch if not
         JSR $0EA9       ; Sound: Cursor
         JSR $8E50       ; Load navig data
         JSR $8E59       ; Relocate cursor
		 LDA #$10		 ; Desc: Off
         TSB $45         ; Set Menu flag
		 JSR $1368       ; Trigger NMI
		 LDA #$36		 ; C3/9621
         STA $26         ; Next: Option list
         RTS
		 
warnpc $C39eC4
; Fork: Handle L and R, prepare for menu reset
C39EC4:	 LDA #$7E        ; C3/1BE5
         STA $E0         ; Set init command
         JMP $2022       ; Handle L and R
padbyte $ff
pad $C39EC4
warnpc $C39ECB


org $C398CB

; 56: Handle manual gear removal
C398CF:	 LDA #$10        ; Description: On
		 TRB $45         ; Set menu flag
		 JSR $9E14       ; Queue text upload
		 JSR $8E72       ; Handle D-Pad
         JSR $9F6A       ; Load description for equipped gear
		 LDA $08         ; No-autofire keys
         BIT #$80        ; Pushing A?
         BEQ C398F4      ; Branch if not
         JSR $0EB2       ; Sound: Click
         JSR $93F2       ; Actor's address
         REP #$21        ; 16-bit A; C-
         TYA             ; Move it to A
         SEP #$20        ; 8-bit A
         ADC $4B         ; Add cursor slot
         TAY             ; Index sum
         LDA $001F,Y     ; Item in slot
         JSR $9D5E       ; Put in stock
         LDA #$FF        ; Empty item
         STA $001F,Y     ; Clear gear slot
		 JSR $90B5
 		 JSR $9E23	     ; Refresh BG3 Tilemap A
		 JMP $1368		; Trigger NMI
		
; Fork: Handle B
C398F4:  LDA $09         ; No-autofire keys
         BIT #$80        ; Pushing B?
         BEQ C39908      ; Branch if not
         JSR $0EA9       ; Sound: Cursor
         JSR $8E50       ; Load navig data
         JSR $8E59       ; Relocate cursor
         LDA #$36        ; C3/9621
         STA $26         ; Next: Option list
         RTS

; Fork: Handle L and R, prepare for menu reset
C39908:  LDA #$7F        ; C3/1BF3
         STA $E0         ; Set init command
         JMP $2022       ; Handle L and R
 

; ------------------------------------------------------------------------
; Handle gear browsing (Action 57)
; Adds description handling, backs up gear effects, supports
; auto-cursor change respecting current column
; (Unified Equip Menu)

BrowseGear:
  LDA #$10        ; Description: On
  TRB $45         ; Set menu flag
  JSR $9E14       ; Queue text upload
  JSR $9AD3       ; Handle navigation
  JSR $9233       ; Draw stat preview
  JSR $A294       ; Load description

  LDA $08         ; No-autofire keys
  BIT #$80        ; Pushing A?
  BEQ .check_b    ; Branch if not
  JSR $9A42       ; On a gray item?
  BCC .fail       ; Fail if so
  JSR $0EB2       ; Sound: Click
  LDA $001F,Y     ; Item to unequip
  CMP #$FF        ; None?
  BEQ .clear      ; Branch if so
  JSR $9D5E       ; Put in stock
.clear
  TDC             ; Clear A
  LDA $4B         ; Gear list slot
  TAX             ; Index it
  LDA $7E9D8A,X   ; Inventory slot
  TAX             ; Index it
  LDA $1869,X     ; Item in slot
  STA $001F,Y     ; Equip on actor
  JSR $9D97       ; Adjust stock
  JSR $90b5		  ; Redo text, status (* new routine position)
  BRA .exit_list  ; Exit gear list

.check_b
  LDA $09         ; No-autofire keys
  BIT #$80        ; Pushing B?
  BEQ .exit       ; Exit if not
  JSR $0EA9       ; Sound: Cursor

  LDA $F0         ; Get stored Gear Effects [BNW ?]
  STA $11D8       ; Copy to RAM [BNW ?]
.exit_list
  LDA #$10        ; Description: Off
  TSB $45         ; Set menu flag

  JSR $9C87       ; Clear stat preview
  REP #$20        ; 16-bit A
  LDA #$0100      ; BG1 H-Shift: 256
  STA $7E9BD0     ; Hide gear list
  SEP #$20        ; 8-bit A
  LDA #$C1        ; Top cursor: Off
  TRB $46         ; Scrollbar: Off
  JSR $8E6C       ; Load navig data
  LDA $5E         ; Former position (changed from $5F)
  STA $4E         ; Set cursor row
  LDA $5D         ; Former column [?]
  STA $4D         ; Set cursor column [?]
  JSR $8E75       ; Relocate cursor
  JSR $1368       ; Refresh screen (*)
  jsr $9e23		  ; You are equipping a weapon and refresh is required to avoid lag
  LDA #$55        ; C3/9884
  STA $26         ; Next: Body parts
.exit
  RTS
.fail
  JSR $0EC0       ; Play buzzer
  JMP $305D       ; Pixelate screen (* remove unnecessary RTS)

; ------------------------------------------------------------------------
; Draw "R-hand" and "L-hand" in Equip menu
; Handle placeholder text for empty slots
; Handle Gauntlet effect coloring
; Moves much code to new locations for space
; (Unified Equip Menu) 

DrawHands:
  LDA $11D8       ; Gear effects
  AND #$08        ; Gauntlet?
  BEQ .draw_them  ; Branch if not
  JSR $93F2       ; Define Y
  LDA $001F,Y     ; R-Hand item
  CMP #$FF        ; None?
  BEQ .lyelit     ; Draw L-Hand in yellow
  LDA $0020,Y     ; L-Hand item
  CMP #$FF        ; None?
  BNE .draw_them  ; branch if equipped
.ryelit
  LDA #$28        ; palette: yellow
  STA $29         ; set color ^
  JSR $9ecf		  ; draw r-hand w/o changing color
  JMP $9ee9		  ; set user color, then draw l-hand
.lyelit
  LDA #$28        ; palette: yellow
  STA $29         ; set color ^
  JSR $9eed  	 ; draw l-hand w/o changing color
  JMP $9ecb	     ; set user color, then draw r-hand
.draw_them
  JSR $9ecb   	 ; Draw R-Hand name/item
  JMP $9ee9	     ; Draw L-Hand name/item

; Define Bat.Pwr mode (normal, doubled, or combined hands)
C399E8:  STZ $CD         ; Genji mode off
         LDA $11D8       ; Gear effects
         AND #$10        ; Genji Glove?
		 BEQ C399F3
         BRA real_dual   ; Branch if not
C399F3:  STZ $A1         ; Power x2: Off
         LDA $11D8       ; Gear effects
         AND #$08        ; Gauntlet?
         BEQ C39A0C      ; Exit if not
         LDA $001F,Y     ; R-Hand item
         CMP #$FF        ; None?
         BEQ C39A0E      ; Branch if so
         LDA $0020,Y     ; L-Hand item
         CMP #$FF        ; None?
         BEQ C39A2B      ; Branch if so
         BRA C39A0C      ; ...
C39A0C:  SEC             ; ...
         RTS

real_dual:
		 LDA $001F,Y     ; R-Hand item
         CMP #$5a        ; Weapon?
		 BCC .check_left ; Check left if so
		 BRA C399F3		 ; No weapon so Attack can't be merged
.check_left:         
		 LDA $0020,Y     ; L-Hand item
         CMP #$5a        ; Weapon?
         BCS C399F3      ; Branch if not
		 INC $CD		 ; Attack should be merged
         BRA C399F3      ; Branch if not

; Fork: Check if L-Hand also empty
C39A0E:  LDA $0020,Y     ; L-Hand item
         CMP #$FF        ; None?
         BNE C39A17      ; Branch if not
         BRA C39A0C      ; Exit

; Fork: Check if two-handed weapon in L-Hand
C39A17:  JSR $8321      ; Compute index
         LDX $2134       ; Load it
         LDA $D85013,X   ; Properties
         AND #$40        ; 2-hand OK?
         BEQ C39A0C      ; Exit if not
         CLC             ; ...
         LDA #$01        ; Power: x2
         STA $A1         ; Set Pwr mode
         RTS

; Fork: Check if two-handed weapon in R-Hand
C39A2B:  LDA $001F,Y     ; R-Hand item
         JSR $8321      ; Compute index
         LDX $2134       ; Load it
         LDA $D85013,X   ; Properties
         AND #$40        ; 2-hand OK?
         BEQ C39A0C      ; Exit if not
         CLC             ; ...
         LDA #$01        ; Power: x2
         STA $A1         ; Set Pwr mode
         RTS

padbyte $ff
pad $c39a42
warnpc $C39a42

org $C35fc8
	jsr C399E8	; Define Bat.Pwr
org $c390d1
	jsr C399E8	; Define Bat.Pwr
org $c39271
	jsr C399E8	; Define Bat.Pwr


org $c390bc
	jsr DrawHands

	
org $C3960C
; Switch to layout with options in Equip or Relic menu
C3960C:  RTS

; 36: Handle Equip menu options
C39621:  LDA #$10        ; Description: Off
         TSB $45         ; Set menu flag
         ; JSR $1368       ; Refresh screen
         JSR $9E14       ; Queue BG3 upload
         JSR $9041       ; Draw options
         JSR $8E56       ; Handle D-Pad
         LDA $08         ; No-autofire keys
         BIT #$80        ; Pushing A?
         BEQ C39635      ; Branch if not
         JSR $0EB2       ; Sound: Click
         BRA C39664      ; Handle selection
         
; Fork: Handle B
C39635:  LDA $09         ; No-autofire keys
         BIT #$80        ; Pushing B?
         BEQ C39638      ; Branch if not
         JSR $0EA9       ; Sound: Cursor
         JSR $9F06
		 LDA #$04        ; C3/1A8A
         STA $27         ; Queue main menu
         STZ $26         ; Next: Fade-out
         RTS

; Fork: Handle L and R, prepare for menu reset
C39638:  LDA #$35        ; C3/1BB8
         STA $E0         ; Set init command
         JMP $2022       ; Handle L and R

org $C3964F
; Handle selected option in Equip menu
C39664:  TDC             ; Clear A
         LDA $4B         ; Cursor slot
         ASL A           ; Double it
         TAX             ; Index it
         JMP (C3966C,X)  ; Handle option

; Jump table for the above
C3966C:  dw C39674       ; EQUIP
         dw C3968E       ; REMOVE
         dw C3969F       ; EMPTY

; Handle "EQUIP" selection in Equip menu
;org $C39674
C39674:	 JSR C39E4B     ; Update text colour (Yellow)
         JSR $9F7F      ; Update menu colours (Equip)
		 JSR $8E6C      ; Load navig data
		 JSR $11B0      ; Handle anim queue
		 JSR $134D      ; Update screen/pad		
         JSR $8E75      ; Relocate cursor
		 JSR $9e23		; Refresh BG3 Tilemap A + Upper B
         LDA #$55       ; C3/9884
         STA $26        ; Next: Slot choice
		 RTS

; Handle "RMOVE" selection in Equip menu
;org $C3968E
C3968E:  JSR C39E4B     ; Switch windows
         JSR $9F91      ; Update menu colours (Remove)
         JSR $8E6C      ; Load navig data
         JSR $8E75      ; Relocate cursor
		 JSR $9e23		; Refresh BG3 Tilemap A + Upper B
         LDA #$56       ; C3/98CF
         STA $26        ; Next: Slot choice
         RTS
		 
; Handle "EMPTY" selection in Equip menu
C3969F:  JSR C396A8      ; Remove gear
         JSR $90B5       ; Redo text, status
         STZ $4D         ; Cursor: "USE"
         RTS


; Remove character's equipment
C396A8:  JSR $93F2      ; Define Y
		 ldx #$0005
C396AE:	 lda $001f,y
		 jsr $9D5E
		 lda #$ff
		 sta $001f,y
		 iny
		 dex
		 bpl C396AE
         RTS
		 	 
warnpc $C396AA

org $C396C4
	BRA C396AE

; 6E: Open Equip menu after removing all gear
org $C31C26
	JSR $1BBD      ; Init variables
    JSR C396A8      ; Remove gear


org $c36525

padbyte $FF
pad $C3652C
warnpc $C3652D

; Patch bug in merged equip menu descriptions (taken from bropedio-2.1/random-party-2.asm)

org $C39F70
DescripBug:
  LDA $4B     ; slot index
.loop
  BEQ .done   ; branch if done adding
  INY         ; add to offset
  DEC         ; reduce slot index left
  BRA .loop   ; loop
.done

; add cursor wrapping to equip slot selection
org $C38E7B : db $00    ; wrap in both directions
