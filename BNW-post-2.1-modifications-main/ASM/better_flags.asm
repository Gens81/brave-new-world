arch 65816
hirom
table "menu.tbl", ltr

!freeBank = #$C0
!initXY = #$812F+128		; tilemap coords for first property string
!numProps = #$0014		; how many properties to check for (should match size of tables at the bottom)
!maxProps = #$0005		; how many properties are we willing to display?
!overwriteRow = $C0DC6E
!Continue = $C4F3DE
!HealingWeapons = $C4F3FA

macro FakeShortC3(addr)
	phk						; push 
	per $0006				; push return
	pea $96EE				; push address
	jml $c3<addr>			; jump to address
endmacro

org $C3874C				; display properties for weapons
  JSR OffensiveProps2
  RTS

;;######################################################################################################;;
;;                                                                                                      ;;
;;  The first half asm file is necessary to arrange all the bg3 tiles to make the better spacing view   ;;
;;  on screen.                                                                                          ;;
;;                                                                                                      ;;
;;######################################################################################################;;

; Description text pos.
org $c3a73d		
	ldx #$7849

; Item can be used by:
; item pos
org $c38553
	lda #$7D8D+128
	
; _can be used by:
org $C385BD	
	dw #CanBeUsed

; Charachter Pos.
org $C38653				
	dw $7e0f+128
	dw $7e23+128
	dw $7e37+128
	dw $7e8f+128
	dw $7ea3+128
	dw $7eb7+128
	dw $7f0f+128
	dw $7f23+128
	dw $7f37+128
	dw $7f8f+128
	dw $7fa3+128
	dw $7fb7+128
	dw $800f+128
	dw $8023+128
	dw $8037+128
	
;Move quantity 1 line up
org $C38A7C
	dw $7A93
 
; Text in item menu (stats and element)
; pointer manager
org	$C38678				
	ldx #Stats				; Start pointer offset
	ldy #Stats2-Stats		; Pointers to read (2 bytes each pointer)
 
org	$C38685					
	ldx #Stats2				; Start pointer offset
	ldy #DefElement-Stats2	; Pointers to read (2 bytes each pointer)
 
org	$C3873A				
	ldx #DefElement			; Start pointer offset
	ldy #$0008				; Pointers to read (2 bytes each pointer)

org $C3F856
	LDY #elementattack
	
org $C387C1
	dw #itemquestionmark
	
org $C38A4B
	LDY #itemowned

; Defensive element po.
	org $C388CE : LDX #$7BCD-160     ; resist
	org $C388DA : LDX #$7BE9-64      ; absorb
	org $C388E6 : LDX #$7CCD-160     ; nullify
	org $C388F2 : LDX #$7CE9-64      ; weakness

; Text
org $C38d16
	dw $78cd : db "Item",$00
	dw $78dd : db "USE",$00
	dw $78e7 : db "ARRANGE",$00
	dw $78f9 : db "RARE",$00

CanBeUsed:
	db " can be used by:",$00

; Pointers at $C38D45		
Stats:
	dw #itemvigor
	dw #itemstamina
	dw #itemmagic
	dw #itemevade
	dw #itemmevade
	dw #item2points
	dw #item2points2
	dw #item2points3
	dw #item2points4
	dw #item2points5
	dw #item2points6
	dw #item2points7
	dw #item2points8
	dw #item2points9
Stats2:	
	dw #itemspeed	
	dw #itemattack
	dw #itemdefense
	dw #itemmdefense
DefElement:	
	dw #itemresist
	dw #itemabsorb
	dw #itemnullify
	dw #itemweakness

