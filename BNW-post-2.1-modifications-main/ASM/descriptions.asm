arch 65816
hirom

table "menu.tbl",ltr

;-------------------------------
; Item descriptions
;-------------------------------

org $ED6400

HealingShiv:    db "The pointy end does the healing",$00
MythrilDirk:    db "Knives allow a 2nd weapon|and can be used w/ [Throw]",$00
Kagenui:        db "[Fight] hits 2x|May set [Stop]/[Slow]",$00
Butterfly:      db "2x damage to humans",$00
Switchblade:    db "May steal from foe",$00
Demonsbane:     db "Undead-slayer",$00
ManEater:       db "2x damage to humans",$00
Kunai:          db "",$00
Avenger:        db "Holy damage",$00
Valiance:       db "Ignores defense|Stronger at low HP",$00
MythrilBolo:    db "",$00
IronCutlass:    db "",$00
Scimitar:       db "Dual-wield|May counterattack",$00
Flametongue:    db "Fire damage|May cast Fire 2",$00
Icebrand:       db "Ice damage|May cast Ice 2",$00
ElecSword:      db "Bolt damage|May cast Bolt 2",$00
Epee:           db "",$00
BreakBlade:     db "",$00
BloodSword:     db "May cast Drain",$00
Imperial:       db "",$00
RuneBlade:      db "Uses MP for critical hits",$00
Falchion:       db "Dual-wield|May counterattack",$00
SoulSabre:      db "May cast Osmose",$00
Organix:        db "",$00
Excalibur:      db "Uses MP for critical hits|Stronger in 2 hands",$00
Zantetsuken:    db "Always hits, may counterattack|High crit rate, can insta-kill",$00
Illumina:       db "Uses MP for critical hits|May cast Holy",$00
Apocalypse:     db "Uses MP for critical hits|May cast Flare",$00
AtmaWeapon:     db "Attacks w/ stamina|Weaker at low HP",$00
MythrilPike:    db "Spears are stronger in 2 hands|and users may guard allies",$00
Trident:        db "HP+12.5%|Water damage",$00
StoutSpear:     db "HP+25%",$00
Partisan:       db "HP+25%",$00
Longinus:       db "HP+25%|Holy damage",$00
FireLance:      db "HP+12.5%|Fire damage",$00
Gungnir:        db "HP+50%|Always hits",$00
PointyStick:    db "",$00
Tanto:          db "",$00
Kunai2:         db "Anti-air, high crit rate",$00
Sakura:         db "May cast Break",$00
Ninjato:        db "Anti-air, high crit rate",$00
Kagenui2:       db "Ninja can wield",$00
Orochi:         db "Anti-air, high crit rate",$00
Hanzo:          db "Katanas are stronger in 2 hands",$00
Kotetsu:        db "May counterattack",$00
Ichimonji:      db "High crit rate, can insta-kill",$00
Kazekiri:       db "May hit all foes with|stamina-based wind attack",$00
Murasame:       db "May counterattack",$00
Masamune:       db "May counterattack",$00
Spoon:          db "",$00
Mutsunokami:    db "Wind blade is most powerful",$00
SpookStick:     db "",$00
MythrilRod:     db "Rods use MP for critical damage|and have high spellcast rate",$00
FireRod:        db "May cast Fire 2|(MP crit = 2x spell damage)",$00
IceRod:         db "May cast Ice 2|(MP crit = 2x spell damage)",$00
ThunderRod:     db "May cast Bolt 2|(MP crit = 2x spell damage)",$00
WindBreaker:    db "Wind hits with much stamina",$00
Doomstick:      db "May cast Doom|(MP crit = X-Zone)",$00
Quartrstaff:    db "May cast Quartr|(MP crit = hits foe group)",$00
Punisher:       db "May cast Dark|(MP crit = 2x spell damage)",$00
MagusRod:       db "",$00
LightBrush:     db "Brushes cure HP and hit 2x",$00
MonetBrush:     db "May cast Safe",$00
DaliBrush:      db "May cast Shell",$00
RossBrush:      db "May cast Reflect",$00
Shuriken:       db "Use w/ [Throw]|Can spread with L/R",$00
TackStar:       db "",$00
NinjaStar:      db "Strongest throw",$00
Club:           db "",$00
FullMoon:       db "Anti-air, high crit rate|Ignores row, dual-wield",$00
MorningStar:    db "Ignores defense",$00
Boomerang:      db "Anti-air, high crit rate|Ignores row, dual-wield",$00
RisingSun:      db "Anti-air, high crit rate|Ignores row, dual-wield",$00
Kusarigama:     db "2x damage to humans|May set [Stop]/[Slow]",$00
BoneClub:       db "",$00
MagicBone:      db "",$00
WingEdge:       db "Such wing, much edge",$00
Cards:          db "",$00
Darts:          db "Casino weapons ignore row",$00
Tarot:          db "Holy damage, undead-slayer",$00
ViperDarts:     db "Uses MP for critical hits",$00
Dice:           db "Damage = (2Lv. * D1 * D2)|Always hits",$00
FixedDice:      db "Damage = (2Lv. * D1 * D2 * D3)|Always hits",$00
MythrilClaw:    db "",$00
SpiritClaw:     db "Holy damage|May cast Slow",$00
PoisonClaw:     db "Dark damage|May cast Sap",$00
OceanClaw:      db "Water damage|May cast Drain",$00
HellClaw:       db "Fire damage|May cast Fire",$00
Frostgore:      db "Ice damage|May cast Ice",$00
Stormfang:      db "Bolt damage|May cast Bolt",$00
Buckler:        db "",$00
IronShield:     db "",$00
Targe:          db "",$00
GoldShield:     db "Halves Water damage",$00
AegisShield:    db "Auto-Haste (Blocks [Slow])",$00
DiamondKite:    db "Halves Bolt damage",$00
Flameguard:     db "Absorbs Fire damage",$00
Iceguard:       db "Absorbs Ice damage",$00
Thunderguard:   db "Absorbs Bolt damage",$00
CrystalKite:    db "Halves Wind damage",$00
GenjiShield:    db "Auto-Safe",$00
Multiguard:     db "Blocks Fire/Ice/Bolt damage",$00
CursedShield:   db "A horrible shield to have a curse",$00
HeroShield:     db "Auto-Regen (Blocks [Sap])",$00
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
Tiara:          db "A pretty princess tiara",$00
GoldHelm:       db "Halves Water damage",$00
TigerMask:      db "Halves Fire damage",$00
RedCap:         db "HP/MP+25%",$00
MysteryVeil:    db "Sword spellcast rate up",$00
Circlet:        db "MP+50%",$00
DragonHelm:     db "[Jump] randomly hits 2x",$00
DiamondHelm:    db "Halves Bolt damage",$00
DarkHood:       db "",$00
CrystalHelm:    db "Halves Wind damage",$00
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
GaiaGear:       db "Halves Earth damage",$00
MirageVest:     db "Auto-Haste (Blocks [Slow])",$00
GoldArmor:      db "Halves Water damage",$00
PowerArmor:     db "",$00
LightRobe:      db "",$00
DiamondVest:    db "Halves Bolt damage",$00
RoyalJacket:    db "HP+25%",$00
ForceArmor:     db "Halves Fire/Ice/Bolt damage",$00
DiamondMail:    db "Halves Bolt damage",$00
DarkGear:       db "",$00
TaoRobe:        db "",$00
CrystalMail:    db "Halves Wind damage",$00
RadiantGown:    db "MP+25%|Brush spellcast rate up",$00
GenjiArmor:     db "",$00
LazyShell:      db "Halves Bolt/Wind damage",$00
Minerva:        db "Blocks Fire/Ice/Bolt damage",$00
TabbyHide:      db "Halves Earth damage",$00
GatorHide:      db "Halves Water damage",$00
ChocoboHide:    db "Halves Water/Wind damage",$00
MoogleHide:     db "Halves Earth/Wind damage",$00
DragonHide:     db "Halves Fire/Wind damage",$00
SnowMuffler:    db "Blocks Ice/Wind damage|HP+25%",$00
Noiseblaster:   db "May set [Muddle] - foe group",$00
BioBlaster:     db "Dark damage - foe group|Sets [Poison]",$00
Flash:          db "Non-elemental dmg - foe group|Sets [Blind]",$00
Chainsaw:       db "This is not a drill",$00
Defibrillator:  db "[CLEAR!]",$00
Drill:          db "This is a drill",$00
ManaBattery:    db "It keeps going and going_",$00
Autocrossbow:   db "Physical attack - foe group|Ignores row",$00
FireScroll:     db "(Split) Fire damage - all foes|Use w/ [Throw]",$00
WaveScroll:     db "(Split) Water damage - all foes|Use w/ [Throw]",$00
BoltScroll:     db "(Split) Bolt damage - all foes|Use w/ [Throw]",$00
InvizScroll:    db "Ninja vanish!",$00
SmokeBomb:      db "Sets [Image] - one ally|Use w/ [Throw]",$00
LeoCrest:       db $E6,$00
Bracelet:       db "Blocks [Poison]",$00
SpiritStone:    db "Blocks [Blind]/[Poison]/[Petrify]",$00
Amulet:         db "Blocks [Sleep]/[Muddle]/[Berserk]",$00
WhiteCape:      db "Blocks [Imp]/[Mute]/[Stop]",$00
Talisman:       db "Blocks [Blind]/[Poison]",$00
FairyCharm:     db "Blocks [Sleep]/[Muddle]",$00
BarrierCube:    db "Sets [Shell] on low HP",$00
SafetyGlove:    db "Sets [Safe] on low HP",$00
GuardRing:      db "Auto-Safe",$00
SprintShoes:    db "Auto-Haste (Blocks [Slow])",$00
ReflectRing:    db "Auto-Reflect",$00
-:              db "",$00
GumPod:         db "",$00
KnightCape:     db "HP+12.5%|May guard allies",$00
DragoonSeal:    db "[Fight] to [Jump]|Sword spellcast rate up",$00
ZephyrCape:     db "Sets [Haste] on low HP",$00
MysteryEgg:     db "It's a mystery_",$00
BlackHeart:     db "HP+50%",$00
MagicCube:      db "MP+50%",$00
PowerGlove:     db "Physical output +25%|(It's so bad)",$00
BlizzardOrb:    db "Magical output +25%|(??? on yeti)",$00
PsichoBelt:     db "Physical output +25%|(??? on yeti)",$00
RogueCloak:     db "[Fight] always hits|Magical output +25%",$00
WallRing:       db "Auto-Shell",$00
HeroRing:       db "HP/MP+25%|May guard allies",$00
Ribbon:         db "Blocks [Stop]/[Petrify]/Death|(Death includes [Zombie])",$00
MuscleBelt:     db "HP+25%|Physical output +25%",$00
CrystalOrb:     db "MP+25%|Magical output +25%",$00
Goggles:        db "Blocks [Blind]",$00
SoulBox:        db "MP costs = 1/2",$00
ThiefGlove:     db "[Steal] to [Mug]|Physical damage +25%",$00
Gauntlet2:      db "",$00
GenjiGlove:     db "",$00
HyperWrist:     db "Auto-Berserk",$00
Offering:       db "",$00
Beads:          db "",$00
ExBlack:        db "",$00
HeijiCoin:      db "[Slot] to [GP Toss]",$00
SageStone:      db "[Magic] to [X-Magic]",$00
GemBox:         db "MP costs = 1/2",$00
NirvanaBand:    db "All output +25%",$00
Economizer:     db "1 MP cost",$00
MementoRing:    db "That is not dead|Which can rise again",$00
QuartzCharm:    db "Auto-Safe/Shell",$00
GhostRing:      db "Makes wearer undead",$00
MoogleCharm:    db "Dance like the wind|Fall like a stone",$00
BlackBelt:      db "[Fight] always hits|May counterattack",$00
Codpiece:       db "",$00
BackGuard:      db "Prevents ambushes",$00
GaleHairpin:    db "Pre-emptive attack rate up",$00
StatStick:      db "HP/MP+12.5%",$00
DarylSoul:      db "[Fight] hits 2x",$00
LifeBell:       db "Auto-Regen (Blocks [Sap])",$00
DirtyUndies:    db "",$00
RenameCard:     db "Hidden item",$00
Tonic:          db "Cures 1/2 Max HP",$00
Potion:         db "Cures 3/4 Max HP",$00
XPotion:        db "Cures 3/4 Max HP - party",$00
Tincture:       db "Cures 50 MP",$00
Ether:          db "Cures 3/4 Max MP",$00
XEther:         db "Cures 3/4 Max MP - party",$00
Elixir:         db "Cures HP/MP to max|Lifts most bad statuses",$00
Megalixir:      db "Full heal (HP/MP/status) - party",$00
PhoenixDown:    db "Revives fallen ally|(HP = 1)",$00
HolyWater:      db "Cures [Zombie]|(HP = 1/8 max)",$00
Antidote:       db "Cures [Poison]",$00
Eyedrops:       db "Cures [Blind]",$00
SnakeOil:       db "All-Natural",$00
Remedy:         db "Lifts most bad statuses",$00
Scrap:          db "Sell for GP",$00
Tent:           db "",$00
GreenCherry:    db "Has a calming effect",$00
PhoenixTear:    db "Revives fallen ally|(HP = 3/4 max)",$00
BouncyBall:     db "Do not taunt Happy Fun Ball",$00
RedBull:        db "Cures 200 HP",$00
SlimJim:        db "Snap into it!",$00
WarpWhistle:    db "Welcome to Warp Zone",$00
DriedMeat:      db "Cures 100 HP",$00
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
    db "Cider made from delicious fruit",$00
