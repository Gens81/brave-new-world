hirom
; header

; Pincer Easy (update of pincer-atb patch)
; BNW - ATB Refactor (Pincer/Back attack refining)
; Bropedio (May 15, 2019)
;
; To make Pincer attacks move faster, and to avoid giving a stealth
; buff to slow characters, there should be two effects of Pincer/Back
; attacks on ATB:
;
; 1. Characters get reduced, but not zero, ATB
; 2. Enemies start with full ATB and get to act immediately
; 3. CHANGE: Pincer behaves like "Front"
;
; This patch refactors the ATB Initialization code to achieve this
; while reducting code volume overall. The previous ATB changes in
; BNW added a subroutine at C2/FAA4; this JSR is no longer needed.

org $C225FA
NextLoop:                     ; this leaves ATB at 0 for immediate action

org $C225B2
TypeCheck:                    ; was 44 bytes - now 40
                LDA $B0       ; attack flags
                ASL #2        ; carry: preemptive
                LDA #$03      ; assume preemptive (=side type)
                BCS .type     ; keep A==3 if preemptive
                LDA $201F     ; otherwise, load encounter type
.type
                LSR           ; carry: Back or Side attack
                BCC .front    ; normal ATB if Front or Pincer
                LSR           ; carry: Side attack (clear: Back)
                LDA $3018,Y   ; character bit
                BEQ .monster  ; branch if no character bit (is monster)
                BIT $3A40     ; character acting as enemy?
                BNE .monster  ; branch if so
.human
                BCS NextLoop  ; if side attack, characters get full ATB
                LDA $F2
                BRA .lessatb  ; back attack ATB = rand() + speed + genInc
.monster
                BCC NextLoop  ; if back attack, monsters get full ATB
                LDA #$01
                BRA .setatb   ; else, set top byte of ATB timer to 1 (no ATB)
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

warnpc $C225F8
padbyte $EA
pad $C225F7

; The subroutine below is no longer needed (saves 16 bytes)

;org $C2FAA4
;padbyte $FF
;pad $C2FAB4
