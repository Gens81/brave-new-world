hirom

; CA, CB, CC Event Banks

; ------------------------------------------------------------------------
; Miscellaneous Notes, unconfirmed

; Space freed up:
; 7 bytes at CC/FE1A
; 27 bytes at CC/FF9C
;  20 bytes at CC/5216
; 216 bytes at CC/3434
; 18 bytes at CC/6633

; Event bits freed up:
; DB $D6,$6F     ; Set event bit $1E80($36F) [$1EF0, bit 7]
; DB $D6,$A1     ; Set event bit $1E80($3A1) [$1EF4, bit 1]

; ########################################################################
; ============================== BANK CA =================================
; ########################################################################

; ------------------------------------------------------------------------
; Add an option to the Falcon's wheel to search out Doom Gaze

org $CA00CA : db $B2,$29,$52,$01   ; JSR $CB5229

; ------------------------------------------------------------------------
; Removes the stupid hand up thing Edgar does on the airship
; Related to pre-KT Pendant events [?]

org $CA0258 : db $04,$84,$C2,$82,$CE,$FF
; If $1E80($127) [$1EA4, bit 7] is clear, branch to $EEAF50
; $127 - always clear, used to ensure branching 100% of the time
org $CA025E : db $C0,$27,$01,$50,$AF,$24

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CA03B0 : db $4B,$93,$8B

; ------------------------------------------------------------------------
; Move Gau's line up in the priority during the hammy speech before fighting Kefka

org $CA0884
  db $BE,$01,$7E,$3D,$B0  ; If Gau is in the party, JSR $CA3D7E
  db $BE,$01,$76,$3D,$90  ; If Setzer is in the party, JSR $CA3D76
  db $BE,$01,$7A,$3D,$A0  ; If Mog is in the party, JSR $CA3D7A

; ------------------------------------------------------------------------
; Give a background to caption 3037
org $CA2B99 : db $4B,$DE,$0B

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CA40AD : db $4B,$BB,$09

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CA4110 : db $4B,$BA,$09

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CA411B : db $4B,$BD,$09

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CA4126 : db $4B,$C0,$09

; ------------------------------------------------------------------------
; Alter the puzzle in Daryl's Tomb to grant Daryl's Soul as the reward
; for completion

org $CA413D : db $80,$E4,$FD ; Add Daryl's Soul to party inventory, and NOP
org $CA4142 : db $FD         ; NOPs something dealing with a removed caption display

; ------------------------------------------------------------------------
; Gau, WoR recruitment (new level averaging behavior)

org $CA4871 : db $66

; ------------------------------------------------------------------------
; Removes Pendant from the party's rare items after the Floating Continent
; Part of pre-KT Pendant events

org $CA4F40 : db $D3,$E3,$FD

; ------------------------------------------------------------------------
; Changes a caption called for Cid at the beginning of the WoR

org $CA5284 : db $4B,$86,$06    ; Call caption $0686 (1671)

; ------------------------------------------------------------------------
; Celes, WoR recruitment (new level averaging behavior)

org $CA5304 : db $66

; ------------------------------------------------------------------------
; Beginning of WoR, remove "Shock" command via event bit
; Command given via ($CAE3F1)

org $CA5334 : DB $B2,$41,$B1,$24   ; JSR $EEB141

; ------------------------------------------------------------------------
; Doubles the effectiveness of the fish used to save Cid's life

org $CA539A : db $E9,$07,$40,$00 ; Yummy fish
org $CA53A6 : db $E9,$07,$20,$00 ; Just a fish

; ------------------------------------------------------------------------
; Swap Fenrir and Palidor (1/2)

org $CA55EF : db $86,$4E ; Give Fenrir to the party (was Palidor)

; ------------------------------------------------------------------------
; Holds the player's hand like dear old grandma by needlessly restoring
; their HP after the IAF fight

org $CA5A5D : db $B2,$56,$B1,$24   ; JSR $EEB156

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CA5FAC : db $4B,$63,$0B,$FE

; ------------------------------------------------------------------------
; Skip free Autocrossbow on Edgar joining

org $CA66B4 : db $FD,$FD ; NOP NOP

; ------------------------------------------------------------------------
; Chancellor breadcrumb for schematics

; If Edgar is in the current CaseWord, call subroutine $CB5201
org $CA67F1 : db $BE,$01,$01,$52,$41

; ------------------------------------------------------------------------
; Edgar, WoR recruitment (new level averaging behavior)

org $CA6AD3 : db $66

; ------------------------------------------------------------------------
; Call an alternate tentacle pack if Sabin has not been recruited

org $CA6AE4 : db $B2,$78,$52,$01,$FD   ; JSR $CB5278, then NOP

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CA759C : db $4B,$63,$0B

; ------------------------------------------------------------------------
; Removes the odd finger wag Edgar does at Sabin's cabin

org $CA81C3 : db $FD,$FD,$FD,$FD,$FD,$FD,$FD,$FD,$FD,$FD

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CA8FB4 : db $4B,$8F,$0B

; ------------------------------------------------------------------------
; Add a line for Sabin if he's present while chasing Gerad

org $CA926C : db $B2,$A2,$52,$01   ; JSR $CB52A2

; ------------------------------------------------------------------------
; Change the black market merchant in Zozo to not call excessive captions

org $CA951D
  db $C0,$DB,$81,$2E,$95,$00 ; If lube is in rare items, branch to $CA952E
  db $4B,$27,$04             ; Call caption 1062
  db $B6,$32,$95,$00         ; If yes, branch to $CA9532
  db $B3,$5E,$00,$FE         ; Else exit, then RTS
; $CA952E
  db $4B,$26,$04,$FE         ; Call caption 1061, then RTS
; $CA9532
  db $85,$E8,$03             ; Take 1000 GP from the party
  db $C0,$BE,$81,$FF,$69,$01 ; If not enough cash, branch to $CB69FF
  db $4B,$28,$04             ; Call caption 1063
  db $D2,$DB,$FE             ; Add lube to rare items inventory, then RTS

; ------------------------------------------------------------------------
; Prevents Shadow from randomly running off (1/5)

org $CA96B7 : db $B8

; ------------------------------------------------------------------------
; Easter egg allowing a personalized comment from Shadow during the meeting with Ramuh

org $CA998B
  db $BE,$07        ; Checks the current caseword (active party membership), 7 checks
  db $EB,$AC,$10    ; If Locke is present, JSR $CAACEB
  db $F3,$AC,$30    ; If Shadow is present, JSR $CAACF3
  db $EF,$AC,$60    ; If Celes is present, JSR $CAACEF
  db $EF,$AC,$50    ; If Sabin is present, JSR $CAACEF
  db $EF,$AC,$20    ; If Cyan is present, JSR $CAACEF
  db $EF,$AC,$40    ; If Edgar is present, JSR $CAACEF
  db $F7,$AC,$B0    ; If Gau is present, JSR $CAACF7

; ------------------------------------------------------------------------
; Terra, after IMTRF (new level averaging behavior)

org $CAA6A9 : db $FD,$FD

; ------------------------------------------------------------------------
; Unequips all characters not in the party after events at Zozo.

org $CAAC86 : db $B2,$34,$B0,$24   ; JSR $EEB048

; ------------------------------------------------------------------------
; Hides the imp in the "Choose a scenario" map when a scenario is chosen.
; Hide Locke
org $CAADC9
  db $42,$16     ; Hide the imp
  db $C0,$29,$03,$B3,$5E,$00 ; Return if Locke's scenario is complete.
  db $42,$10     ; Hide Locke's sprite
  db $45,$FE     ; Refresh objects, and return

; Hide Terra, Edgar, and Banon
  db $42,$16     ; Hide the imp
  db $C0,$2B,$03,$B3,$5E,$00 ; Return if Terra's scenario is complete.
  db $42,$12     ; Hide Terra's sprite
  db $42,$13     ; Hide Edgar's sprite
  db $42,$14     ; Hide Banon's sprite
  db $45,$FE     ; Refresh objects, and return

; Hide Sabin
  db $42,$16     ; Hide the imp
  db $C0,$29,$03,$B3,$5E,$00 ; Return if Sabin's scenario is complete.
  db $42,$11     ; Hide Sabin's sprite
  db $45,$FE     ; Refresh objects, and return

; ------------------------------------------------------------------------
; After brown dragon defeated, ruin its statue and skip dragon counting

org $CAB6E2
  db $B2 : dl $0150A8 ; JSR $CB50A8
org $CAB6F3
  db $4B : dw $01DE   ; display dialogue $01DE
  db $FE              ; bypass dragon-counting routine

; ------------------------------------------------------------------------
; During Locke's conversation with Celes at the Opera House, remove a
; check that would display an extra caption if the player viewed Locke's
; flashbacks in Kohlingen. The extra caption is now displayed regardless

org $CABA8D : db $FD,$FD,$FD,$FD,$FD,$FD

; ------------------------------------------------------------------------
; Gau, after IMTRF (new level averaging behavior)

