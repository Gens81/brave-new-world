arch 65816
hirom

table "menu.tbl",ltr

!freeE6 = $E6F440   ; Freespace (80 bytes) before Palette Animation Color Palettes
!warnE6 = $E6F490

org $C1BB31         ; Dance animation routine
  LDA ($78)
  BMI End
  LDA #$06          ; Use regular dance hop/twirl if repeating
  LSR $20           ; Load "BG shifting" bit into carry
  BCC +
  LDA #$38          ; Use boogie if shifting
+ JSR $BBE1
End:

org $C205B6         ; Modify how Dance step is determined
  JSR $4B5A         ; A = 0..255 (unchanged from vanilla, included for context)
  JSL StepHelper    ; Sets $EE to the index of the desired Dance step
  LDX $EE
  LDA $CFFE80,X     ; Get attack # for the Dance step used
  PLX
  RTS

org $C21780
  AND #$FE          ; Always clear Dance status

org $C2179D         ; Former Stumble check
  INC $20           ; Set flag to indicate BG is changing
  SEC

org $C217AF         ; Stumble when trying to dance (now unused)
FastFall_Chk:
  PHX
  TXA
  ASL #4            ; 32-byte table width
  TAX               ; index it
  LDA $2EC6,X       ; get actor index
  PLX
  CMP #$0A
  RTS

  padbyte $FF
  pad $C217C7       ; mark freespace (10 bytes free now)

org $C219ED
  dw $177D          ; Revert Dance code pointer (decouple Moogle Charm from controlled dance)

org $C23A9E         ; (copied + modified from BNW repo)
Charm_Chk:
  XBA               ; command ID
  CMP #$16          ; "Jump"
  BNE .no_jump      ; branch if not ^
; ---- modified portion ------------------
  JSR FastFall_Chk  ; z=1 if actor = Mog |
  NOP #2            ;                    |
  BNE .not_mog      ; branch if not Mog  |
; ----------------------------------------
  LDA #$0E          ; shorter wait time
  BRA .no_jump      ; and finish
.not_mog
  LDA #$16          ; longer wait time
.no_jump
  CMP #$1E          ; [displaced] is command > 1E
  RTS

org !freeE6
StepHelper:         ; Select step based on RNG value
  CMP #$60
  BCS .common       ; ..do common   if >= #$60 (10/16)
  CMP #$10
  BCS .uncommon     ; ..do uncommon if >= #$10 (5/16)
.rare
  LDA #$03          ; ..do rare     if < #$10 (1/16)
  BRA .end
.uncommon
  LDA #$02
  BRA .end
.common             ; Select which common step to use based on background
  JSR BGHelper      ; ..C = 1 if background matches chosen Dance
  TDC               ; ..A = 0
  ADC #$00          ; ..A = 0 if shifting, 1 if repeating
.end
  CLC
  ADC $EE           ; Add step index to Dance table pointer
  STA $EE           ; Store it
  RTL

BGHelper:
  LDA $3A6F         ; Load selected Dance
  LDX $11E2         ; Load current background
  CMP $ED8E5B,X     ; Check if Dance for current BG matches selected Dance
  BEQ .repeat       ;
  CLC               ; ..clear carry  if shifting
  RTS               ;
.repeat             ;
  SEC               ; ..set carry if repeating
  RTS
warnpc !warnE6


org $ED8676         ; Treasure data: Moogle Charm coordinates
  db $2b            ; move trigger up into wall (unreachable)

org $CB84A3           ; Unused event space
  db $4B,$7A,$02,$FE  ; Display caption #634: Mig eulogy


org $CFFE80 ; Reorganize Dance Step -> Attack Number table

; Wind Song
db $66 ; Sun Bath   ; Shift
db $65 ; Wind Slash ; Repeat
db $67 ; Razor Leaf ; Uncommon
db $75 ; Cockatrice ; Rare

; Forest Suite
db $67 ; Razor Leaf ; Shift
db $68 ; Harvester  ; Repeat
db $6B ; Elf Fire   ; Uncommon
db $7A ; Raccoon    ; Rare

; Desert Aria
db $6E ; Mirage     ; Shift
db $66 ; Sun Bath   ; Repeat
db $69 ; Sand Storm ; Uncommon
db $77 ; Meerkat    ; Rare

; Love Sonata
db $6B ; Elf Fire   ; Shift
db $6C ; Bedevil    ; Repeat
db $6A ; Moonlight  ; Uncommon
db $78 ; Tapir      ; Rare

; Earth Blues
db $ED ; Landslide  ; Shift
db $6D ; Avalanche  ; Repeat
db $66 ; Sun Bath   ; Uncommon
db $79 ; Wild Boars ; Rare

; Water Rondo
db $6F ; El Nino    ; Shift
db $70 ; Plasma     ; Repeat
db $74 ; Surge      ; Uncommon
db $7B ; Toxic Frog ; Rare

; Dusk Requiem
db $6A ; Moonlight  ; Shift
db $71 ; Snare      ; Repeat
db $72 ; Cave In    ; Uncommon
db $76 ; Wombat     ; Rare

; Snowman Jazz
db $73 ; Blizzard   ; Shift
db $74 ; Surge      ; Repeat
db $6E ; Mirage     ; Uncommon
db $7C ; Ice Rabbit ; Rare