; Text 
org $C38D71
itemquestionmark:	dw $8643 : db $bf,$bf,$bf,$00
itemvigor:			dw $842F : db "Vigor",$00
itemstamina:		dw $85AF : db "Stamina",$00
itemmagic:			dw $84AF : db "Magic",$00
itemevade:			dw $872F : db "Evade",$00
itemmevade:			dw $882F : db "M.Evade",$00
item2points:		dw $843f : db $d3,$00	; ".."
item2points2:		dw $84bf : db $d3,$00	; ".."
item2points3:		dw $853f : db $d3,$00	; ".."
item2points4:		dw $85bf : db $d3,$00	; ".."
item2points5:		dw $863f : db $d3,$00	; ".."
item2points6:		dw $86bf : db $d3,$00	; ".."
item2points7:		dw $873f : db $d3,$00	; ".."
item2points8:		dw $87bf : db $d3,$00	; ".."
item2points9:		dw $883f : db $d3,$00	; ".."	
itemspeed:			dw $852f : db "Speed",$00
itemattack:			dw $862f : db "Attack",$00
itemdefense:		dw $86af : db "Defense",$00
itemmdefense:		dw $87af : db "M.Def.",$00
itemresist:			dw $7C8D : db "Half Damage",$00
itemabsorb:			dw $7B8D : db "Absorb",$00
itemnullify:		dw $7C0D : db "No Damage",$00
itemweakness:		dw $7d0d : db "Weakness",$00
elementattack:		dw $7B8D : db "Damage Type",$00
itemowned:			dw $7a0D : db "Owned:",$00

warnpc $C38E35

; stats value	
org $C386AA : LDA #$8445	; vigor
org $C386F0 : LDA #$84C5	; magic
org $C386C1 : LDA #$8545	; speed
org $C386D6 : LDA #$85c5	; stamina
;org $c3879D : LDX #$8643	; attack	-> in arrange elements routine 
org $c38727 : LDX #$86C3	; defense
;org $c387AC : LDA #$8743	; evade		->				^
org $c38717 : LDX #$87C3	; m.def.
;org $c387C7 : LDA #$8843	; m.evade	->				^


;;######################################################################################################;;
;;                                                                                                      ;;
;;  HDMA table for shortening space between rows                                                        ;;                                            ;;
;;  I've not really understand how this HDMA table work it's arranged 3 bytes each row.                 ;;
;;                                                                                                      ;;
;;  1st value -> scanlines, when $00 HDMA will be quit                                                  ;;
;;  2nd value -> scanlines to axe                                                                       ;;
;;  3rd value -> really dunno, just keep on $00                                                         ;;
;;                                                                                                      ;;
;;	So the table seems to work like that:                                                               ;;
;;	Print first 17 scanlines and do nothing                                                             ;;
;;	Print next 0C scanlines and axe (or move up) 4 scanlines                                            ;;
;;	Print next 0C scanlines and axe (or move up) 8 scanlines                                            ;;
;;	And so on...                                                                                        ;;
;;                                                                                                      ;;
;;######################################################################################################;;


org $C3FBEF
Item_Description:
	db $1F,$00,$00		; row 1
	db $08,$08,$00      ; row 2
	db $0c,$0c,$00      ; row 3
	db $0c,$10,$00      ; row 4
	db $0c,$14,$00      ; row 5
	db $0c,$18,$00      ; row 6
	db $0c,$1c,$00      ; row 7
	db $0c,$20,$00      ; row 8
	db $0c,$24,$00      ; row 9
	db $0c,$28,$00      ; row 10
	db $0c,$2c,$00      ; row 11
	db $0c,$30,$00      ; row 12
	db $0c,$34,$00      ; row 13
	db $0c,$38,$00      ; row 14
	db $0c,$3c,$00      ; row 15
	db $0c,$40,$00      ; row 16
	db $00              ; end

; clear map when push B

org $c389b5
	ldx #$7AE9		; RAM address
	skip 3
	ldx #$2E0		; byte count


	
; This replaces the procedural "check this byte, write this string" form of
; outputting item flags with an extensible table-based approach. Simply add
; the string, relevant item data byte, and relevant item data bit to the
; tables at the bottom, set !numProps to match the desired table length,
; and enjoy!
;
; For each row in the data tables, this will compute the offset to the item
; data byte, check the property bit, then output a string if the bit is set.
; The first relevant property string will be printed starting at the !initXY
; tilemap location, and each one after that will appear on the line below.
; Once all properties have been checked, or !maxProps have been output
; (whichever comes first), it stops.

