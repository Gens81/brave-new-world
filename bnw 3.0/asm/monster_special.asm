;------------------------------------------------------------------
;Monsters list
;------------------------------------------------------------------

org $CFC050

    db "Guard     " 	;000       Guard
    db "Soldier   " 	;001     Soldier
    db "Phalanx   " 	;002     Phalanx
    db "Ninja     " 	;003       Ninja
    db "Samurai   " 	;004     Samurai
    db "Shokan    " 	;005      Shokan
    db "Mag>Roader" 	;006  Mag Roader
    db "Retainer  " 	;007    Retainer
    db "Conjurer  " 	;008    Conjurer
    db "Dahling   " 	;009     Dahling
    db "Parasoul  " 	;010    Parasoul
    db "Scrapper  " 	;011    Scrapper
    db "Gargoyle  " 	;012    Gargoyle
    db "Wrexsoul  " 	;013    Wrexsoul
    db "Spirit    " 	;014      Spirit
    db "Lich      " 	;015        Lich
	db "          " 	;016            
    db "Officer   " 	;017     Officer
    db "Foamy     " 	;018       Foamy
    db "Sewer>Rat " 	;019   Sewer Rat
	db "          " 	;020            
    db "Rhyhorn   " 	;021     Rhyhorn
    db "Ogre>Nix  " 	;022    Ogre Nix
    db "Leafer    " 	;023      Leafer
    db "Stray>Cat " 	;024   Stray Cat
    db "Lobo      " 	;025        Lobo
    db "Banshee   " 	;026     Banshee
    db "Mammoth   " 	;027     Mammoth
    db "Pooch     " 	;028       Pooch
    db "Adamantite" 	;029  Adamantite
    db "Suriander " 	;030   Suriander
    db "Chimera   " 	;031     Chimera
    db "Behemoth  " 	;032    Behemoth
    db "Mesosaur  " 	;033    Mesosaur
    db "Albatross " 	;034   Albatross
    db "Fossilfang" 	;035  Fossilfang
    db "White-D   " 	;036     White-D
    db "Shemp     " 	;037       Shemp
	db "          " 	;038            
    db "Tyrano    " 	;039      Tyrano
    db "Raven     " 	;040       Raven
    db "Beakor    " 	;041      Beakor
    db "Buzzard   " 	;042     Buzzard
	db "          " 	;043            
    db "Mudcrab   " 	;044     Mudcrab
    db "Cyborg    " 	;045      Cyborg
    db "Hornet    " 	;046      Hornet
    db "Cricket   " 	;047     Cricket
    db "Beetle    " 	;048      Beetle
	db "          " 	;049            
    db "Trillium  " 	;050    Trillium
    db "Nightshade" 	;051  Nightshade
    db "Tumbleweed" 	;052  Tumbleweed
    db "Plantpire " 	;053   Plantpire
    db "Trilobite " 	;054   Trilobite
    db "Siegfried " 	;055   Siegfried
    db "Nautiloid " 	;056   Nautiloid
    db "Exocite   " 	;057     Exocite
    db "Anguiform " 	;058   Anguiform
    db "Leap>Frog " 	;059   Leap Frog
    db "Basilisk  " 	;060    Basilisk
    db "Chickenlip" 	;061  Chickenlip
    db "Sand>Worm " 	;062   Sand Worm
    db "Thanatos  " 	;063    Thanatos
	db "Chupon    " 	;064      Chupon
    db "Onion>Kid " 	;065   Onion Kid
    db "Tek>Armor " 	;066   Tek Armor
    db "Sky>Armor " 	;067   Sky Armor
    db "Telstar   " 	;068     Telstar
    db "WEAPON    " 	;069      WEAPON
    db "Vaporite  " 	;070    Vaporite
    db "Flan      " 	;071        Flan
    db "Jinn      " 	;072        Jinn
    db "Humpty    " 	;073      Humpty
    db "Brainpan  " 	;074    Brainpan
    db "Cave>Stuff" 	;075  Cave Stuff
    db "Cactuar   " 	;076     Cactuar
	db "          " 	;077            
    db "Hobo      " 	;078        Hobo
    db "Bomb      " 	;079        Bomb
    db "          " 	;080            
    db "Boxxy     " 	;081       Boxxy
    db "Slamdancer" 	;082  Slamdancer
    db "Giant     " 	;083       Giant
    db "Pug       " 	;084         Pug
    db "Magic>Pot " 	;085   Magic Pot
	db "          " 	;086            
	db "          " 	;087            
    db "Buffalax  " 	;088    Buffalax
    db "Eukaryote " 	;089   Eukaryote
    db "Wight     " 	;090       Wight
    db "Troll     " 	;091       Troll
    db "Sand>Ray  " 	;092    Sand Ray
    db "Antlion   " 	;093     Antlion
    db "Sea>Flower" 	;094  Sea Flower
    db "Sand>Devil" 	;095  Sand Devil
    db "Europa    " 	;096      Europa
    db "Marlboro  " 	;097    Marlboro
    db "Crawler   " 	;098     Crawler
    db "Eye Goo   " 	;099     Eye Goo
    db "Captain   " 	;100     Captain
    db "Trooper   " 	;101     Trooper
    db "Templar   " 	;102     Templar
    db "Shinobi   " 	;103     Shinobi
    db "Tarokan   " 	;104     Tarokan
    db "Warlock   " 	;105     Warlock
    db "Maiden    " 	;106      Maiden
    db "Rain>Man  " 	;107    Rain Man
    db "Fighter   " 	;108     Fighter
    db "Mephisto  " 	;109    Mephisto
	db "          " 	;110            
    db "Powerslave" 	;111  Powerslave
    db "Osteosaur " 	;112   Osteosaur
    db "Doberman  " 	;113    Doberman
    db "Rocky     " 	;114       Rocky
    db "Plague>Rat" 	;115  Plague Rat
    db "Black>Bear" 	;116  Black Bear
    db "Rhydon    " 	;117      Rhydon
    db "Rabite    " 	;118      Rabite
    db "Wild>Cat  " 	;119    Wild Cat
    db "Red>Wolf  " 	;120    Red Wolf
    db "Rottweiler" 	;121  Rottweiler
    db "Tusker    " 	;122      Tusker
    db "Doggo     " 	;123       Doggo
	db "          " 	;124            
    db "Wart>Puck " 	;125   Wart Puck
    db "Manticore " 	;126   Manticore
    db "Intangir>Z" 	;127  Intangir Z
    db "Raptor    " 	;128      Raptor
    db "Wyvern    " 	;129      Wyvern
    db "Zombone   " 	;130     Zombone
	db "          " 	;131            
    db "Brontosaur" 	;132  Brontosaur
	db "Dinosaur  " 	;133    Dinosaur
    db "Cockatrice" 	;134  Cockatrice
    db "Windrunner" 	;135  Windrunner
    db "Vulture   " 	;136     Vulture
    db "Griffin   " 	;137     Griffin
    db "Hermit    " 	;138      Hermit
    db "Robot     " 	;139       Robot
	db "          " 	;140            
    db "Dragonfly " 	;141   Dragonfly
    db "Scarab    " 	;142      Scarab
    db "Zorathian " 	;143   Zorathian
    db "Mandrake  " 	;144    Mandrake
    db "Belladonna" 	;145  Belladonna
    db "Atlasphere" 	;146  Atlasphere
    db "Weedula   " 	;147     Weedula
    db "Primordite" 	;148  Primordite
    db "Callisto  " 	;149    Callisto
    db "Cephalid  " 	;150    Cephalid
    db "Clawglip  " 	;151    Clawglip
    db "Frogger   " 	;152     Frogger
    db "Komodo    " 	;153      Komodo
    db "Cluck     " 	;154       Cluck
    db "Land>Worm " 	;155   Land Worm
    db "Reaper    " 	;156      Reaper
    db "Ganymede  " 	;157    Ganymede
    db "Tiny>Tim  " 	;158    Tiny Tim
    db "Mega>Armor" 	;159  Mega Armor
    db "Chaser    " 	;160      Chaser
    db "Warmech   " 	;161     Warmech
    db "Ectoplasm " 	;162   Ectoplasm
	db "          " 	;163            
    db "Djinni    " 	;164      Djinni
    db "Dumpty    " 	;165      Dumpty
    db "Pond>Scum " 	;166   Pond Scum
    db "Puff>Goo  " 	;167    Puff Goo
    db "Mechanix  " 	;168    Mechanix
    db "Drifter   " 	;169     Drifter
    db "Grenade   " 	;170     Grenade
    db "Succubus  " 	;171    Succubus
    db "Pan Dora  " 	;172    Pan Dora
    db "Souldancer" 	;173  Souldancer
    db "Colossus  " 	;174    Colossus
    db "Mag>Roadie" 	;175  Mag Roadie
	db "          " 	;176            
    db "Prokaryote" 	;177  Prokaryote
	db "          " 	;178            
    db "Scorpion  " 	;179    Scorpion
    db "Sponge    " 	;180      Sponge
    db "Sea>Devil " 	;181   Sea Devil
	db "          " 	;182            
	db "Devil>Weed" 	;183  Devil Weed
    db "Slurm     " 	;184       Slurm
    db "Latimeria " 	;185   Latimeria
    db "Zombie    " 	;186      Zombie
    db "Bonelord  " 	;187    Bonelord
    db "Mu        " 	;188          Mu
    db "Assassin  " 	;189    Assassin
    db "Madam     " 	;190       Madam
    db "Umbro     " 	;191       Umbro
    db "Specter   " 	;192     Specter
    db "Gorokan   " 	;193     Gorokan
	db "          " 	;194            
	db "Dark>Hare " 	;195   Dark Hare
    db "Wizard    " 	;196      Wizard
    db "Brawler   " 	;197     Brawler
    db "Rhyperior " 	;198   Rhyperior
    db "Commando  " 	;199    Commando
    db "Opinicus  " 	;200    Opinicus
    db "Nutkin    " 	;201      Nutkin
    db "Lunaris   " 	;202     Lunaris
    db "Foxhound  " 	;203    Foxhound
    db "Condor    " 	;204      Condor
    db "Hoodwink  " 	;205    Hoodwink
    db "Nastidon  " 	;206    Nastidon
	db "          " 	;207            
	db "Locust    " 	;208      Locust
    db "Vermin    " 	;209      Vermin
    db "Mantodea  " 	;210    Mantodea
    db "Chupacabra" 	;211  Chupacabra
    db "Grizzly   " 	;212     Grizzly
    db "Necrosaur " 	;213   Necrosaur
    db "Adamantoid" 	;214  Adamantoid
    db "Death     " 	;215       Death
    db "Dactyl    " 	;216      Dactyl
	db "          " 	;217            
    db "Fuzzy     " 	;218       Fuzzy
	db "Tofu      " 	;219        Tofu
    db "O-Bake    " 	;220      O-Bake
    db "Vagrant   " 	;221     Vagrant
	db "          " 	;222            
	db "Repo>Man  " 	;223    Repo Man
    db "Diablos   " 	;224     Diablos
	db "          " 	;225            
	db "          " 	;226            
	db "Spitfire  " 	;227    Spitfire
    db "Sphinx    " 	;228      Sphinx
    db "Wraith    " 	;229      Wraith
    db "Osprey    " 	;230      Osprey
    db "Hot>Wheels" 	;231  Hot Wheels
    db "Wasp      " 	;232        Wasp
    db "Anemone   " 	;233     Anemone
    db "Arsenal   " 	;234     Arsenal
    db "Racer     " 	;235       Racer
    db "Roc       " 	;236         Roc
    db "Android   " 	;237     Android
    db "Kudzu     " 	;238       Kudzu
    db "Junkie    " 	;239      Junkie
    db "Tapdancer " 	;240   Tapdancer
    db "Revenant  " 	;241    Revenant
    db "Titan     " 	;242       Titan
    db "Low>Rider " 	;243   Low Rider
	db "          " 	;244            
    db "Gold>Bear " 	;245   Gold Bear
    db "Searcher  " 	;246    Searcher
    db "Witch     " 	;247       Witch
    db "Werewolf  " 	;248    Werewolf
    db "Didalos   " 	;249     Didalos
    db "Fiend     " 	;250       Fiend
    db "Ahriman   " 	;251     Ahriman
    db "Autobot   " 	;252     Autobot
    db "Iron>Man  " 	;253    Iron Man
    db "Io        " 	;254          Io
    db "Tonberry  " 	;255    Tonberry
    db "Whelk     " 	;256       Whelk
    db "Chesticle " 	;257   Chesticle
    db "Robomech  " 	;258    Robomech
    db "Vargas    " 	;259      Vargas
    db "Hell>Angel" 	;260  Hell Angel
    db "Prometheus" 	;261  Prometheus
    db "Soul>Train" 	;262  Soul Train
    db "Dadaluma  " 	;263    Dadaluma
    db "Shiva     " 	;264       Shiva
    db "Ifrit     " 	;265       Ifrit
    db "Number>024" 	;266  Number 024
    db "Number>128" 	;267  Number 128
    db "Inferno   " 	;268     Inferno
    db "Crane     " 	;269       Crane
	db "          " 	;270            
	db "          " 	;271            
    db "Yeti      " 	;272        Yeti
	db "Guardian  " 	;273    Guardian
    db "Guardian  " 	;274    Guardian
    db "IAF       " 	;275         IAF
    db "Esper...? " 	;276   Esper...?
    db "Esper...? " 	;277   Esper...?
    db "Heartfire " 	;278   Heartfire
    db "Atma      " 	;279        Atma
	db "Nimufu    " 	;280      Nimufu
    db "Intangir  " 	;281    Intangir
    db "          " 	;282            
    db "Tentacle>A" 	;283  Tentacle A
    db "Dullahan  " 	;284    Dullahan
    db "Doom>Gaze " 	;285   Doom Gaze
    db "Lakshmi   " 	;286     Lakshmi
    db "Curly     " 	;287       Curly
    db "Larry     " 	;288       Larry
    db "Moe       " 	;289         Moe
    db "          " 	;290            
    db "Hidon     " 	;291       Hidon
    db "Katanasoul" 	;292  Katanasoul
    db "Lv.4>Mage " 	;293   Lv.4 Mage
    db $BE,"Blinky   "	;294     !Blinky
    db "Asura     " 	;295       Asura
    db "Isis      " 	;296        Isis
    db "Myria     " 	;297       Myria
    db "Kefka     " 	;298       Kefka
    db "Lv.3>Mage " 	;299   Lv.3 Mage
    db "Ultros    " 	;300      Ultros
    db "Ultros    " 	;301      Ultros
	db "Ultros    " 	;302      Ultros
    db "Chupon    " 	;303      Chupon
    db "Lv.2>Mage " 	;304   Lv.2 Mage
    db "Ziegfried " 	;305   Ziegfried
    db "Lv.1>Mage " 	;306   Lv.1 Mage
	db "Lv.5>Mage " 	;307   Lv.5 Mage
    db $BE,"Whelk    " 	;308      !Whelk
    db $BE,"Chesticle" 	;309  !Chesticle
    db "          " 	;310            
	db "Kaiser    " 	;311      Kaiser
	db "Master>T  " 	;312    Master T
    db "Lv.8>Mage " 	;313   Lv.8 Mage
    db "Merchant  " 	;314    Merchant
    db "Nude>Dude " 	;315   Nude Dude
    db "Tentacle>B" 	;316  Tentacle B
    db "Tentacle>C" 	;317  Tentacle C
    db "Tentacle>D" 	;318  Tentacle D
    db $BE,"Rapier   " 	;319     !Rapier
    db $BE,"Saber    " 	;320      !Saber
    db $BE,"Striker  " 	;321    !Striker
    db $BE,"Rake     " 	;322       !Rake
    db "Lv.9>Mage " 	;323   Lv.9 Mage
    db "Esper...? " 	;324   Esper...?
    db $BE,"Right>Bay" 	;325  !Right Bay
    db "          " 	;326            
    db $BE,"Left>Bay " 	;327   !Left Bay
    db "Chadarnook" 	;328  Chadarnook
    db "Silver-D  " 	;329    Silver-D
    db "Kefka     " 	;330       Kefka
    db "Purple-D  " 	;331    Purple-D
    db "Brown-D   " 	;332     Brown-D
    db "Bear      " 	;333        Bear
    db "Templar   " 	;334     Templar
	db "          " 	;335            
	db "Gold-D    " 	;336      Gold-D
    db "Green-D   " 	;337     Green-D
    db "Blue-D    " 	;338      Blue-D
    db "Red-D     " 	;339       Red-D
    db "Piranha   " 	;340     Piranha
    db "Rizopas   " 	;341     Rizopas
    db "Phantom   " 	;342     Phantom
    db "Limbo     " 	;343  !Short Arm
    db "Lust      " 	;344   !Long Arm
    db "Gluttony  " 	;345       !Face
    db "Wrath     " 	;346      !Tiger
    db "Greed     " 	;347      !Tools
    db "Heresy    " 	;348      !Magic
    db "Violence  " 	;349        !Hit
    db "Fraud     " 	;350       !Girl
    db "Treachery " 	;351      !Sleep
    db $BE,"Pinky    " 	;352      !Pinky
    db $BE,"Kinky    " 	;353      !Kinky
    db $BE,"Clyde    " 	;354      !Clyde
    db "Lv.6>Mage " 	;355   Lv.6 Mage
    db "Lv.7>Mage " 	;356   Lv.7 Mage
    db "Proto>Man " 	;357   Proto Man
    db "MagiMaster" 	;358  MagiMaster
	db "Soulblazer" 	;359  Soulblazer
	db "Ultros    " 	;360      Ultros
    db "Bat>Lady  " 	;361    Bat Lady
	db "Phunbaba  " 	;362    Phunbaba
	db "Phunbaba  " 	;363    Phunbaba
	db "Phunbaba  " 	;364    Phunbaba
	db "          " 	;365            
    db "(Event)   " 	;366     (Event)
	db "(Event)   " 	;367     (Event)
	db $BE,"Cyan     "	;368       !Cyan
	db "Zone>Eater" 	;369  Zone Eater
	db $BE,"Gau      " 	;370        !Gau
    db "(Event)   " 	;371     (Event)
    db "          " 	;372            
	db "Trooper   " 	;373     Trooper
	db "Centurion " 	;374   Centurion
	db "Kefka     " 	;375       Kefka
	db "          " 	;376            
	db "Recruit   " 	;377     Recruit
    db "(Event)   " 	;378     (Event)
	db "(Event)   " 	;379     (Event)
    db "          " 	;380            
    db "Ultima    " 	;381      Ultima
    db "          " 	;382
    db "          " 	;383
	
