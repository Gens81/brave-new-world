arch 65816
hirom

table "menu.tbl", ltr ; Tabella per le stringhe di testo

org $C3F786
	jsr C350A2
	
;Restore original opcodes -> Now MP will be always showed up 
ORG $C34c80
		STZ $9E         ; No MP by Magic
		JSR $0F89      ; Stop VRAM DMA B

; Draw text in spell slot of Magic menu
ORG $C34FC4
C34FC4:	LDA $E6			; BG1 write row
		INC A			; Go 1 row down
		JSR $809F		; Compute map ptr
		REP #$20		; 16-bit A
		TXA				; ...
		STA $7E9E89		; Set position
		SEP #$20		; 8-bit A
		JSR $50EC		; Spell
		JSR $514D		; Handle graying
		JSR $50EC		; Spell
		CMP #$FF		; None?
		BEQ C3501A		; Blank if so
		JSR C350A2		; Spell mastery
		CMP #$FF		; Fully learned?
		BNE C3501A		; Blank if not

; Fork: Draw spell plus MP cost
C34FEB:	JSR $50EC			; Spell
		JSR $8467			; Load name
		LDX #$9E93			; 7E/9E92
		STX $2181 			; Set WRAM LBs
		JSR $50EC 			; Spell
		JSR $510D 			; Define MP cost
		JSR $04E0 			; Turn into text
		LDA #$D3   			; Tens digit	
		STA $2180  			; Add to string
		LDA #$FF   			; Free space	
		STA $2180  			; Add to string
		LDA $F8    			; Tens digit	
		STA $2180  			; Add to string
		LDA $F9				; Ones digit
		STA $2180  			; add to string
		LDA #$FF   			; space character
		STA $2180  			; add to string
		STZ $2180  			; end string
		JMP $7FD9  			; draw string

; Fork: Blank spell slot
C3501A: JMP CanLrn
		TDC             ; Clear A
        LDA $E5         ; Spell slot
        TAX             ; Index it
        LDA #$FF        ; Spell: None
        STA $7E9D89,X   ; Assign to slot
        JSR $51B9       ; Disable spell
        LDY #$000d		; Letters: 12
        LDX #$9E8B      ; 7E/9E8B
        STX $2181       ; Set WRAM LBs
        LDA #$FF        ; Space char
C35032: STA $2180       ; Add to string
        DEY             ; One less left
        BNE C35032      ; Loop till last
        STZ $2180       ; End string
        JMP $7FD9       ; Draw 11 spaces

		
; Fork: Draw spell plus percentage
 
C3503E: JSR $50EC			; Spell
        JSR $8467			; Load name
        LDX #$9E92			; 7E/9E92
        STX $2181 			; Set WRAM LBs
        JSR $50EC			; Spell
        JSR C350A2			; Spell mastery
        CMP #$FF  			; Fully learned?
        BEQ C34FEB			; Branch if so
        PHA       			; Save mastery
        LDA #$2C			; Palette 3
        STA $29				; Color: Bluish
		LDA #$FF			; Blankspace
		STA $2180 			; Add to string		 
        LDA #$D3  			; Char: "…"
        STA $2180 			; Add to string
        PLA       			; Spell mastery
        JSR $04E0			; Turn into text
		LDA #$FF			; Blankspace
		STA $2180 			; Add to string		 
        LDA $F8   			; Tens digit
        STA $2180 			; Add to string
        LDA $F9   			; Ones digit
        STA $2180			; Add to string
        LDA #$CD			; Char: "%"
        STA $2180 			; Add to string
C35082: STZ $2180 			; End string
        JMP $7FD9			; Draw string



; Get spell's mastery percentage
C350A2: STA $E0         ; Save spell
        JSR $4EDD       ; Define Y
        LDA $0000,Y     ; Actor
        CMP #$0C        ; Gogo?
        BEQ C350C5      ; Branch if so
C350AE: STA $4202       ; Set multiplicand
        LDA #$36        ; Spell list size
        STA $4203       ; Set multiplier
        TDC             ; Clear A
        LDA $E0         ; Spell
        REP #$20        ; 16-bit A
        ADC $4216       ; Add product
        TAX             ; Index sum
        SEP #$20        ; 8-bit A
        LDA $1A6E,X     ; Spell mastery
        RTS

warnpc $C350C5

org $c3f592
CanLrn:	JSR $50EC		; Spell
		CMP #$32		; Rerise?
		BEQ .rerise		; Branch if so
.Cannot	JMP C3501A+3	; Print blank if not

.rerise	PHY				; Save Y
		LDY $67			; Actor index in Y
		LDA $0000,Y		; Load Actor ID
		PLY				; Restore Y
		CMP	#$03		; Relm?
		BEQ .CanLrn		; Branch if so
		CMP #$08		; Shadow?
		BEQ .CanLrn		; Branch if so
		BRA .Cannot		; Print blank
.CanLrn	JMP C3503E		; Print spel plus percentage



ORG $C350C5
C350C5:					; Placeholder to avoid compiling issues

; Erase Fork: Handle Y, moving down 1A: Sustain Magic Menu
org $C327E2

PADBYTE $FF :	PAD $C327FE
warnpc $C327FE

org $C3020F
	dw C327E2
	
org $C327FE
; 1A: Sustain Magic menu
C327E2:  LDA #$10        ; Description: On
         TRB $45         ; Set menu flag
         LDA #$01        ; List type: Magic
         STA $2A         ; Set redraw mode
         JSR $0EFD      ; Queue list upload
         LDA $021E       ; Frame counter
         ROR A           ; Even value?
         BCC C327F8      ; Favor desc if so
         JSR $0F75      ; Queue cost upload
         BRA C327FB      ; Skip a line
C327F8:  JSR $A991      ; Queue desc upload
C327FB:  JSR $1F64      ; Handle L and R
         BCS C32861      ; Exit if pushed
         JSR $4B88      ; Handle D-Pad
         JSR $56E5      ; Load description

warnpc $C32822		 
org $C32861
C32861:


ORG $C350DB
	JSR C350AE
	
org $c3f7d1 
	jsr C350A2