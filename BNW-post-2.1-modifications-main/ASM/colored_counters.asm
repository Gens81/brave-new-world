; -----------------------------------------------------------------------------
; Synopsis: Highlights enemy counterattacks using a custom text color.
;     Base: BNW 2.2b15
;   Author: Fëanor
;  Created: 2023-05-27
;  Updated: 2023-06-01
;  Updated: 2023-11-01 by Bropedio
;     * Switch from $CF to $B1:$08 for flag
;     * Enemies flash differently when countering
; -----------------------------------------------------------------------------
hirom

!free_a = $C13E03      ; 17 bytes of free space required
!warn_a = !free_a+28   ; 28 bytes available

!free_b = $C2FBB9      ; 11 bytes of free space required
!warn_b = !free_b+13   ; 13 bytes available

!textcolor = #$03BF    ; custom text color = yellow

; -----------------------------------------------------------------------------
; Routine: Enemy executes attack animation
;
; First, rearrange code to save 6 bytes freespace
; Then, add handling to skip second flash for counterattacks
; -----------------------------------------------------------------------------
; C1/9B25:
;   ...
;   LDA $80DB,X        ; A = monster sprite data?
;   STA $7AF0          ; save it
org $C19B8A
    JSR FlashOnce      ; flash once
    LDA $B1            ; attack flags
    BIT #$08           ; 'counterattack'
    BEQ FlashOnce      ; branch if not ^
    RTS                ; else, return after only one flash
FlashOnce:
    LDA #$06           ; flash B&W palette index x2
    JSR $9BA1          ; set monster palette index ^
    LDA $7AF0          ; default palette index
    JMP $9BA1          ; set monster palette index ^
warnpc $C19BA0+1

org $C19BAD : LDA #$06 ; longer flash duration (was $04)
; -----------------------------------------------------------------------------
; Routine: Draw Dialogue Text
; -----------------------------------------------------------------------------
; C1/5DD5:
;   ...
;   STZ $E9F5
;   STZ $7A
org $C15DDA
    JSR SpliceDrawText ; get $4B flag (use custom color or not)
    STA $4B            ; save ^
    LDA $88D9          ; battle message script bank
    STA $4A            ; save ^
    STX $48            ; save battle message script address
;   LDA [$48]
;   BEQ $5DFE
;   ...
; -----------------------------------------------------------------------------
; Routine: Setting Default Window Colors
; -----------------------------------------------------------------------------
; C1/99AC:
;   LDX #$0000
;   STX $7E22
org $C199B2
    LDX !textcolor    ; set custom text color
;   STX $7E24
;   LDX $1D55
;   ...
; -----------------------------------------------------------------------------
; Routine: Counterattack Turn
; -----------------------------------------------------------------------------
; C2/4B7B
;    ...
org $C24B7F
     LDA #$09       ; 'Unconventional' and 'Counterattack' flags
     TSB $B1        ; set both ^ [unchanged]
     PEA CounterDone-1
 
org $C24BCE : JSR AllyCounter
; -----------------------------------------------------------------------------
;
; enable custom text color usage for counterattacks only (requires excluding
; any textboxes that are loaded without screen designation $12. This screen
; designation is only active for drawing textbox tiles via battle dynamics
; command $01 and $11, which are command messages and special attack names.
; I'm unsure why battle quips, preemptive, gained GP, etc revert the screen
; designation back to $17 prior to writing the text tiles, but they do.

org !free_a
SpliceDrawText:
    LDX $88D7       ; [displaced] battle message script address
    LDA $898D       ; current screen designation
    CMP #$12        ; "drawing textbox" (used for attack names)
    BNE .nope       ; branch if not ^
    LDA $B1         ; check attack flags
    AND #$08        ; isolate "Counterattack" flag
    RTS
.nope
    TDC             ; else, use zero
    RTS
warnpc !warn_a

; unset new "counterattack" flag after counterattack finishes
org !free_b
CounterDone:
    PEA $0018       ; [displaced] (return to battle loop at RTS)
AllyCounter:
    LDA #$08        ; 'counterattack' flag
    TRB $B1         ; unset ^
    LDA $3AA0,X     ; [displaced] (only needed for AllyCounter)
    RTS
warnpc !warn_b