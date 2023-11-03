; -----------------------------------------------------------------------------
; Synopsis: Draw colosseum bets that form a closed loop in yellow.
;     Base: BNW 2.2b18.2
;   Author: Fëanor
;  Created: 2023-08-07
;  Depends: Include after "shrinked_colosseum.asm"
;  Updated: 2023-11-02 by Bropedio
;    * Remove palette change to yellow for closed loops
;    * Use new "trade" tile for closed loops instead
; -----------------------------------------------------------------------------
hirom

; -----------------------------------------------------------------------------
; Description
; -----------------------------------------------------------------------------
; This hack modifies the colosseum data of each betting item to store its color
; palette in byte $03 (used for "show/hide reward" info).
;
; vanilla: $00 = show reward / $FF = hide reward
;     now: $00 = hide reward / $XX = color palette
;
; This change requires two BEQ/BNE branches to be switched.
; -----------------------------------------------------------------------------

!free = $C3F6F6         ; requires  8 bytes
!warn = !free+10        ; provides 10 bytes

!open   = $D5     ; arrow
!closed = $C7     ; trade

; -----------------------------------------------------------------------------
; draw prize item name (character select screen)
; -----------------------------------------------------------------------------
org $C3B258 : db $D0    ; change BEQ to BNE

; -----------------------------------------------------------------------------
; shrinked_colosseum.asm
; -----------------------------------------------------------------------------
org $C3F233 : db $F0    ; change BNE to BEQ

; C3F24F:
; string_delimiter:
;   LDA $0205               ; bet item ID
;   CMP #$FF                ; null?
org $C3F254
SelectTile:
    BEQ .set_char           ; if ^, use ' ' tile ($FF)
    JSR TradeTileSplice     ; go get trade tile
    NOP #3                  ; empty space
.set_char
;   STA $2180               ; write chosen delimiter
;   STZ $2180               ; end of string
;   RTS
; -----------------------------------------------------------------------------

; set text color for each betting item
org !free
TradeTileSplice:    ; [8 bytes]
  LDA $0209         ; trade type tile
  BNE .done         ; branch if not hidden
  LDA !open         ; else, use arrow (Kagenui)
.done
  RTS
warnpc !warn

; -----------------------------------------------------------------------------
; DFB600-DFB9FF: Colosseum Data (256 items, 4 bytes each) 
; -----------------------------------------------------------------------------

!hidden = $00

