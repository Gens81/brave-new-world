hirom

; needs to be assembled after "bushido.asm"

; -----------------------------------------------------------------------------
; This hack allows cycling between three different info display modes during
; battle by pressing the Select button. These three modes are:
; - current HP/ATB Gauge
; - current HP/maximum HP
; - current MP/maximum MP
;
; For keeping track of the current mode the address $2021 is used which was
; previously dedicated to tracking the "ATB Gauge Setting". Its value
; corresponds to each mode as follows:
; - $00: curHP/Gauge (default)
; - $01: curHP/maxHP
; - $02: curMP/maxMP
; -----------------------------------------------------------------------------

; C1/DE66-C1/DEFD (152 bytes) is occupied by an unused routine according to
; everything8215's disassembly
!free = $C1DE66
!warn = !free+152

; replace hook to listen for "Select" button press
; TODO: clear old routines "CheckSel" and "SwapGauge"
org $C10CFA : JSR SelectHook

; update pointer of left segment (character info text $01)
; TODO: clear old routine (C1/6841)
org $C16819 : dw CharInfo_L

; update pointer of right segment (character info text $02)
; TODO: clear leftover parts from old routine (C1/6872)
org $C1681B : dw CharInfo_R

; reset $2021 during Battle RAM initialization
org $C22493 : NOP #2    ; clear BRA instruction skipping over reset

org !free
SelectHook:         ; 22 bytes
    LDA $09         ; no-autofire keys
    ASL #2          ; shift "Select" to $80
    BPL .end        ; branch if not pressed
    INC $2021       ; increment state
    LDA $2021
    CMP #$03        ; check if state >= 3
    BCC .end        ; branch otherwise
    STZ $2021       ; reset state
.end
    JMP $0B73       ; [displaced] update running/fade in/timers

CharInfo_L:         ; 16 bytes
    LDA $2021       ; current state
    CMP #$02        ; check if state >= 2
    BCC .cur_hp     ; branch otherwise
    LDA #$0B        ; $2EB9 (current mp)
    BRA .end
.cur_hp
    LDA #$07        ; $2EB5 (current hp)
.end
    JMP $6975       ; write 4 digit number text

CharInfo_R:         ; 32 bytes
    LDA $2021       ; current state
    BNE .no_atb     ; branch if z = 0
    JMP $6878       ; display ATB gauge
.no_atb
    LSR             ; shift LSb into carry
    PHP             ; store flags
    LDA #$C0        ; '/'
    JSR $66F3       ; write letter (menu text)
    PLP             ; restore flags
    BCS .max_hp     ; branch if c = 1
    LDA #$0D        ; $2EBB (max mp)
    BRA .end
.max_hp
    LDA #$09        ; $2EB7 (max hp)
.end
    JSR $6975       ; write 4 digit number text
    LDA #$FF        ; ' '
    JMP $66F3       ; write letter (menu text)

warnpc !warn
