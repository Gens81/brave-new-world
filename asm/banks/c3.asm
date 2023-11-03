hirom
table vwf.tbl,rtl

; C3 Bank

; #########################################################################
; Variable definitions for reuse

!_ellipsis = #$C7
!w = $E8 ; white magic dot
!b = $E9 ; black magic dot
!g = $EA ; gray magic dot

; #########################################################################
; Some Menu UI Coordinates

; -------------------------------------------------------------------------
; Equip Menu Coordinates

!rh_coords = $7A8D ; tilemap pointer for righthand text
!lh_coords = $7AAB ; tilemap pointer for lefthand text
!head_pos  = $7B0D ; tilemap pointer for head text
!body_pos  = $7B2B ; tilemap pointer for body text
!relic1pos = $7B8D ; tilemap pointer for relic1 text
!relic2pos = $7BAB ; tilemap pointer for relic2 text

; #########################################################################
; Top Level Menu Jump Table ($C301DB)

org $C30247 : dw EqpMenuOpts    ; 36: New Equip Menu (unified equip menu)
org $C30285 : dw GearSlotSelect ; 55: Updated Gear Slot Fill (unified equip)
org $C30289 : dw BrowseGear     ; 57: New Gear Browsing (unified equip menu)

; #########################################################################
; Draw Character HP/MP/LV Values

org $C30C81 : JSR Esp_Lvl ; Also draw EL value

; #########################################################################
; Animation Queue

; Remove infinite loop that existed for some reason (TODO: Test this)
; Change included in "Esper Changes" hack for EP/EL/Spell Bank features
org $C311AD : NOP #2

; #########################################################################
; In Game Time Update

org $C3140D : JSR FrameCounter ; hook to increment RNG frame counter

; #########################################################################
; Initialize Skills Menu

org $C31B61 : JSR StChr ; store character ID in $A3 (for esper restrict)

; #########################################################################
; Initialize Equip Menu (35)
; Rearrange code to do away with pointless BRA
; Supports new unified equip menu, including descriptions

org $C31BB8
InitializeEquipMenu:
  JSR InitEqpVars    ; init variables
MoreEquipMenu:
  JSR DrawEquipMenu  ; [shifted] Draw menu; status
  LDA #$01           ; [shifted] C3/1D7E
  STA $26            ; [shifted] Next: Fade-in
  LDA #$36           ; [shifted] C3/9621
  STA $27            ; [shifted] Queue: Option list
  JMP $3541          ; [shifted] BRT:1 + NMI

; ------------------------------------------------------------------------
; Initialize variables for Equip menu
; No longer set main cursor on
; Now we display equip description

InitEqpVars:         ; shifted from 1BBD
  JSR $352F          ; Reset/Stop stuff
  JSR $6A08          ; Set Win1 bounds
  STZ $4A            ; List scroll: 0
  STZ $49            ; Top BG1 WR row: 1
  LDA #$10           ; Reset/Stop desc
  TSB $45            ; Set menu flag
  JSR $1B99          ; Queue desc anim
  JSR $94B6          ; Set to shift text
  JMP InitEqpHelp    ; jump to finish routine
warnpc $C31BE5       ; some freespace here

; #########################################################################
; Swap Actor in Equip Menu (7E & 7F) - $C31BE5
; Instead of drawing blue title for mode, instead highlight current
; mode in yellow, and change other mode options to gray

org $C31BE8 : JSR SetEquip ; Update menu colours (Equip)
org $C31BF6 : JSR SetRmove ; Update menu colours (Remove)

; ------------------------------------------------------------------------
; Redraw Equip Menu after Swap
; Updated JSR/JMP addresses

org $C31C01
  JSR InitEqpVars    ; Reset variables (new routine address)
  JSR DrawEquipMenu  ; [unchanged] Draw menu; status
  JMP YellowTxt      ; Set yellow palette

; #########################################################################
; Open Equip Menu After Optimizing Gear (6D)

org $C31C1D : NOP #3 ; skip optimize routine

; #########################################################################
; Open Equip Menu After Removing Gear (6E)
; Update JSR and branch targets

org $C31C26
  JSR InitEqpVars    ; Init variables
  JSR $96A8          ; Remove gear
  LDA #$02           ; Menu: Equip
  STA $25            ; Set submenu
  BRA MoreEquipMenu  ; Draw menu, etc.

; #########################################################################
; Allows the player to equip Umaro manually.

org $C31E6E : CMP #$0E

; #########################################################################
; Initialize Magic Menu

org $C32125 : NOP #3 ; skip drawing MP Cost in Magic Menu

; #########################################################################
; Initialize Rage Menu
;
; Modified by dn's patch to handle BNW's reduced rage set (64)

org $C321AD : LDA #$03f0 ; fix arrow (scrollbar speed)
org $C321C3 : LDA #$18   ; set scroll limit (8 onscreen + 24 scroll * 2 = 64)

; #########################################################################
; Sustain Config Menu
;
; Modified by dn's "Battle Speed Remove" patch, to adjust "Controller"
; option index.

org $C322D0 : CMP #$07     ; "Controller" option ID (was 8 in vanilla)

; #########################################################################
; Game Options Pressing A Handlers
;
; Modified by dn's "Remove Battle Speed" patch.

org $C3234A
OptionPressA:
  dw .rts     ; Bat.Mode
  dw .rts     ; Msg.Speed
  dw $2368    ; Cmd.Set
  dw .rts     ; Gauge
  dw .rts     ; Sound
  dw .rts     ; Cursor
  dw .rts     ; Reequip
  dw $2379    ; Controller
  dw .rts     ; [unused]
org $C3235C
  dw .rts     ; Mag.Order
  dw .rts     ; Window
  dw $2388    ; Color
  dw $2388    ; R
  dw $2388    ; G
  dw $2388    ; B
org $C32341
.rts

; #########################################################################
; Sustain Magic Menu

org $c32806 : NOP #3 ; skip drawing MP cost

; #########################################################################
; Sustain Dance Menu

org $C328AA : JSR DancesHook ; insert dance descriptions

; #########################################################################
; Sustain Rage Menu

org $C328BE : JSR RageDescHelp ; insert rage descriptions

; #########################################################################
; Draw Esper

org $C32937 : JMP DrawEsperHook ; include esper equip bonuses

; #########################################################################
; Field Spell Usage

org $C32C32 : CMP #$29 ; update spell ID for float (allow field usage)
org $C32C36 : CMP #$1F ; update spell ID for Imp (allow field usage)
org $C32C67 : AND #$65 ; add Imp status to curable by Remedy item in field

; #########################################################################
; Return to Magic Menu

org $C32D56 : NOP #3 ; skip drawing MP cost

; #########################################################################
; Handle Main Menu Selections

org $C32E72 : dw ReviewMenu ; was "Relic", now "Review"

; #########################################################################
; Character Display

; Change position of LV to make room for EL
; If espers have been acquired, write EL label after LV label
org $C33303 : JSR EL_Main_1 ; Main menu, character 1
org $C3332D : dw $39A5
org $C3334F : JSR EL_Main_2 ; Main menu, character 2
org $C33379 : dw $3B25
org $C3339B : JSR EL_Main_3 ; Main menu, character 3
org $C333C5 : dw $3CA5
org $C333E7 : JSR EL_Main_4 ; Main menu, character 4
org $C33411 : dw $3E25


; #########################################################################
; Navigation Data for Status Menu ($C336FF)

; Update cursor positions for Status Menu Redesign
org $C33713
  dw $7090                ; command 1 (cursor)
  dw $7C90                ; command 2 (cursor)
  dw $8890                ; command 3 (cursor)
  dw $9490                ; command 4 (cursor)

; #########################################################################
; Text Pointers for Main Menu ($C33723)

org $C3372D : dw ReviewTxt ; New "Review" menu option (was "Relic")
                           ; TODO: Why not change text in place?

; #########################################################################
; Positioned Text for Main Menu ($C3376F)

org $C33819 : db "GP" ; instead of Gp

; #########################################################################
; Config Menu Initialize

org $C33867
ConfigMenuNav:
  db $81      ; never wraps
  db $00      ; initial column
  db $00      ; initial row
  db $01      ; 1 column
  db $08      ; 8 rows (from 9)

org $C3386C
ConfigCursorPositions:
  dw $3560    ; Exp Mode
  dw $4960    ; Msg.Speed
  dw $5960    ; Cmd.Set
  dw $6960    ; Gauge
  dw $7960    ; Sound
  dw $8960    ; Cursor
  dw $9960    ; Reequip
  dw $A960    ; Controller

org $C338C9
DrawConfigMenu:
  LDA #$28      ; "Yellow" palette
  STA $29       ; set ^
  LDY #BNWText  ; "BNW" title text data offset

org $C339E6
ConfigMenuWindowLayout:
  dw $588D     ; title window position on screen
  db $1A       ; title window width+1(left)+1(right)
  db $02       ; title window height+1(top)+1(bottom)

org $C33A40 : LDA #$07     ; "Controller" config option ID (was 8 in vanilla)

org $C33BA7 : LDY #OffTxt2

; Old "Battle Speed" drawing routine [now freespace]
org $C33BB7
  RTS           ; automatically return from battle speed jump
BNWText:   dw $78D1 : db "  Brave New World 2.1.0",$00
                      db "8 ",$00 ; TODO: Remove this text fragment
BattleTxt: dw $3A4F : db "Battle",$00

%free($C33BDE)

; -------------------------------------------------------------------------
; Helper for Loading Summon Descriptions (in freespace)

org $C33BDE           ; 18 bytes, we'll use 17 :)
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

%free($C33BF2)

org $C33C55 : LDY #WindowTxt
org $C33C7E : LDY #OnWait
org $C33CCB : LDY #ResetTxt
org $C33CFF : LDY #WalkTxt

; #########################################################################
; Game Options Update Handlers
;
; Modified by dn's "Remove Battle Speed" patch.

org $C33D43
OptionJumpPage1:
  dw $3D61     ; Bat.Mode
  dw $3DAB     ; Msg.Speed
  dw $3DE8     ; Cmd.Set
  dw $3E01     ; Gauge
  dw $3E1A     ; Sound
  dw $3E4E     ; Cursor
  dw $3E6D     ; Reequip
  dw $3E86     ; Controller
  dw $FFFF     ; [unused]

org $C33D55
OptionJumpPage2:
  dw $3E9F     ; Mag.Order
  dw $3ECD     ; Window
  dw $3F01     ; Viewed color
  dw $3F3C     ; R
  dw $3F5B     ; G
  dw $3F7A     ; B

;org $C33D7A
;%free($C33DAB) ; remove "Battle Speed" handler code

; #########################################################################
; Positioned Text for Config Menu (page 1)

org $C34903

ConfigTxt1: dw ControllerTxt
ConfigTxt2: dw CursorTxt
ConfigTxt3: dw FastTxt
ConfigTxt4: dw SlowTxt

ControllerTxt: dw $3D8F : db "Controller",$00
OnTxt2:        dw $39F5 : db "On",$00
                          db $AD,$00          ; fill empty space from "Wait"
FastTxt:       dw $3A65 : db "Fast",$00
SlowTxt:       dw $3A75 : db "Slow",$00
ShortTxt:      dw $3B35 : db "Short",$00
OffWait:       dw $3BA5 : db "Off",$00        ; Off and On swapped for Wait Gauge
OnWait:        dw $3BB5 : db "On",$00
StereoTxt:     dw $3C25 : db "Stereo",$00
MonoTxt:       dw $3C35 : db "Mono",$00
MemoryTxt:     dw $3CB5 : db "Memory",$00
DashTxt2:      dw $3D25 : db "Dash",$00,$00,$00,$00
MultipleTxt:   dw $3DB5 : db "Multiple",$00
Scale1Txt:     dw $3A25 : db "1 2 3 4 5 6",$00
Scale2Txt:     dw $3AA5 : db "1 2 3 4 5 6",$00
CursorTxt:     dw $3C8F : db "Cursor",$00
warnpc $C34993

org $C34993
ConfigTxt5: dw ExpGainTxt
ConfigTxt6: dw BattleTxt
ConfigTxt7: dw MsgSpeedTxt
ConfigTxt8: dw CmdSetTxt
ConfigTxt9: dw GaugeLabel
ConfigTxtA: dw SoundTxt
ConfigTxtB: dw DashTxt

ConfigTitleTxt: dw $78F9 : db "Config",$00 ; TODO: No longer used
ExpGainTxt:     dw $39CF : db "Exp.Gain",$00
BatSpeedTxt:    dw $3A0F : db "Bat.Speed",$00
MsgSpeedTxt:    dw $3A8F : db "Msg.Speed",$00
CmdSetTxt:      dw $3B0F : db "Cmd.Set",$00
GaugeTxt:       dw $3B8F : db "Gauge",$00 ; TODO: No longer used
SoundTxt:       dw $3C0F : db "Sound",$00
DashTxt:        dw $3D0F : db "B Button",$00
OffTxt2:        dw $39E5 : db "Off",$00,$00,$00,$00
WindowTxt:      dw $3B25 : db "Window",$00
ResetTxt:       dw $3CA5 : db "Reset",$00
WalkTxt:        dw $3D35 : db "Walk",$00
SingleTxt:      dw $3DA5 : db "Single",$00
warnpc $C34A1C

; #########################################################################
; Magic Menu Cursor Positions

org $C34BAE
MagicMenuCursorPositions:
  dw $7408    ; Spell 1
  dw $7478    ; Spell 2
  dw $8008    ; Spell 3
  dw $8078    ; Spell 4
  dw $8C08    ; Spell 5
  dw $8C78    ; Spell 6
  dw $9808    ; Spell 7
  dw $9878    ; Spell 8
  dw $A408    ; Spell 9
  dw $A478    ; Spell 10
  dw $B008    ; Spell 11
  dw $B078    ; Spell 12
  dw $BC08    ; Spell 13
  dw $BC78    ; Spell 14
  dw $C808    ; Spell 15
  dw $C878    ; Spell 16

; #########################################################################
; Draw Skills Menu(s)

org $C34C80 : JSR FlipMPDisplay : NOP #2 ; default MP display to "on"
org $C34CC0 : NOP #6 ; skip drawing "title box" window
org $C34D8C : NOP #6 ; skip drawing "MP" label
org $C34EEA : JSR EL_Skill  ; draw EL in skills display
org $C34F12 : db $35,$42 ; make room for EL display

; Data table for magic order in menus
org $C34F49
  db $2D,$00,$19,$FF
  db $2D,$19,$00,$FF
  db $00,$19,$2D,$FF
  db $00,$2D,$19,$FF
  db $19,$2D,$00,$FF
  db $19,$00,$2D,$FF

org $C34F69 : LDX #$0014 ; the number of grey magic spells
org $C34F6E : LDX #$0019 ; the number of black magic spells
org $C34FAC : LDX #$0011 ; increase space between spell list columns (was $10)

; #########################################################################
; Draw Magic Menu Spell

org $c35005
DrawSpellAndCost:
  LDA !_ellipsis     ; ellipsis character
  STA $2180          ; add to string
  LDA #$FF           ; space character
  STA $2180          ; add to string
  LDA $F8            ; tens digit
  STA $2180          ; add to string
  JMP EndDrawMP      ; finish old [moved] code
  db $FF,$FF,$FF     ; [fill unused]
warnpc $C3501A

org $C35027 : LDY #$000C ; allow for spell name length 12 (was 11)

org $c35082
  LDA #$FF           ; space character
  JMP EndDrawPercent ; finish drawing percentage learned
  db $FF             ; [fill unused]

; -------------------------------------------------------------------------
; Skip Imp disabling magic usage in field

org $C3518D : BRA No_Imp
org $C3519B : No_Imp:

; #########################################################################
; Draw MP Cost in Magic Menu
; No longer in use, can be used as freespace

org $C351C6
warnpc $C351F9

; #########################################################################
; Draw Lore Menu

org $C35203 : NOP #6 ; skip drawing "Lore" title

; #########################################################################
; Draw Bushido Menu

org $C352E8 : NOP #6 ; skip drawing "Bushido" title

; #########################################################################
; Draw Rage Menu

org $C3539B : NOP #6 ; skip drawing "Rage" title

; #########################################################################
; Build Rage List
;
; Rewritten by Assassin for "Alphabetical Rage" patch. Included notes:
;   Generates alphabetical Rage list under the Skills menu.  Loops for all 256 enemies.
;   Function C3/5418 still needs to process this list to display the names.  I tweaked that
;   routine to make sure it preserves the ordering established here.

