; -----------------------------------------------------------------------------
; Synopsis: Highlights current native dance in battle menu
;     Base: BNW 2.2b17.1
;   Author: Fëanor
;  Created: 2023-06-27
; -----------------------------------------------------------------------------
hirom

!free = $C4BFB9     ; 44 bytes required
!warn = !free+79    ; 79 bytes available

!color = #$08       ; yellow text color

; -----------------------------------------------------------------------------
; Draw One Row of Dance Menu Text [C14D08]
; -----------------------------------------------------------------------------
;   ...
;   CPX #$000D
;   BNE $4D0D
org $C14D1A
    JSL DrawDanceSplice
    NOP #8
;   JSR $4E07
;   JSR $63AB
;   PLY
;   RTS
; -----------------------------------------------------------------------------

; set custom text color for menu entry matching current native dance
org !free
DrawDanceSplice:    ; [44 bytes]
    LDX $11E2       ; get battle background index
; left column
    LDA $267E,Y     ; get dance index
    STA $575A
    CMP $ED8E5B,X   ; compare to native dance index
    BNE +           ; branch if no match
    LDA !color
    ORA $5758
    STA $5758       ; set custom text color
; right column
  + LDA $267F,Y     ; get dance index
    STA $5760
    CMP $ED8E5B,X   ; compare to native dance index
    BNE +           ; branch if no match
    LDA !color
    ORA $575E
    STA $575E       ; set custom text color
  + RTL
warnpc !warn
