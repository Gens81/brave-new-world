hirom
table table_c3.tbl,rtl
; header

; BNW - Rage & Dance Descriptions (by dn)
; Bropedio (August 24, 2019)
;
; Converted dn's original description binaries.
; Also adding dynamic prefixing for the rage
; descriptions, to save ~450 bytes
;
; NOTE: Typo fixed by BTB, 2021

!help_hook = $C3FCA0
!desc_data = $C4A820

!w = $E8 ; white magic dot
!b = $E9 ; black magic dot
!g = $EA ; gray magic dot

; #####################################
; Insert rage descriptions

org $C328BE
  JSR RageDescHelp

; #####################################
; Insert dance descriptions

org $C328AA
  JSR DancesHook

; #####################################
; New rage & dance helpers

org !help_hook

PrepDescs:
  STX $E7          ; store pointer offset
  LDX #$0000       ; use base offset for text
  STX $EB          ; ^ will be added to Y index
  LDA #$C4         ; bank
  STA $ED          ; text bank
  STA $E9          ; pointer bank
  JSR $0EFD        ; queue list upload (vanilla)
  LDA #$10         ; "Descriptions on"
  TRB $45          ; set ^ in menu flags
  RTS

DancesHook:
  LDX #DanceDescs  ; pointer offsets
  JSR PrepDescs
  JMP $572A

RageDescHelp:
  LDX #RageDescs   ; pointer offsets
  JSR PrepDescs
  LDX #$9EC9       ; 7E/9EC9
  STX $2181        ; Set WRAM LBs
  TDC              ; clear A
  LDA $4B          ; list slot
  TAX              ; index it
  LDA $7E9D89,X    ; entry id
  CMP #$FF         ; null slot?
  BNE .continue    ; branch if not ^
  JMP $576D        ; blank description
.continue
  REP #$20         ; 16-bit A
  ASL A            ; double id
  TAY              ; index it
  LDA [$E7],Y      ; Relative ptr
  PHA              ; store for later
  SEP #$20         ; 8-bit A
  LDY #PrefixA
  JSR WriteLine
  PLY              ; get description pointer
  JSR WriteLine
  PHY              ; save next line offset
  LDY #PrefixB
  JSR WriteLine
  PLY              ; get next line offset
  JSR WriteLine
  STZ $2180
  RTS

WriteChar:
  INY
  STA $2180       ; add to string
  CMP #$01
  BEQ WriteExit
WriteLine:
  LDA [$EB],Y     ; text character
  BNE WriteChar   ; loop if not 00
WriteExit:
  RTS
warnpc $C40000

; #####################################
; Rage description pointers

org !desc_data
RageDescs:
  dw .empty
  dw .soldier
  dw .empty
  dw .ninja
  dw .empty
  dw .shokan
  dw .empty
  dw .empty
  dw .conjuror
  dw .empty
  dw .empty
  dw .scrapper
  dw .gargoyle
  dw .empty
  dw .spirit
  dw .lich
  dw .empty
  dw .empty
  dw .empty
  dw .sewer_rat
  dw .empty
  dw .empty
  dw .empty
  dw .leafer
  dw .stray_cat
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .adamantite
  dw .empty
  dw .chimera
  dw .behemoth
  dw .mesosaur
  dw .albatross
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .tyrano
  dw .raven
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .hornet
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .tumbleweed
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .exocite
  dw .empty
  dw .empty
  dw .empty
  dw .chickenlip
  dw .empty
  dw .empty
  dw .empty
  dw .onion_kid
  dw .tek_armor
  dw .empty
  dw .empty
  dw .empty
  dw .vaporite
  dw .flan
  dw .jinn
  dw .empty
  dw .brainpan
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .bomb
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .magic_pot
  dw .empty
  dw .empty
  dw .buffalax
  dw .empty
  dw .empty
  dw .troll
  dw .sand_ray
  dw .antlion
  dw .empty
  dw .empty
  dw .empty
  dw .marlboro
  dw .crawler
  dw .eye_goo
  dw .empty
  dw .empty
  dw .templar
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .rain_man
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .osteosaur
  dw .empty
  dw .rocky
  dw .empty
  dw .empty
  dw .rhydon
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .doggo
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .zombone
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .windrunner
  dw .vulture
  dw .griffin
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .scarab
  dw .empty
  dw .empty
  dw .belladonna
  dw .empty
  dw .weedula
  dw .empty
  dw .empty
  dw .cephalid
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .nastidon
  dw .empty
  dw .locust
  dw .empty
  dw .mantodea
  dw .empty
  dw .grizzly
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .vagrant
  dw .empty
  dw .repo_man
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .anemone
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .kudzu
  dw .empty
  dw .empty
  dw .revenant
  dw .titan
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .witch
  dw .werewolf
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .empty
  dw .io

