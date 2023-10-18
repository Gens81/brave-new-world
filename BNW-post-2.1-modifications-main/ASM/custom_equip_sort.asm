hirom

!free = $CEFEE7
!warn = $CF0000

; modifies "Sort Items by Attack/Defense Power" routine
org $C3A15A : BEQ exit  ; update "no items" branch
org $C3A15E : BEQ exit  ; update "one item" branch
org $C3A167
  - LDA $7E9D8A,X       ; item list (positions in inventory)
    PHX
    TAY
    LDA $1869,Y         ; item number
    TAX
    LDA SortTbl,X       ; custom sort value
    STA $2180
    PLX
    INX
    CPX $E7
    BNE -               ; branch until loop complete
    JSR $A187           ; sort items in decreasing order
exit:
    RTS
warnpc $C3A187
padbyte $EA : pad $C3A187

; modifies "Put Item List in Order of Decreasing Attack/Defense Power" routine
org $C3A198 : db $90    ; sort in ascending order, replaces BCS with BCC

; lookup table containing custom ordering
org !free
SortTbl:
    db $4C ; Healing Shiv
    db $46 ; Mythril Dirk
    db $0F ; Kagenui
    db $40 ; Butterfly
    db $1C ; Switchblade
    db $1B ; Demonsbane
    db $26 ; Man Eater
    db $FF ; Kunai (unused)
    db $09 ; Avenger
    db $10 ; Valiance
    db $45 ; Mythril Bolo
    db $3F ; Iron Cutlass
    db $30 ; Scimitar
    db $2A ; Flametongue
    db $2B ; Icebrand
    db $29 ; Elec Sword
    db $FF
    db $FF
    db $14 ; Blood Sword
    db $35 ; Imperial
    db $23 ; Rune Blade
    db $25 ; Falchion
    db $11 ; Soul Sabre
    db $FF
    db $01 ; Excalibur
    db $06 ; Zantetsuken
    db $0D ; Illumina
    db $0C ; Apocalypse
    db $04 ; Atma Weapon
    db $48 ; Mythril Pike
    db $22 ; Trident
    db $38 ; Stout Spear
    db $20 ; Partisan
    db $02 ; Longinus
    db $21 ; Fire Lance
    db $03 ; Gungnir
    db $FF ; Pointy Stick
    db $4A ; Tanto
    db $44 ; Kunai
    db $3B ; Sakura
    db $2F ; Ninjato
    db $FF ; Kagenui (dummy)
    db $07 ; Orochi
    db $49 ; Hanzo
    db $3D ; Kotetsu
    db $37 ; Ichimonji
    db $16 ; Kazekiri
    db $12 ; Murasame
    db $0A ; Masamune
    db $FF ; Spoon
    db $05 ; Mutsunokami
    db $FF ; Spook Stick
    db $47 ; Mythril Rod
    db $31 ; Fire Rod
    db $32 ; Ice Rod
    db $33 ; Thunder Rod
    db $0B ; Wind Breaker
    db $24 ; Doomstick
    db $28 ; Quartrstaff
    db $08 ; Punisher
    db $FF
    db $42 ; Light Brush
    db $1F ; Monet Brush
    db $1E ; Dali Brush
    db $1D ; Ross Brush
    db $FF ; Shuriken
    db $FF
    db $FF ; Ninja Star
    db $43 ; Club
    db $2E ; Full Moon
    db $2C ; Morning Star
    db $3A ; Boomerang
    db $27 ; Rising Sun
    db $36 ; Kusarigama
    db $19 ; Bone Club
    db $41 ; Magic Bone
    db $15 ; Wing Edge
    db $FF
    db $3C ; Darts
    db $18 ; Tarot
    db $13 ; Viper Darts
    db $1A ; Dice
    db $00 ; Fixed Dice
    db $4B ; Mythril Claw
    db $3E ; Spirit Claw
    db $39 ; Poison Claw
    db $34 ; Ocean Claw
    db $2D ; Hell Claw
    db $17 ; Frostgore
    db $0E ; Stormfang
    db $5B ; Buckler
    db $5A ; Iron Shield
    db $59 ; Targe
    db $58 ; Gold Shield
    db $51 ; Aegis Shield
    db $57 ; Diamond Kite
    db $52 ; Flameguard
    db $53 ; Iceguard
    db $54 ; Thunderguard
    db $55 ; Crystal Kite
    db $4F ; Genji Shield
    db $56 ; Multiguard
    db $4D ; Hero Shield (cursed)
    db $4E ; Hero Shield
    db $50 ; Force Shield
    db $72 ; Leather Hat
    db $71 ; Hair Band
    db $FF ; Plumed Hat
    db $60 ; Ninja Mask
    db $68 ; Magus Hat
    db $70 ; Bandana
    db $6F ; Iron Helm
    db $5E ; Skull Cap
    db $6D ; Stat Hat
    db $6E ; Green Beret
    db $FF
    db $6B ; Mythril Helm
    db $6C ; Tiara
    db $67 ; Gold Helm
    db $6A ; Tiger Mask
    db $61 ; Red Cap
    db $69 ; Mystery Veil
    db $62 ; Circlet
    db $5D ; Dragon Helm
    db $66 ; Diamond Helm
    db $65 ; Dark Hood
    db $64 ; Crystal Helm
    db $63 ; Oath Veil
    db $5F ; Cat Hood
    db $5C ; Genji Helm
    db $FF
    db $FF
    db $8F ; Hard Leather
    db $8D ; Cotton Robe
    db $8E ; Karate Gi
    db $8C ; Iron Armor
    db $FF
    db $8B ; Mythril Vest
    db $8A ; Ninja Gear
    db $89 ; White Dress
    db $88 ; Mythril Mail
    db $87 ; Gaia Gear
    db $7C ; Mirage Vest
    db $84 ; Gold Armor
    db $86 ; Power Armor
    db $83 ; Light Robe
    db $85 ; Diamond Vest
    db $78 ; Royal Jacket
    db $76 ; Force Armor
    db $82 ; Diamond Mail
    db $81 ; Dark Gear
    db $FF
    db $7F ; Crystal Mail
    db $79 ; Radiant Gown
    db $74 ; Genji Armor
    db $80 ; Lazy Shell
    db $75 ; Minerva
    db $7E ; Tabby Hide
    db $7D ; Gator Hide
    db $7B ; Chocobo Hide
    db $7A ; Moogle Hide
    db $77 ; Dragon Hide
    db $73 ; Snow Muffler
    db $FF ; Noiseblaster
    db $FF ; Bio Blaster
    db $FF ; Flash
    db $FF ; Chainsaw
    db $FF ; Defibr@&ator
    db $FF ; Drill
    db $FF ; Mana Battery
    db $FF ; Autocrossbow
    db $FF ; Fire Scroll
    db $FF ; Wave Scroll
    db $FF ; Bolt Scroll
    db $FF ; Inviz Scroll
    db $FF ; Smoke Bomb
    db $A5 ; Leo's Crest
    db $96 ; Bracelet
    db $B6 ; Spirit Stone
    db $90 ; Amulet
    db $BC ; White Cape
    db $B9 ; Talisman
    db $9B ; Fairy Charm
    db $92 ; Barrier Cube
    db $B3 ; Safety Glove
    db $A0 ; Guard Ring
    db $B7 ; Sprint Shoes
    db $B0 ; Reflect Ring
    db $FF ; -
    db $FF ; Gum Pod
    db $A4 ; Knight Cape
    db $99 ; Dragoon Seal
    db $BD ; Zephyr Cape
    db $AB ; Mystery Egg
    db $94 ; Black Heart
    db $A7 ; Magic Cube
    db $AD ; Power Glove
    db $95 ; Blizzard Orb
    db $AE ; Psycho Belt
    db $B2 ; Rogue Cloak
    db $BB ; Wall Ring
    db $A2 ; Hero Ring
    db $B1 ; Ribbon
    db $AA ; Muscle Belt
    db $97 ; Crystal Orb
    db $9F ; Goggles
    db $B5 ; Soul Box
    db $BA ; Thief Glove
    db $FF
    db $FF
    db $A3 ; Hyper Wrist
    db $FF
    db $FF
    db $FF
    db $A1 ; Heiji's Coin
    db $B4 ; Sage Stone
    db $9D ; Gem Box
    db $AC ; Nirvana Band
    db $9A ; Economizer
    db $A8 ; Memento Ring
    db $AF ; Quartz Charm
    db $9E ; Ghost Ring
    db $A9 ; Moogle Charm
    db $93 ; Black Belt
    db $FF ; Codpiece
    db $91 ; Back Guard
    db $9C ; Gale Hairpin
    db $B8 ; Stat Stick
    db $98 ; Daryl's Soul
    db $A6 ; Life Bell
    db $FF ; Dirty Undies
    db $FF ; Rename Card
    db $FF ; Tonic
    db $FF ; Potion
    db $FF ; X-Potion
    db $FF ; Tincture
    db $FF ; Ether
    db $FF ; X-Ether
    db $FF ; Elixir
    db $FF ; Megalixir
    db $FF ; Phoenix Down
    db $FF ; Holy Water
    db $FF ; Antidote
    db $FF ; Eyedrops
    db $FF ; Snake Oil
    db $FF ; Remedy
    db $FF ; Scrap
    db $FF ; Tent
    db $FF ; Green Cherry
    db $FF ; Phoenix Tear
    db $FF ; Bouncy Ball
    db $FF ; Chocobo Wing
    db $FF ; Hero Drink
    db $FF ; Warp Whistle
    db $FF ; Dried Meat
    db $FF ; Empty
warnpc !warn
