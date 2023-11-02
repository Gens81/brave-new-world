arch 65816
hirom
table "menu.tbl",ltr


; #########################################################################
; Draw Esper

org $C32937 : JMP DrawEsperHook ; include esper equip bonuses
	
; #########################################################################
; Draw Selected Esper Data Info

org $C35A3B : JSR Unspent_EL ; add unspent EL draw to esper bonus draw
	
!EL_bank = $1D1C
!EL = $1D10
!EP = $1CF8

; Change position of LV to make room for EL
; If espers have been acquired, write EL label after LV label
org $C33303 : JSR EL_Main_1 ; Main menu, character 1

org $C3334F : JSR EL_Main_2 ; Main menu, character 2

org $C3339B : JSR EL_Main_3 ; Main menu, character 3

org $C333E7 : JSR EL_Main_4 ; Main menu, character 4

org $C34EEA : JSR EL_Skill  ; draw EL in skills display

; #########################################################################
; Character Lineup
org $C3797D : JSR EL_Party  ; draw EL after LV in party select screen

; #########################################################################
; Draw Character HP/MP/LV Values

org $C30C81 : JSR Esp_Lvl ; Also draw EL value
	


org $ED8BCA
	EP_Chart:
; ------------------------------------------------------------------------
; Status Menu Redesign helpers

org $C3FC20
NewWindow:
	JSR $6A4B               ; vanilla code
	STZ $37                 ; shift BG1 down slightly
	LDY #NewWindowSpec      ; middle window size/position
	JMP $0341               ; draw it

NewWindowSpec:
	dw $5B4B,$0D0f

PortraitPlace:
	LDA $26					; Menu flag
	AND #$00FF				; Keep only flag
	CMP #$000B				; Init Satus menu?
	BEQ .high				; Branch if so
	CMP #$000C				; Sust Status menu?
	BEQ .high				; Branch if so
	CMP #$0042				; Initialize Lineup's Status menu?
	BEQ .high				; Branch if so
	LDA #$0038				; Y-Pos
	RTS
.high
	LDA #$001A				; Y-Pos
	RTS

ELStuff:
  JSR Calc_EP_Status      ; get EP and EP to next Lvl (in F1-F4)
  BCC .exit
  JSR $052E               ; convert 16-bit number into text (from F3-F4)
  JSR Ramuh_Chk			  ; already got esper?
  BEQ .exit				  ; Branch if so and keep the screen clean
  JSR Char_Chk     		  ; check if Gogo or above
  BCS .exit        		  ; exit if ^  
  LDX #$7A61              ; next EL number coords
  JSR $049A               ; draw 5 digits
  REP #$20                ; 16-bit A
.exit
  RTS

DrawEPLabel:
  JSR $02F9               ; draw text at pointer
  LDY #EPLabel            ; pointer to EP Label text
  JMP $02F9               ; draw text at pointer

ClearEPLabel:
  JSR $02F9               ; draw text at pointer
  LDY #EmptyEPLabel       ; pointer to EP Label text
  JSR $02F9               ; draw text at pointer
  LDY #EmptyEPText        ; pointer to EP Label text
  JMP $02F9               ; draw text at pointer

EPLabel:
  dw $7A6B : db "EP",$00     ; EP label
EmptyEPLabel:
  dw $7AEB : db "  ",$00     ; EP label
EmptyEPText:
  dw $7AFB : db "     ",$00  ; EP label

; ------------------------------------------------------------------------
; EL/EP/Spell bank text data and helpers
; Many new label and text positions and tiles
; Updated by Status Menu Redesign

org $C3F277
EPUpTxt:
	dw $7A27 : db "Next",$00  ; Next EL label