org $CAC466 : db $FD,$FD

; ------------------------------------------------------------------------
; Cyan, after IMTRF (new level averaging behavior)

org $CAC47A : db $FD,$FD

; ------------------------------------------------------------------------
; Edgar, after IMTRF (new level averaging behavior)

org $CAC48E : db $FD,$FD

; ------------------------------------------------------------------------
; Sabin, after IMTRF (new level averaging behavior)

org $CAC4A2 : db $FD,$FD

; ------------------------------------------------------------------------
; Heals the party before the fight with Nimufu

org $CADA48
  db $B2,$4A,$B1,$24   ; JSR $EEB14A
  db $FD,$FD,$FD       ; NOP NOP NOP

; ------------------------------------------------------------------------
; Add the Imperial sword to the party's inventory during the escape from
; the FC and optimize it onto Celes. Then enable Shock via event bit.
; Clear the event bit after the escape sequence (see $CA5334)

org $CAE3F1 : db $B2,$36,$B1,$24   ; JSR $EEB136

; ------------------------------------------------------------------------
; Stops the soldier on the right side of South Figaro from moving, and thus
; prevents an exploit allowing players to bypass most of Locke's scenario

; If ($1E80($127) [$1EA4, bit 7] is clear), branch to $CAEBDA
org $CAEBC7 : db $C0,$27,$01,$DA,$EB,$00

; ------------------------------------------------------------------------
; Event called when at the helm of either airship (Doom Gaze option)

; If ($1E80($170) [$1EAE, bit 0] is set), branch to $CB5230
org $CAF554 : db $C0,$70,$81,$30,$52,$01

; ------------------------------------------------------------------------
; Swap the order of the choices on the Blackjack so fly around is first

org $CAF582
  db $B6,$8D,$F5,$00
  db $17,$58,$00

; ------------------------------------------------------------------------
; Changes the order of the yes/no choices for swapping party on the airship

org $CAF5A0 : db $B6,$A8,$F5,$00,$B3,$5E,$00

; ------------------------------------------------------------------------
; Replace Genji Glove / Gauntlet gifts with Barrier Cube / Safety Glove

org $CAF975 : db $80,$B7     ; Adds a Barrier Cube to party inventory
org $CAFB0B : db $80,$B8     ; Adds a Safety Glove to party inventory
org $CAFB73 : db $80,$B8     ; Adds a Safety Glove to party inventory
org $CAFFD2 : db $80,$B7     ; Adds a Barrier Cube to party inventory

; ########################################################################
; ============================== BANK CB =================================
; ########################################################################

; ------------------------------------------------------------------------
; Optimizes Terra and Edgar during their raft trip down the Lete River with Banon

org $CB0999 : db $B2,$DB,$52,$01   ; JSR $CB52DB

; ------------------------------------------------------------------------
; Pops up Shadow's naming screen earlier in Sabin's scenario

org $CB0AA2
  db $FD,$FD,$FD,$FD   ; Make it so Sabin doesn't face the camera for no reason
org $CB0AAE
  db $C0,$0B,$01
  db $BC,$0A,$01       ; Branches to assigned Shadow caption

