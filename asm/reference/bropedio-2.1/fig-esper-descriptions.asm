hirom
table c3.tbl,rtl

!free = $C3FD08

org $C3599D
  db $10,$B8        ; Reposition EL bonus cursor

org $C3F431
  dw #$470F         ; Position EL bonus label 2 chars left

org $C35A4C
  db #$0B           ; Remove 2 spaces between label and bonus

org $C3F3F3
  dw #$4791         ; Position EL bank label 2 chars left

org $C3F41B
  dw #$47A9         ; Position EL bank 2 chars left

org $C35CE2
  SPLabel:    dw #$47B1 : db "SP ",$00
  LearnLabel: dw #$4437 : db "Learn",$00
  SPMax:      dw #$47BB : db "/30",$00

org $C35B0A         ; Slight adjustments to Synchysi's code here
  JMP MPCost        ; was JSR Learn_Chk
  SPCost:

org $C359CF         ; End of drawing Esper name
  JSR DrawEsperMP

org $C35B21
  JMP FinishSP      ; changed destination

org $C3F752         ; End of Blue_Bank_Txt
  dw #$47B7         ; Locate SP bank down the bottom now
  JMP NewLabels     ; Output banked SP and other new static labels

org !free

FinishSP:
  LDA #$8F          ; P
  STA $2180
  STZ $2180         ; EOS
  JMP $7FD9         ; String done, now print it

MPCost:
  PHA               ; Store SP cost for retrieval
  PHX               ; Preserve X for isolation purposes
  LDA #$FF
  STA $2180
  LDA $E1           ; ID of the spell
  JSR $50F5         ; Compute index
  LDX $2134         ; Load it
  LDA $C46AC5,X     ; Base MP cost
  PLX               ; Restore X
  JSR $04E0         ; Turns A into displayable digits
  LDA $F8           ; tens digit
  STA $2180
  LDA $F9           ; ones digit
  STA $2180
  LDA #$FF          ; space
  STA $2180
  LDA #$8C          ; M
  STA $2180
  LDA #$8F          ; P
  STA $2180
  LDA #$FF          ; 3 spaces
  STA $2180
  STA $2180
  STA $2180
  LDA $AA
  LSR
  BCC .unknown
.known
  PLA
  JMP Known         ; print a checkmark
.unknown
  PLA
  JSR $04E0         ; Turns A into displayable digits
  JMP SPCost        ; go back to where we sliced in and output SP cost

Known:  
  LDA #$FF          ; 2 spaces to center checkmark
  STA $2180
  STA $2180
  
  LDA #$CF          ; checkmark
  STA $2180
  
  LDA #$FF          ; 2 more spaces to overwrite stale text in this slot
  STA $2180
  STA $2180

  STZ $2180         ; EOS
  JMP $7FD9

NewLabels:
; The flip-flopping from white to blue for all of the static positioned
; text could be streamlined, but this is just so much simpler to grap
; than having to slice the blue in with the blue and the white in with
; the white, etc.

  JSR $04B6         ; Write banked SP to screen (relocated)
  LDY #SPMax
  JSR $02F9         ; Print "/30" with SP bank
  LDA #$24
  STA $29           ; Set text color to blue
  LDY #LearnLabel
  JSR $02F9         ; Print "Learn"
  LDA #$20
  STA $29           ; Set text color back to white
  LDA #$00
  XBA               ; Wipe HB of A
  LDA $99
  RTS

DrawEsperMP:
  LDA #$FF
  STA $2180         ; 3 spaces
  STA $2180
  STA $2180
  LDA $99           ; Current Esper
  ADC #$36          ; Get attack ID
  PHX
  JSR $50F5         ; Compute index
  LDX $2134         ; Load it
  LDA $C46AC5,X     ; Base MP cost
  PLX
  JSR $04E0         ; Turns A into displayable digits
  LDA $F8           ; tens digit
  STA $2180
  LDA $F9           ; ones digit
  STA $2180
  LDA #$FF          ; space
  STA $2180
  LDA #$8C          ; M
  STA $2180
  LDA #$8F          ; P
  STA $2180
  STZ $2180         ; EOS
  RTS

; The following contains minor tweaks or optimizations to
; code Synchysi wrote in restrict-espers.asm and esper-
; changes.asm. 
;
; As it stands currently, the "Can't Equip!" message only
; works by fluke because X usually contains a specific text
; pointer (Esper description) – once I started messing around
; with that, it started claiming Terra had every esper due to
; an incompatible offset. The following changes shelter the Uneq
; routine from this issue. They also remove some redundant
; executions of the esper equippability routine by flagging a
; scratch variable with the equippability determination.
;
; Most of the code that follows is reproduced verbatim from
; their original sources, and I have done my best to note the
; portions that differ.

; -------------------------------------------------------------------------------

org $C3F097

; Manually disassembled and modified, commentary is my own.
; I eliminated one of the loops, and optimized the other slightly.
; The latter now also rolls the equippability bit onto a scratch
; variable instead of doing an AND on the LSB of A. This scratch
; variable is used in other places to determine equippability.
; This change is the foundation of everything else in this file.

