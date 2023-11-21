;|----------------------------------------------|
;| Coreography                                  |
;| by: Sir Newton Fig                           |
;| Released on: September 28th, 2021            |            
;|----------------------------------------------|

arch 65816
hirom

!free = $C23AC5     ; Former home of the Control effect handler, ripe for the picking

org $C21780
  AND #$FE          ; Always clear Dance status

org $C2179D
  JSR StumbleCheck  ; Let Moogle Charm bypass stumble chance

org $C219ED
  dw $177D          ; Revert Dance code pointer (decouple Moogle Charm from controlled dance)

org $C23C82         ; Reclaim space for Moogle Charm Dance wrapper
  padbyte $FF
  pad $C23C8F

org $C205B6         ; Modify how Dance step is determined
  JSL PickType      ; X = index of Dance step
  JSR $4B65         ; RNG (0..7)
  CMP.l Thresholds,X  ; Compare number with threshold
  BCS +             ; Use the common step if above
  INC $EE           ; Use the uncommon step if below
+ LDX $EE
  LDA $CFFE80,X     ; Get attack # for the Dance step used
  PLX
  RTS

; Data
Thresholds:
  db $04            ; Transition steps: choose A if RNG(0..19) >= 5 (",$12,"), else B
  db $08            ; Sustain steps: choose A if RNG(0..19) >= 8 (",$0F,"), else B

padbyte $FF
pad $C205D1         ; 2 bytes reclaimed, wowee

org !free
PickType:
  LDA $3A6F
  LDX $11E2
  CMP $ED8E5B,X     ; Check if background is same as dance
  BNE +             ; Branch if not
  rep 2 : INC $EE   ; Use lower half of step list for sustain steps
  LDX #$01          ; Use sustain probabilities
  BRA ++
+ LDX #$00          ; Use transition probabilities
++ LDA #$14
+ RTL

StumbleCheck:
  PHA
  LDA $3C59,Y       ; Relic Effects 4
  BIT #$20          ; Moogle Charm flag (unused in Vanilla)
  BNE +
  JSR $3AB3         ; Check for stumble rate if no Charm equipped
  BRA ++
+ SEC               ; Proceed without stumble check if Charm equipped
++ PLA
  RTS

padbyte $FF         ; Reclaim (most of) the rest of the routine
pad $C23B1B         ; After this, some of the Control code miss condition is still required

;Dance tables

org $CFFE80 ; Reorganize Dance Step -> Attack Number table
  ; Wind Song
  ; -- Transition --
  db $66 ; Sun Bath   ; ",$12,"
  db $75 ; Cockatrice ; ",$1A,"
  ; --- Sustain -----
  db $67 ; Razor Leaf ; ",$0F,"
  db $65 ; Wind Slash ; ",$10,"

  ; Forest Suite
  ; -- Transition --
  db $67 ; Razor Leaf ; ",$12,"
  db $7A ; Raccoon    ; ",$1A,"
  ; --- Sustain -----
  db $68 ; Harvester  ; ",$0F,"
  db $6B ; Elf Fire   ; ",$10,"
  
  ; Desert Aria
  ; -- Transition --
  db $6E ; Mirage     ; ",$12,"
  db $77 ; Meerkat    ; ",$1A,"
  ; --- Sustain -----
  db $66 ; Sun Bath   ; ",$0F,"
  db $69 ; Sand Storm ; ",$10,"
  
  ; Love Sonata
  ; -- Transition --
  db $6B ; Elf Fire   ; ",$12,"
  db $78 ; Tapir      ; ",$1A,"
  ; --- Sustain -----
  db $6C ; Bedevil    ; ",$0F,"
  db $6A ; Moonlight  ; ",$10,"
  
  ; Earth Blues
  ; -- Transition --
  db $6D ; Avalanche  ; ",$12,"
  db $79 ; Wild Boars ; ",$1A,"
  ; --- Sustain -----
  db $ED ; Landslide  ; ",$0F,"
  db $66 ; Sun Bath   ; ",$10,"
  
  ; Water Rondo
  ; -- Transition --
  db $6F ; El Nino    ; ",$12,"
  db $7B ; Toxic Frog ; ",$1A,"
  ; --- Sustain -----
  db $70 ; Plasma     ; ",$0F,"
  db $74 ; Surge      ; ",$10,"
  
  ; Dusk Requiem
  ; -- Transition --
  db $6A ; Moonlight  ; ",$12,"
  db $76 ; Wombat     ; ",$1A,"
  ; --- Sustain -----
  db $71 ; Snare      ; ",$0F,"
  db $72 ; Cave In    ; ",$10,"

  ; Snowman Jazz
  ; -- Transition --
  db $73 ; Blizzard   ; ",$12,"
  db $7C ; Ice Rabbit ; ",$1A,"
  ; --- Sustain -----
  db $74 ; Surge      ; ",$0F,"
  db $6E ; Mirage     ; ",$10,"