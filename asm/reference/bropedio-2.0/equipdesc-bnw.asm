hirom
; header

table ff6_bank_c3.tbl,rtl
incsrc ff6_bank_c3_defs.asm

org $C30247
         dw #C39621      ; Update entry 36 in C301DB jump table

org $C30285
         dw #C39884      ; Update entry 55 in C301DB jump table
         
org $C30289
         dw #C3990F      ; Update entry 57 in C301DB jump table

org $C31BB8
; 35: Initialize Equip menu
C31BB8:  JSR C31BBD      ; Init variables
C31BD7:  JSR C39032      ; Draw menu; status
         LDA #$01        ; C3/1D7E
         STA $26         ; Next: Fade-in
         LDA #$36        ; C3/9621
         STA $27         ; Queue: Option list
         JMP $3541       ; BRT:1 + NMI

; Initialize variables for Equip menu
C31BBD:  JSR $352F       ; Reset/Stop stuff
         JSR $6A08       ; Set Win1 bounds
         ; LDA #$06        ; Main cursor: On
         ; TSB $46         ; Set menu flag
         STZ $4A         ; List scroll: 0
         STZ $49         ; Top BG1 WR row: 1
         LDA #$10        ; Reset/Stop desc
         TSB $45         ; Set menu flag
         JSR $1B99       ; Queue desc anim
         JSR $94B6       ; Set to shift text
         JMP _38E59
         
warnpc $C31BE5


org $C31BE8
; Update JSR target
         JSR C3964F      ; Update menu colours (Equip)
         
org $C31BF6
; Update JSR target
         JSR C39656      ; Update menu colours (Remove)
         
org $C31C01
; Update JSR and JMP targets
C31C01:  JSR C31BBD      ; Reset variables
         JSR C39032      ; Draw menu; status
         JMP C39614      ; Switch windows
         

org $C31C26
; Update JSR and branch target
C31C26:  JSR C31BBD      ; Init variables
         JSR $96A8       ; Remove gear
         LDA #$02        ; Menu: Equip
         STA $25         ; Set submenu
         BRA C31BD7      ; Draw menu, etc.


org $C32E72
; Update menu pointer
         dw #prtyvu

org $C3372D
; Update text pointer
         dw #review


org $C38E59
; Update LDY pointer
C38E59:  LDY #C38E64     ; C3/8E64

org $C38E5F
; Navigation data for Equip menu options
C38E5F:  db $01          ; Wraps horizontally
         db $00          ; Initial column
         db $00          ; Initial row
         db $03          ; 3 columns
         db $01          ; 1 row

; Cursor positions for Equip menu options
C38E64:  dw $0840        ; EQUIP
         dw $0878        ; REMOVE
         dw $08B8        ; EMPTY

warnpc $C38E6C


org $C38E75
; Update LDY pointer
         LDY #C38E80

org $C38E7B
; Navigation data for Equip menu slot selection
C38E7B:  db $81          ; Wraps all ways
         db $00          ; Initial column
         db $00          ; Initial row
         db $02          ; 2 column
         db $03          ; 3 rows

warnpc $C38E88


org $C38FB4
         NOP #12          ; Blanking out a routine that handles allowing/forbidding "Empty", which we no longer use

warnpc $C38FC1

        
org $C39032
; Draw Equip menu, create portrait, update status via gear
C39032:  JSR C39093      ; Do boxes; face
         JSR C3911B      ; Draw info; status
         JSR C3904E      ; Draw top options
         JSR C3A6AB
         JMP $0E6E       ; Upload BG3 A+B
         
; Draw options in Equip menu
C3904E:  LDA #$20        ; Palette 0
         STA $29         ; Color: User's
         LDX #C3A2A6     ; Text ptrs loc
         LDY #$0006      ; Strings: 3
         JMP $69BA       ; Draw text
         
