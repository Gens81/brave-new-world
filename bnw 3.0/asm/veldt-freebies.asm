; Add a new event command to automatically unlock all the WoB-exclusive formations on the Veldt
; (very hardcoded to formations as they appeared in BNW 2.1)
; Insert that event command into the end of the world event, so all missable WoB formations become unlocked
; in time for the WoR

; by seibaby
; 0.3 - at the behest of BTB, now also includes the non-missable FC formations
; 0.2 - actually works now
; 0.1 - I can't code


hirom
;header
!freespace_code = $C0DA56   ; Free space

org $C0992A
        dw	eventcommand    ; Event command $68 - unused

org !freespace_code
eventcommand:
        PHA                 ; Preserve A
        PHX                 ; Preserve X
        PHP                 ; Preserve CPU flags
        SEP #$30            ; Set 8-bit accumulator and index registers
        LDX #$11            ; Loop through 17 bytes
.loop   LDA $7E1DDC,X       ; Index of Veldt formations clear data in SRAM
        ORA formations-1,X    ; Combine with table data
        STA $7E1DDC,X
        DEX                 ; Next value
        BNE .loop           ; Loop 15 times
        PLP                 ; Restore CPU flags
        PLX                 ; Restore X
        PLA                 ; Restore A
        LDA #$01            ; Number of bytes until next event command in script = 1
        JMP $9B5C           ; Advance event queue

formations:
db $EE                      ; Formations 0-7
db $77                      ; Formations 8-15
db $A0                      ; Formations 16-23
db $48                      ; Formations 24-31
db $88                      ; Formations 32-39
db $A0                      ; Formations 40-47
db $54                      ; Formations 48-55
db $11                      ; Formations 56-63
db $00                      ; Formations 64-71
db $00                      ; Formations 72-79
db $19                      ; Formations 80-87
db $C8                      ; Formations 88-95
db $31                      ; Formations 96-103
db $50                      ; Formations 104-111
db $C9                      ; Formations 112-119
db $98                      ; Formations 120-127
db $11                      ; Formations 128-135

; Insert event command into apocalypse cutscene event script
org $CA51CD
db $95  ; Pause for 120 units (was originally B5 08    Pause for 15 * 8 (120) units - frees one byte)
db $68  ; Unlock Veldt formations