ChkEsp:
  STZ $FB           ; reserve for equippability flag
  STA $E0           ; store Esper ID in $E0
  LSR #3            ; /8 (determine which byte the esper is in)
  STA $FC           ; store offest to scratch
  LDA $A3           ; load character ID
  ASL #2            ; x4 (4 equippability bytes per character?)
  ADC $FC           ; add stored offset
  TAX               ; index it in X
  LDA $E0           ; load esper ID
  AND #$07          ; which bit of the equippability byte corresponds to this esper?
  TAY
  LDA $C3F0F5,X     ; get equippability byte for esper/character pair
- LSR               ; Do: shift right
  DEY               ; | Y--
  BPL -             ; + loop until Y negative
                    ;
  ROR $FB           ; ############## // New Swag Alert! \\ ###############
                    ; | At this point, the C flag will be 1 if the esper |
                    ; | is equippable. I roll it onto the MSB of $FB     |
                    ; | so that we can use the shorthand `BIT $FB` later |
                    ; | to evaluate the equippability of the currently   |
                    ; | loaded esper without having to destroy A         |
                    ; ####################################################
                    ;
  BPL +             ; if positive, esper cannot be equipped; branch
  JSR $5576         ; can equip; check for equip conflict with another character
  STX $FD           ; keep track of who has the current esper equipped, if anyone
  PHA
  LDA $29
  STA $FC           ; keep track of the esper palette
  PLA
  RTS
+ LDA #$28          ; cannot equip; gray text
  STA $FC           ; keep track of the esper palette
  JMP $5595         ; return

; This routine is the same length as the original, and gives us three
; persistent outputs we can utilize elsewhere so that we don't have to
; run it as many times on the esper info screen.

; -------------------------------------------------------------------------------

org $C3F77B

; The main change here is that I now check $FB for equippability
; instead of calling `Chk_Esper_Eq`. The rest is just making sure
; the palette values are loaded in the correct execution forks.

Learn_Chk:
  STZ $AA
  LDA $E0           ; SP cost of the spell
  PHA               ; Preserve it, because C3/50A2 mutilates $E0
  LDA $FB           ; Is esper equippable? (new)
  BPL .cantEquip
  LDA $E1           ; If so, get spell ID
  JSR $50A2         ; See if it's known yet
  BEQ .notLearned
  INC $AA           ; If so, flag $AA
.notLearned
  LDA #$20          ; White text if esper is equippable
  BRA .done
.cantEquip
  LDA #$28          ; Gray text if not (moved from above)
.done
  STA $29           ; Set palette
  PLA               ; Retrieve SP cost
  RTS

; -------------------------------------------------------------------------------

org $C3F7A5

; This removes a `ChkEsp` call from `Chk_Spell`, since we
; now have a stored shorthand for looking that up. A snippet
; of original code (commented out) is included for context

; Chk_Spell:
;   LDA $99           ; Load esper ID
;   STA $4202
;   JSR ChkEsp        ; <- $C3F7A5, this is where I cut in
;   TDC
;   LDA $29
;   CMP #$28          ; <- from where I start to the end of this line, that's 8 bytes
;   BEQ Bzzt_Player   ; <- $C3F7AF, this is where my slice should end up

  LDA $FB             ; Is esper equippable?
  BRA $04             ; Skip the next 4 bytes
  NOP #4              ; Dummy them out to be sure
                      ; = 8 bytes
; BPL Bzzt_Player     ; This is what I need it to do, so...
  db #$10             ; ...just replace BEQ -> BPL

; -------------------------------------------------------------------------------

; There are two notable changes in the following section.
;
; First, it flips the logic: check for unequippability, then
; assume a conflict if it's equippable (rather than checking for
; the conflicting name and then assuming it's unequippable if the
; letter is blank, which will only work for a pre-assumed X offset)
;
; This makes the "Can't Equip!" message much less prone to breaking
; due to unexpected X register values that are leftover from other
; operations.
;
; Second, it gets rid of the yucky JSR/PLX juju by JMPing in and out.
; If one execution branch ends in a JMP, might as well let them both.
; We have the space to spare, and it's only called in one place.

org $C355B2
  JMP Uneq            ; Was JSR, but see below

org $C3F0CB
Uneq:
  LDA $FB             ; Is esper equippable?
  BPL +               
  LDA $1602,X         ; Character's name; displaced from calling function
  JMP $55B5           ; If esper is equippable, go back and display who has it equipped
+ LDX $00             ; Else, print "Can't Equip!" error message
                      
; Note the gross PLX is gone now that we JMP back
; to the calling location instead of RTS :)

- LDA.l NoEqTxt,X
  STA $2180           ; Print the current letter.
  BEQ Null            ; If the letter written was null ($00), exit.
  INX                 ; Go to the next letter.
  BRA -
Null:
  JMP $7FD9           ; 27 bytes total, 2 bytes to spare

; "Can't equip!" text.
;
; NOTE: the extra 2 nulls at the end are to make up for the difference
;   in this routine's length. The "p!" at the end of the string in the
;   old version was still there, so I've just nulled it out to be tidy.
;   Esper equippability tables still follow from here in their original
;   locations.