; Draw elements shared by Equip and Relic menus, create portrait
C39093:  JSR C39110      ; Load actor stats
         REP #$20        ; 16-bit A
         LDA #$0100      ; BG1 H-Shift: 256
         STA $7E9BD0     ; Hide gear list
         SEP #$20        ; 8-bit A
         LDA #$01        ; 64x32 at $0000
         STA $2107       ; Set BG1 map loc
         LDA #$42        ; 32x64 at $4000
         STA $2109       ; Set BG3 map loc
         JSR $6A28       ; Clear BG2 map A
         JSR $6A2D       ; Clear BG2 map B
         LDY #C3947F     ; C3/947F
         JSR $0341       ; Draw stats box A
         LDY #C39487     ; C3/9487
         JSR $0341       ; Draw option box
         LDY #C3948F     ; C3/9487
         JSR $0341       ; Draw option box
         LDY #C39497     ; C3/9487
         JSR $0341       ; Draw option box
         JSR $0E52       ; Upload windows
         JSR $6A15       ; Clear BG1 map A
         JSR $6A19       ; Clear BG1 map B
         JSR $0E28       ; Upload BG1 A+B
         JSR $0E36       ; Upload BG1 C...
         JSR $6A3C       ; Clear BG3 map A
         JSR $6A41       ; Clear BG3 map B
         JSR $93E5       ; Draw actor name
         ; JSR $61B2       ; Create portrait
         LDA #$2C        ; Palette 3
         STA $29         ; Color: Blue
         LDX #$A34D      ; Text ptrs loc
         LDY #$001C      ; Strings: 14
         JSR $69BA       ; Draw Vigor, etc.
         LDX #$A369      ; Text ptrs loc
         LDY #$0008      ; Strings: 4
         JSR $69BA       ; Draw Speed, etc.
         JMP $0E6E       ; Upload BG3 A+B

; Draw actor info in Equip menu, update status based on gear
C3911B:  LDA #$20        ; Palette 0
         STA $29         ; Color: User's
         JSR C3913E      ; Do stats; status
         JSR C39975
         JSR C39435      ; Draw helmet
         JSR C39443      ; Draw armor
         JSR C39451      ; Draw Relic 1
         JMP C3945F      ; Draw Relic 2

; Draw current stats in gear menu, update status based on gear
C3913E:  JSR C39110      ; Load actor stats
         JSR $93F2       ; Actor's address
         JSR $99E8       ; Set Bat.Pwr mode
         JSR $9207       ; Relocate stats
         PHB             ; Save DB
         LDA #$7E        ; Bank: 7E
         PHA             ; Put on stack
         PLB             ; Set DB to 7E
         JSR $91C4       ; Update status
         LDA $3006       ; Vigor
         JSR $04E0       ; Turn into text
         LDX #$7CB7      ; Text position
         JSR $04C0       ; Draw 3 digits
         LDA $3004       ; Speed
         JSR $04E0       ; Turn into text
         LDX #$7D37      ; Text position
         JSR $04C0       ; Draw 3 digits
         LDA $3002       ; Stamina
         JSR $04E0       ; Turn into text
         LDX #$7DB7      ; Text position
         JSR $04C0       ; Draw 3 digits
         LDA $3000       ; Mag.Pwr
         JSR $04E0       ; Turn into text
         LDX #$7E37      ; Text position
         JSR $04C0       ; Draw 3 digits
         JSR $9382       ; Define Bat.Pwr (BNW)
         LDX $F1         ; Load it
         STX $F3         ; Save for $052E
         JSR $052E       ; Turn into text
         LDX #$7EB7      ; Text position
         JSR $0486       ; Draw 3 digits
         LDA $301A       ; Defense
         JSR $04E0       ; Turn into text
         LDX #$7F37      ; Text position
         JSR $04C0       ; Draw 3 digits
         LDA $3008       ; Evade
         JSR $04E0       ; Turn into text
         LDX #$7FB7      ; Text position
         JSR $04C0       ; Draw 3 digits
         LDA $301B       ; Mag.Def
         JSR $04E0       ; Turn into text
         LDX #$8037      ; Text position
         JSR $04C0       ; Draw 3 digits
         LDA $300A       ; MBlock
         JSR $04E0       ; Turn into text
         LDX #$80B7      ; Text position
         JSR $04C0       ; Draw 3 digits
         PLB             ; Restore DB
         RTS
         
; Cursor positions for Equip menu slot selection
C38E80:  dw $3800        ; R-Hand
         dw $3878        ; L-Hand
         dw $4400        ; Head
         dw $4478        ; Body
         dw $5000        ; Relic 1
         dw $5078        ; Relic 2
         
