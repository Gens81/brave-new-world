arch 65816
hirom


ORG $C3992E
	JSR C3A1D8

ORG $C3970A
	JSR C3A150
ORG $C39768
	JSR C3A150
ORG $C3989E
	JSR C3A150
ORG $C39E81
	JSR C3A150



; Freeing up some space in Equip/Relic Area and gaining space for rages hack
org $C3A226
; Sort compatible gear by power after loading power ratings
C3A150: LDX #$AC8D      ; 7E/AC8D
        STX $2181       ; Set WRAM LBs
        LDA $7E9D89     ; List size
        BEQ C3A181      ; Exit if 0
        CMP #$01        ; One item?
        BEQ C3A181      ; Exit if so
        STA $E7         ; Memorize it
        STZ $E8         ; Clear HB
        TDC             ; Clear A
        TAX             ; Gear slot: 1
        TAY             ; ...
C3A167: LDA $7E9D8A,X   ; Inventory slot
        PHX             ; Save gear slot
        TAY             ; Index former
        LDA $1869,Y     ; Item in slot
        TAX
		LDA $CEFEE7,X
        STA $2180       ; Add to list
        PLX             ; Gear slot
        INX             ; Gear slot +1
        CPX $E7         ; End of list?
		BNE C3A167      ; Loop if not
        JSR C3A187      ; Sort list
C3A181: RTS

; Sort list of compatible gear by power
C3A187: DEC $E7         ; List size -1
        PHB             ; Save DB
        LDA #$7E        ; Bank: 7E
        PHA             ; Put on stack
        PLB             ; Set DB to 7E
        TDC             ; Clear A
        TAY             ; Items done: 0
C3A190: TDC             ; Clear A
        TAX             ; List slot: 1
C3A192: LDA $AC8D,X     ; Item's power
        CMP $AC8E,X     ; Next is worse?
        BCC C3A1B7      ; Skip if not
        STA $E0         ; Memorize it
        LDA $9D8A,X     ; Item number A
        STA $E1         ; Memorize it
        LDA $AC8E,X     ; Item power B
        STA $AC8D,X     ; Replace A's
        LDA $9D8B,X     ; Item number B
        STA $9D8A,X     ; Replace A's
        LDA $E0         ; Item power A
        STA $AC8E,X     ; Replace B's
        LDA $E1         ; Item number A
        STA $9D8B,X     ; Replace B's
C3A1B7: INX             ; List slot +1
        CPX $E7         ; End of list?
        BNE C3A192      ; Loop if not
        INY             ; Items done +1
        CPY $E7         ; Fully sorted?
        BNE C3A190      ; Loop if not
        PLB             ; Restore DB
        RTS

C3A1D8:	JSR $82FE      ; Set desc ptrs
		TDC             ; Clear A
		LDA $4B         ; Gear list slot
		TAX             ; Index it
		LDA $7E9D8A,X   ; Inventory slot
		TAX             ; Index it
		LDA $1869,X     ; Item in slot
		JMP $5738      ; Load description


warnpc $C3a2a6