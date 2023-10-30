arch 65816
hirom
table "menu.tbl", ltr

;;**********************************************************************;;
;;     																	;;
;;   Rearranging Elements routine										;;     																	;;
;;                                                                      ;;
;;**********************************************************************;;
Org $C3F850
	JSR C387EB      ; Draw evasions
	JSR $C2F7
	LDY #$8E12
	JSR $02F9
	JMP C388A0

org $C386BC
	JSR C38836
org $C386D1
	JSR C38836
org $C386EB
	JSR C38836
org $C38700
	JSR C38836
	
org $C3872D	
	JSR C387EB      ; Draw evasions
;	JSR C388A0      ; Draw 50% elems
	nop
	nop
	nop
	JSR C38959      ; Draw other ones

org $C38746
	JSR C3879C      ; Draw Bat.Pwr	

; Draw weapon's Bat.Pwr in gear data menu
org $C3877F
C3879C:  TDC             ; Clear A
         LDA $4B         ; Clicked slot
         TAY             ; Index it
         LDA $1869,Y     ; Item in slot
         CMP #$1C        ; Atma Weapon?
         BEQ C387C0      ; Hide if so
         CMP #$17        ; Omega Weapon?
         BEQ C387C0      ; Hide if so
         CMP #$51        ; Dice?
         BEQ C387C0      ; Hide if so
         CMP #$52        ; Fixed Dice?
         BEQ C387C0      ; Hide if so
         LDA $D85014,X   ; Bat.Pwr
         JSR $04E0       ; Turn into text
         LDX #$8603      ; Text position
         JMP $04C0       ; Draw 3 digits

; Fork: Hide power
C387C0:  LDY #$8D71      ; Text pointer
         JSR $02F9       ; Draw "???"
         RTS
	
; Draw Evade and MBlock modifiers for gear data menu

C387EB:  REP #$20        ; 16-bit A
         LDA #$8703      ; Tilemap ptr
         STA $7E9E89     ; Set position
         SEP #$20        ; 8-bit A
         LDX $2134       ; Item index
         TDC             ; Clear A
         LDA $D8501A,X   ; Evasion mods
         PHA             ; Memorize them
         AND #$0F        ; Evade index
         ASL A           ; x2
         ASL A           ; x4
         JSR C3881A      ; Draw modifier
         REP #$20        ; 16-bit A
         LDA #$8803      ; Tilemap ptr
         STA $7E9E89     ; Set position
         SEP #$20        ; 8-bit A
         LDX $2134       ; Item index
         TDC             ; Clear A
         PLA             ; Evasion mods
         AND #$F0        ; MBlock index
         LSR A           ; ÷2
         LSR A           ; ÷4
C3881A:  TAX             ; Index it
         LDA.L C38854,X  ; Sign
         STA $7E9E8B     ; Add to string
         LDA.L C38854+1,X; Tens digit
         STA $7E9E8C     ; Add to string
         LDA.L C38854+2,X; Ones digit
         STA $7E9E8D     ; Add to string
         JMP C38847      ; Draw modifier

; Draw a non-evasion stat modifier for gear data menu
C38836:  TAX             ; Modifier index
         LDA.L C38880,X  ; Sign
         STA $7E9E8B     ; Add to string
         LDA.L C38880+1,X; Digit
         STA $7E9E8C     ; Add to string
C38847:  LDY #$9E89      ; 7E/9E89
         STY $E7         ; Set src LBs
         LDA #$7E        ; Bank: 7E
         STA $E9         ; Set src HB
         JSR $02FF      ; Draw modifier
         RTS

; Text for evasion modifiers
C38854:  db "  0",$00
         db $CA,"10",$00
         db $CA,"20",$00
         db $CA,"30",$00
         db $CA,"40",$00
         db $CA,"50",$00
         db "-10",$00
         db "-20",$00
         db "-30",$00
         db "-40",$00
         db "-50",$00

; Text for non-evasion stat modifiers
C38880:  db " 0"
         db $CA,"1"
         db $CA,"2"
         db $CA,"3"
         db $CA,"4"
         db $CA,"5"
         db $CA,"6"
         db $CA,"7"
         db " 0"         ; Unused
         db "-1"
         db "-2"
         db "-3"
         db "-4"
         db "-5"
         db "-6"
         db "-7"

; Build and draw list of attack or halved elements
C388A0:  LDX $2134       ; Item index
         TDC             ; ...
         LDA $D8500F,X   ; Elements
         JSR C388AE      ; Build list
         JMP C388CE      ; Draw list

; Build current list of elements
C388AE:  LDY #$AA8D      ; 7E/AA8D
         STY $2181       ; Set WRAM LBs
         STZ $E0         ; Current: Water
         LDY #$0008      ; Elements: 8
C388B9:  ROL A           ; Draw current?
         BCC C388C3      ; Skip it if not
         PHA             ; Save elements
         LDA $E0         ; Current element
         STA $2180       ; Add to list
         PLA             ; Elements left
C388C3:  INC $E0         ; Elem number +1
         DEY             ; One less left
         BNE C388B9      ; Loop till last
         LDA #$FF        ; Terminator
         STA $2180       ; End list
         RTS
