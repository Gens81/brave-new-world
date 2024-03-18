;|----------------------------------------------|
;| Coreography                                  |
;| by: Sir Newton Fig                           |
;| Released on: September 28th, 2021            |
;| added cut by Feanor 18th March 2024          |
;|----------------------------------------------|

hirom

!freeC2 = $C23AC5   ; Former home of the Control effect handler, ripe for the picking
!warnC2 = $C23AEE   ; Start of Ryo's inventory duplication bugfix
!freeE6 = $E6F440   ; Freespace (80 bytes) before Palette Animation Color Palettes
!warnE6 = $E6F490

org $C201A3
  JSR FightHelper   ; Hook into "Execute Action" routine for "Added Cut" mechanic

org $C21780
  AND #$FE          ; Always clear Dance status

org $C21797
  JSL CharmHelper   ; Clear Moogle Charm flag if repeating

org $C219ED
  dw $177D          ; Revert Dance code pointer (decouple Moogle Charm from controlled dance)

org $C205B6         ; Modify how Dance step is determined
  JSR $4B5A         ; A = 0..255 (unchanged from vanilla, included for context)
  JSL StepHelper    ; Sets $EE to the index of the desired Dance step
  LDX $EE
  LDA $CFFE80,X     ; Get attack # for the Dance step used
  PLX
  RTS
padbyte $FF
pad $C205D1         ; 7 bytes reclaimed!

org $C23C82         ; Reclaim space for Moogle Charm Dance wrapper
padbyte $FF
pad $C23C8F

org !freeC2
FightHelper:
  JSR $021E         ; [displaced] Update mimic data
  LDA $B5           ; Executed command
  CMP #$13          ; Check if Dance
  BNE .end          ; Return otherwise
  LDA $3C59,X       ; Relic effects 4
  BIT #$20          ; Check for Moogle Charm flag
  BEQ .end          ; Return otherwise
  LDA $3A75         ; Monsters that are alive
  BEQ .end          ; Return if all monsters are dead
  STZ $B5           ; Set Fight command
  STZ $B8           ; Clear targets (low byte)
  STZ $B9           ; Clear targets (high byte)
  STZ $3A4C         ; Clear MP cost (fixes Tapir bug)
  JSR $13D3         ; Execute command
.end
  RTS
warnpc !warnC2

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

CharmHelper:
  CMP $ED8E5B,X     ; [displaced] Determine if repeating or shifting
  PHP               ; Store repeat/shift status
  PHA               ; Store A
  BNE .end          ; Return if shifting
  LDA $3C59,Y       ; Load relic effects 4
  BIT #$20          ; Check for Moogle Charm
  BEQ .end          ; Return if not equipped
  AND #$DF          ; Clears Moogle Charm flag
  STA $3C59,Y       ; Store relic effects 4
  TYA               ; Transfer (doubled) character index
  LSR A             ; Halve it
  TAX               ; Index it
  INC $2F30,X       ; Set equipment change flag (force relic effects update)
.end
  PLA               ; Restore A
  PLP               ; Restore repeat/shift status
  RTL
warnpc !warnE6

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
