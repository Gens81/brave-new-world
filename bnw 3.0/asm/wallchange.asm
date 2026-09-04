hirom
!free = $C0DA90           ; TODO: find 26 bytes in any bank

org $C23989           ; Wall Change effect
  JSL WallChange      ; Move implementation out of bank
  RTS

RandomBitLong:
  JSR $522A           ; Provide a JSL wrapper for the "random bit" function at $522A
  RTL

padbyte $FF
pad $C2399E           ; Erase rest of function (frees 12 bytes)

org !free
WallChange:
  TDC
  LDA $3BE0,Y         ; A = current weaknesses
  EOR #$FF            ; Invert: A = all non-weak elements
  JSL RandomBitLong   ; Pick one at random
  STA $3BE0,Y         ; Set it as weakness
  EOR #$FF            ; Invert: A = all elements other than weakness
  STA $3BCD,Y         ; Nullify all other elements
  JSL RandomBitLong   ; Pick one null element at random
  STA $3BCC,Y         ; Absorb that element
  RTL