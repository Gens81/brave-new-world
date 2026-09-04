arch 65816
hirom

table "menu.tbl",ltr

;------------------------------------------------------------------
;Item list
;------------------------------------------------------------------
org $D2B300
    
    db $DB,"Healing>Shiv"
    db $DB,"Dirk        "
    db $DB,"Kagenui     "
    db $DB,"Butterfly   "
    db $DB,"Switchblade "
    db $DB,"Demonsbane  "
    db $DB,"Man>Eater   "
    db $DB,"Kunai       "
    db $DB,"Avenger     "
    db $DB,"Valiance    "
    db $DC,"Sabre       "
    db $DC,"Iron>Cutlass"
    db $DC,"Scimitar    "
    db $DC,"Flametongue "
    db $DC,"Icebrand    "
    db $DC,"Elec>Sword  "
    db "             "
    db "             "
    db $DC,"Blood>Sword "
    db $DC,"Imperial    "
    db $DC,"Rune>Blade  "
    db $DC,"Falchion    "
    db $DC,"Soul>Sabre  "
    db "             "
    db $DC,"Excalibur   "
    db $DC,"Zantetsuken "
    db $DC,"Illumina    "
    db $DC,"Apocalypse  "
    db $DC,"Atma>Weapon "
    db $DD,"Mythril>Pike"
    db $DD,"Trident     "
    db $DD,"Stout>Spear "
    db $DD,"Partisan    "
    db $DD,"Longinus    "
    db $DD,"Fire>Lance  "
    db $DD,"Gungnir     "
    db $DD,"Pointy>Stick"
    db $DB,"Tanto       "
    db $DB,"Kunai       "
    db $DB,"Sakura      "
    db $DB,"Ninjato     "
    db $DB,"Kagenui     "
    db $DB,"Orochi      "
    db $DF,"Hanzo       "
    db $DF,"Kotetsu     "
    db $DF,"Ichimonji   "
    db $DF,"Kazekiri    "
    db $DF,"Murasame    "
    db $DF,"Masamune    "
    db $DF,"Spoon       "
    db $DF,"Mutsunokami "
    db $E1,"Spook>Stick "
    db $E1,"Magus>Rod   "
    db $E1,"Fire>Rod    "
    db $E1,"Ice>Rod     "
    db $E1,"Thunder>Rod "
    db $E1,"Windbreaker "
    db $E1,"Doomstick   "
    db $E1,"Quartrstaff "
    db $E1,"Punisher    "
    db "             "
    db $E2,"Light>Brush "
    db $E2,"Monet>Brush "
    db $E2,"Dali>Brush  "
    db $E2,"Ross>Brush  "
    db $D9,"Shuriken    "
    db "             "
    db $D9,"Ninja>Star  "
	db $E3,"Club        "
    db $D7,"Full>Moon   "
    db $E3,"Morning>Star"
    db $D7,"Boomerang   "
    db $D7,"Rising>Sun  "
    db $E3,"Kusarigama  "
    db $E3,"Bone>Club   "
    db $E3,"Magic>Bone  "
    db $D7,"Wing>Edge   "
    db $DE,"Hell>Claw   "
    db $E0,"Darts       "
    db $E0,"Tarot       "
    db $E0,"Viper>Darts "
    db $E0,"Dice        "
    db $E0,"Fixed>Dice  "
    db $DE,"Mythril>Claw"
    db $DE,"Light>Claw  "
    db $DE,"Poison>Claw "
    db $DE,"Ocean>Claw  "
    db $DE,"Hell>Claw   "
    db $DE,"Frostgore   "
    db $DE,"Stormfang   "
    db $E4,"Buckler     "
    db $E4,"Iron>Shield "
    db $E4,"Targe       "
    db $E4,"Gold>Shield "
    db $E4,"Aegis>Shield"
    db $E4,"Diamond>Kite"
    db $E4,"Flameguard  "
    db $E4,"Iceguard    "
    db $E4,"Thunderguard"
    db $E4,"Crystal>Kite"
    db $E4,"Genji>Shield"
    db $E4,"Multiguard  "
    db $E4,"Hero>Shield "
    db $E4,"Hero>Shield "
    db $E4,"Force>Shield"
    db $E5,"Leather>Hat "
    db $E5,"Hair>Band   "
    db $E5,"Plumed>Hat  "
    db $E5,"Ninja>Mask  "
    db $E5,"Magus>Hat   "
    db $E5,"Bandana     "
    db $E5,"Iron>Helm   "
    db $E5,"Skull>Cap   "
    db $E5,"Stat>Hat    "
    db $E5,"Green>Beret "
    db "             "
    db $E5,"Mythril>Helm"
    db $E5,"Tiara       "
    db $E5,"Gold>Helm   "
    db $E5,"Tiger>Mask  "
    db $E5,"Red>Cap     "
    db $E5,"Mystery>Veil"
    db $E5,"Circlet     "
    db $E5,"Dragon>Helm "
    db $E5,"Diamond>Helm"
    db $E5,"Dark>Hood   "
    db $E5,"Crystal>Helm"
    db $E5,"Oath>Veil   "
    db $E5,"Cat>Hood    "
    db $E5,"Genji>Helm  "
    db "             "
    db "             "
    db $E6,"Hard>Leather"
    db $E6,"Cotton>Robe "
    db $E6,"Karate>Gi   "
    db $E6,"Iron>Armor  "
    db "             "
    db $E6,"Mythril>Vest"
    db $E6,"Ninja>Gear  "
    db $E6,"White>Dress "
    db $E6,"Mythril>Mail"
    db $E6,"Gaia>Gear   "
    db $E6,"Mirage>Vest "
    db $E6,"Gold>Armor  "
    db $E6,"Power>Armor "
    db $E6,"Light>Robe  "
    db $E6,"Diamond>Vest"
    db $E6,"Royal>Jacket"
    db $E6,"Force>Armor "
    db $E6,"Diamond>Mail"
    db $E6,"Dark>Gear   "
    db "             "
    db $E6,"Crystal>Mail"
    db $E6,"Radiant>Gown"
    db $E6,"Genji>Armor "
    db $E6,"Lazy>Shell  "
    db $E6,"Minerva     "
    db $E6,"Tabby>Hide  "
    db $E6,"Gator>Hide  "
    db $E6,"Chocobo>Hide"
    db $E6,"Moogle>Hide "
    db $E6,"Dragon>Hide "
    db $E6,"Snow>Muffler"
    db $D8,"Noiseblaster"
    db $D8,"Bio>Blaster "
    db $D8,"Flash       "
    db $D8,"Chainsaw    "
    db $D8,"Defibr",$EC,$ED,"ator"
    db $D8,"Drill       "
    db $D8,"Mana>Battery"
    db $D8,"Autocrossbow"
    db $DA,"Fire>Scroll "
    db $DA,"Wave>Scroll "
    db $DA,"Bolt>Scroll "
    db $DA,"Fade>Scroll "
    db $DA,"Smoke>Bomb  "
    db $E7,"Leo's>Crest "
    db $E7,"Bracelet    "
    db $E7,"Spirit>Stone"
    db $E7,"Amulet      "
    db $E7,"White>Cape  "
    db $E7,"Talisman    "
    db $E7,"Fairy>Charm "
    db $E7,"Barrier>Cube"
    db $E7,"Safety>Glove"
    db $E7,"Guard>Ring  "
    db $E7,"Sprint>Shoes"
    db $E7,"Reflect>Ring"
    db "             "
    db $EB,"Gum>Pod     "
    db $E7,"Knight>Cape "
    db $E7,"Dragoon>Seal"
    db $E7,"Zephyr>Cape "
    db $E7,"Mystery>Egg "
    db $E7,"Black>Heart "
    db $E7,"Magic>Cube  "
    db $E7,"Power>Glove "
    db $E7,"Blizzard>Orb"
    db $E7,"Psycho>Belt "
    db $E7,"Rogue>Cloak "
    db $E7,"Wall>Ring   "
    db $E7,"Hero>Ring   "
    db $E7,"Ribbon      "
    db $E7,"Muscle>Belt "
    db $E7,"Crystal>Orb "
    db $E7,"Goggles     "
    db $E7,"Soul>Box    "
    db $E7,"Thief>Glove "
    db "             "
    db "             "
    db $E7,"Hyper>Wrist "
    db "             "
    db "             "
    db "             "
    db $E7,"Heiji's>Coin"
    db $E7,"Sage>Stone  "
    db $E7,"Gem>Box     "
    db $E7,"Nirvana>Band"
    db $E7,"Economizer  "
    db $E7,"Memento>Ring"
    db $E7,"Quartz>Charm"
    db $E7,"Ghost>Ring  "
    db $E7,"Moogle>Charm"
    db $E7,"Black>Belt  "
    db $E7,"Peace>Ring  "
    db $E7,"Back>Guard  "
    db $E7,"Gale>Hairpin"
    db $E7,"Stat>Stick  "
    db $E7,"Daryl's>Soul"
    db $E7,"Life>Bell   "
    db $E7,"Charm>Bangle" 
    db $EB,"Rename>Card "
    db $EB,"Tonic       "
    db $EB,"Potion      "
    db $EB,"X-Potion    "
    db $EB,"Tincture    "
    db $EB,"Ether       "
    db $EB,"X-Ether     "
    db $EB,"Elixir      "
    db $EB,"Megalixir   "
    db $EB,"Phoenix>Down"
    db $EB,"Holy>Water  "
    db $EB,"Antidote    "
    db $EB,"Eyedrops    "
    db $EB,"Snake>Oil   "
    db $EB,"Remedy      "
    db $EB,"Scrap       "
    db $EB,"Tent        "
    db $EB,"Green>Cherry"
    db $EB,"Phoenix>Tear"
    db $EB,"Bouncy>Ball "
    db $EB,"Chocobo>Wing"
    db $EB,"Hero>Drink  "
    db $EB,"Warp>Whistle"
    db $EB,"Dried>Meat  "

