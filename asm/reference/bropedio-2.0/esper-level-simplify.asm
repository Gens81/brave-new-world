hirom
; header

; BNW - Simplified Esper Levels
; Bropedio (April 26, 2019)
; Last modified: June 11, 2019
;
; This overhauls the handling of esper boosts to enable faster changes:
; * Use a table of data rather than pointers to subroutines
; * Encode each bonus into a single byte (bits: 76543210)
;   * Bit 0 indicates stat versus HP/MP
;   * If stat, bits 2 and 1 provide stat index (7-3 are zero)
;   * If stat, assume change of 1 (could support more w/ unused bits)
;   * If HP/MP, bit 1 indicates MP (over HP)
;   * If HP/MP, bits 7-2 indicate amount to change (max 63)
; 
; NOTE: This patch does not handle esper level text display, though I
; imagine it could be rewritten to programmatically determine the EL
; description based on the table below.

org $C2612C
ELJump:
    REP #$20         ; 16-bit A
    JMP AddEL        ; handle esper levelups
    NOP #2

org $C2614E
ELTable:
    db $78,$78 ; 60HP - Terrato, Crusader
    db $52,$52 ; 40HP - Bahamut, Ragnarok
    db $78,$3E ; 30HP/15MP -  Phoenix, Seraph
    db $01,$50 ; 20HP/Vig - Golem
    db $52,$07 ; 20MP/Mag - Zoneseek
    db $01,$03 ; Vig/Spd - Palidor
    db $03,$07 ; Mag/Spd - Siren
    db $01,$05 ; Vig/Stm - Phantom
    db $05,$07 ; Mag/Stm - Maduin
    db $03,$05 ; Spd/Stm - Alexander
    db $78,$05 ; 30HP/Stm - Kirin, Unicorn
    db $05,$66 ; 25MP/Stm - Carbunkl
    db $01,$01 ; 2Vig - Ramuh, Bismark
    db $03,$03 ; 2Spd - Ifrit, Fenrir
    db $05,$05 ; 2Stm - Stray, Odin, Tritoch, Starlet
    db $07,$07 ; 2Mag - Shiva, Shoat
    db $00,$00 ; null - Raiden?

AddEL:
    LDA ELTable,X   ; A = full 2-byte boost
    SEP #$20        ; 8-bit A
.doone
    TYX             ; X = index to character stats
    XBA             ; swap A bytes
    BNE .bonus      ; if bonus, branch and handle (long-loop)
    RTL             ; return
.bonus
    LSR
    BCC .hpmp       ; if bit $01 not set, use HP/MP
.loop
    BEQ .stat       ; if no stat index, continue
    INX
    DEC
    BRA .loop       ; add X to A
.stat
    LDA $161A,X     ; A = stat
    CMP #$80
    BEQ .fin        ; if maxed already, skip increment
    INC
    STA $161A,X     ; store updated stat
.fin
    BRA .next       ; finish this bonus byte
.hpmp
    LSR             ; remainder is amount to add
    BCC .addhp      ; if MP bit not set, skip INX
    INX
    INX
    INX
    INX             ; X points to max MP now
    CLC
.addhp
    ADC $160B,X
    STA $160B,X     ; add HP/MP bonus
    BCC .next       ; if no overflow, continue
    INC $160C,X     ; carry to hi byte
.next
    LDA #$00        ; clear finished bonus
    BRA .doone      ; loop for second bonus byte

padbyte $FF
pad $C261E9
