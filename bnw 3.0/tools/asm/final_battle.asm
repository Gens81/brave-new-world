; #########################################################################
;
; Final Battle Hack made for Brave New World
; New graphics and Hack by Khaos (IAmUrza) and Ryo_Hazuki 2026-07-30 v.1.00
; Special thanks to everything8215
;
; Requirements:
;  	monster_and_bg_updates.ips for monster sprites and background changes, which overwrites existing Ifrit Summon graphics, among other things
; 	BNW ROM, unheadered (not compatible with Vanilla FF6 ROM)
;	Animation script changes for Ifrit are handled in the custom animations .asm
;   Monster names and Special names are handled as part of a different .asm
;
; #########################################################################

hirom

; There is a horizontal-only shaking function that is enabled after you beat each battle, as the screen scrolls up.
; This code skips all shaking, if horizontal-only shaking is enabled.
; This is because the shaking function does not always return the background to exact pixel-perfect starting position.
org $C10D18 : db $F0, $1A

; When HDMA effects like Noiseblaster move the background, they misalign it by 2 pixels to the left.
; This is because the precalculated "amplitude = '0'" sine wave function is -2, instead of 0.
; This fixes the issue by NOP'ing the DEC's.
org $C10DDA : db $EA, $EA

; *Always* branch over some "final battle" hard coded stuff.
; This allows monster sprites to show.
org $C11339 : db $80, $0B

; Update monster data to show names in battle and to allow the Sketch command.
org $CF2AF2 : db $00, $0C	; Limbo
org $CF2B12 : db $00, $0C	; Lust
org $CF2B32 : db $10, $0C	; Gluttony
org $CF2B52 : db $00, $4C	; Wrath
org $CF2B72 : db $00, $4C	; Greed
org $CF2B92 : db $01, $4C	; Heresy
org $CF2BB2 : db $10, $4C	; Violence
org $CF2BD2 : db $10, $4C	; Fraud
org $CF2BF2 : db $00, $4C	; Treachery

; Update monster data to have Sketches.
org $CF45AE : db $BC, $E3	; Limbo		- Magnitude		/ Shockwave
org $CF45B0 : db $BC, $6D	; Lust		- Magnitude		/ Avalanche
org $CF45B2 : db $EB, $DF	; Gluttony	- Lifeshaver	/ Meteo
org $CF45B4 : db $BA, $B3	; Wrath		- Snowball		/ Fireball
org $CF45B6 : db $B6, $B4	; Greed		- Volt Array	/ Atomic Ray
org $CF45B8 : db $0F, $0F	; Heresy	- Flare			/ Flare
org $CF45BA : db $EF, $EF	; Violence	- Special		/ Special
org $CF45BC : db $91, $6A	; Fraud		- Holy Wind		/ Moonlight
org $CF45BE : db $15, $15	; Treachery	- Merton		/ Merton

; Update battle data to set proper VRAM maps, allowing the new monster sprites to show properly
; Also sets proper X and Y positions of each monster sprite
org $CF7D99 : db $C0, $19, $57, $FF, $FF, $58, $59, $FF, $EA, $00, $00, $9D, $C2, $00, $3F	; Battle #471d (Limbo, Lust, Gluttony)
org $CF8000 : db $C0, $1B, $5D, $5A, $FF, $5B, $5C, $FF, $F6, $FC, $00, $E6, $65, $00, $3F	; Battle #512d (Wrath, Greed, Heresy, Violence)
org $CF800F : db $00, $0C, $FF, $FF, $5E, $5F, $FF, $FF, $00, $00, $75, $D8, $00, $00, $3F	; Battle #513d (Fraud, Treachery)

; Code from Ryo to prevent monster sprites on tiers from loading twice
org $C11014
	JSL Clear
	NOP #2

; Code below is by Ryo to help the transitions sequence, by changing parts of the background after the scrolling is complete

org $C19564
	JSL TransferDeadGFX

ORG $D247F0
ClearDeadFlag:
	STZ $0180		; Clear this byte to load dead graphic only one time
	TDC
	LDY #$0200
	RTL