org $C3F6CB
OffensiveProps2:
	JSL OffensiveProps2_long
	RTS
	
org $C4F3AD
OffensiveProps2_long:
  PHX
  LDA #$20             ; "user's color" palette (white)
  STA $29              ; set palette
  REP #$20             ; 16-bit A
  PHA                  ; preserve HB of A (possibly unnecessary)

  LDX $00              ; how many properties have we checked?
  LDY $00              ; how many properties have we found?

- CPX !numProps        ; have we done all flags?
  BEQ .endLoop         ; jump to end if so
  CPY !maxProps        ; have we printed the max number of flags?
  BEQ .endLoop         ; jump to end if so
  PHX                  ; stash loop index
  LDA.l ItemFlagOffsets,X
  AND #$00FF           ; isolate offset since A=16bit
  CLC
  ADC $2134            ; add item index
  TAX                  ; index in X
  TDC
  SEP #$20             ; 8-bit A
  LDA $D85000,X        ; load item property byte
  PLX
  
;;################################################################################################;;  
;;                                                                                                ;;
;; This is the biggest change i've made. Save X, A and go to the turn value function and avoid    ;;
;; Ignores Row print if you are on healing weapon and print Cures HP instead of Always Hit        ;;
;;                                                                                                ;;
  PHX                   ; save X                                                                  ;;
  PHA                   ; save A                                                                  ;;
  JML !overwriteRow     ; jump                                                                    ;;
;																								  ;;
; Continue - Only when you are on Healing weapon and Cures must be print the prev. function       ;;
;            doesn't go back here and axe next 13 row code.                                       ;;
;                                                                                                 ;;
; When first 11 flags are done we need to change bitmask due to BIT opcode matters                 ;;
;                                                                                                 ;;
  CPX #$000B           ; from this point need to change flag value due to aovid wrong BIT         ;;
  BCC .NotMulti        ;                                                                          ;;
  JSR multiflag		   ; go to the routine that avoid print mistake                               ;;
.NotMulti                                                                                         ;;
;;																								  ;;
;;                                                                                                ;;
;;                                                                                                ;;
;;################################################################################################;;

  STA $E7              ; store in scratch
  PHX                  ; load loop index
  LDA.l ItemFlagBitmasks,X
  BIT $E7              ; test bits of item data
  BEQ .next            ; skip if property not set
  REP #$20             ; back to 16-bit A
  TXA
  ASL                  ; loop index -> pointer index
  TAX
  LDA.l ItemFlagPointers,X
  
;;################################################################################################;;  
;;                        												  						  ;;
;; HealingWeapons - When on Healing weapons we don't need to test with bitmask so we can axe the  ;;
;;                  previous 13 rows. Flag pointer must be loaded in overwriteRow funciotn   	  ;;											  ;;
;;                        												                          ;;
;;################################################################################################;;

  STA $E7              ; set LBs of text pointer
  SEP #$20             ; 8-bit A
  LDA !freeBank
  STA $E9              ; set HB of text
  REP #$20             ; 16-bit A
  LDA !initXY          ; first tilemap pointer
  TYX

.positionLoop
  BEQ +
  CLC
  ADC #$0080           ; move down 1 row for each property we've already printed
  DEX
  BRA .positionLoop
+ STA $EB              ; write LBs for tilemap destination
  PHY
  LDY $00
  %FakeShortC3(030C)   ; output item flag string to tilemap
  PLY
  INY
.next
  REP #$20             ; just in case
  PLX                  ; pop loop index
  INX
  BRA -                ; loop for all item properties in list

.endLoop
    
  PLA                  ; retrieve previous A (preserve HB)
  SEP #$20             ; 8-bit A
  PLX
  RTL