ClockKey:
    db "Useful if your clock locks up",$00
TastyFish:
    db "A tasty fish",$00
JustFish:
    db "Just a fish",$00
Fish:
    db "Fish",$00
RottenFish:  
    db "A rotten fish",$00
Guilt:
    db "It's heavy with the weight of|murdered family and friends",$00
LolaLetter:
    db "Rather explicit, to say the least",$00
Booty:
    db "Yar, it be the booty of a pirate",$00
Filth:
    db "[The Adventures of Mr. Tentacle and| the Naughty Schoolgirl]",$00
EmperorMap:
    db "Show this to the old man",$00
WD40:
    db "Fixes anything that can't be fixed|with duct tape",$00
Schematics:
    db "Autocrossbow:|Power +50%, Accuracy = 100%",$00
BettingChips:  
    db "These look like somebody tried to|eat them_",$00
Blank1: db $00
Blank2: db $00
CrackedStone:  
    db "This is why we can't have nice|things_",$00
LeoSpirits:  
    db "A bottle of Leo's favorite booze",$00
Blank3: db $00
Pendant:
    db "Some things you",$03,"just can't get rid of_",$00
    
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
Sap: db "Dark damage - single|May set [Sap]",$00
Poison: db "Dark damage|May set [Poison]",$00
Fire2: db $FC,$FC,$00
Ice2: db $FB,$FB,$00
Bolt2: db $F8,$F8,$00
Break: db "Wind damage - single|Ignores def.",$00
Fire3: db $FC,$FC,$FC,$00
Ice3: db $FB,$FB,$FB,$00
Bolt3: db $F8,$F8,$F8,$00
Quake: db "Earth (ground) damage - all|Ignores def.",$00
Doom: db "Instant death - single|(Heals undead)",$00
Holy: db "Holy damage - single|Ignores def.",$00
Flare: db "Non-elemental dmg - single|Ignores def.",$00
Dark: db "Dark damage - single",$00
Storm: db "Wind/Water damage - all foes",$00
XZone: db "Instant death - foe group",$00
Meteor: db "Non-elemental dmg - all foes",$00
Ultima: db "Ultimate magic attack",$00
Merton: db "Fire/Dark damage - all",$00
Demi: db "Earth damage - single|Damage = (HP * 1/2)",$00
Quartr: db "Earth damage - foe group|Damage = (HP * 3/4)",$00
Drain: db "Steals HP - single",$00
Osmose: db "Steals MP - single",$00
Rasp: db "MP damage - single",$00
Muddle: db "Sets [Muddle] - all foes",$00
Mute: db "Sets [Mute] - single",$00
Sleep: db "Sets [Sleep] - single",$00
SleepX: db "Sets [Sleep] - foe group",$00
Imp: db "Sets/lifts [Imp] - single",$00
Bserk: db "Sets [Berserk] - single",$00
Stop: db "Sets [Stop] - single",$00
Safe: db "Sets [Safe] - one ally",$00
Shell: db "Sets [Shell] - one ally",$00
Haste: db "Sets [Haste] - one ally",$00
HasteX: db "Sets [Haste] - ally group",$00
Slow: db "Sets [Slow] - single",$00
SlowX: db "Sets [Slow] - foe group",$00
Rflect: db "Sets [Reflect] - single",$00
Float: db "Sets [Float] - party",$00
Warp: db "Go to World 9",$00
Scan: db "!",$00
Dispel: db "Lifts good statuses - single",$00
Cure: db "Cures HP (Holy-elemental)",$00
Cure2: db "Cures HP (Holy-elemental)",$00
Cure3: db "Cures HP (Holy-elemental)",$00
Life: db "Revives fallen ally|(HP = 250~500)",$00
Life2: db "Revives fallen ally|(HP = max)",$00
Rerise: db "Sets [Rerise] - one ally",$00
GRemedy: db "Stamina-based cure - one ally|Lifts most bad statuses",$00
Regen: db "Stamina-based cure - one ally|Sets [Regen]",$00
RegenX: db "Stamina-based cure - ally group|Sets [Regen]",$00

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
	db "Physical attack (ignores def.)|Sets [Sap]",$00