org $C353C1
BuildRageList:
  LDX #$9D89       ; WRAM buffer address
  STX $2181        ; set ^
  SEP #$10         ; 8-bit X/Y
  LDX $00          ; zero iterator
.loop
  LDA RageList,X   ; next sorted rage ID
  TAY              ; index it
  PHX              ; store iterator
  CLC              ; $C25217 treats carry as bit 9 of A
  JSL LongByteMod  ; X: byte index, A: bitmask for this rage bit
  BIT $1D2C,X      ; compare to known rages
  BEQ .null        ; branch if not learned yet
  TYA              ; else, get rage ID
  BRA .save        ; and branch to save it
.null
  LDA #$FF         ; "null" entry
.save
  STA $2180        ; store rage in menu
  PLX              ; restore iterator
  INX              ; next sorted rage index
  BNE .loop        ; loop until 256 rollover TODO: Update this for BNW
  REP #$10         ; 16-bit X/Y
  RTS
  NOP #3           ; [fill empty space]
  RTS              ; [fill empty space]
warnpc $C353EE

; #########################################################################
; Draw Rage Name
;
; Largely rewritten as part of Assassin's "Alphabetical Rage" patch. See notes:
;   - If a given menu slot holds FFh, display a blank string in place of the enemy's name.
;   - If the slot holds 0-FEh, display the name of the enemy whose number matches the current
;     menu slot's *contents*.  This is a change from the original code, which used the
;     enemy number equal to the slot's position.  The home of that rowdy second "LDA $E5" is
;     now inhabited by peaceful NOPs.

org $C35418
DrawRageName:
  LDA $E6         ; current row
  INC             ; one row below
  JSR $809F       ; X: tile position
  REP #$20        ; 16-bit A
  TXA             ; tile position in A
  STA $7E9E89     ; save to buffer
  SEP #$20        ; 8-bit A
  TDC             ; zero A/B
  LDA $E5         ; rage slot index
  TAX             ; index it
  LDA $7E9D89,X   ; rage ID in this slot
  CMP #$FF        ; "null" (unlearned rage)
  BEQ .null       ; branch if ^
  NOP #2          ; [unused space]
  JSR $8467       ; load enemy name
  JMP $7FD9       ; draw enemy name
.null
  LDY #$000A      ; length of enemy names
  LDX #$9E8B      ; WRAM address
  STX $2181       ; set ^
  LDA #$FF        ; " " (space)
.space_loop
  STA $2180       ; write space
  DEY             ; next character
  BNE .space_loop ; loop for full length
  STZ $2180       ; EOL
  JMP $7FD9       ; draw empty name
warnpc $C35452

; #########################################################################
; Draw Esper Menu

org $C35460 : NOP #6       ; skip drawing "Esper" title
org $C35524 : JSR ChkEsp   ; handle restrictions when choosing esper palette
org $C35576 : ChkEq:       ; [label] check if any espers are already equipped
org $C35593 : LDA #$2C     ; color: grey-blue (esper equipped by someone else)
org $C35595 : SetTxtColor: ; [label] used in restrict espers hack
org $C355B2 : JMP Uneq     ; handle printing name of unequippable esper

; #########################################################################
; Draw Blitz Menu

org $C355DE : NOP #6 ; skip drawing "Blitz" title

; #########################################################################
; Draw Blitz Inputs
;
; Jump added by dn's "Blitz Menu" patch, to draw Blitz names as well

org $C3565D : JSR BlitzNames

; #########################################################################
; Draw Dance Menu

org $C3577E : NOP #6 ; skip drawing "Dance" title

; #########################################################################
; Initialize Esper Data Menu

org $C358B9 : JSL InitEsperDataSlice ; ($C4)

; #########################################################################
; Sustain Esper Data Menu

org $C358DB : JMP Pressed_A : NOP ; support Spell Bank and EL Bonus selection

org $C358E1           ; handle restrictions when choosing esper palette
  STA $E0             ; memorize esper
  LDX $FD             ; retrieve stored offset for who has esper equipped
  NOP                 ; filler byte to get us back in the right spot
  LDA $FC             ; retrieve stored esper palette

; Checks if the text color is gray, and BZZTs the character if it is. Since
; we're also using blue to indicate an unequippable esper, we'll simply
; change the comparison from "if not gray, branch" to "if white, branch"

org $C358E8
  CMP #$20        ; is esper color white
  BEQ WhiteTxt    ; branch if ^
org $C35902 : WhiteTxt:

; #########################################################################
; Draw Selected Esper Data Info

org $C3599D : dw $B810  ; Reposition EL bonus cursor
org $C359AC : JSR Blue_Bank_Txt
org $C359B1 : JSR ChkEsp ; handle restrictions when choosing esper palette
org $C359CF : JSR DrawEsperMP ; end of drawing esper name
org $C35A3B : JSR Unspent_EL ; add unspent EL draw to esper bonus draw
org $C35A4C : db $0B    ; Remove 2 spaces between label and bonus
org $C35A84 : JMP $7FD9 ; skip drawing spell progress

; Re-formats the esper screen to properly display SP cost
org $C35AFF
  LDA #$FF          ; " "
  STA $2180         ; write ^
  STA $2180         ; write ^
  JSR Learn_Chk
  JMP MPCost
SPCost:
  LDA $F8           ; tens digit
  STA $2180         ; write ^
  LDA $F9           ; ones digit
  STA $2180         ; write ^
  LDA #$FF          ; " "
  STA $2180         ; write ^
  LDA #$92          ; "S"
  STA $2180         ; write ^
  JMP FinishSP      ; jump to second part of routine

org $C35B26 : JSR No_Spell_In_Slot
org $C35BA6 : JSR LoadDescription

; #########################################################################
; Positioned Text for Skills Menu (and Submenus)

org $C35C59 : dw $7A8D : db "Bushido",$00 ; rename "Swdtech"
org $C35CB8 : dw $81B7 : db "Bushido",$00 ; rename "Swdtech"
org $C35CE2
  SPLabel:    dw $47B1 : db "SP ",$00
  LearnLabel: dw $4437 : db "Learn",$00
  SPMax:      dw $47BB : db "/30",$00
              db $00   : db " EL Bonus:    "

; #########################################################################
; Draw Status Menu

; Add another window to draw
org $C35D26 : JSR NewWindow ; create new (middle) window

; Reduce number of status menu labels by one
org $C35D63 : LDY #$000A ; 5 strings

; #########################################################################
; Gogo's Command Select Menu
; BNW Hardcodes Gogo's available commands
; TODO: Convert this to simple data

org $C35DC9
GogoCmdList:
  SEP #$20        ; 8-bit A
  LDA #$00        ; 0
  STA $2180       ; "Fight"
  INC             ; 1
  STA $2180       ; "Item"
  INC             ; 2
  STA $2180       ; "Magic"
  LDA #$05        ; 5
  STA $2180       ; "Steal"
  LDA #$07        ; 7
  STA $2180       ; "Bushido"
  INC             ; 8 
  STA $2180       ; "Throw"
  INC             ; 9
  STA $2180       ; "Tools"
  INC             ; 10
  STA $2180       ; "Blitz"
  INC             ; 11
  STA $2180       ; "Runic"
  INC             ; 12
  STA $2180       ; "Lore"
  INC             ; 13
  STA $2180       ; "Sketch"
  LDA #$0F        ; 15
  STA $2180       ; "Slot"
  INC             ; 16
  STA $2180       ; "Rage"
  LDA #$13        ; 19
  STA $2180       ; "Dance"
  NOP #10
.build_list
  LDX #$9D8A      ; 7E/9D8A
  STX $2181       ; Set WRAM LBs
  LDA #$FF        ; Cmd: Empty
  STA $2180       ; Add to list
  TDC             ; Clear A
  TAX             ; Cmd slot: 1
  TAY             ; Cmd count: 0
.loop
  TDC             ; ...
  PHX             ; Save cmd slot
  LDA $7E9E09,X   ; Available cmd
  STA $2180       ; Add to list
  INY             ; Cmd count +1
  PLX             ; Cmd slot
  INX             ; Cmd slot +1
  CPX #$000E      ; Done 16 x 4?
  BNE .loop       ; Loop if not
  INY             ; Cmd count +1
  TYA             ; Put it in A
  STA $7E9D89     ; Set list size
  BRA .layout
org $C35E6D : .layout

; #########################################################################
; Draw command names based on availability
;
; Rewritten as part of Assassin's "Brushless Sketch" patch to save space
; and add support for "Sketch" disabling based on whether a brush is equipped.

org $C35ED7
CmdListA:
  PHA                ; store command ID
  JSR $3519          ; prepare name drawing
  PLA                ; restore command ID
  BMI CmdListB_blank ; branch if null
  BRA CmdListB_skip  ; else, continue
  NOP
org $C35EE1
CmdListB:
  JSR $612C          ; check blanked commands (Magic/Morph/Leap/etc)
  BMI .blank         ; branch if ^
.skip
  JSR Grey_Shock     ; pick a palette, handle Shock palette, too 
  STA $E2            ; save command number
  ASL                ; x2
  CLC : ADC $E2      ; x3
  ASL                ; x6
  CLC : ADC $E2      ; x7
  TAX                ; index it
  CLC                ; clear carry (indicates non-null cmd)
.init_loop
  LDY #$0007         ; prep loop through command name
.loop     
  BCS .set           ; skip loading letter if null cmd
  LDA $D8CEA0,X      ; else, load next letter
.set
  STA $2180          ; write to WRAM
  INX                ; increment source
  DEY                ; decrement remaining
  BNE .loop          ; loop till done
  STZ $2180          ; write EOL byte
  CLC                ; clear carry
  JMP $7FD9          ; draw string
.blank
  LDA #$FF           ; space character
  SEC                ; set carry (indicates null-cmd)
  BRA .init_loop     ; write 7 spaces
  PHA                ; store command ID ; TODO: Remove unused byte
CmdPalette:
  CMP #$0B           ; "Runic"
  BNE .bushido       ; branch if not ^
.runic
  LDA $11DA          ; right hand properties
  ORA $11DB          ; left hand properties
  BPL .gray          ; branch if no Runic support
  BRA .white         ; display the command lit up
.bushido
  CMP #$07           ; "Bushido"
  BNE .sketch        ; branch if not ^
  LDA $11DA          ; right hand properties
  ORA $11DB          ; left hand properties
  BIT #$02           ; "Bushido Allowed"
  BEQ .gray          ; branch to disable if no ^
  BRA .white         ; else branch to show
.sketch
  CMP #$0D           ; "Sketch"
  BNE .white         ; enable if not ^ (or other previous)
  LDA $11C6          ; right hand equipment slot
  JSL $C2FBFD        ; C: Not a brush
  BCC .white         ; branch if is brush
  LDA $11C7          ; left hand equipment slot
  JSL $C2FBFD        ; C: Not a brush
  BCS .gray          ; branch if ^
.white
  LDA #$20           ; user color palette (white)
  BRA .palette       ; branch to finish
.gray
  LDA #$24           ; gray color
.palette
  STA $29            ; update palette
  PLA                ; restore command ID
  RTS
warnpc $C35F50