;;################################################################################################;;  
;;                        												  						  ;;
;; As i said before we need to hard-code a lot to find the way to show all the flags avoiding to  ;;
;; show flags on wrong weapons.                                                                   ;;
;; From 9th flag offset we have a lot of flag on 1B bytes code and BIT couldn't return 0 even if  ;;
;; the flag is inactive.                                                                          ;;
;; A weapon with $80 on 1B byte doesn't return $00 if BITted with $70 and Z flag remain unsetted  ;;
;; showing up the wrong flag                                                                      ;;
;;                                                                                                ;;
;;################################################################################################;;
	
multiflag:
	AND #$F0				; AND and set value on X0
	CMP #$F0				; If 1B is $F0 (Demonsbane & Tarot) you are on Undead Slayer flag
	BEQ .Undead             ; branch if so
	CMP #$30                ; Anti-Human weapon (Kusarigama)?
	BEQ .end                ; branch if so
	CMP #$40                ; Are you on Man Eater or Butterfly?
	BEQ .AntiHuman          ; They are Anti-Human, branch if so
	CMP #$D0                ; Zantetsuken or Ichimonji?
	BEQ .InstaKill          ; branch if so
	CMP #$70                ; MP critical weapon?
	BEQ .MPCrit             ; branch if so
	CMP #$A0				; Valiance?
	BEQ .IgnoresDef         ; branch if so
	CMP #$50                ; Morning Star?
	BEQ .IgnoresDef         ; branch if so
	CMP #$80                ; Anti-Air and High Critical Bonus?
	BEQ .end                ; branch if so
.clear
	LDA $00	                ; If the flag doesn't fit the above values clear and return always false
	RTS
.Undead
	LDA #$04                ; turn A into a BIT mask value that can return true only with Undead
.end
	RTS                     ; go back
.InstaKill                  
	LDA #$40                ; turn A into a BIT mask value that can return true only with Instakill
	BRA .end                ; branch to go back (makes 2 round: Instakill and High Critical)
.MPCrit                     
	LDA #$02                ; turn A into a BIT mask value that can return true only with Mp Critical
	BRA .end                ; branch to go back
.AntiHuman                  
	LDA #$30                ; Turn Man Eater and Butterlfy flag value into bitmask value
	BRA .end                ; branch to go back
.IgnoresDef
	LDA #$08
	BRA .end
	
org $C0DB40
Bushido: db "Bushido",$00
Runic: db "Runic",$00
Gauntlet: db "Two-Handed",$00
Throw: db "Throw",$00
Ranged: db "Ignores Row",$00
Cover: db "Jump Bonus",$00
Cover2: db "Cover Allies",$00
Always: db "Always Hits",$00
Counter: db "Counterattack",$00
Genji: db "Dual-Wield",$00
MPCrit: db "Mp Critical",$00
Instakill: db "Insta-Kill",$00
HighCrit: db "High Critical",$00
AntiAir: db "Anti-Air",$00
Undead: db "Undead-Slayer",$00
SpellcastUp: db "Spellcast ",$D4,$00
AntiHuman: db "Anti-Human",$00
XFight: db "Hits Twice",$00
IgnoresDef: db "Ignores Def.",$00
Heal: db "Cures HP",$00

; ... +more

ItemFlagPointers:      ; pointers to the strings for each item flag to be displayed
  dw Bushido
  dw Runic
  dw Gauntlet
  dw Throw
  dw Ranged
  dw Cover
  dw Cover2
  dw Always
  dw Counter
  dw Genji
  dw XFight
  dw MPCrit
  dw Instakill
  dw HighCrit
  dw AntiAir
  dw HighCrit
  dw Undead
  dw SpellcastUp
  dw AntiHuman
  dw IgnoresDef
  dw Heal
  ; ... +more


