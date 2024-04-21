hirom

; NHT EL Tweaks (based on esper-level-simplify.asm)
; September 18, 2019
;
; For NHT, All HP and MP bonuses have been modified to give +20.
;
; HP/MP EL Byte: ppppppx0
;   p: amount to increase HP/MP
;   x: 1: MP, 0: HP
;   0: always 0
;
; Stat EL Byte: 00000ss1
;   0: always 0 (unused)
;   s: index to stat (0: Vigor, 1: Speed, 2: Stamina, 3: Magic)
;   1: always 1

org $C2614E
ELTable:
  dw $5050 ; $00 - 40HP - Terrato, Crusader
  dw $5252 ; $01 - 40MP - Bahamut, Ragnarok
  dw $5052 ; $02 - 20HP/20MP -  Phoenix, Seraph
  dw $0150 ; $03 - 20HP/Vig - Golem
  dw $5207 ; $04 - 20MP/Mag - Zoneseek
  dw $0103 ; $05 - Vig/Spd - Palidor
  dw $0307 ; $06 - Mag/Spd - Siren
  dw $0105 ; $07 - Vig/Stm - Phantom
  dw $0507 ; $08 - Mag/Stm - Maduin
  dw $0305 ; $09 - Spd/Stm - Alexander
  dw $5005 ; $0A - 20HP/Stm - Kirin, Unicorn
  dw $0552 ; $0B - 20MP/Stm - Carbunkl
  dw $0101 ; $0C - 2Vig - Ramuh, Bismark
  dw $0303 ; $0D - 2Spd - Ifrit, Fenrir
  dw $0505 ; $0E - 2Stm - Stray, Odin, Tritoch, Starlet
  dw $0707 ; $0F - 2Mag - Shiva, Shoat
  dw $0000 ; $10 - null - Raiden?
