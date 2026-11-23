hirom

ORG $D254CC
; [ Init Hardware Registers (magitek march) ]
; This code is needed for the opening magitek march scene
open_ppu_set:
PHB
LDA #$00
PHA
PLB
LDA #$03
STA $2101
LDX $00
STX $2102
LDA #$07
STA $2105
LDA #$78
STA $2107
LDA #$7C
STA $2108
LDA #$74
STA $2109
STA $210A
LDA #$22
STA $210B
LDA #$77
STA $210C
TDC
STA $211A
PLB
RTL

; This code is needed for the opening title sequence to work properly
ORG $D25502
title_work_init:
TDC
TAY
STY $25
STY $27
STY $29
STY $2B
STY $2D
STY $2F
STY $15
STY $04
STY $06
STY $08
STA $33
STA $18
STA $19
STA $1A
STA $17
STA $31
STA $32
STA $36
STY $12
STY $0E
LDA #$7E
STA $14
LDY #$FFFF
STY $10
RTL
