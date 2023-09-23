hirom
; header

; BNW - Review Screen Esper Yellow
; Bropedio (August 20, 2019)

org $C3F480
DrawNameAndEsper:
  LDA #$24          ; "blue" palette
  STA $29           ; set palette color
  PHY               ; store tile position
  JSR $34CF         ; draw character name
  LDA #$34          ; "pink" unset palette (RAM noise)
  STA $29           ; set palette color
  REP #$20          ; 16-bit A
  PLA               ; get tile position
  CLC               ; prepare add
  ADC #$0020        ; advance 16 spaces
  TAY               ; store new tile position
  LDA #$03BF        ; "yellow" color
  STA $7E30EF       ; text color for unused palette
  TDC               ; A = 0000 "black"
  STA $7E30EB       ; border color for unused palette
  SEP #$20          ; 8-bit A
  JSR $34E6         ; draw esper name 
  LDA #$20          ; "white" palette
  STA $29           ; set palette color
  RTS
warnpc $C3F4B2
padbyte $FF
pad $C3F4B1
