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
