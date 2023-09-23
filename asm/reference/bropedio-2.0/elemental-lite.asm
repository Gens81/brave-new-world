hirom
; header

; BNW - Elemental Mixing Lite
; Bropedio (June 17, 2019)
;
; Based on Elemental Share, this algorithm simplifies damage
; output to either 0%, 50%, 100%, or 200%

org $C20B8B
ElemStart:
  JMP ExitElemMod  ; exit if zero battle power

org $C20B9D
  LDA $3EE4,Y
  ASL
  BMI NullDmg      ; branch to null dmg if target petrified

org $C20BB9
  BNE ExitElemMod  ; exit if reviving dead?

org $C20BD3
  LDA $11A1        ; attack element types
  BEQ Atma         ; skip elemental mod if no attack elements
  STA $EE          ; save copy of elemental byte (used in C0 routine)
  AND $3BCC,Y      ; check absorbs
  BEQ .step2       ; if no absorb, continue elemental check
  LDA $F2
  EOR #$01
  STA $F2          ; toggle heal flag
  BRA Atma         ; finish elemental check
.step2
  PHX              ; store X on stack
  TYX              ; X = target index
  TDC              ; C0 routine requires 0 lo-A
  TAY              ; Y = 0 (modifier count)
  STZ $E8          ; E8 = 0 (# attack elems)
  SEC              ; so first ROR in C0 loop yields A=#$80
.loop
  ROR              ; A = next bit to check 
  TRB $EE          ; test for attack element
  BEQ .loop        ; if not used, try next
  INC $E8          ; increment # attack elems
  JSL ModLoop      ; increment elements and modifiers
  BNE .loop        ; if not zero, loop again 
  TYA              ; A = modifier count
  TXY              ; reset Y to target index
  PLX              ; restore X value
  CMP #$00         ; is modifier count zero (immune)?
  BNE Step3        ; if not, continue

NullDmg:
  STZ $F0
  STZ $F1          ; zero damage
  BRA SkipAtma   ; skip past Atma Weapon check

Step3:
  LSR              ; A = modifier count / 2
  CMP $E8
  BEQ Atma         ; if equals elem count, regular dmg
  BCS .double      ; if count > elems, double dmg
  LSR $F1          ; else half dmg
  ROR $F0
  BRA Atma         ; finish
.double  
  LDA $F1
  BMI Atma         ; don't double damage if over 32k
  ASL $F0
  ROL $F1          ; double damage
  NOP              ; 1 free byte

Atma:
  LDA $11A9        ; from here to rts, reverted to vanilla
  CMP #$04
  BNE SkipAtma     ; branch if not Atma Weapon special effect
  JSR $0E39        ; Atma Weapon damage modification

SkipAtma:
  JSR $0C2D        ; apply damage/healing to be done

ExitElemMod:
  PLP
  RTS
warnpc $C20C2E

org $C0FD40
ModLoop:           ; 24 bytes
  BIT $3BCD,X      ; check immunities
  BNE .next        ; if immune, skip dmg increments
.inys
  BIT $3BE1,X      ; check resistances
  BNE .half        ; only iny 50%
  INY
.half
  INY
  BCS .skip        ; skip weakness check 2nd time
  SEC              ; track weakness loop
  BIT $3BE0,X      ; check weaknesses
  BNE .inys        ; double increments via loop
.skip
  CLC
.next
  INC $EE
  DEC $EE          ; check if no remaining attack elems
  RTL

padbyte $FF
pad $C0FD84
