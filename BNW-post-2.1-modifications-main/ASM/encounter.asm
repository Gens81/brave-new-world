;|----------------------------------------------|
;| Random Encounter Menu Option (on/off)        |
;| by: madsiur                                  |
;| version: 1.1a                                |
;| Released on: January 30th, 2022              |            
;|----------------------------------------------|

!FreeSpaceC0 = $C0DA84  ; Bank $C0 free space offset

;------------------------------------------------
;| World map encounter function                 |
;------------------------------------------------
org $C0C1FE
LDA $1D4E           ; Load settings byte
BIT #$20
BNE lbl_C278        ; Exit if encounters are off
JSR function        ; Otherwise proceed as usual
nop

org $C0C278
lbl_C278:           ; Function exit is here

;------------------------------------------------
;| Dungeon encounter function                   |
;------------------------------------------------
org $C0C397
LDA $1D4E           ; Load settings byte
BIT #$20
BEQ lbl_C39D        ; Branch if encounters are on
RTS                 ; Otherwise exit
lbl_C39D:
JSR function        ; if encounters are on, proceed as usual

;------------------------------------------------
;| Free space                                   |
;------------------------------------------------
org !FreeSpaceC0    ; You can change this free space offset as long as it is in bank $C0
function:           ; Original code
LDA $11DF           ; Load party-wide effects
AND #$03            
ASL A
ASL A               ; Multiply by 4
ORA $1A
ASL A
TAX
RTS

;------------------------------------------------
;| Bank $C3 code                                |
;------------------------------------------------
org $C30063
	bra stereo		; no check for mono or stereo (always stereo)

org $C3006F
stereo:

org $C33E1A
	lda $0B
	bit #$01
	bne push_right
	lda #$20
	trb $1D4E
redraw:
	jsr $0EA3
	jmp $3C85

push_right:
	lda #$20
	tsb $1D4E
	bra redraw
	
;org $C3499D
;dw EncString ; Encounters ("Sound")
;
;org $C34940
;dw $3C25 : db "On",$00
;	
;org $C34949
;dw $3C35 : db "Off",$00
;
;org $C3FC88
;EncString:
;dw $3C0F : db "Encounters",$00
