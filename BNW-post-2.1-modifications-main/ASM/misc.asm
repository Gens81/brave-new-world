arch 65816
hirom

table "menu.tbl", ltr ; Tabella per le stringhe di testo

;;--------------------------------------------------
;;Item box dimension
;;	First value: Start print position X assis
;;  Second value: Start print position Y assis
;;	Third value: Height
;;	Fourth value: Lenght
;;--------------------------------------------------

org $C37E13
	db $8B,$58,$04,$01	;Item window
	db $97,$58,$16,$01	;Use_Arrange_Rare window
	db $4b,$59,$1c,$03	;Description window
	db $8b,$5a,$1c,$10	;Item List window
	
;;--------------------------------------------------
;;Cursor position
;;	First: Y Assis
;;	Second value: X Assis
;;--------------------------------------------------

org $C37D9D

;Use
dw $0f40

;Arrange
dw $0f68

;Rare
dw $0fb0

; Load navigation data & Handle D-Pad for Item, Colosseum, or Sell menu

org $C37D1C
	LDY #Navigation_Data 	; C3/7D2B
	JMP $05FE				; Load navig data
	JSR $81C7				; Handle D-Pad
	LDY #Cursor_Position	; C3/7D30
	JMP $0648				; Relocate cursor
	
padbyte $FF
pad $c37d43

; Cursor positions for rare item menu
org $C37D58
	dw $4a08+$400        ; Item 1
	dw $4a78+$400        ; Item 2
	dw $5608+$400        ; Item 3
	dw $5678+$400        ; Item 4
	dw $6208+$400        ; Item 5
	dw $6278+$400        ; Item 6
	dw $6e08+$400        ; Item 7
	dw $6e78+$400        ; Item 8
	dw $7a08+$400        ; Item 9
	dw $7a78+$400        ; Item 10
	dw $8608+$400        ; Item 11
	dw $8678+$400        ; Item 12
	dw $9208+$400        ; Item 13
	dw $9278+$400        ; Item 14
	dw $9e08+$400        ; Item 15
	dw $9e78+$400        ; Item 16
	dw $aa08+$400        ; Item 17
	dw $aa78+$400        ; Item 18
	dw $b608+$400        ; Item 19
	dw $b678+$400        ; Item 20
	
	
; HDMA Tables
; First Value are the scanlines

; BG1 H-Shift table for inventory-style menus
org $C37EDA
	db $20,$00,$01  ; Value to change for moving up the scroll menu
	db $2f,$00,$01  ; Value to change for moving up the scroll menu
	db $80,$00,$00  ; Items
	db $1E,$00,$01  ; Nothing
	db $00          ; End

; BG1 V-Shift table for inventory-style menus
;org $C37EE7
	db $1F,$80,$00  ; Value to change for moving up the scroll menu
	db $08,$00,$00  ; Nothing?
	db $0C,$04,$00  ; Nothing?
	db $0C,$08,$00  ; Nothing?
	db $08,$80,$00  ; Nothing?
	db $08,$00,$00  ; Nothing?
	db $04,$b8,$FF  ; Item row 1
	db $04,$b8,$FF  ;    
	db $04,$b8,$FF  ; 
	db $04,$bC,$FF  ; Item row 2 
	db $04,$bC,$FF  ;   
	db $04,$bC,$FF  ;   
	db $04,$c0,$FF  ; Item row 3 
	db $04,$c0,$FF  ;   
	db $04,$c0,$FF  ;   
	db $04,$c4,$FF  ; Item row 4 
	db $04,$c4,$FF  ;   
	db $04,$c4,$FF  ;   
	db $04,$c8,$FF  ; Item row 5 
	db $04,$c8,$FF  ;   
	db $04,$c8,$FF  ;   
	db $04,$cC,$FF  ; Item row 6 
	db $04,$cC,$FF  ;   
	db $04,$cC,$FF  ;   
	db $04,$d0,$FF  ; Item row 7 
	db $04,$d0,$FF  ;   
	db $04,$d0,$FF  ;   
	db $04,$d4,$FF  ; Item row 8 
	db $04,$d4,$FF  ;   
	db $04,$d4,$FF  ;   
	db $04,$d8,$FF  ; Item row 9 
	db $04,$d8,$FF  ;   
	db $04,$d8,$FF  ;   
	db $04,$dC,$FF  ; Item row 10
	db $04,$dC,$FF  ;    
	db $04,$dC,$FF  ;    
	db $04,$e0,$FF  ; Item row 11
	db $04,$e0,$FF  ; 
	db $04,$e0,$FF  ; 