ItemFlagOffsets:       ; item data offsets relative to $D85000 struct
  db $13	; Bushido
  db $13	; Runic
  db $13	; Gauntlet
  db $00	; Throw
  db $13	; Ranged
  db $0C	; Cover
  db $0C	; Cover
  db $15	; Always
  db $0C	; Counter
  db $0C	; Genji
  db $0C	; XFight  
  db $1B	; Mp for crit
  db $1B	; Instakill
  db $1B	; High Crit
  db $1B	; Anti-Air
  db $1B	; High Crit
  db $1B	; Undead slayer
  db $0C	; SpellcastUp
  db $1B	; AntiHuman
  db $1B	; Ignores Def.
  
  ; ... +more

  
ItemFlagBitmasks:      ; which bit to check in corresponding item data byte above ^
  db $02	; Bushido
  db $80	; Runic
  db $40	; Gauntlet
  db $10	; Throw
  db $20	; Ranged
  db $40	; Cover
  db $40	; Cover
  db $83	; Always
  db $02	; Counter
  db $10	; Genji
  db $01	; XFight
  db $02	; Mp for crit
  db $40	; Instakill
  db $40	; High Crit
  db $80	; Anti-Air
  db $80    ; High Crit
  db $04	; Undead slayer
  db $80	; SpellcastUp
  db $30	; AntiHuman
  db $08	; Ignores Def.
  ; ... +more
  
  
;;#################################################################################################;;  
;;                        												  						   ;;
;;  When OffensiveProps2 Index X is on 0004 we are looking for Ignores Row						   ;;
;;  When OffensiveProps2 Index X is on 0007 we are looking for Always Hit                          ;;
;;                                                                                                 ;;
;;  If we are on Healing weapon Ignores Row musn't be printed and Cures HP must be printed instead ;;
;;  of Always Hit                        												           ;;
;;#################################################################################################;;

overwriteRow:
; From OffensiveProps2
; A:00XX - XX -> item property byte
; X:0005 - 0007

	CPX #$0004				; on Ignores Row?
	BEQ .NoIgnoresRow		; branch if so
	CPX #$0007				; always hit?
	BEQ .NoAlwaysHit		; branch if so  
	CPX #$0009				; Dual Wield?
	BEQ .DualWield			; Branch if so
	BRA .end				; branch to go back if not
.NoIgnoresRow	
	LDA $4B        			; load item position
	TAX            			; index it
	LDA $1869,X 	   		; load item id from inventory SRAM position
	CMP #$00				; Healing Shiv?
	BEQ .change				; branch to change if so	
	CMP #$40+1				; Ross Brush or above?
	BCS	.end				; branch to go back if so		
	CMP #$3D				; Light Brush or below?
	BCC .end				; branch to go back if so
.change
	PLA             		; restore A 
	TDC            			; clear A (and so the weapon don't show Ignore Row - $00 = always false)
	PLX             		; restore X
	BRA .jmp        		; branch to jump
.end                 
	PLA             		; restore A
	PLX             		; restore X
.jmp
	JML !Continue			; Go back and go on to print

.NoAlwaysHit
	CMP #$FF					; Hit Rate on FF = Always Hit? 
	BNE .end					; Branch to go back if not (497 row)
	LDA $4B						; load item position
	TAX							; index it
	LDA $1869,X					; load item id from inventory SRAM position
	CMP #$19					; Zantetsuken?
	BEQ .end					; branch if so
	CMP #$23					; Gungnir?
	BEQ .end					; branch if so
	CMP #$41					; Shuriken?
	BEQ .end					; branch if so
	CMP #$43					; Ninja Star?
	BEQ .end					; branch if so
	PLA							; restore A
	REP #$20					; 16 bit-A
	LDA.l ItemFlagPointers+40	; load Cures HP pointer
	JML !HealingWeapons			; go back to OffensiveProps2 routine - no need to restore X in this case
	
.DualWield
	CMP #$13					; If byte 0C is 12 or below the weapons are dual wield
	BCC .end        	        ; branch if so and go to print dual wield	
	BRA .change					; branch to clear A
