;This is a modified version of code created by DaMarsMan in 2006 for his Intro tutorial
;Clarifications and additions made by DackR in 2018
;Thanks to MrRichard for asking me to take a closer look
arch 65816
hirom

;***************************VARIABLE LOCATIONS**********************************
;these are LoROM addresses

;(original code) start of reset vector, often $00FF00 if it's HiROM, or commonly $008000 for LoROM
!OriginalCodeOffset = $C0002C
!NewCodeOffset = $F00000   ;the compiled code will take up less than 0x300 (768) bytes
!ReturnCodeOffset = $C00032

;change this to where the palette data should be stored (takes up about 0x200 bytes)
org $F00300
incbin gfx/intro/intro.col

;essentially the same as the above org, only the bank and the offset are separated
!ColBank = #$F0
!ColOffset = #$0300

;change this to the desired location of the tilemap (takes up about 0x800 bytes)
org $F00500
incbin gfx/intro/intro.map

;essentially the same as the above org, only the bank and the offset are separated
!MapBank = #$F0
!MapOffset = #$0500

;change this org to the offset of the raw image data (bitplane data)
org $F01000
incbin gfx/intro/intro.set

;essentially the same as the above org, only the bank and the offset are separated
!SetBank = #$F0 ;(the raw image data takes up two banks)
!SetBank2 = #$F0 ;usually 1 more than SetBank unless you manually split up the image :p
!SetOffset = #$1000
!SetOffset2 = #$9000

;***************************CHANGE ABOVE FIRST**********************************

;***********************OPTIONAL VARIABLE CHANGES*******************************
!FadeSpeed = #$6FFF ;Changing this directly effects the Fade Speed (Higher==Slower)
!IntroDelay = #$0013 ;make larger to increase pause, smaller for short pause
!MosaicEnable = #$00 ;#$01 is enabled, #$00 is disabled
;*********************END OPTIONAL VARIABLE CHANGES*****************************

;this is where we are hijacking the original initialization routine (about 4 bytes)
org !OriginalCodeOffset
JML !NewCodeOffset

;start initialization
org !NewCodeOffset
SEI
CLC
XCE
SEP #$30
PHB
LDA #$00
PHA
PLB
LDA #$80
STA $2100
LDA #$00
STA $2101
STA $2102
STA $2103
STA $2105
STA $2106
STA $2107
STA $2108
STA $2109
STA $210A
STA $210B
STA $210C
STA $210D
STA $210D
STA $210E
STA $210E
STA $210F
STA $210F
STA $2110
STA $2110
STA $2111
STA $2111
STA $2112
STA $2112
STA $2113
STA $2113
STA $2114
STA $2114

LDA #$80
STA $2115
LDA #$00
STA $2116
STA $2117
STA $211A
STA $211B
LDA #$01
STA $211B
LDA #$00
STA $211C
STA $211C
STA $211D
STA $211D
STA $211E
LDA #$01
STA $211E
LDA #$00
STA $211F
STA $211F
STA $2120
STA $2120
STA $2121
STA $2123
STA $2124
STA $2125
STA $2126
STA $2127
STA $2128
STA $2129
STA $212A
STA $212B
LDA #$01
STA $212C
LDA #$00
STA $212D
STA $212E
STA $212F
LDA #$30
STA $2130
LDA #$00
STA $2131
LDA #$E0
STA $2132
LDA #$00
STA $2133
LDA #$01	;auto read joypads
STA $4200
LDA #$FF
STA $4201
LDA #$00
STA $4202
STA $4203
STA $4204
STA $4205
STA $4206
STA $4207
STA $4208
STA $4209
STA $420A
STA $420B
STA $420C
STA $420D
REP #$30
SEP #$20
LDA #$03
STA $2105
LDA #$01
STA $212C
LDA #$00
STA $2107
LDA #$01
STA $210B
JSR Jump1

;DMA color stuff
LDX #$8000
STX $2116
LDX #$1801
STX $4300
LDX !MapOffset
STX $4302
LDA !MapBank
STA $4304
LDX #$0C00
STX $4305
LDA #$01
STA $420B
LDA #$00
STA $2121
LDX #$2200
STX $4300
LDX !ColOffset
STX $4302
LDA !ColBank
STA $4304
LDX #$0200	;512 colors
STX $4305
LDA #$01
STA $420B
JSR Jump1 ;await vblank


;DMA transfer data for "set"
;copy first half #$8000
LDX #$1000
STX $2116
LDX #$1801
STX $4300
LDX !SetOffset
STX $4302
LDA !SetBank
STA $4304
LDX #$8000
STX $4305
LDA #$01
STA $420B
JSR Jump1 ;await vblank

;DMA transfer data for second half of the image
;copy bottom half #$6000 in size
LDX !SetOffset2
STX $4302
LDA !SetBank2
STA $4304
LDX #$6000
STX $4305
LDA #$01
STA $420B
Jump9:
JSR mosaic
STA $2100 ;setting the screen brightness (fade in)
INC
JSR Jump2 ;fade delay

CMP #$10
BCC Jump9 ; keep fading in if A is less than 0x10

FadeRoutine:
CLI
LDX !IntroDelay ;make larger to increase pause, smaller for short pause

Jump3:
SEP #$20
LDY #$FFFF

Jump4:
DEY
BNE Jump4

Jump5:
LDA $4212
AND #$80
BEQ Jump5

Jump6:	
LDA $4212	;check vblank
AND #$01
BNE Jump6

REP #$20
LDA $4218
AND #$F0F0
BNE Jump7
DEX

;****************************OPTIONAL CODE CHANGE*******************************
;SHOULD WE STAY OR SHOULD WE GO NOW?
BNE Jump3 ;don't wait for keypress
;BRA Jump3 ;wait for keypress
;***************************END OF OPTIONAL CHANGE******************************

Jump7:
SEP #$20
LDA $4210
AND #$80
BEQ Jump7
LDA #$0F ;0F

Jump10:
JSR mosaic
STA $2100 ;fading out
DEC A
PHA
JSR Jump2 ;once again, using this routine for fade delay
;END OF FADE ROUTINE



PLA
CMP #$00
BNE Jump10


LDX #$0000

;THIS CONTAINS CODE FROM THE ORIGINAL RESET VECTOR
;****************************CHANGE THE CODE BELOW******************************
LDA #$01
db $8d,$0d,$42
;****************************CHANGE THE CODE ABOVE******************************
JML !ReturnCodeOffset


Jump1:
PHA
Jump11:
LDA $4210 ;checking the nmi flag
AND #$80 ;the flag is on the first bit (0x80 == 0b10000000)
BEQ Jump11
PLA
RTS


Jump2:
LDY !FadeSpeed ; each time the brightness is changed, we delay this amount
Jump8:
DEY
BNE Jump8 ; while y is not zero
RTS



vblank:
PHA
PHP
SEP #$20

Vloop:
LDA.l $4210
AND #$80
BEQ Vloop

PLP
PLA
RTS

mosaic:
PHA
ASL A
ASL A
ASL A
ASL A
EOR #$F0
ORA !MosaicEnable
STA $2106
PLA
RTS

