;For Brave New World

;concept: Nowea
;coding: Seibaby

;Original formula: (ATB multiplier) * 1.5 * (Speed + 20) / 16
;New formula: (ATB multiplier) * (Speed + 51) / 16

;xkas 0.06
hirom         ;don't change this
;header       ;uncomment if headered ROM

;table ff6_bank_c3.tbl,rtl

;ATB multipliers
!slow = 55
!normal = 70
!haste = 85
;Universal Speed bonus
!bonus = 51

!freespace = $C28A60
!freespaceC3 = $C3F694
org $C209D2
atb:
;Set ATB multipliers
PHP
LDY.b #!slow    ;ATB multiplier = 60 if slowed
LDA $3EF8,X
BIT #$04
BNE .skip       ;Branch if Slow
LDY.b #!normal  ;ATB multiplier = 75 normally
BIT #$08
BEQ .skip       ;Branch if not Haste
LDY.b #!haste   ;ATB multiplier = 90 if hasted
.skip
TYA 
STA $3ADD,X     ;save the ATB multiplier
PHA 

;Check if monster or character
CPX #$08
BCC .character

;For monsters: Multiply ATB multiplier by 3
JSR newfunc
CLC
ADC $01,S
STA $01,S
;For monsters: add 20 Speed 
LDA #$14
CLC
BRA .addSpeed

.character
LDA #!bonus     ;Universal Speed bonus

;Add 51 to Speed
.addSpeed
ADC $3B19,X     ;Speed
XBA             ;Speed + Bonus in top byte of Accumulator

;Multiply by Slow/Normal/Haste constant
PLA             ;bottom byte of A is now Slow/Normal/Haste Constant
JSR $4781       ;Let C be the Slow/Normal/Haste constant, equal to
                ; 60, 75, or 90, respectively.
                ; for characters and enemies:
                ; A = (Speed + 51) * C
REP #$20

;Divide by 16
LSR 
LSR 
LSR 
LSR             ;A = A / 16
;Result = (Speed + 51) * ATB multiplier / 16
STA $3AC8,X     ;Save as amount by which to increase ATB timer.
PLP 
RTS
print bytes

org !freespace
newfunc:
LDA $1D4E       ;Sound option
BIT #$20        ;Mono?
BNE .easymode   ;Branch if set to Stereo
LDA $01,S       ;ATB multiplier
ASL             ;Double it
RTS
.easymode
LDA $01,S       ;ATB multiplier
LSR             ;Halve it
RTS

;Remove stereo option
org $C3006C
NOP #3 ;JSR $3E3F      ; Adjust volume

org $C33E21
NOP #3 ;JSR $3E3F      ; Adjust volume

org $C33E31
NOP #3 ;JSR $3E3F      ; Adjust volume

org $C34940
dw $3C25 : db "Normal",$00

org $C34949
dw $3C35 : db "Hard",$00

org $C3499D
dw diff ; Difficulty ("Sound")

org !freespaceC3 
diff:
dw $3C0F : db "Difficulty",$00

