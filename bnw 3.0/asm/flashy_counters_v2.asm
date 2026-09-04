; -----------------------------------------------------------------------------
; Makes enemy counters distinguish themselves from regular attacks as follows:
; - enemy sprite flashes red
; - increased duration of flash animation
; - Original Hack by Feanor
; - v2 Modifications by Khaos (IAmUrza) to use a red gradient instead of a solid red colour
; -----------------------------------------------------------------------------
hirom

; documented FF3us freespace (before Pointers to SwdTech Descriptions)
!free_xx = $CFFFBE      ; 56 bytes required (Khaos Edit: Increased size from 52 to 56 bytes)
!warn_xx = !free_xx+66  ; 66 bytes available

!flash = #$0008         ; dark red color (Khaos Edit: Adjusted from $001F (red) to $0008 (dark red))

; hook into "set monster palette" routine to set the time between palette swaps 
; -----------------------------------------------------------------------------
; C1/9BA1:
;   STA $10
;   LDA $80DB,X
;   AND #$F1
;   ORA $10
;   STA $80DB,X
org $C19BAD
    JML FlashTime
    NOP
warnpc $C19BB2

; hook into "set flash color" routine
; -----------------------------------------------------------------------------
; C1/9BC5:
;   ...
;   CPX #$0020
;   BNE $9BC7
org $C19BD0
    JSL FlashColor
    RTS

; helper functions for setting palette index and time between palette swaps
; based on if it's a counter or not
org !free_xx
FlashTime:          ; 15 bytes
    LDA $B1         ; get attack flags
    LSR             ; shift counter bit into carry
    BCS .counter    ; skip if counter
    LDA #$04        ; default flash duration
    BRA .exit
.counter
    LDA #$08        ; counter flash duration
.exit
    JML $C19BB6     ; [displayed] wait n frames
FlashColor:         ; 41 bytes (Khaos Edit: Increased size from 37 to 41 bytes)
    LDA $B1         ; get attack flags
    LSR             ; shift counter bit into carry
    BCS .counter    ; skip if counter
    LDX #$FFFF      ; flash color (default)
    BRA .exit
.counter
    LDX #$0000
    REP #$20        ; 16-bit A
    TDC
    TAX
    LDA !flash      ; flash color (counter)
.loop
    STA $7F60,X
    INX
    INX
    CLC             ; (Khaos Edit: Clear carry added)
    ADC #$0002      ; (Khaos Edit: Adds $0002 to the colour, reddening it slightly more with each loop)
    CPX #$0020
    BNE .loop
    SEP #$20        ; 8-bit A
    RTL
.exit
    STX $7F62
    RTL
warnpc !warn_xx
