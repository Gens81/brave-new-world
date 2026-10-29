hirom
; header

; Level Cap Patch
; Bropedio

org $C26073 : CMP #$1E ; Max out level at 30
org $C2A6E0 : CMP #$14 ; Max out EL at 20

; exploiting elemental weakness does 1.5x dmg in place of 2x
!free = $C47F40

org $C20C19
  JSL ElementalWeakHelper

org !free
ElementalWeakHelper:
  REP #$20         ; 16-bit A
  LDA $F0          ; load damage
  LSR              ; half damage
  CLC
  ADC $F0          ; damage = 1.5x
  STA $F0
  SEP #$20         ; 8-bit A
  RTL

; Cap max items at 20, rather than 99
; Bropedio

; #################################################
; Change all checks for 99 to checks for 20

org $C39D8D : CMP #$14
org $C3B840 : CMP #$14
org $C1448B : CMP #$14
org $C1448F : LDA #$14
org $C0A024 : CMP #$14
org $C0AD25 : CMP #$14

; Code that has been overwritten, or never runs
; org $C18BE4 : CMP #$14
; org $C18C99 : CMP #$14
; org $C19035 : CMP #$14
; org $C190FC : CMP #$14
; Removed org $C3B836 : LDA #$14 cause tools now can't be more than 1 per type

; BNW - Simplified Esper Levels
; Bropedio (April 26, 2019)
; Last modified: June 11, 2019
;
; This overhauls the handling of esper boosts to enable faster changes:
; * Use a table of data rather than pointers to subroutines
; * Encode each bonus into a single byte (bits: 76543210)
;   * Bit 0 indicates stat versus HP/MP
;   * If stat, bits 2 and 1 provide stat index (7-3 are zero)
;   * If stat, assume change of 1 (could support more w/ unused bits)
;   * If HP/MP, bit 1 indicates MP (over HP)
;   * If HP/MP, bits 7-2 indicate amount to change (max 63)

	; Additional notes for simplicity:
	; $01 = 1 Vig
	; $03 = 1 Spd
	; $05 = 1 Spr
	; $07 = 1 Mag
	; $01010000 = $50 = 20 HP
	; $00111110 = $3E = 15 MP

org $C2614E
ELTable:
    db $50,$50 ; 40HP - Terrato, Crusader (reduced from +60)
    db $3E,$3E ; 30MP - Bahamut, Ragnarok
    db $50,$3E ; 20HP/15MP -  Phoenix, Seraph
    db $01,$50 ; 20HP/Vig - Golem
    db $3E,$07 ; 15MP/Mag - Zoneseek
    db $01,$03 ; Vig/Spd - Palidor
    db $03,$07 ; Mag/Spd - Siren
    db $01,$05 ; Vig/Spi - Phantom
    db $05,$07 ; Mag/Spi - Maduin
    db $03,$05 ; Spd/Spi - Alexander
    db $50,$05 ; 20HP/Spi - Kirin, Unicorn
    db $3E,$05 ; 15MP/Spi - Carbunkl
    db $01,$01 ; 2Vig - Ramuh, Bismark
    db $03,$03 ; 2Spd - Ifrit, Fenrir
    db $05,$05 ; 2Spi - Stray, Odin, Tritoch, Starlet
    db $07,$07 ; 2Mag - Shiva, Shoat
    db $00,$00 ; null - Raiden?

;----------------------------------------------
;Esper bonus descriptions
;----------------------------------------------

org $EDFE00

HP: db "+40 HP per EL spent",$00
MP: db "+30 MP per EL spent",$00
HMPP: db "+20 HP/+15 MP per EL spent",$00
VgrHP: db "+1 Vigor/+20 HP per EL spent",$00
MagMP: db "+1 Magic/+15 MP per EL spent",$00
VgrSpd: db "+1 Vigor/+1 Speed per EL spent",$00
MagSpd: db "+1 Magic/+1 Speed per EL spent",$00
VgrSta: db "+1 Vigor/+1 Spirit per EL spent",$00
MagSta: db "+1 Magic/+1 Spirit per EL spent",$00
SpdSta: db "+1 Speed/+1 Spirit per EL spent",$00
HPSta: db "+20 HP/+1 Spirit per EL spent",$00
MPSta: db "+15 MP/+1 Spirit per EL spent",$00
Vigor: db "+2 Vigor per EL spent",$00
Speed: db "+2 Speed per EL spent",$00
Stamina: db "+2 Spirit per EL spent",$00
Magic: db "+2 Magic per EL spent",$00
