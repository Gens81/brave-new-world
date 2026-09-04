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
; Inside "Write LV-HP-MP" routine

org $C31D66
JSL Load_Yellow				; In load Game

org $C31CD8
JSL Load_Yellow_Save		; In save menu

ORG $C3F31E
JSL Draw_Info_Lvl_Up
RTS

org $C32558
JSL Restore_Colour


ORG $C30C7F
JML LV_Gray_Out
NOP


ORG $E5FEE0
Restore_Colour:
TDC
TAX
.loop
LDA.l $D8E830,X
STA $7E30A9,X
INX
CPX #$0008
BNE .loop
LDA #$53
STA $26
RTL

LV_Gray_Out:
SEP #$20				; 8 Bit-A - from vanilla -
LDA $29					; Saved Palette
STA $0110				; Save Temporary
LDA $1D4D	    	  	; config byte 
BIT #$08    	    	; "gain exp" flag - AND would works as well
BNE Print_LV	        ; Branch if not
CPX #$7849				; BG3?
BCC BG1					; Branch if not
LDA #$24				; Grey colour BG3
BRA Skip_One_Line		; Skip to set
BG1:
LDA #$28                ; Grey Colour BG1
Skip_One_Line:
STA $29                 ; Set
Print_LV:

LDY #$0C83				; JSR come back address
PHY						; Push onto stack
%FakeC3(04B6)			; Print Char level

LDA $0110				; Saved temporary palette
STA $29                 ; Set


JML $C3F308				; Jump long to the routine that print LV, EL and other stuff


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
ADC #$000C				; move X position for esper level display
SEP #$20				; 8-bit A
TAX						; Index it

LDY $67					; Actor adress
LDA $001E,Y				; Actor's esper
CMP #$FF				; None?
BNE	Esper				; Branch if not
CPX #$7849				; BG3?
BCC .BG1				; Branch if not
LDA #$24				; Grey colour BG3
BRA .Skip_One_Line		; Skip to set
.BG1
LDA #$28                ; Grey Colour BG1
.Skip_One_Line
STA $29                 ; Set

Esper:
%FakeC3(04B6)			; Print esper level

LDA $0110				; Saved temporary palette
STA $29					; Set


LDX $67					; Actor adress
TDC						; Clear A
LDA $0000,X				; Actor number
TAX						; Index it
LDA $1D1C,X				; Esper point available?
BEQ No_Avlbl			; Branch if not
JSR Prepare_Tilemap		; Jump and set tilemap and print Arrow
LDA #$D4				; Arrow up sign
STA [$EB],Y				; Save
INY						; Inc pos
LDA $26					; Menu flag
CMP #$22				; Load game?
BEQ .Load				; Branch if so
CMP #$15				; Save confirmation?
BEQ .Load				; Branch if so
BRA .Not_Load
.Load
LDA #$2C				; Yellow Colour
BRA .Skip_One			; Go to set
.Not_Load
LDA #$34				; Palette: Yellow
.Skip_One
STA [$EB],Y				; SEt
RTL
No_Avlbl:
JSR Prepare_Tilemap
LDA #$FF				; Arrow up sign
STA [$EB],Y				; Save
INY						; Inc pos
LDA #$20				; User Palette
STA [$EB],Y				; Save
RTL

Prepare_Tilemap:
REP #$20	        	; 16-bit A
LDA [$EF]   	    	; tilemap position for level display
CLC             		; clear carry
ADC #$0008     			; move X position for esper level display
TAX          	    	; index it
SEP #$20        		; 8-bit A
LDA $F8					; Tens
CMP #$FF				; Blank?
BNE Two_Digit			; Branch if not
INX						; Inc tilemap pos.
INX						; Inc tilemap pos.
Two_Digit:	
INX						; Inc tilemap pos.
INX						; Inc tilemap pos.
STX $EB					; Set dest. low byte
LDA #$7E				; Dest. Bank
STA $ED					; Set
LDY $00					; Clear Index
RTS




Load_Yellow:
LDA #$23
STA $27
.Load
TDC
TAX
.loop
LDA $7E3059,X
STA $7E30A9,X
INX
CPX #$0008
BNE .loop
RTL 

Load_Yellow_Save:
LDA #$52
STA $26
BRA Load_Yellow_Load

WARNPC $E60000