; Many "EL" text positions, plus extra $FF buffer for indexing purposes
EL_TXT:
  dw $39AB : db "EL",$00,$FF,$FF,$FF	; Actor 1 Main
  dw $3B2B : db "EL",$00,$FF,$FF,$FF    ; Actor 2 Main
  dw $3CAB : db "EL",$00,$FF,$FF,$FF    ; Actor 3 Main
  dw $3E2B : db "EL",$00,$FF,$FF,$FF    ; Actor 4 Main
  dw $423B : db "EL",$00,$FF,$FF,$FF    ;
  dw $7A19 : db "EL",$00,$FF,$FF,$FF    ;
  dw $3A7B : db "EL",$00,$FF,$FF,$FF    ; Status

UnspentTxt:
  db "Unspent",$00

; TODO: This label no longer used
Calc_EP_Status:     ; ($C3F31B)
  LDA $1E8A         ; event byte
  AND #$08          ; "met Ramuh"
  BEQ .no_ep        ; branch if not ^
  LDX $67           ; character data offset
  LDA $0000,X       ; character ID
  CMP #$0C          ; Gogo or above
  BCC .yes_ep       ; branch if not ^
.no_ep
  RTS
.yes_ep
  PHA               ; store character ID
  LDA #$2C          ; color: gray-blue
  STA $29           ; set text palette
  LDY #EPUpTxt      ; pointer for "EP to lv. up" text display
  JSR DrawEPLabel   ; draw ^
  TDC               ; zero A/B
  LDA #$20          ; color: white
  STA $29           ; set text palette
  PLA               ; restore character ID
  TAY               ; index it
  LDA !EL,Y         ; character's esper level
  CMP #$19          ; at max (25)
  BNE .needed_ep    ; branch if not ^
  SEC               ; set carry (show EP needed)
  JMP $60C3         ; display zero and exit
.needed_ep
  ASL               ; EL x2
  TAX               ; index to EP lookup
  TYA               ; character ID
  ASL               ; x2
  TAY               ; index it
  REP #$30          ; 16-bit A, X/Y
  LDA !EP,Y         ; character's total EP
  STA $F1           ; store ^
  LDA EP_Chart,X    ; EP needed for next level
  SEC               ; set carry
  SBC $F1           ; EP needed - total EP
  STA $F3           ; store ^ (* modified by Status Menu Redesign)
  SEP #$20          ; 8-bit A
  SEC               ; set carry (show EP needed)
  RTS

Esp_Lvl:
  JSR $04B6         ; [displaced] draw two digits
  JSR Ramuh_Chk     ; check if optained espers yet
  BEQ .exit         ; exit if not ^
  JSR Char_Chk      ; check if Gogo or above
  BCS .exit         ; exit if ^
  TAY               ; index character ID
  LDA !EL,Y         ; character's esper level
  JSR $04E0         ; turn into digit tiles
  REP #$20          ; 16-bit A
  JSR Print_EL_Value; Check and print Esper Level value pos
  ADC #$000C        ; move X position for esper level display
  TAX               ; index it
  SEP #$20          ; 8-bit A
  JMP $04B6         ; write esper level to screen
.exit
  RTS

Ramuh_Chk:
  TDC               ; zero A/B
  LDA $1E8A         ; event byte
  AND #$08          ; "met Ramuh"
  RTS

Char_Chk:
  LDX $67           ; character data offset
  TDC               ; zero A/B
  LDA $0000,X       ; character ID
  CMP #$0C          ; carry: Gogo or higher
  RTS

EL_Main_1:
  LDA #$00          ; slot 1 offset for "EL" label in main menu
  PHA               ; store ^
  BRA Write_Text    ; draw "EL" label

EL_Main_2:
  LDA #$08          ; slot 2 offset for "EL" label in main menu
  PHA               ; store ^
  BRA Write_Text    ; draw "EL" label

EL_Main_3:
  LDA #$10          ; slot 3 offset for "EL" label in main menu
  PHA               ; store ^
  BRA Write_Text    ; draw "EL" label

EL_Main_4:
  LDA #$18          ; slot 4 offset for "EL" label in main menu
  PHA               ; store ^
  BRA Write_Text    ; draw "EL" label