;Closing table data
	db $1E,$00,$00  ; Nothing
	db $00          ; End


; Navigation data & Cursor positions for Item, Colosseum, and Sell menus

;C37D2B:
Navigation_Data:
	db $01          ; Wraps horizontally
	db $00          ; Initial column
	db $00          ; Initial row
	db $01          ; 1 column
	db $0B          ; 11 rows
;C37D30: 
Cursor_Position: 
	dw $4E08        ; Item 1
	dw $5A08        ; Item 2
	dw $6608        ; Item 3
	dw $7208        ; Item 4
	dw $7E08        ; Item 5
	dw $8A08        ; Item 6
	dw $9608        ; Item 7
	dw $A208        ; Item 8
	dw $AE08        ; Item 9
	dw $BA08        ; Item 10
	dw $C608		; Item 11
	
warnpc $C37F7B

org $c30854
	adc #$0A				; Extend blinking finger to 1 up line	

org $c37e35
	ldy #Item_Description	; Moving item descritpion HDMA data table in another section

;org $C37fb1
;	ldx #$0031				; Item type 1st row -> The code perform a TXA, ASL and the added to BG1 base address $7E3849
;
;org $c37fbd
;	ldx #$0023				; Item name ist row -> Same as above
	
org $c37f8b
	ldy #$000b				; How many lines must be loaded in the BG1 Tilemap

Org $c37ec6
	cpx #$007E				; BG1 V-Shift table size

org $c37ed4					; Closing Table data size
	cpx #$0082

org $C31af3
	LDA #$0B				; Onscreen rows: 11

org $c31b19
	lda #$0085				; Extend scroll triangle cursor
org $c31b20
	lda #$0046				; Triangle cursor starting point

org $c3265f
	lda #$0085				; Extend scroll triangle cursor (from USE ARRANGE RARE to scroll)
org $c32666
	lda #$0046				; Triangle cursor starting point (from USE ARRANGE RARE to scroll)

org $c3bc0a
	lda #$0085				; Extend scroll triangle cursor (Shop menu)
org $c3bc11
	lda #$0046				; Triangle cursor starting point (Shop menu)
	
org $c309b1
	adc #$0085				; ADD to complete below half cursor scroll


;;-----------------------------------------------------
;;
;;Colosseum
;;
;;-----------------------------------------------------

; Window layout for Colosseum item menu
org $C3AD8A
	dw $588B,$0109  ; 11x04 at $588B (Title)
	dw $58A1,$0111  ; 19x04 at $58A1 ("Select...")
	dw $594B,$031C  ; 30x05 at $598B (Description)
	dw $5A8B,$101C  ; 30x17 at $5ACB (Items)

; Positioned text for Colosseum
org $C3AD9A
	dw $78cd : db "Colosseum",$00
	dw $78e3 : db "Select an Item",$00

;Change words position
org $C3B251
    db $EB,$78        ;Right item
org $C3B261
    db $CD,$78        ;Left item

;Change box dimension
org $C3B33F
	db $8b,$58,$0d,$01	;Left Item
	db $a9,$58,$0d,$01	;Right Item

;Moving challenger data
org $c3aefa
	ldy #$7c51

org $C3B427
	db $cd,$78,"?????????????",$00
	
;Fix gradient scale

org $D4CB42
;upper side
	dw $e001,$e702,$e603,$e503,$e403,$e302,$e203,$e103
	dw $e003,$e102,$e201,$e301,$e401,$e501,$e601,$e701

