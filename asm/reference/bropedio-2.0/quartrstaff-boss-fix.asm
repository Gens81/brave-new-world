hirom
; header

; BNW - Fix Quartrstaff Boss Bug
; Bropedio (Sept 5, 2019)
;
; * Don't bypass fractional immunity checks
; * Get correct spell data (X-Zone vs. Doom)
; * Randomize multi-target spells and don't backup targets
; * Don't target dead/hidden

!free_c4 = $C4B9CF   ; moved 1 byte earlier than dn's patch

; #######################################
; Convert Doom to X-Zone for autocrit

org $C23659
  JSL SpellCastId
  NOP

; #######################################
; Shift entry to autocrit spellcast modifications

org $C2381B
  JSL CastTarget
  STA $BB           ; vanilla code (restored)

; #######################################
; Show missed spellcast animations

org $C23828
  NOP #3            ; always show missed spellcast animations

; #######################################
; New Code (handle auto-crit spellcasts)

org !free_c4

SpellCastId:       ; 20 bytes
  AND #$3F         ; isolate spell id (vanilla code)
  CMP #$0D         ; "Doom" ID
  BNE .set_spell   ; if not "Doom", no conversion needed
  LDA $B3
  LSR
  LSR              ; "Autocrit" in carry
  LDA #$0D         ; default to using "Doom" id
  BCS .set_spell   ; if no "Autocrit", keep id
  LDA #$12         ; else replace with "X-Zone"
.set_spell
  STA $3400        ; save spellcast ID
  RTL

CastTarget:        ; 29 bytes
  LDA $B3
  LSR
  LSR              ; "Autocrit" in carry
  BCS .regular     ; branch if no ^
  LDA $B6          ; spell ID
  CMP #$17         ; "Quartr"
  BEQ .multi       ; branch if matched
  CMP #$12         ; "X-Zone"
  BEQ .multi       ; branch if matched
.regular
  LDA #$0C         ; "Hit dead targets"/"No retarget if invalid"
  TSB $BA          ; set flags
  LDA #$40         ; regular single enemy targeting
  RTL
.multi
  STZ $3415        ; randomize targets, and don't back them up
  LDA #$6E         ; all enemies targeting
  RTL
