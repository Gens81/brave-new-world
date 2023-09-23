hirom
table table_c3.tbl,rtl
; header

; BNW - Status Screen Overhaul (+ Equip/Gear stat reorder)
; Bropedio (August 18, 2019)

!local_free = $C3FC20

; #########################################################
; Portrait placement (shift upward, and mask Gogo)

org $C36200
  JSR PortraitPlace

org $C35F50
  LDX #$60CA               ; mask Gogo portrait at new coords

; #########################################################
; Status Menu
; Change some stat names, and remove ".." before each stat

org $C35D63
  LDY #$000A               ; 5 strings

org $C36437
  dw StatusMenu_vigor
  dw StatusMenu_stam
  dw StatusMenu_magic
  dw StatusMenu_evade
  dw StatusMenu_mevade
org $C36455
  dw StatusMenu_lvl
  dw StatusMenu_hp
  dw StatusMenu_mp
  dw StatusMenu_slash1
  dw StatusMenu_slash2
  dw StatusMenu_prcnt1
  dw StatusMenu_prcnt2
  dw StatusMenu_speed
  dw StatusMenu_attack
  dw StatusMenu_def
  dw StatusMenu_mdef
  dw StatusMenu_exp
  dw StatusMenu_lvlup

org $C3646F
StatusMenu:
.slash1  dw $39AB : db "/",$00
.slash2  dw $39EB : db "/",$00
.prcnt1  dw $7F83 : db $00
.prcnt2  dw $8883 : db $00
.lvl     dw $395D : db "LV",$00
.hp      dw $399D : db "HP",$00
.mp      dw $39DD : db "MP",$00
.exp     dw $7ACD : db "Exp.",$00
.lvlup   dw $7B4D : db "Next LV",$00
.vigor   dw $7C4D : db "Vigor",$00
.magic   dw $7CCD : db "Magic",$00
.speed   dw $7D4D : db "Speed",$00
.stam    dw $7DCD : db "Stamina",$00
.attack  dw $7F4D : db "Attack",$00
.def     dw $7FCD : db "Defense",$00
.mdef    dw $7FEB : db "M.Defense",$00
.evade   dw $884D : db "Evade",$00
.mevade  dw $886B : db "M.Evade",$00
warnpc $C3652E

; ##################################################
; Handle windows (position, size, adding another)

org $C35F79
WindowPositions:
  dd $051C5D4B            ; lower window size/position
  dd $07085BAD            ; command window size/position
  dd $091C588B            ; top window size/position
org $C35D26
  JSR NewWindow           ; create new (middle) window

; ##################################################
; Display status effects in Status menu
org $C3625B
  LDY #$38E7              ; Text position
  LDX #$0C78              ; Icon position

; ##################################################
; Position stat information

org $C35FD5 : LDX #$7C61     ; Vigor position
org $C35FE1 : LDX #$7D61     ; Speed position
org $C35FED : LDX #$7DE1     ; Stamina position
org $C35FF9 : LDX #$7CE1     ; Magic position
org $C36013 : LDX #$7F61     ; Attack position
org $C3601F : LDX #$7FE1     ; Defense position
org $C3602B : LDX #$8861     ; Evade position
org $C36037 : LDX #$7FFF     ; Mag.Def position
org $C36043 : LDX #$887F     ; Mblock position
org $C36049 : LDY #$78D9     ; Actor name position

org $C36055
  JSR $F3BF       ; draw EL label
  JSR ELStuff     ; draw next EL labels

org $C36068
RevertToVanilla:
  LDX $67         ; Actor's address
  LDA $0011,X     ; Experience LB
  STA $F1         ; Memorize it
  LDA $0012,X     ; Experience MB
  STA $F2         ; Memorize it
  LDA $0013,X     ; Experience HB
  STA $F3         ; Memorize it
  JSR $0582       ; Turn into text
  LDX #$7ADB      ; Text position (new position)
  JSR $04AC       ; Draw 7 digits (shorter)
  JSR $60A0       ; Get needed exp
  JSR $0582       ; Turn into text
  LDX #$7B5B      ; Text position (new position)
  JSR $04AC       ; Draw 7 digits (shorter)
  STZ $47         ; Ailments: Off
  JSR $11B0       ; Hide ail. icons
  JMP $625B       ; Display status
warnpc $C36097

; EP pos: 7AF5

org $C36096 : dw $3965       ; Level
org $C36098 : dw $39A3       ; HP                  
org $C3609A : dw $39AD       ; Max HP
org $C3609C : dw $39E3       ; MP
org $C3609E : dw $39ED       ; Max MP


; ##################################################
; Cursor/Text positions for Commands

org $C33713
  dw $7090                ; command 1 (cursor)
  dw $7C90                ; command 2 (cursor)
  dw $8890                ; command 3 (cursor)
  dw $9490                ; command 4 (cursor)

