; The following repurposes the Stereo/Mono switch to be a Text: on/off switch

org $C33CA0
  LDY #Off            ; Text pointer

org $C33CA9
  LDY #On             ; Text pointer

org $C34940
  On:   dw $3C35 : db $8E,$A7,$00
  Off:  dw $3C25 : db $8E,$9F,$9F,$00

org $C349DF
  Text: dw $3C0F : db $93,$9E,$B1,$AD,$00

org $C30068
  BRA $05             ; Always stereo

org $C33E20
  rep 4 : NOP

org $C33E2F
  rep 5 : NOP
