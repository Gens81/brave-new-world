arch 65816
hirom

table "menu.tbl",ltr 

;------------------------------------------------------------------
; Rare Item count Disabled
;------------------------------------------------------------------
org $c3837f
	RTS		;Return to Sub instead of LDX $7AC5 and avoid count print

;------------------------------------------------------------------
;Item list
;------------------------------------------------------------------

org $D2BC99	;Gum pod
	db $EB 

org $D2BB7B
	db $D8,"Defibr",$0C,$0D,"ator"

org $D2B681	;Full Moon
	db $EC

org $D2B69B	;Boomerang
	db $EC

org $D2B6A8	;Rising Sun
	db $EC

org $D2B6DC	;Wing Edge
	db $EC

org $D2BEBB

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
    db $EB,"Red>Bull    "
    db $EB,"Slim>Jim    "
    db $EB,"Warp>Whistle"
    db $EB,"Dried>Meat  "
    
warnpc $D2BFF3