; #####################################
; Rage description text

.empty
  db $00
.soldier
  db !w,"Cure 2",$01
  db "Attack (2x damage)",$00
.ninja
  db "Wave Scroll",$01
  db "Vanish",$00
.shokan
  db !b,"Dark",$01
  db "Raze",$00
.conjuror
  db !w,"Rerise",$01
  db "Attack (Sap)",$00
.scrapper
  db "Attack (2x damage)",$01
  db "Chakra",$00
.gargoyle
  db "Sun Bath",$01
  db !b,"Quake",$00
.spirit
  db !b,"Demi",$01
  db !b,"Quartr",$00
.lich
  db !g,"Rasp",$01
  db "Elf Fire",$00
.sewer_rat
  db !b,"Poison",$01
  db "Attack (Poison)",$00
.leafer
  db "Wind Slash",$01
  db "Air Blast",$00
.stray_cat
  db "Snowball",$01
  db "Attack (3x damage)",$00
.adamantite
  db "Attack (2x damage)",$01
  db "Holy Wind",$00
.chimera
  db "Aqualung",$01
  db "Fireball",$00
.behemoth
  db "Attack (2x damage)",$01
  db "Meteo",$00
.mesosaur
  db "Holy Wind",$01
  db "Magnitude",$00
.albatross
  db "Fireball",$01
  db "Attack (2x damage)",$00
.tyrano
  db "Attack (3x damage)",$01
  db "Firestorm",$00
.raven
  db !b,"Break",$01
  db "Attack (Sleep)",$00
.hornet
  db "Attack (3x damage)",$01
  db "Blink",$00
.tumbleweed
  db !w,"Cure 3",$01
  db "Attack (Steal HP)",$00
.exocite
  db "Rock",$01
  db "Attack (2x damage)",$00
.chickenlip
  db "Attack (Muddle)",$01
  db "Net",$00
.onion_kid
  db "Brown Note",$01
  db "Attack (Bserk)",$00
.tek_armor
  db "Barrier",$01
  db "Attack (2x damage)",$00
.vaporite
  db "Plasma",$01
  db "Attack (Blind - no dmg)",$00
.flan
  db !w,"Life",$01
  db !g,"SlowX",$00
.jinn
  db "Discord",$01
  db "Attack (Mute)",$00
.brainpan
  db "Blow Fish",$01
  db !w,"Rerise",$00
.bomb
  db "Exploder",$01
  db "Exploder",$00
.magic_pot
  db !w,"Cure",$01
  db "Attack (4x damage)",$00
.buffalax
  db "Landslide",$01
  db "Attack (3x damage)",$00
.troll
  db "Attack (3x damage)",$01
  db "Refract",$00
.sand_ray
  db "Sand Storm",$01
  db "Attack (2x damage)",$00
.antlion
  db "Attack (Stop - no dmg)",$01
  db "Snare",$00
.marlboro
  db "Bio Blast",$01
  db "Bad Breath",$00
.crawler
  db "Magnitude",$01
  db "Attack (Steal HP)",$00
