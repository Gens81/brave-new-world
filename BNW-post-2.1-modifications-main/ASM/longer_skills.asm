;;-----------------------------------------------------
;;-----------------------------------------------------
;;
;;Magic & Esper data
;; 
;;-----------------------------------------------------
;;-----------------------------------------------------

;------------------------------------------------------
;Spell increased by 1
;------------------------------------------------------

;spell data: increase how many letter to be print by 1 

;spell pointer
;battle menu

org $C1601A
	lda #$08		;Spell name length
org $C16031
	lda spell,x		;Load spell name

org $C165E8
	lda #$08		;Spell name length
	sta $2E
	sta $40
	jsr $18B0
	ldx $30
	lda spell,x		;Load Spell name

org $C16B1D
	lda #$08		;Spell name length
	sta $10
	jsr $18CA
	rep #$20
	lda $004216
	tax 
	tdc 
	sep #$20
	lda spell,x		;Load spell name
	
org $c34fb5
	ldy #$0008		;Spell name length
	sty $EB
	ldy #spell		;spell name address
	sty $EF
	lda #$EF		;spell name bank

org $c34ff7
	nop				;nop instead of $FF 
	nop				;where "_..._" [$FF,$c7$,FF] in magic menu must be print

org $c35af9
	ldx #$9e93		;Where spell in the esper menu must be print

org $c3fd4b			;Shortening space between MP and PA - Spell in the esper menu
	nop				;No operations insteda os LDA 2180
	nop				;LDA 2180 repeat the byte $FF 3 times to print 3
	nop				;blank tiles before XX PA

;------------------------------------------------------
;Esper increased by 1
;------------------------------------------------------

;Esper space increased by 1

;esper pointer
;Battle

org $C15FF3
	lda #$09			;Esper name length
org $C16007	
	lda esper,x			;Load esper name x
		
org $C165D0	
	lda #$09			;Esper name length
	sta $2e	
	sta $40	
	jsr $18b0	
	ldx $30	
	lda esper,x			;Load esper name x
		
org $C1668D	
	lda #$09			;Esper name length
	sta $2e	
	sta $40	
	jsr $18b0	
	ldx $30	
	lda esper,x			;Btl Menu pointer x
	
; Menu	

org	$c334f0 
	jsr multiplierby9	;Jump to subroutine that multiply by 9
	tax
	ldy #$0009			;Esper name length
	lda esper,x			;Skill&Review menu pointer

org $C33508				;Set blank tiles when esper are unequipped
	ldy #$0009			;Set tiles number
	lda #$ff  			;Set tile value

org $c34f0c	
	ldy #$421d			;Where esper must be print in skill menu
	
org $c354FA	
	ldy #$0009			;Esper name length
	sty $eb	
	ldy #esper			;Esper list menu pointer
	sty $ef	
	lda #$ef			;Esper name bank
	
;org $c35539 	
;	ldx #$9e94			;Esper choice wide +1 (Switched off because the same address have been used after)

org $C359BD
	jsr multiplierby9	;Jump to subroutine that multiply by 9
	tax
	ldy #$0009			;Esper name length
	lda esper,x			;Esper choice menu pointer
	
	
org $c3f6e0				;New subroutine that multiply A
multiplierby9:			;Necessary to load every 9 bytes
	sta $4202
	lda #$09
	bra multiplier
multiplierby0b:  		;Necessary to load every 11 bytes
	sta $4202			;store
	lda #$0b			;Set 0b
multiplier:
	sta $4203
	nop
	nop
	CLC
	lda $4216
	rts

;Data