Suplex:
	db "Physical attack (ignores def.)|May set [Stop]",$00
Aurabolt:
	db "Holy (stamina) attack",$00
FireDance:
	db "Fire damage - all foes",$00
Mantra:
	db "Cures ally HP (stamina-based)|Weaker at low HP",$00
Chakra:
	db "Cures ally MP (stamina-based)",$00
SonicBoom:	
	db "Wind (stamina) attack - all foes",$00
BumRush:	
	db "Punch hard",$00

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
	db "Physical attack (ignores def.)|2x damage to humans",$00
Mindblow:	
	db "500 MP damage - one foe",$00
Empeworer:	
	db "Steals HP/MP - one foe|Sets [Sap]",$00
Flurry:	
	db "4x physical attack|May set [Muddle]",$00
Dragon:	
	db "Stamina attack - ignores def.|May set [Petrify]",$00
Eclipse:	
	db "Non-elemental dmg - all foes|Sets [Blind]",$00
Tempest:	
	db "4x physical attack",$00
Cleave:	
	db $E6,$00

warnpc $CFFE00

org $CFFFAE

	dw Dispatch-Dispatch
	dw Mindblow-Dispatch
	dw Empeworer-Dispatch
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
	db "Water damage - all foes",$00
BadBreath:	
	db "Sets bad status - foe group|([Poison]/[Blind]/[Mute])",$00
