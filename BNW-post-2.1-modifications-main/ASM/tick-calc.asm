hirom

; Rewrite of Periodic Effects/Damage Helper that prevents Poison and Phantasm
; from inflicting increased damage when paired with Regen.

org $C20AFF
Tick_Calc:
    PHA             ; store +A (Max HP)
    SEP #$20        ; 8-bit A
    LDA #$80        ; "Periodic" flag (new in BNW)
    TSB $11A7       ; update special byte 3
    LDA $11A4       ; attack flags 2
    LSR             ; shift "restore hp/mp" into carry
    BCC .no_restore ; branch otherwise
    LDA $E8         ; Stamina
    XBA             ; save multiplier
    LDA $3B18,Y     ; Level
    JSR $4781       ; Stamina * Level
    REP #$20        ; 16-bit A
    LSR #4          ; Stamina * Level / 16
    STA $E8         ; save total so far
    PLA             ; restore +A (Max HP)
    LSR #6          ; +A = Max HP / 64
    CLC : ADC $E8   ; +A = Max HP / 64 + Stamina * Level / 16
    BRA .end        ; branch to end
.no_restore
    LDA $E8         ; Stamina
    LSR #3          ; Stamina / 8
    CLC : ADC #$10  ; Stamina / 8 + 16
    TAX             ; set divisor ^
    REP #$20        ; 16-bit A
    PLA             ; restore +A (Max HP)
    JSR $4792       ; +A = Max HP / (Stamina / 8 + 16)
.end
    RTS
warnpc $C20B4A