; Draw equipped armor in Equip menu
C39443:  LDX #$7B2B      ; Tilemap ptr
         JSR $946D       ; Set Y, coords
         LDA #$20        ; Palette 0
         STA $29         ; Color: User's
         LDA $0022,Y     ; Armor
         CMP #$FF        ; Is it empty?
         BEQ drBody      ; If so, branch and draw "Body"
         JMP $9479       ; Draw its name
drBody:  LDA #$24        ; Palette 1
         STA $29         ; Color: Gray
         LDY #C3A2D3     ; Body string location
drSlot:  JMP $02F9
         
; Draw equipped relic 1 in Relic menu
C39451:  LDX #$7B8D      ; Tilemap ptr
         JSR $946D      ; Set Y, coords
         LDA #$20        ; Palette 0
         STA $29         ; Color: User's
         LDA $0023,Y     ; Relic 1
         CMP #$FF        ; Is it empty?
         BEQ drRel1      ; If so, branch and draw "Relic"
         JMP $9479      ; Draw its name
drRel1:  LDA #$24
         STA $29
         LDY #C3A2DA
         BRA drSlot

; Draw equipped relic 2 in Relic menu
C3945F:  LDX #$7BAB      ; Tilemap ptr
         JSR $946D       ; Set Y, coords
         LDA #$20        ; Palette 0
         STA $29         ; Color: User's
         LDA $0024,Y     ; Relic 2
         CMP #$FF        ; Is it empty?
         BEQ drRel2      ; If so, branch and draw "Relic"
         JMP $9479       ; Draw its name
drRel2:  LDA #$24
         STA $29
         LDY #C3A2E2
         BRA drSlot
         
warnpc $C391C4

org $C3926B
; Update JSR target
         JSR C39110      ; Load actor data
         
org $C393E5
; Draw actor name in Equip or Relic menu
C393E5:  JSR $93F2      ; Actor's address
         LDA #$2C        ; Palette 0
         STA $29         ; Color: Blue
         LDY #$788D      ; Text position

org $C393FC
; Draw equipped helmet in Equip menu
C39435:  LDX #$7B0D      ; Tilemap ptr
         JSR $946D       ; Set Y, coords
         LDA #$20        ; Palette 0
         STA $29         ; Color: User's
         LDA $0021,Y     ; Helmet
         CMP #$FF        ; Is it empty?
         BEQ drHead      ; If so, branch and draw "Head"
         JMP $9479       ; Draw its name
drHead:  LDA #$24
         STA $29
         LDY #C3A2CC
         JMP drSlot

warnpc $C3946D


org $C3947F
; Window layout for Equip and Relic menus
C3947F:  dw $5B4B,$0D1C  ; 30x15 at $5B4B (Stats w/o title)
C39487:  dw $584B,$0A1C  ; 30x04 at $588B (Options)
C3948F:  dw $584B,$011C  ; Menu
C39497:  dw $584B,$0106  ; Name


org $C3960C
; Switch to layout with options in Equip or Relic menu
C3960C:  RTS

; 36: Handle Equip menu options
C39621:  LDA #$10        ; Description: Off
         TSB $45         ; Set menu flag
         ; JSR $1368       ; Refresh screen
         JSR $9E14       ; Queue BG3 upload
         JSR C3904E      ; Draw options
         JSR $8E56       ; Handle D-Pad
         LDA $08         ; No-autofire keys
         BIT #$80        ; Pushing A?
         BEQ C39635      ; Branch if not
         JSR $0EB2       ; Sound: Click
         BRA C39664      ; Handle selection
         
; Fork: Handle B
C39635:  LDA $09         ; No-autofire keys
         BIT #$80        ; Pushing B?
         BEQ C39648      ; Branch if not
         JSR $0EA9       ; Sound: Cursor
         JSR C39110      ; Update field FX
         LDA #$04        ; C3/1A8A
         STA $27         ; Queue main menu
         STZ $26         ; Next: Fade-out
         RTS

; Fork: Handle L and R, prepare for menu reset
C39648:  LDA #$35        ; C3/1BB8
         STA $E0         ; Set init command
         JMP $2022       ; Handle L and R