BlackOmen:	
	db "Non-elemental dmg - all foes|Ignores def.",$00
Blaze:	
	db "Fire/Wind damage|May set [Blind]/[Sap]",$00
BlowFish:	
	db "Physical attack - single|Damage = 1000",$00
Discord:	
	db "Sets [Muddle]/[Berserk] - single|Unreflectable",$00
HolyWind:	
	db "Cures HP - party|Amount = (Caster's current HP)",$00
Raid:	
	db "Steal HP/MP - single|Unreflectable, ignores def.",$00
Raze:	
	db "Fire/Wind damage - single|May set [Sap]",$00
Refract:	
	db "Sets [Reflect]/[Image] - one ally|Unreflectable",$00
Shield:	
	db "Sets [Safe] - party",$00
Tsunami:	
	db "Water damage - all foes",$00

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

!freeXL = $CB52FC

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

Ramuh: db "Judgement:|Bolt damage - all foes",$00
Ifrit: db "Inferno:|Fire damage - all foes",$00
Shiva: db "Gem Dust:|Ice damage - all foes",$00
Siren: db "Siren Song:|Sets [Muddle]/[Berserk] - all foes",$00
Terrato: db "Earth Rage:|Earth damage - all foes",$00
Shoat: db "Hurricane:|Sets [Petrify] - all foes",$00
Maduin: db "Chaos Wing: Wind damage - all foes|Ignores def.",$00
Bismark: db "Sea Song:|Water damage - all foes",$00
Stray: db "Cait Sith: Stamina-based cure - party|Sets [Regen]",$00
Palidor: db "Air Raid:|Party attacks with [Jump]",$00
Tritoch: db "Trisection:|Fire/Ice/Bolt damage - all foes",$00
Odin: db "Atom Edge: Stamina-based - all foes|Non-elemental dmg; ignores def.",$00
Loki: db $00
Bahamut: db "Mega Flare: Ignores def.|Non-elemental dmg - all foes",$00
Crusader: db "Jihad:|Dark damage - all foes",$00
Ragnarok: db "Oblivion:|9999 damage - one foe",$00
Alexandr: db "Justice:|Holy damage - all foes",$00
Kirin: db "Life Force: Cures HP - party|Revives fallen allies",$00
Zoneseek: db "Light Wall:|Sets [Shell] - party",$00
Carbunkl: db "Ruby Blast:|Sets [Reflect] - party",$00
Phantom: db "Fader:|Sets [Vanish] - party",$00
Seraph: db "Lifeline:|Sets [Rerise] - party",$00
Golem: db "Earth Wall: Blocks physical attacks|(Durability = caster's max HP)",$00
Unicorn: db "Heal Horn: Stamina-based cure - party|Lifts most bad statuses",$00
Fenrir: db "Moonshine:|Sets [Image] - party",$00
Starlet: db "Group Hug: Cures HP to max - party|Lifts all bad statuses",$00
Phoenix: db "Rebirth: Revives fallen allies - party|(HP = max)",$00