org $EFFC00
spell:
	db $E9,"Fire   "
	db $E9,"Ice    "
	db $E9,"Bolt   "
	db $E9,"Sap    "
	db $E9,"Poison "
	db $E9,"Fire>2 "
	db $E9,"Ice>2  "
	db $E9,"Bolt>2 "
	db $E9,"Break  "
	db $E9,"Fire>3 "
	db $E9,"Ice>3  "
	db $E9,"Bolt>3 "
	db $E9,"Quake  "
	db $E9,"Doom   "
	db $E9,"Holy   "
	db $E9,"Flare  "
	db $E9,"Dark   "
	db $E9,"Storm  "
	db $E9,"X-Zone "
	db $E9,"Meteor "
	db $E9,"Ultima "
	db $E9,"M",$08,$09,$0A,$0B,"wn"
	db $E9,"Demi   "
	db $E9,"Quartr "
	db $E9,"Drain  "
	db $EA,"Osmose "
	db $EA,"Rasp   "
	db $EA,"Muddle "
	db $EA,"Mute   "
	db $EA,"Sleep  "
	db $EA,"SleepX "
	db $EA,"Imp    "
	db $EA,"Berserk"
	db $EA,"Stop   "
	db $EA,"Safe   "
	db $EA,"Shell  "
	db $EA,"Haste  "
	db $EA,"HasteX "
	db $EA,"Slow   "
	db $EA,"SlowX  "
	db $EA,"Reflect"
	db $EA,"Float  "
	db $EA,"Warp   "
	db $EA,"Scan   "
	db $EA,"Dispel "
	db $E8,"Cure   "
	db $E8,"Cure>2 "
	db $E8,"Cure>3 "
	db $E8,"Life   "
	db $E8,"Life>2 "
	db $E8,"Rerise "
	db $E8,"Remedy "
	db $E8,"Regen  "
	db $E8,"RegenX "

esper:
	db "Ramuh    "
	db "Ifrit    "
	db "Shiva    "
	db "Siren    "
	db "Terrato  "
	db "Shoat    "
	db "Maduin   "
	db "Bismark  "
	db "Stray    "
	db "Palidor  "
	db "Tritoch  "
	db "Odin     "
	db "Loki     "
	db "Bahamut  "
	db "Crusader "
	db "Ragnarok "
	db "Alexander"
	db "Kirin    "
	db "Zoneseek "
	db "Carbuncle"
	db "Phantom  "
	db "Seraph   "
	db "Golem    "
	db "Unicorn  "
	db "Fenrir   "
	db "Starlet  "
	db "Phoenix  "

;------------------------------------------------------
;Battle quotes-BLue Magic increased by 1
;------------------------------------------------------

org $C15FC9
	lda #$0b				;String text length on battle quotes
org $C15FDD
	lda.l battle_quotes,x	;Battle quotes text bank

org $C165B4
	lda #$0b
org $C165BF
	lda.l battle_quotes,x

org $C16ADC
	lda #$0b
org $C16AED
	lda.l battle_quotes,x


;Blue Magic Skil Menu pointer 
org $C35266
	ldy #$000b		;Set String Length
	sty $eb			;Store in 
	
org $C3526B
	ldy #blue_magic	;Load text Address
	sty $ef			;Store in
	lda #$e6		;Load text Bank
	sta $f1			;Store in

;Blue MAgic Battle Menu
org $C16665
	lda #$0b			;Set String Length
org $C16670
	lda.l blue_magic,x;Load text address

org $c35295 
	ldx #$9e96			;Set "... xx" one tile right
org $C352C0
	ldy #$000f			;Delete tiles length

;Dance
org $c357c1
	ldy #$000c		;Dance text Length
	sty $eb			;Store in
	ldy #dance		;Text Pointer
	sty $ef			;Store in
	lda #$e6		;Bank text pointer
	sta $f1			;Store in
	
;Jujitsu
org $C3f503			;Jujitsu skill menu
	ldy #$000b		;Jujitsu text length
	lda.l jujitsu,x	;Text Pointer

;Jujitsu pointer routine

org $c3f4f0
	pha
	phy					;Push Y to Stack
	jsr multiplierby0b	;Go to subroutine that multiply by 0b
	pha 
	nop
	nop

;Summon
org $C2BB4D
	lda #$0B			;Set 11 letters length
	
org $C2BB59
	lda.l summon,x		;pointers
	
org $C2BB66
	cpy #$000B
	
;Mgtek
org $C164f8
	lda #$0b