; Highlight "Equip", gray out "Remove" and "Empty"
; C3964F:  LDY #C3A31A     ; Text pointer
         ; JSR $02F9       ; Draw title
         ; LDA #$24
         ; STA $29
         ; LDY #C3A32C
         ; JSR $02F9
         ; BRA grEmpty

; Highlight "Remove", gray out "Equip" and "Empty"
; C39656:  LDY #C3A32C     ; Text pointer
         ; JSR $02F9       ; Draw title
         ; LDA #$24
         ; STA $29
         ; LDY #C3A31A
         ; JSR $02F9
; grEmpty: LDY #C3A334
         ; JMP $02F9

warnpc $C39664


org $C39664
; Handle selected option in Equip menu
C39664:  TDC             ; Clear A
         LDA $4B         ; Cursor slot
         ASL A           ; Double it
         TAX             ; Index it
         JMP (C3966C,X)  ; Handle option

; Jump table for the above
C3966C:  dw $9674       ; EQUIP
         dw $968E       ; REMOVE
         dw $969F       ; EMPTY
         
org $C39674
; Update JSR targets
C39674:  JSR C39614      ; Update text colour (Yellow)
         JSR C3964F      ; Update menu colours (Equip)
         
org $C3968E
; Update JSR target
C3968E:  JSR C39614      ; Update text colour (Yellow)
         JSR C39656      ; Update menu colours (Remove)
         

org $C396A2
; Update JSR target
         JSR C3911B      ; Redo text, status  
         
org $C396A8
; Remove character's equipment
C396A8: JSR $93F2       ; Define Y
        LDX #$0005       ; Loop index
rmloop: LDA $001F,Y      ; SRAM equipment location
        JSR $9D5E
        LDA #$FF
        STA $001F,Y
        INY
        DEX
        BPL rmloop
        RTS
        
_396A8: JSR $93F2
        LDX #$0003
        BRA rmloop
        
warnpc $C396D2

org $C396E9
; Minor optimisation -- called at start of /96F0 subroutine
         NOP #3

org $C396F0
; Update JSR target
C396F0:  JSR C39110      ; Get gear FX
         JSR _396A8

; org $C39704
; Update JSR target
         ; JSR C39B59      ; ...
         
; org $C3971C
; Update JSR target
         ; JSR C39B59      ; ...
         
; org $C3973B
; Update JSR target
         ; JSR C39B59      ; ...
         
; org $C39755
; Update JSR target
         ; JSR C39B59      ; ...
         
; org $C3976F
; Update JSR target
         ; JSR C39B59      ; ...
         
; org $C39784
; Update JSR target
         ; JSR C39B59      ; ...
         

org $C398F1
; Update JSR target
         ; JSR C3911B      ; Redo text, status
         
; org $C398F8
; Update branch target
         ; BEQ $0E



org $C398CF
; 56: Handle manual gear removal
C398CF:  LDA $09
         BIT #$40        ; Pushing Y?
         BEQ .nodsc      ; Branch if not
         LDA $45         ; Description: On
         EOR #$10        ; Set Menu Flag
         STA $45
.nodsc   JSR $9E14       ; Queue text upload
         JSR $8E72       ; Handle D-Pad
         JSR C3A1C3      ; Load description for equipped gear
         LDA $08         ; No-autofire keys
         BIT #$80        ; Pushing A?
         BEQ C398F4      ; Branch if not
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
         JSR C3911B      ; Redo text, status

; Fork: Handle B
C398F4:  LDA $09         ; No-autofire keys
         BIT #$80        ; Pushing B?
         BEQ C39908      ; Branch if not
         JSR $0EA9       ; Sound: Cursor
         JSR $8E50       ; Load navig data
         JSR $8E59       ; Relocate cursor
         LDA #$36        ; C3/9621
         STA $26         ; Next: Option list
         RTS

; Fork: Handle L and R, prepare for menu reset
C39908:  LDA #$7F        ; C3/1BF3
         STA $E0         ; Set init command
         JMP $2022       ; Handle L and R