; #########################################################################
; Yellow Streak Fix (Gogo's Menu)
; Modified by Status Menu Redesign

org $C35F50 : LDX #$60CA ; nudge mask around Gogo portrait at new coords

; #########################################################################
; Draw Status Screen

; -------------------------------------------------------------------------
; Handle window position and size

org $C35F79
  dd $051C5D4B            ; lower window size/position
  dd $07085BAD            ; command window size/position
  dd $091C588B            ; top window size/position

; -------------------------------------------------------------------------
; Position status menu stat information

org $C35FD5 : LDX #$7C61     ; Vigor position
org $C35FE1 : LDX #$7D61     ; Speed position
org $C35FED : LDX #$7DE1     ; Stamina position
org $C35FF9 : LDX #$7CE1     ; Magic position

; -------------------------------------------------------------------------
; Skip over useless code, create freespace used for Battle Power helper

org $C36002
  BRA Skip       ; skip over unused code, now freespace for helper function
PowHelper:       ; in freespace branched over
  LDX #$300C     ; use addresses $300C and $300D for hand Battle Powers
  STX $E0        ; save in temp variable
  LDX $CE        ; just want bottom half, top half will be ignored
  CLC
  LDA $A0        ; check for Gauntlet, setting Zero Flag accordingly
  NOP
  RTS
Skip:
  JSR $052E      ; [vanilla] unchanged, left for context

; -------------------------------------------------------------------------
; Position status menu stat information
; (Status menu redesign)

org $C36013 : LDX #$7F61     ; Attack position
org $C3601F : LDX #$7FE1     ; Defense position
org $C3602B : LDX #$8861     ; Evade position
org $C36037 : LDX #$7FFF     ; Mag.Def position
org $C36043 : LDX #$887F     ; Mblock position
org $C36049 : LDY #$78D9     ; Actor name position

org $C36055
  JSR $F3BF       ; draw EL label
  JSR ELStuff     ; draw next EL labels

; -------------------------------------------------------------------------
; Update stat text positions and sizes for Status Menu Redesign

org $C36068
  LDX $67         ; Actor's address
  LDA $0011,X     ; Experience LB
  STA $F1         ; Memorize it
  LDA $0012,X     ; Experience MB
  STA $F2         ; Memorize it
  LDA $0013,X     ; Experience HB
  STA $F3         ; Memorize it
  JSR $0582       ; Turn into text
  LDX #$7ADB      ; Text position (* new position)
  JSR $04AC       ; Draw 7 digits (* shorter)
  JSR $60A0       ; Get needed exp
  JSR $0582       ; Turn into text
  LDX #$7B5B      ; Text position (* new position)
  JSR $04AC       ; Draw 7 digits (* shorter)
  STZ $47         ; Ailments: Off
  JSR $11B0       ; Hide ail. icons
  JMP $625B       ; Display status
warnpc $C36096


; -------------------------------------------------------------------------
; Position status menu stat information

org $C36096 : dw $3965       ; Level (makes room for EL)
org $C36098 : dw $39A3       ; HP                  
org $C3609A : dw $39AD       ; Max HP
org $C3609C : dw $39E3       ; MP
org $C3609E : dw $39ED       ; Max MP


; #########################################################################
; Status Screen Commands
; 
; Rewritten as part of Assassin's "Brushless Sketch" patch to make room
; for a helper function. This new helper exposes $C36172 (command upgrades)
; to the C2 menu command routine(s).
;
; Further tweaked by Status Menu Redesign

org $C36102
StatusCmdOpt:
  LDY #$7CF1  ; tilemap ptr (cmd 1)
  JSR $4598
  LDY #$7D71  ; tilemap ptr (cmd 2)
  JSR $459E
  LDY #$7DF1  ; tilemap ptr (cmd 3)
  JSR $45A5
  LDY #$7E71  ; tilemap ptr (cmd 4)
  JSR $45AD
  RTS

%nop($C36128)

Long6172:
  JSR $6172      ; Access to existing relic cmd changes (from C2)
  RTL
warnpc $C3612C

; #########################################################################
; Relic Effects

; -------------------------------------------------------------------------
; Force-enable Shock for escape from Floating Continent
org $C36176 : JSR Shock_Chk
; Replaces Runic with Shock if Leo's Crest is equipped
org $C3619A : db $0B ; Runic
; Commands to upgrade above due to Relics
org $C3619F : db $1B ; Shock

; #########################################################################
; Status Menu Portrait placement (shift upward)

org $C36200 : JSR PortraitPlace


; ##################################################
; Display status effects in Status menu
; Change location of status effects text/icons

org $C3625B
  LDY #$38E7              ; Text position
  LDX #$0C78              ; Icon position

; #########################################################################
; Status Menu Text Data
; Change some stat names, remove ".." before each stat
; Percent symbols (%) removed previously by dn's "No Percents" patch

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
warnpc $C3652D

; TODO: Remove this unused code ASAP
org $C36511 : dw $7C4D : db "Exp to lv. up:",$00 ; status menu exp text

; #########################################################################
; Reset Game Data and Configurations ($C3709B)

org $C370C5 : JSR GaugeOn ; default to Wait Gauge on

; #########################################################################
; Character Lineup
org $C3797D : JSR EL_Party  ; draw EL after LV in party select screen
org $C379E6 : dw $3A75      ; shift LV label to make room for EL display

; #########################################################################
; Draw Item Row (used in item menu and colosseum)

org $C37FD0 : JMP ItemNameFork ; hook for colosseum item row

; #########################################################################
; Load Item Descriptions and Draw Item Count
; BNW - Remove Inventory Count

org $C382FB : db $4C

; #########################################################################
; Item Menu Stat Text Data (Gear)

; -------------------------------------------------------------------------
; Reorder stats

org $C386AA : LDA #$8445    ; Vigor modifier
org $C386C1 : LDA #$8545    ; Speed modifier
org $C386D6 : LDA #$85C5    ; Stamina modifier
org $C386F0 : LDA #$84C5    ; Magic modifier

; #########################################################################
; [fork] Draw Offensive Properties
; Rewritten to always draw "Runic", "2-Hand", "Bushido" but grayed out

org $C38743 : RTS ; skip drawing "Spell Taught" in gear details

org $C38746
OffensiveProps:
  JSR $879C           ; draw Bat.Pwr
  JSR OffensiveHelp   ; draw evasions, attack label, elements
  JSR ItemProperties  ; get item properties
  AND #$80            ; "Allows Runic"
  JSR UpdateTxtColor  ; set palette to grey or white, depending on ^
  LDY #$8E30          ; "Runic" text data address
  JSR DrawTextData    ; draw ^
  JSR ItemProperties  ; get item properties
  AND #$40            ; "Allows 2-Hand"
  JSR UpdateTxtColor  ; set palette to grey or white, depending on ^
  LDY #$8E38          ; "2-Hand" text data address
  JSR DrawTextData    ; draw ^
  JSR ItemProperties  ; get item properties
  AND #$02            ; "Allows Bushido"
  JSR UpdateTxtColor  ; set palette to grey or white, depending on ^
  LDY #$8E26          ; "Bushido" text data address
  JSR DrawTextData    ; draw ^
  RTS
%free($C38777)

; ------------------------------------------------------------------------
; Helper for Summon Descriptions (in freespace)

org $C38777           ; 29 bytes, we'll use 24 >.>
SummonDescription:    ; Load Esper summon description
  LDX #EsperDescPointers
  STX $E7             ; Set ptr loc LBs
  LDX $00
  STX $EB             ; Set text loc LBs
  LDA #$C4            ; Pointer/text bank
  STA $E9             ; Set ptr loc HB
  STA $ED             ; Set text loc HB
  LDA #$10
  TRB $45             ; Description: On
  RTS                 ;   It expects (in a roundabout way) this value to be in the X
                      ;   register in the event a character tries to equip an Esper
                      ;   that doesn't belong to them, because it needs an offset to
                      ;   a region of memory where there will be a large swath of
                      ;   values below #$80 /shrug

%free($C38795)

; ------------------------------------------------------------------------
; Resume equipment properties code
; Modify IDs that do not display battle power

org $C387A3 : CMP #$1C       ; Atma Weapon
org $C387A7 : CMP #$17       ; Omega Weapon
org $C387AB : CMP #$51       ; Dice
org $C387AF : CMP #$52       ; Fixed Dice

; ------------------------------------------------------------------------
; dn's "Shop Hack" patch changes where to write elemental effects
org $C388CE : LDX #$7B65 ; where to write resisted elements
org $C388DA : LDX #$7BE5 ; where to write absorbed elements
org $C388E6 : LDX #$7C65 ; where to write immune elements
org $C388F2 : LDX #$7CE5 ; where to write weak elements

; #########################################################################
; Sustain Item Usage Menu

org $C38B7B
  CMP #$FC        ; check if "Slim Jim" to allow field use (was Green Cherry)
  BEQ Heal        ; branch to regular healing item check if "Slim Jim" ^

org $C38B81
  JMP More_Checks ; hook into extended field item usage validation
  RTS             ; Just in case

; -------------------------------------------------------------------------
; Handle "Snake Oil" usage (was Soft in vanilla)

org $C38BA0
  JSR Heal        ; carry: target needs healing
  BCC Remedy      ; branch to status check if not ^

org $C38BB2 : Remedy:
org $C38BC4 : Heal:

; #########################################################################
; Menu Label Changes (part 1.5)

; -------------------------------------------------------------------------
; dn's "Shop Hack" patch: Text pointers for gear data menu (point to new text)

org $C38D69
  dw EleResist
  dw EleAbsorb
  dw EleImmune
  dw EleWeak

; -------------------------------------------------------------------------
; Stat label text data
; Percent symbols (%) overwritten with spaces by dn's "No Percents" patch
; Stats reordered and names tweaked by Status Menu Redesign

org $C38D77 : dw $842F                  ; Vigor label position
org $C38D7F : dw $85AF                  ; Stamina label position
org $C38D89 : dw $84AF : db "Magic",$00
org $C38D9B : db $FF                    ; replace '%' with ' '
org $C38D9F : db "M.Evade",$00
org $C38DCB : dw $852F                  ; Speed label position
org $C38DD5 : db "Attack",$00
org $C38DE9 : db "M.Def.",$00
org $C38E26 : dw $822F : db "Bushido",$00 ; rename "SwdTech" gear attribute

; #########################################################################
; Equip Menu Tabs Navigation
;
; Modified by dn's "Equip Fix" hack to reduce columns from 4 to 3 and
; remove "Optimum" cursor position
; Cursor positions further modified by Tristan's Unified Equip Menu

org $C38E5F
  db $01          ; wraps horizontally
  db $00          ; initial column
  db $00          ; initial row
  db $03          ; 3 columns
  db $01          ; 1 row

org $C38E64
  dw $0840        ; "Equip" cursor position
  dw $0878        ; "Remove" cursor position
  dw $08B8        ; "Empty" cursor position
  dw $FFFF        ; [now unused]

org $C38E75
  LDY #EqpSlotCoords ; move coord data to support Relics in Equip menu

org $C38E7B       ; Equip gear slots
  db $81          ; Wraps all ways
  db $00          ; Initial column
  db $00          ; Initial row
  db $02          ; 2 column
  db $03          ; 3 rows

; #########################################################################
; Relic Menu Navigation Data - TODO: Can remove this change, since Relic
; menu no longer exists

org $C38ED1
  dw $1028  ; "EQUIP" cursor position
  dw $1088  ; "REMOVE" cursor position

; #########################################################################
; Review Screen Draw Routines ($C38EED)
;
; Modified by dn's "Equip Overview Espers" patch to include equipped esper
; names immediately to the right of the character's name.
;
; Modified by Tristan's "Unified Equip Menu" to remove "Empty" text

org $C38F2B : JSR DrawEsperName
org $C38F45 : JSR DrawEsperName
org $C38F61 : JSR DrawEsperName
org $C38F7D : JSR DrawEsperName
org $C38FB4 : NOP #12 ; remove handling for "Empty" text

; #########################################################################
; Draw Equip Menu
; Largely rewritten by Tristan for the "Unified Equip Menu"
; Some text positions modified by Status Menu Design

org $C39032

DrawEquipMenu:
  JSR DrawEqBoxes   ; Draw boxes
  JSR DrawInfo      ; Draw info; status
  JSR DrawOptions   ; Draw top options
  JSR DescTilemap   ; Build tilemap for description
  JMP $0E6E         ; Upload BG3 A+B

; Draw options in Equip menu
DrawOptions:
  LDA #$20          ; Palette 0
  STA $29           ; Color: User's
  LDX #EqpOptsTxt   ; Text ptrs loc
  LDY #$0006        ; Strings: 3 (reduced from 4 to 3)
  JMP $69BA         ; Draw text

; Draw elements shared by Equip and Relic menus, create portrait
; No longer draws portrait or resets BG2 X-Pos, and draws different boxes
DrawEqBoxes:
  JSR LoadGear      ; Load actor stats
  REP #$20          ; 16-bit A
  LDA #$0100        ; BG1 H-Shift: 256
  STA $7E9BD0       ; Hide gear list
  SEP #$20          ; 8-bit A
  LDA #$01          ; 64x32 at $0000
  STA $2107         ; Set BG1 map loc
  LDA #$42          ; 32x64 at $4000
  STA $2109         ; Set BG3 map loc
  JSR $6A28         ; Clear BG2 map A
  JSR $6A2D         ; Clear BG2 map B
  LDY #StatsBox     ; C3/947F
  JSR $0341         ; Draw stats box A
  LDY #OptsBox      ; C3/9487
  JSR $0341         ; Draw option box
  LDY #MenuBox      ; C3/9487
  JSR $0341         ; Draw option box
  LDY #NameBox      ; C3/9487
  JSR $0341         ; Draw option box
  JSR $0E52         ; Upload windows
  JSR $6A15         ; Clear BG1 map A
  JSR $6A19         ; Clear BG1 map B
  JSR $0E28         ; Upload BG1 A+B
  JSR $0E36         ; Upload BG1 C...
  JSR $6A3C         ; Clear BG3 map A
  JSR $6A41         ; Clear BG3 map B
  JSR $93E5         ; Draw actor name
  LDA #$2C          ; Palette 3
  STA $29           ; Color: Blue
  LDX #$A34D        ; Text ptrs loc
  LDY #$001C        ; Strings: 14
  JSR $69BA         ; Draw Vigor, etc.
  LDX #$A369        ; Text ptrs loc
  LDY #$0008        ; Strings: 4
  JSR $69BA         ; Draw Speed, etc.
  JMP $0E6E         ; Upload BG3 A+B

; Draw actor info in Equip menu, update status based on gear
DrawInfo:
  LDA #$20          ; Palette 0
  STA $29           ; Color: User's
  JSR DoStats       ; Do stats; status
  JSR DrawHands     ; Draw hand names
  JSR DrawHelmet    ; Draw helmet
  JSR DrawArmor     ; Draw armor
  JSR DrawRel1      ; Draw Relic 1
  JMP DrawRel2      ; Draw Relic 2

; Draw current stats in gear menu, update status based on gear
; From $C3913E, almost exactly copied

DoStats:
  JSR LoadGear      ; Load actor stats ; New location
  JSR $93F2         ; Actor's address
  JSR $99E8         ; Set Bat.Pwr mode
  JSR $9207         ; Relocate stats
  PHB               ; Save DB
  LDA #$7E          ; Bank: 7E
  PHA               ; Put on stack
  PLB               ; Set DB to 7E
  JSR $91C4         ; Update status
  LDA $3006         ; Vigor
  JSR $04E0         ; Turn into text
  LDX #$7CB7        ; Text position
  JSR $04C0         ; Draw 3 digits
  LDA $3004         ; Speed
  JSR $04E0         ; Turn into text
  LDX #$7DB7        ; Text position
  JSR $04C0         ; Draw 3 digits
  LDA $3002         ; Stamina
  JSR $04E0         ; Turn into text
  LDX #$7E37        ; Text position
  JSR $04C0         ; Draw 3 digits
  LDA $3000         ; Mag.Pwr
  JSR $04E0         ; Turn into text
  LDX #$7D37        ; Text position
  JSR $04C0         ; Draw 3 digits
  JSR DefineBatPwr  ; Define Bat.Pwr (BNW: Include Gauntlet)
  LDX $F1           ; Load it
  STX $F3           ; Save for $052E
  JSR $052E         ; Turn into text
  LDX #$7EB7        ; Text position
  JSR $0486         ; Draw 3 digits
  LDA $301A         ; Defense
  JSR $04E0         ; Turn into text
  LDX #$7F37        ; Text position
  JSR $04C0         ; Draw 3 digits
  LDA $3008         ; Evade
  JSR $04E0         ; Turn into text
  LDX #$7FB7        ; Text position
  JSR $04C0         ; Draw 3 digits
  LDA $301B         ; Mag.Def
  JSR $04E0         ; Turn into text
  LDX #$8037        ; Text position
  JSR $04C0         ; Draw 3 digits
  LDA $300A         ; MBlock
  JSR $04E0         ; Turn into text
  LDX #$80B7        ; Text position
  JSR $04C0         ; Draw 3 digits
  PLB               ; Restore DB
  RTS

; Cursor positions for Equip menu slot selection
EqpSlotCoords:
  dw $3800          ; R-Hand
  dw $3878          ; L-Hand
  dw $4400          ; Head
  dw $4478          ; Body
  dw $5000          ; Relic 1
  dw $5078          ; Relic 2

; Draw equipped armor in Equip menu
; From $C39443

DrawArmor:
  LDX #!body_pos    ; Tilemap ptr
  JSR $946D         ; Set Y, coords
  LDA #$20          ; Palette 0
  STA $29           ; Color: User's
  LDA $0022,Y       ; Armor
  CMP #$FF          ; Is it empty?
  BEQ .drawbody     ; If so, branch and draw "Body"
  JMP $9479         ; Draw its name
.drawbody
  LDA #$24          ; Palette 1
  STA $29           ; Color: Gray
  LDY #BodyTxt      ; Body string location
DrawTextAlt:
  JMP $02F9         ; Load text into tilemap

; Draw equipped relic 1 in Relic menu
; From $C39451

DrawRel1:
  LDX #!relic1pos   ; Tilemap ptr
  JSR $946D         ; Set Y, coords
  LDA #$20          ; Palette 0
  STA $29           ; Color: User's
  LDA $0023,Y       ; Relic 1
  CMP #$FF          ; Is it empty?
  BEQ .draw         ; If so, branch and draw "Relic"
  JMP $9479         ; Draw its name
.draw
  LDA #$24
  STA $29
  LDY #Relic1Txt
  BRA DrawTextAlt

; Draw equipped relic 2 in Relic menu
; From $C3945F

DrawRel2:
  LDX #!relic2pos   ; Tilemap ptr
  JSR $946D         ; Set Y, coords
  LDA #$20          ; Palette 0
  STA $29           ; Color: User's
  LDA $0024,Y       ; Relic 2
  CMP #$FF          ; Is it empty?
  BEQ .draw         ; If so, branch and draw "Relic"
  JMP $9479         ; Draw its name
.draw
  LDA #$24
  STA $29
  LDY #Relic2Txt
  BRA DrawTextAlt

warnpc $C391C4

; ------------------------------------------------------------------------
; Update status based on gear
;
; Skip removing statuses when gear is equipped.
; Status will be removed at start of battle,
; instead.
org $C391CB : NOP #3 

; ------------------------------------------------------------------------
; Point to new "Load Actor Data" routine [Unified Equip Menu]

org $C3926B : JSR LoadGear      ; Load actor data

; #########################################################################
; Sustain Relic and Sustain Equip Menus

; Reorder stats
org $C3927D : LDX #$7CBF    ; New vigor position
org $C3928F : LDX #$7DBF    ; New speed position
org $C392A1 : LDX #$7E3F    ; New stamina position
org $C392B3 : LDX #$7D3F    ; New magic position



; -------------------------------------------------------------------------
; Hook into new routine to include Gauntlet in Battle Power calculation

org $C3934F : JSR $9382  

; -------------------------------------------------------------------------
; Rewrite "Define New Battle Power" routine to account for Gauntlet
; 32 bytes freed starting at C3/93C9.

org $C39371
  LDX #$11AC      ; use addresses $11AC and $11AD for hand Battle Powers
  STX $E0         ; save in temp variable
  LDX $CD         ; just want bottom half, top half will be ignored
  CLC
  LDA $A1         ; check for Gauntlet, setting Zero Flag accordingly
  JSR General
  STA $F3         ; save 16-bit sum of hands' Battle Powers
  BRA CleanUpPwr  ; do cleanup and return
DefineBatPwr:
  JSR PowHelper   ; do moved code
  JSR General
  STA $F1         ; save 16-bit sum of hands' Battle Powers
CleanUpPwr:
  TDC             ; clear A/B
  SEP #$20        ; 8-bit A
  RTS

General:
  BEQ .skip       ; branch if Gauntlet not present
  SEC             ; set Carry if it is
.skip
  PHB             ; push bank ($00)
  LDA #$7E        ; RAM bank
  PHA             ; add to stack
  PLB             ; set bank to $7E
  LDY #$0001      ; offset to left hand battle power
  PHP             ; store gauntlet flag
  BCS .add        ; skip Genji Glove check if Gauntlet in use
  TXA             ; get value of Variable $CD or $CE, Genji Glove presence
  ORA #$00        ; TODO: Remove unnecessary ORA
  BNE .add        ; branch if Genji Glove
  LDA ($E0)       ; get right hand Battle Power
  BEQ .add        ; branch if zero ^
  TDC             ; zero A/B
  STA ($E0),Y     ; if rh battle power, then zero left hand
.add
  TDC             ; make sure top half of A is clear for addition
  LDA ($E0)       ; right hand battle power
  CLC             ; clear carry
  ADC ($E0),Y     ; sum of two hands' [modified] battle powers
  XBA             ; hi-byte
  ADC #$00        ; add carry if overflow
  XBA             ; now 16-bit A = sum of hands' battle powers
  PLP             ; restore gauntlet flag in carry
  REP #$20        ; 16-bit A
  PHP             ; save carry
  CLC             ; clear carry
  ADC !baseb      ; add base battle power
  PLP             ; restore carry
  BCC .genji      ; branch if not gauntlet
  PHA             ; store A
  LSR             ; A / 2
  CLC             ; clear carry
  ADC $01,S       ; add A
  STA $01,S       ; save result to stack
  PLA             ; A * 1.5
.exit
  PLB             ; restore old Data Bank ($00)
  RTS
.genji
  SEP #$10        ; 8-bit X/Y
  INX : DEX       ; set flags for genji
  REP #$10        ; 16-bit X/Y
  BEQ .exit       ; exit if no genji
  CLC             ; prep add
  ADC !baseb      ; add another base battle power
  PHA             ; store power on stack
  LSR #2          ; power / 4
  STA $E0         ; save quarter power to scratch
  PLA             ; get full power again
  SEC : SBC $E0   ; subtract 25%
  BRA .exit       ; finish up
warnpc $C393E5    ; NOTE Some freespace here, maybe

; #########################################################################
; Draw actor name in Equip or Relic menu
; Modified color and text position for Unified Equip Menu

org $C393E5
  JSR $93F2       ; Actor's address
  LDA #$2C        ; Palette 0
  STA $29         ; Color: Blue
  LDY #$788D      ; Text position

; #########################################################################
; Draw equipped helmet in Equip menu (replaces old Draw Equipped Armaments)
; Moved and modified for Unified Equip Menu
; From $C39435

org $C393FC
DrawHelmet:
  LDX #!head_pos  ; Tilemap ptr
  JSR $946D       ; Set Y, coords
  LDA #$20        ; Palette 0
  STA $29         ; Color: User's
  LDA $0021,Y     ; Helmet
  CMP #$FF        ; Is it empty?
  BEQ .draw       ; If so, branch and draw "Head"
  JMP $9479       ; Draw its name
.draw
  LDA #$24        ; Gray
  STA $29         ; Set palette
  LDY #HeadTxt    ; Load text coords
  JMP DrawTextAlt ; Draw text
warnpc $C3946D

; #########################################################################
; Window layout for Equip and Relic menus
; Updated for Unifed Equip Menu

org $C3947F
StatsBox:  dw $5B4B,$0D1C  ; 30x15 at $5B4B (Stats w/o title)
OptsBox:   dw $584B,$0A1C  ; 30x04 at $588B (Options)
MenuBox:   dw $584B,$011C  ; Menu
NameBox:   dw $584B,$0106  ; Name


; #########################################################################
; Sustain Equip Menu option selection (Equip/Remove/Empty) (Action 36)
;
; Altered by Unified Equip Menu to create space and add descriptions.
; Much of the code is the same, but shifted, and many JSRs are updated.
; Used to start at $C39621
;
; Note that dn's "Y Screen Swap" patch is largely overwritten

; ------------------------------------------------------------------------
; Deprecate unused routine to make room for Action 36 to enter higher up.
org $C3960C : RTS

; ------------------------------------------------------------------------
; New entrypoint for equip menu
; Overwrites $C39614, adds description handling

EqpMenuOpts:
  LDA #$10        ; Description: Off
  TSB $45         ; Set menu flag
  JSR $9E14       ; Queue BG3 upload

                  ; * Mostly unchanged except for (*)
  JSR DrawOptions ; Draw options (* new routine location)
  JSR $8E56       ; Handle D-Pad
  LDA $08         ; No-autofire keys
  BIT #$80        ; Pushing A?
  BEQ .check_b    ; Branch if not
  JSR $0EB2       ; Sound: Click
  BRA .handle     ; Handle selection
.check_b
  LDA $09         ; No-autofire keys
  BIT #$80        ; Pushing B?
  BEQ .check_lr   ; Branch if not
  JSR $0EA9       ; Sound: Cursor
  JSR LoadGear    ; Update field FX (* new routine location)
  LDA #$04        ; C3/1A8A
  STA $27         ; Queue main menu
  STZ $26         ; Next: Fade-out
  RTS
.check_lr
  LDA #$35        ; C3/1BB8
  STA $E0         ; Set init command
  JMP $2022       ; Handle L and R
warnpc $C39664    ; TODO: is $C3964F-$C39664 really unused?

; TODO: Revert this Equip<>Relic swap code, as it is no longer in effect
org $C39648 : JMP EquipSwap : NOP #4

org $C39664
.handle           ; * Fork is at original location, unchanged
  TDC             ; Clear A
  LDA $4B         ; Cursor slot
  ASL A           ; Double it
  TAX             ; Index it
  JMP (OptTbl,X)  ; Handle option

; ------------------------------------------------------------------------
; Jump table equipment options
; Still at $C3966C, modified to remove OPTIMUM option

OptTbl:
  dw DoEquip     ; EQUIP
  dw DoRemove    ; REMOVE
  dw DoEmpty     ; EMPTY
  dw DoEmpty     ; EMPTY (TODO: Remove unused duplicate)

; ------------------------------------------------------------------------
; Update JSR targets
DoEquip:
  JSR YellowTxt   ; Update text colour (Yellow)
  JSR SetEquip    ; Update menu colours (Equip)

; -------------------------------------------------------------------------
; Handle "Optimum" option
; TODO: Can revert this change, claim freespace here ($C39685-$C3968E)
org $C39685 : NOP #3 ; skip optimize routine entirely

; ------------------------------------------------------------------------
; Update JSR targets
org $C3968E
DoRemove:
  JSR YellowTxt   ; Update text colour (Yellow)
  JSR SetRmove    ; Update menu colours (Remove)

org $C3969F
DoEmpty:
  JSR RemoveGear  ; Remove gear
  JSR DrawInfo    ; Redo text, status (* new routine location)
  STZ $4D         ; Cursor: "USE"
  RTS

; ------------------------------------------------------------------------
; Remove option optimized with a loop
; Rewrites $C396A8

RemoveGear:
  JSR $93F2       ; Define Y
  LDX #$0005      ; Loop R-Hand, L-Hand, Head, Body, Relic1, Relic2
RemoveLoop:
.loop
  LDA $001F,Y     ; SRAM equipment location
  JSR $9D5E       ; add to item stock
  LDA #$FF        ; "null"
  STA $001F,Y     ; clear from equipped
  INY             ; next equipment slot
  DEX             ; decrement iterator
  BPL .loop       ; loop till done
  RTS
RemoveEqps:
  JSR $93F2       ; Define Y
  LDX #$0003      ; Loop R-Hand, L-Hand, Head, Body
  BRA RemoveLoop  ; Remove ^
warnpc $C396D2

; -------------------------------------------------------------------------
; General Event Command "Optimize Equipment"
; Rewritten to fix errors when no valid equipment found (assassin)
; LoadGear and RemoveEqps JSRs modified by Unified Equip Menu

org $C396E9
  NOP #3          ; Removes redundant "Get gear FX" routine call
  JSR $96F0       ; [unchanged] Optimum command - fully equips standard equipment
  RTL             ; [unchanged]

; Optimum command
  JSR LoadGear    ; Get gear FX (* new routine position)
  JSR RemoveEqps  ; Remove gear (* new rewritten routine)
  JSR $93F2       ; [unchanged] get character index
  STY $F3         ; [unchanged] store character index
  LDA $11D8       ; [unchanged] relic flags
  AND #$08        ; [unchanged] Check "attack with 2 hands" bit
  BEQ .no_gaunt   ; [unchanged] branch if not set
  NOP #2
  JSR WeaponList  ; generate list of equippable Weapons and Shields.
  JSR $9795       ; [unchanged] generate list of equippable Weapons
  JSR $A150       ; [unchanged] sort list of eligible weapons by Battle Power
  JSR $983F       ; [unchanged] pick best weapon that's compatible with Optimum,
  LDY $F3         ; [unchanged] load character index
  STA $001F,Y     ; [unchanged] store to right hand
  JSR $9D97       ; [unchanged] Remove item from inventory
  BRA .helmet     ; advance to the helmet slot
.no_gaunt
  JSR wpn_common  ; pick the best weapon that's compatible with Optimum
  STA $001F,Y     ; store to right hand
  JSR $9D97       ; remove item from inventory
  LDA $11D8       ; relic flags
  AND #$10        ; "Dual Wield"
  BNE .dual       ; branch if ^
  JSR WeaponList  ; generate list of equippable Weapons and Shields.
  JSR $97D7       ; generate list of equippable Shields
  JSR common      ; sort list of shields by Defense, then pick the best
  STA $0020,Y     ; store to left hand
  JSR $9D97       ; remove item from inventory
  BRA .helmet     ; do the helmet slot now
.dual
  JSR wpn_common  ; pick the best weapon that's compatible with Optimum
  STA $0020,Y     ; store to left hand
  JSR $9D97       ; remove item from inventory
.helmet
  JSR stuff_9B59  ; do early parts of Function C3/9B59
  JSR $9BB2       ; generate list of equippable Helmets
  JSR common      ; sort list of helmets by Defense, then pick the best
  STA $0021,Y     ; store to head
  JSR $9D97       ; remove item from inventory
  JSR stuff_9B59  ; do early parts of Function C3/9B59
  JSR $9BEE       ; generate list of equippable Armors
  JSR common      ; sort list of armors by Defense, then pick the best
  STA $0022,Y     ; store to body
  JMP $9D97       ; remove item from inventory
wpn_common:
  JSR WeaponList  ; generate list of equippable Weapons and Shields.
  JSR $9795       ; generate list of equippable Weapons
common:
  JSR $A150       ; sort list of eligible gear by Battle Power or Defense
  LDY $F3         ; load character index
  JMP CheckEmpty  ; hook, then pick best gear that's compatible with Optimum
                  ; TODO: Just insert CheckEmpty inline here ^
stuff_9B59:
  JSR $9C2A       ; Generate fallback list of 9 FFs, in case none found
  JSR $9C41       ; set equippability word
  LDA #$20        ; color: white
  STA $29         ; set text color to white.  99.5% sure it's pointless here
  RTS
WeaponList:       ; TODO: pointless [?]
  JSR stuff_9B59  ; do early parts of Function C3/9B59
  JMP $9B72       ; generate list of equippable Weapons and Shields.
CheckEmpty:
  LDA $7E9D89     ; A = list size
  BEQ .empty      ; branch if no items ^
  JMP $9819       ; else, pick item
.empty
  JMP $9881       ; jump to finish
  NOP #8

; #########################################################################
; Sustain Equip and Relic Menus (continued)

; -------------------------------------------------------------------------
; TODO: Can be reverted, since Unified Equip Menu renders it moot
org $C398C8 : JMP EquipSubSwap : NOP #4

; ------------------------------------------------------------------------
; Handle manual gear removal (Action 56)
; Description handling added, otherwise mostly unchanged (*)
; (Unified Equip Menu)

org $C398CF
  LDA $09
  BIT #$40        ; Pushing Y?
  BEQ .nodsc      ; Branch if not
  LDA $45         ; Description: On
  EOR #$10        ; Set Menu Flag
  STA $45
.nodsc
  JSR $9E14       ; Queue text upload

  JSR $8E72       ; Handle D-Pad
  JSR LoadDescript; Load description for equipped gear
  LDA $08         ; No-autofire keys
  BIT #$80        ; Pushing A?
  BEQ .check_b    ; Branch if not
  JSR $0EB2       ; Sound: Click
  JSR $93F2       ; Actor's address
  REP #$21        ; 16-bit A; C-
  TYA             ; Move it to A
  SEP #$20        ; 8-bit A
  ADC $4B         ; Add cursor slot
  TAY             ; Index sum
  LDA $001F,Y     ; Item in slot
  JSR $9D5E       ; Put in stock
  LDA #$FF        ; Empty item
  STA $001F,Y     ; Clear gear slot
  JSR DrawInfo    ; Redo text, status (* new routine position)
.check_b
  LDA $09         ; No-autofire keys
  BIT #$80        ; Pushing B?
  BEQ .check_lr   ; Branch if not
  JSR $0EA9       ; Sound: Cursor
  JSR $8E50       ; Load navig data
  JSR $8E59       ; Relocate cursor
  LDA #$36        ; C3/9621
  STA $26         ; Next: Option list
  RTS
.check_lr
  LDA #$7F        ; C3/1BF3
  STA $E0         ; Set init command
  JMP $2022       ; Handle L and R

; ------------------------------------------------------------------------
; Handle gear browsing (Action 57)
; Adds description handling, backs up gear effects, supports
; auto-cursor change respecting current column
; (Unified Equip Menu)

BrowseGear:
  LDA #$10        ; Description: On
  TRB $45         ; Set menu flag
  JSR $9E14       ; Queue text upload
  JSR $9AD3       ; Handle navigation
  JSR $9233       ; Draw stat preview
  JSR $A1D8       ; Load description

  LDA $08         ; No-autofire keys
  BIT #$80        ; Pushing A?
  BEQ .check_b    ; Branch if not
  JSR $9A42       ; On a gray item?
  BCC .fail       ; Fail if so
  JSR $0EB2       ; Sound: Click
  LDA $001F,Y     ; Item to unequip
  CMP #$FF        ; None?
  BEQ .clear      ; Branch if so
  JSR $9D5E       ; Put in stock
.clear
  TDC             ; Clear A
  LDA $4B         ; Gear list slot
  TAX             ; Index it
  LDA $7E9D8A,X   ; Inventory slot
  TAX             ; Index it
  LDA $1869,X     ; Item in slot
  STA $001F,Y     ; Equip on actor
  JSR $9D97       ; Adjust stock
  JSR DrawInfo    ; Redo text, status (* new routine position)
  BRA .exit_list  ; Exit gear list

.check_b
  LDA $09         ; No-autofire keys
  BIT #$80        ; Pushing B?
  BEQ .exit       ; Exit if not
  JSR $0EA9       ; Sound: Cursor

  LDA $F0         ; Get stored Gear Effects [BNW ?]
  STA $11D8       ; Copy to RAM [BNW ?]
.exit_list
  LDA #$10        ; Description: Off
  TSB $45         ; Set menu flag

  JSR $9C87       ; Clear stat preview
  REP #$20        ; 16-bit A
  LDA #$0100      ; BG1 H-Shift: 256
  STA $7E9BD0     ; Hide gear list
  SEP #$20        ; 8-bit A
  LDA #$C1        ; Top cursor: Off
  TRB $46         ; Scrollbar: Off
  JSR $8E6C       ; Load navig data
  LDA $5E         ; Former position (changed from $5F)
  STA $4E         ; Set cursor row
  LDA $5D         ; Former column [?]
  STA $4D         ; Set cursor column [?]
  JSR $8E75       ; Relocate cursor
  JSR $1368       ; Refresh screen (*)
  LDA #$55        ; C3/9884
  STA $26         ; Next: Body parts
.exit
  RTS
.fail
  JSR $0EC0       ; Play buzzer
  JMP $305D       ; Pixelate screen (* remove unnecessary RTS)

; ------------------------------------------------------------------------
; Draw "R-hand" and "L-hand" in Equip menu
; Handle placeholder text for empty slots
; Handle Gauntlet effect coloring
; Moves much code to new locations for space
; (Unified Equip Menu)

DrawHands:
  LDA $11D8       ; Gear effects
  AND #$08        ; Gauntlet?
  BEQ .draw_them  ; Branch if not
  JSR $93F2       ; Define Y
  LDA $001F,Y     ; R-Hand item
  CMP #$FF        ; None?
  BEQ .lyelit     ; Draw L-Hand in yellow
  LDA $0020,Y     ; L-Hand item
  CMP #$FF        ; None?
  BNE .draw_them  ; branch if equipped
.ryelit
  LDA #$28        ; palette: yellow
  STA $29         ; set color ^
  JSR DrawRHand2  ; draw r-hand w/o changing color
  JMP DrawLHand   ; set user color, then draw l-hand
.lyelit
  LDA #$28        ; palette: yellow
  STA $29         ; set color ^
  JSR DrawLHand2  ; draw l-hand w/o changing color
  JMP DrawRHand   ; set user color, then draw r-hand
.draw_them
  JSR DrawRHand   ; Draw R-Hand name/item
  JMP DrawLHand   ; Draw L-Hand name/item
warnpc $C399E8

; TODO: Remove this old palette shift ASAP, which is now handled above
org $C399E2 : LDA #$28 ; Yellow

; #########################################################################
; Support validation for dual-wield, two-handed, katana equips

org $C39A5D : JSR Wpn_Index ; save selected item index in scratch
org $C39A90 : JMP DW_Chk_RH ; handle right hand slot
org $C39ABC : JMP DW_Chk_LH ; handle left hand slot

; #########################################################################
; Compile compatible gear for actor's body part
; Modified in part to include Relics for Unified Equip Menu

org $C39B59
ValidGear:
  JSR $9C2A       ; Init list
  JSR $9C41       ; Define compat
  LDA #$20        ; Palette 0
  STA $29         ; Color: User's
  LDA $4B         ; Body part
  CMP #$02        ; Head?
  BCC ValidHands  ; Branch if LHand or RHand
  BEQ ValidHead   ; Branch if Head
  CMP #$04        ; Relics?
  BCC ValidTorso  ; Branch if Torso
  JMP GetRelics   ; Handle relics
warnpc $C39B72

org $C39B72 : ValidHands: ; Fork: Weapons and shields
org $C39BB2 : ValidHead:  ; Fork: Helmet list
org $C39BEE : ValidTorso: ; Fork: Armor list

; #########################################################################
; Initialize Relic Menu [now freespace]
; Since relic menu no longer exists, we use this space for the new code
; for the Unified Equip Menu 

org $C39E4B

YellowTxt:
  LDA #$28        ; Palette 2
  STA $29         ; Color: Yellow
  RTS             ; ^ For "Equip"

; ------------------------------------------------------------------------
; Handle selection of gear slot to fill (Action 55)
; Largely copied from $C39884

GearSlotSelect:
  LDA $09
  BIT #$40        ; Pushing Y?
  BEQ .nodsc      ; Branch if not
  LDA $45         ; Description: On
  EOR #$10        ; Set Menu Flag
  STA $45
.nodsc
  JSR $9E14       ; Queue text upload
  JSR $8E72       ; Handle D-Pad
  JSR LoadDescript; Load description for equipped gear
  JSR DrawHands   ; Recolor hand names
  LDA $08         ; No-autofire keys
  BIT #$80        ; Pushing A?
  BEQ .check_b    ; Branch if not
.pushing_a
  JSR $0EB2       ; Sound: Click
  LDA $4B         ; Cursor position
  STA $5F         ; Set body slot
  LDA $4E         ; Cursor row
  STA $5E         ; Set cursor row
  LDA $4D         ; Get cursor column
  STA $5D         ; Save cursor column
  LDA $11D8       ; Get gear effects 
  STA $F0         ; And save
  LDA #$57        ; C3/990F
  STA $26         ; Next: Item list
  JSR ValidGear   ; Build item list
  JSR $A150       ; Sort it by power
  JSR $9AEB       ; Cursor & Scrollbar
  LDA #$55        ; Return here if..
  STA $27         ; ..list is empty
  LDA #$10        ; Description: Off
  TSB $45         ; Set menu flag
  JSR $6A15       ; Blank item list
  JSR $1368       ; Refresh screen
  JSR $9CAC       ; Draw item list
  JSR $9233       ; Draw stat preview
  JSR $9E23       ; Queue BG3 upload
  JMP $1368       ; Refresh screen
.check_b
  LDA $09         ; No-autofire keys
  BIT #$80        ; Pushing B?
  BEQ .check_lr   ; Branch if not
  JSR $0EA9       ; Sound: Cursor
  JSR $8E50       ; Load navig data
  JSR $8E59       ; Relocate cursor
  LDA #$10        ; Description: Off
  TSB $45         ; Set menu flag
  JSR $1368       ; Refresh screen
  LDA #$36        ; C3/9621
  STA $26         ; Next: Option list
  RTS
.check_lr
  LDA #$7E        ; C3/1BE5
  STA $E0         ; Set init command
  JMP $2022       ; Handle L and R

; ------------------------------------------------------------------------
; Draw L-Hand and R-Hand name/item

DrawRHand:
  LDA #$20        ; Palette 0
  STA $29         ; Color: User's
DrawRHand2:
  LDX #!rh_coords ; Tilemap ptr
  JSR $946D       ; Set Y, coords
  LDA $001F,Y     ; R-Hand item
  CMP #$FF        ; Is it empty?
  BEQ .draw_rhand ; If so, branch and draw "R-Hand"
  JMP $9479       ; Draw its name
.draw_rhand
  LDA #$24        ; gray palette
  STA $29         ; set ^
  LDY #RHandTxt   ; text pointer
DrawText:
  JMP $02F9       ; draw text
DrawLHand:
  LDA #$20        ; Palette 0
  STA $29         ; Color: User's
DrawLHand2:
  LDX #!lh_coords ; Tilemap ptr
  JSR $946D       ; Set Y, coords
  LDA $0020,Y     ; L-Hand item
  CMP #$FF        ; Is it empty?
  BEQ .draw_lhand ; If so, branch and draw "Head"
  JMP $9479       ; Draw its name
.draw_lhand
  LDA #$24        ; gray palette
  STA $29         ; set ^
yllhem:
  LDY #LHandTxt   ; text pointer
  BRA DrawText    ; draw text ^

; ------------------------------------------------------------------------
; Load member's stats and properties with gear
; Copied exactly from $C39110

LoadGear:
  TDC             ; Clear A
  LDA $28         ; Member slot
  TAX             ; Index it
  LDA $69,X       ; Actor
  JSL $C20006     ; Load data
  RTS

; ------------------------------------------------------------------------
; Invoke Party Overview Menu

ReviewMenu:
  JSR $0EB2       ; Sound: Click
  STZ $26         ; Next: Fade-out
  LDA #$38        ; C3/1AD6
  STA $27         ; Queue party overview
  RTS

; ------------------------------------------------------------------------
; Replacement positioned text for main menu

ReviewTxt:  dw $7AB9 : db "Review",$00

; ------------------------------------------------------------------------
; Compile compatible relics
; Lifted largely from $C3A051

GetRelics:
  JSR $9C2A       ; Init list
  JSR $9C41       ; Define compat
  LDA #$20        ; Palette 0
  STA $29         ; Color: User's
  LDX $00         ; Clear X...
  TXY             ; Item slot: 1
.slot_loop
  TDC             ; Clear A
  LDA $1869,Y     ; Item in slot
  CMP #$FF        ; None?
  BEQ .next       ; Skip if so
  JSR $8321       ; Compute index
  LDX $2134       ; Load it
  LDA $D85000,X   ; Properties
  AND #$07        ; Get class
  CMP #$05        ; Relic?
  BNE .next       ; Skip if not
  REP #$20        ; 16-bit A
  LDA $D85001,X   ; Compatibility
  BIT $E7         ; Actor can use?
  BEQ .next       ; Skip if not
  SEP #$20        ; 8-bit A
  TYA             ; Item slot
  STA $2180       ; Add to list
  INC $E0         ; List size +1
.next
  SEP #$20        ; 8-bit A
  INY             ; Item slot +1
  CPY #$0100      ; Done all 256?
  BNE .slot_loop  ; Loop if not
  LDA $E0         ; List size
  STA $7E9D89     ; Save to list
  RTS

; ------------------------------------------------------------------------
; Load item description for equipped relic (unused)

LoadDescript:
  JSR $8308      ; Set desc ptrs
  JSR $93F2      ; Define Y (Character SRAM block)
  REP #$20       ; 16-bit A
  TYA            ; Character in A
  ADC $4B        ; Add slot index
  TAY            ; And return to Y
  SEP #$20       ; 8-bit A
  TDC
  LDA $001F,Y
C3A1D5:
  JMP $5738      ; Load description

; ------------------------------------------------------------------------
; Highlight active "Equip"/"Remove", gray others
; Moved and modified from $C3964F and $C39656

SetEquip:
  LDY #EquipTxt   ; text pointer
  JSR $02F9       ; draw text
  LDA #$24        ; gray palette
  STA $29         ; set ^
  LDY #RemoveTxt  ; text pointer
  JSR $02F9       ; draw text
  BRA UnsetEmpty  ; gray out "empty"

SetRmove:
  LDY #RemoveTxt  ; text pointer
  JSR $02F9       ; draw text
  LDA #$24        ; gray palette
  STA $29         ; set ^
  LDY #EquipTxt   ; text pointer
  JSR $02F9       ; draw text

UnsetEmpty:
  LDY #EmptyTxt   ; text pointer
  JMP $02F9       ; draw text
warnpc $C3A051

; -------------------------------------------------------------------------
; TODO: Can be reverted ASAP, since Unified Equip Menu renders it moot
org $C3A047 : JSR RelicSwap
org $C3A146 : JSR RelicSwap

; #########################################################################
; Relic description handling (now freespace)
; Unified Equip Menu removes Relic Menu, so reuses this space

org $C3A1C3
InitEqpHelp:
  JSR $8E50      ; Load navig data
  JSR $8E59      ; Relocate cursor
  JMP $07B0      ; Queue cursor OAM
warnpc $C3A1D8

; #########################################################################
; Equip and Relic Menu Text Data
; First updated by removal of Optimize option, then overwritten by
; Unified Equip Menu.

org $C3A2A6
EqpOptsTxt:
  dw EquipTxt     ; EQUIP
  dw RemoveTxt    ; RMOVE
  dw EmptyTxt     ; EMPTY
  dw HeadTxt      ; Head ; TODO: Pointer unused
  dw BodyTxt      ; Body ; TODO: Pointer unused
  dw Relic1Txt    ; Relic 1 ; TODO: Pointer unused
  dw Relic2Txt    ; Relic 2 ; TODO: Pointer unused

; Positioned text for Equip and Relic menus
RHandTxt:   dw !rh_coords : db " R-hand      ",$00
LHandTxt:   dw !lh_coords : db " L-hand      ",$00
HeadTxt:    dw !head_pos  : db " Head        ",$00
BodyTxt:    dw !body_pos  : db " Body        ",$00
Relic1Txt:  dw !relic1pos : db " Relic       ",$00
Relic2Txt:  dw !relic2pos : db " Relic       ",$00

; Positioned text for options in Equip menu
EquipTxt:  dw $789D : db "EQUIP",$00
RemoveTxt: dw $78AB : db "REMOVE",$00
EmptyTxt:  dw $78BB : db "EMPTY",$00

; TODO: Freespace here [?]
warnpc $C3A34D

; TODO: Remove this unused code ASAP. This is freespace now (see above)
org $C3A32D : db "EMPTY",$00
org $C3A33C : dw $7917 : db "EQUIP",$00 : dw $792F : db "REMOVE",$00

; #########################################################################
; Menu Label Changes (part 2)

; -------------------------------------------------------------------------
; Percent symbols (%) overwritten with spaces by dn's "No Percents" patch
; Stats renamed and reordered as part of Status Menu Redesign

org $C3A371 : dw $7CA9                  ; Vigor label position
org $C3A379 : dw $7E29                  ; Stamina label position
org $C3A383 : dw $7D29 : db "Magic",$00
org $C3A395 : db $FF                    ; replace '%' with ' '
org $C3A399 : db "M.Evade",$00
org $C3A3C5 : dw $7DA9                  ; Speed label position
org $C3A3CF : db "Attack",$00
org $C3A3E3 : db "M.Def.",$00

; #########################################################################
; Button Settings

; Fixes vanilla bug where the Select button was getting mapped to the R button
org $C3A5D7 : LDY #$0756

; #########################################################################
; Build description tilemap for Relic menu
;
; Now used for equip menu, as relic menu no longer exists
; Some start/end coordinates are modified for Unified Equip Menu

org $C3A6AB
DescTilemap:
  LDX #$7849      ; Base: 7E/7849
  STX $EB         ; Set map ptr LBs
  LDA #$7E        ; Bank: 7E
  STA $ED         ; Set ptr HB
  LDY #$013C      ; Ends at 30,7
  STY $E7         ; Set row's limit
  LDY #$0104      ; Starts at 3,7
  LDX #$3500      ; Tile 256, pal 5
  STX $E0         ; Priority enabled
  JSR $A783       ; Do line 1, row 1
  LDY #$017C      ; Ends at 30,8
  STY $E7         ; Set row's limit
  LDY #$0144      ; Starts at 3,8
  LDX #$3501      ; Tile 257, pal 5
  STX $E0         ; Priority enabled
  JSR $A783       ; Do line 1, row 2
  LDY #$01BC      ; Ends at 30,9
  STY $E7         ; Set row's limit
  LDY #$0184      ; Starts at 3,9
  LDX #$3538      ; Tile 312, pal 5
  STX $E0         ; Priority enabled
  JSR $A783       ; Do line 2, row 1
  LDY #$01FC      ; Ends at 30,10
  STY $E7         ; Set row's limit
  LDY #$01C4      ; Starts at 3,10
  LDX #$3539      ; Tile 313, pal 5
  STX $E0         ; Priority enabled
  JMP $A783       ; Do line 2, row 2

; #########################################################################
; Sustain Final Battle Lineup Menu (74)
;
; Modify existing line-up code to allow only 4 selections,
; and add a hook to shuffle the remaining characters when
; the player presses "Start" or selects "End"

org $C3AA8F
  JSR MaybeAdd        ; add chosen character if not at max
  LDA $4A             ; (vanilla code)
  CMP #$04            ; go to "End" after selecting 4

org $C3AA9C
  JSR ShuffleList     ; randomize remaining lineup order

; #########################################################################
; Draw Final Battle Lineup Menu

org $C3AC33
  LDX #$0004          ; limit user selected list to 4

; -------------------------------------------------------------------------
; Change lineup menu heading

org $C3AC98
  dw $391D : db "Select party",$00

; #########################################################################
; Sustain Main Shop Menu

; Modifies "buy item" list handling to update full details ("Shop Hack")
org $C3B4BD
  JSR BuyItemDetails
  RTS
DrawItemNameNMI:
  JSR $1368        ; refresh screen (NMI)
  JSR $7FD9        ; draw item name
  RTS
%free($C3B4E6)

; #########################################################################
; Initialize Main Shop Menu
;
; "Shop Hack" - Insert hooks to draw gear details windows and labels and
; handle hiding the details until required.

org $C3B8C4
  JSR ShopClearBG  ; clear BG maps and draw detail windows
  NOP #6

org $C3B95A
; TODO Don't know why this is rewritten to free up 6 (unused) bytes
  JSR ClearBG3     ; clear background 3 maps
  JSR $BFD3        ; Draw title
  LDY #$C338       ; Text pointer
  JSR $02F9        ; Draw "GP"
  JSR $C2F2        ; Color: User's
  LDY $1860        ; Gold LBs
  STY $F1          ; Memorize it
  LDA $1862        ; Gold HB
  STA $F3          ; Memorize it
  JSR $0582        ; Turn into text
  LDX #$7A33       ; Text position
  JSR $04AC        ; Draw GP total
  RTS
warnpc $C3B986

org $C3B989 : LDY #HelpText
org $C3BABA : NOP #3 ; skip drawing "Power" info on buy order menu
org $C3BAC9 : JSR DrawItemNameNMI ; refresh screen before name draw
org $C3C037 : db $2F,$06,$00      ; change text shifting for shop "Shop Hack"

; #########################################################################
; Shop Menu equippability UI

org $C3C29C : BRA $3F ; Never show equipped/up/down/equal icons

; #########################################################################
; Draw "Owned" and "Equipped" window
;
; dn's "Shop Hack" interrupts drawing "Owned and "Equipped" window

org $C3C2E1 : JSR DrawDetailsLabels

; #########################################################################
; Positioned Text for Shop Menu

org $C3C357 : dw $7B8F : db "Attack",$00

; #########################################################################
; Freespace Helpers

; Restricts espers to be equippable only by certain characters set in the
; tables at the bottom.
org $C3F091

StChr:
  TAX           ; index slot
  LDA $69,X     ; character ID in slot
  STA $A3       ; save in scratch RAM
  RTS

; Checks if a character can use an esper before checking if someone else
; has it equipped.

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
  LDA.l EsperData,X ; get equippability byte for esper/character pair
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
  JSR ChkEq         ; can equip; check for equip conflict with another character
  STX $FD           ; keep track of who has the current esper equipped, if anyone
  PHA
  LDA $29
  STA $FC           ; keep track of the esper palette
  PLA
  RTS
+ LDA #$28          ; cannot equip; gray text
  STA $FC           ; keep track of the esper palette
  JMP SetTxtColor   ; return

; Handle error messages in the case of trying to equip a grey esper.
; This prints out the name of the person currently using the esper you're trying to
; equip, which was originally the only thing stopping someone from equipping a certain
; esper. We need to change this, as the name will be blank if the character simply
; can't equip it.
Uneq:
  LDA $FB           ; Is esper equippable?
  BPL +               
  LDA $1602,X       ; Character's name; displaced from calling function
  JMP $55B5         ; If esper is equippable, go back and display who has it equipped
+ LDX $00           ; Else, print "Can't Equip!" error message
- LDA.l NoEqTxt,X
  STA $2180         ; Print the current letter.
  BEQ .exit         ; If the letter written was null ($00), exit.
  INX               ; Go to the next letter.
  BRA -
.exit
  JMP $7FD9

NoEqTxt:
  db "Can't equip!",$00,$00,$00 ; TODO: Remove unneeded 2x $00 padding here

; Character esper data table. See below for specifics.
EsperData:
  db $C0,$84,$88,$04 ; Terra
  db $03,$00,$02,$04 ; Locke
  db $80,$40,$02,$00 ; Cyan
  db $00,$00,$10,$01 ; Shadow
  db $08,$02,$C0,$00 ; Edgar
  db $10,$01,$40,$00 ; Sabin
  db $0D,$40,$31,$00 ; Celes
  db $04,$08,$0C,$00 ; Strago
  db $02,$20,$04,$02 ; Relm
  db $20,$00,$20,$02 ; Setzer
  db $70,$02,$00,$00 ; Mog
  db $00,$01,$00,$01 ; Gau
  db $00,$00,$00,$00 ; Gogo
  db $00,$00,$00,$00 ; Umaro
  db $00,$00,$00,$00 ; Slot 15
  db $00,$00,$00,$00 ; Slot 16

; Byte 1        Byte 2         Byte 3         Byte 4
; $01: Ramuh    $01: Stray     $01: Alexandr  $01: Fenrir
; $02: Ifrit    $02: Palidor   $02: Kirin     $02: Starlet
; $04: Shiva    $04: Tritoch   $04: Zoneseek  $04: Phoenix
; $08: Siren    $08: Odin      $08: Carbunkle $08: N/A
; $10: Terrato  $10: Raiden    $10: Phantom   $10: N/A
; $20: Shoat    $20: Bahamut   $20: Seraph    $20: N/A
; $40: Maduin   $40: Crusader  $40: Golem     $40: N/A
; $80: Bismark  $80: Ragnarok  $80: Unicorn   $80: N/A

; ------------------------------------------------------------------------
; Helpers for Dual-Wield and Two-Handed equip restrictions

org $C3F137
Wpn_Index:
  LDA $1869,X         ; item in equipment list slot
  STA $A3             ; store item ID
  RTS
DW_Chk_RH:
  LDA $0020,Y         ; left hand weapon ID
  BRA Item_Chk        ; branch
DW_Chk_LH:
  LDA $001E,Y         ; right hand weapon ID
Item_Chk:
  PHA                 ; store lh/rh weapon ID
  LDA $A3             ; equipment list item ID
  CMP #$5A            ; in "weapon" range?
  PLA                 ; restore lh/rh weapon ID
  BCS .allow          ; branch if item not a weapon (allow)
  LDA $D8500C,X       ; lh/rh weapon properties (special byte 3)
  AND #$18            ; isolate "Genji Glove" and "Gauntlet"
  CMP #$08            ; check if only "Gauntlet" (eg. spear)
  BEQ .exit           ; branch if ^ (disallow all off-hand weapons)
  CMP #$10            ; check if only "Genji Glove" (eg. claw)
  BEQ .spear_chk      ; branch if ^
  JSR GetItemOffset   ; get selected weapon flags
  CMP #$10            ; check if only "Genji Glove" (eg. claw)
  BEQ .allow          ; branch to allow if ^
.exit
  CLC                 ; clear carry (=unequippable)
  RTS
.spear_chk
  JSR GetItemOffset   ; get selected weapon flags
  CMP #$08            ; check if only "Gauntlet" (eg. spear)
  BEQ .exit           ; branch to disallow if ^
.allow
  SEC                 ; set carry (=equippable)
  RTS
GetItemOffset:
  LDA $A3             ; selected weapon ID
  JSR $8321           ; get item data offset (x30)
  LDX $2134           ; load offset into X
  LDA $D8500C,X       ; selected weapon properties (special byte 3)
  AND #$18            ; isolate "Genji Glove" and "Gauntlet"
  RTS

; ------------------------------------------------------------------------
; Helpers for Shock Command

org $C3F17C
Shock_Chk:
  LDA $1E9C             ; event byte (0E0 - 0E7) - Unused bits
  BIT #$10              ; bit 0E4 - "FC Escape Sequence"
  BEQ .end              ; exit if clear ^
  LDA #$10              ; "Runic -> Shock"
  TSB $11D6             ; set relic effect ^
.end
  LDA $11D6             ; [displaced] get relic effects
  RTS
  
Grey_Shock:
  PHA                   ; store command ID
  CMP #$1B              ; "Shock"
  BNE .next             ; branch if not ^
  JMP CmdPalette_runic  ; else, use Runic disable code
.next
  JMP CmdPalette        ; check Runic

; ------------------------------------------------------------------------
; Helper for field item usage target validation
; TODO: Sleeping Bag handling should be removed altogether
; TODO: May be able to inline this helper once sleeping bag is skipped

org $C3F197
More_Checks:
  BEQ .sleeping_bag   ; branch if was sleeping bag
  CMP #$FB            ; "Red Bull" item ID
  BEQ .red_bull       ; branch if ^
  JMP $8BD0           ; else return with clear carry
.sleeping_bag
  JMP $8BD2           ; jump to sleeping bag handler [vanilla]
.red_bull
  JMP Heal            ; jump to check if target needs healing

; ------------------------------------------------------------------------
; Helpers for nATB freezing time during animations

org $C3F1A6
MagicFunction1:
  LDA ($76)        ; [displaced]
  CMP #$FF         ; "null" EOL
  BEQ .exit        ; exit if ^
  INC $3A8F        ; else, freeze time
.exit
  RTL
MagicFunction2:
  DEC $3A8F        ; allow time to progress
  REP #$20         ; [displaced]
  LDA $76          ; [displaced]
  RTL

; ------------------------------------------------------------------------
; Colosseum Item Row drawing helpers
; Include prize item on line with item row

org $C3F1B8
ItemNameFork:
  LDA $26                 ; current system op
  CMP #$71                ; "Init Colosseum Item Selection"
  BEQ .colosseum_menu     ; branch if ^
  CMP #$72                ; "Sustain Colosseum Item Selection"
  BEQ .colosseum_menu     ; branch if ^
  JSR $80B9               ; else, do regular "Item Menu" rows
  JSR $7FD9               ; display text
  JMP $7FE6               ; display item type
.colosseum_menu
  JSR colosseum_setup     ; setup colosseum variables
  JSR string_init         ; init the string
  JSR string_bet          ; display bet item
  JSR string_display      ; display the string
  JSR position_advance_1A ; advance position for next display
  JSR string_init         ; init the string
  JSR string_delimiter    ; dislay delimiter
  JSR string_display      ; display the string
  JSR position_advance_02 ; advance position for next display
  JSR string_init         ; init the string
  JSR string_reward       ; display reward item
  JSR string_display      ; display the string
  JSR position_advance_1A ; advance position for next display
  RTS

colosseum_setup:
  TDC                     ; zero A/B
  LDA $E5                 ; row index in menu
  TAY                     ; index it
  LDA $1869,Y             ; item ID in slot
  STA $0205               ; save item to bet
  JSR $B22C               ; setup Colosseum variables
  RTS

string_init:
  LDX #$9E8B              ; start of text in WRAM buffer
  STX $2181               ; set WRAM destination
  RTS

string_display:
  JSR $7FD9               ; draw string [TODO: remove needless wrapper]
  RTS

string_fill:
  LDX #$000D              ; length of item name
.loop
  STA $2180               ; write fill character
  DEX                     ; decrement iterator
  BNE .loop               ; loop till all written
  STZ $2180               ; set EOL
  RTS

position_advance_02:
  LDX #$0002              ; advance $02 spaces
  BRA position_advance
position_advance_1A:
  LDX #$001A              ; advance $1A spaces
position_advance:
  REP #$20                ; 16-bit A
  TXA                     ; tiles to advance
  CLC                     ; clear carry
  ADC $7E9E89             ; add to text tilemap position
  STA $7E9E89             ; set new text tilemap position
  SEP #$20                ; 8-bit A
  RTS

string_reward:
  LDA $0209               ; mask flag
  BNE .case_mask          ; branch if hidden prize
  LDA $0205               ; bet item ID
  CMP #$FF                ; null?
  BEQ .case_empty         ; branch if empty item
.case_default
  LDA $0207               ; reward item
  JSR $C068               ; load item name [TODO JMP]
  RTS
.case_mask
  LDA #$BF                ; '?' character
  JSR string_fill         ; fill item name with '????'
  RTS
.case_empty
  LDA #$FF                ; ' ' character
  JSR string_fill         ; fill item name with '    '
  RTS

string_delimiter:
  LDA $0205               ; bet item ID
  CMP #$FF                ; null?
  BEQ .case_empty         ; branch if ^
.case_default
  LDA #$D5                ; '>' character (right-facing arrow)
  BRA .set_char           ; branch and write ^
.case_empty
  LDA #$FF                ; ' ' character
.set_char
  STA $2180               ; write chosen delimiter
  STZ $2180               ; end of string
  RTS

string_bet:
  LDA $0205               ; item ID to bet
  CMP #$FF                ; null?
  BEQ .case_empty         ; branch if ^
.case_default
  LDA $0205               ; item ID to bet [TODO: Redundant]
  JSR $C068               ; load item name [TODO: JMP]
  RTS
.case_empty
  LDA #$FF                ; space character
  JSR string_fill         ; fill item name with spaces
  RTS    

; ------------------------------------------------------------------------
; EL/EP/Spell bank text data and helpers
; Many new label and text positions and tiles
; Updated by Status Menu Redesign

org $C3F277
EPUpTxt:
  dw $7B6B : db "Next EL",$00  ; Next EL label
             db ". up:",$00    ; TODO: Remove this fragment ASAP
EPUpClr:
  dw $7B6B : db "       ",$00  ; Next EL label clear (blanks for Gogo)
             db "     ",$00    ; TODO: Remove this fragment ASAP
EPClear:
  dw $7B7B : db "     ",$00    ;  5 blanks for Gogo+ EP

; TODO: Lots of duplicated code here
; Many "EL" text positions, plus extra $FF buffer for indexing purposes
  dw $39AB : db "EL",$00,$FF,$FF,$FF
  dw $3B2B : db "EL",$00,$FF,$FF,$FF
  dw $3CAB : db "EL",$00,$FF,$FF,$FF
  dw $3E2B : db "EL",$00,$FF,$FF,$FF
  dw $423B : db "EL",$00,$FF,$FF,$FF
  dw $396B : db "EL",$00,$FF,$FF,$FF
  dw $3A7B : db "EL",$00,$FF,$FF,$FF

; TODO: Lots of duplicated code here
; Many "EL" text positions, but with spaces instead, to overwrite
  dw $39AB : db "     ",$00
  dw $3B2B : db "     ",$00
  dw $3CAB : db "     ",$00
  dw $3E2B : db "     ",$00
  dw $423B : db "     ",$00
  dw $396B : db "     ",$00
  dw $3A7B : db "     ",$00
UnspentTxt:
  db "Unspent EL:",$00

; TODO: This label no longer used
Calc_EP_Status:     ; ($C3F31B)
  LDA $1E8A         ; event byte
  AND #$08          ; "met Ramuh"
  BEQ .no_ep        ; branch if not ^
  LDX $67           ; character data offset
  LDA $0000,X       ; character ID
  CMP #$0C          ; Gogo or above
  BCC .yes_ep       ; branch if not ^
.no_ep
  LDY #EPClear      ; pointer for spaces to blank out EP value
  JSR $02F9         ; draw ^
  LDY #EPUpClr      ; pointer for spaces to blank out "EP to lv. up"
  JSR ClearEPLabel  ; draw ^
  CLC               ; clear carry (hide EP needed)
  RTS
.yes_ep
  PHA               ; store character ID
  LDA #$2C          ; color: gray-blue
  STA $29           ; set text palette
  LDY #EPUpTxt      ; pointer for "EP to lv. up" text display
  JSR DrawEPLabel   ; draw ^
  TDC               ; zero A/B
  LDA #$20          ; color: white
  STA $29           ; set text palette
  PLA               ; restore character ID
  TAY               ; index it
  LDA !EL,Y         ; character's esper level
  CMP #$19          ; at max (25)
  BNE .needed_ep    ; branch if not ^
  SEC               ; set carry (show EP needed)
  JMP $60C3         ; display zero and exit
.needed_ep
  ASL               ; EL x2
  TAX               ; index to EP lookup
  TYA               ; character ID
  ASL               ; x2
  TAY               ; index it
  REP #$30          ; 16-bit A, X/Y
  LDA !EP,Y         ; character's total EP
  STA $F1           ; store ^
  LDA EP_Chart,X    ; EP needed for next level
  SEC               ; set carry
  SBC $F1           ; EP needed - total EP
  STA $F3           ; store ^ (* modified by Status Menu Redesign)
  SEP #$20          ; 8-bit A
  SEC               ; set carry (show EP needed)
  RTS

Esp_Lvl:
  JSR $04B6         ; [displaced] draw two digits
  JSR Ramuh_Chk     ; check if optained espers yet
  BEQ .exit         ; exit if not ^
  JSR Char_Chk      ; check if Gogo or above
  BCS .exit         ; exit if ^
  TAY               ; index character ID
  LDA !EL,Y         ; character's esper level
  JSR $04E0         ; turn into digit tiles
  REP #$20          ; 16-bit A
  LDA [$EF]         ; tilemap position for level display
  CLC               ; clear carry
  ADC #$000C        ; move X position for esper level display
  TAX               ; index it
  SEP #$20          ; 8-bit A
  JMP $04B6         ; write esper level to screen
.exit
  RTS

Ramuh_Chk:
  TDC               ; zero A/B
  LDA $1E8A         ; event byte
  AND #$08          ; "met Ramuh"
  RTS

Char_Chk:
  LDX $67           ; character data offset
  TDC               ; zero A/B
  LDA $0000,X       ; character ID
  CMP #$0C          ; carry: Gogo or higher
  RTS

EL_Main_1:
  LDA #$00          ; slot 1 offset for "EL" label in main menu
  PHA               ; store ^
  BRA Write_Text    ; draw "EL" label

EL_Main_2:
  LDA #$08          ; slot 2 offset for "EL" label in main menu
  PHA               ; store ^
  BRA Write_Text    ; draw "EL" label

EL_Main_3:
  LDA #$10          ; slot 3 offset for "EL" label in main menu
  PHA               ; store ^
  BRA Write_Text    ; draw "EL" label

EL_Main_4:
  LDA #$18          ; slot 4 offset for "EL" label in main menu
  PHA               ; store ^
  BRA Write_Text    ; draw "EL" label

EL_Skill:
  LDA #$24          ; color: blue
  STA $29           ; set text palette
  LDA #$20          ; offset for "EL" label in skills menu
  PHA               ; store ^
  BRA Stat_Skill_Ent ; draw "EL" label

; TODO: This routine label no longer used
EL_Status:
  LDA #$24          ; color: blue
  STA $29           ; set text palette
  LDA #$28          ; offset for "EL" label in status menu
  PHA               ; store ^
  BRA Stat_Skill_Ent ; draw "EL" label

EL_Party:
  LDA #$30          ; offset for EL label in party lineup menu
  PHA               ; store ^
Write_Text:
  JSR $69BA         ; [displaced] draw multiple strings

Stat_Skill_Ent:
  JSR Ramuh_Chk     ; obtained espers
  BEQ No_Ramuh      ; branch if not ^
  JSR Char_Chk      ; Gogo check
  PLA               ; restore text offset
  PHP               ; store flags
  REP #$20          ; 16-bit A
  BCS Gogo          ; branch if Gogo or higher
  ADC #$F29F        ; else, add "EL" text location
  BRA Write_EL      ; branch to write ^

No_Ramuh:
  PLA               ; restore text offset
  PHP               ; store flags
  REP #$20          ; 16-bit A

Gogo:
  CLC               ; clear carry
  ADC #$F2D7        ; add black spaces text location

Write_EL:
  TAY               ; index text source
  PLP               ; restore flags
  JMP $02F9         ; draw source text

; Adds "Unspent EL" display under the esper bonuses
Unspent_EL:
  LDA #$24          ; color: blue
  STA $29           ; set text palette
  LDY #$4791        ; tilemap position to write to
  JSR $3519         ; initialize WRAM buffer with ^
  LDX $00           ; zero X
.write_uel
  LDA.l UnspentTxt,X ; get "Unspent EL:" tile
  BEQ .finish       ; break if EOL
  STA $2180         ; else, write to WRAM
  INX               ; next tile index
  BRA .write_uel    ; loop till EOL ($00)
.finish
  STZ $2180         ; write EOL
  JSR $7FD9         ; draw string from WRAM buffer
  LDA #$20          ; color: white
  STA $29           ; set palette
  JSR Char_Chk      ; current character's ID
  TAY               ; index it
  LDA !EL_bank,Y    ; available ELs for character to spend
  JSR $04E0         ; turn into digit tiles
  LDY #$47A9        ; tilemap position to write to
  JSR $3519         ; initialize WRAM buffer with ^
  LDA $F8           ; tens digit of ELs
  STA $2180         ; write ^
  LDA $F9           ; ones digit of ELs
  STA $2180         ; write ^
  STZ $2180         ; write EOL
  JSR $7FD9         ; draw string from WRAM buffer
  LDY #$470F        ; next tilemap position (shifted left 2 spaces)
  RTS

; ---------------------------------------------------------
; Esper Equip Bonus Drawing helper
; Modified further by Unified Equip Menu (LoadGear routine)

org $C3F43B
DrawEsperHook:
  JSR LoadGear      ; Recalculate numbers (* new routine position)
  JSR $4EED         ; Properly update display
  JMP $4F08         ; draw esper name [?]

; ---------------------------------------------------------
; Handle in-battle gauge mode toggle via Select button
; Modifed/Rewritten to convert Config option to "Show Delay"

org $C3F444
SwapGauge:
  STZ $2021         ; default to flag "off"
  LDA $0B           ; semi-auto keys
  ASL #2            ; shift "Select" to $80
  BMI .exit         ; branch if ^
  DEC $2021         ; else set flag "on" ($FF)
.exit
  RTL
GaugeLabel:
  dw $3B8F : db "Show Delay",$00
GaugeOn:
  LDA #$80          ; 'Show Delay' flag
  STA $1D4E         ; init config option
  RTS
warnpc $C3F46A

; TODO: Remove this unused code snippet
  db $05
.skip2
  LDA #$FF
  STA $2021
.exit2
  RTL
; TODO: Remove code snippet above

; ---------------------------------------------------------
; Support more colors for drawing esper names

org $C3F480
DrawEsperName:
  LDA #$24          ; "blue" palette
  STA $29           ; set palette color
  PHY               ; store tile position
  JSR $34CF         ; draw character name
  LDA #$34          ; "pink" unset palette (RAM noise)
  STA $29           ; set palette color
  REP #$20          ; 16-bit A
  PLA               ; get tile position
  CLC               ; prepare add
  ADC #$0020        ; advance 16 spaces
  TAY               ; store new tile position
  LDA #$03BF        ; "yellow" color
  STA $7E30EF       ; text color for unused palette
  TDC               ; A = 0000 "black"
  STA $7E30EB       ; border color for unused palette
  SEP #$20          ; 8-bit A
  JSR $34E6         ; draw esper name 
  LDA #$20          ; "white" palette
  STA $29           ; set palette color
  RTS
%free($C3F4B1)

; Duplicate Unused ==========================================
; TODO: This "dup" namespace code is unused, and duplicative
; of the routine at C3F530. It has been preserved for now to
; avoid changing any code/patch behavior during initial code
; migration, but it can be removed ASAP.

namespace "dup"
org $C3F4B1
EquipSwap:
  BIT #$40
  BNE ToRelics
  LDA #$35
HandleLR:
  STA $E0
  JMP $2022
ToRelics:
  JSR $0EB2
  LDA #$58
  STA $26
  ;INC $25
  RTS
RelicSwap:
  LDA $09
  BIT #$40
  BEQ .skip
  JSR $0EB2
  JSR $1E5F
  BCS .skip
  JSR $9EEB
  LDA $99
  BNE .skip
  LDA #$35
  STA $26
  STZ $27
  ;DEC $25
.skip
  JMP $9EE6
EquipSubSwap:
  BIT #$40
  BNE ToRelics
  LDA $26
  CLC : ADC #$29
  BRA HandleLR
warnpc $C3F4ED
namespace off

org $C3F4F0
BlitzNames:
  PHA               ; store blitz ID
  PHY               ; store Y [TODO: unnecessary]
  ASL               ; x2
  PHA               ; store blitz ID x2
  ASL #2            ; x4 (now x8)
  ADC $01,s         ; add x2 (now x10)
  TAX               ; index to Blitz name
  LDY #$9E8B        ; WRAM buffer address
  STY $2181         ; set ^
  LDA #$20          ; user color (white)
  STA $29           ; set palette
  LDY #$000A        ; 10 (length of blitz name)
.loop
  LDA $E6F831,X     ; blitz name byte
  STA $2180         ; write letter to buffer
  INX               ; increment name index
  DEY               ; decrement buffer size
  CPY #$0000        ; at zero [TODO: unnecessary CPY]
  BNE .loop         ; loop through all 10 tiles
  STZ $2180         ; EOL
  PLY               ; clean up stack some [TODO: unnecessary, and broken]
  JSR $7FD9         ; draw name from buffer
  REP #$21          ; 16-bit A, set carry
  LDA $7E9E89       ; tilemap address
  ADC #$0084        ; increment to next Blitz name location
  STA $7E9E89       ; update tilemap address
  TDC               ; zero A/B
  SEP #$20          ; 8-bit A
  PLA               ; clean up stack (hi byte of PHY earlier)
  PLA               ; get Blitz ID back
  JMP $5683         ; [moved] build tilemap
warnpc $C3F530

org $C3F530
; TODO: Remove Relic <-> Equip Screen Swap code, as it is no longer in effect
; due to Unified Equip Menu. Reclaim this freespace.

EquipSwap:
  BIT #$40          ; pressing Y
  BNE ToRelics      ; branch if ^
  LDA #$35          ; [moved] "Initialize Equip Menu"

HandleLR:
  STA $E0           ; [moved] set ^
  JMP $2022         ; handle L/R

ToRelics:
  JSR $0EB2         ; play click sound
  LDA #$58          ; "Initialize Relic Menu"
  STA $26           ; set next menu action
  INC $25           ; selected menu: "Relics"
  RTS

RelicSwap:
  LDA $09           ; buttons pressed
  BIT #$40          ; pressing Y
  BEQ .skip         ; branch if not ^
  JSR $0EB2         ; play click sound
  JSR $1E5F         ; check for equip permissions
  BCS .skip         ; branch if cannot equip
  JSR $9EEB         ; try auto-switch to equip menu
  LDA $99           ; was it triggered
  BNE .skip         ; branch if ^
  LDA #$35          ; "Initialize Equip Menu"
  STA $26           ; set ^
  STZ $27           ; zero queued command
  DEC $25           ; selected menu: "Equip"
.skip
  JMP $9EE6         ; memorize menu mode

EquipSubSwap:
  BIT #$40          ; pressing Y
  BNE ToRelics      ; branch if ^
  LDA $26           ; menu mode
  CLC : ADC #$29    ; "Swap Actor in Equip Menu" (retain Equip or Remove mode)
  BRA HandleLR      ; branch
warnpc $C3F570

; -------------------------------------------------------------------------
; Keep frame counter updated for RNG algorithm

org $C3F570
FrameCounter:
  INC $021E      ; increment frame counter
  INC $01F0      ; increment RNG frame counter [TODO: Why not use 021E?]
  RTS

; -------------------------------------------------------------------------
; Helpers for new Counterattack variable triggers
    
org $C3F577
AttkBackup:
  TXA              ; attack index
  STA $3290,Y      ; save target's last attacker
  LDA $11A3        ; attack flags
  ROL #2           ; $01: mp damage
  PHA              ; store on stack 
  LDA $B3          ; attack flags
  EOR #$FF         ; invert them
  LSR              ; shift $20 to $10
  ORA $11A7        ; get combined "respect row" flag ($10)
  LSR #4           ; shift it into $01
  AND $11A2        ; combine with "physical" flag ($01)
  LSR              ; carry: "melee attack"
  PLA              ; restore flags
  ROL #2           ; shift "mp dmg" to $04, "melee" to $02
  PHA              ; store on stack again 
  LDA $B1          ; attack flags
  LSR              ; shift "special turn" into carry
  PLA              ; restore row flags
  ROR              ; shift "special" to $80, "mp dmg" to $02, "melee" to $01
  AND #$83         ; only keep these flags
  STA $327D,Y      ; store result
  RTL

TargetMelee:
  LDY $327C,X      ; last attacker
  BMI .exit        ; exit w/o match if "null" (no last attacker)
  LDA $327D,X      ; last attack data
  BMI .exit        ; exit w/o match for "double-counters"
  AND $3A2F        ; match with op arg2 (condition bits)
  CMP $3A2F        ; return with Z flag if are all conditions are met
.exit
  RTL

CounterCheck:
  STY $E8          ; save target index
  ADC $E8          ; add with A offset
  TAX              ; save index to relevant data
  LDA $327D,Y      ; last attack flags
  BMI .exit        ; branch if was "counterattack"
  LDY $3290,X      ; relevant attacker index
.exit
  RTL
warnpc $C3F5C0

; -------------------------------------------------------------------------
; Helpers for Randomize Final Party patch
;
; For the final battle against Kefka, only allow the
; player to select their first 4 characters in the
; line-up. After those four, the line-up will now be
; shuffled/randomized for an extra challenge.

org $C3F5C0

MaybeAdd:
  LDA $4A             ; currently selected
  CMP #$04            ; already maxed out
  BEQ .exit           ; exit (and point to End) if ^
  JSR $AAB2           ; add chosen character (vanilla)
.exit
  RTS

ShuffleList:
  LDY #$000B          ; start with 12th slot
.loop
  TYA                 ; place range in A
  JSR RandomInRange   ; random number from 0 to A
  TAX                 ; store as slot to swap
  JSR SwapSlots       ; swap slots X and Y
  DEY                 ; point to next lowest slot
  BNE .loop           ; peform random swaps for each slot
  JSR $AACA           ; continue to "End" vanilla code
  RTS

RandomInRange:        ; 18 bytes
  INC                 ; include A in possible random number
  STA $4202           ; first multiplicand (range)
  JSL $C0FD00         ; random number
  STA $4203           ; second multiplicand
  NOP #4              ; wait for calc
  LDA $4217           ; get hi byte of product
  RTS

SwapSlots:            ; 35 bytes
  PHB                 ; store current bank
  LDA #$7E            ; replace with $7E
  PHA
  PLB
  LDA $AA8D,X         ; slot X's palette
  PHA                 ; store on stack
  LDA $AA8D,Y         ; slot Y's palette
  STA $AA8D,X         ; replace X's
  PLA                 ; get X's palette
  STA $AA8D,Y         ; replace Y's
  LDA $9D8A,X         ; slot X's id
  PHA                 ; store on stack
  LDA $9D8A,Y         ; slot Y's id
  STA $9D8A,X         ; replace X's
  PLA                 ; get X's id
  STA $9D8A,Y         ; replace Y's
  PLB                 ; restore bank
  RTS

; -------------------------------------------------------------------------
org $C3F700
FlipMPDisplay:
  LDA #$FF       ; MP display = on
  STA $9E        ; store it
  JSR $0F89      ; stop VRAM DMA B
  RTS

EndDrawMP:
  LDA $F9        ; ones digit
  STA $2180      ; add to string
  LDA #$FF       ; space character
  STA $2180      ; add to string
  STZ $2180      ; end string
  JMP $7FD9      ; draw string

EndDrawPercent:
  STA $2180      ; add to string
  STZ $2180      ; end string
  JMP $7FD9      ; draw string
warnpc $C3F721

; TODO: Dunno why we've left 2 unused bytes in between here

org $C3F723
C3_BlindJump:       ; TODO: This Label (and STZ) is no longer used
  STZ $11A9         ; omit special effect (if any)
C3_BlindJump2:
  LDA $3EE4,x       ; status byte 1
  LSR               ; C: "Blind"
  LDA #$20          ; "Cannot Miss"
  BCS .blind        ; branch if "Blind"
  STA $11A4         ; set "Cannot Miss"
  BRA .exit         ; branch to exit
.blind
  STZ $11A4         ; clear "Cannot Miss" [TODO: Why?]
.exit
  RTL
warnpc $C3F737

; TODO: Another two unused bytes here

; EL, EP, Spell Bank Helpers (Synchysi)
org $C3F739
Blue_Bank_Txt:
  LDA #$24          ; color: blue
  STA $29           ; set text palette ^
  JSR $02F9         ; display "SP" in blue text
  LDA #$20          ; color: white
  STA $29           ; set text palette ^
  LDX $67           ; character data offset
  TDC               ; zero A/B
  LDA $0000,X       ; character ID
  TAY               ; index it
  LDA !spell_bank,Y ; character's banked SP
  JSR $04E0         ; convert to displayable digits
  LDX #$47B7        ; where to display
  JMP NewLabels     ; Output banked SP and other new static labels

Finish_Esper_Txt:   ; TODO: Label unused
  LDA #$8F          ; "P"
  STA $2180         ; add ^ to WRAM
  LDA #$FF          ; " "
  STA $2180         ; add ^ to WRAM
  STA $2180         ; add ^ to WRAM
  STA $2180         ; add ^ to WRAM
  LDA $AA           ; spell learned
  LSR               ; C: learned
  BCC .unknown      ; branch if not ^
  LDA #$CF          ; "checkmark"
  BRA .finish       ; draw ^ and finish
.unknown
  LDA #$FF          ; " "
.finish
  STA $2180         ; add ^ to WRAM
  STZ $2180         ; add EOL to WRAM
  JMP $7FD9         ; finish drawing spell row

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
  RTS               ; TODO: Remove duplicated, unused RTS

Pressed_A:
  LDA $4B           ; pointer index
  BNE .spell        ; branch if pointing at a spell
  JML $C358DF       ; vanilla "can equip esper" fork TODO: Use JMP
.spell
  LDA $99           ; load esper ID
  STA $4202         ; set multiplier
  LDA $FB           ; Is esper equippable?
  BRA $04           ; Skip the next 4 bytes
  NOP #4            ; Dummy them out to be sure TODO: Remove these NOPs
  BPL .nope         ; branch if ^
  LDA #$0B          ; size of esper data block (11)
  STA $4203         ; set multiplicand
  LDA $4B           ; pointer index
  CMP #$06          ; "esper bonus" index
  BEQ Apply_Bonus   ; branch if ^
  DEC               ; else, decrement index
  ASL               ; and *2
  CLC               ; clear carry
  REP #$20          ; 16-bit A
  ADC $4216         ; add spell offset to esper data offset
  STA $A5           ; store ^
  TAX               ; index it
  SEP #$20          ; 8-bit A
  LDA $D86E01,X     ; spell ID the pointer is currently on
  STA $E0           ; store ^
  CMP #$FF          ; null?
  BEQ Exiter        ; branch if ^
  JSR $50A2         ; check spell mastery
  BNE .nope         ; exit if already learned
  LDX $A5           ; restore spell offset
  TDC               ; zero A/B
  LDA $D86E00,X     ; SP cost of the spell
  STA $A4           ; store ^
  LDX $67           ; character data offset
  LDA $0000,X       ; character ID
  TAX               ; index it
  STA $4202         ; set multiplier
  LDA !spell_bank,X ; character's banked SP
  SEC               ; set carry
  SBC $A4           ; subtract spell SP cost
  BCC .nope         ; exit if not enough SP
  STA !spell_bank,X ; else, reduce banked SP
  LDA #$36          ; size of character spell lists (54)
  STA $4203         ; set multiplicand
  JSR $0ECE         ; sound: "cha-ching"
  TDC               ; zero A/B
  LDA $E0           ; spell ID
  REP #$20          ; 16-bit A
  CLC               ; clear carry
  ADC $4216         ; add spell index to character spell list offset
  TAX               ; index it
  SEP #$20          ; 8-bit A
  LDA #$FF          ; "learned"
  STA $1A6E,X       ; set spell learned
  JMP $5913         ; jump to vanilla "press B" esper menu fork
.nope
BzztPlayer:
  JMP $0EC0         ; sound: Bzzt

Chk_Esper_Eq:
  STA $4203         ; save SP cost of spell [TODO: Why?]
  LDA $99           ; esper ID
  JSR ChkEsp        ; check esper restriction
  LDA $29           ; text color palette
  CMP #$2C          ; color: gray-blue (equipped)
  BNE .exit         ; exit if not ^
  LDA #$20          ; color: white (equippable)
.exit
Exiter:
  RTS

No_Spell_In_Slot:
  LDX #$B492        ; tilemap position [?]
  STX $2181         ; set WRAM destination
  LDA #$FF          ; " " space
  STA $2180         ; write ^
  STZ $2180         ; write EOL
  JMP $7FD9         ; draw esper name

Apply_Bonus:        ; F834
  LDX $67           ; character data offset
  LDA $0000,X       ; character ID
  TAX               ; index it
  LDA !EL_bank,X    ; unspent esper levels
  BEQ BzztPlayer    ; branch if none ^
  DEC !EL_bank,X    ; else, decrement unspent ELs
  JSL Do_Esper_Lvl  ; and apply esper boost
  JSR $0ECE         ; sound: "cha-ching"
  JSR $4EED         ; redraw HP/MP on the status screen
  JMP $5913         ; jump to vanilla "Press B" esper menu fork

org $C3F850
OffensiveHelp:
  JSR $87EB      ; [displaced] draw evasions
  JSR $C2F7      ; [optimized] set blue palette
  LDY #$8E1D     ; [displaced] text pointer
  JSR $02F9      ; [displaced] draw "Attack"
  JMP $88A0      ; [displaced] draw elements

UpdateTxtColor:
  BEQ .gray      ; branch to gray if property missing
  LDA #$20       ; "user's color" palette (white)
  BRA .done      ; set ^
.gray
  LDA #$24       ; grey text
.done
  STA $29        ; set palette ID
  RTS

ItemProperties:
  LDX $2134        ; item index
  LDA $D85013,x    ; byte to look at
  RTS

DrawTextData:
  STY $E7
  JSR $8795
  RTS

ShopClearBG:
  JSR $6A28        ; clear bg2 map a
  JSR $6A2D        ; clear bg2 map b
  JSR $6A32        ; clear bg2 map c
  JSR $6A37        ; clear bg2 map d
  LDY #GearWindow  ; offset to main gear window specs
  JSR $0341        ; draw window ^
  LDY #GearActors  ; offset to actor window specs
  JSR $0341        ; draw window ^
  LDY #GearNameBox ; offset to name window specs
  JSR $0341        ; draw window ^
  LDY #GearDesc    ; offset to desc window specs
  JSR $0341        ; draw window ^
ClearBG3:
  JSR $6A3C        ; clear bg3 map a
  JSR $6A41        ; clear bg3 map b
  JSR $6A46        ; clear bg3 map c
  JSR $6A4B        ; clear bg3 map d
  RTS

draw_title_dupe:
  JSR $02FF        ; draw title

BuyItemDetails:
  LDA #$10         ; reset/stop desc
  TSB $45          ; set menu flags
  JSR $0F39        ; queue text upload
  JSR $1368
  JSR $0F4D        ; queue text upload 2
  JSR $B8A6        ; handle d-pad
  JSR check_stats
  JSR $BC84        ; draw quantity owned
  JSR $BCA8        ; draw quantity worn
;Handle hold Y
shop_handle_y:
  LDA $0D
  BIT #$40         ; holding Y?
  BEQ .handle_b    ; branch if not
  REP #$20         ; 16-bit A
  LDA #$0100       ; BG2 scroll position
  STA $3B          ; BG2 Y position
  STA $3D          ; BG3 X position
  SEP #$20         ; 8-bit A
  LDA #$04         ; bit 2
  TRB $45          ; set bit in menu flags A
  JSR gear_desc
  RTS
;Fork: Handle B
.handle_b
  STZ $3C
  STZ $3E
  LDA #$04
  TSB $45
  LDA $09          ; No-autofire keys
  BIT #$80         ; Pushing B?
  BEQ .handle_a    ; Branch if not
  JSR $0EA9        ; Sound: Cursor
  JMP $B760        ; Exit submenu
;Fork: Handle A
.handle_a
  LDA $08          ; no-autofire keys
  BIT #$80         ; pushing (A)
  BEQ .exit        ; exit if not ^
  JSR $B82F        ; set buy limit
  JSR $B7E6        ; test GP, stock
.exit
  RTS

DrawDetailsLabels:
  JSR $1368        ; trigger NMI
  JSR $C2F7        ; [displaced] color: blue
  LDY #VigorText   ; text: vigor
  JSR $02F9        ; draw text
  LDY #SpeedText   ; text: speed
  JSR $02F9        ; draw text
  LDY #StaminaText ; text: stamina
  JSR $02F9        ; draw text
  LDY #MagicText   ; text: magic
  JSR $02F9        ; draw text
  LDY #DefText     ; text: defense
  JSR $02F9        ; draw text
  LDY #MDefText    ; text: magic defense
  JSR $02F9        ; draw text
  LDY #EvadeText   ; text: evasion
  JSR $02F9        ; draw text
  LDY #MEvadeText  ; text: magic evasion
  JSR $02F9        ; draw text
  LDY #PowerText   ; text: bat.pow.
  JSR $02F9        ; draw text
  JSR $BFC2        ; get item ID in A [TODO why]
  RTS

check_stats:
  PHA               ; store A
  PHX               ; store X
  PHY               ; store Y
  PHP               ; store flags
  JSR $C2F2         ; set palette to white
  JSR $BFC2         ; get item
  JSR $8321         ; Compute index
  LDX $2134         ; Load it
  TDC               ; Terminator
  STA $7E9E8D       ; Set mod B3
  STA $7E9E8E       ; Set mod B4
  REP #$20          ; 16-bit A
  LDA #$8223        ; Tilemap ptr
  STA $7E9E89       ; Set position
  SEP #$20          ; 8-bit A
  TDC               ; Clear A
  LDA $D85010,X     ; Stat mods LB
  PHA               ; Memorize them
  AND #$0F          ; Vigor index
  ASL A             ; Double it
  JSR $8836         ; Draw modifier
  REP #$20          ; 16-bit A
  LDA #$8323        ; Tilemap ptr
  STA $7E9E89       ; Set position
  SEP #$20          ; 8-bit A
  TDC               ; Clear A
  PLA               ; Stat mods LB
  AND #$F0          ; Speed index
  LSR A             ; Put in b3-b6
  LSR A             ; Put in b2-b5
  LSR A             ; Put in b1-b4
  JSR $8836         ; Draw modifier
  REP #$20          ; 16-bit A
  LDA #$83A3        ; Tilemap ptr
  STA $7E9E89       ; Set position
  SEP #$20          ; 8-bit A
  LDX $2134         ; Item index
  TDC               ; Clear A
  LDA $D85011,X     ; Stats mods HB
  PHA               ; Memorize them
  AND #$0F          ; Stamina index
  ASL A             ; Double it
  JSR $8836         ; Draw modifier
  REP #$20          ; 16-bit A
  LDA #$82A3        ; Tilemap ptr
  STA $7E9E89       ; Set position
  SEP #$20          ; 8-bit A
  TDC               ; Clear A
  PLA               ; Stat mods HB
  AND #$F0          ; Mag.Pwr index
  LSR A             ; Put in b3-b6
  LSR A             ; Put in b2-b5
  LSR A             ; Put in b1-b4
  JSR $8836         ; Draw modifier

;draw defensive properties
  LDX $2134         ; Item index
  LDA $D85000,X     ; Properties
  AND #$07          ; Get class
  BEQ not_weapon    ; branch if tool
  CMP #$01          ; Weapon?
  BEQ is_weapon     ; Branch if so
  CMP #$06          ; item?
  BEQ not_weapon    ; branch if so
  LDA $D85014,X     ; Defense
  JSR $04E0         ; Turn into text
  LDX #$823F        ; Text position
  JSR $04C0         ; Draw 3 digits
  LDX $2134         ; Item index
  LDA $D85015,X     ; Mag.Def
  JSR $04E0         ; Turn into text
  LDX #$833F        ; Text position
  JSR $04C0         ; Draw 3 digits
  LDY #PowerDash
  JSR $02f9
is_weapon:
  TDC
  LDX $2134        ; item index
  LDA $D85000,x    ; properties
  AND #$07
  CMP #$01
  BNE not_weapon
  LDA #$20       ; Palette 0
  STA $29        ; Color: User's
  CMP #$51       ; Dice?
  BEQ hide_bpow      ; Hide if so
  LDX $2134
  LDA $D85014,X  ; Bat.Pwr
  JSR $04E0      ; Turn into text
  LDX #$813F        ; Text position
  JSR $04C0      ; Draw 3 digits
  LDY #DefDash
  JSR $02F9
  LDY #MDefDash
  JSR $02F9
  BRA not_weapon

hide_bpow:
  LDY #UnknownTxt     ; Text pointer
  JSR $02F9      ; Draw "???"

not_weapon:
  JSR all_dashes
  REP #$20       ; 16-bit A
  LDA #$82BF     ; Tilemap ptr
  STA $7E9E89    ; Set position
  SEP #$20       ; 8-bit A
  LDX $2134      ; Item index
  TDC            ; Clear A
  LDA $D8501A,X  ; Evasion mods
  PHA            ; Memorize them
  AND #$0F       ; Evade index
  ASL A          ; x2
  ASL A          ; x4
  JSR $881A      ; Draw modifier
  REP #$20       ; 16-bit A
  LDA #$83BF     ; Tilemap ptr
  STA $7E9E89    ; Set position
  SEP #$20       ; 8-bit A
  LDX $2134      ; Item index
  TDC            ; Clear A
  PLA            ; Evasion mods
  AND #$F0       ; MBlock index
  LSR A          ;
  LSR A          ;
  TAX            ; Index it
  LDA $C38854,X  ; Sign
  STA $7E9E8B    ; Add to string
  LDA $C38855,X  ; Tens digit
  STA $7E9E8C    ; Add to string
  LDA $C38856,X  ; Ones digit
  STA $7E9E8D    ; Add to string
  JSR $8847      ; Draw modifier

; name and cleanup
  REP #$20
  LDA #$810D        ; tilemap ptr
  STA $7E9E89
  SEP #$20        
  JSR $BFC2        ; get item
  JSR $C068        ; load item name
  JSR $7FD9
  PLP
  PLY
  PLX
  PLA
  JSR $BC92
  RTS

all_dashes:
  LDX $2134
  LDA $D85000,x
  AND #$07
  CMP #$06
  BNE skip_all_dashes
  LDY #PowerDash
  JSR $02F9
  LDY #DefDash
  JSR $02F9
  LDY #MDefDash
  JSR $02F9
skip_all_dashes:
  RTS
gear_desc:
  LDA $02
  CMP $4B
  BNE gear_desc_end
  JSR gear_desc2    ; build description tilemap for shop menu
  JSR $B4E6        ; set description flags
  JSR $B4EF        ; load item description for buy menu
gear_desc_end:
  LDA $4B
  STA $02
  RTS

gear_desc2:
  LDX #$7849     ; Base: 7E/7849
  STX $EB        ; Set map ptr LBs
  LDA #$7E       ; Bank: 7E
  STA $ED        ; Set ptr HB
  LDY #$0CBC     ; Ends at 30,19
  STY $E7        ; Set row's limit
  LDY #$0C84     ; Starts at 3,19
  LDX #$3500     ; Tile 256, pal 5
  STX $E0        ; Priority enabled
  JSR $A783      ; Do line 1, row 1
  LDY #$0CFC     ; Ends at 30,20
  STY $E7        ; Set row's limit
  LDY #$0CC4     ; Starts at 3,20
  LDX #$3501     ; Tile 257, pal 5
  STX $E0        ; Priority enabled
  JSR $A783      ; Do line 1, row 2
  LDY #$0D3C     ; Ends at 30,21
  STY $E7        ; Set row's limit
  LDY #$0D04     ; Starts at 3,21
  LDX #$3538     ; Tile 312, pal 5
  STX $E0        ; Priority enabled
  JSR $A783      ; Do line 2, row 1
  LDY #$0D7C     ; Ends at 30,22
  STY $E7        ; Set row's limit
  LDY #$0D44     ; Starts at 3,22
  LDX #$3539     ; Tile 313, pal 5
  STX $E0        ; Priority enabled
  JMP $A783      ; Do line 2, row 2

HelpText:
  dw $791F : db "Hold",$FE,"Y",$FE,"for",$FE,"details.",$00 ; TODO: Why FE?
VigorText:
  dw $820D : db "Vigor",$00
SpeedText:
  dw $830D : db "Speed",$00
StaminaText:
  dw $838D : db "Stamina",$00
MagicText:
  dw $828D : db "Magic",$00
DefText:
  dw $822B : db "Defense",$00
MDefText:
  dw $832B : db "M.Def.",$00
EvadeText:
  dw $82AB : db "Evade",$00
MEvadeText:
  dw $83AB : db "M.Evade",$00
PowerText:
  dw $812B : db "Attack",$00,$00 ; TODO Remove extra $00 here
UnknownTxt:
  dw $813F : db "???",$00
PowerDash:
  dw $813F : db "---",$00
DefDash:
  dw $823F : db "---",$00
MDefDash:
  dw $833F : db "---",$00
EleResist:
  dw $7B8D : db "Resist:",$00
EleAbsorb:
  dw $7C0D : db "Absorb:",$00
EleImmune:
  dw $7C8D : db "Nullify:",$00
EleWeak:
  dw $7D0D : db "Weakness:",$00

; Window layout data
GearWindow:  : dw $718B : db $1C,$06
GearActors:  : dw $750B : db $1C,$06
GearNameBox: : dw $708B : db $1C,$02
GearDesc:    : dw $738B : db $1C,$04

; ------------------------------------------------------------------------
; Status Menu Redesign helpers

org $C3FC20

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

; ------------------------------------------------------------------------
; Rage and Dance description helpers

org $C3FCA0
PrepDescs:
  STX $E7          ; store pointer offset
  LDX #$0000       ; use base offset for text
  STX $EB          ; ^ will be added to Y index
  LDA #$C4         ; bank
  STA $ED          ; text bank
  STA $E9          ; pointer bank
  JSR $0EFD        ; queue list upload (vanilla)
  LDA #$10         ; "Descriptions on"
  TRB $45          ; set ^ in menu flags
  RTS

DancesHook:
  LDX #DanceDescs  ; pointer offsets
  JSR PrepDescs
  JMP $572A

RageDescHelp:
  LDX #RageDescs   ; pointer offsets
  JSR PrepDescs
  LDX #$9EC9       ; 7E/9EC9
  STX $2181        ; Set WRAM LBs
  TDC              ; clear A
  LDA $4B          ; list slot
  TAX              ; index it
  LDA $7E9D89,X    ; entry id
  CMP #$FF         ; null slot?
  BNE .continue    ; branch if not ^
  JMP $576D        ; blank description
.continue
  REP #$20         ; 16-bit A
  ASL A            ; double id
  TAY              ; index it
  LDA [$E7],Y      ; Relative ptr
  PHA              ; store for later
  SEP #$20         ; 8-bit A
  LDY #PrefixA
  JSR WriteLine
  PLY              ; get description pointer
  JSR WriteLine
  PHY              ; save next line offset
  LDY #PrefixB
  JSR WriteLine
  PLY              ; get next line offset 
  JSR WriteLine
  STZ $2180
  RTS

WriteChar:
  INY
  STA $2180       ; add to string
  CMP #$01
  BEQ WriteExit
WriteLine:
  LDA [$EB],Y     ; text character
  BNE WriteChar   ; loop if not 00
WriteExit:
  RTS
warnpc $C40000

; ------------------------------------------------------------------------
; More EL/EP/SpellBank Helpers
; TODO: Some of this code deprecates unused labels above
; TODO: Some of this code may not be used at all

org $C3FD08
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

