arch 65816
hirom

table "menu.tbl",ltr
;bigrams and elemental icons legenda
;s 	    $E0
;le	    $E1
;al	    $E2
;in	    $E4
;at     $07
; - 	$0E
;et	    $E5
;] 	    $EC
;e 	    $E7
; d	    $EB
;g 	    $EE
;ta	    $F0
;re	    $F1
;ly	    $F2
;[S	    $F3
;d 	    $F4
;if	    $F5
; s	    $F7
;il	    $0C
;lt	    $09
;Holy	$F6
;Bolt   $F8
;Wind   $F9
;Earth  $FA
;Ice    $FB
;Fire   $FC
;Water  $FD
;Dark   $EF
;white magic dot 	$E8
;black magic dot	$E9
;gray magic dot		$EA
;lore icon			$E3

;-------------------------------
; Item descriptions
;-------------------------------

org $ED6400

HealingShiv:    db "The pointy end doe",$E0,"the healing",$00
MythrilDirk:    db "Knive",$E0,"allow a 2nd weapon|and can be used w/ [Throw]",$00
Kagenui:        db "[Fight] hit",$E0,"2x|May set [Stop]/[Slow]",$00
Butterfly:      db "2x dmg to humans",$00
Switchblade:    db "May steal from foe",$00
Demonsbane:     db "Undead-slayer",$00
ManEater:       db "2x dmg to humans",$00
Kunai:          db "",$00
Avenger:        db "Holy dmg",$00
Valiance:       db "Ignore",$E0,"defense|Stronger at low HP",$00
MythrilBolo:    db "",$00
IronCutlass:    db "",$00
Scimitar:       db "Dual-wield|May counterattack",$00
Flametongue:    db "Fire dmg|May cast ",$E9,"Fire 2",$00
Icebrand:       db "Ice dmg|May cast ",$E9,"Ice 2",$00
ElecSword:      db "Bolt dmg|May cast ",$E9,"Bolt 2",$00
Epee:           db "",$00
BreakBlade:     db "",$00
BloodSword:     db "May cast ",$E9,"Drain",$00
Imperial:       db "",$00
RuneBlade:      db "Use",$E0,"MP for critical hits",$00
Falchion:       db "Dual-wield|May counterattack",$00
SoulSabre:      db "May cast ",$EA,"Osmose",$00
Organix:        db "",$00
Excalibur:      db "Use",$E0,"MP for critical hits|Stronger in 2 hands",$00
Zantetsuken:    db "Alway",$E0,"hits, may counterattack|High crit rate, can insta-kill",$00
Illumina:       db "Use",$E0,"MP for critical hits|May cast ",$E9,"Holy",$00
Apocalypse:     db "Use",$E0,"MP for critical hits|May cast ",$E9,"Flare",$00
AtmaWeapon:     db "Attack",$E0,"w/ stamina|Weaker at low HP",$00
MythrilPike:    db "Spear",$E0,"are stronger in 2 hands|and user",$E0,"may guard allies",$00
Trident:        db "HP+12.5%|Water dmg",$00
StoutSpear:     db "HP+25%",$00
Partisan:       db "HP+25%",$00
Longinus:       db "HP+25%|Holy dmg",$00
FireLance:      db "HP+12.5%|Fire dmg",$00
Gungnir:        db "HP+50%|Alway",$E0,"hits",$00
PointyStick:    db "",$00
Tanto:          db "",$00
Kunai2:         db "Anti-air, high crit rate",$00
Sakura:         db "May cast ",$E9,"Break",$00
Ninjato:        db "Anti-air, high crit rate",$00
Kagenui2:       db "Ninja can wield",$00
Orochi:         db "Anti-air, high crit rate",$00
Hanzo:          db "Katana",$E0,"are stronger in 2 hands",$00
Kotetsu:        db "May counterattack",$00
Ichimonji:      db "High crit rate, can insta-kill",$00
Kazekiri:       db "May hit all foe",$E0,"with|stamina-based wind attack",$00
Murasame:       db "May counterattack",$00
Masamune:       db "May counterattack",$00
Spoon:          db "",$00
Mutsunokami:    db "Wind blade i",$E0,"most powerful",$00
SpookStick:     db "",$00
MythrilRod:     db "Rod",$E0,"use MP for critical dmg|and have high spellcast rate",$00
FireRod:        db "May cast ",$E9,"Fire 2|(MP crit = 2x spell dmg)",$00
IceRod:         db "May cast ",$E9,"Ice 2|(MP crit = 2x spell dmg)",$00
ThunderRod:     db "May cast ",$E9,"Bolt 2|(MP crit = 2x spell dmg)",$00
WindBreaker:    db "Wind hit",$E0,"with much stamina",$00
Doomstick:      db "May cast ",$E9,"Doom|(MP crit = X-Zone)",$00
Quartrstaff:    db "May cast ",$E9,"Quartr|(MP crit = hit",$E0,"foe group)",$00
Punisher:       db "May cast ",$E9,"Dark|(MP crit = 2x spell dmg)",$00
MagusRod:       db "",$00
LightBrush:     db "Brushe",$E0,"cure HP and hit 2x",$00
MonetBrush:     db "May cast ",$EA,"Safe",$00
DaliBrush:      db "May cast ",$EA,"Shell",$00
RossBrush:      db "May cast ",$EA,"Haste",$00
Shuriken:       db "Use w/ [Throw]|Can spread with L/R",$00
TackStar:       db "",$00
NinjaStar:      db "Strongest throw",$00
Club:           db "",$00
FullMoon:       db "Anti-air, high crit rate|Ignore",$E0,"row, dual-wield",$00
MorningStar:    db "2x dmg to humans|Ignore",$E0,"defense",$00
Boomerang:      db "Anti-air, high crit rate|Ignore",$E0,"row, dual-wield",$00
RisingSun:      db "Anti-air, high crit rate|Ignore",$E0,"row, dual-wield",$00
Kusarigama:     db "2x dmg to humans|May set [Stop]/[Slow]",$00
BoneClub:       db "",$00
MagicBone:      db "",$00
WingEdge:       db "Such wing, much edge",$00
Cards:          db "",$00
Darts:          db "Casino weapon",$E0,"ignore row",$00
Tarot:          db "Holy dmg, undead-slayer",$00
ViperDarts:     db "Use",$E0,"MP for critical hits",$00
Dice:           db "Dmg = (2Lv. * D1 * D2)|Alway",$E0,"hits",$00
FixedDice:      db "Dmg = (2Lv. * D1 * D2 * D3)|Alway",$E0,"hits",$00
MythrilClaw:    db "",$00
SpiritClaw:     db "HP+12.5%|Holy dmg, may cast ",$EA,"Slow",$00
PoisonClaw:     db "HP+12.5%|Dark dmg, may cast ",$E9,"Sap",$00
OceanClaw:      db "HP+25%|Water dmg, may cast ",$E9,"Drain",$00
HellClaw:       db "HP+25%|Fire dmg, may cast ",$E9,"Fire",$00
Frostgore:      db "HP+50%|Ice dmg, may cast ",$E9,"Ice",$00
Stormfang:      db "HP+50%|Bolt dmg, may cast ",$E9,"Bolt",$00
Buckler:        db "",$00
IronShield:     db "",$00
Targe:          db "",$00
GoldShield:     db "Halve",$E0,"Water dmg",$00
AegisShield:    db "Auto-Haste (Block",$E0,"[Slow])",$00
DiamondKite:    db "Halve",$E0,"Bolt dmg",$00
Flameguard:     db "Absorb",$E0,"Fire dmg",$00
Iceguard:       db "Absorb",$E0,"Ice dmg",$00
Thunderguard:   db "Absorb",$E0,"Bolt dmg",$00
CrystalKite:    db "Halve",$E0,"Wind dmg",$00
GenjiShield:    db "Auto-Safe",$00
Multiguard:     db "Block",$E0,"Fire/Ice/Bolt dmg",$00
CursedShield:   db "A horrible shield to have a curse",$00
HeroShield:     db "Auto-Regen (Block",$E0,"[Sap])",$00
ForceShield:    db "Auto-Shell",$00
LeatherHat:     db "",$00
HairBand:       db "",$00
PlumedHat:      db "",$00
NinjaMask:      db "May counterattack",$00
MagusHat:       db "MP+25%",$00
Bandana:        db "",$00
IronHelm:       db "",$00
SkullCap:       db "",$00
StatHat:        db "",$00
GreenBeret:     db "HP/MP+12.5%",$00
HeadBand:       db "",$00
MyhtrilHelm:    db "",$00
Tiara:          db "A pretty princes",$E0,"tiara",$00
GoldHelm:       db "Halve",$E0,"Water dmg",$00
TigerMask:      db "Halve",$E0,"Fire dmg",$00
RedCap:         db "HP/MP+25%",$00
MysteryVeil:    db "Sword spellcast rate up",$00
Circlet:        db "MP+50%",$00
DragonHelm:     db "[Jump] randomly hit",$E0,"2x",$00
DiamondHelm:    db "Halve",$E0,"Bolt dmg",$00
DarkHood:       db "",$00
CrystalHelm:    db "Halve",$E0,"Wind dmg",$00
OathVeil:       db "Sword spellcast rate up",$00
CatHood:        db "",$00
GenjiHelm:      db "",$00
Thornlet:       db "",$00
Titanium:       db "",$00
HardLeather:    db "",$00
CottonRobe:     db "",$00
KarateGi:       db "",$00
IronArmor:      db "",$00
SilkRobe:       db "",$00
MythrilVest:    db "",$00
NinjaGear:      db "",$00
WhiteDress:     db "",$00
MythrilMail:    db "",$00
GaiaGear:       db "Halve",$E0,"Earth dmg",$00
MirageVest:     db "Auto-Haste (Block",$E0,"[Slow])",$00
GoldArmor:      db "Halve",$E0,"Water dmg",$00
PowerArmor:     db "",$00
LightRobe:      db "",$00
DiamondVest:    db "Halve",$E0,"Bolt dmg",$00
RoyalJacket:    db "Auto-Safe|Spellcast rate up",$00
ForceArmor:     db "Halve",$E0,"Fire/Ice/Bolt dmg",$00
DiamondMail:    db "Halve",$E0,"Bolt dmg",$00
DarkGear:       db "",$00
TaoRobe:        db "",$00
CrystalMail:    db "Halve",$E0,"Wind dmg",$00
RadiantGown:    db "Auto-Shell|Brush spellcast rate up",$00
GenjiArmor:     db "",$00
LazyShell:      db "Halve",$E0,"Bolt/Wind dmg",$00
Minerva:        db "Block",$E0,"Fire/Ice/Bolt dmg",$00
TabbyHide:      db "Halve",$E0,"Earth dmg",$00
GatorHide:      db "Halve",$E0,"Water dmg",$00
ChocoboHide:    db "Halve",$E0,"Water/Wind dmg",$00
MoogleHide:     db "Halve",$E0,"Earth/Wind dmg",$00
DragonHide:     db "Halve",$E0,"Fire/Wind dmg",$00
SnowMuffler:    db "Block",$E0,"Ice/Wind dmg|HP+25%",$00
Noiseblaster:   db "May set [Muddle]",$0E,"foe group|Fail by stamina",$00
BioBlaster:     db "Dark dmg",$0E,"foe group|Set",$E0,"[Poison]",$00
Flash:          db "Non-elemental dmg",$0E,"foe group|Set",$E0,"[Blind]",$00
Chainsaw:       db "Thi",$E0,"i",$E0,"not a drill|Ignore",$E0,"def., randomly kills",$00
Defibrillator:  db "[CLEAR!]|Revive",$E0,"fallen ally",$00
Drill:          db "Thi",$E0,"i",$E0,"a drill|Ignore",$E0,"def., set",$E0,"[Sap]",$00
ManaBattery:    db "It keep",$E0,"going and going_|Cure",$E0,"MP - one ally",$00
Autocrossbow:   db "Physical attack",$0E,"foe group|Ignore",$E0,"row, can miss",$00
FireScroll:     db "(Split) Fire dmg",$0E,"all foes|Use w/ [Throw]",$00
WaveScroll:     db "(Split) Water dmg",$0E,"all foes|Use w/ [Throw]",$00
BoltScroll:     db "(Split) Bolt dmg",$0E,"all foes|Use w/ [Throw]",$00
InvizScroll:    db "Ninja vanish!",$00
SmokeBomb:      db "Set",$E0,"[Image]",$0E,"one ally|Use w/ [Throw]",$00
LeoCrest:       db $E6,$00
Bracelet:       db "Block",$E0,"[Poison]",$00
SpiritStone:    db "Block",$E0,"[Blind]/[Poison]/[Petrify]",$00
Amulet:         db "Block",$E0,"[Sleep]/[Muddle]/[Berserk]",$00
WhiteCape:      db "Block",$E0,"[Imp]/[Mute]/[Stop]",$00
Talisman:       db "Block",$E0,"[Blind]/[Poison]",$00
FairyCharm:     db "Block",$E0,"[Sleep]/[Muddle]",$00
BarrierCube:    db "Set",$E0,"[Shell] on low HP",$00
SafetyGlove:    db "Set",$E0,"[Safe] on low HP",$00
GuardRing:      db "Auto-Safe",$00
SprintShoes:    db "Auto-Haste (Block",$E0,"[Slow])",$00
ReflectRing:    db "Auto-Reflect",$00
-:              db "",$00
GumPod:         db "",$00
KnightCape:     db "HP+12.5%|May guard allies",$00
DragoonSeal:    db "[Fight] to [Jump]|Sword spellcast rate up",$00
ZephyrCape:     db "Set",$E0,"[Haste] on low HP",$00
MysteryEgg:     db "It'",$E0,"a mystery_",$00
BlackHeart:     db "HP+50%",$00
MagicCube:      db "MP+50%",$00
PowerGlove:     db "Physical output +25%|(It'",$E0,"so bad)",$00
BlizzardOrb:    db "Magical output +25%|(??? on yeti)",$00
PsichoBelt:     db "Physical output +25%|(??? on yeti)",$00
RogueCloak:     db "[Fight] alway",$E0,"hits|Magical output +25%",$00
WallRing:       db "Auto-Shell",$00
HeroRing:       db "HP/MP+25%|May guard allies",$00
Ribbon:         db "Block",$E0,"[Stop]/[Petrify]/Death|(Death include",$E0,"[Zombie])",$00
MuscleBelt:     db "HP+25%|Physical output +25%",$00
CrystalOrb:     db "MP+25%|Magical output +25%",$00
Goggles:        db "Block",$E0,"[Blind]",$00
SoulBox:        db "MP cost",$E0,"= 1/2",$00
ThiefGlove:     db "[Steal] to [Mug]|Physical dmg +25%",$00
Gauntlet2:      db "",$00
GenjiGlove:     db "",$00
HyperWrist:     db "Auto-Berserk",$00
Offering:       db "",$00
Beads:          db "",$00
ExBlack:        db "",$00
HeijiCoin:      db "[Slot] to [GP Toss]",$00
SageStone:      db "[Magic] to [X-Magic]",$00
GemBox:         db "MP cost",$E0,"= 1/2",$00
NirvanaBand:    db "All output +25%",$00
Economizer:     db "MP cost",$E0,"= 1",$00
MementoRing:    db "That i",$E0,"not dead|Which can rise again",$00
QuartzCharm:    db "Auto-Safe/Shell",$00
GhostRing:      db "Make",$E0,"wearer undead",$00
MoogleCharm:    db "Dance like the wind|Fall like a stone",$00
BlackBelt:      db "[Fight] alway",$E0,"hits|May counterattack",$00
Codpiece:       db "",$00
BackGuard:      db "Prevent",$E0,"ambushes",$00
GaleHairpin:    db "Pre-emptive attack rate up",$00
StatStick:      db "HP/MP+12.5%",$00
DarylSoul:      db "[Fight] hit",$E0,"2x",$00
LifeBell:       db "Auto-Regen (Block",$E0,"[Sap])",$00
DirtyUndies:    db "",$00
RenameCard:     db "Hidden item",$00
Tonic:          db "Cure",$E0,"1/2 Max HP",$00
Potion:         db "Cure",$E0,"3/4 Max HP",$00
XPotion:        db "Cure",$E0,"3/4 Max HP",$0E,"party",$00
Tincture:       db "Cure",$E0,"50 MP",$00
Ether:          db "Cure",$E0,"3/4 Max MP",$00
XEther:         db "Cure",$E0,"3/4 Max MP",$0E,"party",$00
Elixir:         db "Cure",$E0,"HP/MP to max|Lift",$E0,"most bad statuses",$00
Megalixir:      db "Full heal (HP/MP/status)",$0E,"party",$00
PhoenixDown:    db "Revive",$E0,"fallen ally|(HP = 1)",$00
HolyWater:      db "Cure",$E0,"[Zombie]|(HP = 1/8 max)",$00
Antidote:       db "Cure",$E0,"[Poison]",$00
Eyedrops:       db "Cure",$E0,"[Blind]",$00
SnakeOil:       db "All-Natural",$00
Remedy:         db "Lift",$E0,"most bad statuses",$00
Scrap:          db "Sell for GP",$00
Tent:           db "",$00
GreenCherry:    db "Ha",$E0,"a calming effect",$00
PhoenixTear:    db "Revive",$E0,"fallen ally|(HP = 3/4 max)",$00
BouncyBall:     db "Do not taunt Happy Fun Ball",$00
RedBull:        db "Cure",$E0,"200 HP",$00
SlimJim:        db "Snap into it!",$00
WarpWhistle:    db "Welcome to Warp Zone",$00
DriedMeat:      db "Cure",$E0,"100 HP",$00
DontFuck:       db "",$00

warnpc $ED779F

org $ED7AA0

dw HealingShiv-HealingShiv
dw MythrilDirk-HealingShiv
dw Kagenui-HealingShiv
dw Butterfly-HealingShiv
dw Switchblade-HealingShiv
dw Demonsbane-HealingShiv
dw ManEater-HealingShiv
dw Kunai-HealingShiv
dw Avenger-HealingShiv
dw Valiance-HealingShiv
dw MythrilBolo-HealingShiv
dw IronCutlass-HealingShiv
dw Scimitar-HealingShiv
dw Flametongue-HealingShiv
dw Icebrand-HealingShiv
dw ElecSword-HealingShiv
dw Epee-HealingShiv
dw BreakBlade-HealingShiv
dw BloodSword-HealingShiv
dw Imperial-HealingShiv
dw RuneBlade-HealingShiv
dw Falchion-HealingShiv
dw SoulSabre-HealingShiv
dw Organix-HealingShiv
dw Excalibur-HealingShiv
dw Zantetsuken-HealingShiv
dw Illumina-HealingShiv
dw Apocalypse-HealingShiv
dw AtmaWeapon-HealingShiv
dw MythrilPike-HealingShiv
dw Trident-HealingShiv
dw StoutSpear-HealingShiv
dw Partisan-HealingShiv
dw Longinus-HealingShiv
dw FireLance-HealingShiv
dw Gungnir-HealingShiv
dw PointyStick-HealingShiv
dw Tanto-HealingShiv
dw Kunai2-HealingShiv
dw Sakura-HealingShiv
dw Ninjato-HealingShiv
dw Kagenui2-HealingShiv
dw Orochi-HealingShiv
dw Hanzo-HealingShiv
dw Kotetsu-HealingShiv
dw Ichimonji-HealingShiv
dw Kazekiri-HealingShiv
dw Murasame-HealingShiv
dw Masamune-HealingShiv
dw Spoon-HealingShiv
dw Mutsunokami-HealingShiv
dw SpookStick-HealingShiv
dw MythrilRod-HealingShiv
dw FireRod-HealingShiv
dw IceRod-HealingShiv
dw ThunderRod-HealingShiv
dw WindBreaker-HealingShiv
dw Doomstick-HealingShiv
dw Quartrstaff-HealingShiv
dw Punisher-HealingShiv
dw MagusRod-HealingShiv
dw LightBrush-HealingShiv
dw MonetBrush-HealingShiv
dw DaliBrush-HealingShiv
dw RossBrush-HealingShiv
dw Shuriken-HealingShiv
dw TackStar-HealingShiv
dw NinjaStar-HealingShiv
dw Club-HealingShiv
dw FullMoon-HealingShiv
dw MorningStar-HealingShiv
dw Boomerang-HealingShiv
dw RisingSun-HealingShiv
dw Kusarigama-HealingShiv
dw BoneClub-HealingShiv
dw MagicBone-HealingShiv
dw WingEdge-HealingShiv
dw Cards-HealingShiv
dw Darts-HealingShiv
dw Tarot-HealingShiv
dw ViperDarts-HealingShiv
dw Dice-HealingShiv
dw FixedDice-HealingShiv
dw MythrilClaw-HealingShiv
dw SpiritClaw-HealingShiv
dw PoisonClaw-HealingShiv
dw OceanClaw-HealingShiv
dw HellClaw-HealingShiv
dw Frostgore-HealingShiv
dw Stormfang-HealingShiv
dw Buckler-HealingShiv
dw IronShield-HealingShiv
dw Targe-HealingShiv
dw GoldShield-HealingShiv
dw AegisShield-HealingShiv
dw DiamondKite-HealingShiv
dw Flameguard-HealingShiv
dw Iceguard-HealingShiv
dw Thunderguard-HealingShiv
dw CrystalKite-HealingShiv
dw GenjiShield-HealingShiv
dw Multiguard-HealingShiv
dw CursedShield-HealingShiv
dw HeroShield-HealingShiv
dw ForceShield-HealingShiv
dw LeatherHat-HealingShiv
dw HairBand-HealingShiv
dw PlumedHat-HealingShiv
dw NinjaMask-HealingShiv
dw MagusHat-HealingShiv
dw Bandana-HealingShiv
dw IronHelm-HealingShiv
dw SkullCap-HealingShiv
dw StatHat-HealingShiv
dw GreenBeret-HealingShiv
dw HeadBand-HealingShiv
dw MyhtrilHelm-HealingShiv
dw Tiara-HealingShiv
dw GoldHelm-HealingShiv
dw TigerMask-HealingShiv
dw RedCap-HealingShiv
dw MysteryVeil-HealingShiv
dw Circlet-HealingShiv
dw DragonHelm-HealingShiv
dw DiamondHelm-HealingShiv
dw DarkHood-HealingShiv
dw CrystalHelm-HealingShiv
dw OathVeil-HealingShiv
dw CatHood-HealingShiv
dw GenjiHelm-HealingShiv
dw Thornlet-HealingShiv
dw Titanium-HealingShiv
dw HardLeather-HealingShiv
dw CottonRobe-HealingShiv
dw KarateGi-HealingShiv
dw IronArmor-HealingShiv
dw SilkRobe-HealingShiv
dw MythrilVest-HealingShiv
dw NinjaGear-HealingShiv
dw WhiteDress-HealingShiv
dw MythrilMail-HealingShiv
dw GaiaGear-HealingShiv
dw MirageVest-HealingShiv
dw GoldArmor-HealingShiv
dw PowerArmor-HealingShiv
dw LightRobe-HealingShiv
dw DiamondVest-HealingShiv
dw RoyalJacket-HealingShiv
dw ForceArmor-HealingShiv
dw DiamondMail-HealingShiv
dw DarkGear-HealingShiv
dw TaoRobe-HealingShiv
dw CrystalMail-HealingShiv
dw RadiantGown-HealingShiv
dw GenjiArmor-HealingShiv
dw LazyShell-HealingShiv
dw Minerva-HealingShiv
dw TabbyHide-HealingShiv
dw GatorHide-HealingShiv
dw ChocoboHide-HealingShiv
dw MoogleHide-HealingShiv
dw DragonHide-HealingShiv
dw SnowMuffler-HealingShiv
dw Noiseblaster-HealingShiv
dw BioBlaster-HealingShiv
dw Flash-HealingShiv
dw Chainsaw-HealingShiv
dw Defibrillator-HealingShiv
dw Drill-HealingShiv
dw ManaBattery-HealingShiv
dw Autocrossbow-HealingShiv
dw FireScroll-HealingShiv
dw WaveScroll-HealingShiv
dw BoltScroll-HealingShiv
dw InvizScroll-HealingShiv
dw SmokeBomb-HealingShiv
dw LeoCrest-HealingShiv
dw Bracelet-HealingShiv
dw SpiritStone-HealingShiv
dw Amulet-HealingShiv
dw WhiteCape-HealingShiv
dw Talisman-HealingShiv
dw FairyCharm-HealingShiv
dw BarrierCube-HealingShiv
dw SafetyGlove-HealingShiv
dw GuardRing-HealingShiv
dw SprintShoes-HealingShiv
dw ReflectRing-HealingShiv
dw --HealingShiv
dw GumPod-HealingShiv
dw KnightCape-HealingShiv
dw DragoonSeal-HealingShiv
dw ZephyrCape-HealingShiv
dw MysteryEgg-HealingShiv
dw BlackHeart-HealingShiv
dw MagicCube-HealingShiv
dw PowerGlove-HealingShiv
dw BlizzardOrb-HealingShiv
dw PsichoBelt-HealingShiv
dw RogueCloak-HealingShiv
dw WallRing-HealingShiv
dw HeroRing-HealingShiv
dw Ribbon-HealingShiv
dw MuscleBelt-HealingShiv
dw CrystalOrb-HealingShiv
dw Goggles-HealingShiv
dw SoulBox-HealingShiv
dw ThiefGlove-HealingShiv
dw Gauntlet2-HealingShiv
dw GenjiGlove-HealingShiv
dw HyperWrist-HealingShiv
dw Offering-HealingShiv
dw Beads-HealingShiv
dw ExBlack-HealingShiv
dw HeijiCoin-HealingShiv
dw SageStone-HealingShiv
dw GemBox-HealingShiv
dw NirvanaBand-HealingShiv
dw Economizer-HealingShiv
dw MementoRing-HealingShiv
dw QuartzCharm-HealingShiv
dw GhostRing-HealingShiv
dw MoogleCharm-HealingShiv
dw BlackBelt-HealingShiv
dw Codpiece-HealingShiv
dw BackGuard-HealingShiv
dw GaleHairpin-HealingShiv
dw StatStick-HealingShiv
dw DarylSoul-HealingShiv
dw LifeBell-HealingShiv
dw DirtyUndies-HealingShiv
dw RenameCard-HealingShiv
dw Tonic-HealingShiv
dw Potion-HealingShiv
dw XPotion-HealingShiv
dw Tincture-HealingShiv
dw Ether-HealingShiv
dw XEther-HealingShiv
dw Elixir-HealingShiv
dw Megalixir-HealingShiv
dw PhoenixDown-HealingShiv
dw HolyWater-HealingShiv
dw Antidote-HealingShiv
dw Eyedrops-HealingShiv
dw SnakeOil-HealingShiv
dw Remedy-HealingShiv
dw Scrap-HealingShiv
dw Tent-HealingShiv
dw GreenCherry-HealingShiv
dw PhoenixTear-HealingShiv
dw BouncyBall-HealingShiv
dw RedBull-HealingShiv
dw SlimJim-HealingShiv
dw WarpWhistle-HealingShiv
dw DriedMeat-HealingShiv
dw DontFuck-HealingShiv

;------------------------------------------------------------------
;Rare items descriptions
;------------------------------------------------------------------

org $CEFCB0

Cider:
    db "Cider made from deliciou",$E0,"fruit",$00
ClockKey:
    db "Useful if your clock lock",$E0,"up",$00
TastyFish:
    db "A tasty fish",$00
JustFish:
    db "Just a fish",$00
Fish:
    db "Fish",$00
RottenFish:
    db "A rotten fish",$00
Guilt:
    db "It'",$E0,"heavy with the weight of|murdered family and friends",$00
LolaLetter:
    db "Rather explicit, to say the least",$00
Booty:
    db "Yar, it be the booty of a pirate",$00
Filth:
    db "[The Adventure",$E0,"of Mr. Tentacle and| the Naughty Schoolgirl]",$00
EmperorMap:
    db "Show thi",$E0,"to the old man",$00
WD40:
    db "Fixe",$E0,"anything that can't be fixed|with duct tape",$00
Schematics:
    db "Autocrossbow:|Power +50%, Accuracy = 100%",$00
BettingChips:
    db "These look like somebody tried|to eat them_",$00
Blank1: db $00
Blank2: db $00
CrackedStone:
    db "Thi",$E0,"i",$E0,"why we can't have nice|things_",$00
LeoSpirits:
    db "A bottle of Leo'",$E0,"favorite booze",$00
Blank3: db $00
Pendant:
    db "Some thing",$E0,"you",$03,"just can't get rid of_",$00

warnpc $CEFFFF

org $CEFB60

    dw Cider-Cider
    dw ClockKey-Cider
    dw TastyFish-Cider
    dw JustFish-Cider
    dw Fish-Cider
    dw RottenFish-Cider
    dw Guilt-Cider
    dw LolaLetter-Cider
    dw Booty-Cider
    dw Filth-Cider
    dw EmperorMap-Cider
    dw WD40-Cider
    dw Schematics-Cider
    dw BettingChips-Cider
    dw Blank1-Cider
    dw Blank2-Cider
    dw CrackedStone-Cider
    dw LeoSpirits-Cider
    dw Blank3-Cider
    dw Pendant-Cider

;---------------------------------------
;Spells descriptions
;---------------------------------------

org $D8C9A0

Fire: db $FC,$00
Ice: db $FB,$00
Bolt: db $F8,$00
Sap: db $EF," S",$E5,$E0,$F3,"ap]|Periodic",$EB,"mg, l",$F5,"t",$E0,"[Regen",$EC,$00 ; Dark Sets "Sap", periodic dmg, lifts "Regen"
Poison: db $EF," S",$E5,$E0,"[Poison",$EC,"|Ris",$E4,$EE,"periodic",$EB,"mg",$00 ; Dark Sets "Poison"|Rising periodic dmg
Fire2: db $FC,$FC,$00
Ice2: db $FB,$FB,$00
Bolt2: db $F8,$F8,$00
Break: db $F9," Igno",$F1,$E0,"def.",$00 ; Wind Ignores def.
Fire3: db $FC,$FC,$FC,$00
Ice3: db $FB,$FB,$FB,$00
Bolt3: db $F8,$F8,$F8,$00
Quake: db $FA," Igno",$F1,$E0,"def., groun",$F4,$07,$F0,"ck",$00 ; Earth Ignores def., ground attack
Doom: db "Ins",$F0,"nt",$EB,"e",$07,"h (he",$E2,$E0,"undead)|Fa",$0C," by",$F7,$F0,"m",$E4,"a",$00; Instant death|Heals undead
Holy: db $F6," Igno",$F1,$E0,"def.",$00 ; Holy Ignores def.
Flare: db "Non-e",$E1,"ment",$E2,$EB,"mg|Igno",$F1,$E0,"def.",$00 ; Non-elemental dmg|Ignores def.
Dark: db $EF,$00 ; Dark
Storm: db $F9,"/",$FD,$00 ; Wind/Water
XZone: db "Ins",$F0,"nt",$EB,"e",$07,"h|Fa",$0C," by",$F7,$F0,"m",$E4,"a",$00 ; Instant death
Meteor: db "Non-e",$E1,"ment",$E2,$EB,"mg",$00 ; Non-elemental dmg
Ultima: db "U",$09,"im",$07,$E7,"magic ",$07,$F0,"ck",$00 ; Ultimate Magic Attack
Merton: db $FC,"/",$EF,$00 ; Fire/Dark
Demi: db $FA," (HP * ",$11,")|Fa",$0C," by",$F7,$F0,"m",$E4,"a",$00 ; Earth (HP * 1/2)
Quartr: db $FA," (HP * ",$12,")|Fa",$0C," by",$F7,$F0,"m",$E4,"a",$00; Earth (HP * 3/4)
Drain: db "Ste",$E2,$E0,"HP|hitr",$07,$E7,"= 90%",$00 ; Steals HP
Osmose: db "Ste",$E2,$E0,"MP|hitr",$07,$E7,"= 90%",$00 ; Steals MP
Rasp: db "MP",$EB,"mg|Fa",$0C," by",$F7,$F0,"m",$E4,"a",$00 ; MP dmg
Muddle: db "S",$E5,$E0,"[Mudd",$E1,"], fa",$0C," by",$F7,$F0,"m",$E4,"a|At",$F0,"ck random ",$E2,"lie",$E0,"unt",$0C," phys. hit",$00 ; Sets "Muddle"|Attack random allies until phys. hit
Mute: db "S",$E5,$E0,"[Mute], fa",$0C," by",$F7,$F0,"m",$E4,"a|Can't",$EB,"o anyth",$E4,$EE,"th",$07," cost",$E0,"MP",$00; Sets "Mute"|Can't do anything that costs MP
Sleep: db "S",$E5,$E0,$F3,$E1,"ep], fa",$0C," by",$F7,$F0,"m",$E4,"a|Inactiv",$E7,"unt",$0C,$03,"phys.",$03,"hit",$03,"or",$03,"it wear",$E0,"off",$00 ; Sets "Sleep"|Inactive until phys. hit or it wears off
SleepX: db "S",$E5,$E0,$F3,$E1,"ep]|Fa",$0C," by",$F7,$F0,"m",$E4,"a",$00 ; Sets "Sleep"
Imp: db "S",$E5,"s/l",$F5,"t",$E0,"[Imp]|Dm",$EE,"an",$F4,"he",$E2,$E4,$EE,"output h",$E2,"ved",$00 ; Sets/lifts "Imp"|Dmg and healing output halved
Bserk: db "S",$E5,$E0,"[Berserk]|Phys.",$EB,"m",$EE,"up, becom",$E7,"uncontrollab",$E1,$00 ; Sets "Berserk"|Phys. dmg up, become uncontrollable
Stop: db "S",$E5,$E0,$F3,"top], fa",$0C," by",$F7,$F0,"m",$E4,"a|Can't mov",$E7,"for a brief time",$00 ; Sets "Stop"|Can't move for a brief time
Safe: db "S",$E5,$E0,$F3,"afe]|Reduc",$E7,"physic",$E2,$EB,"m",$EE,$F0,"ken",$00 ; Sets "Safe"|Reduce physical dmg taken
Shell: db "S",$E5,$E0,$F3,"hell",$EC,"|Reduc",$E7,"magic",$E2,$EB,"m",$EE,$F0,"ken",$00 ; Sets "Shell"|Reduce magical dmg taken
Haste: db "S",$E5,$E0,"[Haste]|Spee",$F4,"up, l",$F5,"t",$E0,$F3,"low]",$00 ; Sets "Haste"|Speed up, lifts "Slow"
HasteX: db "S",$E5,$E0,"[Haste]",$00 ; Sets "Haste"
Slow: db "S",$E5,$E0,$F3,"low], fa",$0C," by",$F7,$F0,"m",$E4,"a|Speed",$EB,"own, l",$F5,"t",$E0,"[Haste]",$00 ; Sets "Slow"|Speed down, lifts "Haste"
SlowX: db "S",$E5,$E0,$F3,"low]|Fa",$0C," by",$F7,$F0,"m",$E4,"a",$00 ; Sets "Slow"
Rflect: db "S",$E5,$E0,"[Ref",$E1,"ct]|Repel",$E0,"s",$E4,"g",$E1," an",$F4,"f",$F1,"e-",$F0,"rg",$E5," magic",$00 ; Sets "Reflect"|Repels single and free-target magic
Float: db "S",$E5,$E0,"[Flo",$07,"]|Block",$E0,"groun",$F4,$07,$F0,"cks",$00 ; Sets "Float"|Blocks ground attacks
Warp: db "Go to Worl",$F4,"9",$00
Scan: db "Display",$E0,"HP/MP, activ",$E7,"st",$07,"uses|an",$F4,"e",$E1,"ment",$E2," weaknesses",$00
Dispel: db "L",$F5,"t",$E0,"positiv",$E7,"s",$F0,"tuses",$00 ; Lifts positive statuses
Cure: db "Cu",$F1,$E0,"HP|",$F6,$EB,"m",$EE,"to undead",$00; Cures HP|Holy dmg to undead
Cure2: db "Cu",$F1,$E0,"HP|",$F6,$F6,$00
Cure3: db "Cu",$F1,$E0,"HP|",$F6,$F6,$F6,$00
Life: db "Revive",$E0,"f",$E2,$E1,"n ",$E2,$F2,"|(HP = 250~500)",$00 ; Revives fallen ally|(HP = 250~500)
Life2: db "Revive",$E0,"f",$E2,$E1,"n ",$E2,$F2,"|(HP = max)",$00 ; Revives fallen ally|HP = max
Rerise: db "S",$E5,$E0,"[Rerise]|Cast",$E0,$E8,"L",$F5,$E7,"upon",$EB,"e",$07,"h",$00; Sets "Rerise"|Casts ○Life upon death
GRemedy: db "Cu",$F1,$E0,"HP (s",$F0,"m",$E4,"a-based)|L",$F5,"t",$E0,"most ba",$F4,"s",$F0,"tuses",$00 ; Cures HP (stamina-based)|Lifts most bad statuses
Regen: db "S",$E5,$E0,"[Regen]; periodic he",$E2,", l",$F5,"t",$E0,"[Sap]|Cu",$F1,$E0,"HP (s",$F0,"m",$E4,"a-based)",$00 ; Cures HP (stamina-based)|Sets "Regen" (periodic heal; lifts Sap)
RegenX: db "S",$E5,$E0,"[Regen]|Cu",$F1,$E0,"HP (s",$F0,"m",$E4,"a-based)",$00 ; Cures HP (stamina-based)|Sets "Regen"

warnpc $D8CE9F

org $D8CF80

	dw Fire-Fire
	dw Ice-Fire
	dw Bolt-Fire
	dw Sap-Fire
	dw Poison-Fire
	dw Fire2-Fire
	dw Ice2-Fire
	dw Bolt2-Fire
	dw Break-Fire
	dw Fire3-Fire
	dw Ice3-Fire
	dw Bolt3-Fire
	dw Quake-Fire
	dw Doom-Fire
	dw Holy-Fire
	dw Flare-Fire
	dw Dark-Fire
	dw Storm-Fire
	dw XZone-Fire
	dw Meteor-Fire
	dw Ultima-Fire
	dw Merton-Fire
	dw Demi-Fire
	dw Quartr-Fire
	dw Drain-Fire
	dw Osmose-Fire
	dw Rasp-Fire
	dw Muddle-Fire
	dw Mute-Fire
	dw Sleep-Fire
	dw SleepX-Fire
	dw Imp-Fire
	dw Bserk-Fire
	dw Stop-Fire
	dw Safe-Fire
	dw Shell-Fire
	dw Haste-Fire
	dw HasteX-Fire
	dw Slow-Fire
	dw SlowX-Fire
	dw Rflect-Fire
	dw Float-Fire
	dw Warp-Fire
	dw Scan-Fire
	dw Dispel-Fire
	dw Cure-Fire
	dw Cure2-Fire
	dw Cure3-Fire
	dw Life-Fire
	dw Life2-Fire
	dw Rerise-Fire
	dw GRemedy-Fire
	dw Regen-Fire
	dw RegenX-Fire

;---------------------------------------
;Blitz descriptions
;---------------------------------------

org $CFFC00

Pummel:
	db "Physical attack (ignore",$E0,"def.)|Set",$E0,"[Sap]",$00
Suplex:
	db "Physical attack (ignore",$E0,"def.)|May set [Stop]",$00
Aurabolt:
	db $F6," (stamina-based)|Row affect",$E0,"dmg",$00
FireDance:
	db $FC,$00
Mantra:
	db "Cure",$E0,"HP (stamina-based)|Weaker at low HP",$00
Chakra:
	db "Cure",$E0,"MP (stamina-based)",$00
SonicBoom:
	db $F9," (stamina-based)",$00
BumRush:
	db "Punch hard (ignore",$E0,"def.)",$00

warnpc $CFFCFF

org $CFFF9E

	dw Pummel-Pummel
	dw Suplex-Pummel
	dw Aurabolt-Pummel
	dw FireDance-Pummel
	dw Mantra-Pummel
	dw Chakra-Pummel
	dw SonicBoom-Pummel
	dw BumRush-Pummel

;---------------------------------------
;Bushido descriptions
;---------------------------------------

org $CFFD00

Dispatch:
	db "Physic",$E2," attack (ignore",$E0,"def.)|2x",$EB,"mg to humans",$00
Mindblow:
	db "500 MP",$EB,"mg",$00
Empowerer:
	db "Ste",$E2,$E0,"HP/MP, row affects",$EB,"mg|Effective v",$E0,"undead, s",$E5,$E0,$F3,"ap]",$00
Flurry:
	db "4 physic",$E2," attacks|May",$F7,$E5," [Muddle]",$00
Dragon:
	db "Stamina-based, ignore",$E0,"def.|May",$F7,$E5," [Petrify]",$00
Eclipse:
	db "Non-e",$E1,"mental",$EB,"mg|S",$E5,$E0,"[Blind]",$00
Tempest:
	db "4 physical attacks",$00
Cleave:
	db "Instant",$EB,"eath|Can miss",$00

warnpc $CFFE00

org $CFFFAE

	dw Dispatch-Dispatch
	dw Mindblow-Dispatch
	dw Empowerer-Dispatch
	dw Flurry-Dispatch
	dw Dragon-Dispatch
	dw Eclipse-Dispatch
	dw Tempest-Dispatch
	dw Cleave-Dispatch

;---------------------------------------
;Lore descriptions
;---------------------------------------

org $ED77A0

Aqualung:
	db $FD,$00
BadBreath:
	db "Set",$E0,"[Poison]/[Blind]/[Mute]|Fail by stamina",$00
BlackOmen:
	db "Non-elemental dmg|Ignore",$E0,"def.",$00
Blaze:
	db $FC,"/",$F9,", may set [Blind]/[Sap]",$00
BlowFish:
	db "Physical dmg = 1000",$00
Discord:
	db "Set",$E0,"[Muddle]/[Berserk]|Unreflectable, fail by stamina",$00
HolyWind:
	db "Cure",$E0,"HP|Amount healed = caster'",$E0,"(current) HP",$00
Raid:
	db "Steal HP/MP, fail by stamina|Ignore",$E0,"def., unreflectable",$00
Raze:
	db $FC,"/",$F9,", may set [Sap]",$00
Refract:
	db "Set",$E0,"[Reflect]/[Image]|Unreflectable",$00
Shield:
	db "Set",$E0,"[Safe]",$00
Tsunami:
	db $FD,$FD,$FD,$00

warnpc $ED7A6F

org $ED7A70

	dw Aqualung-Aqualung
	dw BadBreath-Aqualung
	dw BlackOmen-Aqualung
	dw Blaze-Aqualung
	dw BlowFish-Aqualung
	dw Discord-Aqualung
	dw HolyWind-Aqualung
	dw Raid-Aqualung
	dw Raze-Aqualung
	dw Refract-Aqualung
	dw Shield-Aqualung
	dw Tsunami-Aqualung

;----------------------------------------------
; Summons descriptions
;----------------------------------------------

org $C38777
  LDX #EsperDescPointers

org $C38780
  LDA #$CB

org $C358B9
  JSL InitEsperDataSlice

!freeXL = $CB52FC     ; big ol' chunk of freespace :D

org !freeXL

InitEsperDataSlice:
  LDA #$10            ; Reset/Stop desc
  TSB $45             ; Set menu flag
  LDA $49             ; Top BG1 write row
  STA $5F             ; Save for return
  RTL

EsperDescPointers:
  dw Ramuh
  dw Ifrit
  dw Shiva
  dw Siren
  dw Terrato
  dw Shoat
  dw Maduin
  dw Bismark
  dw Stray
  dw Palidor
  dw Tritoch
  dw Odin
  dw Loki
  dw Bahamut
  dw Crusader
  dw Ragnarok
  dw Alexandr
  dw Kirin
  dw Zoneseek
  dw Carbunkl
  dw Phantom
  dw Seraph
  dw Golem
  dw Unicorn
  dw Fenrir
  dw Starlet
  dw Phoenix

Ramuh: db "Judgement:|",$F8," (",$11,$EB,"mg on multi-target)",$00
Ifrit: db "Inferno:|",$FC," (",$11,$EB,"mg on multi-target)",$00
Shiva: db "Gem Dust:|",$FB," (",$11,$EB,"mg on multi-target)",$00
Siren: db "Siren Song:Set",$E0,"[Muddle]/[Berserk]|Fail by stamina",$00
Terrato: db "Earth Rage:|",$FA," (",$11,$EB,"mg on multi-target)",$00
Shoat: db "Hurricane:|Set",$E0,"[Petrify",$EC,"(low hit%)",$00
Maduin: db "Chao",$E0,"Wing:|",$F9," Ignore",$E0,"def.",$00
Bismark: db "Sea Song:|",$FD," (",$11,$EB,"mg on multi-target)",$00
Stray: db "Cait Sith:Set",$E0,"[Regen]|Cure",$E0,"HP (stamina-based)",$00
Palidor: db "Air Raid:|Party attack",$E0,"w/ [Jump]",$00
Tritoch: db "Trisection:|",$FC,"/",$FB,"/",$F8," (",$11,$EB,"mg on multi-target)",$00
Odin: db "Atom Edge:|Stamina-based",$EB,"mg, ignore",$E0,"def.",$00
Loki: db $00
Bahamut: db "Mega Flare:|Non-elemental",$EB,"mg, ignore",$E0,"def.",$00
Crusader: db "Jihad:|",$EF," (",$11,$EB,"mg on multi-target)",$00
Ragnarok: db "Oblivion:|Non-elemental",$EB,"mg = 9999",$00
Alexandr: db "Justice:|",$F6," (",$11,$EB,"mg on multi-target)",$00
Kirin: db "Lif",$E7,"Force:|Cure",$E0,"HP, revive",$E0,"allies",$00
Zoneseek: db "Light Wall:|Set",$E0,$F3,"hell]",$00
Carbunkl: db "Ruby Blast:|Set",$E0,"[Reflect]",$00
Phantom: db "Fader:Set",$E0,"[Clear]|100% physical, 0% magical evasion",$00
Seraph: db "Lifeline:|Set",$E0,"[Rerise]",$00
Golem: db "Earth Wall:Block",$E0,"physical",$EB,"mg|Durability = caster'",$E0,"max HP",$00
Unicorn: db "Heal Horn:Cure",$E0,"HP (stamina-based)|Lift",$E0,"most bad statuses",$00
Fenrir: db "Moonshine:Set",$E0,"[Image]|Evade",$E0,"on",$E7,"or mor",$E7,"physical attacks",$00
Starlet: db "Group Hug:Cure",$E0,"HP to max|Lift",$E0,"all bad statuses",$00
Phoenix: db "Rebirth:|Revive",$E0,"fallen allie",$E0,"to max HP",$00

warnpc $CB5790

;----------------------------------------------------
;Equip bonus descriptions
;----------------------------------------------------

org $CF3940

Ramuhb:
    db "Equip:|H",$E2,"ve",$E0,"Bolt damage",$00
Ifritb:
    db "Equip:|H",$E2,"ve",$E0,"Fi",$F1," damage",$00
Shivab:
    db "Equip:|H",$E2,"ve",$E0,"Ice damage",$00
Sirenb:
    db "Equip:|Block",$E0,"[Mute]/[Mudd",$E1,"]/[Berserk]",$00
Terratob:
	db "Equip:|H",$E2,"ve",$E0,"Earth damage",$00
Shoatb:
	db "Equip:|S",$F0,"m",$E4,"a +5",$00
Maduinb:
	db "Equip:|H",$E2,"ve",$E0,"W",$E4,"d damage",$00
Bismarkb:
	db "Equip:|H",$E2,"ve",$E0,"W",$07,"er damage",$00
Strayb:
	db "Equip:|Block",$E0,"[Bl",$E4,"d]/[Poison]/[Imp]",$00
Palidorb:
	db "Equip:|Auto-Hast",$E7,"(block",$E0,$F3,"low])",$00
Tritochb:
	db "Equip:|Auto-Shell",$00
Odinb:
	db "Equip:|Speed +5",$00
Lokib:
	db "",$00
Bahamutb:
	db "Equip:|Auto-Safe",$00
Crusaderb:
	db "Equip:|Auto-Ref",$E1,"ct",$00
Ragnarokb:
	db "Equip:|Magic",$E2," output +25%",$00
Alexandrb:
	db "Equip:|Physic",$E2," output +25%",$00
Kirinb:
	db "Equip:|Magic +5",$00
Zoneseekb:
	db "Equip:|M.Def. +10",$00
Carbunklb:
	db "Equip:|Auto-Regen (block",$E0,$F3,"ap])",$00
Phantomb:
	db "Equip:|M.Evad",$E7,"+10",$00
Seraphb:
	db "Equip:|Block",$E0,$F3,$E1,"ep]/[P",$E5,"rify]/De",$07,"h",$00
Golemb:
	db "Equip:|Def +10",$00
Unicornb:
	db "Equip:|Vigor +5",$00
Fenrirb:
	db "Equip:|Evad",$E7,"+10",$00
Starletb:
	db "Equip:|MP+25%",$00
Phoenixb:
	db "Equip:|HP+25%",$00

warnpc $CF3C40

org $CFFE40

	dw Ramuhb-Ramuhb
    dw Ifritb-Ramuhb
    dw Shivab-Ramuhb
    dw Sirenb-Ramuhb
    dw Terratob-Ramuhb
    dw Shoatb-Ramuhb
    dw Maduinb-Ramuhb
    dw Bismarkb-Ramuhb
    dw Strayb-Ramuhb
    dw Palidorb-Ramuhb
    dw Tritochb-Ramuhb
    dw Odinb-Ramuhb
    dw Lokib-Ramuhb
    dw Bahamutb-Ramuhb
    dw Crusaderb-Ramuhb
    dw Ragnarokb-Ramuhb
    dw Alexandrb-Ramuhb
    dw Kirinb-Ramuhb
    dw Zoneseekb-Ramuhb
    dw Carbunklb-Ramuhb
    dw Phantomb-Ramuhb
    dw Seraphb-Ramuhb
    dw Golemb-Ramuhb
    dw Unicornb-Ramuhb
    dw Fenrirb-Ramuhb
    dw Starletb-Ramuhb
    dw Phoenixb-Ramuhb

;----------------------------------------------
;Esper bonus descriptions
;----------------------------------------------

org $EDFE00

HP: db "+60 HP per EL spent",$00
MP: db "+40 MP per EL spent",$00
HMPP: db "+30 HP/+15 MP per EL spent",$00
VgrHP: db "+1 Vigor/+20 HP per EL spent",$00
MagMP: db "+1 Magic/+20 MP per EL spent",$00
VgrSpd: db "+1 Vigor/+1 Speed per EL spent",$00
MagSpd: db "+1 Magic/+1 Speed per EL spent",$00
VgrSta: db "+1 Vigor/+1 Stamina per EL spent",$00
MagSta: db "+1 Magic/+1 Stamina per EL spent",$00
SpdSta: db "+1 Speed/+1 Stamina per EL spent",$00
HPSta: db "+30 HP/+1 Stamina per EL spent",$00
MPSta: db "+25 MP/+1 Stamina per EL spent",$00
Vigor: db "+2 Vigor per EL spent",$00
Speed: db "+2 Speed per EL spent",$00
Stamina: db "+2 Stamina per EL spent",$00
Magic: db "+2 Magic per EL spent",$00

warnpc $EDFFCF

org $EDFFD0

dw HP-HP
dw MP-HP
dw HMPP-HP
dw VgrHP-HP
dw MagMP-HP
dw VgrSpd-HP
dw MagSpd-HP
dw VgrSta-HP
dw MagSta-HP
dw SpdSta-HP
dw HPSta-HP
dw MPSta-HP
dw Vigor-HP
dw Speed-HP
dw Stamina-HP
dw Magic-HP

warnpc $EDFFFF
