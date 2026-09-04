; -----------------------------------------------------------------------------
; Synopsis: Displays rages that are unlocked but not yet learned in grey in the
;           rage menu.
;     Base: BNW 2.2b17.1
;   Author: Novalia Spirit
;   Porter: Fëanor
;  Created: 2023-06-24
; -----------------------------------------------------------------------------
hirom

!free = $C4FF72     ;  92 bytes of free space required
!warn = !free+142   ; 142 bytes available

!encs = $7EAA8D     ; used to store list of enemies roaming the Veldt

; -----------------------------------------------------------------------------
; [C321A6] Skills Menu $05: Rage (init)
;   ...
;   LDA #$02
;   STA $5B
;   LDY #$0100
org $C321D2
    JSL VeldtEncounters ; builds a list of enemies roaming the Veldt
;   JSR $5391
;   LDA #$1D
;   STA $26
;   RTS

; -----------------------------------------------------------------------------
; Rewrite of Subroutine that Draws Rage Name in Skills Menu $05
;
; Now takes into account if an unlearned rage is unlocked or not.

org $C4A7E0 : Rages:  ; hard-coded list of rage IDs in alphabeticl order

org $C35418
DrawRageName:
    LDA $E6         ; current row
    INC             ; one row below
    JSR $809F       ; X: tile position
    REP #$20        ; 16-bit A
    TXA             ; tile position in A
    STA $7E9E89     ; save to buffer
    SEP #$20        ; 8-bit A
    TDC             ; zero A/B
    LDA $E5         ; rage slot index
    TAX             ; index it
    LDA #$20        ; default palette
    STA $29         ; set default text color
    LDA $7E9D89,X   ; rage ID in this slot
    CPX $FE			; beyond available rages?
	BCS .branch_done; branch if so
	BRA .draw		; branch if available
.branch_done
	TAX				; index it
    PHA             ; push it on stack
    LDA #$28        ; palette 2
    STA $29         ; set text color: gray
    PLA             ; pull rage ID from stack
	CMP #$FF		; unavailable rage?
	BEQ .blank		; Blank if so
.draw
    JSR $8467       ; load enemy name
    JMP $7FD9       ; draw enemy name
.blank
    JMP $555D       ; draw blank name
                    ; ^ reuses esper menu code to save space
padbyte $FF
pad $C35452
warnpc $C35452

; -----------------------------------------------------------------------------
; Helper for Building a List of Enemies Roaming the Veldt
;
; This code is largely taken from Novalia Spirit's original hack as is but
; contains two changes:
; - uses $00 instead of $FF to denote non-encountered enemies
; - removes special case handling of Pugs

org !free
VeldtEncounters:    ; [92 bytes]
    STY $39         ; [displaced]
    STY $3D         ; [displaced]
    LDX #$00FF      ; Slot: Last
    LDA #$00
.loop1
    STA !encs,X     ; clear slot (set to $00)
    DEX             ; List slot -1
    BPL .loop1      ; Loop till < 0

; Fork: Build list of encountered enemies
    INX             ; 8-pack index: 0
    STX $E0         ; Group index: 0

; Fork: Mark enemies met from 8 groups
.loop2
    LDY #$0008      ; Groups left: 8
    LDA $1DDD,X     ; 8 met-group flags
    JSR mark6x8     ; Mark enemies met

; Fork: Handle next 8-group pack
    BNE .loop2      ; If not last pack
    RTL

; mark Rage-compatible enemies in 8 groups as met
mark6x8:
    PHX             ; Save pack index
.loop1
    LSR A           ; Met current group?
    PHY             ; Save group counter
    PHA             ; Save group flags
    BCC .next       ; Skip if not
    TDC             ; Clear A
    LDX $E0         ; Group data index
    LDY #$0006      ; Enemies: 6
    JSR mark6x1     ; Mark enemies met

; Fork: Handle next group from 8-pack
.next
    LDA #$0F        ; Loop counter
    LDY $E0         ; Group data index
.loop2
    INY             ; Index +1
    DEC A           ; Counter -1
    BNE .loop2      ; Loop till 0
    STY $E0         ; Save updated index
    PLA             ; 8 met-group flags
    PLY             ; Groups remaining
    DEY             ; One less group
    BNE .loop1      ; Loop till 8th
    PLX             ; Pack index
    INX             ; Pack index +1
    CPX #$0040      ; Done all 64?
    RTS

; Mark Rage-compatible enemies in group as met
mark6x1:
    LDA $CF620E,X   ; 6 enemy num MSB
.loop
    LSR A           ; Enemy num > 255?
    BCS .next       ; Skip enemy if so
    PHX             ; Save enemy slot
    PHA             ; Save nums MSBs
    LDA $CF6202,X   ; Enemy number
    TAX             ; Index it
.store
    STA !encs,X     ; Mark enemy as met
    PLA             ; 6 enemy num MSB
    PLX             ; Enemy slot
.next
    INX             ; Enemy slot +1
    DEY             ; One less enemy
    BNE .loop       ; Loop till 6th
.exit
    RTS
warnpc !warn