; Routine that check in which menu you are
C388CX:	LDA $26
		CMP #$0C
		RTS
		
		CMP #$1D
		BEQ C388F8
		
; Draw list of attack or halved elements
C388CE:	LDX #$7B2D       ; Tilemap ptr
		BRA C388F8		 ; Draw Element
; Draw list of Halved Elements
C388XX: LDX #$7C2D       ; Tilemap ptr
		BRA C388F8       ; Draw Element
; Draw list of absorbed elements
C388DA: LDX #$7B2D       ; Tilemap ptr
		BRA C388F8		 ; Draw Element
; Draw list of nulled elements
C388E6: LDX #$7BA9       ; Tilemap ptr
		BRA C388F8		 ; Draw Element
; Draw list of elemental weaknesses
C388F2: LDX #$7CA9       ; Tilemap ptr

C388F8:	STX $EB          ; Set dest LBs
        LDA #$7E         ; Bank: 7E
        STA $ED          ; Set dest HB

; Draw current list of elements
C388FE:  TDC             ; Clear A
         TAX             ; Index: 0
C38900:  TDC             ; Clear A
         LDA $7EAA8D,X   ; Element to draw
         BMI C38926      ; Exit if no more
         PHX             ; Save list index
         REP #$20        ; 16-bit A
         ASL A           ; Element x2
         TAX             ; Index it
         LDA.L C38927,X  ; Tilemap data
         STA $E0         ; Memorize it
         JSR C38937      ; Draw element
         LDA $EB         ; Tilemap ptr
         CLC             ; ...
         ADC #$0004      ; Skip 2 tiles
         STA $EB         ; Save changes
         SEP #$20        ; 8-bit A
         PLX             ; List index
         INX             ; List index +1
         CPX #$0006      ; Done 6 entries?
         BNE C38900      ; Loop if not
C38926:  RTS

; Base tile attributes for each element
C38927:  dw $3580        ; Water
         dw $3584        ; Earth
         dw $3588        ; Pearl
         dw $358C        ; Wind
         dw $3590        ; Poison
         dw $3594        ; Lightning
         dw $3598        ; Ice
         dw $359C        ; Fire

; Draw current element
C38937:  TDC             ; Clear A
         TAY             ; Map ptr: NW
         LDA $E0         ; Attributes
         STA [$EB],Y     ; Set NW tile
         INC $E0         ; Tile num +1
         LDY #$0040      ; Map ptr: SW
         LDA $E0         ; Attributes
         STA [$EB],Y     ; Set SW tile
         INC $E0         ; Tile num +1
         LDY #$0002      ; Map ptr: NE
         LDA $E0         ; Attributes
         STA [$EB],Y     ; Set NE tile
         INC $E0         ; Tile num +1
         LDY #$0042      ; Map ptr: SE
         LDA $E0         ; Attributes
         STA [$EB],Y     ; Set SE tile
         RTS

; Build and draw list of absorbed, nulled, and weak elements
C38959:  LDX $2134       ; Item index
         TDC             ; ...
         LDA $D8500F,X   ; Elements
         JSR C388AE      ; Build list
		 JSR C388XX		 ; Draw list
         LDX $2134       ; Item index
         TDC             ; ...		 
		 LDA $D85016,X   ; Absorbed elements
         JSR C388AE      ; Build list
         JSR C388DA      ; Draw list
         LDX $2134       ; Item index
         TDC             ; ...
         LDA $D85017,X   ; Nulled elements
         JSR C388AE      ; Build list
         JSR C388E6      ; Draw list
         LDX $2134       ; Item index
         TDC             ; ...
         LDA $D85018,X   ; Weak points
         JSR C388AE      ; Build list
         JMP C388F2      ; Draw list
		 
; Build and draw list of halved absorbed, nulled, and weak elements from C4B6EE new status routine
C38936:	 LDX #$7C2F		 ; 1st Row ptr
		 LDA $D9		 ; Absorb
		 JSR C388AE      ; Build list
         JSR C388F8      ; Draw list	
		 
		 LDX #$7CEF		 ; 2nd Row ptr
		 LDA $DA		 ; No DMG
		 JSR C388AE      ; Build list
         JSR C388F8      ; Draw list
		 
		 LDX #$7DAF		 ; 3rd Row ptr
 		 LDA $D8		 ; Half DMG
		 JSR C388AE      ; Build list
         JSR C388F8      ; Draw list		
		 
		 LDX #$7E6F		 ; 4th Row ptr
		 LDA $DB		 ; Weakness	
		 JSR C388AE      ; Build list
         JSR C388F8      ; Draw list
		 RTL
		 
padbyte $FF
pad $C38982
Warnpc $C38983

org $C3f96c
	jsr C38836
org $C3f981
	jsr C38836
org $C3f99b
	jsr C38836
org $C3f9b0
	jsr C38836
org $C3Fa3e
	jsr C3881A
org $C3Fa56
	LDA.l C38854,X  ; Sign
	STA $7E9E8B    ; Add to string
	LDA.l C38854+1,X  ; Tens digit
	STA $7E9E8C    ; Add to string
	LDA.l C38854+2,X  ; Ones digit
	STA $7E9E8D    ; Add to string
	jsr C38847