org $C36102 : LDY #$7CF1  ; tilemap ptr (cmd 1)
org $C36108 : LDY #$7D71  ; tilemap ptr (cmd 2)
org $C3610E : LDY #$7DF1  ; tilemap ptr (cmd 3)
org $C36114 : LDY #$7E71  ; tilemap ptr (cmd 4)

; ##################################################
; EL Label Text Data

org $C3F2C7 : dw $396B                     ; EL label
org $C3F2FF : dw $396B                     ; EL clear
org $C3F277 : dw $7B6B : db "Next EL",$00  ; Next EL label
org $C3F287 : dw $7B6B : db "       ",$00  ; Next EL label clear
org $C3F297 : dw $7B7B                     ; Next EL number clear

; ##################################################
; Next EL calculation byte change (use F3-F4, not F1-F2)

org $C3F369 : STA $F3

; ##################################################
; Draw/clear EP label when Next EL label is drawn/cleared

org $C3F341 : JSR DrawEPLabel
org $C3F334 : JSR ClearEPLabel

; ##################################################
; New Code (C3)

org !local_free

NewWindow:
  JSR $6A4B               ; vanilla code
  STZ $37                 ; shift BG1 down slightly
  LDY #NewWindowSpec      ; middle window size/position
  JMP $0341               ; draw it

NewWindowSpec:
  dd $061C5B4B            ; change this to the right pos/size

PortraitPlace:
  LDA $26
  AND #$00FF
  CMP #$000B
  BEQ .high
  CMP #$000C
  BEQ .high
  CMP #$0042
  BEQ .high
  LDA #$0038
  RTS
.high
  LDA #$0011
  RTS

ELStuff:
  JSR $F31B               ; get EP and EP to next Lvl (in F1-F4)
  BCC .exit
  JSR $052E               ; convert 16-bit number into text (from F3-F4)
  LDX #$7B7B              ; next EL number coords
  JSR $049A               ; draw 5 digits
  REP #$20                ; 16-bit A
  LDA $F1                 ; total EP
  STA $F3                 ; move to source for drawing
  SEP #$20                ; 8-bit A
  JSR $052E               ; convert 16-bit number into text (from F3-F4)
  LDX #$7AFB              ; next EL number coords
  JSR $049A               ; draw 5 digits
.exit
  RTS

DrawEPLabel:
  JSR $02F9               ; draw text at pointer
  LDY #EPLabel            ; pointer to EP Label text
  JMP $02F9               ; draw text at pointer

ClearEPLabel:
  JSR $02F9               ; draw text at pointer
  LDY #EmptyEPLabel       ; pointer to EP Label text
  JSR $02F9               ; draw text at pointer
  LDY #EmptyEPText        ; pointer to EP Label text
  JMP $02F9               ; draw text at pointer

EPLabel:
  dw $7AEB : db "EP",$00     ; EP label
EmptyEPLabel:
  dw $7AEB : db "  ",$00     ; EP label
EmptyEPText:
  dw $7AFB : db "     ",$00  ; EP label

; #########################################################
; Gear Data (Item Menu)
; Update stat names, reorder

org $C386AA : LDA #$8445    ; Vigor modifier
org $C386C1 : LDA #$8545    ; Speed modifier
org $C386D6 : LDA #$85C5    ; Stamina modifier
org $C386F0 : LDA #$84C5    ; Magic modifier

org $C38D77 : dw $842F      ; Vigor label position
org $C38D7F : dw $85AF      ; Stamina label position
org $C38D89 : dw $84AF      ; Magic label position
org $C38DCB : dw $852F      ; Speed label position

org $C38D8B : db "Magic",$00
org $C38D9F : db "M.Evade",$00
org $C38DE9 : db "M.Def.",$00
org $C38DD5 : db "Attack",$00

; #########################################################
; Equip/Relic Menus
; Update stat names, remove ".." characters, reorder stats

org $C390E5 : LDX #$7CB7    ; Old vigor position
org $C390F1 : LDX #$7DB7    ; Old speed position
org $C390FD : LDX #$7E37    ; Old stamina position
org $C39109 : LDX #$7D37    ; Old magic position

org $C3927D : LDX #$7CBF    ; New vigor position
org $C3928F : LDX #$7DBF    ; New speed position
org $C392A1 : LDX #$7E3F    ; New stamina position
org $C392B3 : LDX #$7D3F    ; New magic position

org $C3A371 : dw $7CA9      ; Vigor label position
org $C3A379 : dw $7E29      ; Stamina label position
org $C3A383 : dw $7D29      ; Magic label position
org $C3A3C5 : dw $7DA9      ; Speed label position

org $C3A385 : db "Magic",$00
org $C3A399 : db "M.Evade",$00
org $C3A3CF : db "Attack",$00
org $C3A3E3 : db "M.Def.",$00

