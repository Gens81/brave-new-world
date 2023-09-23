hirom
; header

; Bropedio
; Halve Battle Power

!freeC0 = $C0DA20
!warnC0 = $C0DB01

!baseb = $11CC ; apparently unused (in equip check func)
!basec = $11CD ; needed for zero 16-bit read

; ##################################
; Add base battle power when loading in physical formula

org $C2646A : JSL GetPwrFork
org $C26481 : JSL GetBushPwr

; ##################################
; Initialize battle power without base
; Save base battle power in new variable

org $C20EA6 : STA !baseb : NOP #3 ; save base battle power
org $C210E3 : BNE $01 : INC : STA $11AC,Y : NOP #4 ; overwrite battle power

; ##################################
; Helper Funcs

org !freeC0
GetBushPwr:
  REP #$20        ; 16-bit A [moved]
  PHA             ; save power so far
  SEP #$20        ; 8-bit A
  LDA $3C58,X     ; weapon effects
  BIT #$10        ; dual wielding
  JSR GetBatPwr   ; get base battle power (preserves Z flag)
  REP #$20        ; 16-bit A
  BEQ .norm       ; branch if not dual wielding
  ASL             ; else, double base battle power
.norm
  CLC : ADC $01,S ; add to power-so-far
  STA $01,S : PLA ; clean up stack
  LSR #2          ; [moved]
  RTL

GetPwrFork:
  SEP #$20        ; [moved]
  LDA $B5         ; command ID
  CMP #$16        ; is command "Jump"
  BEQ .get_pwr    ; branch if ^
  LDA $3413       ; backup command (fight/mug)
  BMI .exit       ; exit if not fight/mug or battle
.get_pwr
  JSR GetBatPwr   ; get base battle power
  REP #$21        ; 16-bit A
  ADC $04,S       ; add to stored power on stack
  STA $04,S       ; overwrite with full power
  SEP #$20        ; 8-bit A
.exit
  LDA $B5         ; [moved]
  RTL
org !warnC0

GetBatPwr:
  PHP             ; store flags (including Z)
  LDA $3ED8,X     ; character X's ID
  STA $004202     ; prep multiplication
  LDA #$16        ; size of character startup block
  STA $004203     ; start mutliplication
  NOP #3          ; wait for processor
  REP #$30        ; 16-bit X/Y,A
  LDA $004216     ; get product
  PHX             ; save character index 
  TAX             ; index to character data
  TDC             ; zero A/B
  SEP #$20        ; 8-bit A
  LDA $ED7CAA,X   ; character battle power
  PLX             ; restore character index
  PLP             ; restore flags (including Z)
  RTS

; ################################################
; Genji Glove Battle Power modifier UI

org $C393B5
EndBatPwrHelp:
  PHP             ; save carry
  CLC             ; clear carry
  ADC !baseb      ; add base battle power
  PLP             ; restore carry
  BCC .genji      ; branch if not gauntlet
  PHA
  LSR
  CLC
  ADC $01,S
  STA $01,S
  PLA
.exit
  PLB             ; restore bank
  RTS
.genji
  SEP #$10        ; 8-bit X/Y
  INX : DEX       ; set flags for genji
  REP #$10        ; 16-bit X/Y
  BEQ .exit       ; exit if no genji
  CLC             ; prep add
  ADC !baseb      ; add another base battle power
  PHA             ; store power on stack
  LSR #2          ; power / 4
  STA $E0         ; save quarter power to scratch
  PLA             ; get full power again
  SEC : SBC $E0   ; subtract 25%
  BRA .exit       ; finish up

; NOTE Some freespace here, maybe

warnpc $C393E6