;Claw buff

org $D859E4 
    db $12      ;Spirit Claw> counter-attack
org $D859FF 
    db $10      ;Poison Claw> HP+
org $D85A20 
    db $12      ;Ocean Claw> counter-attack
org $D85A3B 
    db $04      ;Hell Claw> HP++
org $D85A5C
    db $12      ;Frostgore> counter-attack
org $D85A77 
    db $08      ;Stormfang> HP+++

;Royal Jacket (no hp bonus, spellcast up, auto-safe)
org $D86142
    db $40,$00,$00,$00,$80

;Radiant Gown (no mp bonus, auto-shell)
org $D861F6
    db $20,$00

;fix Gale Hairpin stat (from +3 stam to +3 magic)    
org $D86A8D 
	db $30

;former Mythril Rod may cast Rasp
org $D8562A 
	db $5A

;Rune Blade value 20k GP and FC escape chest content
org $D85274
    db $20,$4E
org $ED8B64
    db $40,$14

;Morning Star (Anti-human)

; update per-target jump table entry of weapon effect $05
org $C23DD7 : dw $38F2  ; double damage to humans

; -----------------------------------------------------------------------------
; This overhaul makes Sketch always hit and changes the random weapon proc
; rates of brushes. The "High Sketch Rate" property that's already set on every
; brush will be repurposed into a "Use Brush Odds" property.
; -----------------------------------------------------------------------------

