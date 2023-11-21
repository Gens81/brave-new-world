arch 65816
hirom

table "menu.tbl",ltr

; BNW - Rage & Dance Descriptions (by dn)
; Bropedio (August 24, 2019)
;
; Converted dn's original description binaries.
; Also adding dynamic prefixing for the rage
; descriptions, to save ~450 bytes

!help_hook = $C3FCA0
!desc_data = $C4A820

!w = $E8 ; white magic dot
!b = $E9 ; black magic dot
!g = $EA ; gray magic dot
!l = $E3 ; lore icon

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
  STX $2181        ; set WRAM LBs
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
; #####################################

.empty
  db $00
.soldier
  db !w,"Cure 2",$01
  db "Attack (2x dmg)",$00
.ninja
  db "Wave Scroll (",$FD,")",$01
  db "Vanish (sets [Clear])",$00
.shokan
  db !b,"Dark",$01
  db !l,"Raze",$00
.conjuror
  db !w,"Rerise",$01
  db "Attack (Sap)",$00
.scrapper
  db "Attack (2x dmg)",$01
  db "Chakra",$00
.gargoyle
  db "Sun Bath (cures HP)",$01
  db !b,"Quake",$00
.spirit
  db !b,"Demi",$01
  db !b,"Quartr",$00
.lich
  db !g,"Rasp",$01
  db "Elf Fire (",$FC,")",$00
.sewer_rat
  db !b,"Poison",$01
  db "Attack (Poison)",$00
.leafer
  db "Wind Slash (",$F9,")",$01
  db "Air Blast (",$F9," HP * ",$11,")",$00
.stray_cat
  db "Snowball (",$FB,", may set [Slow])",$01
  db "Attack (3x dmg)",$00
.adamantite
  db "Attack (2x dmg)",$01
  db !l,"Holy Wind",$00
.chimera
  db !l,"Aqualung",$01
  db "Fireball (",$FC,", may set [Sap])",$00
.behemoth
  db "Attack (2x dmg)",$01
  db "Meteo (ignores def.)",$00
.mesosaur
  db !l,"Holy Wind",$01
  db "Magnitude (",$FA," ground dmg)",$00
.albatross
  db "Fireball (",$FC,", may set [Sap])",$01
  db "Attack (2x dmg)",$00
.tyrano
  db "Attack (3x dmg)",$01
  db "Firestorm (",$FC,"/",$FD,")",$00
.raven
  db !b,"Break",$01
  db "Attack (Sleep)",$00
.hornet
  db "Attack (3x dmg)",$01
  db "Blink (sets [Image]/[Haste])",$00
.tumbleweed
  db !w,"Cure 3",$01
  db "Attack (steal HP)",$00
.exocite
  db "Rock (stamina, may set [Muddle])",$01
  db "Attack (2x dmg)",$00
.chickenlip
  db "Attack (Muddle)",$01
  db "Net (sets [Slow]/[Stop])",$00
.onion_kid
  db "Brown Note (random bad status)",$01
  db "Attack (Berserk)",$00
.tek_armor
  db "Barrier (sets [Shell]/[Reflect])",$01
  db "Attack (2x dmg)",$00
.vaporite
  db "Plasma (",$FD,")",$01
  db "Attack (Blind - no dmg)",$00
.flan
  db !w,"Life",$01
  db !g,"SlowX",$00
.jinn
  db !l,"Discord",$01
  db "Attack (Mute)",$00
.brainpan
  db !l,"Blow Fish",$01
  db !w,"Rerise",$00
.bomb
  db "Exploder (dmg = caster's HP * 2.5)",$01
  db "Exploder",$00
.magic_pot
  db !w,"Cure",$01
  db "Attack (4x dmg)",$00
.buffalax
  db "Landslide (",$FA,", may set [Slow])",$01
  db "Attack (3x dmg)",$00
.troll
  db "Attack (3x dmg)",$01
  db !l,"Refract",$00
