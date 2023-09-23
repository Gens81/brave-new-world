hirom

; ########################################################################
; =============================== Bank EE ================================
; ########################################################################

; ------------------------------------------------------------------------
; Miscellaneous RNG updates to use new C0FD00 routine

org $EE149D : JSL Random   ; novalia: used in Earth destruction scene
org $EE150D : JSL Random   ; novalia: used in Earth destruction scene

org $EE2515 : JSL Random   ; novalia: has to do with minecart commands
org $EE2523 : JSL Random   ; novalia: has to do with minecart commands
org $EE3281 : JSL Random   ; minecart, determines formation for pack A
org $EE32CF : JSL Random   ; minecart, determines formation for pack B
org $EE5071 : JSL Random   ; novalia: used when airship emerges from ocean
org $EE5081 : JSL Random   ; novalia: used when airship emerges from ocean
org $EE5092 : JSL Random   ; novalia: used when airship emerges from ocean

org $EE54C6 : JSL Random   ; novalia: used to draw fire when Earth is zapped
org $EE54D6 : JSL Random   ; novalia: used to draw fire when Earth is zapped
org $EE54E7 : JSL Random   ; novalia: used to draw fire when Earth is zapped
org $EE56BF : JSL Random   ; novalia: animate airship in ending scene
org $EE56CF : JSL Random   ; novalia: animate airship in ending scene
org $EE56E0 : JSL Random   ; novalia: animate airship in ending scene

; ------------------------------------------------------------------------
; Always play "Ruined World" on overworld map, even after getting Airship

org $EE8394 : db $4F

; ------------------------------------------------------------------------
; Miscellaneous RNG updates to use new C0FD00 routine

org $EE86A6 : JSL Random   ; novalia: sets Doomgaze's position
org $EE86B4 : JSL Random   ; novalia: sets Doomgaze's position

; ------------------------------------------------------------------------
; Doom Gaze airship search option helper

org $EEAF01
  db $6A,$01,$04,$9E,$33,$01 ; Load map $0001 (World of Ruin) after fade out, (upper bits $0400), place party at (158, 51), facing up, party is in the airship
  db $29,$58,$0C,$30,$4C,$20
  db $2C,$10,$24,$10,$34,$10
  db $54,$10,$49,$24,$40,$A0
  db $24,$30,$34,$40,$54,$30
  db $40,$80,$49,$60,$40,$80
  db $24,$30,$D9             ; Wild airship movement
  db $D2,$11,$36,$11,$08,$C0 ; Load map $0011 (Falcon, upper deck), position (17, 08), mode $C0
  db $4D,$5D,$29             ; Invoke battle against Doom Gaze
  db $B2,$A9,$5E,$00         ; Check for death
  db $B7,$48,$E3,$00,$00     ; If ($1DC9($048) [$1DD2, bit 0] is clear), branch to $CA00E3
  db $96                     ; Restore screen from fade
  db $C0,$27,$01,$9D,$00,$00 ; If ($1E80($127) [$1EA4, bit 7] is clear), branch to $CA009D

; ------------------------------------------------------------------------
; Helper for making Locke required to receive Apocalypse or Illumina

org $EEAF41
  db $DE                     ; Load caseword with characters in current party
  db $C1,$B6,$80,$A1,$01     ; If ($1E80($0B6) [$1E96, bit 6] is set) or
                             ;    ($1E80($1A1) [$1EB4, bit 1] is clear)...
  db $6C,$0B,$02             ; ...branch to $CC0B6C
  db $C0,$27,$01             ; If ($1E80($127) [$1EA4, bit 7] is clear)...
  db $24,$0B,$02             ; ...branch to $CC0B24

; ------------------------------------------------------------------------
; Helpers for Pendant scene on airship, pre KT