;bottom side
	dw $e070,$ea01,$e903,$e804,$e704,$e604,$e504,$e404
	dw $e304,$e204,$e104,$e004,$e104,$e204,$e304,$e404
	dw $e504,$e604,$e704,$e804,$e904,$ea02

;;-----------------------------------------------
;;Inside item submenu
;;-----------------------------------------------
org $C3331e
	ldy #$391b		;1 Name position
	
org $C3336a
	ldy #$3a9b		;2 Name position

org $C333B6
	ldy #$3c1b		;3 Name position

org $c33402
	ldy #$3d9b		;4 Name position

;Windows sizes
;	first value x start assis print
;	second value y start assis print
;	third value wide sizes
;	fourth value height sizes
 
org $C38A3B
	db $9d,$58,$13,$18	;Stats window
	db $8b,$58,$0e,$01	;Item window
	db $4b,$59,$07,$03	;Owned window

org $C38A54
	db $cd,$78  	;Move Item name 1 line up

;------------------------------------------------------
;Hide rare counter item and expand description box
;------------------------------------------------------
; Some changes for free up space 
; Moving Compute item data index next to Prepare item description loadin can permit to gain 
; 10 $FF bytes + the 52 bytes over the compute routine but it's called from 34 routines 
ORG $C31F35
    JMP $0F39      ; Queue its upload
	DL $FFFFFF		; Clean up old JSR
	
ORG $C32772
    JMP $0F39      ; Queue its upload
	DL $FFFFFF		; Clean up old JSR	
	RTS				; Labelled
	

ORG $C3A1D8
	JSR C38308
ORG $C3B4EF
	JSR C38308
ORG $C3B4F8
	JSR C38308
ORG $C39F6A
	JSR C38308
ORG $C3FF00
	JSR C38308
	
	
; Load common item's description and draw item count in Item menu
org $C382F1
C382F1:  JSR C38308      ; Set desc ptrs
         TDC             ; Clear A
         LDA $4B         ; Cursor slot
         TAY             ; Index it
         LDA $1869,Y     ; Item in slot
         JMP $5738

; Prepare item description loading
C38308:  LDX #$7AA0      ; ED/7AA0
         STX $E7         ; Set ptr loc LBs
         LDX #$6400      ; ED/6400
         STX $EB         ; Set text loc LBs
         LDA #$ED        ; Bank: ED
         STA $E9         ; Set ptr loc HB
         LDA #$ED        ; ...
         STA $ED         ; Set text loc HB
         LDX #$9EC9      ; 7E/9EC9
         STX $2181       ; Set WRAM LBs
         RTS

padbyte $FF
Pad $C38321
warnpc $C38321

; Compute item data index
;C38321:  PHA             ; Save item
;C38322:  LDA $4212       ; PPU status
;         AND #$40        ; H-Blank?
;         BEQ C38322      ; Loop if not
;         PLA             ; Item
;         STA $211B       ; Set matrix A LB
;         STZ $211B       ; Clear HB
;         LDA #$1E        ; Item data size
;         STA $211C       ; Set matrix B
;         STA $211C       ; ...
;         RTS
		 
; Load rare item's description and draw item count
org $C38339
C38339:  LDX #$FB60      ; CE/FB60
         STX $E7         ; Set ptr loc LBs
         LDX #$FCB0      ; CE/FCB0
         STX $EB         ; Set text loc LBs
         LDA #$CE        ; Bank: CE
         STA $E9         ; Set ptr loc HB
         STA $ED         ; Set text loc HB
         JSR $572A      ; Load description
         LDA #$20        ; Palette 0
         STA $29         ; Color: User's
         RTS

warnpc $C38351


;------------------------------------------------------------------
;New consumable icon
;------------------------------------------------------------------	
org $C326E3
.loop	
	lda.l icon,x	; load icon value
	phx         ; save X
	sta $e0     ; save value on e0
	jsr $2706   ; 
	plx         ; restore X
	inx         ; increase X
	cpx #$0012  ; all icon checked?
	bne .loop   ; branch if not
	rts         ; return
	
