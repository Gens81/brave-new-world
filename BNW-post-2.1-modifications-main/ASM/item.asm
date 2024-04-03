arch 65816
hirom

table "menu.tbl",ltr 

;------------------------------------------------------------------
;Item list
;------------------------------------------------------------------

org $D2BC99	;Gum pod
	db $EB 

org $D2BB7B
	db $D8,"Defibr",$0C,$0D,"ator"

org $D2B674	
	db $E3,"Club        "
    db $EC,"Full>Moon   "
    db $E3,"Morning>Star"
    db $EC,"Boomerang   "
    db $EC,"Rising>Sun  "
    db $E3,"Kusarigama  "
    db $E3,"Bone>Club   "
    db $E3,"Magic>Bone  "
    db $EC,"Wing>Edge   "

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

;Claw buff

org $D859E1 
    db $10
org $D859FF 
    db $10      ;Spirit/Poison HP+
org $D85A1D 
    db $04
org $D85A3B 
    db $04      ;Ocean/Hell HP++
org $D85A59 
    db $08
org $D85A77 
    db $08      ;Frost/Storm HP+++

;Royal Jacket (no hp bonus, spellcast up, auto-safe)
org $D86142
    db $40,$00,$00,$00,$80

;Radiant Gown (no mp bonus, auto-shell)
org $D861F6
    db $20,$00

org $D85792
    db $64      ;Ross Brush proc Haste
    
;Morning Star (Anti-human)

; update per-target jump table entry of weapon effect $05
org $C23DD7 : dw $38F2  ; double damage to humans