; org $C3990F
; 57: Handle gear browsing
C3990F:  LDA #$10        ; Description: On
         TRB $45         ; Set menu flag
         JSR $9E14
         JSR $9AD3       ; Handle navigation
         JSR $9233       ; Draw stat preview
         JSR $A1D8       
         
; Fork: Handle A
         LDA $08         ; No-autofire keys
         BIT #$80        ; Pushing A?
         BEQ C39944      ; Branch if not
         JSR $9A42       ; On a gray item?
         BCC C3996E      ; Fail if so
         JSR $0EB2       ; Sound: Click
         LDA $001F,Y     ; Item to unequip
         CMP #$FF        ; None?
         BEQ C3992D      ; Branch if so
         JSR $9D5E       ; Put in stock
C3992D:  TDC             ; Clear A
         LDA $4B         ; Gear list slot
         TAX             ; Index it
         LDA $7E9D8A,X   ; Inventory slot
         TAX             ; Index it
         LDA $1869,X     ; Item in slot
         STA $001F,Y     ; Equip on actor
         JSR $9D97       ; Adjust stock
         JSR C3911B      ; Redo text, status
         BRA C3994D      ; Exit gear list

; Fork: Handle B
C39944:  LDA $09         ; No-autofire keys
         BIT #$80        ; Pushing B?
         BEQ C3996D      ; Exit if not
         JSR $0EA9       ; Sound: Cursor
         LDA $F0
         STA $11D8
C3994D:  LDA #$10        ; Description: Off
         TSB $45         ; Set menu flag
         JSR $9C87       ; Clear stat preview
         REP #$20        ; 16-bit A
         LDA #$0100      ; BG1 H-Shift: 256
         STA $7E9BD0     ; Hide gear list
         SEP #$20        ; 8-bit A
         LDA #$C1        ; Top cursor: Off
         TRB $46         ; Scrollbar: Off
         JSR $8E6C       ; Load navig data
         LDA $5E         ; Former position
         STA $4E         ; Set cursor row
         LDA $5D
         STA $4D
         JSR $8E75       ; Relocate cursor
         JSR $1368       ; Refresh screen
         LDA #$55        ; C3/9884
         STA $26         ; Next: Body parts
C3996D:  RTS

; Fork: Invalid selection
C3996E:  JSR $0EC0       ; Play buzzer
         JMP $305D       ; Pixelate screen

; Draw "R-hand" and "L-hand" in Equip menu
C39975:  LDA $11D8       ; Gear effects
         AND #$08        ; Gauntlet?
         BEQ C3998F      ; Branch if not
         JSR $93F2       ; Define Y
         LDA $001F,Y     ; R-Hand item
         CMP #$FF        ; None?
         BEQ .lyelit     ; Draw L-Hand in yellow
         
         LDA $0020,Y     ; L-Hand item
         CMP #$FF        ; None?
         BNE C3998F
         
.ryelit  LDA #$28
         STA $29
         JSR ylwrhn
         JMP _393FC
        
.lyelit  LDA #$28
         STA $29
         JSR ylwlhn
         JMP C393FC
         
C3998F:  JSR C393FC       ; Draw R-Hand name/item
         JMP _393FC       ; Draw L-Hand name/item
         
         
warnpc $C399E8


; org $C39A5D
; From genji_menu_fix.asm
; JSR Wpn_Index

; org $C39A90		; Right hand
; JMP DW_Chk_RH

; org $C39ABC		; Left hand
; JMP DW_Chk_LH


org $C39B59
; Compile compatible gear for actor's body part
C39B59:  JSR $9C2A       ; Init list
         JSR $9C41       ; Define compat
         LDA #$20        ; Palette 0
         STA $29         ; Color: User's
         LDA $4B         ; Body part
         CMP #$02        ; Head?
         BCC C39B72
         BEQ C39BB2
         CMP #$04
         BCC C39BEE      ; Handle torso
         JMP C3A051       ; Handle relics

warnpc $C39B73


;; ORIGINAL FOR BRANCHING
; Fork: Weapons and shields
org $C39B72
C39B72:

; Fork: Helmet list
org $C39BB2
C39BB2:  

; Fork: Armor list
org $C39BEE
C39BEE:  
         
;; END ORIGINAL