warnpc $CFD0CF


;------------------------
;Monsters specials
;------------------------
;		Special	  	 ID	 	 Monster

org $CFD0D0

    db "Aboot     " ;000       Guard
    db "Blow      " ;001     Soldier
    db "Cut       " ;002     Phalanx
    db "Vanish    " ;003       Ninja
    db "Eviscerate" ;004     Samurai
    db "Taint     " ;005      Shokan
    db "Wheelie   " ;006  Mag Roader
    db "Disembowel" ;007    Retainer
    db "Frazzle   " ;008    Conjurer
    db "Speechless" ;009     Dahling
    db "Ella      " ;010    Parasoul
    db "Punch     " ;011    Scrapper
    db "Enrage    " ;012    Gargoyle
    db "Karma     " ;013    Wrexsoul
    db "Nightmare " ;014      Spirit
    db "Deja>Vu   " ;015        Lich
	db "          " ;016            
    db "Thrust    " ;017     Officer
    db "Spoot     " ;018       Foamy
    db "Bite      " ;019   Sewer Rat
	db "          " ;020            
    db "Bash      " ;021     Rhyhorn
    db "Chokeslam " ;022    Ogre Nix
    db "Nibble    " ;023      Leafer
    db "Catscratch" ;024   Stray Cat
    db "Fang      " ;025        Lobo
    db "Shriek    " ;026     Banshee
    db "Stomp     " ;027     Mammoth
    db "Snap      " ;028       Pooch
    db "Gash      " ;029  Adamantite
    db "Yawn      " ;030   Suriander
    db "Provoke   " ;031     Chimera
    db "Pound     " ;032    Behemoth
    db "Nail      " ;033    Mesosaur
    db "Whack     " ;034   Albatross
    db "Bone      " ;035  Fossilfang
    db "D-Claw    " ;036     White-D
    db "          " ;037       Shemp
	db "          " ;038            
    db "Thrash    " ;039      Tyrano
    db "Nevermore " ;040       Raven
    db "Angel>Dust" ;041      Beakor
    db "Blind     " ;042     Buzzard
	db "          " ;043            
    db "Snip      " ;044     Mudcrab
    db "Control   " ;045      Cyborg
    db "Needler   " ;046      Hornet
    db "Chirp     " ;047     Cricket
    db "Zap       " ;048      Beetle
	db "          " ;049            
    db "Bane      " ;050    Trillium
    db "Spore>Pod " ;051  Nightshade
    db "Suck      " ;052  Tumbleweed
    db "Evil>Dead " ;053   Plantpire
    db "Barb      " ;054   Trilobite
    db "Mishamune " ;055   Siegfried
    db "Ink       " ;056   Nautiloid
    db "Pinch     " ;057     Exocite
    db "Wrap      " ;058   Anguiform
    db "Tongue    " ;059   Leap Frog
    db "Stoneskin " ;060    Basilisk
    db "Lick      " ;061  Chickenlip
    db "Crush     " ;062   Sand Worm
    db "Pike      " ;063    Thanatos
	db "Sneeze    " ;064      Chupon
    db "Trigger   " ;065   Onion Kid
    db "Metal>Fist" ;066   Tek Armor
    db "Jettison  " ;067   Sky Armor
    db "Spazer    " ;068     Telstar
    db "Ruby>Blast" ;069      WEAPON
    db "Mist      " ;070    Vaporite
    db "Goo       " ;071        Flan
    db "Hex       " ;072        Jinn
    db "Hug       " ;073      Humpty
    db "Stop      " ;074    Brainpan
    db "Grope     " ;075  Cave Stuff
    db "8=====D>~ " ;076     Cactuar
	db "          " ;077            
    db "Hook      " ;078        Hobo
    db "Bang      " ;079        Bomb
    db "          " ;080            
    db "Mystify   " ;081       Boxxy
    db "Whiskey   " ;082  Slamdancer
    db "Shocker   " ;083       Giant
    db "Stab      " ;084         Pug
    db "Slap      " ;085   Magic Pot
	db "          " ;086            
	db "          " ;087            
    db "Charge    " ;088    Buffalax
    db "Violate   " ;089   Eukaryote
    db "Subcon    " ;090       Wight
    db "Lulz      " ;091       Troll
    db "Prick     " ;092    Sand Ray
    db "Stunner   " ;093     Antlion
    db "Spine     " ;094  Sea Flower
    db "Beat      " ;095  Sand Devil
    db "Apollo    " ;096      Europa
    db "Drool     " ;097    Marlboro
    db "Swallow   " ;098     Crawler
    db "Slumber   " ;099     Eye Goo
    db "Strike    " ;100     Captain
    db "Bayonet   " ;101     Trooper
    db "Hew       " ;102     Templar
    db "Clear     " ;103     Shinobi
    db "Corrupt   " ;104     Tarokan
    db "Hush      " ;105     Warlock
    db "Loveless  " ;106      Maiden
    db "Umbrella  " ;107    Rain Man
    db "Kick      " ;108     Fighter
    db "Seeing>Red" ;109    Mephisto
	db "          " ;110            
    db "Ed>Hunter " ;111  Powerslave
    db "Harden    " ;112   Osteosaur
    db "Assault   " ;113    Doberman
    db "Spluff    " ;114       Rocky
    db "Plague    " ;115  Plague Rat
    db "Blacked   " ;116  Black Bear
    db "Ram       " ;117      Rhydon
    db "Gnaw      " ;118      Rabite
    db "ChopChop  " ;119    Wild Cat
    db "Red>Fang  " ;120    Red Wolf
    db "Battery   " ;121  Rottweiler
    db "Tusk      " ;122      Tusker
    db "Chomp     " ;123       Doggo
	db "          " ;124            
    db "Snooze    " ;125   Wart Puck
    db "Fury      " ;126   Manticore
    db "Jam       " ;127  Intangir Z
    db "Shred     " ;128      Raptor
    db "Swing     " ;129      Wyvern
    db "Boner     " ;130     Zombone
	db "          " ;131            
    db "Smack     " ;132  Brontosaur
	db "Snu>Snu   " ;133    Dinosaur
    db "Gaze      " ;134  Cockatrice
    db "Bath>Salts" ;135  Windrunner
    db "Blindmore " ;136     Vulture
    db "Red>Talon " ;137     Griffin
    db "Vicegrip  " ;138      Hermit
    db "Alt       " ;139       Robot
	db "          " ;140            
    db "Buzz      " ;141   Dragonfly
    db "Blast     " ;142      Scarab
    db "Impsickle " ;143   Zorathian
    db "Toxic     " ;144    Mandrake
    db "Bio>Spore " ;145  Belladonna
    db "Roll      " ;146  Atlasphere
    db "Dead>Alive" ;147     Weedula
    db "Pincer    " ;148  Primordite
    db "Craterize " ;149    Callisto
    db "Molest    " ;150    Cephalid
    db "Clamp     " ;151    Clawglip
    db "Slurp     " ;152     Frogger
    db "Paraskin  " ;153      Komodo
    db "Gobble    " ;154       Cluck
    db "Smother   " ;155   Land Worm
    db "Lance     " ;156      Reaper
    db "Moonstrike" ;157    Ganymede
    db "Bloodlust " ;158    Tiny Tim
    db "Megabuster" ;159  Mega Armor
    db "Hyper>Beam" ;160      Chaser
    db "Cinderizer" ;161     Warmech
    db "Cling     " ;162   Ectoplasm
	db "          " ;163            
    db "Curse     " ;164      Djinni
    db "Stench    " ;165      Dumpty
    db "Frisk     " ;166   Pond Scum
    db "Dreamland " ;167    Puff Goo
    db "Pipewrench" ;168    Mechanix
    db "Knife     " ;169     Drifter
    db "Boom      " ;170     Grenade
    db "Science   " ;171    Succubus
    db "Puzzle    " ;172    Pan Dora
    db "Tango     " ;173  Souldancer
    db "Squish    " ;174    Colossus
    db "Pollute   " ;175  Mag Roadie
	db "          " ;176            
    db "Mutate    " ;177  Prokaryote
	db "          " ;178            
    db "Venom     " ;179    Scorpion
    db "Feeler    " ;180      Sponge
    db "Defeat    " ;181   Sea Devil
	db "          " ;182            
	db "Unlife    " ;183  Devil Weed
    db "Digest    " ;184       Slurm
    db "Constrict " ;185   Latimeria
    db "Infect    " ;186      Zombie
    db "Stone>Bone" ;187    Bonelord
    db "Hold      " ;188          Mu
    db "Disappear " ;189    Assassin
    db "Restless  " ;190       Madam
    db "Ella      " ;191       Umbro
    db "Nocturne  " ;192     Specter
    db "Desecrate " ;193     Gorokan
	db "          " ;194            
	db "Noms      " ;195   Dark Hare
    db "Quell     " ;196      Wizard
    db "Headbutt  " ;197     Brawler
    db "Smash     " ;198   Rhyperior
    db "Penetrate " ;199    Commando
    db "Horn      " ;200    Opinicus
    db "Spuzz     " ;201      Nutkin
    db "Black>Fang" ;202     Lunaris
    db "Foxdie    " ;203    Foxhound
    db "Peck      " ;204      Condor
    db "Band>Candy" ;205    Hoodwink
    db "Trample   " ;206    Nastidon
	db "          " ;207            
	db "Swarm     " ;208      Locust
    db "Rabies    " ;209      Vermin
    db "Gouge     " ;210    Mantodea
    db "Oogyboog  " ;211  Chupacabra
    db "Maul      " ;212     Grizzly
    db "Befoul    " ;213   Necrosaur
    db "Lacerate  " ;214  Adamantoid
    db "Impale    " ;215       Death
    db "Swat      " ;216      Dactyl
	db "          " ;217            
    db "Touch     " ;218       Fuzzy
	db "Slime     " ;219        Tofu
    db "Voodoo    " ;220      O-Bake
    db "Slash     " ;221     Vagrant
	db "          " ;222            
	db "Wrench    " ;223    Repo Man
    db "Batter    " ;224     Diablos
	db "          " ;225            
	db "          " ;226            
	db "Rotor>Gun " ;227    Spitfire
    db "Riddle    " ;228      Sphinx
    db "Impmare   " ;229      Wraith
    db "Blindmost " ;230      Osprey
    db "Tired     " ;231  Hot Wheels
    db "Stinger   " ;232        Wasp
    db "Crabs     " ;233     Anemone
    db "Rocket    " ;234     Arsenal
    db "Bad>Touch " ;235       Racer
    db "Grey>Talon" ;236         Roc
    db "Delete    " ;237     Android
    db "Virus     " ;238       Kudzu
    db "Crack>Pipe" ;239      Junkie
    db "Foxtrot   " ;240   Tapdancer
    db "Farewell  " ;241    Revenant
    db "Dominate  " ;242       Titan
    db "Exhausted " ;243   Low Rider
	db "          " ;244            
    db "Gore      " ;245   Gold Bear
    db "Silencer  " ;246    Searcher
    db "Wand      " ;247       Witch
    db "Ravage    " ;248    Werewolf
    db "Bludgeon  " ;249     Didalos
    db "Probe     " ;250       Fiend
    db "Evil>Eye  " ;251     Ahriman
    db "Impact    " ;252     Autobot
    db "Roid>Rage " ;253    Iron Man
    db "Lunar>Beam" ;254          Io
    db "Shank     " ;255    Tonberry
    db "          " ;256       Whelk
    db "          " ;257   Chesticle
    db "Disarm    " ;258    Robomech
    db "Death>Fist" ;259      Vargas
    db "Drill>Gun " ;260  Hell Angel
    db "Drilldozer" ;261  Prometheus
    db "Run>Over  " ;262  Soul Train
    db "Elbow>Drop" ;263    Dadaluma
    db "Chill     " ;264       Shiva
    db "Fever     " ;265       Ifrit
    db "Overflow  " ;266  Number 024
    db "Program666" ;267  Number 128
    db "Subversion" ;268     Inferno
    db "Cannonball" ;269       Crane
	db "          " ;270            
	db "          " ;271            
    db "Tackle    " ;272        Yeti
	db "FAKK2     " ;273    Guardian
    db "FAKK2     " ;274    Guardian
    db "          " ;275         IAF
    db "          " ;276   Esper...?
    db "          " ;277   Esper...?
    db "Smoke     " ;278   Heartfire
    db "Full>Power" ;279        Atma
	db "          " ;280      Nimufu
    db "Slam      " ;281    Intangir
    db "          " ;282            
    db "Entangle  " ;283  Tentacle A
    db "Flail     " ;284    Dullahan
    db "Doom>Gaze " ;285   Doom Gaze
    db "Death>Kiss" ;286     Lakshmi
    db "Head>Bonk " ;287       Curly
    db "Nose>Grab " ;288       Larry
    db "Eye>Poke  " ;289         Moe
    db "          " ;290            
    db "Spellbind " ;291       Hidon
    db "Slayer    " ;292  Katanasoul
    db "          " ;293   Lv.4 Mage
    db "Mega>Claw " ;294     !Blinky
    db "Loc>Nar   " ;295       Asura
    db "Turmoil   " ;296        Isis
    db "Tyrfing   " ;297       Myria
    db "Havoc>Wing" ;298       Kefka
    db "          " ;299   Lv.3 Mage
    db "Squirt    " ;300      Ultros
    db "Squirt    " ;301      Ultros
	db "Squirt    " ;302      Ultros
    db "Snort     " ;303      Chupon
    db "          " ;304   Lv.2 Mage
    db "          " ;305   Ziegfried
    db "          " ;306   Lv.1 Mage
	db "          " ;307   Lv.5 Mage
    db "          " ;308      !Whelk
    db "Coldfinger" ;309  !Chesticle
    db "          " ;310            
	db "Bonebreak " ;311      Kaiser
	db "Gank      " ;312    Master T
    db "          " ;313   Lv.8 Mage
    db "          " ;314    Merchant
    db "          " ;315   Nude Dude
    db "Entangle  " ;316  Tentacle B
    db "Entangle  " ;317    Tentacle
    db "Entangle  " ;318    Tentacle
    db "Rapier    " ;319     !Rapier
    db "Saber     " ;320      !Saber
    db "Striker   " ;321    !Striker
    db "Rake      " ;322       !Rake
    db "          " ;323   Lv.9 Mage
    db "Let>It>Go " ;324   Esper...?
    db "          " ;325  !Right Bay
    db "          " ;326            
    db "          " ;327   !Left Bay
    db "Demon>Kiss" ;328  Chadarnook
    db "D-Claw    " ;329    Silver-D
    db "Stabbles  " ;330       Kefka
    db "D-Claw    " ;331    Purple-D
    db "D-Claw    " ;332     Brown-D
    db "Bear>Claw " ;333        Bear
    db "          " ;334     Templar
	db "          " ;335            
	db "D-Claw    " ;336      Gold-D
    db "D-Claw    " ;337     Green-D
    db "D-Claw    " ;338      Blue-D
    db "D-Claw    " ;339       Red-D
    db "          " ;340     Piranha
    db "Razor>Bite" ;341     Rizopas
    db "Somnambula" ;342     Phantom
    db "Mercy     " ;343       Limbo
    db "Covet     " ;344        Lust
    db "Indulge   " ;345  	Gluttony
    db "Rage      " ;346  	   Wrath
    db "Conquest  " ;347  	   Greed
    db "Blasphemy " ;348  	  Heresy
    db "Hate      " ;349    Violence
    db "Love      " ;350  	   Fraud
    db "Peace     " ;351   Treachery
    db "Stone>Claw" ;352      !Pinky
    db "Kappa>Claw" ;353      !Kinky
    db "Crazy>Klaw" ;354      !Clyde
    db "          " ;355   Lv.6 Mage
    db "          " ;356   Lv.7 Mage
    db "Armcannon " ;357   Proto Man
    db "Overkill  " ;358  MagiMaster
	db "Doomy>Doom" ;359  Soulblazer
	db "Squirt    " ;360      Ultros
    db "Maru>Mari " ;361    Bat Lady
	db "Body>Check" ;362    Phunbaba
	db "Body>Check" ;363    Phunbaba
	db "Body>Check" ;364    Phunbaba
	db "          " ;365            
    db "          " ;366     (Event)
	db "          " ;367     (Event)
	db "          " ;368       !Cyan
	db "Pulverize " ;369  Zone Eater
	db "          " ;370        !Gau
    db "          " ;371     (Event)
    db "          " ;372            
	db "Bayonet   " ;373     Trooper
	db "Slice     " ;374   Centurion
	db "Stabbles  " ;375       Kefka
	db "          " ;376            
	db "          " ;377     Recruit
    db "          " ;378     (Event)
	db "          " ;379     (Event)
    db "          " ;380            
    db "Full>Power" ;381      Ultima
    db "          " ;382
    db "          " ;383     

warnpc $CFDFDF