; occupied by "Check Sketch/Control Success" routine (no longer needed)
!free = $C23792
!warn #= !free+36

; update hook to new "RandomCast" routine
org $C23651 : JSR RandomCast

; make Sketch always hit by removing a conditional branch (this also removes
; the only call to the "Check Sketch/Control Success" routine)
org $C23B3D : NOP #5

; replaces the old "RandomCast" routine
org !free
RandomCast:         ; 33 bytes
    JSR $4B5A       ; random(256)
    PHA             ; store ^
    LDA $3C58,X     ; relic effects byte 3
    PHP             ; store n = "High Proc Rate" bit
    LDA $3C45,X     ; relic effects byte 2
    BIT #$04        ; check "Use Brush Odds"
    BNE .brush_odds ; branch if ^
    PLP             ; restore "High Proc Rate" bit
    BMI .one_in_two ; branch if ^
    PLA             ; restore random(256)
    CMP #$40        ; 1/4 chance for random weapon proc
    RTS
.one_in_two
    PLA             ; restore random(256)
    CMP #$80        ; 1/2 chance for random weapon proc
    RTS
.brush_odds
    PLP             ; restore "High Proc Rate" bit
    BPL .one_in_two ; branch if not ^
    PLA             ; restore random(256)
    CMP #$C0        ; 3/4 chance for random weapon proc
    RTS
warnpc !warn

; Light Brush
org $D85732 : db $00    ; remove "X-Fight"
org $D8573A : db $64    ; Attack = 100

; Monet Brush
org $D85750 : db $00    ; remove "X-Fight"
org $D85758 : db $78    ; Attack = 120

; Dali Brush
org $D8576E : db $00    ; remove "X-Fight"
org $D85776 : db $8C    ; Attack = 140

; Ross Brush
org $D8578C : db $00    ; remove "X-Fight"
org $D85794 : db $A0    ; Attack = 160

; Brushes procs

org $D85738
    db $62      ;Light Brush proc Safe

org $D85756
    db $63      ;Monet Brush proc Shell

org $D85774
    db $68      ;Dali Brush proc Reflect

org $D85792
    db $64      ;Ross Brush proc Haste
;
org $D8529F
	db $04		;Brush proc rate active on Soul Sabre

; printme discrepancies fixes

org $D858CC
	db $28		;Magic Bone equippable by Gau/Umaro

org $D859CA
	db $02		;+2 Vigor to Mythril Claw

; create dummy Hell Claw (id=$4D)
org $D2B6E9 : db $DE,"Hell>Claw   "
org $D1008E : db $01    ; throw gfx = thin knife

;rare items
org $CEFC08
    db "Coral        "		; Booty
    db "Books        "		; Filth