; ------------------------------------------------------------------------
; Violet Dies (assumes "Dead Boy" sprite converted to "Dead Girl"
org $CB12C8 : db $2D,$83 ; When pulling Violet from bed, switch to "dead" earlier

; ------------------------------------------------------------------------
; Overwrite a completely pointless 1-byte jump to flag Cyan as having
; joined the party once recruited in Sabin's scenario. This wasn't done
; in vanilla for some reason.

org $CB1641
  db $D4,$F2           ; Set event bit $1E80($2F2) [1EDE, bit 2]
  db $FD,$FD,$FD       ; NOP x3

; ------------------------------------------------------------------------
; Prevents Shadow from randomly running off (2/5)

org $CB1B03 : db $B8

; ------------------------------------------------------------------------
; Adds a line from Gau during the first meeting with Setzer on the Blackjack

org $CB1D97 : db $B2,$FC,$9A,$02   ; JSR $CC9AFC

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CB1FF9 : db $4B,$20,$05

; ------------------------------------------------------------------------
; Makes Locke look at Celes instead of Setzer during their first meeting on the Blackjack

org $CB2096
  db $01,$05  ; Open action queue for character $01 (Locke), 5 bytes long
  db $C3      ; Set movement speed to fast
  db $80      ; Move up 1 tile
  db $87      ; Move left 2 tiles
  db $63      ; Look stage right
  db $FF      ; End queue

; ------------------------------------------------------------------------
; Animate Terra when trying to take her to the Sealed Gate alone

org $CB260D : db $B2,$B2,$52,$01   ; JSR $CB52B2

; ------------------------------------------------------------------------
; Consolidates all the Sealed Cave Grand Stairway treasures into one event
; CB/30EF to CB/313F is free space now

org $CB30DB
  db $4B,$97,$06    ; Display caption 1686
  db $93            ; 45 unit pause
  db $F4,$1B        ; Sound effect
  db $4B,$7D,$06    ; Display caption 1660
  db $80,$AB        ; Add Fire Scroll to party inventory
  db $80,$AC        ; Add Water Scroll to party inventory
  db $80,$AD        ; Add Bolt Scroll to party inventory
  db $80,$43        ; Add Ninja Star to party inventory
  db $D4,$4D,$FE    ; Set event bit $24D, then return

; ------------------------------------------------------------------------
; Prevents Shadow from randomly running off (3/5)
; TODO: This is wrong, but inconsequential, since it overwrites unused
; code from the Grand Stairway above

org $CB3143 : db $B8

; ------------------------------------------------------------------------
; Move the dialogue between Kefka and the party at the Sealed Gate to before the battle

org $CB3AA8
  db $92,$B2,$AC,$38,$01  ; Pause for 30 units, then JSR $CB38AC
  db $00,$08,$20,$E0,$01
  db $CE,$E0,$01,$CC,$FF  ; Action queue for Terra - nod, then face up
  db $92,$3F,$00,$00      ; Pause, then remove Terra from the party
  db $4B,$60,$0A          ; Call caption 2655
  db $49,$F4,$CD          ; Play sound effect 205 (Kefka's laugh)
  db $B0,$06,$16,$82,$1D
  db $FF,$16,$82,$1E,$FF,$B1 ; These two lines = Kefka laughing animation
  db $4B,$61,$0A          ; Call caption 2656
  db $4B,$62,$0A          ; Call caption 2657
  db $B2,$AB,$4F,$01      ; JSR $CB4FAB
  db $FD,$FD              ; NOPs two unused bytes

org $CB3ADE : db $3F      ; Re-enables swoosh sound on transition to battle

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CB4334 : db $4B,$90,$03

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CB433C : db $4B,$90,$03

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CB450F : db $FE

; ------------------------------------------------------------------------
; As a consequence of changing the auction house to the Advanced School,
; random douchebag in front of it needs a change

org $CB453F : db $4B,$08,$04,$FE   ; Display caption 1031, then RTS

; ------------------------------------------------------------------------
; Changes a woman near Owzer's mansion to only call one caption
; 6 bytes free at $CB4596

org $CB4592 : db $4B,$0B,$04,$FE   ; Call caption 1034, then RTS

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CB45D7 : db $4B,$10,$04,$FE : db $FD,$FD,$FD,$FD,$FD,$FD

; ------------------------------------------------------------------------
; Change the items granted by the floating chests in Owzer's Mansion.

org $CB4A84 : db $84,$20,$4E  ; Gives 20000 GP to the party
org $CB4AC4 : db $80,$EA      ; Adds an X-Potion to party inventory
org $CB4B03 : db $80,$ED      ; Adds an X-Ether to party inventory
org $CB4B42 : db $80,$EE      ; Adds an Elixir to party inventory

; ------------------------------------------------------------------------
; Prevents Shadow from randomly running off (4/5)
; TODO: This code is wrong, but was previously overwritten by the floating
; chests changes above, so had no effect. Leaving here for reference, for
; now.
;
; org $CB4A85 : db $B8

; ------------------------------------------------------------------------
; Emperor Gestahl's portrait dialogue change

org $CB4B6F : db $81
org $CB4B83 : db $81

; ------------------------------------------------------------------------
; Relm, WoR recruitment (new level averaging behavior)

org $CB4E0E : db $66

; ------------------------------------------------------------------------
; Starts Relm with the dog block status in the WoR if Shadow is dead

org $CB4E25 : db $B2,$88,$52,$01 ; JSR $CB5288

; ========================================================================
; Freespace, essentially
;
; First thing's first, deprecate the auction house with $FF byte padding
; TODO: Avoid writing and overwriting the same ROM space. This free space
; TODO: should be documented but left untouched by any padding.

org $CB4E5E : padbyte $FF : pad $CB5EC5

; ------------------------------------------------------------------------
; Change Ultros in the colosseum to the respec NPC

org $CB4E5E
  db $4B,$5B,$0A             ; Display caption 2650
  db $C0,$DD,$81,$72,$4E,$01 ; If the party has the receipt, branch to $CB4E72
  db $4B,$5C,$0A             ; Display caption 2651
  db $B6,$7D,$4E,$01         ; If yes, branch to $CB4E7D
  db $23,$4F,$01,$FE         ; Else, branch to $CB4F23, then RTS
; $CB4E72
  db $4B,$5D,$0A             ; Display caption 2652
  db $B6,$8D,$4E,$01         ; If yes, branch to $CB4E8D
  db $23,$4F,$01,$FE         ; Else, branch to $CB4F23, then RTS
; $CB4E7D
  db $85,$A8,$61             ; Deduct 25k GP from the party
  db $C0,$BE,$81,$FF,$69,$01 ; If the party doesn't have enough cash, branch to CB/69FF
  db $D2,$DD                 ; Give party Receipt rare item
  db $B2,$9F,$4E,$01,$FE     ; JSR $CB4E9F, then RTS
; $CB4E8D
  db $85,$60,$EA             ; Deduct 60000 GP from the party
  db $C0,$BE,$81,$FF,$69,$01 ; If the party doesn't have enough cash, branch to CB/69FF
  db $85,$40,$9C             ; Deduct 40000 GP from the party
  db $C0,$BE,$81,$BD,$51,$01 ; If the party doesn't have enough cash, branch to CB/51BD
; $CB4E9F
  db $3B                     ; Ready-to-go stance for the on-screen character
  db $F4,$4F,$92,$F4,$4F,$92 ; Sound effect 79, like when unequipping people
  db $DE                     ; Load caseword with active party
  db $C0,$A0,$01,$B1,$4E,$01 ; If Terra is not in the party, branch to $CB4EB1
  db $8D,$00                 ; Unequip Terra
  db $67,$00                 ; Respec Terra
  db $C0,$A1,$01,$BB,$4E,$01 ; If Locke is not in the party, branch to $CB4EBB
  db $8D,$01                 ; Unequip Locke
  db $67,$01                 ; Respec Locke
  db $C0,$A2,$01,$C5,$4E,$01 ; If Cyan is not in the party, branch to $CB4EC5
  db $8D,$02                 ; Unequip Cyan
  db $67,$02                 ; Respec Cyan
  db $C0,$A3,$01,$CF,$4E,$01 ; If Shadow is not in the party, branch to $CB4ECF
  db $8D,$03                 ; Unequip Shadow
  db $67,$03                 ; Respec Shadow
  db $C0,$A4,$01,$D9,$4E,$01 ; If Edgar is not in the party, branch to $CB4ED9
  db $8D,$04                 ; Unequip Edgar
  db $67,$04                 ; Respec Edgar
  db $C0,$A5,$01,$E3,$4E,$01 ; If Sabin is not in the party, branch to $CB4EE3
  db $8D,$05                 ; Unequip Sabin
  db $67,$05                 ; Respec Sabin
  db $C0,$A6,$01,$ED,$4E,$01 ; If Celes is not in the party, branch to $CB4EED
  db $8D,$06                 ; Unequip Celes
  db $67,$06                 ; Respec Celes
  db $C0,$A7,$01,$F7,$4E,$01 ; If Strago is not in the party, branch to $CB4EF7
  db $8D,$07                 ; Unequip Strago
  db $67,$07                 ; Respec Strago
  db $C0,$A8,$01,$01,$4F,$01 ; If Relm is not in the party, branch to $CB4EF01
  db $8D,$08                 ; Unequip Relm
  db $67,$08                 ; Respec Relm
  db $C0,$A9,$01,$0B,$4F,$01 ; If Setzer is not in the party, branch to $CB4F0B
  db $8D,$09                 ; Unequip Setzer
  db $67,$09                 ; Respec Setzer
  db $C0,$AA,$01,$15,$4F,$01 ; If Mog is not in the party, branch to $CB4F15
  db $8D,$0A                 ; Unequip Mog
  db $67,$0A                 ; Respec Mog
  db $C0,$AB,$01,$1F,$4F,$01 ; If Gau is not in the party, branch to $CB4F1F
  db $8D,$0B                 ; Unequip Gau
  db $67,$0B                 ; Respec Gau
  db $4B,$5E,$0A,$FE         ; Display caption 2653, then RTS
; $CB4F23
  db $4B,$5F,$0A,$FE         ; Display caption 2654, then RTS

; ------------------------------------------------------------------------
; Colosseum guy sells Golem and Zoneseek

org $CB4F27
  db $C0,$53,$00,$54,$78,$01 ; If the party is yet to meet Ramuh, branch to $CB7854
  db $C0,$6D,$01,$3D,$4F,$01 ; If the party hasn't obtained Golem, branch to $CB4F3D
  db $C0,$6C,$01,$5A,$4F,$01 ; If the party hasn't obtained Zoneseek, branch to $CB4F5A
  db $4B,$59,$0A,$FE         ; Display caption 2648, then RTS
; $CB4F3D
  db $4B,$56,$0A             ; Display caption 2645
  db $B6,$47,$4F,$01         ; If yes, branch to $CB4F47
  db $81,$4F,$01             ; Else, branch to $CB4F81
  db $85,$10,$27             ; Deduct 10k GP from the party
  db $C0,$BE,$81,$FF,$69,$01 ; If the party doesn't have enough cash, branch to CB69FF
  db $F4,$8D                 ; Play sound effect
  db $86,$4C                 ; Give Golem to the party
  db $4B,$C3,$0A             ; Display caption 2754
  db $D2,$6D,$FE             ; Set event bit for acquiring Golem, then RTS
; $CB4F5A
  db $C0,$6B,$00,$7D,$4F,$01 ; If the party has not defeated the Cranes, branch to $CB4F7D
  db $4B,$56,$0A             ; Display caption 2645
  db $B6,$6A,$4F,$01         ; If yes, branch to $CB4F6A
  db $81,$4F,$01             ; Else, branch to $CB4F81
  db $85,$10,$27             ; Deduct 10k GP from the party
  db $C0,$BE,$81,$FF,$69,$01 ; If the party doesn't have enough cash, branch to CB/69FF
  db $F4,$8D                 ; Play sound effect
  db $86,$48                 ; Give Zoneseek to the party
  db $4B,$C4,$0A             ; Display caption 2755
  db $D2,$6C,$FE             ; Set event bit for acquiring Zoneseek, then RTS
; $CB4F7D
  db $4B,$57,$0A,$FE         ; Display caption 2646, then RTS
; $CB4F81
  db $4B,$58,$0A,$FE         ; Display caption 2647, then RTS

; Coliseum guy in the WoR (Bob)
; $CB4F85
  db $C0,$6C,$81,$58,$78,$01 ; If the party has obtained Zoneseek, branch to $CB7858
  db $C0,$6D,$01,$9C,$4F,$01 ; If the party hasn't obtained Golem, branch to $CB4F9C
  db $4B,$5A,$0A             ; Display caption 2649
  db $B6,$6A,$4F,$01         ; If yes, branch $CB4F6A
  db $A7,$4F,$01,$FE         ; Else, branch to $CB4FA5, then RTS
; $CB4F9C
  db $4B,$5A,$0A             ; Display caption 2649
  db $B6,$47,$4F,$01         ; If yes, branch $CB4F47
  db $A7,$4F,$01,$FE         ; Else, branch to $CB4FA7, then RTS
; $CB4FA7
  db $4B,$55,$0A,$FE         ; Display caption 2644, then RTS

; ------------------------------------------------------------------------
; Helper for Kefka @ Sealed Gate changes

org $CB4FAB
  db $16,$02,$80,$FF   ; Kefka steps up 1 tile
  db $4B,$63,$0A       ; Call caption 2658
  db $31,$02,$82,$FF   ; Character in slot 1 moves down 1 tile
  db $4B,$64,$0A       ; Call caption 2659
  db $92               ; Pause
  db $16,$04,$04,$C7,$82,$FF ; Kefka slides back 1 tile
  db $92,$B0,$04,$16,$84,$24
  db $E0,$01,$FF,$16,$84,$25
  db $E0,$01,$FF,$B1   ; These three lines = Kefka finger wagging animation
  db $49,$F4,$CD       ; Play sound effect 205 (Kefka's laugh)
  db $B0,$06,$16,$82,$1D
  db $FF,$16,$82,$1E,$FF,$B1 ; These two lines = Kefka laughing animation
  db $4B,$65,$0A       ; Call caption 2660
  db $40,$0F,$2A,$FE   ; Set Kefka's properties and add him to the party, then RTS

; ------------------------------------------------------------------------
; Many Kaiser and Dragon Helpers

; Kaiser's map modification - map ID 304
org $CB4FE5

; Rearranging the exit layout
  db $73,$57,$1E,$01,$04,$65,$75,$74,$71
  db $73,$4D,$1E,$01,$04,$65,$75,$75,$71
  db $73,$52,$1D,$01,$03,$65,$01,$35

; Adding the other four statue bases on L1 and ground tiles on L2
  db $73,$4D,$23,$01,$01,$6F
  db $73,$4D,$63,$01,$01,$85 ; Brown dragon statue
  db $73,$57,$23,$01,$01,$6F
  db $73,$57,$63,$01,$01,$63 ; Purple dragon statue
  db $73,$50,$20,$01,$01,$6F
  db $73,$50,$60,$01,$01,$88 ; Green dragon statue
  db $73,$54,$20,$01,$01,$6F
  db $73,$54,$60,$01,$01,$8A ; Gold dragon statue

; Check for slain dragons and remove the L2 statue tile

; CB502F
  db $C0,$87,$03,$3B,$50,$01 ; If ($1E80($387) [$1EF0, bit 7) is clear), branch to $CB503B
  db $73,$4D,$62,$01,$01,$5F ; If the brown dragon is still alive, draw the top of its statue
; CB503B
  db $C0,$9A,$82,$47,$50,$01 ; If ($1E80($29A) [$1ED3, bit 2) is set), branch to $CB5047
  db $73,$57,$62,$01,$01,$5F ; If the purple dragon is still alive, draw the top of its statue
; CB5047
  db $C0,$94,$86,$53,$50,$01 ; If ($1E80($694) [$1F52, bit 4) is set), branch to $CB5053
  db $73,$4F,$61,$01,$01,$00 ; If the white dragon has been slain, remove the top of its statue
; CB5053
  db $C0,$95,$86,$5F,$50,$01 ; If ($1E80($695) [$1F52, bit 5) is set), branch to $CB505F
  db $73,$55,$61,$01,$01,$00 ; If the silver dragon has been slain, remove the top of its statue
; CB505F
  db $C0,$E3,$00,$6B,$50,$01 ; If ($1E80($0E3) [$1E9C, bit 3) is clear), branch to $CB506B
  db $73,$50,$63,$01,$01,$00 ; If the red dragon has been slain, remove the top of its statue
; CB506B
  db $C0,$A1,$86,$77,$50,$01 ; If ($1E80($6A1) [$1F54, bit 1) is set), branch to $CB5077
  db $73,$54,$63,$01,$01,$00 ; If the blue dragon has been slain, remove the top of its statue
; CB5077
  db $C0,$B4,$06,$83,$50,$01 ; If ($1E80($6B4) [$1F56, bit 4) is clear), branch to $CB5083
  db $73,$50,$5F,$01,$01,$5F ; If the green dragon is still alive, draw the top of its statue
; CB5083
  db $C0,$B3,$06,$8F,$50,$01 ; If ($1E80($6B3) [$1F56, bit 3) is clear), branch to $CB508F
  db $73,$54,$5F,$01,$01,$5F ; If the gold dragon is still alive, draw the top of its statue
; CB508F
  db $FE

; The following handles the eventing after each dragon is defeated

; Event bits (clear if dragon was defeated)
; * Brown Dragon $387 ($1EF0, bit 7)Q 77,34 (4D,22)
; * Purple Dragon $686 ($1F50, bit 6)S 87,34 (57,22)
; * White Dragon $694 ($1F52, bit 4)Q 79,33 (4F,21)
; * Silver Dragon $695 ($1F52, bit 5)S 85,33 (55,21)
; * Red Dragon  $69C ($1F53, bit 4)Q 80,35 (50,23)
; * Blue Dragon  $6A1 ($1F54, bit 1)S 84,35 (54,23)
; * Green Dragon $6B4 ($1F56, bit 4)Q 80,31 (50,1F)
; * Gold Dragon  $6B3 ($1F56, bit 3)S 84,31 (54,1F)
;
; Fitting sound effects
; * $BB - original
; * $85 - Hidon
; * $19 - Fire 3
; * $50 - magicite breaking

; CB5090 - common event
  db $B2,$A9,$5E,$00,$42,$31 ; Displaced code from above; hide on-screen character
  db $6B,$30,$01,$52,$22,$40 ; Load map 304 (Kaiser's room)
  db $B2,$E5,$4F,$01         ; JSR $CB4FE5 - entrance event for Kaiser's room
  db $96,$5C,$94             ; Restore screen from fade; pause execution until fade-in is complete; pause for 60 units
  db $58,$F1,$F4,$50,$FE     ; Shake screen; play sound effect $50; RTS

; CB50A8 - destruction of the brown dragon's statue
  db $F2,$00                 ; Stop current song from playing
  db $B2,$90,$50,$01         ; JSR $CB5090 - common event to teleport to Kaiser's room and prep statue destruction
  db $73,$4D,$62,$01,$01,$00 ; Remove top of the brown dragon's statue
  db $93,$B2,$9F,$1F,$02     ; Pause for 45 units; calls dragon count routine
  db $F2,$2D,$93,$41,$31,$FE ; Fade out music; pause for 45 units; show on-screen character; RTS

; CB50BF - destruction of the purple dragon's statue
  db $F2,$00                 ; Stop current song from playing
  db $B2,$90,$50,$01         ; JSR $CB5090 - common event to teleport to Kaiser's room and prep statue destruction
  db $73,$57,$62,$01,$01,$00 ; Remove top of the purple dragon's statue
  db $93,$B2,$9F,$1F,$02,$93 ; Pause for 45 units; calls dragon count routine
  db $F2,$2D,$93             ; Fade out music; pause for 45 units
  db $6B,$B3,$20,$29,$0F,$C0 ; Return to originating map at estimated position the player initiated combat against the dragon
  db $B2,$85,$43,$02         ; Run entrance event for return map
  db $41,$31,$FE             ; Show on-screen character; RTS

; CB50E1 - destruction of the white dragon's statue
  db $F2,$00                 ; Stop current song from playing
  db $B2,$90,$50,$01         ; JSR $CB5090 - common event to teleport to Kaiser's room and prep statue destruction
  db $73,$4F,$61,$01,$01,$00 ; Remove top of the white dragon's statue
  db $93,$B2,$9F,$1F,$02,$93 ; Pause for 45 units; calls dragon count routine
  db $F2,$2D,$93             ; Fade out music; pause for 45 units
  db $6B,$70,$21,$07,$08,$C0 ; Return to originating map at estimated position the player initiated combat against the dragon
  db $B2,$A3,$55,$02         ; Run entrance event for return map
  db $41,$31,$FE             ; Show on-screen character; RTS

; CB5103 - destruction of the silver dragon's statue
  db $F2,$00                 ; Stop current song from playing
  db $B2,$90,$50,$01         ; JSR $CB5090 - common event to teleport to Kaiser's room and prep statue destruction
  db $73,$55,$61,$01,$01,$00 ; Remove top of the silver dragon's statue
  db $93,$B2,$9F,$1F,$02,$93 ; Pause for 45 units; calls dragon count routine
  db $F2,$2D,$93             ; Fade out music; pause for 45 units
  db $6B,$22,$20,$16,$10,$C0 ; Return to originating map at estimated position the player initiated combat against the dragon
  db $B2,$DC,$36,$02         ; Run entrance event for return map
  db $41,$31,$FE             ; Show on-screen character; RTS

; CB5125 - destruction of the red dragon's statue
  db $F2,$00                 ; Stop current song from playing
  db $B2,$90,$50,$01         ; JSR $CB5090 - common event to teleport to Kaiser's room and prep statue destruction
  db $73,$50,$63,$01,$01,$00 ; Remove top of the red dragon's statue
  db $93,$B2,$9F,$1F,$02,$93 ; Pause for 45 units; calls dragon count routine
  db $F2,$2D,$93             ; Fade out music; pause for 45 units
  db $D0,$E3                 ; Set event bit $1E80($0E3) [1E9C, bit 3]
  db $6B,$3B,$21,$14,$2C,$C0 ; Return to originating map at estimated position the player initiated combat against the dragon
  db $B2,$3C,$24,$02         ; Run entrance event for return map
  db $41,$31,$FE             ; Show on-screen character; RTS

; CB5149 - destruction of the blue dragon's statue
  db $F2,$00                 ; Stop current song from playing
  db $B2,$90,$50,$01         ; JSR $CB5090 - common event to teleport to Kaiser's room and prep statue destruction
  db $73,$54,$63,$01,$01,$00 ; Remove top of the blue dragon's statue
  db $93,$B2,$9F,$1F,$02,$93 ; Pause for 45 units; calls dragon count routine
  db $F2,$2D,$93             ; Fade out music; pause for 45 units
  db $6B,$98,$21,$34,$2D,$C0 ; Return to originating map at estimated position the player initiated combat against the dragon
  db $B2,$FD,$19,$02         ; Run entrance event for return map
  db $41,$31,$FE             ; Show on-screen character; RTS

; CB516B - destruction of the green dragon's statue
  db $B2,$90,$50,$01         ; JSR $CB5090 - common event to teleport to Kaiser's room and prep statue destruction
  db $73,$50,$5F,$01,$01,$00 ; Remove top of the green dragon's statue
  db $93,$B2,$9F,$1F,$02,$93 ; Pause for 45 units; calls dragon count routine
  db $6B,$62,$21,$52,$22,$C0 ; Return to originating map at estimated position the player initiated combat against the dragon
  db $B2,$41,$11,$02         ; Run entrance event for return map
  db $41,$31,$FE             ; Show on-screen character; RTS

; CB5188 - destruction of the gold dragon's statue
  db $B2,$90,$50,$01         ; JSR $CB5090 - common event to teleport to Kaiser's room and prep statue destruction
  db $73,$54,$5F,$01,$01,$00 ; Remove top of the gold dragon's statue
  db $93,$B2,$9F,$1F,$02,$93 ; Pause for 45 units; calls dragon count routine
  db $6B,$4F,$21,$52,$22,$C0 ; Return to originating map at estimated position the player initiated combat against the dragon
  db $B2,$37,$11,$02         ; Run entrance event for return map
  db $41,$31,$FE             ; Show on-screen character; RTS

; ------------------------------------------------------------------------
; Modifies a map in South Figaro to make the basement inaccessible until Locke's scenario

org $CB51A5
  db $C0,$19,$80,$AC,$EC,$00 ; If ($1E80($019) [$1E83, bit 1] is set), branch to CA/ECAC
  db $73,$1D,$09,$01,$01,$57 ; Map changes follow
  db $FE

; ------------------------------------------------------------------------
; Ghost shop in Cyan's Nightmare

org $CB51B2
  db $9B,$56     ; Invoke shop $56
  db $FE         ; RTS

; ------------------------------------------------------------------------
; Ultros NPC free respec

org $CB51BD
  db $84,$60,$EA             ; Grant 60000 GP to the party
  db $C0,$2F,$02,$FF,$69,$01 ; If ($1E80($22F) [$1EC5, bit 7] is clear), branch to $CB69FF
  db $FE                     ; RTS

; ------------------------------------------------------------------------
; Recovery Points [?]
; Related: $CC9AEB

org $CB51C7
  db $C0,$B5,$81,$B3,$5E,$00 ; If ($1E80($1B5) [$1EB6, bit 5] is set), branch to $CA5EB3
  db $F4,$E9                 ; Play sound effect 233
  db $B2,$BD,$CF,$00         ; JSR $CACFBD
  db $B2,$F3,$9A,$02,$FE     ; JSR $CC9AF3, then RTS

; ------------------------------------------------------------------------
; Helper for Locke's extra line after Celes dialogue in Albrook

org $CB51D8
  db $92               ; Pause for 30 frames
  db $4B,$84,$05       ; Call caption 1411
  db $94               ; Pause for 60 frames
  db $B5,$10,$F2,$A0   ; [displaced]
  db $FE               ; RTS

; ------------------------------------------------------------------------
; Helper for Leeroy giving Relm stuff after Hidon

org $CB51E2
  db $94,$4B,$62,$0B   ; Displaced from JSR above
  db $80,$40           ; Adds the Rainbow Brush to the party's inventory
  db $80,$99           ; Adds the Czarina Gown to the party's inventory
  db $FE               ; RTS

; ------------------------------------------------------------------------
; Helper for booting player to airship at KT switches

org $CB51EB
  db $C9,$BD,$80,$74,$80  ; If Inferno and Myria are dead (bits set)...
  db $7D,$05,$00          ; ...branch to $CA057D
  db $95,$B2,$04,$21,$02  ; else, boot party to airship (JSR $CC2104)
  db $4B,$0C,$00,$FE      ; display caption #11

; ------------------------------------------------------------------------
; Cider merchant in WoR (Leo's Crest dialogue)

org $CB51FC : db $B2,$B0,$B0,$24,$FE  ; JSR $EEB0B0

; ------------------------------------------------------------------------
; Helpers for Edgar's Schematics quest and events

org $CB5201
  db $C1,$DC,$81,$A4,$00     ; If ($1E80($1DC) [$1EBB, bit 4] is set)
                             ; or ($1E80($0A4) [$1E94, bit 4] is clear)...
  db $FF,$67,$00             ; ...branch to $CA67FF
  db $4B,$75,$06,$FE         ; Display caption 1652

; Soldier - grants the schematics in the WoR
; $CB520D
  db $C0,$A4,$00,$D8,$75,$00 ; If ($1E80($0A4) [$1E94, bit 4] is clear), branch to $CA75D8
  db $4B,$84,$06             ; Display caption 1667
  db $C0,$DC,$81,$B3,$5E,$00 ; If ($1E80($1DC) [$1EBB, bit 4] is set, branch to $CA5EB3
  db $DE                     ; Load caseword with characters in current party
  db $C0,$A4,$01,$B3,$5E,$00 ; If ($1E80($1A4) [$1EB4, bit 4] is clear), branch to $CA5EB3
  db $4B,$77,$06             ; Call caption 1654
  db $D2,$DC,$FE             ; Set event bit $1E80($1DC) [$1EBB, bit 4]

; ------------------------------------------------------------------------
; Helper for Doom Gaze airship option

org $CB5229
  db $D0,$E2              ; Set event bit $1E80($0E2) [1E9C, bit 2]
  db $78,$31,$78,$12      ; Displaced code
  db $FE                  ; RTS
; $CB5230
  db $C1,$E2,$80,$A4,$00  ; If ($1E80($0E2) [$1E9C, bit 2] is set)
                          ; or ($1E80($0A4) [$1E94, bit 4] is clear)...
  db $6E,$F5,$00          ; ...branch to $CAF56E
  db $4B,$A5,$86          ; Display caption 1700
  db $B6,$8D,$F5,$00      ; If choice 1 was selected, take off
  db $46,$52,$01          ; If choice 2 was selected, invoke combat against Doom Gaze
  db $B3,$5E,$00,$FE      ; Else, just return
; $CB5246
  db $B2,$01,$AF,$24,$FE  ; JSL $EEAF01

; ------------------------------------------------------------------------
; Helper for making Atma required boss in KT

org $CB524B
  db $42,$10,$DD,$BD         ; Displaced code from originating location
  db $D0,$E1                 ; Set event bit $1E80($0E1) [1E9C, bit 1]
  db $FE                     ; RTS
; $CB5252
  db $C0,$E1,$80,$5C,$13,$02 ; If ($1E80($0E1) [$1E9C, bit 1] is set), branch to $CC135C
  db $31,$82                 ; Open action queue for on-screen character
  db $80,$FF                 ; Move character up 1 tile, end queue
  db $4B,$FB,$00             ; Caption 250
  db $FE                     ; RTS

; ------------------------------------------------------------------------
; Helper for top of Fanatic's Tower adding Pendant to inventory
; Bits used:
; $0E0 - witnessed the breadcrumb scene leading the party to the Fanatics' Tower
; $2DB - defeated the Magi Master at the top of the Fanatics' Tower

org $CB5260
  db $F4,$A6                 ; Sound effect
  db $73,$07,$07,$01,$01,$12 ; Opens the chest
  db $C0,$DA,$82,$14,$00,$00 ; If ($1E80($2DA) [$1EDB, bit 3] is set), branch to $CA0014
  db $D2,$E3                 ; Adds Pendant to the player's rare items
  db $4B,$C1,$0A             ; Caption 2752
  db $D4,$DA                 ; Set event bit $1E80($2DA) [$1EDB, bit 2]
  db $DC,$99                 ; Set event bit $1E80($699) [$1F53, bit 1]
  db $FE                     ; RTS

; ------------------------------------------------------------------------
; Helper for calling different Tentacle boss fight w/o Sabin

org $CB5278
  db $9C,$04                 ; Put optimum equipment on Edgar
  db $C0,$8A,$02,$84,$52,$01 ; If $1E80($28A) [$1ED1, bit 2] is clear, branch to $CB5284
  db $4D,$54,$37             ; Battle against tentacles with Sabin
  db $FE                     ; RTS
; $CB5284
  db $4D,$53,$37             ; Battle against tentacles without Sabin
  db $FE                     ; RTS

; ------------------------------------------------------------------------
; Helper for starting Relm with Dog Block in WoR

org $CB5288
  db $C0,$A3,$00,$92,$52,$01 ; If $1E80($0A3) [$1E9F, bit 3] is clear, branch to $CB5292
  db $89,$08,$00,$40         ; Inflict dog block status on Relm
  db $B2,$95,$CB,$00         ; JSR $CACB95
  db $FE                     ; RTS

; ------------------------------------------------------------------------
; Helper for starting game inventory

org $CB5297
  db $80,$FE
  db $80,$FE
  db $80,$FE
  db $80,$FE
  db $80,$FE     ; Add dried meat x5 to inventory
  db $FE         ; RTS

; ------------------------------------------------------------------------
; Helper for giving Sabin dialogue while chasing Gerad

org $CB52A2
  db $BE,$01       ; Checks the current caseword (active party membership), 1 check
  db $AC,$52,$51   ; If Sabin is present, JSR $CB52AC
  db $32,$02       ; Open action queue for character $32 (party character 1), 2 bytes long
  db $81           ; Move right 1 tile
  db $FF           ; End queue
  db $FE           ; RTS
  db $91           ; Pause for 15 units
  db $4B,$2A,$09   ; Display caption $092A (2347)
  db $91           ; Pause for 15 units
  db $FE           ; RTS

; ------------------------------------------------------------------------
; Helper for angry Terra soloing Sealed Gate

org $CB52B2
  db $00,$02     ; Open action queue for character $00 (Terra), 2 bytes long 
  db $18         ; Angry stance
  db $FF         ; End queue
  db $92         ; Pause for 30 units
  db $4B,$60,$06 ; Display caption $0660 (1633)
  db $92         ; Pause for 30 units
  db $FE         ; RTS

; ------------------------------------------------------------------------
; Helper for Lone Wolf caption pacing change

org $CB52BC
  db $4B,$88,$06  ; Display caption $0688 (1673)
  db $95          ; Pause for 120 units
  db $31,$02      ; Open action queue for character $31 (party character 0), 2 bytes long
  db $CC          ; Turn character up
  db $FF          ; End queue
  db $FE          ; RTS

; ------------------------------------------------------------------------
; Kaiser NPC Event

org $CB52C5
  db $4D,$9A,$3F      ; Invoke battle against pack $9A (410) using default background
  db $B2,$A9,$5E,$00  ; JSR $CA5EA9 - checks to see if a game over needs to be triggered
  db $42,$10          ; Hides NPC $10 (dragon sprite, in this case)
  db $D7,$A3          ; Clear event bit $1E80($3A3) [$1EF4, bit 3]
  db $96              ; Restore screen from fade
  db $5C              ; Pause execution until fade is complete
  db $4B,$E2,$C5      ; Display caption $05E2 (1505)
  db $F4,$8D          ; Play sound effect
  db $86,$45          ; Add Crusader to party esper list
  db $3A              ; Enable movement while events execute
  db $FE              ; RTS

; ------------------------------------------------------------------------
; Helper for optimizing Terra and Edgar on Lete River

org $CB52DB
  db $B2,$95,$CB,$00   ; Displaced code from JSR above
  db $9C,$00           ; Optimize Terra
  db $9C,$04           ; Optimize Edgar
  db $FE

; ------------------------------------------------------------------------
; Helper for changing Intangir Kagenui drop

org $CB52E4
; displaced from vanilla
  db $42,$14                 ; hide NPC $14 (Intangir)
  db $3E,$14                 ; delete NPC $14 (Intangir)
; new event code
  db $C0,$A3,$00,$F2,$52,$01 ; skip if Shadow alive
  db $81,$29                 ; remove item: Kagenui1
  db $80,$02                 ; give item: Kagenui2
  db $FE                     ; return from subroutine

; ------------------------------------------------------------------------
; Gau makeover scene changes
; Changes a conditional and modifies to avoid clustering the party

org $CB5FB7 : db $B2,$87,$B0,$24   ; JSR $EEB087

org $CB5FCB
  db $FD,$FD,$FD,$FD,$FD,$FD,$FD
  db $FD,$FD,$FD,$FD,$FD,$FD,$FD

org $CB60A4
  db $E1                  ; Load CaseWord with recruited characters
  db $C1,$A1,$01,$A4,$01  ; If Locke or Edgar are absent...
  db $C0,$60,$01          ; branch to $CB60C0
  db $FD,$FD,$FD,$FD,$FD  ; Five NOPs
  db $15                  ; Change character action queue to NPC #5 (Edgar)

org $CB60B9 : db $12      ; Change character action queue to NPC #2 (Locke)
org $CB61C8 : db $E1      ; Load CaseWord with recruited characters
org $CB61F5 : db $15      ; Change character action queue to NPC #5 (Edgar)
org $CB6203 : db $12      ; Change character action queue to NPC #2 (Locke)
org $CB6214 : db $12      ; Change character action queue to NPC #2 (Locke)
org $CB621D : db $15      ; Change character action queue to NPC #5 (Edgar)
org $CB622A : db $12      ; Change character action queue to NPC #2 (Locke)
org $CB623D : db $12      ; Change character action queue to NPC #2 (Locke)
org $CB6242 : db $15      ; Change character action queue to NPC #5 (Edgar)
org $CB6246 : db $12      ; Change character action queue to NPC #2 (Locke)

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CB6698 : db $4B,$08,$0B

; ------------------------------------------------------------------------
; Leeroy gives Relm the Rainbow Brush and Czarina Gown after defeating Hidon

org $CB73DA : db $B2,$E2,$51,$01   ; JSR $CB51E2

; ------------------------------------------------------------------------
; Upon speaking to Leeroy in Thamasa, Hidon will
; now reappear 100% of the time (rather than 12.5%).
; Point all 50% branches to "Hidon Reappears"

org $CB73FE
  db $BD : dl $01740A
  db $BD : dl $01740A
  db $BD : dl $01740A

; ------------------------------------------------------------------------
; Removes a dialogue branch that no longer exists
; 7 bytes of free space after this return.

org $CB757F : db $FE      

; ------------------------------------------------------------------------
; Shadow, WoR recruitment (new level averaging behavior)

org $CB7954 : db $66

; ------------------------------------------------------------------------
; Change what Intangir drops based on Shadow being alive

org $CB7A7C : db $B2,$E4,$52,$01   ; jump to subroutine: $CB52E4

; ------------------------------------------------------------------------
; Ebot's Rock Coral Event(s)
;
; Allow collected coral to accumulate when feeding chest. Note, jumps to
; subroutines in E6 Bank. This is part of Gi Nattak's "No Coral for You"
; patch

org $CB7107
  db $B2 : dl $1CCD44 ; JSR CoralHelper2
  db $FE              ; RTS
  padbyte $FF
  pad $CB711B

; Branch to Coral Helper 1
org $CB712A
  db $B2 : dl $1CCD3D ; JSR CoralHelper1

; ------------------------------------------------------------------------
; Shift a dialogue block up four bytes to deprecate the usage of caption 2424

org $CB7858 : db $4B,$7A,$09,$FE   ; Display caption 2425, then return.

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CB78B0 : db $67,$65,$02

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CB7D04 : db $4B,$E6,$09

; ------------------------------------------------------------------------
; Remove the Magitek status from that portion of Cyan's dream.
; Branch to CB/93E6, thus not applying the M-Tek status and staying on-foot

org $CB93D7 : db $C0,$27,$01,$E6,$93,$01

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CBB1A7 : db $4B,$8A,$02

; ------------------------------------------------------------------------
; Extend a pause to prevent the game from smashing two dialogue windows
; together during the end of the Phantom Train sequence

org $CBBD90 : db $94

; ------------------------------------------------------------------------
; Prevents Shadow from randomly running off (5/5)

org $CBBE60 : db $B8

; ------------------------------------------------------------------------
; Remove Shadow's equipment at Baren Falls

org $CBC01E : db $8D,$03 ; (replaces a 10-unit pause)

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CBFE4A : db $4B,$AF,$0A

; ########################################################################
; ============================== BANK CC =================================
; ########################################################################

; ------------------------------------------------------------------------
; Thamasa, after Leo dies (no level averaging)

org $CC08E2 : db $FD,$FD,$FD,$FD,$FD,$FD,$FD,$FD,$FD,$FD,$FD,$FD,$FD,$FD

; ------------------------------------------------------------------------
; Mog, after Leo dies (if recruited) (new level averaging behavior)

org $CC093D : db $FD,$FD

; ------------------------------------------------------------------------
; Leo's grave

org $CC0977
  db $C9,$B4,$81,$B0,$81  ; If you're facing up and pressing A...
  db $CD,$B0,$24,$FE      ; branch to $EEB0CD

; ------------------------------------------------------------------------
; Make Locke required to receive either the Apocalypse or Illumina.

; If ($1E80($127) [$1EA4, bit 7] is clear), branch to $EEAF41
org $CC0B1E : db $C0,$27,$01,$41,$AF,$24

; ------------------------------------------------------------------------
; Change the options at the Narshe weapon shop to Apocalypse or Illumina,
; and add a "Wait" option. To free up space, remove one of the blue glow
; effects from the first part of the dialogue.

org $CC0B2D
  db $41,$11           ; Show object $11
  db $B2,$D5,$9A,$02   ; JSR $CC9AD5
  db $4B,$EF,$05,$B6   ; Display caption 1518 and set up the following branch
  db $42,$0B,$02       ; Apocalypse - $CC0B42
  db $58,$0B,$02       ; Illumina - $CC0B58
  db $B3,$5E,$00       ; Wait - $CA5EB3
  db $FE               ; RTS; probably unnecessary, but it's otherwise wasted space

org $CC0B53 : db $80,$1B     ; Adds Apocalypse to party inventory
org $CC0B67 : db $80,$1A     ; Adds Illumina to party inventory

; ------------------------------------------------------------------------
; Blocks an exit so Atma is a required boss
; Atma sequence starts at $CC18B4

org $CC18BE : db $B2,$4B,$52,$01   ; JSR $CB524B

; ------------------------------------------------------------------------
; After gold dragon defeated, ruin its statue and skip dragon counting

org $CC18F6
  db $B2 : dl $015188 ; JSR $CB5188
org $CC1900
  db $3A,$FE          ; bypass dragon-counting routine

; ------------------------------------------------------------------------
; After green dragon defeated, ruin its statue and skip dragon counting

org $CC1923
  db $B2 : dl $01516B ; JSR $CB516B
org $CC192D
  db $3A,$FE          ; bypass dragon-counting routine

; ------------------------------------------------------------------------
; Trolls the player a bit by sending them back to the airship at the three
; switches if they skipped Myria or Inferno

; If ($1E80($22F) [$1EC5, bit 7] is clear), branch to $CB51EB
org $CC19E8 : db $C0,$2F,$02,$EB,$51,$01

; ------------------------------------------------------------------------
; Changes the statue of Odin to drop the cracked stone rare item
; The queen's statue now turns the stone into the Odin magicite
; The stairwell is always visible

org $CC1A06 : dw $FDFD : dw $FDFD : dw $FDFD ; always reveal stairs on map load
org $CC1ED1 : db $D2,$E0 ; Gain stone: Sets event bit $1E80($1E0) [$1EBC, bit 0]
org $CC1F81 : db $D3,$E0 ; Lose stone: Clears event bit $1E80($1E0) [$1EBC, bit 0]
org $CC1F85 : db $86,$41 ; Add Odin to party esper list
org $CC1F8B : db $FE     ; Remove event when examining hidden tile in castle

; ------------------------------------------------------------------------
; Re-write the dragon counting routine to add a fade to each result
; Removes esper reward from defeating all 8 dragons
; * (is now a reward for beating Kaiser)
; TODO: Dry up these forks
; TODO: Is this even used anymore?
; CC203C - 12 bytes of free space to CC/2047

org $CC1F9F
  db $EB : db $06 : dw $0008     ; remaining dragons ($1FCE) == 8 ?
  db $C0 : dw $01A0 : dl $021FB3 ; branch to $CC1FB3 if ^
  db $4B : dw $C5DA              ; display dialogue $05DA, no window, bottom
  db $EA : db $06 : dw $0001     ; decrement $1FCE by 1
  db $97,$5C,$FE                 ; fade to black, pause during fade, RTS
; CC1FB3
  db $EB : db $06 : dw $0007     ; remaining dragons ($1FCE) == 7 ?
  db $C0 : dw $01A0 : dl $021FC7 ; branch to $CC1FC7 if ^
  db $4B : dw $C5DB              ; display dialogue $05DB, no window, bottom
  db $EA : db $06 : dw $0001     ; decrement $1FCE by 1
  db $97,$5C,$FE                 ; fade to black, pause during fade, RTS
; CC1FC7
  db $EB : db $06 : dw $0006     ; remaining dragons ($1FCE) == 6 ?
  db $C0 : dw $01A0 : dl $021FDB ; branch to $CC1FDB if ^
  db $4B : dw $C5DC              ; display dialogue $05DC, no window, bottom
  db $EA : db $06 : dw $0001     ; decrement $1FCE by 1
  db $97,$5C,$FE                 ; fade to black, pause during fade, RTS
; CC1FDB
  db $EB : db $06 : dw $0005     ; remaining dragons ($1FCE) == 5 ?
  db $C0 : dw $01A0 : dl $021FEF ; branch to $CC1FEF if ^
  db $4B : dw $C5DD              ; display dialogue $05DD, no window, bottom
  db $EA : db $06 : dw $0001     ; decrement $1FCE by 1
  db $97,$5C,$FE                 ; fade to black, pause during fade, RTS
; CC1FEF
  db $EB : db $06 : dw $0004     ; remaining dragons ($1FCE) == 4 ?
  db $C0 : dw $01A0 : dl $022003 ; branch to $CC2003 if ^
  db $4B : dw $C5DE              ; display dialogue $05DE, no window, bottom
  db $EA : db $06 : dw $0001     ; decrement $1FCE by 1
  db $97,$5C,$FE                 ; fade to black, pause during fade, RTS
; CC2003
  db $EB : db $06 : dw $0003     ; remaining dragons ($1FCE) == 3 ?
  db $C0 : dw $01A0 : dl $022017 ; branch to $CC2017 if ^
  db $4B : dw $C5DF              ; display dialogue $05DF, no window, bottom
  db $EA : db $06 : dw $0001     ; decrement $1FCE by 1
  db $97,$5C,$FE                 ; fade to black, pause during fade, RTS
; CC2017
  db $EB : db $06 : dw $0002     ; remaining dragons ($1FCE) == 2 ?
  db $C0 : dw $01A0 : dl $02202B ; branch to $CC202B if ^
  db $4B : dw $C5E0              ; display dialogue $05E0, no window, bottom
  db $EA : db $06 : dw $0001     ; decrement $1FCE by 1
  db $97,$5C,$FE                 ; fade to black, pause during fade, RTS
; CC202B
  db $4B : dw $C5E1              ; display dialogue $05E1, no window, bottom
  db $EA : db $06 : dw $0001     ; decrement $1FCE by 1
  db $D6 : db $A3                ; set event bit $1E80($3A3) [$1EF4, bit 3]
  db $95,$97,$95                 ; pause for 120, fade to black, pause for 120
  db $F4 : db $B9                ; play sound: $B9
  db $B5 : db $0C                ; pause duration: 180
  db $FE                         ; RTS

; The following clipped out because the music fade in would always start with
; the victory fanfare for some reason.
;   db $95           ; pause 120
;   db $F2 : db $20  ; fade out song (duration $20)
;   db $97           ; fade to black
;   db $5C           ; pause during fade
;   db $F3 : db $20  ; fade in song (duration $20)
;   db $FE           ; RTS

; ------------------------------------------------------------------------
; After red dragon defeated, ruin its statue and skip dragon counting

org $CC204B
  db $B2 : dl $015125 ; JSR $CB5125
org $CC2055
  db $3A,$FE          ; bypass dragon-counting routine

; ------------------------------------------------------------------------
; After blue dragon defeated, ruin its statue and skip dragon counting

org $CC205E
  db $B2 : dl $015149 ; JSR $CB5149
  db $42,$13          ; Hide blue dragon
  db $DD,$A1          ; Clear event bit $1E80($6A1) [$1F54, bit 1]
org $CC2068
  db $3A,$FE          ; bypass dragon-counting routine

; ------------------------------------------------------------------------
; Remove Locke's head nod when recruiting him in the WoR

org $CC2BC4 : db $FD,$FD,$FD,$FD,$FD,$FD,$FD,$FD

; ------------------------------------------------------------------------
; Locke, WoR recruitment (new level averaging behavior)

org $CC3188 : db $66

; ------------------------------------------------------------------------
; Removes most items Locke has from the Phoenix Cave, leaving a Phoenix Tear
; Includes removal of Valiant Edge

org $CC3282
  db $80,$F9     ; Adds Phoenix Tear to party inventory
  db $FD,$FD,$FD,$FD,$FD
  db $FD,$FD,$FD,$FD,$FD  ; NOPing out the rest of the items he gives

; ------------------------------------------------------------------------
; Removes a now-blank dialogue caption from the save point tutorial dude
; CC33E5 - CC33E7 are now free. Whoopdee-doo.

org $CC33E4 : db $FE

; ------------------------------------------------------------------------
; Axes the "aura" dialogue from the NPC in the Beginner's School

org $CC3429 : db $FE

; ------------------------------------------------------------------------
; Repoint a dialogue pointer that was overwritten by expanding the above events.

org $CC342A : db $C0,$55,$80,$FB,$AD,$00,$4B,$90,$04,$FE

; ------------------------------------------------------------------------
; Unequips Umaro via airship NPCs

org $CC3591            ; Unequip everyone
  db $B2,$53,$B0,$24   ; JSR $EEB053
  db $92               ; Pause for 30 units
  db $3A               ; Enable player to move while event commands execute
  db $FE               ; RTS

org $CC3664            ; Unequip those not in the party
  db $B2,$66,$B0,$24   ; JSR $EEB066
  db $92               ; Pause for 30 units
  db $3A               ; Enable player to move while event commands execute
  db $FE               ; RTS

; ------------------------------------------------------------------------
; Axe a dialogue choice from the beginner's school

org $CC367A : db $FE

; ------------------------------------------------------------------------
; After silver dragon defeated, ruin its statue and skip dragon counting

org $CC36E2
  db $B2 : dl $015103 ; JSR $CB5103
org $CC36EC
  db $3A,$FE          ; bypass dragon-counting routine

; ------------------------------------------------------------------------
; Mog, WoR recruitment (new level averaging behavior)

org $CC3A32 : db $66

; ------------------------------------------------------------------------
; Alter Setzer's WoR recruitment scene

org $CC3C5A
  db $4B,$91,$09,$91   ; Call caption 2448, then pause
  db $06,$03,$A3,$8B,$FF,$92 ; Action queue for Celes
  db $4B,$92,$09,$92   ; Call caption 2449, then pause
  db $06,$02,$CD,$FF,$92  ; Action queue for Celes
  db $48,$93,$09,$93   ; Call caption 2450
  db $06,$05,$80,$89,$80
  db $CD,$FF,$F2,$A0,$49  ; Action queue for Celes, fade out song, and pause
  db $F0,$10     ; Play Setzer's theme
  db $15,$08,$CF,$E0,$06
  db $CE,$E0,$08,$23,$FF,$94 ; Action queue for Setzer, and pause
  db $4B,$94,$09,$F0,$10  ; Call caption 2451, then play Setzer's theme

org $CC3CBE : db $4B,$B2,$0A    ; Call caption 2738

; ------------------------------------------------------------------------
; Setzer, WoR recruitment (new level averaging behavior)

org $CC3D52 : db $66

; ------------------------------------------------------------------------
; After purple dragon defeated, ruin its statue and skip dragon counting

org $CC43D0
  db $B2 : dl $0150BF ; JSR $CB50BF
org $CC43DC
  db $3A,$FE          ; bypass dragon-counting routine

; ------------------------------------------------------------------------
; Swap Fenrir and Palidor (2/2)

org $CC4ADA : db $86,$3F ; Give Palidor to the party (was Fenrir)

; ------------------------------------------------------------------------
; Cyan, WoR recruitment (new level averaging behavior)

org $CC42A1 : db $66

; ------------------------------------------------------------------------
; Terra, before final battle against Phunbaba (new level averaging behavior)

org $CC4CD4 : db $66

; ------------------------------------------------------------------------
; Terra, WoR recruitment (new level averaging behavior)

org $CC5047 : db $66

; ------------------------------------------------------------------------
; Removes the magic only gimmick from the Fanatics' Tower

org $CC5173 : db $B9

; ------------------------------------------------------------------------
; Prevents the NPC at the base of the Fanatics' Tower from jumping, since he's been killed
; CC/51EA to CC/51F6 is free space now

org $CC51E9 : db $FE

; ------------------------------------------------------------------------
; Changes the thief that sell bogus info at the base of the Fanatics' Tower to sell the Alexandr esper for 32,768

org $CC51FF
  db $C0,$E5,$00,$09,$52,$02 ; If ($1E80($0E5) [$1E9C, bit 5] is clear), branch to $CC5209
  db $4B,$E6,$09,$FE         ; Call caption 2533, then RTS
  db $4B,$C8,$08,$B6         ; Call caption 2247, then set up the choice branch below
  db $13,$52,$02,$B3,$5E,$00 ; Branch to CC5213 (yes), CA5EB3 (no)
  db $85,$00,$80             ; Deduct 32,768 GP from party
  db $C0,$BE,$81,$FF,$69,$01 ; If they don't have enough money, branch
  db $86,$46                 ; Give Alexandr to the party
  db $D0,$E5                 ; Set event bit $1E80($0E5) [1E9C, bit 5]
  db $4B,$C9,$08,$FE         ; Call caption 2248, then RTS

; ------------------------------------------------------------------------
; Strago, WoR recruitment (new level averaging behavior)

org $CC541D : db $66

; ------------------------------------------------------------------------
; Puts Pendant in party's rare items once the Gem Box chest has been looted
; Originally the event in front of the Gem Box chest

org $CC5440
  db $C0,$DA,$82,$B3,$5E,$00 ; If ($1E80($2DA) [$1EDB, bit 2] is set)...
                             ; ..branch to $CA5EB3 (simply returns)
  db $B2,$60,$52,$01         ; JSR $CB5260

; ------------------------------------------------------------------------
; After white dragon defeated, ruin its statue and skip dragon counting

org $CC558E
  db $B2 : dl $0150E1 ; JSR $CB50E1
org $CC5598
  db $3A,$FE          ; bypass dragon-counting routine

; ------------------------------------------------------------------------
; Sabin, WoR recruitment (new level averaging behavior)

org $CC5AAD : db $66

; ------------------------------------------------------------------------
; Adds a line for Locke after his "talk" with Celes at Albrook

org $CC624F : db $B2,$D8,$51,$01   ; JSR $CB51D8

; ------------------------------------------------------------------------
; Corrects NPC behavior in Mobliz resulting from the execution of derpkid.
; Various NPC movements - no need for commentary

org $CC65F8 : db $1B,$1E,$C1,$87,$E0,$0C,$8D,$E0,$0C,$82,$E0,$10,$80,$E0,$0C,$84,$E0,$10,$86,$C2,$83,$DC,$87,$E0,$0C,$C1,$81,$E0,$0C,$FC,$1B,$FF,$1D,$18,$CF,$E0,$10,$CE,$E0,$20,$CD,$E0,$20,$CE,$E0,$08,$CD,$E0,$10,$CE,$E0,$04,$CF,$E0,$20,$FC,$15,$FF,$FE

; ------------------------------------------------------------------------
; Lower the price for hiring Shadow at Kohlingen to 1000 GP.

org $CC7001 : db $85 : dw $03E8 ; 1000 GP

; ------------------------------------------------------------------------
; Locke and Terra, after banquet with Gestahl (new level averaging behavior)

org $CC906C : db $FD,$FD,$FD,$FD

; ------------------------------------------------------------------------
; Re-writes the save point events to free up a bit of space
; Also introduces recovery points (see $CB51C7)

org $CC9AEB
  db $C0,$B5,$81,$B3,$5E,$00 ; If ($1E80($1B5) [$1EB6, bit 5] is set), branch to $CA5EB3
  db $F4,$D1                 ; Plays sound effect 209
  db $55,$80                 ; Flash screen blue
  db $D2,$B5                 ; Set event bit $1E80($1B5) [$1EB6, bit 5]
  db $D2,$BF                 ; Set event bit $1E80($1BF) [$1EB7, bit 7]
  db $3A                     ; Enable player to move while commands execute
  db $FE                     ; RTS

; ------------------------------------------------------------------------
; Helper for giving Gau a line during first meeting with Setzer

org $CC9AFC
  db $4B,$F8,$04,$92   ; Call caption #1271 and pause for 30 units
  db $DE               ; Load caseword with active party
  db $C0,$AB,$01,$0B,$9B,$02 ; If Gau is not in the party, branch to $CC9B0B
  db $4B,$66,$0A,$92   ; Call caption #2661 and pause for 30 units
  db $FE               ; RTS

; ------------------------------------------------------------------------
; Change an encounter at Narshe from a dinosaur to two lobos

org $CC9BF1 : db $4D,$02

; ------------------------------------------------------------------------
; Starts the party with 5 dried meat rather than 2 sleeping bags

org $CCA00A : db $B2,$97,$52,$01   ; JSR $CB5297

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CCC241 : db $4B,$28,$05

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CCC285 : db $4B,$90,$03

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CCC2BB : db $4B,$28,$05

; ------------------------------------------------------------------------
; Kefka at Narshe - Change number of parties to 2

org $CCC665 : db $99,$82,$00,$00 ; Invoke party selection screen (2 groups)

org $CCC69B : db $D5,$13,$0A     ; Set party 1 position before Kefka arrival
org $CCC6AA : db $D5,$15,$0A     ; Set party 2 position before Kefka arrival
org $CCC6B3 : padbyte $FD : pad $CCC6C2 ; NOP party 3 handling

org $CCC85D : db $D5,$13,$0A     ; Set party 1 position after Kefka arrival
org $CCC86C : db $D5,$15,$0A     ; Set party 2 position after Kefka arrival
org $CCC875 : padbyte $FD : pad $CCC884 ; NOP party 3 handling

; ------------------------------------------------------------------------
; Change Arvis' caption to act as an unequipper after the Battle of Narshe

org $CCD1E7 : db $4B,$DC,$06

; ------------------------------------------------------------------------
; Shift the dialogue of some Narshe NPCs to free up dialogue space

org $CCD207 : db $4B,$99,$03,$FE
org $CCD23F : db $4B,$9D,$03,$FE

; ------------------------------------------------------------------------
; Dialogue Reassignment

org $CCD2A7 : db $4B,$8C,$03

; ------------------------------------------------------------------------
; Splits a caption during the Lone Wolf "splat" event for better flow

org $CCD6B7 : db $B2,$BC,$52,$01   ; JSR $CB52BC

; ------------------------------------------------------------------------
; Makes game overs exit to the title screen

org $CCE5EC
  db $A9      ; Call title screen
  db $AB      ; Call loading screen
  db $4F      ; Exit current location (seems to just exit the current event,
  db $FE      ; like $FE without actually returning anywhere)
  db $FF

; ------------------------------------------------------------------------
; Changes the caption call for an NPC at the Beginner's School

org $CCE5F1 : db $4B,$86,$02,$FE   ; Display caption #645

; EOF
