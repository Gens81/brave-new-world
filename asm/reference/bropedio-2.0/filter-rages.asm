hirom
; header

; BNW - Disable Leap when all Rages are learned
; Bropedio (May 16, 2019)
;
; Also fixes a branching bug causing Leap and Dance
; to pass through the Lore handling to enable MP

!free = $C2652E    ; (29 bytes)

org $C25434
Brancher:

org $C2543C
DanceHandle:
    BRA Brancher   ; was incorrectly branching to add MP

org $C25443
LeapHandle:
    BRA Brancher   ; was incorrectly branching to add MP

; proper patch

org $C252BC
    LDX #$0009     ; add one more command to check (rage)
org $C252C8
    JSR ($52EC,X)  ; adjust pointer table location

org $C252EB
TableShift:
    db $11         ; add Leap command to require handling
    dw $5322
    dw Sketch      ; move Sketch handling for space
    dw $5322
    dw $531D
    dw $5314
    dw $5314
    dw $5314
    dw $5301
    dw $5301
    dw Leap        ; new pointer to Leap handling
    NOP            ; one empty byte

warnpc $C25302

org !free
Sketch:
    LDA $EF
    LSR
    RTS
Leap:
    PHY            ; store target index
    LDY #$0005     ; loop iterator
.loop      
    LDA $3F46,Y    ; Get monster number from formation data
    CMP #$FF       ; this also clears Carry for $5217 below
    BEQ .next      ; skip if $FF (empty monster)
    JSR $5217      ; X = monster # DIV 8, A = 2^(monster # MOD 8), C = 0
    AND $1D2C,X
    BEQ .done      ; return with Carry clear if at least one rage unlearned
.next
    DEY
    BPL .loop      ; check for all monsters
    SEC            ; if all rages learned, set carry (disable command)
.done
    PLY            ; restore Y
    RTS





