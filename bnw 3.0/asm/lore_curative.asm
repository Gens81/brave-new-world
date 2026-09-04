hirom
; header

; BNW - Lore Curative
;
; Allow Lore and Esper menus to open "Curative Ally Targeting" submenu

org $C18931
ItemJump:

org $C181D6
SpellJump:
  LDA $2094,X     ; targeting byte
  XBA             ; store in B
  LDA #$03        ; "Magic" parent menu
LoreHelp:
  STA $ECBA       ; set parent menu
  LDA #$00        ; ensure B stays zero
  XBA             ; get targeting byte
  STA $7A84       ; save ^
  JMP ItemJump    ; leverage item code for targeting fork
warnpc $C181EC

org $C18374
LoreJump:
  XBA            ; store targeting byte 
  LDA #$09       ; set parent menu to "lore"
  JMP LoreHelp

; ############################################
; Change use of $ECBA to support Lore menu

org $C155C2
  CLC : ADC #$05  ; +5
  LSR             ; /2

org $C14573
  LDA #$1A
  NOP
  ORA $ECBA

; ############################################
; This can't work as is, due to window complexity
;org $C182F2
;EsperJump:
;  XBA             ; store tareting byte
;  LDA #$03        ; set parent menu to "esper"
;  JMP EsperHelp
