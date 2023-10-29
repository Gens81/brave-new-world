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

; skip to banquet option (Fëanor)

!free = $CB5790
!offset = $CA0000

; update event script of left door
org $CC85E3
    db $C0,$27,$01              ; always jump to target
    dl LeftDoor-!offset         ; ^ continued
padbyte $FE : pad $CC85EB

; update event script of right door
org $CC860D
    db $C0,$27,$01              ; always jump to target
    dl RightDoor-!offset        ; ^ continued
padbyte $FE : pad $CC8615

org $CC8A96 : Banquet:          ; entry point when timer expires

; new event code that gives the player the option to skip directly to the
; banquet during the "talk to the soldiers" segment
org !free
LeftDoor:
    db $C1,$3C,$81,$F1,$81,$B3  ; [displaced] if $13C==On || $1F1==On return else
    db $5E,$00                  ; [displaced] ^ continue
    db $C0,$7C,$00,$EB,$85,$02  ; if $07C==Off jump to $CC85EB else continue
    db $C0,$27,$01              ; always jump to target
    dl Choice-!offset           ; ^ continued
RightDoor:
    db $C1,$3C,$81,$F1,$81,$B3  ; [displaced] if $13C==On || $1F1==On return else
    db $5E,$00                  ; [displaced] ^ continue
    db $C0,$7C,$00,$15,$86,$02  ; if $07C==Off jump to $CC8615 else continue
    db $C0,$27,$01              ; always jump to target
    dl Choice-!offset           ; ^ continued
Choice:
    db $4B,$DD,$06              ; display caption $06DD
    db $B6                      ; jump based on choice
    dl StepBack-!offset         ; ^ continued
    dl Banquet-!offset          ; ^ continued
    db $FE                      ; return
StepBack:
    db $31,$82,$82,$FF          ; action queue for player character
    db $FE                      ; return

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
