arch 65816
hirom

table "menu.tbl", ltr

; Insert Targe Power Hack
org $C3298E
LDA #$10        ; Description: On
         TRB $45         ; Set menu flag
         JSR $0EFD      ; Queue list upload
         JSR $4BD4      ; Handle D-Pad
         JSR Bpwrtrgt	; Insert Y func
         LDA $09         ; No-autofire keys
         BIT #$80        ; Pushing B?
         BEQ C329A4      ; Exit if not
         JSR $29A5      ; Leave submenu
C329A4:  RTS
warnpc $c329A5


;###################################################################
;
;	Insert number before Bushidos
;
;###################################################################

org $C35349
	LDA $7e9d89,x	; Load Tech
	CMP #$FF		; Tech in slot?
	JML C4F300		; Jump to new tech load routine
	JMP $7FD9		; Draw name
warnpc $C35356	

org $C4F300
C4F300:	BEQ C35357		; Go to blank if not
		LDA $7e9d89,x	; Load Tech
		CMP #$FF		; Tech in slot?
		BEQ C35357		; Go to blank if not
		PHA				; Save A
		CMP #$00		; Is first tech?
		BEQ first		; Branch if so
		ASL				; Double value it
first:	LDY #$0002		; Spaces: 2
		LDX #$9E8B		; $7E9E8B
		STX $2181		; Set WRAM LBs
		TAX				; Index A value
second:	LDA.l Number,X	; Load number
		STA $2180		; Add to string
		INX				; Point to next
		DEY				; One less left
		BNE second		; Loop till last
C3846E:	LDA $4212       ; PPU status
		AND #$40        ; H-Blank?
		BEQ C3846E      ; Loop if not
		PLA             ; Name number
		STA $211B       ; Set matrix A LB
		STZ $211B       ; Clear HB
		TDC             ; Clear A
		LDA $EB         ; String size
		STA $211C       ; Set matrix B
		STA $211C       ; ...
		LDY $2134       ; Index product
		LDX $EB         ; String size
C3848A:	LDA [$EF],Y     ; Letter
		STA $2180       ; Add to string
		INY             ; Point to next
		DEX             ; One less left
		BNE C3848A      ; Loop till last
		STZ $2180       ; End string
		JML $C35353
Number:	db "1."
		db "2."
		db "3."
		db "4."
		db "5."
		db "6."
		db "7."
		db "8."

C35357: JML $C35357		; Blank if not
		
warnpc $C4F460	
		
; -----------------------------------------------------------------------------
; Synopsis: Enables setting a max gauge speed for Cyan's Bushido ability.
;     Base: BNW 2.2b15
;   Author: Fëanor (optimized by Sir Newton Fig)
;  Created: 2023-05-12
;  Updated: 2023-06-06
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Explanation
; -----------------------------------------------------------------------------
; It's possible to replace the original subroutine with the modified one by
; reclaiming two bytes before and two bytes after it. This is how it looks
; before reclaiming:
;
; [ Battle Event Command $03-$06: Character Animation ]
;   ...
; C1FFE2:
;   RTS
;
; [ Battle Event Command $02: No Effect ]
; C1FFE3:
;   RTS            ; [reusable]
;   RTS            ; [unused]
;
; CheckSel:
;   JSL SwapGauge
;   JMP $0B73
;
; BushidoGauge:
;   INC $7B82
;   LDA $7B82
;   ADC $36
;   STA $7B82
;   RTS
;   NOP            ; [unused]
;   DB $FF         ; [unused]
;
; C1FFFA:
;   JSR $BAAA
;   JMP $914D
; -----------------------------------------------------------------------------

!max = #$07     ; $07 = max speed reached after unlocking sixth skill

; update jumps to displaced subroutines
org $C10CFA : JSR CheckSel
org $C17D8A : JSR BushidoGauge

; update Battle Event Command jump table (frees up 1 byte)
org $C1FDC2 : DW $FFE2

org $C3F444 : SwapGauge:

org $C1FFE3
CheckSel:
    JSL SwapGauge
    JMP $0B73

; modified Bushido gauge subroutine
BushidoGauge:
    LDA !max    ; load max speed
    CMP $36     ; compare to # of unlocked skills
    BCC .end    ; branch if greater or equal
    LDA $36     ; load # of unlocked skills
    INC         ; add 1
.end:
    ADC $7B82   ; add to gauge
    STA $7B82   ; store it
    RTS
warnpc $C1FFFA