org $C164FF
	lda #$0b
org $C1650A
	lda.l Mgtek,x
	
;Dance
org $C16610
	lda #$0c			;Text length
Org $C1661b
	lda.l dance,x		;Pointers

;------------------------------------------------------
;Text Data
;------------------------------------------------------

org $E6F567
battle_quotes:
	db "Ninja>Fire "
	db "Ninja>Wave "
	db "Ninja>Bolt "
	db "Blizzard   "
	db "           "
	db "           "
	db "           "
	db "           "
	db "           "
	db "           "
	db "           "
	db "           "
jujitsu:
	db "Pummel     "
	db "Suplex     "
	db "Aurabolt   "
	db "Fire>Dance "
	db "Mantra     "
	db "Chakra     "
	db "Sonic>Boom "
	db "Bum>Rush   "
	db "Wind>Slash "
	db "Sun>Bath   "
	db "Razor>Leaf "
	db "Harvester  "
	db "Sand>Storm "
	db "Moonlight  "
	db "Elf>Fire   "
	db "Bedevil    "
	db "Avalanche  "
	db "Mirage     "
	db "El>Nino    "
	db "Plasma     "
	db "Snare      "
	db "Cave>In    "
	db "Blizzard   "
	db "Surge      "
	db "Cockatrice "
	db "Wombat     "
	db "Meerkat    "
	db "Tapir      "
	db "Wild>Boars "
	db "Raccoon    "
	db "Toxic>Frog "
	db "Ice>Rabbit "
	db "Bio>Blast  "
	db "Flash      "
	db "Trifecta   "
	db "Blackjack  "
	db "Solitaire  "
	db $be,"Shock     "
Mgtek:
	db $E9,"Fire      "   
	db "Exploder   "
	db "Rock       "
	db "Tentacle   "
	db "Shrapnel   "
	db "Blink      "
	db "Ninja>Wave "          
	db "           "
	
;org	$E6F9FD
blue_magic:
	db $E3,"Aqualung  "
	db $E3,"Bad>Breath"
	db $E3,"Black>Omen"
	db $E3,"Blaze     "
	db $E3,"Blow>Fish "
	db $E3,"Discord   "
	db $E3,"Holy>Wind "
	db $E3,"Raid      "
	db $E3,"Raze      "
	db $E3,"Refract   "
	db $E3,"Shield    "
	db $E3,"Tsunami   "
	db "Jackpot    "
	db $be,"WindSlash "
	db $be,"Aero      "
	db $be,"Defib     "
	db $be,"ManaBat   "
	db $be,"WarpFlute "
	db "Harvester  "
	db "Sun>Bath   "
	db "Meltdown   "
	db "           "
	db "           "
	db "           "
	
;org $E6FAED
;Battle_Quotes_2
	db "Head>Bonk  "
	db "Bio>Blast  "
	db "Heal>Force "
	db "Imp>Song   "
	db "Schiller   "
	db "Quasar     "
	db "Acid>Rain  "
	db "Firestorm  "
	db "Exploder   "
	db "Starlight  "
	db "Net        "
	db "Rock       "
	db "Aqualung   "
	db "Entwine    "
	db "Repair     "
	db "Cyclonic   "
	db "Fireball   "
	db "Atomic>Ray "
	db "Tek>Laser  "
	db "Diffuser   "
	db "Discharge  "
	db "Mega>Volt  "
	db "Giga>Volt  "
	db "Snowball   "
	db "Absolute>0 "
	db "Magnitude  "
	db "Vanish     "
	db "Flash>Rain "
	db "Barrier    "
	db "Fallen>One "
	db "Wallchange "
	db "Escape     "
	db "G-Force    "
	db "Mind>Blast "
	db "N.Cross    "
	db "Flare>Star "
	db "Love>Token "
	db "Grab       "
	db "Polarity   "
	db "Targetting "
	db "Sneeze     "
	db "S.Cross    "
	db "Launcher   "
	db "Charm      "
	db "Cold>Dust  "
	db "Tentacle   "
	db "Hyperdrive "
	db "Train      "
	db "Evil>Toot  "
	db "Grav>Bomb  "
	db "Engulf     "
	db "Thriller   "
	db "Shrapnel   "
	db "Condemn    "
	db "Soul>Eater "
	db "Gi>Nattak  "
	db "Discard    "
	db "Overcast   "
	db "Missile    "
	db "Goner      "
	db "Meteo      "
	db "Purge      "
	db "Phantasm   "
	db "Glare      "
	db "Shock>Wave "
	db "Aero       "
	db "Step>Mine  "
	db "Gale>Cut   "
	db "Air>Blast  "
	db "Lode>Stone "
	db "Blight     "
	db "Snot>Rocket"
	db "Lifeshaver "
	db "Brown>Note "
	db "Landslide  "
	db "Battle     "
	db "Special    "
	db "Riot>Blast "
	db "Mirager    "
	db "Dark>Heart "
	db "Ninja>Flip "
	db "Last>Ditch "
	db "Hadouken   "
	db "Tornado    "
	db "Soul>Reaver"
	db "Star>Prism "
	db "Full>House "
	db "Mig>Rush   "
	db "X-Meteo    "
	db "Reprisal   "
	db "Reprisal   "
	db "Go>Fish    "
	db "?????????? "