.eye_goo
  db "Lode Stone",$01
  db "Glare",$00
.templar
  db "Attack (3x damage)",$01
  db !w,"Remedy",$00
.rain_man
  db "Acid Rain",$01
  db !b,"Bolt 2",$00
.osteosaur
  db !b,"Doom",$01
  db "Attack (Petrify - no dmg)",$00
.rocky
  db "Harvester",$01
  db "Rock",$00
.rhydon
  db "Attack (2x damage)",$01
  db "Sun Bath",$00
.doggo
  db "Attack (3x damage)",$01
  db "Step Mine",$00
.zombone
  db "Cave In",$01
  db "Attack (Zombie - no dmg)",$00
.windrunner
  db "Aero",$01
  db "Blight",$00
.vulture
  db "Razor Leaf",$01
  db "Harvester",$00
.griffin
  db "Giga Volt",$01
  db "Air Blast",$00
.scarab
  db "Starlight",$01
  db "Mega Volt",$00
.belladonna
  db "Moonlight",$01
  db "Raid",$00
.weedula
  db !b,"Quake",$01
  db "Razor Leaf",$00
.cephalid
  db "Tentacle",$01
  db "Attack (Slow)",$00
.nastidon
  db "Snowball",$01
  db "Absolute 0",$00
.locust
  db "Gale Cut",$01
  db "Mirage",$00
.mantodea
  db "Shrapnel",$01
  db "Attack (Sap)",$00
.grizzly
  db "Cave In",$01
  db "Attack (3x damage)",$00
.vagrant
  db "Flash Rain",$01
  db "Attack (2x damage)",$00
.repo_man
  db "Step Mine",$01
  db "Vanish",$00
.anemone
  db "Discharge",$01
  db "Attack (Poison)",$00
.kudzu
  db "Raid",$01
  db !w,"RegenX",$00
.revenant
  db !b,"Holy",$01
  db "Blaze",$00
.titan
  db "Avalanche",$01
  db "Attack (3x damage)",$00
.witch
  db "Refract",$01
  db !b,"Fire 3",$00
.werewolf
  db "Attack (3x damage)",$01
  db !w,"Regen",$00
.io
  db "Atomic Ray",$01
  db "Diffuser",$00

PrefixA:
  db "66% ",$00
PrefixB:
  db "33% ",$00

; #####################################
; Dance description pointers

DanceDescs:
  dw .wind_song
  dw .forest_suite
  dw .desert_aria
  dw .love_sonata
  dw .earth_blues
  dw .water_rondo
  dw .dusk_requiem
  dw .snowman_jazz

; #####################################
; Dance description text

.wind_song
  db "Sun Bath: 7/16, Wind Slash: 5/16",$01
  db "Razor Leaf: 3/16, Cockatrice: 1/16",$00
.forest_suite
  db "Harvester: 7/16, Razor Leaf: 5/16",$01
  db "Elf Fire: 3/16, Raccoon: 1/16",$00
.desert_aria
  db "Sand Storm: 7/16, Mirage: 5/16",$01
  db "Sun Bath: 3/16, Meerkat: 1/16",$00
.love_sonata
  db "Bedevil: 7/16, Moonlight: 5/16",$01
  db "Elf Fire: 3/16, Tapir: 1/16",$00
.earth_blues
  db "Avalanche: 7/16, Sun Bath: 5/16",$01
  db "Wind Slash: 3/16, Wild Boars: 1/16",$00
.water_rondo
  db "El Nino: 7/16, Plasma: 5/16",$01
  db "Surge: 3/16, Toxic Frog: 1/16",$00
.dusk_requiem
  db "Cave In: 7/16, Snare: 5/16",$01
  db "Moonlight: 3/16, Wombat: 1/16",$00
.snowman_jazz
  db "Blizzard: 7/16, Surge: 5/16",$01
  db "Mirage: 3/16, Ice Rabbit: 1/16",$00

warnpc $C4B9D1