padbyte $FF
pad $C326F5
warnpc $C326F5

org $C0FF9A
icon:
	db $eb	;item
	db $d8	;tool
	db $d9	;star
	db $da	;scroll
	db $db	;knife
	db $dc	;sword
	db $dd	;spear
	db $de	;claw
	db $df	;katana
	db $e0	;casino
	db $e1	;rod
	db $e2	;brush
	db $ec	;ranged
	db $e3	;other
	db $e4	;shield
	db $e5	;helmet
	db $e6	;armor
	db $e7	;relic

warnpc $C32965

org $D26F8C
	db "Ranged "
;------------------------------------------------------------------
;Load empty tiles on category item in battle inventory
;------------------------------------------------------------------

org $c16534
  cmp #$EB
  
;------------------------------------------------------------------
;Fix equip menu gfx bug
;------------------------------------------------------------------	

org $C3906c
	LDY #draw_equip_box1
org $C39072
	LDY #draw_equip_box2
org $C39078
	LDY #draw_equip_box3
org $C3907E
	LDY #draw_equip_box4

; Moving 1 tile down all the bg2 tilemaps box & up by 6 pixel
; Set text position and load actor data address

org $C3946D  
	REP #$20        ; 16-bit A
	TXA             ; Tilemap ptr
	STA $7E9E89     ; Set position
	SEP #$20        ; 8-bit A
; Moving 6 pixels up bg2
	PHA
	LDA #$06
	STA $3B
	PLA
	JMP $93F2      ; Load address
; Load and draw equipped item's name 
	JSR $8FE1      ; Load item name
	JMP $7FD9      ; Draw item name
; Boxes Data
draw_equip_box1:
	db $8b,$5b,$1c,$0d
draw_equip_box2:
	db $8b,$58,$1c,$0a
draw_equip_box3:
	db $8b,$58,$1c,$01
draw_equip_box4:
	db $8b,$58,$06,$01

warnpc $c39496

org $c39edc
	jmp $947f
org $c39efa
	jmp $947f
org $c3940d
	jmp $947f
org $c3916e
	jmp $947f
org $c3918c
	jmp $947f
org $c391a9
	jmp $947f

;Wounded
org $C3371B
	db " KO    "

;scroll fixing on lore menus

org $C32175
	LDA #$1800	;v-speed 24 pixel

org $C3218B
    LDA #$04	;scroll limit at line 12 (Tsunami)

; Lore Battle Menu

org $C18336 : CMP #$08    ; lore menu length 12 (4 shown on first page + 8 scrolling)
org $C1838F : LDA #$08    ; lore menu scrollbar flash
org $C18393 : LDX #$0500  ; scrollbar reaching the end of the menu correctly

; Throw Battle Menu

org $C186E4 : CMP #$11    ; throw menu length 21 (4 shown on first page + 17 scrolling)
org $C18735 : LDA #$11    ; throw menu scrollbar flash
org $C18739 : LDX #$0220  ; scrollbar reaching the end of the menu correctly

;Adding Muddle to Siren Song

org $C46DE9
	db $30

;Changing element tiles to print in inventory sub-menu

org $D8E90E
	db $FD,$FA,$F6,$F9,$EF,$F8,$FB,$FC,$00		; water, earth, holy, wind, dark, bolt, ice, fire
	
; Mosaic effect mitigation

org $C00E82  
	db $0F, $1F, $2F, $3F, $2F, $1F, $2F, $3F, $2F, $1F, $2F, $3F, $2F, $1F, $2F, $3F, $2F, $1F, $2F, $3F, $2F, $1F, $2F, $3F, $2F, $1F, $2F, $3F, $2F, $1F
	
; fix an hard to trigger bug that can softlock the game moving char sprite offscreen

org $CACBAD
	db $FD

; fixed "pink gogo" bug

org $C456EA
	db $CD

org $C4575F
	db $0D

; ST Cure no longer heals poison on affected chars equipping a poison denying relic

org $C391EC	
	AND #$20