warnpc $CB5790

;----------------------------------------------------
;Equip bonus descriptions
;----------------------------------------------------

org $CF3940

Ramuhb: 
    db "Equip Bonus:|Halves Bolt damage",$00
Ifritb: 
    db "Equip Bonus:|Halves Fire damage",$00
Shivab: 
    db "Equip Bonus:|Halves Ice damage",$00
Sirenb: 
    db "Equip Bonus:|Blocks [Mute]/[Muddle]/[Berserk]",$00
Terratob: 
	db "Equip Bonus:|Halves Earth damage",$00
Shoatb: 
	db "Equip Bonus:|Stamina +5",$00
Maduinb: 
	db "Equip Bonus:|Halves Wind damage",$00
Bismarkb:
	db "Equip Bonus:|Halves Water damage",$00
Strayb: 
	db "Equip Bonus:|Blocks [Blind]/[Poison]/[Imp]",$00
Palidorb: 
	db "Equip Bonus:|Auto-Haste (blocks [Slow])",$00
Tritochb: 
	db "Equip Bonus:|Auto-Shell",$00
Odinb: 
	db "Equip Bonus:|Speed +5",$00
Lokib: 
	db "",$00
Bahamutb:
    db "Equip Bonus:|Auto-Safe",$00
Crusaderb: 
	db "Equip Bonus:|Auto-Reflect",$00
Ragnarokb: 
	db "Equip Bonus:|Magical output +25%",$00
Alexandrb: 
	db "Equip Bonus:|Physical output +25%",$00
Kirinb: 
	db "Equip Bonus:|Magic +5",$00
Zoneseekb: 
	db "Equip Bonus:|M.Def +10",$00
Carbunklb: 
	db "Equip Bonus:|Auto-Regen (blocks [Sap])",$00
Phantomb: 
	db "Equip Bonus:|M.Evade +10",$00
Seraphb: 
	db "Equip Bonus:|Blocks [Sleep]/[Petrify]/Death",$00
Golemb: 
	db "Equip Bonus:|Def +10",$00
Unicornb: 
	db "Equip Bonus:|Vigor +5",$00
Fenrirb: 
	db "Equip Bonus:|Evade +10",$00
Starletb: 
	db "Equip Bonus:|MP+25%",$00
Phoenixb: 
	db "Equip Bonus:|HP+25%",$00
    
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