summon:
	db "Judgement  "
	db "Inferno    "
	db "Gem>Dust   "
	db "Siren>Song "
	db "Earth>Rage "
	db "Hurricane  "
	db "Chaos>Wing "
	db "Sea>Song   "
	db "Cait>Sith  "
	db "Air>Raid   "
	db "Trisection "
	db "Atom>Edge  "
	db "Quark>Edge "
	db "Mega>Flare "
	db "Jihad      "
	db "Oblivion   "
	db "Justice    "
	db "Life>Force "
	db "Light>Wall "
	db "Ruby>Blast "
	db "Fader      "
	db "Lifeline   "
	db "Earth>Wall "
	db "Heal>Horn  "
	db "Moonshine  "
	db "Group>Hug  "
	db "Rebirth    "
;org $E6FFA9
dance:
	db "Wind>Song   "
	db "Forest>Suite"
	db "Desert>Aria "
	db "Love>Sonata "
	db "Earth>Blues "
	db "Water>Rondo "
	db "Dusk>Requiem"
	db "Snowman>Jazz"

padbyte $ff
pad $E6ffff
warnpc $E70000

;Bushido names

org $CF3C40
	db "Dispatch    "
	db "Mindblow    "
	db "Empowerer   "
	db "Flurry      "
	db "Dragon      "
	db "Eclipse     "
	db "Tempest     "
	db "Cleave      "

warnpc $CF3CFF
	
;;-----------------------------------------------------
;;-----------------------------------------------------
;;
;;Skills menu
;;Overwrite data: 
;;from C35C48-C35C86 to C35C (Old unused data)
;;-----------------------------------------------------
;;-----------------------------------------------------

;MP needed section

org $C35856
	dw #needed

org $C35881
	dw $7A4F	; quantity of MP needed position

org $C35889
	db $55,$7A,"MP",$00	;MP


;Pointers
org $C34CE3
	dw #Skillesper
	
org $C34CED
	dw #SkillMagic

org $C34CF7
	dw #SkillBushido
	
org $C34D01
	dw #SkillBlitz
	
org $C34D0B
	dw #SkillLore

org $C34D15
	dw #SkillRage

org $C34D1F
	dw #SkillDance 

;LV, HP, MP pointer manager

org $C34D32
	dw #Skillstats				;Start pointer offset 
	
org $C34d35
	dw $0006					;Pointers to read (2 bytes each pointer)

;Data 
org $C35C48
Skillesper:
	db $0d,$79,"Espers",$00
	
SkillMagic:	
	db $8d,$79,"Magic",$00
	
SkillBushido:
	db $8d,$7A,"Bushido",$00

SkillBlitz:
	db $0d,$7b,"Blitz",$00
	
SkillLore:
	db $8d,$7b,"Lore",$00
	
