hirom
; header

; BNW - ATB Refactor (Pincer/Back attack refining)
; Bropedio (May 15, 2019)
;
; To make Pincer attacks move faster, and to avoid giving a stealth
; buff to slow characters, there should be two effects of Pincer/Back
; attacks on ATB:
;
; 1. Characters get reduced, but not zero, ATB
; 2. Enemies start with full ATB and get to act immediately
;
; This patch refactors the ATB Initialization code to achieve this
; while reducting code volume overall. The previous ATB changes in
; BNW added a subroutine at C2/FAA4; this JSR is no longer needed.

org $C225FA
NextLoop:                     ; this leaves ATB at 0 for immediate action

org $C225B2
TypeCheck:                    ; was 44 bytes - now 40
                LDX #$03      ; assume preemptive (=side type)
                LDA $B0
                ASL           ; this also clears Carry flag for later
                BMI .type     ; keep X==3 if preemptive
                LDX $201F     ; otherwise, load encounter type
.type
                DEX
                BMI .front    ; branch to front handling if type was 0
                DEX           ; prepare for last type check
                LDA $3018,Y
                BIT $3A40     ; acting as enemy?
                BNE .monster  ; branch if so
                CPY #$08
                BCS .monster  ; branch if is monster
.human
                DEX
                BEQ NextLoop  ; if type was 3, keep full ATB bar
                LDA $F2
                BRA .lessatb  ; pincer ATB = rand() + speed + genInc
.monster
                DEX
                BNE NextLoop  ; type was 1 or 2 (side/pincer), keep full ATB
                LDA #$01
                BRA .setatb   ; set top byte of ATB timer to 1
.front
                LDA $3B19,Y
                ADC #$1E
                JSR $4B65     ; random(0..30+speed)
                ADC $F2       ; no chance to overflow here
.lessatb
                ADC $3B19,Y
                BCS .overflow
                ADC $3B19,Y
                BCS .overflow
                ADC $F3       ; add general incrementor
                BCC .setatb
.overflow
                LDA #$FF      ; set to max ATB
.setatb
                ORA #$01      ; ensure not zero
                NOP

warnpc $C225F8

; The subroutine below is no longer needed (saves 16 bytes)

org $C2FAA4
padbyte $FF
pad $C2FAB4