NoEqTxt:
  DB $82,$9A,$A7,$C3,$AD,$FF,$9E,$AA,$AE,$A2,$A9,$BE,$00,$00,$00

org $C358E1           ; previously `JSR ChkEsp`
  STA $E0             ; memorize esper
  LDX $FD             ; retrieve stored offset for who has esper equipped
  NOP                 ; filler byte to get us back in the right spot
  LDA $FC             ; retrieve stored esper palette


!freeC3_A = $C33BDE   ; 18 bytes, we'll use 17 :)
!freeC3_B = $C38777   ; 29 bytes, we'll use 24 >.>

!freeXL = $C48270     ; big ol' chunk of freespace :D
!freeXLEnd = $C487C1
!freeXLbank = $C4    ; if freeXL changes, change this accordingly

org $C35BA6
  JSR LoadDescription

org !freeC3_A
LoadDescription:
  LDA $4B             ; On esper name?
  BEQ .esper          ; Branch if so
  CMP #$06            ; On bonus?
  BEQ .bonus          ; Branch if so
  JMP $5BE3           ; Load magic description
.esper
  JMP SummonDescription
.bonus
  JMP $5BF6           ; Load EL description

org !freeC3_B
SummonDescription:    ; Load Esper summon description
  LDX #EsperDescPointers
  STX $E7             ; Set ptr loc LBs
  LDX $00
  STX $EB             ; Set text loc LBs
  LDA #!freeXLbank    ; Pointer/text bank
  STA $E9             ; Set ptr loc HB
  STA $ED             ; Set text loc HB
  LDA #$10
  TRB $45             ; Description: On
  RTS                 ;   It expects (in a roundabout way) this value to be in the X
                      ;   register in the event a character tries to equip an Esper
                      ;   that doesn't belong to them, because it needs an offset to
                      ;   a region of memory where there will be a large swath of
                      ;   values below #$80 /shrug


org $C358B9
  JSL InitEsperDataSlice


; The code, pointers, and text in !freeXL below is in a region
; of the ROM usually utilized for graphics data, and it just so
; happens that the Esper summon drawer in combat has some sort of
; label in it that points to this region of the ROM for its glyphs.
; It is normally invisible, since this region is empty, but since
; I added a bunch of stuff here, it ends up displaying a couple of
; tiles of gibberish instead. This change just prevents these tiles
; from displaying at all.

org $C2E092           
  db $03,$8C,$03,$8F,$FF,$16,$00,$00         
    ; 03  2C  03  2F  FF  16  00  00

org !freeXL

InitEsperDataSlice:
  LDA #$10            ; Reset/Stop desc
  TSB $45             ; Set menu flag
  LDA $49             ; Top BG1 write row
  STA $5F             ; Save for return
  RTL

EsperDescPointers:
  dw Ramuh
  dw Ifrit
  dw Shiva
  dw Siren
  dw Terrato
  dw Shoat
  dw Maduin
  dw Bismark
  dw Stray
  dw Palidor
  dw Tritoch
  dw Odin
  dw Loki
  dw Bahamut
  dw Crusader
  dw Ragnarok
  dw Alexandr
  dw Kirin
  dw Zoneseek
  dw Carbunkl
  dw Phantom
  dw Seraph
  dw Golem
  dw Unicorn
  dw Fenrir
  dw Starlet
  dw Phoenix

Ramuh: db "Bolt damage - all foes",$00
Ifrit: db "Fire damage - all foes",$00
Shiva: db "Ice damage - all foes",$00
Siren: db "Sets `Bserk^ - all foes",$00
Terrato: db "Earth damage - all foes",$00
Shoat: db "Sets `Petrify^ - all foes",$00
Maduin: db "Wind damage - all foes|Ignores def.",$00
Bismark: db "Water damage - all foes",$00
Stray: db "Stamina-based cure - party|Sets `Regen^",$00
Palidor: db "Party attacks with `Jump^",$00
Tritoch: db "Fire",$C0,"Ice",$C0,"Bolt damage - all foes",$00
Odin: db "Non-elemental dmg - all foes|Stamina-based; ignores def.",$00
Loki: db $00
Bahamut: db "Non-elemental dmg - all foes|Ignores def.",$00
Crusader: db "Dark damage - all foes",$00
Ragnarok: db "9999 damage - one foe",$00
Alexandr: db "Holy damage - all foes",$00
Kirin: db "Cures HP - party|Revives fallen allies",$00
Zoneseek: db "Sets `Shell^ - party",$00
Carbunkl: db "Sets `Rflect^ - party",$00
Phantom: db "Sets `Vanish^ - party",$00
Seraph: db "Sets `Rerise^ - party",$00
Golem: db "Blocks physical attacks|(Durability ",$D2," caster*s max HP)",$00
Unicorn: db "Stamina-based cure - party|Lifts most bad statuses",$00
Fenrir: db "Sets `Image^ - party",$00
Starlet: db "Cures HP to max - party|Lifts all bad statuses",$00
Phoenix: db "Revives fallen allies - party|(HP ",$D2," max)",$00

warnpc !freeXLEnd;