EL_Skill:
  LDA #$24          ; color: blue
  STA $29           ; set text palette
  LDA #$20          ; offset for "EL" label in skills menu
  PHA               ; store ^
  BRA Stat_Skill_Ent ; draw "EL" label	

C3F3BF:  
EL_Status:
  LDA #$2C          ; color: blue
  STA $29           ; set text palette
  LDA #$28          ; offset for "EL" label in status menu
  PHA               ; store ^
  BRA Stat_Skill_Ent ; draw "EL" label

EL_Party:
  LDA #$30          ; offset for EL label in party lineup menu
  PHA               ; store ^
Write_Text:
  JSR $69BA         ; [displaced] draw multiple strings

Stat_Skill_Ent:
  JSR Ramuh_Chk     ; obtained espers
  BEQ No_Ramuh      ; branch if not ^
  JSR Char_Chk      ; Gogo check
  PLA               ; restore text offset
  PHP               ; store flags
  REP #$20          ; 16-bit A
  BCS Gogo          ; branch if Gogo or higher
  ADC #EL_TXT       ; else, add "EL" text location
  BRA Write_EL      ; branch to write ^

No_Ramuh:
  PLA               ; restore text offset
  PHP               ; store flags
  REP #$20          ; 16-bit A

Gogo:
  PLP               ; restore flags
  rts				; don't print

Write_EL:
  TAY               ; index text source
  PLP               ; restore flags
  JMP $02F9         ; draw source text

; Adds "Unspent EL" display under the esper bonuses
Unspent_EL:
  LDA #$24          	; color: blue
  STA $29           	; set text palette
  LDY #$4733        	; tilemap position to write to
  JSR $3519         	; initialize WRAM buffer with ^
  LDX $00           	; zero X
.write_uel
  LDA.l UnspentTxt,X 	; get "Unspent EL:" tile
  BEQ .finish       	; break if EOL
  STA $2180         	; else, write to WRAM
  INX               	; next tile index
  BRA .write_uel    	; loop till EOL ($00)
.finish	
  STZ $2180         	; write EOL
  JSR $7FD9         	; draw string from WRAM buffer
  LDA #$20          	; color: white
  STA $29           	; set palette
  JSR Char_Chk      	; current character's ID
  TAY               	; index it
  LDA !EL_bank,Y    	; available ELs for character to spend
  JSR $04E0         	; turn into digit tiles
  LDY #$47B5        	; tilemap position to write to
  JSR $3519         	; initialize WRAM buffer with ^
  LDA $F8           	; tens digit of ELs
  STA $2180         	; write ^
  LDA $F9           	; ones digit of ELs
  STA $2180         	; write ^
  STZ $2180         	; write EOL
  JSR $7FD9         	; draw string from WRAM buffer
  lda #$24				; blue color
  sta $29				; store
  LDY #$4711        	; next tilemap position (shifted left 2 spaces)
  JSR $3519				; Set pos, WRAM
  LDX $00				; Char index: 0
.loop	
  LDA.L EL_Bonus,X		; "EL Bonus" char
  beq .finish_bns		; Point to next 
  STA $2180				; Add to string
  INX
  BRA .loop				; Loop if not
.finish_bns	
  STZ $2180	
  JSR $7FD9         	; draw string from WRAM buffer 
  ldy #$47bb			; "EL text" bottom position 
  JSR $3519				; Set pos, WRAM
  LDX $00
.loop2
  LDA.l ELavlbl,X
  beq .finish_ELavlb	; Point to next 
  STA $2180
  INX
  bra .loop2
.finish_ELavlb  
  STZ $2180
  JMP $7FD9         	; draw string from WRAM buffer  

ELavlbl: db "EL",$00


warnpc $C3F43B+1
padbyte $FF
pad $C3F43B


org $C3F49E
DrawEsperHook:
  JSR $9F06      ; Recalculate numbers (* new routine position)
  JSR $4EED         ; Properly update display
  JMP $4F08         ; draw esper name [?]
	