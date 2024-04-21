arch 65816
hirom

; King's Robes patch v1.3 by Leet Sketcher

org $C13DB7
outer_loop:
	LDY #$0008      ; space-optimize these bit reversals into a loop
    LDA $03C0,X
    STA $10         ; one instruction replaces one
    LDA $10C0,X
inner_loop:
    ASL $10         ; four instructions replace four
    ROR $03C0,X
    ASL A
    ROR $10C0,X
	DEY
	BNE inner_loop
    INX
    DEC $12
    BNE outer_loop
    PLB
    PLX
    PLA
    ASL A
    ASL A
    ASL A
    ASL A
    ASL A
    PHX
    TAX
    LDA $2EAE,X     ; get sprite ID
	CMP #$04        ; if it's Edgar's sprite...
	BEQ tentacles   ; ...check if we're battling the Tentacles
    CMP #$0E        ; if it's a soldier sprite...
    BNE normal_pal  ; ...check if Locke's wearing a uniform
    LDA $2EC6,X     ; character ID
    DEC A           ; one for one
    BNE normal_pal  ; branch if actual character isn't Locke
    LDA $1EA0
    AND #$08        ; "Locke wearing a soldier uniform" event bit check
    BEQ normal_pal
tentacles:
	LDA $ECB8
	CMP #$37        ; check if battle background ID is Tentacles
	BEQ zero_pal    ; if so, Carry will be set
	CLC             ; if not, Carry will be cleared
zero_pal:
    PLX
    TDC
	ROL A           ; load palette 1 iff it's Edgar during Tentacles battle
    BRA continue

padbyte $EA : pad $C13E1F

org $C13E1F
normal_pal:
    PLX
    LDA $C2CE2B,X
continue:


; Moving Mog tutorial from South Figaro (relics) to Gogo's room (commands customization)

org $CA790E
  db $FD,$FD,$FD,$FD                        ; Deactivate the cutscene 

org $CB52F3
  db $B2,$C1,$C5,$00,$B2,$F6,$D2,$02,$FE	; New subroutine
  
org $CB823F 
  db $B2,$F3,$52,$01            			; Call new subroutine