; slim jim not usable on menu
	
org $D86D88
	db $26

; blocks blitz p2 inputs

org $C3A4B2      ; Scrap the old "merged inputs" behaviour that was located here
  LDA $EB        ; It used to merge P1+P2 inputs together, and was read during
  STA $04        ; Blitz inputs (?), allowing P2 to screw up P1's Blitzes, and
  BRA $02        ; vice versa. This just makes $04 a copy of the current inputs.

; 255 attack bug fix

org $C198C5
    LDA #$01
    STA $629E
    STA $E9C3
    STZ $7B67
warnpc $C198D0

;Preserves the Undead status set by the Ghost Ring when raging a non-undead monster
;Author: Fëanor

!free = $C25E63     ; requires 11 bytes
!warn = !free+15    ; provides 15 bytes

; -----------------------------------------------------------------------------
; Init Monster/Rage Data [C2/2DC1-C2/2E39]
;   ...
;   STA $3BCC,Y
org $C22E31
    JSR Splice
    NOP
warnpc $C22E35
;   STA $3C94,Y
;   ...
; -----------------------------------------------------------------------------

org !free
Splice:
    LDA $3C94,Y     ; load current metamorph info & special flags
    AND #$8000      ; preserve only the undead flag
    ORA $CF0011,X   ; OR with monster's metamorph info & special flags
    RTS
warnpc !warn

;; -----------------------------------------------------------------------------
;; Synopsis: Adds hotkey to exit the main menu from anywhere.
;;   Author: Fëanor
;;  Created: 2023-07-21
;;  Updated: 2023-10-23
;; -----------------------------------------------------------------------------
;!free = $C3F6B0
;!warn = $C3F6CB
;
;!hotkey = #$10      ; Start
;
;; prevent mini-map toggling if Start is held for too long
;org $EE2028 : LDA $09   ; load pressed buttons (no-autofire keys)
;
;; -----------------------------------------------------------------------------
;; Menu State Loop
;; -----------------------------------------------------------------------------
;; C3/01BA:
;;   JSR $1412
;org $C301BD
;    JSR MenuLoopSplice
;;   CMP #$FF
;;   BEQ $01D8
;;   ...
;;   STZ $43
;;   RTS
;; -----------------------------------------------------------------------------
;
;org !free
;MenuLoopSplice:     ; [27 bytes]
;    TDC             ; [displaced]
;    LDA $0200       ; load menu type
;    BNE +           ; branch if ^ not main menu
;	LDA $09         ; load pressed buttons (no-autofire keys)
;    AND !hotkey     ; check if hotkey is pressed
;    BEQ +           ; branch if not ^
;    STZ $0205       ; clear item used out-of-battle
;    JSR $0EA9       ; play cursor sound effect (cancel)
;    JSR $1DD2       ; update field equipment effects
;    LDA #$FF        ; setup menu exit
;    RTS
;  + LDA $26         ; [displaced]
;    RTS
;warnpc !warn


; #########################
; Fix sprite priority after cover (Bropedio)

org $C1C225 : BEQ $05
org $C1C22A : NOP #2

;pressing/holding A will advance dialog text (Fëanor)

org $C0854F : LDA #$01
org $C08579 : LDA #$01

;Stray Flash by CDude
org $D0784B 
	db $A7	;fix flash tool sprite position
	
; button_blunder (Gi Nattak)
org $CA1B15 : db $0C	;correct button Graphic in Gogo endgame scene

; ---------------------------------------------------------
; Support more colors for drawing esper names

org $C3F480
DrawEsperName:
  LDA #$24          ; "blue" palette
  STA $29           ; set palette color
  PHY               ; store tile position
  JSR $34CF         ; draw character name
  LDA #$34          ; "pink" unset palette (RAM noise)
  STA $29           ; set palette color
  REP #$20          ; 16-bit A
  PLA               ; get tile position
  CLC               ; prepare add
  ADC #$0020        ; advance 16 spaces
  TAY               ; store new tile position
  SEP #$20          ; 8-bit A
