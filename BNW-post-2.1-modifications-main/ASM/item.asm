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

org $D2B5A4	
	db $E1,"Magus>Rod   "

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

org $D859E4 
    db $12      ;Spirit Claw> counter-attack
org $D859FF 
    db $10      ;Poison Claw> HP+
org $D85A20 
    db $12      ;Ocean Claw> counter-attack
org $D85A3B 
    db $04      ;Hell Claw> HP++
org $D85A50 
    db $12      ;Frostgore> counter-attack
org $D85A77 
    db $08      ;Stormfang> HP+++

;Royal Jacket (no hp bonus, spellcast up, auto-safe)
org $D86142
    db $40,$00,$00,$00,$80

;Radiant Gown (no mp bonus, auto-shell)
org $D861F6
    db $20,$00

;fix gale hairpin stat (from +3 stam to +3 magic)    
org $D86A8D 
	db $30

;former mythril rod may cast Rasp
org $D8562A 
	db $5A
    
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