.sand_ray
  db "Sand Storm (",$FA,"/",$F9,",",$03,"may set [Blind])",$01
  db "Attack (2x dmg)",$00
.antlion
  db "Attack (Stop - no dmg)",$01
  db "Snare (instant death)",$00
.marlboro
  db "Bio Blast (",$EF,", may set [Poison])",$01
  db !l,"Bad Breath",$00
.crawler
  db "Magnitude (",$FA," ground dmg)",$01
  db "Attack (steal HP)",$00
.eye_goo
  db "Lode Stone",$03,"(",$FA," HP * ",$13,", may slow)",$01
  db "Glare (sets [Petrify])",$00
.templar
  db "Attack (3x dmg)",$01
  db !w,"Remedy",$00
.rain_man
  db "Acid Rain (",$FD,", may set [Sap])",$01
  db !b,"Bolt 2",$00
.osteosaur
  db !b,"Doom",$01
  db "Attack (Petrify - no dmg)",$00
.rocky
  db "Harvester",$03,"(cures HP/bad statuses)",$01
  db "Rock (stamina, may set [Muddle])",$00
.rhydon
  db "Attack (2x dmg)",$01
  db "Sun Bath (cures HP)",$00
.doggo
  db "Attack (3x dmg)",$01
  db "Step Mine (dmg rises w/ steps)",$00
.zombone
  db "Cave In (",$FA," HP * ",$12,", sets [Sap])",$01
  db "Attack (Zombie - no dmg)",$00
.windrunner
  db "Aero (",$F9,", may set [Sap])",$01
  db "Blight (",$EF,"/",$F9,", may set [Poison])",$00
.vulture
  db "Razor Leaf (",$FA,"/",$F9,")",$01
  db "Harvester",$03,"(cures HP/bad statuses)",$00
.griffin
  db "Giga Volt (",$F8,"/",$F9,", may set [Sap])",$01
  db "Air Blast (",$F9," HP * ",$11,")",$00
.scarab
  db "Starlight (may set [Blind])",$01
  db "Mega Volt (",$F8,"/",$F9,", may set [Sap])",$00
.belladonna
  db "Moonlight (",$F6,")",$01
  db !l,"Raid",$00
.weedula
  db !b,"Quake",$01
  db "Razor Leaf (",$FA,"/",$F9,")",$00
.cephalid
  db "Tentacle (stamina-based)",$01
  db "Attack (Slow)",$00
.nastidon
  db "Snowball (",$FB,", may set [Slow])",$01
  db "Absolute 0 (",$FB,$FB,$FB,")",$00
.locust
  db "Gale Cut (",$F9,")",$01
  db "Mirage (randomly sets [Image])",$00
.mantodea
  db "Shrapnel (stamina-based)",$01
  db "Attack (Sap)",$00
.grizzly
  db "Cave In (",$FA," HP * ",$12,", sets [Sap]) ",$01
  db "Attack (3x dmg)",$00
.vagrant
  db "Flash Rain (",$F8,"/",$FD,")",$01
  db "Attack (2x dmg)",$00
.repo_man
  db "Step Mine (dmg rises w/ steps)",$01
  db "Vanish (sets [Clear])",$00
.anemone
  db "Discharge (",$F8,")",$01
  db "Attack (Poison)",$00
.kudzu
  db !l,"Raid",$01
  db !w,"RegenX",$00
.revenant
  db !b,"Holy",$01
  db !l,"Blaze",$00
.titan
  db "Avalanche (",$FA,", ignores def.)",$01
  db "Attack (3x dmg)",$00
.witch
  db !l,"Refract",$01
  db !b,"Fire 3",$00
.werewolf
  db "Attack (3x dmg)",$01
  db !w,"Regen",$00
.io
  db "Atomic Ray (unreflectable)",$01
  db "Diffuser (",$F8,")",$00

PrefixA:
  db $0F," ",$00
