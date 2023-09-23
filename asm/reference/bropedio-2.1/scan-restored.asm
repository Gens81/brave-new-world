hirom
; header

; Name: Scan Restored
; Author: Bropedio
; Date: July 22, 2020

; Description ====================================
; The "Scan" spell should once again display HP and
; MP values for non-boss type enemies. This patch
; also rewrites the existing Scan status/weakness
; changes to save space.
;
; $C4F26A - $C4F2DC: Now free space
; * Partially used by "Runic Stance" patch (C4F26A-C4F27F)

; Code ===========================================

; Point to new scan command location
org $C21A15 : dw FullScan

; Move and rewrite full scan command
org $C25120
FullScan:
  PHP                 ; store flags
  LDX $B6             ; get target of original casting
  LDA #$FF            ; null (end of script marker)
  STA $2D72           ; set end-of-script flag
  LDA #$02            ; "Display Battle Msg" command ID
  STA $2D6E           ; set battle command ID
  STZ $2F37           ; clear message parameter
  STZ $2F3A           ; clear message parameter
  JSL ScanHPMP
  JSL ScanWeak
  JSL ScanStatus
  PLP
  RTS
warnpc $C25142

; Helpers for scan command parts
org $C250DD
LongMsgArg:
  STA $2F35           ; save param for message
LongMsg:
  PHA                 ; store A
  PHP                 ; store flags
  SEP #$20            ; 8-bit A
  LDA #$04            ; "Message" animation type
  JSR $6411           ; process message animation
  PLP                 ; restore flags
  PLA                 ; restore A
  RTL
warnpc $C250F5

; Scan command parts
org $C4F1D0
ScanHPMP:
  PHP                 ; store flags
  LDA #$30            ; "HP .../..." message ID
  STA $2D6F           ; set message ID
  LDA $3C95,X         ; enemy flags
  ASL                 ; isolate "boss" bit in N
  BMI .exit           ; branch if ^
  REP #$20            ; 16-bit A
  LDA $3C1C,X         ; max HP
  STA $2F38           ; save in msg data
  LDA $3BF4,X         ; current HP 
  JSL LongMsgArg      ; set arg, execute msg
  INC $2D6F           ; "MP .../..." message ID
  LDA $3C30,X         ; max MP
  STA $2F38           ; save in msg data
  LDA $3C08,X         ; current MP
  JSL LongMsgArg      ; set arg, execute msg
.exit
  PLP                 ; restore flags
  RTL

ScanWeak:
  LDA #$15            ; first weakness message ID
  STA $2D6F           ; set message ID
  TDC                 ; zero A/B
  TAY                 ; zero Y
  DEC                 ; #$FF (elements to scan)
  STA $EE             ; store ^
  LDA $3BE0,X         ; weaknesses to check
  STA $EC             ; store ^
  LDA $3BE1,X         ; resisted elements
  ORA $3BCC,X         ; absorbed elements
  ORA $3BCD,X         ; immune elements
  TRB $EC             ; remove resisted, absorbed, immune elements
  JSR CheckEach       ; process these elements
  DEY                 ; check if count not zero
  BPL .exit           ; exit if at least one weakness
  LDA #$2C            ; "No Weakness" message
  STA $2D6F           ; set message ID
  JSL LongMsg         ; process "No Weakness" message animation
.exit
  RTL

ScanStatus:
  PHP                 ; store flags
  LDA #$47            ; first status message ID
  STA $2D6F           ; set message ID
  REP #$20            ; 16-bit A
  LDY #$00            ; initialize message counter
  LDA #$F825          ; statuses (1-2) to scan
  STA $EE             ; store ^
  LDA $3EE4,X         ; current status (1-2)
  STA $EC             ; store ^
  JSR CheckEach       ; process these statuses
  LDA #$84FE          ; statuses (3-4) to scan
  STA $EE             ; store ^
  LDA $3EF8,X         ; current status (3-4)
  STA $EC             ; store ^
  JSR CheckEach       ; process these statuses
  DEY                 ; check if count not zero
  BPL .exit           ; exit if at least one status msg
  JSL LongMsg         ; process "No statuses" message (#$58)
.exit
  PLP                 ; restore flags
  RTL

CheckEach:
  TDC                 ; zero A/B
  INC                 ; first bit to check
.loop  
  BIT $EE             ; check if in list of "to check"
  BEQ .next           ; skip if not checking
  BIT $EC             ; check if in current status
  BEQ .skip           ; skip if not ^
  INY                 ; increment status message counter
  JSL LongMsg         ; process message box animation
.skip
  INC $2D6F           ; set message ID for next status
.next
  ASL                 ; shift bit to check
  BNE .loop           ; loop if still bits left
  RTS
warnpc $C4F26B

