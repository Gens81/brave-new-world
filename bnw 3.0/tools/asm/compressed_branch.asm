hirom

ORG $CFBF70
; [ Init Hardware Registers (magitek march) ]

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

ORG $CFBFB0
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

; Restore original JML
org $c2680F
	JML $7E5000

; Data needed for Japanese title
;org $D0CF60
;D0CF60:
;	DB $08,$21,$63,$10,$63,$10,$63,$10,$00,$00,$8b,$51,$29,$45,$ea,$3c
;	DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;	DB $08,$21,$63,$10,$63,$10,$63,$10,$00,$00,$8b,$51,$29,$45,$ea,$3c
;	DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;	DB $00,$00,$c6,$1c,$a5,$1c,$85,$1c,$84,$18,$64,$14,$63,$10,$00,$00
;	DB $63,$10,$00,$00,$1e,$26,$9b,$15,$f1,$10,$5b,$56,$b4,$45,$2e,$35
;	DB $00,$00,$de,$66,$5b,$56,$b4,$45,$2e,$35,$08,$31,$e8,$2c,$c7,$28
;	DB $a6,$24,$a5,$1c,$84,$18,$64,$14,$63,$10,$bb,$21,$36,$11,$7f,$73
;	DB $00,$00,$de,$66,$5b,$56,$b4,$45,$2e,$35,$08,$31,$e8,$2c,$c7,$28
;	DB $a6,$24,$a5,$1c,$84,$18,$64,$14,$63,$10,$7f,$73,$7f,$73,$7f,$73
;
;warnpc $D0D000
;org $c2680F
;	JML $D4FFB0
;
;org $D4FFB0
;	LDX $00
;loop:
;	LDA.L D0CF60,X
;	STA $7E7B65,X
;	INX
;	CPX #$00A0
;	BNE loop
;	JML $7E5000