org $EEAF50
  db $4B,$A0,$0B,$92         ; Dialogue and pause overwritten in initial branch
  db $C0,$E0,$80,$B8,$AF,$24 ; If ($1E80($0E0) [$1E9C, bit 0] is set), branch to $EEAFB8
  db $C0,$DB,$82,$64,$02,$00 ; If ($1E80($2DB) [$1EDB, bit 3] is set), branch to $CA0264
  db $09,$88,$CF,$E0,$12     ; Action for Setzer
  db $CE,$E0,$04,$63,$FF,$92
  db $4B,$FC,$05             ; Caption 1531
  db $04,$84,$E0,$04,$CF,$FF ; Action for Edgar
  db $06,$84,$E0,$04,$23,$FF ; Action for Celes
  db $4B,$FD,$05             ; Caption 1532
  db $93
  db $06,$84,$E0,$02,$CF,$FF ; Action for Celes
  db $94
  db $09,$04,$E0,$10,$24,$FF ; Action for Setzer
  db $4B,$BD,$0A             ; Caption 2748
  db $04,$07,$E0,$0B,$22     ; Action for Edgar
  db $E0,$50,$04,$FF
  db $09,$04,$E0,$06,$63,$FF ; Action for Setzer
  db $4B,$9F,$06             ; Caption 1694
  db $09,$84,$E0,$06,$47,$FF ; Action for Setzer
  db $06,$05,$E0,$1C         ; Action for Celes
  db $01,$22,$FF
  db $4B,$A0,$06             ; Caption 1695
  db $D0,$E0                 ; Set event bit $1E80($0E0) [1E9C, bit 0]
  db $95,$B2,$03,$21,$02,$FE ; JSR $CC2103

; $EEAFB8
  db $C0,$DB,$82,$FD,$AF,$24 ; If ($1E80($2DB) [$1EDB, bit 3] is set), branch to $EEAFFD
  db $09,$08,$CF,$E0,$12     ; Action for Setzer
  db $CE,$E0,$04,$63,$FF,$94
  db $04,$04,$E0,$30,$20,$FF ; Action for Edgar
  db $06,$04,$E0,$28,$1E,$FF ; Action for Celes
  db $93
  db $4B,$BE,$0A             ; Caption 2749
  db $09,$02,$58,$FF         ; Action for Setzer
  db $4B,$A2,$06             ; Caption 1697
  db $93
  db $06,$07,$E0,$04,$01     ; Action for Celes
  db $E0,$04,$18,$FF
  db $04,$07,$E0,$16,$04     ; Action for Edgar
  db $E0,$30,$21,$FF         ; Action for Edgar
  db $93
  db $4B,$A1,$06             ; Caption 1696
  db $95,$B2,$03,$21,$02,$FE ; JSR $CC2103

; $EEAFFD
  db $04,$82,$CF,$FF         ; Action for Edgar
  db $4B,$BF,$0A             ; Caption 2750
  db $06,$05,$1F,$E0,$1A     ; Action for Celes
  db $CF,$FF
  db $4B,$FF,$05             ; Caption 1534
  db $94
  db $F6,$81,$02,$C0
  db $94
  db $F4,$50                 ; Play sound effect
  db $B2,$1B,$D0,$00,$B5,$0A ; Screen flash
  db $B2,$21,$D0,$00
  db $94
  db $F6,$81,$02,$FF
  db $06,$04,$E0,$4A,$22,$FF ; Action for Celes
  db $4B,$C0,$0A             ; Caption 2751
  db $C0,$27,$01,$64,$02,$00 ; If $1E80($127) [$1EA4, bit 7] is clear, branch to $CA0264

; ------------------------------------------------------------------------
; Helper for post-Zozo unequip

org $EEB034
  db $B2,$95,$CB,$00   ; JSR $CACB95 - displaced from JSR above
  db $B2,$A4,$35,$02   ; JSR $CC35A4 - remove gear from non-party characters
  db $8D,$03           ; Remove equipment from Shadow
  db $FE               ; Return

; ------------------------------------------------------------------------
; Helper for Umaro unequip via airship merchant

org $EEB053
  db $E1                     ; Load CaseWord with recruited characters
  db $C0,$AC,$01,$5C,$B0,$24 ; If ($1E80($1AC) [$1EB5, bit 4] is clear), branch to $EEB05C
  db $8D,$0C                 ; Remove all equipment from character $0C (Gogo)
  db $E1                     ; Load CaseWord with recruited characters
  db $C0,$AD,$01,$B3,$5E,$00 ; If ($1E80($1AD) [$1EB5, bit 4] is clear), branch to $CA5EB3
  db $8D,$0D                 ; Remove all equipment from character $0D (Umaro)
  db $FE                     ; RTS