org $C39E4B
; Set text colour to yellow
C39614:  LDA #$28        ; Palette 2
         STA $29         ; Color: Yellow
         RTS             ; ^ For "Equip"


; 55: Handle selection of gear slot to fill
C39884:  LDA $09
         BIT #$40        ; Pushing Y?
         BEQ .nodsc      ; Branch if not
         LDA $45         ; Description: On
         EOR #$10        ; Set Menu Flag
         STA $45
.nodsc   JSR $9E14       ; Queue text upload
         JSR $8E72       ; Handle D-Pad
         JSR C3A1C3      ; Load description for equipped gear
         JSR C39975      ; Recolor hand names
         LDA $08         ; No-autofire keys
         BIT #$80        ; Pushing A?
         BEQ C398B4      ; Branch if not
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
         JSR C39B59      ; Build item list
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
         
; Fork: Handle B
C398B4:  LDA $09         ; No-autofire keys
         BIT #$80        ; Pushing B?
         BEQ C398C8      ; Branch if not
         JSR $0EA9       ; Sound: Cursor
         JSR $8E50       ; Load navig data
         JSR $8E59       ; Relocate cursor
         LDA #$10        ; Description: Off
         TSB $45         ; Set menu flag
         JSR $1368       ; Refresh screen
         LDA #$36        ; C3/9621
         STA $26         ; Next: Option list
         RTS

         
         
; Fork: Handle L and R, prepare for menu reset
C398C8:  LDA #$7E        ; C3/1BE5
         STA $E0         ; Set init command
         JMP $2022       ; Handle L and R
         

; Draw L-Hand and R-Hand name/item
C393FC:  LDA #$20        ; Palette 0
         STA $29         ; Color: User's
ylwrhn:  LDX #$7A8D      ; Tilemap ptr
         JSR $946D       ; Set Y, coords
         LDA $001F,Y     ; R-Hand item
         CMP #$FF        ; Is it empty?
         BEQ drRHnd      ; If so, branch and draw "Head"
         JMP $9479       ; Draw its name
drRHnd:  LDA #$24
         STA $29
ylrhem:  LDY #C3A2BA
drHand:  JMP $02F9
         
_393FC:  LDA #$20        ; Palette 0
         STA $29         ; Color: User's
ylwlhn:  LDX #$7AAB      ; Tilemap ptr
         JSR $946D       ; Set Y, coords
         LDA $0020,Y     ; L-Hand item
         CMP #$FF        ; Is it empty?
         BEQ drLHnd      ; If so, branch and draw "Head"
         JMP $9479       ; Draw its name
drLHnd:  LDA #$24
         STA $29
yllhem:  LDY #C3A2C3
         BRA drHand

; Load member's stats and properties with gear
C39110:  TDC             ; Clear A
         LDA $28         ; Member slot
         TAX             ; Index it
         LDA $69,X       ; Actor
         JSL $C20006     ; Load data
         RTS

; Invoke Party Overview Menu
prtyvu:  JSR $0EB2       ; Sound: Click
         STZ $26         ; Next: Fade-out
         LDA #$38        ; C3/1AD6
         STA $27         ; Queue party overview
         RTS
         
; Replacement positioned text for main menu
review:  dw $7AB9 : db "Review",$00

; Compile compatible relics
C3A051:  JSR $9C2A      ; Init list
         JSR $9C41      ; Define compat
         LDA #$20        ; Palette 0
         STA $29         ; Color: User's
         LDX $00         ; Clear X...
         TXY             ; Item slot: 1
C3A05E:  TDC             ; Clear A
         LDA $1869,Y     ; Item in slot
         CMP #$FF        ; None?
         BEQ C3A088      ; Skip if so
         JSR $8321      ; Compute index
         LDX $2134       ; Load it
         LDA $D85000,X   ; Properties
         AND #$07        ; Get class
         CMP #$05        ; Relic?
         BNE C3A088      ; Skip if not
         REP #$20        ; 16-bit A
         LDA $D85001,X   ; Compatibility
         BIT $E7         ; Actor can use?
         BEQ C3A088      ; Skip if not
         SEP #$20        ; 8-bit A
         TYA             ; Item slot
         STA $2180       ; Add to list
         INC $E0         ; List size +1