SkillRage:
	db $0d,$7c,"Rage",$00
	
SkillDance:
	db $8d,$7c,"Dance",$00
	
Skillstats:
	dw #SkillLV
	dw #SkillHP
	dw #SkillMP

SkillLV:
	db $2f,$42,"LV",$00

SkillHP:
	db $af,$42,"HP",$00

SkillMP:
	db $2f,$43,"MP",$00

needed:
	db $0D,$7A,"Needed",$00	;Needed

Esperslash:
	db $bb,$42,"/",$00

Esperslash2:
	db $3b,$43,"/",$00
	
esperSP:
	db $b1,$47,"SP ",$00
	
learn:	
	db $35,$44," Learn",$00

slash30:
	db $bb,$47,"/30",$00

ELbonus:
	db " EL Bonus: "

org $C3F2BF
	db $3B,$42,"EL",$00

;Esper pointers
org $C34EF7
	dw #Esperslash

org $C34EFD
	dw #Esperslash2
	
org $C359AA
	dw #esperSP

org $C3FD87
	dw #learn

org $C3FD7D
	dw #slash30

org $C35A44
	dw #ELbonus

;Esper bonus menu - MP

org $c35b1c		;SP
lda #$92		;Letter S
sta $2180		
org $C3FD08	
lda #$8f		;Letter P
sta $2180	

;Esper bonus menu - MP

org $c3fdc3		;First MP
lda #$8c		;Letter M
sta $2180
lda #$8f		;Letter P
sta $2180
	
org $c3fd39		;Others MP
lda #$8c		;Letter M
sta $2180
lda #$8f		;Letter P
sta $2180	

org $C3F30F
	db "Unspent EL:",$00

;Triangle cursor

org $C309FE
dw $0002,$0200,$003e,$0208 : db $be
dw $0002,$1200,$003e,$1208 : db $be
dw $0002,$1200,$003e,$0208 : db $be
dw $0002,$0200,$003e,$1208 : db $be

org $C30929
	lda #$00F0		;Set triangle cursor 1 tile right

;Spell right side cursor position
org $C18281
    db $58

;Shortening esper magic number values

org $c35538

	pha			;Save A value (Esper value)
	ldx #$9e94  ;Load Ram Position screen
	stx $2181   ;Save
	nop         ;
	nop         ;
	nop         ;3 NOP instead of Loading&Saving "..." value
	pla         ;Load A Value
	jsr $04e0   ;Jump to Routine that convert Hex Value into Dec Value
	lda #$C7    ;Load "..." value instead of "FF" Value
	sta $2180   ;Save
	lda $f8     ;Load first number value
	sta $2180   ;Save
	lda $f9     ;Load second number value
	sta $2180   ;Save
	stz $2180   ;Clear $2180
	jmp $7fd9   ;Jump

warnpc $c3555b


;-----------------------------------------------------
; Fix Finger cursor position in esper menu
;-----------------------------------------------------

Org $c32ef5
	lda #$003f 		;Y Position 
	sta $7e33ca,x
	lda #$0036		;X Position
	sta $7e344a,x
	
;-----------------------------------------------------
; Fix description position
;-----------------------------------------------------

org $C34E27
	db $05		; move description, esper, magic and bushido 3 pixel up
org $C34E2A
	db $05		; move Blitz, Lore, Rage and Dance 3 pixel up
	
; Cursor positions for Skills menu
org $C34B74
	dw $1100	; Espers
	dw $2100	; Magic
	dw $4100	; Bushido
	dw $5100	; Blitz
	dw $6100	; Lore
	dw $7100	; Rage
	dw $8100	; Dance

;-----------------------------------------------------
; Magic/Esper - MP separator
;-----------------------------------------------------
	
org $c35005 
lda #$D3		;"..." magic mp separator 

org $c35546 
lda #$D3		;"..." esper mp separator

;-----------------------------------------------------
; Space between rages
;-----------------------------------------------------

; space
org $C2E06E
	db $03
	
; finger
org $c1828A
	db $7F