RightGuy:
incbin "Tier2_RightGuy.bin"

Middle:
incbin "Tier2_Middle.bin"

LeftGuy:
incbin "Tier2_LeftGuy.bin"

Tiger:
incbin "Tier2_Tiger.bin"

Goddess:
incbin "Tier3_Goddess.bin"

God:
incbin "Tier3_God.bin"

Tier2PointerTable:
; RightGuy
	DW #RightGuy
	DW $1610					; VRAM address		
	DB $20						; Row lenght
	DB $03						; Row number
	DW $FFFF					; Padding
; Middle
	DW #Middle
	DW $1650   					; VRAM address	     		 	
	DB $40                      ; Row lenght
	DB $06	                    ; Row number
	DW $FFFF					; Padding
; LeftGuy
	DW #LeftGuy
	DW $16E0        			; VRAM address	
	DB $20                     	; Row lenght
	DB $02                     	; Row number
	DW $FFFF					; Padding
; Tiger
	DW #Tiger
	DW $1C10        		   	; VRAM address	
	DB $60                      ; Row lenght
	DB $04                      ; Row number
	DW $FFFF					; Padding

Tier3PointerTable:
; Goddess
	DW #Goddess
	DW $1590					; VRAM address		
	DB $20						; Row lenght
	DB $06						; Row number
	DW $FFFF					; Padding

; God
	DW #God
	DW $1870					; VRAM address		
	DB $20						; Row lenght
	DB $03						; Row number
	DW $FFFF					; Padding

TransferDeadGFX:
	JSL $C101FB					; From vanilla: wait 4 frames and load sprite
	LDA $2D6E					; Command event
	CMP #$12					; $12 - Scrolling BG?
	BNE .clear					; Branch if not
	LDA $0180					; Since we are in loop we won't load graphic every time so we check if we already loaded
	BNE .exit					; Branch if it's not $00 (already loaded)
	LDX $11E0					; Battle number
	CPX #$0200					; Is tier 2?
	BEQ .Tier2					; Branch if so
	CPX #$0201					; Is Tier 3?
	BNE .exit					; Branch if not
	JMP Tier3					; Execute Tier 3 load GFX
	BRA .exit					; May be not needed
.Tier2
	INC $0180					; Active flag
	PHB							; Push Data bank
	TDC							; Clear A
	PHA							; Push A onto stack
	PLB							; Pull A -> New databank
	LDA #$D2					; Gfx Bank
	STA $12						; Set
	TDC							; Clear A
	TAX							; Clear X
	LDA #$03					; Counter
	STA $A6						; Set Pointer Counter
	ASL                         ; *2
	ASL                         ; *4
	ASL                         ; *8
	TAX							; Index it
	LDA #$80					; Write mode
	STA $2115					; Set
	JSR Copy					; Jump and send to VRAM
	LDA #$81					; 
	STA $4200					; NMI enabled
	PLB
.exit
	RTL
.clear
	STZ $0180					; CLear BG flag, little bit expensive but necessary
	RTL

Copy:
	REP #$20					; 16-Bit A
	LDA.L Tier2PointerTable+4,X	; Size and rows
	STA $A7						; Set
	LDA.L Tier2PointerTable,X		; Gfx Lo-byte
	STA $10						; Set
	LDA.L Tier2PointerTable+2,X	; Vram Address
	STA $A9						; Save temporary
	STA $2116					; Set Vram Address
	SEP #$20					; 8-bit A
	LDY $00						; Clear Y, $00 is always 00

; Disable NMI, wait for Vblank make a DMA and restore NMI

	TDC
	STA $4200				; NMI disabled
.loop2
.WaitEndVBlank
	LDA $4212
	AND #$80
	BNE .WaitEndVBlank 		; Wait End Vblank	
.WaitStartVBlank
	LDA $4212
	AND #$80
	BEQ .WaitStartVBlank	; Wait next Vblank	