PrefixB:
  db $10," ",$00

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
  db $17," Sun Bath",$18,$18,$18,$04,$16," Wind Slash",$01
  db $15," Razor Leaf",$18,$18,"  ",$14," Cockatrice",$00
.forest_suite
  db $17," Harvester",$18,$18,$04," ",$16," Razor Leaf",$01
  db $15," Elf Fire",$18,$18,$18,$18,$19,$14," Raccoon",$00
.desert_aria
  db $17," Sand Storm",$18,$18,$06,$16," Mirage",$01
  db $15," Sun Bath",$18,$18,$18,$04,$14," Meerkat",$00
.love_sonata
  db $17," Bedevil",$18,$18,$18,$18,$19,$16," Moonlight",$01
  db $15," Elf Fire",$18,$18,$18,$18,$19,$14," Tapir",$00
.earth_blues
  db $17," Avalanche ",$18,$02,$02,$16," Sun Bath",$01
  db $15," Wind Slash",$18,$18,$02,$14," Wild Boars",$00
.water_rondo
  db $17," El Nino",$18,$18,$18,$18,$04,$16," Plasma",$01
  db $15," Surge",$18,$18,$18,$18,$18,$03,$14," Toxic Frog",$00
.dusk_requiem
  db $17," Cave In",$18,$18,$18,$18," ",$16," Snare",$01
  db $15," Moonlight ",$18,$18,$19,$06,$14," Wombat",$00
.snowman_jazz
  db $17," Blizzard",$18,$18,$18,$19,$06,$16," Surge",$01
  db $15," Mirage",$18,$18,$18,$02,$04,$14," Ice Rabbit",$00
  
;.wind_song
;  db "T:",$03,$1E," Sun Bath",$18,$02,$04,$1A," Cockatrice",$01
;  db "S: ",$05," Razor Leaf",$18,$19,$1F," Wind Slash",$00
;.forest_suite
;  db "T:",$03,$1E," Razor Leaf",$18,$19,$1A," Raccoon",$01
;  db "S: ",$05," Harvester",$02,$02,$03,$1F," Elf Fire",$00
;.desert_aria
;  db "T:",$03,$1E," Mirage",$02,$02,$02,$02,$1A," Meerkat",$01
;  db "S: ",$05," Sun Bath",$02,$02,$02,$1F," Sand Storm",$00
;.love_sonata
;  db "T:",$03,$1E," Elf Fire",$18,$18,$18,$06,$1A," Tapir",$01
;  db "S: ",$05," Bedevil",$18,$18,$18,$06,$1F," Moonlight",$00
;.earth_blues
;  db "T:",$03,$1E," Avalanche",$02,$02,$03,$1A," Wild Boars",$01
;  db "S: ",$05," Landslide",$04,$04,$04,$1F," Sun Bath",$00
;.water_rondo
;  db "T:",$03,$1E," El Nino",$18,$02,$02,$02,$1A," Toxic Frog",$01
;  db "S: ",$05," Plasma",$18,$18,$18,$06,$1F," Surge",$00
;.dusk_requiem
;  db "T:",$03,$1E," Moonlight ",$18,$18,$1A," Wombat",$01
;  db "S: ",$05," Snare",$02,$02,$02,$02,$06,$1F," Cave In",$00
;.snowman_jazz
;  db "T:",$03,$1E," Blizzard",$18,$18,$18,$1A," Ice Rabbit",$01
;  db "S: ",$05," Surge",$02,$02,$02,$02,$06,$1F," Mirage",$00

warnpc $C4B520

;fractions
;2/3  $0F
;1/3  $10
      
;1/2  $11      
;3/4  $12
;5/8  $13
      
;1/16 $14      
;3/16 $15      
;5/16 $16      
;7/16 $17

;4/5  $1E
;1/5  $1A
;3/5  $05  
;2/5  $1F

;blanks
;$03  3 pixel
;$06  6 pixel
;$19  7 pixel
;$04  10 pixel
;$02  11 pixel
;$18  12 pixel