; $EEB066
  db $E1                     ; Load CaseWord with recruited characters
  db $C0,$AC,$01,$76,$B0,$24 ; If ($1E80($1AC) [$1EB5, bit 4] is clear), branch to $EEB076
  db $DE                     ; Load CaseWord with characters in active party
  db $C0,$AC,$81,$76,$B0,$24 ; If ($1E80($1AC) [$1EB5, bit 4] is set), branch to $EEB076
  db $8D,$0C                 ; Remove all equipment from character $0C (Gogo)
  db $E1                     ; Load CaseWord with recruited characters
  db $C0,$AD,$01,$B3,$5E,$00 ; If ($1E80($1AD) [$1EB5, bit 4] is clear), branch to $CA5EB3
  db $DE                     ; Load CaseWord with characters in active party
  db $C0,$AD,$81,$B3,$5E,$00 ; If ($1E80($1AD) [$1EB5, bit 4] is set), branch to $CA5EB3
  db $8D,$0D                 ; Remove all equipment from character $0D (Umaro)
  db $FE                     ; RTS

; ------------------------------------------------------------------------
; Gau Makeover Helper

org $EEB087
  db $3F,$00,$00       ; Remove Terra from party
  db $3F,$01,$00       ; Remove Locke from party
  db $3F,$02,$00       ; Remove Cyan from party
  db $3F,$03,$00       ; Remove Shadow from party
  db $3F,$04,$00       ; Remove Edgar from party
  db $3F,$06,$00       ; Remove Celes from party
  db $3F,$07,$00       ; Remove Strago from party
  db $3F,$08,$00       ; Remove Relm from party
  db $3F,$09,$00       ; Remove Setzer from party
  db $3F,$0A,$00       ; Remove Mog from party
  db $3F,$0C,$00       ; Remove Gogo from party
  db $3F,$0D,$00       ; Remove Umaro from party
  db $B2,$AC,$C6,$00   ; JSR $CAC6AC
  db $FE

; ------------------------------------------------------------------------
; Helper for Cider merchant dialogue in WoR

org $EEB0B0
  db $C0,$A4,$00,$7D,$7D,$00 ; If ($1E80($0A4) [$1E94, bit 4] is clear), branch to $CA7D7D
  db $4B,$F5,$00             ; Display caption #244
  db $DE                     ; Load caseword with characters in current party
  db $C9,$A6,$81,$D0,$81     ; If Celes is in the party and you have the Cider...
  db $C3,$B0,$24             ; branch to $EEB0C3
  db $FE                     ; RTS
; $EEB0C3
  db $4B,$F7,$00             ; Display caption #246
  db $F4,$8D                 ; Sound effect
  db $D3,$D0                 ; Lose the Cider
  db $D2,$E1                 ; Obtain Leo's Spirits
  db $FE                     ; Return

; ------------------------------------------------------------------------
; Helper for Leo's Grave scene

org $EEB0CD
  db $DE                     ; Load caseword with characters in current party
  db $C0,$A6,$01,$32,$B1,$24 ; If Celes is not in the party, branch to $EEB132
  db $C0,$E1,$01,$26,$B1,$24 ; If you don't have Leo's Spirits, branch to $EEB126
  db $B2,$AC,$C6,$00         ; JSR $CAC6AC
  db $B2,$34,$2E,$01         ; JSR $CB2E34
  db $3C,$06,$FF,$FF,$FF     ; Set up party as follows: Celes, 3x empty
  db $32,$04,$C2,$82,$CC,$FF ; Move character $32 down/left, face up
  db $34,$04,$C2,$A2,$CC,$FF ; Move character $34 down, face up
  db $33,$04,$C2,$A1,$CC,$FF ; Move character $33 down/right, face up
  db $93                     ; Pause for 45 units
  db $06,$02,$21,$FF         ; Celes bows her head
  db $94                     ; Pause for 60 units
  db $4B,$60,$0B             ; Display caption #2911
  db $92                     ; Pause for 30 units
  db $06,$02,$1B,$FF         ; Celes puts her hand up
  db $91                     ; Pause for 15 units
  db $F4,$E9                 ; Play sound effect
  db $94                     ; Pause for 60 units
  db $06,$02,$04,$FF         ; Celes puts her hand back down
  db $92                     ; Pause for 30 units
  db $F4,$8D                 ; Sound effect
  db $4B,$61,$0B             ; Display caption #2912
  db $80,$B0                 ; Add Leo's Crest to party's inventory
  db $D3,$E1                 ; Remove Leo's Spirits
  db $32,$02,$80,$FF         ; Move character $32 up/right
  db $34,$02,$A0,$FF         ; Move character $34 up
  db $33,$02,$A3,$FF         ; Move character $33 up/left
  db $92                     ; Pause for 30 units
  db $4B,$29,$05             ; Display caption #1320
  db $B2,$2B,$2E,$01         ; JSR $CB2E2B
  db $B2,$95,$CB,$00         ; JSR $CACB95
  db $FE                     ; RTS
