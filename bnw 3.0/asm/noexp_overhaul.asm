; -----------------------------------------------------------------------------
; Synopsis: Being on the Veldt and/or turning off experience gain yields
;           regular SP but no XP/EP and double GP. Also disables reward
;           messages for XP/EP if none are gained.
;     Base: BNW 2.2b15
;   Author: Fëanor
;  Created: 2023-06-04
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Explanation
; -----------------------------------------------------------------------------
; This hack is mostly a rehash of the normal victory routine with some parts
; added or removed. The most significant changes are made to the loop that
; tallies up earned XP/GP. In addition to checking if the party's on the Veldt
; there is now also a check for the config option "Exp. Gain". To prevent
; having to do both checks for a second time we temporarily store their results
; in a custom flag $F4. This is flag is later on used to check if the GP reward
; should be doubled.
; -----------------------------------------------------------------------------
hirom

; update jumps to displaced subroutines
org $C233BA : JSR SetTarget
org $C23440 : JSR ParryCounter

!XP_flag = $F4      ; custom flag to track if XP/EP is gained

; -----------------------------------------------------------------------------
; tallies up earned XP/GP and stores it
; -----------------------------------------------------------------------------
org $C25DAB
    STZ !XP_flag    ; clear custom flag
    REP #$20        ; set 16-bit A
    LDX #$000A      ; set initial X = $0A for iteration (last enemy)
  - LDA $3EEC,X     ; check enemy's 1st status byte
    BIT #$00C2      ; check if petrify, death, or zombie
    BEQ ++          ; if not, skip this enemy
    LDA $11E4
    BIT #$0002      ; check if party's on the Veldt
    BNE +           ; branch if true to skip tallying XP
    LDA $1D4D       ; get config option byte
    BIT #$0008      ; check "XP gain" flag
    BEQ +           ; branch if XP gain is off
    INC !XP_flag    ; set custom flag
    CLC             ; clear carry flag
    LDA $3D8C,X     ; get enemy XP
    ADC $2F35       ; add to XP tally
    STA $2F35       ; store it in variable 0  (bottom 2 bytes)
    BCC +           ; branch if carry flag is clear
    INC $2F37       ; set top byte of variable 0
  + CLC             ; clear carry flag
    LDA $3DA0,X     ; get enemy GP
    ADC $2F3E       ; add to GP tally
    STA $2F3E       ; store it in variable 3 (bottom 2 bytes)
    BCC ++          ; branch if carry flag is clear
    INC $2F40       ; set top byte of variable 3
 ++ DEX             ; decrement X twice to get next enemy
    DEX
    BPL -           ; continue iteration until X < 0
; -----------------------------------------------------------------------------
; calculates XP earned per character and stores it [unchanged]
; -----------------------------------------------------------------------------
    LDA $2F35       ; get bottom 2 bytes of total XP
    STA $E8         ; store it
    LDA $2F36       ; get top 2 bytes of total XP
    LDX $3A76       ; get number of active and alive characters in party
    PHX
    JSR $4792       ; divide +A / X
    STA $EC         ; +$EC = experience per character
    STX $E9         ;  $E9 = remainder
    LDA $E8
    PLX
    JSR $4792       ; divide +A / X
    STA $2F35
    LDA $EC
    STA $2F36       ; store in variable 0 (top 2 bytes)
    ORA $2F35
    BEQ +           ; branch if XP per character is zero
    LDA #$0027      ; setup battle message $27 "Got <V0> Exp. point(s)"
    JSR $A712       ; jump to subroutine Show_XP
  + SEP #$20        ; set 8-bit A
; -----------------------------------------------------------------------------
; doubles GP reward if no experience is gained
; -----------------------------------------------------------------------------
    LDA !XP_flag    ; load custom enableXP flag
    BNE +           ; branch if XP gain is on
    ASL $2F3E       ; else, double GP reward
    ROL $2F3F
    ROL $2F40
; -----------------------------------------------------------------------------
; handles XP/EP gained in battle and spells taught by equipment [unchanged]
; -----------------------------------------------------------------------------
  + LDY #$0006      ; set initial Y = $06 for iteration
  - LDA $3018,Y     ; get character mask
    BIT $3A74       ; bitmask of characters/enemies that are alive
    BEQ ++          ; skip if character is dead or absent
    BRA skipCave    ; always branch
; -----------------------------------------------------------------------------
; two inserted subroutines that are completely unrelated [unchanged]
; -----------------------------------------------------------------------------
SetTarget:
    STY $C0         ; save target index in scratch RAM
    JSR $220D       ; [displaced] miss determination
    RTS
ParryCounter:
    LDY $C0         ; get target index
    LDA $3018,Y     ; target bitmask
    BIT $3A5A       ; "Miss" tile flag set
    BEQ +           ; branch if not ^
    JSR $35E3       ; else, initialize counter variables
  + RTS
; -----------------------------------------------------------------------------
; continued from above [unchanged]
; -----------------------------------------------------------------------------
skipCave:
    LDX $3010,Y     ; get offset to character slot data
    JSR $6235       ; add XP/EP/SP for battle
    LDA $3ED8,Y     ; get actor index
    CMP #$0C
    BCS ++          ; branch if Gogo or Umaro
    JSR $6283       ; stores address for spells known by character in $F4
    LDX $3010,Y     ; get offset to character slot data
    PHY             ; preserve Y
    JSR $5FEF       ; update spells taught by equipment
    BRA + 
    NOP #15         ; [unused]
  + PLY             ; restore Y
 ++ DEY             ; decrement Y twice to get next character slot
    DEY
    BPL -           ; continue iteration until Y < 0
warnpc $C25E77