.loop
	LDA [$10],Y					; Load GFX
	STA $2118					; Save onto VRAM
	INY
	LDA [$10],Y					; Load GFX
	STA $2119
	INY							; Inc Index
	DEC	$A7						; Dec counter
	BNE .loop					; Branch if not finish
	
	LDA.L Tier2PointerTable+4,X	; Size and rows
	STA $A7						; Restore Counter
	DEC $A8						; Dec Enemy gfx counter
	BEQ .next					; Do next if 0
	JSR Plus100Routine			; Jump to next row if not
	BRA .loop2					; Do next transfer

.next
	DEC $A6						; Dec Enemy number counter
	BMI .finish					; Finish if 0
	TDC
	LDA $A6						; Load Enemy number
	ASL                         ; *2
	ASL                         ; *4
	ASL                         ; *8
	TAX							; Index it
	BRA Copy					; Copy next enemy
.finish
	RTS

Plus100Routine:
	REP #$20					; 16-bit A
	LDA $A9                     ; Load VRAM Address
	CLC                         ; Prepare ADC
	ADC #$0100                  ; Add $200
	STA $A9                     ; Update on $A9
	STA $2116       	        ; Set on VRAM
	SEP #$20                    ; 8-bit A
	TDC							; Clear A
	RTS   

Tier3:         
	INC $0180                   ; Active flag
	PHB                         ; Push Data bank
	TDC                         ; Clear A
	PHA                         ; Push A onto stack
	PLB                         ; Pull A -> New databank
	LDA #$D2					; Gfx Bank
	STA $12						; Set
	TDC							; Clear A
	TAX							; Clear X
	LDA #$01					; Counter
	STA $A6						; Set Pointer Counter
	ASL                         ; *2
	ASL                         ; *4
	ASL                         ; *8
	TAX							; Index it
	LDA #$80
	STA $2115
	JSR .Copy					; Jump and send to VRAM
	LDA #$81					; 
	STA $4200					; NMI enabled
	PLB		 
	RTL

.Copy
	REP #$20					; 16-Bit A
	LDA.L Tier3PointerTable+4,X	; Size and rows
	STA $A7						; Set
	LDA.L Tier3PointerTable,X		; Gfx Lo-byte
	STA $10						; Set
	LDA.L Tier3PointerTable+2,X	; Vram Address
	
	STA $A9						; Save temporary
	STA $2116					; Set Vram Address
	SEP #$20					; 8-bit A
	LDY $00						; Clear Y, $00 is always 00

; Disable NMI, wait for Vblank make a DMA and restore NMI

	TDC
	STA $4200				; NMI disabled
.loop2
.WaitEndVBlank
	LDA $4212
	AND #$80
	BNE .WaitEndVBlank 		; Wait End Vblank	
.WaitStartVBlank
	LDA $4212
	AND #$80
	BEQ .WaitStartVBlank	; Wait next Vblank	

.loop
	LDA [$10],Y					; Load GFX
	STA $2118					; Save onto VRAM
	INY
	LDA [$10],Y					; Load GFX
	STA $2119
	INY							; Inc Index
	DEC	$A7						; Dec counter
	BNE .loop					; Branch if not finish
	
	LDA.L Tier3PointerTable+4,X	; Size and rows
	STA $A7						; Restore Counter
	DEC $A8						; Dec Enemy gfx counter
	BEQ .next					; Do next if 0
	JSR Plus100Routine			; Jump to next row if not
	BRA .loop2					; Do next transfer

.next
	DEC $A6						; Dec Enemy number counter
	BMI .finish					; Finish if 0
	TDC
	LDA $A6						; Load Enemy number
	ASL                         ; *2
	ASL                         ; *4
	ASL                         ; *8
	TAX							; Index it
	BRA .Copy					; Copy next enemy
.finish
	RTS

; Below code from Ryo prevents garbage graphics from showing during battle transitions

Clear:
	PHP
	LDA $2D6E
	CMP #$12
	BNE NoBetween
	TDC
	BRA Skip
	NoBetween:
	LDA $61AA
	Skip:
	STA $201E
	PLP
	RTL

warnpc $D25FFF