org $DFB603 : db !open      ; Healing Shiv
org $DFB607 : db !open      ; Mythril Dirk
org $DFB60B : db !closed    ; Kagenui
org $DFB60F : db !open      ; Butterfly
org $DFB613 : db !open      ; Switchblade
org $DFB617 : db !open      ; Demonsbane
org $DFB61B : db !open      ; Man Eater
org $DFB61F : db !open      ; Kunai
org $DFB623 : db !closed    ; Avenger
org $DFB627 : db !open      ; Valiance
org $DFB62B : db !open      ; Mythril Bolo
org $DFB62F : db !open      ; Iron Cutlass
org $DFB633 : db !open      ; Scimitar
org $DFB637 : db !closed    ; Flametongue
org $DFB63B : db !open      ; Icebrand
org $DFB63F : db !open      ; Elec Sword
org $DFB643 : db !open
org $DFB647 : db !open
org $DFB64B : db !open      ; Blood Sword
org $DFB64F : db !open      ; Imperial
org $DFB653 : db !open      ; Rune Blade
org $DFB657 : db !open      ; Falchion
org $DFB65B : db !open      ; Soul Sabre
org $DFB65F : db !open
org $DFB663 : db !open      ; Excalibur
org $DFB667 : db !closed    ; Zantetsuken
org $DFB66B : db !open      ; Illumina
org $DFB66F : db !open      ; Apocalypse
org $DFB673 : db !open      ; Atma Weapon
org $DFB677 : db !open      ; Mythril Pike
org $DFB67B : db !open      ; Trident
org $DFB67F : db !open      ; Stout Spear
org $DFB683 : db !open      ; Partisan
org $DFB687 : db !open      ; Longinus
org $DFB68B : db !open      ; Fire Lance
org $DFB68F : db !closed    ; Gungnir
org $DFB693 : db !open      ; Pointy Stick
org $DFB697 : db !open      ; Tanto
org $DFB69B : db !open      ; Kunai
org $DFB69F : db !open      ; Sakura
org $DFB6A3 : db !open      ; Ninjato
org $DFB6A7 : db !hidden    ; Kagenui
org $DFB6AB : db !open      ; Orochi
org $DFB6AF : db !open      ; Hanzo
org $DFB6B3 : db !open      ; Kotetsu
org $DFB6B7 : db !open      ; Ichimonji
org $DFB6BB : db !open      ; Kazekiri
org $DFB6BF : db !open      ; Murasame
org $DFB6C3 : db !open      ; Masamune
org $DFB6C7 : db !open      ; Spoon
org $DFB6CB : db !closed    ; Mutsunokami
org $DFB6CF : db !open      ; Spook Stick
org $DFB6D3 : db !open      ; Mythril Rod
org $DFB6D7 : db !open      ; Fire Rod
org $DFB6DB : db !open      ; Ice Rod
org $DFB6DF : db !open      ; Thunder Rod
org $DFB6E3 : db !closed    ; Wind Breaker
org $DFB6E7 : db !open      ; Doomstick
org $DFB6EB : db !open      ; Quartrstaff
org $DFB6EF : db !closed    ; Punisher
org $DFB6F3 : db !open
org $DFB6F7 : db !open      ; Light Brush
org $DFB6FB : db !open      ; Monet Brush
org $DFB6FF : db !open      ; Dali Brush
org $DFB703 : db !closed    ; Ross Brush
org $DFB707 : db !open      ; Shuriken
org $DFB70B : db !open
org $DFB70F : db !open      ; Ninja Star
org $DFB713 : db !open      ; Club
org $DFB717 : db !open      ; Full Moon
org $DFB71B : db !open      ; Morning Star
org $DFB71F : db !open      ; Boomerang
org $DFB723 : db !open      ; Rising Sun
org $DFB727 : db !open      ; Kusarigama
org $DFB72B : db !closed    ; Bone Club
org $DFB72F : db !closed    ; Magic Bone
org $DFB733 : db !closed    ; Wing Edge
org $DFB737 : db !open
org $DFB73B : db !open      ; Darts
org $DFB73F : db !open      ; Tarot
org $DFB743 : db !open      ; Viper Darts
org $DFB747 : db !open      ; Dice
org $DFB74B : db !open      ; Fixed Dice
org $DFB74F : db !open      ; Mythril Claw
org $DFB753 : db !open      ; Spirit Claw
org $DFB757 : db !open      ; Poison Claw
org $DFB75B : db !open      ; Ocean Claw
org $DFB75F : db !open      ; Hell Claw
org $DFB763 : db !closed    ; Frostgore
org $DFB767 : db !closed    ; Stormfang
org $DFB76B : db !open      ; Buckler
org $DFB76F : db !open      ; Iron Shield
org $DFB773 : db !open      ; Targe
org $DFB777 : db !open      ; Gold Shield
org $DFB77B : db !closed    ; Aegis Shield
org $DFB77F : db !open      ; Diamond Kite
org $DFB783 : db !closed    ; Flameguard
org $DFB787 : db !closed    ; Iceguard
org $DFB78B : db !open      ; Thunderguard
org $DFB78F : db !open      ; Crystal Kite
org $DFB793 : db !closed    ; Genji Shield
org $DFB797 : db !open      ; Multiguard
org $DFB79B : db !open      ; Hero Shield
org $DFB79F : db !open      ; Hero Shield
org $DFB7A3 : db !closed    ; Force Shield
org $DFB7A7 : db !open      ; Leather Hat
org $DFB7AB : db !open      ; Hair Band
org $DFB7AF : db !open      ; Plumed Hat
org $DFB7B3 : db !closed    ; Ninja Mask
org $DFB7B7 : db !open      ; Magus Hat
org $DFB7BB : db !open      ; Bandana
org $DFB7BF : db !open      ; Iron Helm
org $DFB7C3 : db !open      ; Skull Cap
org $DFB7C7 : db !open      ; Stat Hat
org $DFB7CB : db !open      ; Green Beret
org $DFB7CF : db !open
org $DFB7D3 : db !open      ; Mythril Helm
org $DFB7D7 : db !open      ; Tiara
org $DFB7DB : db !open      ; Gold Helm
org $DFB7DF : db !open      ; Tiger Mask
org $DFB7E3 : db !open      ; Red Cap
org $DFB7E7 : db !open      ; Mystery Veil
org $DFB7EB : db !open      ; Circlet
org $DFB7EF : db !closed    ; Dragon Helm
org $DFB7F3 : db !open      ; Diamond Helm
org $DFB7F7 : db !open      ; Dark Hood
org $DFB7FB : db !open      ; Crystal Helm
org $DFB7FF : db !open      ; Oath Veil
org $DFB803 : db !closed    ; Cat Hood
org $DFB807 : db !closed    ; Genji Helm
org $DFB80B : db !open
org $DFB80F : db !open
org $DFB813 : db !open      ; Hard Leather
org $DFB817 : db !open      ; Cotton Robe
org $DFB81B : db !open      ; Karate Gi
org $DFB81F : db !open      ; Iron Armor
org $DFB823 : db !open
org $DFB827 : db !open      ; Mythril Vest
org $DFB82B : db !open      ; Ninja Gear
org $DFB82F : db !open      ; White Dress
org $DFB833 : db !open      ; Mythril Mail
org $DFB837 : db !open      ; Gaia Gear
org $DFB83B : db !closed    ; Mirage Vest
org $DFB83F : db !open      ; Gold Armor
org $DFB843 : db !open      ; Power Armor
org $DFB847 : db !open      ; Light Robe
org $DFB84B : db !open      ; Diamond Vest
org $DFB84F : db !closed    ; Royal Jacket
org $DFB853 : db !closed    ; Force Armor
org $DFB857 : db !open      ; Diamond Mail
org $DFB85B : db !open      ; Dark Gear
org $DFB85F : db !open
org $DFB863 : db !open      ; Crystal Mail
org $DFB867 : db !open      ; Radiant Gown
org $DFB86B : db !closed    ; Genji Armor
org $DFB86F : db !open      ; Lazy Shell
org $DFB873 : db !open      ; Minerva
org $DFB877 : db !open      ; Tabby Hide
org $DFB87B : db !open      ; Gator Hide
org $DFB87F : db !open      ; Chocobo Hide
org $DFB883 : db !open      ; Moogle Hide
org $DFB887 : db !closed    ; Dragon Hide
org $DFB88B : db !closed    ; Snow Muffler
org $DFB88F : db !open      ; Noiseblaster
org $DFB893 : db !open      ; Bio Blaster
org $DFB897 : db !open      ; Flash
org $DFB89B : db !open      ; Chainsaw
org $DFB89F : db !open      ; Defibrator
org $DFB8A3 : db !open      ; Drill
org $DFB8A7 : db !open      ; Mana Battery
org $DFB8AB : db !open      ; Autocrossbow
org $DFB8AF : db !open      ; Fire Scroll
org $DFB8B3 : db !open      ; Wave Scroll
org $DFB8B7 : db !open      ; Bolt Scroll
org $DFB8BB : db !open      ; Inviz Scroll
org $DFB8BF : db !open      ; Smoke Bomb
org $DFB8C3 : db !open      ; Leo's Crest
org $DFB8C7 : db !open      ; Bracelet
org $DFB8CB : db !open      ; Spirit Stone
org $DFB8CF : db !open      ; Amulet
org $DFB8D3 : db !open      ; White Cape
org $DFB8D7 : db !open      ; Talisman
org $DFB8DB : db !open      ; Fairy Charm
org $DFB8DF : db !open      ; Barrier Cube
org $DFB8E3 : db !open      ; Safety Glove
org $DFB8E7 : db !open      ; Guard Ring
org $DFB8EB : db !open      ; Sprint Shoes
org $DFB8EF : db !open      ; Reflect Ring
org $DFB8F3 : db !open      ;  -
org $DFB8F7 : db !open      ; Gum Pod
org $DFB8FB : db !open      ; Knight Cape
org $DFB8FF : db !open      ; Dragoon Seal
org $DFB903 : db !open      ; Zephyr Cape
org $DFB907 : db !open      ; Mystery Egg
org $DFB90B : db !open      ; Black Heart
org $DFB90F : db !closed    ; Magic Cube
org $DFB913 : db !closed    ; Power Glove
org $DFB917 : db !closed    ; Blizzard Orb
org $DFB91B : db !closed    ; Psycho Belt
org $DFB91F : db !closed    ; Rogue Cloak
org $DFB923 : db !open      ; Wall Ring
org $DFB927 : db !open      ; Hero Ring
org $DFB92B : db !open      ; Ribbon
org $DFB92F : db !closed    ; Muscle Belt
org $DFB933 : db !closed    ; Crystal Orb
org $DFB937 : db !open      ; Goggles
org $DFB93B : db !open      ; Soul Box
org $DFB93F : db !open      ; Thief Glove
org $DFB943 : db !open
org $DFB947 : db !open
org $DFB94B : db !open      ; Hyper Wrist
org $DFB94F : db !open
org $DFB953 : db !open
org $DFB957 : db !open
org $DFB95B : db !closed    ; Heiji's Coin
org $DFB95F : db !closed    ; Sage Stone
org $DFB963 : db !open      ; Gem Box
org $DFB967 : db !closed    ; Nirvana Band
org $DFB96B : db !open      ; Economizer
org $DFB96F : db !open      ; Memento Ring
org $DFB973 : db !open      ; Quartz Charm
org $DFB977 : db !open      ; Ghost Ring
org $DFB97B : db !open      ; Moogle Charm
org $DFB97F : db !closed    ; Black Belt
org $DFB983 : db !open      ; Codpiece
org $DFB987 : db !open      ; Back Guard
org $DFB98B : db !open      ; Gale Hairpin
org $DFB98F : db !open      ; Stat Stick
org $DFB993 : db !closed    ; Daryl's Soul
org $DFB997 : db !closed    ; Life Bell
org $DFB99B : db !open      ; Dirty Undies
org $DFB99F : db !open      ; Rename Card
org $DFB9A3 : db !open      ; Tonic
org $DFB9A7 : db !open      ; Potion
org $DFB9AB : db !open      ; X-Potion
org $DFB9AF : db !open      ; Tincture
org $DFB9B3 : db !open      ; Ether
org $DFB9B7 : db !open      ; X-Ether
org $DFB9BB : db !open      ; Elixir
org $DFB9BF : db !open      ; Megalixir
org $DFB9C3 : db !open      ; Phoenix Down
org $DFB9C7 : db !open      ; Holy Water
org $DFB9CB : db !open      ; Antidote
org $DFB9CF : db !open      ; Eyedrops
org $DFB9D3 : db !open      ; Snake Oil
org $DFB9D7 : db !open      ; Remedy
org $DFB9DB : db !open      ; Scrap
org $DFB9DF : db !open      ; Tent
org $DFB9E3 : db !open      ; Green Cherry
org $DFB9E7 : db !open      ; Phoenix Tear
org $DFB9EB : db !open      ; Bouncy Ball
org $DFB9EF : db !open      ; Red Bull
org $DFB9F3 : db !open      ; Slim Jim
org $DFB9F7 : db !open      ; Warp Whistle
org $DFB9FB : db !open      ; Dried Meat
org $DFB9FF : db !open      ; Empty