org $CCD31D
  db $4B,$40,$0A                			; Display [caption #2623]:
                                            ; <A12> can do much more than just [Mimic].<D>
                                            ; Customize their command list on the status page.
org $CCD321
  db $6A,$16,$21,$08,$06                    ; Change Map: Gogo's room at (8,6);
  
; clears invisible Red-D
; Note: This works only for Red-D because there's a second event bit $0E3
; that's used for tracking its statue state

org $CC204B
    db $DD,$9C                  ; clear event bit $69C
    db $B2,$25,$51,$01          ; call subroutine $CB5125
    db $FD,$FD                  ; clear redundant hide command
warnpc $CC2053

; -----------------------------------------------------------------------------
; Extends the scene with the Returners before the Lete River segment:
; - (Locke leaves the screen in the wrong direction)
; - Edgar: "Uh, Locke…"
; - Locke: "Right."
; - (Locke reappears, walks across the room and leaves in the right direction)
; - Sabin: "What do you see in that guy?"
;
; The event script has to be edited in two places since are two slighty
; different scenes playing out depending on if Terra answered "Yes" or three
; times "No" when asked by Banon. All edits are inline, that is, they do not
; require additional freespace.
; -----------------------------------------------------------------------------

; Scene A: Terra answers three times with "No"
org $CAFF3E
    db $01,$85,$C2,$CD,$A1,$92  ; action queue for Locke
    db $FF                      ; ^ continued
    db $92                      ; wait for 30 frames (1/2 second)
    db $04,$82,$CD,$FF          ; action queue for Edgar
    db $4B,$6B,$01              ; display caption $16B (#362)
    db $4B,$6C,$01              ; display caption $16C (#363)
    db $04,$02,$CC,$FF          ; action queue for Edgar
    db $00,$02,$CC,$FF          ; action queue for Terra
    db $01,$86,$94,$8B,$A2,$A2  ; action queue for Locke
    db $8E,$FF                  ; ^ continued
    db $94                      ; wait for 60 frames (1 second)
    db $4B,$6D,$01              ; display caption $16D (#364)
    db $94                      ; wait for 60 frames (1 second)
    db $04,$82,$80,$FF          ; action queue for Edgar
padbyte $FD : pad $CAFF79

; Scene B: Terra answers with "Yes"
org $CB0343
    db $01,$83,$C2,$92,$FF      ; action queue for Locke
    db $92                      ; wait for 30 frames (1/2 second)
    db $04,$82,$CD,$FF          ; action queue for Edgar
    db $4B,$6B,$01              ; display caption $16B (#362)
    db $4B,$6C,$01              ; display caption $16C (#363)
    db $04,$02,$CC,$FF          ; action queue for Edgar
    db $00,$02,$CC,$FF          ; action queue for Terra
    db $01,$86,$90,$8B,$A2,$A2  ; action queue for Locke
    db $8E,$FF                  ; ^ continued
    db $94                      ; wait for 60 frames (1 second)
    db $4B,$6D,$01              ; display caption $16D (#364)
    db $94                      ; wait for 60 frames (1 second)
    db $04,$82,$80,$FF          ; action queue for Edgar
padbyte $FD : pad $CB037E

; -----------------------------------------------------------------------------
; By default, Shadow and Relm behave slightly differently after being rescued
; from the Cave on the Veldt and taken back to Thamasa. Shadow will leave as
; soon as the player exits Thamasa. Relm, however, will only leave after the
; player exits town, re-enters Strago's house, and exits town again. This hack
; changes Relm's behavior to match Shadow's.
;
; The space required to make this edit inline comes from the fact that there's
; a redundant event command at CB7B27.
;
; CB7B21: C0 A3 80 E3 7B 01     ; if $0A3==On (Shadow Died) jump to CB7BE3 else continue
; CB7B27: DA 56                 ; set event bit $556 (Thamasa: Shadow in bed)
;
; This event command is redundant due to an earlier call to CB7A0C.
;
; CB7AA3: B2 0C 7A 01           ; call subroutine CB7A0C
;
; CB7A0C: C0 A3 80 15 7A 01     ; if $0A3==On (Shadow Died) jump to CB7A15 else continue
; CB7A12: DA 56                 ; set event bit $556 (Thamasa: Shadow in bed)
; CB7A14: FE                    ; return
; CB7A15: DA 66                 ; set event bit $566 (Thamasa: Relm in bed)
; CB7A17: FE                    ; return
; -----------------------------------------------------------------------------

; set event bit that makes character leave as soon as player exits Thamasa for
; both Relm and Shadow
org $CB7B21
    db $D2,$9E                  ; set event bit $19E (Shadow/Relm leaves immediately)
    db $C0,$A3,$80,$E3,$7B,$01  ; if $0A3==On (Shadow Died) jump to CB7BE3 else continue

; clear event command that sets $19E inside Shadow-exclusive branch
org $CB7BDA : db $FD,$FD        ; replace with NOPs

; remove Relm's initial response ("…") to mirror Shadow's behavior by changing
; the event address of her NPC to CB7D24 (formerly CB7D1C)
org $C45F7C : db $24            ; set event address to CB7D24

; clear event script that's now unreachable because event address was changed
org $CB7D1C : padbyte $FE : pad $CB7D24

; clear event script for Relm's initial response ("…")
org $CB7D58 : padbyte $FE : pad $CB7D5C

; -----------------------------------------------------------------------------
; Pulling the lever on the Phantom Train to detach the rear wagons now
; automatically opens the wall that blocks the way forward.
; -----------------------------------------------------------------------------

; disable secondary lever effect
org $CBB64B
    db $C0,$83,$81,$B3,$5E,$00  ; if $183==On return else continue

; hook into event script of primary lever effect
org $CBB659
    db $B2,$C7,$B7,$01          ; call subroutine $CBB7C7

; animation for wall opening up (uses space occupied by secondary lever effect)
org $CBB7C7
    db $B2,$C3,$6A,$01          ; [displaced] call subroutine $CB6AC3 (pull lever)
    db $73,$1C,$03,$01,$01,$2E  ; replace current map's Layer 1 at ($1C, $03)
    db $B2,$CD,$6A,$01          ; call subroutine $CB6ACD
    db $73,$1A,$05,$01,$04,$97  ; replace current map's Layer 1 at ($1A, $05)
    db $97,$41,$41              ; ^ continued
    db $58,$F8                  ; shake the screen
    db $D2,$7F                  ; set event bit $17F (path is cleared)
    db $FE                      ; return

; used to calculate relative offsets for jumps and subroutine calls
org $CA0000 : EventBase:

; points to a large chunk of freespace (before Treasure Data)
org $ED8BFC : EventScriptFreespace_0:

; -----------------------------------------------------------------------------
; This hacks ports a QoL feature from the Pixel Remaster to BNW. During the
; sequence before the Imperial banquet where you have to talk to a bunch of
; soldiers the player has now the opportunity to skip ahead to the banquet if
; so desired. Attempting to use one of the two doors behind the throne will
; open a dialog box with the choice to continue or skip ahead to the banquet.
; -----------------------------------------------------------------------------

; slice into event script of left door
org $CC85E3
    db $C0,$27,$01              ; always jump to target
    dl LeftDoor-EventBase       ; ^ continued
padbyte $FE : pad $CC85EB

; slice into event script of right door
org $CC860D
    db $C0,$27,$01              ; always jump to target
    dl RightDoor-EventBase      ; ^ continued
padbyte $FE : pad $CC8615

org $CC8A96 : Banquet:          ; entry point when timer expires

; new event code that gives the player the option to skip directly to the
; banquet during the "talk to the soldiers" segment
org EventScriptFreespace_0
LeftDoor:
    db $C1,$3C,$81,$F0,$81,$B3  ; [displaced] if $13C==On || $1F0==On return else
    db $5E,$00                  ; [displaced] ^ continue
    db $C0,$7C,$00,$EB,$85,$02  ; if $07C==Off jump to $CC85EB else continue
    db $C0,$27,$01              ; always jump to target
    dl Choice-EventBase         ; ^ continued
RightDoor:
    db $C1,$3C,$81,$F1,$81,$B3  ; [displaced] if $13C==On || $1F1==On return else
    db $5E,$00                  ; [displaced] ^ continue
    db $C0,$7C,$00,$15,$86,$02  ; if $07C==Off jump to $CC8615 else continue
    db $C0,$27,$01              ; always jump to target
    dl Choice-EventBase         ; ^ continued
Choice:
    db $4B,$DD,$06              ; display caption $06DD
    db $B6                      ; jump based on choice
    dl StepBack-EventBase       ; ^ continued
    dl Banquet-EventBase        ; ^ continued
    db $FE                      ; return
StepBack:
    db $31,$82,$82,$FF          ; action queue for player character
    db $FE                      ; return
EventScriptFreespace_1:

; ----------------------------------------------------------------------------
; This hack implements a new event command $9E that allows opening the main
; menu as part of the event script. This new feature is used at various points
; in the game, namely
; - before Cranes battle
; - before first IAF battle
; - before Tentacles battle
; - before Phunbaba 3 battle
; - before Wrexsoul battle
; to give players the opportunity to equip newly joined party members instead
; of having them join auto-equipped.
; ----------------------------------------------------------------------------

!free = $C0DCC7     ; requires 9 bytes in C0
!warn #= !free+9    ; provides 9 bytes

; update event command jump table
org $C09996 : dw OpenMainMenu

; implement new event command $9E that opens main menu
org !free
OpenMainMenu:       ; [9 bytes]
    STZ $0200       ; set menu type ($00 = main menu)
    STZ $0201       ; disable Warp
    JMP $B0A1       ; reuse code from event command $9D (final battle party select)
warnpc !warn

; slice into event before Cranes battle
org $CB40E1
    db $B2                      ; jump to new event code
    dl Cranes-EventBase         ; ^ continued
warnpc $CB40E5

; insert main menu loop before IAF sequence
org $CA5840
    db $B2                      ; jump to new event code
    dl MainMenu-EventBase       ; ^ continued
    db $F0,$1A                  ; play song $1A
    db $D2,$CC                  ; set event bit $1CC = Song Override
    db $39                      ; unlock screen (scroll when character moves)
warnpc $CA584A : padbyte $FD : pad $CA584A

; slice into event before Tentacles battle
org $CA6AE4
    db $B2                      ; jump to new event code
    dl Tentacles-EventBase      ; ^ continued
warnpc $CA6AE8

; make some adjustments to event script after Tentacles battle to compensate
; for the fact that the map had to be reloaded
org $CA6B3B
    db $3D,$1B                  ; create NPC 11
    db $3D,$1C                  ; create NPC 12
    db $3D,$1D                  ; create NPC 13
    db $3D,$1E                  ; create NPC 14
    db $45                      ; update objects
    db $1B,$07,$D5,$1D,$05,$D0  ; action queue for NPC 11
    db $9A,$CF,$FF              ; ^ continued
    db $91                      ; wait for 15 frames (1/4 second)
    db $1C,$07,$D5,$1D,$05,$D0  ; action queue for NPC 12
    db $96,$CD,$FF              ; ^ continued
    db $91                      ; wait for 15 frames (1/4 second)
    db $1D,$06,$D5,$1D,$05,$D0  ; action queue for NPC 13
    db $92,$FF                  ; ^ continued
    db $91                      ; wait for 15 frames (1/4 second)
    db $1E,$87,$D5,$1D,$05,$D0  ; action queue for NPC 14
    db $8E,$CC,$FF              ; ^ continued
warnpc $CA6B6E : padbyte $FD : pad $CA6B6E

; remove Terra's auto-equip before Phunbaba 3 battle
org $CC4CD6 : db $FD,$FD        ; replace event command with NOPs

; slice into event before Phunbaba 3 battle
org $CC4CE8
    db $B2                      ; jump to new event code
    dl BeforePhunbaba-EventBase ; ^ continued
warnpc $CC4CEC

; set correct battle background for Phunbaba 3 battle since battle is invoked
; from another map
org $CC4CEE : db $05            ; set battle bg $05 = Field (WoR)

; slice into event after Phunbaba 3 battle
org $CC4CEF
    db $B2                      ; jump to new event code
    dl AfterPhunbaba-EventBase  ; ^ continued
warnpc $CC4CF3

; slice into event before Wrexsoul battle
org $CB97EA
    db $B2                      ; jump to new event code
    dl Wrexsoul-EventBase       ; ^ continued
    db $4D,$5C,$1A              ; Battle Enemy Set $5C, Background Scenery $1A
    db $F0,$00                  ; play song $00 = Silence
    db $B2,$A9,$5E,$00          ; call subroutine $CA5EA9 (post-battle)
    db $D2,$CC                  ; set event bit $1CC = Song Override
    db $DB,$48                  ; clear event bit $548
    db $6B,$7E,$20,$19,$0D,$C0  ; load map $207E = Doma Castle: Interior (Cyan's Dream)
warnpc $CB9802 : padbyte $FD : pad $CB9802

org EventScriptFreespace_1
MainMenu:
    db $F2,$10                  ; fade out current song with speed $10
    db $6B,$03,$04,$08,$10,$40  ; load map $0403 = Empty Map
    db $96,$5C                  ; fade screen back in (wait until complete)
    db $4B,$68,$0A              ; display caption $A68 (#2663)
.open
    db $9E                      ; open main menu (custom event command)
    db $96,$5C                  ; fade screen back in (wait until complete)
    db $4B,$69,$0A              ; display caption $A69 (#2664)
    db $B6                      ; jump based on choice
    dl .exit-EventBase          ; ^ continued
    dl .open-EventBase          ; ^ continued
.exit
    db $FE                      ; return

Cranes:
    db $B2                      ; run main menu loop
    dl MainMenu-EventBase       ; ^ continued
    db $FE                      ; return

Tentacles:
    db $B2                      ; run main menu loop
    dl MainMenu-EventBase       ; ^ continued
    db $C0,$8A,$02              ; if $28A==Off jump to target else continue
    dl .no_sabin-EventBase      ; ^ continue
    db $4D,$54,$37              ; Battle Enemy Set $54, Background Scenery $37
    db $C0,$27,$01              ; always jump to target
    dl .continue-EventBase      ; ^ continue
.no_sabin
    db $4D,$53,$37              ; Battle Enemy Set $53, Background Scenery $37
.continue
    db $D7,$F0                  ; clear event bit $3F0 = Tentacles (Engine Room)
    db $D7,$F2                  ; clear event bit $3F2 = Bandits (Engine Room)
    db $6B,$40,$00,$1D,$0B,$40  ; load map = Figaro Castle: Engine Room
    db $1A,$05,$D5,$1D,$0B,$24  ; action queue NPC 10 (Gerad)
    db $FF                      ; ^ continued
    db $31,$86,$D5,$1D,$0F,$C8  ; action queue for Party Character #1
    db $03,$FF                  ; ^ continued
    db $FE                      ; return

BeforePhunbaba:
    db $B8,$39                  ; [displaced] set bit $1E02
    db $B8,$3A                  ; [displaced] set bit $1E03
    ; db $37,$00,$0F              ; assign graphic set "Imp" to Terra
    db $B2                      ; run main menu loop
    dl MainMenu-EventBase       ; ^ continued
    db $FE                      ; return
AfterPhunbaba:
    db $B2,$A9,$5E,$00          ; [displaced] call subroutine $CA5EA9 (post-battle)
    ; db $37,$00,$00              ; assign graphic set "Terra" to Terra
    db $FE                      ; return

Wrexsoul:
    db $94                      ; wait for 60 frames (1 second)
    db $17,$82,$49,$FF          ; action queue for NPC 7
    db $92                      ; wait for 30 frames (1/2 second)
    db $4B,$B4,$8A              ; display caption $AB4 (#2739)
    db $17,$82,$4A,$FF          ; action queue for NPC 7
    db $92                      ; wait for 30 frames (1/2 second)
    db $4B,$B5,$8A              ; display caption $AB5 (#2740)
    db $3D,$02                  ; create Cyan
    db $3F,$02,$01              ; assign Cyan to party $01
    db $47                      ; make character in slot 0 the lead character
    db $B2                      ; run main menu loop
    dl MainMenu-EventBase       ; ^ continued
    db $FE                      ; return
EventScriptFreespace_2:

; -----------------------------------------------------------------------------
; Adds a short tutorial for Mog's new "choreography" dance mechanics at the end
; of the initial recruitment event (either WoB or WoR). The tutorial is a copy
; of the relics tutorial with new dialog.
; -----------------------------------------------------------------------------

; slice into event script of Mog's recruitment in WoB
org $CCD6D6
    db $DD,$40                  ; clear event bit $640 = Lone Wolf/Mog (Cliffs)
    db $DD,$41                  ; clear event bit $641 = Blocked Bridge (Cliffs)
    db $B2                      ; run subroutine with new event code
    dl RecruitMogWoB-EventBase  ; ^ continued
    db $D3,$CC                  ; clear event bit $1CC = Song Override
    db $D4,$9F                  ; set event bit $29F = Named Mog
    db $FE                      ; return
warnpc $CCD6E3

; slice into event script of Mog's recruitment in WoR
org $CC3AE8 
    db $DD,$8D                  ; clear event bit $68D = Narshe: Mog (WoR)
    db $B2                      ; run subroutine with new event code
    dl RecruitMogWoR-EventBase  ; ^ continued
    db $D3,$CC                  ; clear event bit $1CC = Song Override
    db $FE                      ; return
warnpc $CC3AF8 : padbyte $FE : pad $CC3AF8

; new event code
org EventScriptFreespace_2
RecruitMogWoB:
    db $B2                      ; run subroutine for Mog's tutorial
    dl MogTutorial-EventBase    ; ^ continued
    db $6A,$17,$00,$0A,$11,$40  ; loads map $0017 = Narshe: Cliffs (WoB)
    db $47                      ; make character in slot 0 the lead character
    db $96                      ; fade screen back in
    db $5C                      ; wait for screen fade to complete
    db $FE                      ; return

RecruitMogWoR:
    db $B2                      ; run subroutine for Mog's tutorial
    dl MogTutorial-EventBase    ; ^ continued
    db $6A,$2C,$20,$79,$2F,$40  ; loads map $202C = Narshe: Moogle Cave (WoR)
    db $47                      ; make character in slot 0 the lead character
    db $96                      ; fade screen back in
    db $5C                      ; wait for screen fade to complete
    db $FE                      ; return

MogTutorial:
    db $6A,$05,$30,$08,$07,$40  ; loads map $3005 = Empty (Mog Narration)
    db $42,$31                  ; hide Party Character #1
    db $45                      ; update objects
    db $3D,$10                  ; create NPC 0
    db $10,$84,$D5,$10,$07,$FF  ; action queue for NPC 0
    db $41,$10                  ; show NPC 0
    db $45                      ; update objects
    db $96                      ; fade screen back in
    db $5C                      ; wait for screen fade to complete
    db $10,$84,$C3,$9F,$CE,$FF  ; action queue for NPC 0
    db $92                      ; wait for 30 frames (1/2 second)
    db $10,$85,$20,$E0,$03,$CE  ; action queue for NPC 0
    db $FF                      ; ^ continued
    db $92                      ; wait for 30 frames (1/2 second)
    db $4B,$79,$02              ; display caption $279 (632)
    db $4B,$7A,$02              ; display caption $27A (633)
    db $92                      ; wait for 30 frames (1/2 second)
    db $FE                      ; return
EventScriptFreespace_3:

; -----------------------------------------------------------------------------
; Visiting Duncan in WoR to complete Sabin's training now unlocks all of his
; blitzes instead of only Bum Rush (similar to how Cyan unlocks all Bushido
; skills). For balancing reasons, completing Sabin's training is now gated
; behind Doom Gaze's defeat.
;
; This means there are now three different scenes that can play out:
; 1. you meet Duncan and he assigns you the task of defeating Doom Gaze,
; 2. you return after completing it, or alternatively
; 3. you meet Duncan with Doom Gaze already defeated
; -----------------------------------------------------------------------------

; modify event command $90 to unlock all of Sabin's blitzes
org $C0B005 : ORA #$FF

; change event address for event tile outside Duncan's cabin
org $C409C5 : dl Duncan_Start-EventBase

; hook into event script for talking to Duncan inside the cabin
org $CC0F55
    db $B2
    dl Duncan_Inside-EventBase
warnpc $CC0F59

; refactor beginning of original event script into subroutines to avoid the
; need for event code duplication
org $CC0BD8
Duncan_A:                       ; [CC/0BE7-CC/0C24]
    db $F2,$40                  ; fade out current song with speed $40
    db $3D,$10                  ; create NPC 0
    db $45                      ; update objects
    db $F4,$2C                  ; play sound effect $2C
    db $73,$07,$08,$01,$02,$04  ; replace current map's Layer 1 at ($07, $08)
    db $14                      ; ^ continued
    db $41,$10                  ; show NPC 0
    db $78,$10                  ; enable passability for NPC 0
    db $10,$83,$C2,$86,$FF      ; action queue for NPC 0
    db $92                      ; wait for 30 frames (1/2 second)
    db $B2,$AC,$C6,$00          ; call subroutine $CAC6AC (create 1-person party)
    db $B2,$34,$2E,$01          ; call subroutine $CB2E34 (enable passability of party)
    db $3C,$05,$FF,$FF,$FF      ; set up party as follows: $05, $FF, $FF, $FF
    db $32,$04,$C3,$A8,$CC,$FF  ; action queue for Party Character #2
    db $33,$04,$C3,$86,$CC,$FF  ; action queue for Party Character #3
    db $34,$04,$C3,$A7,$CC,$FF  ; action queue for Party Character #4
    db $05,$87,$C3,$CC,$C7,$86  ; action queue for Sabin
    db $C6,$80,$FF              ; ^ continued
    db $FE                      ; return

Duncan_B:                       ; [CC/0C25-CC/0C30]
    db $4B,$E4,$05              ; display caption $05E4 (halt execution until gone)
    db $10,$82,$1F,$FF          ; action queue for NPC 0
    db $94                      ; wait for 60 frames (1 second)
    db $10,$82,$CE,$FF          ; action queue for NPC 0
    db $FE                      ; return

Duncan_C:                       ; [CC/0C31-CC/0C3E]
    db $92                      ; wait for 30 frames (1/2 second)
    db $10,$03,$A2,$CD,$FF      ; action queue for NPC 0
    db $05,$86,$C3,$80,$CF,$E0  ; action queue for Sabin
    db $08,$FF                  ; ^ continued
    db $FE                      ; return

Duncan_D:                       ; [CC/0C3F-CC/0C90]
    db $B5,$06                  ; pause for 6/4 second(s)
    db $B0,$08                  ; start repeat (8 repetitions)
    db $10,$82,$5D,$FF          ; action queue for NPC 0
    db $B4,$02                  ; pause for 2/60 second(s)
    db $10,$82,$5E,$FF          ; action queue for NPC 0
    db $B4,$02                  ; pause for 2/60 second(s)
    db $B1                      ; end repeat
    db $10,$82,$CD,$FF          ; action queue for NPC 0
    db $4B,$E5,$05              ; display caption $05E5 (halt execution until gone)
    db $92                      ; wait for 30 frames (1/2 second)
    db $05,$82,$22,$FF          ; action queue for Sabin
    db $B5,$06                  ; pause for 6/4 second(s)
    db $4B,$E6,$05              ; display caption $05E6 (halt execution until gone)
    db $94                      ; wait for 60 frames (1 second)
    db $F4,$6A                  ; play sound effect $6A
    db $10,$89,$C2,$C8,$02,$C7  ; action queue for NPC 0
    db $1F,$DC,$A1,$CC,$FF      ; ^ continued
    db $92                      ; wait for 30 frames (1/2 second)
    db $F4,$6A                  ; play sound effect $6A
    db $10,$85,$1E,$DC,$A0,$CF  ; action queue for NPC 0
    db $FF                      ; ^ continued
    db $92                      ; wait for 30 frames (1/2 second)
    db $F4,$6A                  ; play sound effect $6A
    db $10,$85,$14,$DC,$A2,$CC  ; action queue for NPC 0
    db $FF                      ; ^ continued
    db $92                      ; wait for 30 frames (1/2 second)
    db $F4,$6A                  ; play sound effect $6A
    db $10,$85,$16,$DC,$A3,$CD  ; action queue for NPC 0
    db $FF                      ; ^ continued
    db $92                      ; wait for 30 frames (1/2 second)
    db $4B,$E7,$05              ; display caption $05E7 (halt execution until gone)
    db $FE                      ; return

Duncan_E:                       ; [CC/0C91-CC/0CB7]
    db $94                      ; wait for 60 frames (1 second)
    db $10,$82,$CE,$FF          ; action queue for NPC 0
    db $92                      ; wait for 30 frames (1/2 second)
    db $10,$82,$09,$FF          ; action queue for NPC 0
    db $91                      ; wait for 15 frames (1/4 second)
    db $F4,$6A                  ; play sound effect $6A
    db $10,$8B,$16,$C4,$8C,$C3  ; action queue for NPC 0
    db $80,$E0,$02,$C2,$82,$09  ; ^ continued
    db $FF                      ; ^ continued
    db $92                      ; wait for 30 frames (1/2 second)
    db $05,$82,$CC,$FF          ; action queue for Sabin
    db $10,$86,$16,$C2,$DC,$A0  ; action queue for NPC 0
    db $CE,$FF                  ; ^ continued
    db $FE                      ; return

Duncan_F:                       ; [CC/0CB8-CC/0CCF]
    db $92                      ; wait for 30 frames (1/2 second)
    db $B0,$08                  ; start repeat (8 repetitions)
    db $10,$82,$5D,$FF          ; action queue for NPC 0
    db $B4,$02                  ; pause for 2/60 second(s)
    db $10,$82,$5E,$FF          ; action queue for NPC 0
    db $B4,$02                  ; pause for 2/60 second(s)
    db $B1                      ; end repeat
    db $10,$82,$CE,$FF          ; action queue for NPC 0
    db $92                      ; wait for 30 frames (1/2 second)
    db $4B,$E8,$85              ; display caption $85E8 (halt execution until gone)
    db $FE                      ; return

Duncan_G:                       ; [CC/0CD2-CC/0CDE]
    db $94                      ; wait for 60 frames (1 second)
    db $10,$82,$18,$FF          ; action queue for NPC 0
    db $95                      ; wait for 120 frames (2 seconds)
    db $05,$85,$21,$E0,$04,$CC  ; action queue for Sabin
    db $FF                      ; ^ continued
    db $FE                      ; return

warnpc $CC0CDF : padbyte $FD : pad $CC0CDF
Duncan_Fight:

; refactor end of original event script into a subroutine to avoid the need for
; event code duplication
org $CC0F06
    db $B2                      ; call subroutine
    dl Duncan_End-EventBase     ; ^ continued
    db $F0,$23                  ; play song $23
    db $D4,$AF                  ; set event bit $2AF
    db $90                      ; Grant Sabin the Bum Rush
    db $FE                      ; return

Duncan_End:                     ; [CC/0F06-CC/0F22]
    db $5A,$04                  ; fade out screen with speed $04
    db $5C                      ; wait for screen fade to complete
    db $05,$84,$C8,$00,$C6,$FF  ; action queue for Sabin
    db $B2,$95,$CB,$00          ; call subroutine $CACB95 (hide party members 2-4)
    db $3B                      ; disable user control
    db $B2,$2B,$2E,$01          ; call subroutine $CB2E2B (disable passability of party)
    db $39                      ; unlock screen (scroll when character moves)
    db $42,$10                  ; hide NPC 0
    db $31,$83,$C2,$82,$FF      ; action queue for Party Character #1
    db $59,$04                  ; fade in screen with speed $04
    db $5C                      ; wait for screen fade to complete
    db $FE                      ; return

warnpc $CC0F2E : padbyte $FD : pad $CC0F2E

; new entry point for event tile outside Duncan's cabin
org EventScriptFreespace_3
Duncan_Start:
    db $DE                      ; set control switches: Current Party Characters
    db $C0,$A5,$01,$B3,$5E,$00  ; if $1A5==Off (Sabin's missing) return else continue
    db $C0,$AF,$82,$B3,$5E,$00  ; if $2AF==On (Learned Bum Rush) return else continue
    db $C9,$BF,$86,$E2,$00,$B3  ; if $6BF==On (Met Duncan) && $0E2==Off (Doom Gaze lives)
    db $5E,$00                  ; return else continue
    db $B2                      ; call subroutine
    dl Duncan_A-EventBase       ; ^ continued
    db $C1,$BF,$06,$E2,$00      ; jump if $6BF==Off (Haven't Met Duncan) ||
    dl .skip1-EventBase         ; $0E2==Off (Doom Gaze lives) else continue
    db $B2                      ; call subroutine
    dl Duncan_Jump-EventBase    ; ^ continued
    db $C0,$27,$01              ; always jump to target
    dl .skip4-EventBase
.skip1
    db $C0,$BF,$86              ; jump if $6BF==On (Sabin Met Duncan) else continue
    dl .skip2-EventBase         ; ^ continued
    db $B2                      ; call subroutine
    dl Duncan_B-EventBase       ; ^ continued
.skip2
    db $B2                      ; call subroutine
    dl Duncan_C-EventBase       ; ^ continued
    db $C0,$BF,$86              ; jump if $6BF==On (Sabin Met Duncan) else continue
    dl .skip3-EventBase         ; ^ continued
    db $B2                      ; call subroutine
    dl Duncan_D-EventBase       ; ^ continued
.skip3
    db $10,$83,$C8,$02,$FF      ; action queue for NPC 0
    db $B2                      ; call subroutine
    dl Duncan_E-EventBase       ; ^ continued
    db $C0,$BF,$86              ; jump if $6BF==On (Sabin Met Duncan) else continue
    dl .skip4-EventBase         ; ^ continued
    db $B2                      ; call subroutine
    dl Duncan_F-EventBase       ; ^ continued
.skip4
    db $C0,$E2,$00              ; jump if $0E2==Off (Doom Gaze lives) else continue
    dl .no_music-EventBase      ; ^ continued
    db $F0,$0A                  ; play song $0A ("Edgar & Sabin")
.no_music
    db $B2                      ; call subroutine
    dl Duncan_G-EventBase       ; ^ continued
    db $DD,$B5                  ; clear event bit $6B5 (Duncan's House: Duncan A)
    db $DC,$BF                  ; set event bit $6BF (Duncan's House: Duncan B)
    db $C0,$E2,$00              ; jump if $0E2==Off (Doom Gaze lives) else continue
    dl Duncan_Task-EventBase    ; ^ continued
    db $C0,$27,$01              ; always jump to target
    dl Duncan_Fight-EventBase   ; ^ continued

Duncan_Task:
    db $4B,$00,$86              ; display caption $600 (#1536)
    db $B2                      ; call subroutine
    dl Duncan_End-EventBase     ; ^ continued
    db $F1,$23,$40              ; fade in song $23 ("Mt. Kolts") with speed $40
    db $FE

Duncan_Jump:
    db $05,$82,$80,$FF          ; action queue for Sabin
    db $92                      ; wait for 30 frames (1/2 second)
    db $10,$84,$C8,$02,$09,$FF  ; action queue for NPC 0
    db $91                      ; wait for 15 frames (1/4 second)
    db $F4,$6A                  ; play sound effect $6A
    db $10,$8B,$16,$C4,$8C,$C3  ; action queue for NPC 0
    db $80,$E0,$02,$C2,$82,$09  ; ^ continued
    db $FF                      ; ^ continued
    db $FE                      ; return

Duncan_Inside:
    db $C0,$AF,$82              ; if $2AF==On (Blitz skills mastered) jump to target
    dl .mastered-EventBase      ; ^ else continue
    db $4B,$00,$86              ; display caption $600 (#1536)
    db $91                      ; [displaced] wait for 15 frames (1/4 second)
    db $FE                      ; return
.mastered
    db $4B,$EE,$05              ; [displaced] display caption $05EE
    db $91                      ; [displaced] wait for 15 frames (1/4 second)
    db $FE                      ; return
EventScriptFreespace_4:

; -----------------------------------------------------------------------------
; This small event hack ensures that the names for Strago and Relm are
; obfuscated prior to getting their first equippable magicite.
; -----------------------------------------------------------------------------

; hook into event script that turns Ifrit and Shiva into magicite
org $CC79C5
    db $B2                      ; call subroutine
    dl ObfuscateNames-EventBase ; ^ continued
warnpc $CC79C9

; obfuscate the names of Strago and Relm
org EventScriptFreespace_4
ObfuscateNames:
    db $7F,$07,$1D              ; change Strago's name to "?????"
    db $7F,$08,$1D              ; change Relm's name to "?????"
    db $DC,$47                  ; [displaced] set event bit $647
    db $DC,$48                  ; [displaced] set event bit $648
    db $FE                      ; return
EventScriptFreespace_5:

; -----------------------------------------------------------------------------
; This small event hack ensures that Edgar is the one talking to Julian while
; receiving the Schematics.
; -----------------------------------------------------------------------------

; hook at end of regular Julian event
org $CB5223
    db $C0,$27,$01                  ; always jump to destination
    dl GetSchematics-EventBase      ; ^continued
warnpc $CB5229

org EventScriptFreespace_5
GetSchematics:                  ; 40 bytes
    db $31,$82,$C3,$FF          ; action queue for Party Character #1
    db $B2,$64,$CA,$00          ; call subroutine $CACA64 (check facing direction)
    db $BE,$02                  ; jump based on facing direction:
    dl $10CACB                  ; ^ facing right
    dl $30CAD2                  ; ^ facing left
    db $47                      ; make character in slot 0 the lead character
    db $04,$82,$CE,$FF          ; action queue for Edgar
    db $42,$31                  ; hide party leader
    db $41,$04                  ; show Edgar
    db $19,$82,$CC,$FF          ; action queue for Julian
    db $92                      ; wait for 30 frames (1/2 second)
    db $4B,$77,$06              ; display caption $0677 (halt execution until gone)
    db $42,$04                  ; hide Edgar
    db $41,$31                  ; show Party Character #1
    db $D2,$DC                  ; set event bit $1DC
    db $FE                      ; return
EventScriptFreespace_6:

warnpc $ED8E5B

; trigger Shadow's arrival when a player chooses to wait for him the second
; time at end of Floating Continent
org $CA57AF : db $BB,$57,$00

; -----------------------------------------------------------------------------
; TEMPORARILY DISABLED EDITS
; -----------------------------------------------------------------------------

;;; Sealed by... song data (overwritten song ends at $C98D84, added twelve 00 bytes)	
;;org $C98CE8
;;incbin sealed_song.bin
;;
;;; Sealed by... instruments data ($C54695 is the offset for a perfect replica of the same instruments)
;;org $C548B5
;;incbin sealed_inst.bin
;;
;;; replace "machine running" with "wind" song during cranes event
;;org $CC82C9
;;  db $39
;
;; Change the event tile at the exit to Atma's room
;
;org $C414E2
;  db $FA
;
;; Blocks an exit so Atma is a required boss
;; Atma sequence starts at $CC18B4
;
;org $CC18BE : db $B2,$FD,$52,$01   ; JSR $CB52FD
;
;; Helper for making Atma required boss in KT
;
;org $CB52FD
;  db $42,$10,$DD,$BD         ; Displaced code from originating location
;  db $D0,$E1                 ; Set event bit $1E80($0E1) [1E9C, bit 1]
;  db $FE                     ; RTS
;; $CB5304
;  db $C0,$E1,$80,$5C,$13,$02 ; If ($1E80($0E1) [$1E9C, bit 1] is set), branch to $CC135C
;  db $31,$82                 ; Open action queue for on-screen character
;  db $80,$FF                 ; Move character up 1 tile, end queue
;  db $F0,$38                 ; Play "Nighty Night"
;  db $4B,$FB,$00             ; Caption 250
;  db $F3,$10                 ; Fade in previously faded out song with trans. time 16
;  db $FE                     ; RTS

;;Mute magitek sound in Cyan's dream
;org $CB93EF
;	db $FD,$FD
;org $CB93F8
;	db $FD,$FD
;org $CB9400
;	db $FD,$FD
;org $CB9408
;	db $FD,$FD
;org $CB9410
;	db $FD,$FD