DrawFromEsperMenu:
  JSR $34E6         ; draw esper name 
  LDA #$20          ; "white" palette
  STA $29           ; set palette color
  RTS
warnpc $C3F4AA
padbyte $FF
pad $C3F4AA

;config screen modifications
org $C349AC
	db "XP Gain ",$00	;changed Exp. to XP

org $C3F453 
	db "Wait Gauge",$00	;replace Show Delay

; replace MP separator in lores menu
org $C3529C : db $D3

; replace Attack/Defense separator in sell menu
org $C3C36D : db $D3

; replace spell progress separator in magic menu
org $C3506B : db $D3
	
;change Setzer's initial weapon
;org $ED7D75
;	db $03	;Butterfly

; edit jump table to skip over Window/Short check
org $C3234E : dw $236F

; Prelude School
; author: Bropedio
;
; Allow the prelude to play during the first visit to
; the beginner's school at the beginning of the game

!free = $C0FD5A ; 11 bytes
!warn = $C0FD65

; $C0034E - Update music on map load
org $C0035F : JSR GetSong ; get song when not allowed to change music

org !free
GetSong:
  LDA $053C          ; map's song
  CMP #$01           ; is it "Prelude" ($01)
  BEQ .exit          ; if so, override "current song"
  LDA $1F80          ; [displaced] get current song
.exit
  RTS
warnpc !warn

; This hack re-enables the "E" icon when shopping which indicates that a
; character has a piece of equipment already equipped. This reverts the
; following change that was made previously:
;
;   org $C3C29C : BRA $3F ; Never show equipped/up/down/equal icons
;
; Note: Removing dead code would free up around 42 bytes.

org $C3C29C
    CMP #$01        ; check if already equipped
    BEQ e_icon      ; show "E" icon if ^
    BRA no_icon     ; show no icon otherwise

org $C3C2B6 : e_icon:
org $C3C2DD : no_icon:

;fix text position and nomenclature in multiple controller config submenu

org $C347C0
	LDY #$7C0F

org $C347FD
	LDY #$7C8F
	
org $C3483A
	LDY #$7D0F
	
org $C34877
	LDY #$7D8F

org $C34B08
	db $21,$7C,"Port 1",$00
	db $33,$7C,"Port 2",$00
	db $A1,$7C,"Port 1",$00
	db $B3,$7C,"Port 2",$00
	db $21,$7D,"Port 1",$00
	db $33,$7D,"Port 2",$00
	db $A1,$7D,"Port 1",$00
	db $B3,$7D,"Port 2",$00

; hide warp point in Phoenix Cave permanently
org $C4566D : db $45    ; set "Returner's Hideout: Banon (Main Room)" as NPC switch
                        ; Note: this NPC switch is turned off at CA/FD9E as
                        ; part of setting up the Lete River sequence
						
;empty moogle charm spot
org $ED8678
	db $40,$BD

;Yeti drops Moogle Charm
org $CF3442
	db $DE,$DE

;Zozo chest Hell Claw>Ninja Star
org $ED88E0
	db $43

; -----------------------------------------------------------------------------
; The current optimize equipment routine wasn't written with the current
; dual-wielding implementation in mind. It contains a bug where if a character
; has a dual-wield weapon equipped prior to optimization, he might get equipped
; with two non-dual-wield weapons. 
; TODO: remove the dual-wield handling completely to free up a few bytes
; -----------------------------------------------------------------------------

; disable genji glove handling
org $C39728 : NOP #2  ; never branch
	
;; check event bit "164: World of Ruin" ($1E94.4) when determining if
;; Interceptor can hit floating targets
;org $C23C22
;    LDA $1E94       ; load event flags
;    AND #$10        ; check for "World of Ruin" event bit

;custom key prompts for blitz commands

org $C35C22 
	db $6C	;X
org $C35C24
	db $6D	;Y
org $C35C26 
	db $6E	;L
org $C35C28
	db $6F	;R

;Brave New World data
org $C33BB8
	db $d1,$78,"Brave New World 2.2 b32",$00
