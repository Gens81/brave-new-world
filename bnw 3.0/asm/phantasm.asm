arch 65816
hirom

; @returns: bit 0 = Sap, Bit 1 = Regen, Bit 2 = Rerise
; -> Regen + Sap bits = Phantasm

org $C14587
StatusTextDisp:
.rerise
  LDA $2EC0,X   ; Status byte 4 (Rerise byte)
  LSR #3        ; Shift Rerise into carry
  TDC           ; Clear A
  ROL           ; Rotate Rerise into bit 0
  XBA           ; Save Rerise
.phantasm
  LDA $3E4D,Y   ; Phantasm byte
  ROL #2        ; Shift Phantasm into carry
  BCC .regen
  XBA           ; Retrieve Rerise
  SEC
  ROL
  SEC
  ROL           ; Rerise = bit 2, Regen + Sap set in LSBs
  XBA           ; store it
  BRA .end
.regen
  LDA $2EBF,X   ; Status byte (for Regen)
  LSR #2        ; Shift Regen into carry
  XBA           ; Get Rerise
  ROL           ; Rotate Regen into bit 0, Rerise into bit 1
  XBA           ; store it
.sap
  LDA $2EBE,X   ; Status byte (for Sap)
  ROL #2        ; Shift Sap into carry
  XBA           ; Get Rerise + Regen
  ROL           ; Rotate Rerise into bit 2, Regen into bit 1, Sap into bit 0
  XBA           ; store it
.end
  LDA #$00
  XBA
  RTS

warnpc $C145B3


; The following are space saving measures

; Optimize this routine to also assign a Y index and not rely on Carry flag
org $C145B3       ; Based on A (0 - 3), check to see if a character is in that slot

  TAX
  LDA $64D6,X
  ASL
  BMI +
  TAY             ; set index for checking Phantasm
  ASL
  ASL
  ASL
  ASL
  TAX             ; set index for checking status bytes
+ RTS

org $C145CC       ; Draw the status names
  db $30          ; change BCC to BMI
org $C145D9
  db $30          ; change BCC to BMI
org $C145E6
  db $30          ; change BCC to BMI
org $C145F3
  db $30          ; change BCC to BMI

; Flatten Magitek data tables to make space for Runic helper
org $C19104
MagitekTargeting:
  db $43,$03      ; Targeting for Tek Laser, Heal Force
TekLaser:
  db $32          ; First MagiTek slot
HealForce:
  db $22          ; Second MagiTek slot
  db $FF,$FF      ; empty the rest
  db $FF,$FF
  db $FF,$FF

RunicAbsorb:     ; relocating helper for space
  JSR $BAB7      ; regular runic absorb animation
  JSR $BCA6      ; get first target index
  CMP #$04       ; is absorber a monster?
  JMP $AB92      ; reset sprite to default if not

; 2 bytes remain at end of MagiTek block, already FF

; Point old calling locations to new addresses
org $C1B7BF :  dw RunicAbsorb
org $C18681 :  dw TekLaser     ; (M-tek commands for everyone but Terra)
org $C14D61 :  dw TekLaser     ; (Left column M-tek attacks for everyone but Terra)
org $C14D68 :  dw HealForce    ; (Right column M-tek attacks for everyone but Terra)
org $C18679 :  dw TekLaser     ; (M-tek commands for Terra)
org $C14D51 :  dw TekLaser     ; (Left column M-tek attacks for Terra)
org $C14D58 :  dw HealForce    ; (Right column M-tek attacks for Terra)

; Battle status screen strings
org $C2ADE1
  db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF    ; overwrite KO
  db $FF,$28,$29,$FF,$FF,$FF,$FF,$FF,$FF,$FF    ; Sap
  db $FF,$20,$21,$22,$FF,$FF,$FF,$FF,$FF,$FF    ; Regen
  db $FF,$75,$76,$77,$78,$79,$FF,$FF,$FF,$FF    ; Phantasm
  db $FF,$20,$23,$24,$FF,$FF,$FF,$FF,$FF,$FF    ; Rerise
  db $FF,$20,$23,$24,$FF,$28,$29,$FF,$FF,$FF    ; Sap, Rerise
  db $FF,$20,$23,$24,$FF,$20,$21,$22,$FF,$FF    ; Regen, Rerise
  db $FF,$75,$76,$77,$78,$79,$20,$23,$24,$FF    ; Phantasm, Rerise