; $EEB132
  db $4B,$45,$08,$FE         ; Display caption #2116

; ------------------------------------------------------------------------
; Helper for Imperial Sword on Celes during FC escape

org $EEB136
  db $F0,$1F,$D4,$BC   ; [displaced]
  db $80,$13           ; Add Imperial sword to party's inventory
  db $9C,$06           ; Optimize Celes' equipment
  db $D0,$E4           ; Set event bit $1E80($0E4) [1E9C, bit 4]
  db $FE

; $EEB141
  db $B2,$4B,$4B,$01   ; [displaced]
  db $D1,$E4           ; Clear event bit $1E80($0E4) [1E9C, bit 4]
  db $D6,$07           ; Flag the cider merchant to reappear in the WoR
  db $FE

; ------------------------------------------------------------------------
; Helper for healing party before Nimufu battle

org $EEB14A
  db $B2,$BD,$CF,$00      ; JSR $CACFBD
  db $4D,$51,$3F          ; [displaced] Invoke Nimufu battle
  db $B2,$A9,$5E,$00,$FE  ; [displaced] JSR $CA5EA9, then RTS

; ------------------------------------------------------------------------
; Helper for post-IAF health refill event

org $EEB156
  db $35,$30,$35,$31               ; Displaced from JSR above
  db $B2,$BD,$CF,$00,$FE           ; JSR $CACFBD, then RTS

; ------------------------------------------------------------------------
; Helpers for Status Colored ATB Gauges
;
; $2EAF01: Palette #1: $21 - White text
; $2EAF09: Palette #2: $25 - Grey text
; $2EAF11: Palette #3: $29 - Yellow text / Full ATB gauge
; $2EAF19: Palette #4: $2D - Blue
; $2EAF21: Palette #5: $31 - All black (???)
; $2EAF29: Palette #6: $35 - White (charging) ATB gauge
; $2EAF31: Palette #7: $39 - Green Morph gauge
; $2EAF39: Palette #8: $3D - Red Condemned gauge (unused)

org $EEB15F
Palettes:
  incbin bin/palettes-bnw.bin ; include binary palette data

StatusATB:
  LDA $0011,X      ; Status byte 3 (buffer)
  BIT #$10         ; Is Stop status set?
  BEQ .slow        ; Branch if not Stopped
  LDA #$3D         ; Select palette #8           STOPPED
  BRA .store       ; Store palette
.slow
  BIT #$04         ; Is Slow status set?
  BEQ .haste       ; Branch if not Slowed
  LDA #$2D         ; Select palette #4           SLOW
  BRA .store       ; Store palette
.haste
  BIT #$08         ; Is Haste status set?
  BEQ .normal      ; Branch if not Hasted
  LDA #$39         ; Select palette #7           HASTE
  BRA .store       ; Store palette
.normal
  LDA #$35         ; Select palette #6           NORMAL
.store
  RTL

; TODO: Remove code below -- no longer used
  LDA #$39         ; Select palette #7           HASTE
  BRA .store2      ; Store palette
  LDA #$35         ; Select palette #6           NORMAL
.store2
  RTL
; TODO: Remove code above -- no longer used

LeftCap:
  LSR A
  AND #$FC
  TAX
  LDA $04,S
  INC
  BEQ .leftfull
  LDA #$F9
  BRA .drawleftcap
.leftfull
  LDA #$FB
.drawleftcap
  RTL

RightCap:
  INC
  BEQ .rightfull
  LDA #$FA
  BRA .drawrightcap
.rightfull
  LDA #$FC         ; Draw tail end of ATB gauge
.drawrightcap
  JML $C166F3      ; Draw tile A

; -------------------------------------------------------------------------
; Wait Gauge helpers

org $EEB1C4

HelpCaps:
  BMI .full        ; branch if ATB is full
  PEA $FAF9        ; empty endcaps
  BRA .done
.full
  PEA $FCFB        ; special endcaps
.done
  PHA              ; save gauge value
  TDC              ; clear B
  PLA              ; restore gauge value
  AND #$7C         ; masked
  TAX              ; index it
  PLA              ; get first cap value 
  JML FinGauge     ; finish up
NormDraw:
  PHA
  LDA $4E
  XBA
  LDA #$35
  STA $4E
  PLA
  JSL LongDraw
  XBA
  STA $4E
  TDC
  RTL
warnpc $EEB200+1