C3A088:  SEP #$20        ; 8-bit A
         INY             ; Item slot +1
         CPY #$0100      ; Done all 256?
         BNE C3A05E      ; Loop if not
         LDA $E0         ; List size
         STA $7E9D89     ; Save to list
         RTS

;print "C3A1C3 is at: ",pc
; Load item description for equipped relic (unused)
C3A1C3:  JSR $8308      ; Set desc ptrs
         JSR $93F2      ; Define Y (Character SRAM block)
         REP #$20       ; 16-bit A
         TYA            ; Character in A
         ADC $4B        ; Add slot index
         TAY            ; And return to Y
         SEP #$20       ; 8-bit A
         TDC
         LDA $001F,Y
C3A1D5:  JMP $5738      ; Load description

; Highlight "Equip", gray out "Remove" and "Empty"
C3964F:  LDY #C3A31A     ; Text pointer
         JSR $02F9       ; Draw title
         LDA #$24
         STA $29
         LDY #C3A32C
         JSR $02F9
         BRA grEmpty

; Highlight "Remove", gray out "Equip" and "Empty"
C39656:  LDY #C3A32C     ; Text pointer
         JSR $02F9       ; Draw title
         LDA #$24
         STA $29
         LDY #C3A31A
         JSR $02F9
grEmpty: LDY #C3A334
         JMP $02F9
         
warnpc $C3A051

org $C3A1C3
_38E59:  JSR $8E50      ; Load navig data
         JSR $8E59      ; Relocate cursor
         JMP $07B0      ; Queue cursor OAM
         
         
warnpc $C3A1D8


org $C3A2A6
; Text pointers for Equip menu
C3A2A6:  dw C3A31A       ; EQUIP
         dw C3A32C       ; RMOVE
         dw C3A334       ; EMPTY
C3A2AE:  dw C3A2CC       ; Head
         dw C3A2D3       ; Body
         dw C3A2DA       ; Relic 1
         dw C3A2E2       ; Relic 2

; Positioned text for Equip and Relic menus
C3A2BA:  dw $7A8D : db " R-hand      ",$00
C3A2C3:  dw $7AAB : db " L-hand      ",$00
C3A2CC:  dw $7B0D : db " Head        ",$00
C3A2D3:  dw $7B2B : db " Body        ",$00
C3A2DA:  dw $7B8D : db " Relic       ",$00
C3A2E2:  dw $7BAB : db " Relic       ",$00

; Positioned text for options in Equip menu
C3A31A:  dw $789D : db "EQUIP",$00
C3A32C:  dw $78AB : db "REMOVE",$00
C3A334:  dw $78BB : db "EMPTY",$00

warnpc $C3A34D


org $C3A6AB
; Build description tilemap for Relic menu
C3A6AB:  LDX #$7849      ; Base: 7E/7849
         STX $EB         ; Set map ptr LBs
         LDA #$7E        ; Bank: 7E
         STA $ED         ; Set ptr HB
         LDY #$013C      ; Ends at 30,7
         STY $E7         ; Set row's limit
         LDY #$0104      ; Starts at 3,7
         LDX #$3500      ; Tile 256, pal 5
         STX $E0         ; Priority enabled
         JSR $A783      ; Do line 1, row 1
         LDY #$017C      ; Ends at 30,8
         STY $E7         ; Set row's limit
         LDY #$0144      ; Starts at 3,8
         LDX #$3501      ; Tile 257, pal 5
         STX $E0         ; Priority enabled
         JSR $A783      ; Do line 1, row 2
         LDY #$01BC      ; Ends at 30,9
         STY $E7         ; Set row's limit
         LDY #$0184      ; Starts at 3,9
         LDX #$3538      ; Tile 312, pal 5
         STX $E0         ; Priority enabled
         JSR $A783      ; Do line 2, row 1
         LDY #$01FC      ; Ends at 30,10
         STY $E7         ; Set row's limit
         LDY #$01C4      ; Starts at 3,10
         LDX #$3539      ; Tile 313, pal 5
         STX $E0         ; Priority enabled
         JMP $A783      ; Do line 2, row 2
         
         
org $C3F43B
         JSR C39110

         
; org $C3FBD0
; FREE SPACE



warnpc $C40000
