arch 65816
hirom

table "dialog.tbl",ltr 

;------------------------------------------------------------------
; Map Names
;------------------------------------------------------------------

org $CEF100
    
Map:		db "",$00
Inn:		db "Inn",$00
Blacksmith:	db "Blacksmith",$00
Armory:		db "Armory",$00
Outfitters:	db "General Outfitters",$00
Relic:		db "Relic Shop",$00
Store:		db "General Store",$00
Pub:		db "Pub",$00
Engine:		db "Engine Room",$00
B1:			db "B1",$00
B2:			db "B2",$00
B3:			db "B3",$00
B4:			db "B4",$00
Floor1:		db "1st Floor",$00
Floor2:		db "2nd Floor",$00
Floor3:		db "3rd Floor",$00
Floor4:		db "4th Floor",$00
Floor5:		db "5th Floor",$00
Floor6:		db "6th Floor",$00
Floor7:		db "7th Floor",$00
Floor8:		db "8th Floor",$00
Floor9:		db "9th Floor",$00
Floor10:	db "10th Floor",$00
Chocobo:	db "Chocobo Stable",$00
FigCastle:	db "Figaro Castle",$00
SouthFig:	db "South Figaro",$00
Returners:	db "Returner's Hideout",$00
Elder:		db "Elder's House",$00
Duncan:		db "Duncan's House",$00
MtKolts:    db "Mt. Kolts",$00
King:		db "King's Room",$00
Moogle:		db "Moogle Cave",$00
Narshe:		db "Narshe",$00
Auction:	db "Auction House",$00
Owzer:		db "Owzer's Mansion",$00
Baren:		db "Baren Falls",$00
Mobliz:		db "Mobliz",$00
Nikeah:		db "Nikeah",$00
Tzen:		db "Tzen",$00
Hideout:	db "Returner's Hideout",$00
Lete:		db "Lete River",$00
Camp:		db "Imperial Camp",$00
Doma:		db "Kingdom of Doma",$00
Forest:		db "Phantom Forest",$00
Serpent:	db "Serpent Trench",$00
Kohlingen:	db "Kohlingen",$00
Zozo:		db "Zozo",$00
Jidoor:		db "Jidoor",$00
Opera:		db "Opera House",$00
Vector:		db "Vector",$00
ImperialC:	db "Imperial Castle",$00
Magitek:	db "Magitek Research Facility",$00
Maranda:	db "Maranda",$00
Albrook:	db "Albrook",$00
Base:		db "Imperial Base",$00
Gate:		db "The Sealed Gate",$00
Thamasa:	db "Thamasa",$00
Colosseum:	db "Dragon's Neck Colosseum",$00
Tomb:		db "Daryl's Tomb",$00
Floating:	db "The Floating Continent",$00
Esperville:	db "Esperville",$00
MtZozo:		db "Mt. Zozo",$00
Factory:	db "Magitek Factory",$00
Crescent:	db "Crescent Mountain",$00
Beginner:	db "Beginner's Classroom",$00
KefkaTower:	db "Kefka's Tower",$00
Advanced:	db "Advanced Battle Tactics",$00
BattleTact:	db "Battle Tactics",$00
Science:	db "Environmental Science",$00
Sealed:		db "Cave to the Sealed Gate",$00
GenStore:	db "General Store",$00
PhoenixC:	db "Phoenix Cave",$00
Veldt:		db "Cave on the Veldt",$00
    
warnpc $CEF600

;-------------------------------
; Pointers to Map Names
;-------------------------------

org $E68400

dw 	Map-Map
dw 	Inn-Map
dw 	Blacksmith-Map
dw 	Armory-Map
dw 	Outfitters-Map
dw 	Relic-Map
dw 	Store-Map
dw 	Pub-Map
dw 	Engine-Map
dw 	B1-Map
dw 	B2-Map
dw 	B3-Map
dw 	B4-Map
dw 	Floor1-Map
dw 	Floor2-Map
dw 	Floor3-Map
dw 	Floor4-Map
dw 	Floor5-Map
dw 	Floor6-Map
dw 	Floor7-Map
dw 	Floor8-Map
dw 	Floor9-Map
dw 	Floor10-Map
dw 	Chocobo-Map
dw 	FigCastle-Map
dw 	SouthFig-Map
dw 	Returners-Map
dw 	Elder-Map
dw 	Duncan-Map
dw 	MtKolts-Map
dw 	King-Map
dw 	Moogle-Map
dw 	Narshe-Map
dw 	Auction-Map
dw 	Owzer-Map
dw 	Baren-Map
dw 	Mobliz-Map
dw 	Nikeah-Map
dw 	Tzen-Map
dw 	Hideout-Map
dw 	Lete-Map
dw 	Camp-Map
dw 	Doma-Map
dw 	Forest-Map
dw 	Serpent-Map
dw 	Kohlingen-Map
dw 	Zozo-Map
dw 	Jidoor-Map
dw 	Opera-Map
dw 	Vector-Map
dw 	ImperialC-Map
dw 	Magitek-Map
dw 	Maranda-Map
dw 	Albrook-Map
dw 	Base-Map
dw 	Gate-Map
dw 	Thamasa-Map
dw 	Colosseum-Map
dw 	Tomb-Map
dw 	Floating-Map
dw 	Esperville-Map
dw 	MtZozo-Map
dw 	Factory-Map
dw 	Crescent-Map
dw 	Beginner-Map
dw 	KefkaTower-Map
dw 	Advanced-Map
dw 	BattleTact-Map
dw 	Science-Map
dw 	Sealed-Map
dw 	GenStore-Map
dw 	PhoenixC-Map
dw 	Veldt-Map

warnpc $E68780