hirom

!ESP = #$D5

macro FakeC3(addr)
	phk					; push 
	per $0006				; push return
	pea $96EE				; push address
	jml $c3<addr>			; jump to address
endmacro


;ORG $C3331E
;LDY #$391B
;JSR Draw_Actor_Hook
;
;ORG $C3336A
;LDY #$3A9B
;JSR Draw_Actor_Hook
;
;ORG $C333B6
;LDY #$3C1B
;JSR Draw_Actor_Hook
;
;ORG $C33402
;LDY #$3D9B
;JSR Draw_Actor_Hook
;
;
;ORG $C3F6C4
;Draw_Actor_Hook:
;JSL Draw_Esp
;RTS

ORG $C3F31E
JSL Draw_Info_Lvl_Up
RTS

ORG $CFBF80
;Draw_Esp:
;PHY				; Put Y onto Stack (Tilemap pos.)
;LDY $67			; Actor adress
;LDA $001E,Y		; Actor's esper
;CMP #$FF		; None?
;BEQ	No_Esper	; Branch if so
;PLY 			; Restore Y from stack
;DEY				; Decrease pos.
;DEY				; Decrease again
;%FakeC3(3519)	; Set pos/WRAM/Y
;LDA !ESP		; Esper glyph
;STA $2180		; Add to string
;%FakeC3(34D2)	; Draw actor name
;RTL
;
;No_Esper:
;PLY				; Restore Y from stack
;%FakeC3(34CF)	; Draw actor Name
;RTL

Draw_Info_Lvl_Up:
ADC #$000C			; move X position for esper level display
SEP #$20			; 8-bit A
TAX					; Index it

LDY $67			; Actor adress
LDA $001E,Y		; Actor's esper
CMP #$FF		; None?
BNE	Esper		; Branch if not
LDA #$28
STA $29

Esper:
%FakeC3(04B6)		; Print esper level

LDA #$20
STA $29


LDX $67				; Actor adress
TDC					; Clear A
LDA $0000,X			; Actor number
TAX					; Index it
LDA $1D1C,X			; Esper point available?
BEQ No_Avlbl		; Branch if not
REP #$20	        ; 16-bit A
LDA [$EF]   	    ; tilemap position for level display
CLC             	; clear carry
ADC #$0008     		; move X position for esper level display
TAX          	    ; index it
SEP #$20        	; 8-bit A
LDA $F8				; Tens
CMP #$FF			; Blank?
BNE Two_Digit		; Branch if not
INX					; Inc tilemap pos.
INX					; Inc tilemap pos.
Two_Digit:
INX					; Inc tilemap pos.
INX					; Inc tilemap pos.
STX $EB				; Set dest. low byte
LDA #$7E			; Dest. Bank
STA $ED				; Set
LDY $00				; Clear Index
LDA #$D4			; Arrow up sign
STA [$EB],Y			; Save
INY					; Inc pos
LDA #$34			; Palette: Yellow
STA [$EB],Y			; SEt
No_Avlbl:
RTL

  
WARNPC $CFC050