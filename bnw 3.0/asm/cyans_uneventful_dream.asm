; -----------------------------------------------------------------------------
; This a port of PowerPanda's "Cyan's Uneventful Dream" hack which removes the
; party splitting sequence at the beginning of Cyan's dream. Instead of
; rescuing the other two party members, you rescue pieces of Cyan's psyche.
; 
; Removing this sequence frees up ~1600 bytes of event space (CB/84A3-CB/8AE0)
; as well as space for 23 additional NPCs.
; -----------------------------------------------------------------------------
hirom

; update event triggers
org $C41431
    db $19,$33,$8C,$8B,$01  ; Stooge #3
    db $1C,$31,$8C,$8B,$01  ; Stooge #3
    db $0F,$2B,$72,$8B,$01  ; Stooge #2
    db $13,$2B,$72,$8B,$01  ; Stooge #2
    db $2E,$38,$B3,$8B,$01  ; Final door
    db $0D,$32,$58,$8B,$01  ; Stooge #1
    db $0E,$32,$58,$8B,$01  ; Stooge #1
    db $2E,$37,$CA,$8B,$01  ; Final door
    db $17,$35,$C7,$51,$01  ; Save point

; update NPCs
org $C45685
    db $B3,$5E,$94,$CC,$17,$B5,$6F,$10,$47 ; Save point
    db $E3,$8A,$91,$8E,$0D,$71,$02,$00,$06 ; Cyan #1
    db $0A,$8B,$D1,$8E,$11,$2E,$02,$00,$06 ; Cyan #2
    db $31,$8B,$11,$8F,$1B,$B4,$02,$00,$06 ; Cyan #3
    db $B3,$5E,$4C,$8F,$0E,$31,$26,$00,$06 ; Stooge #1
    db $B3,$5E,$8C,$8F,$12,$2D,$26,$00,$06 ; Stooge #2
    db $B3,$5E,$CC,$8F,$1A,$73,$26,$00,$06 ; Stooge #3
    db $B3,$5E,$04,$90,$12,$81,$13,$00,$06 ; unused
    db $B3,$5E,$00,$90,$13,$81,$14,$00,$06 ; unused
    db $B3,$5E,$14,$90,$14,$81,$12,$00,$06 ; unused
    db $B3,$5E,$0C,$90,$15,$81,$15,$00,$06 ; unused
    db $B3,$5E,$0C,$90,$16,$81,$16,$00,$06 ; unused
    db $B3,$5E,$08,$90,$00,$81,$00,$00,$06 ; unused
    db $B3,$5E,$04,$90,$01,$81,$01,$00,$06 ; unused
    db $B3,$5E,$10,$90,$02,$41,$02,$00,$06 ; unused
    db $B3,$5E,$10,$90,$03,$01,$03,$00,$16 ; unused
    db $B3,$5E,$00,$90,$04,$81,$04,$00,$06 ; unused
    db $B3,$5E,$00,$90,$05,$01,$05,$00,$06 ; unused
    db $B3,$5E,$00,$90,$06,$01,$06,$00,$06 ; unused
    db $B3,$5E,$0C,$90,$07,$41,$07,$00,$06 ; unused
    db $B3,$5E,$0C,$90,$08,$81,$08,$00,$06 ; unused
    db $B3,$5E,$10,$90,$09,$81,$09,$00,$06 ; unused
    db $B3,$5E,$14,$90,$0A,$81,$0A,$00,$06 ; unused
    db $B3,$5E,$0C,$90,$0B,$81,$0B,$00,$06 ; unused
    db $B3,$5E,$0C,$90,$0C,$81,$0C,$00,$06 ; unused
    db $B3,$5E,$14,$90,$0D,$81,$0D,$00,$06 ; unused
    db $B3,$5E,$00,$90,$0E,$01,$0F,$00,$06 ; unused
    db $B3,$5E,$00,$90,$0F,$01,$10,$00,$06 ; unused
    db $B3,$5E,$0C,$90,$10,$01,$11,$00,$06 ; unused
    db $B3,$5E,$04,$90,$11,$81,$0E,$10,$06 ; unused

; enable event bits
org $CB847B
    db $DA,$3A                  ; set event bit $53A
    db $DA,$3B                  ; set event bit $53B
    db $DA,$3C                  ; set event bit $53C
    db $DA,$3D                  ; set event bit $53D

; change pose of Cyan NPCs
org $CB8496
    db $11,$02,$28,$FF          ; action queue for NPC 1
    db $12,$02,$28,$FF          ; action queue for NPC 2
    db $13,$02,$28,$FF          ; action queue for NPC 3
    db $FE                      ; return

; free unused space
org $CB84A3 : padbyte $FE : pad $CB8AE3

; event script for Cyan #1
org $CB8AE3
    db $B2,$FF,$CA,$00          ; call subroutine $CACAFF (adjust positions)
    db $92                      ; wait for 30 frames (1/2 second)
    db $11,$85,$09,$E0,$03,$CE  ; action queue for NPC 1
    db $FF                      ; ^ continued
    db $B0,$03                  ; start repeat (3 repetitions)
    db $11,$82,$23,$FF          ; action queue for NPC 1
    db $11,$82,$63,$FF          ; action queue for NPC 1
    db $B1                      ; end repeat
    db $11,$82,$CE,$FF          ; action queue for NPC 1
    db $92                      ; wait for 30 frames (1/2 second)
    db $55,$80                  ; flash screen blue
    db $F4,$45                  ; play sound effect $45
    db $42,$11                  ; hide NPC 1
    db $3E,$11                  ; delete NPC 1
    db $DB,$3A                  ; clear event bit $53A
    db $FE                      ; return

; event script for Cyan #2
org $CB8B0A
    db $B2,$FF,$CA,$00          ; call subroutine $CACAFF (adjust positions)
    db $92                      ; wait for 30 frames (1/2 second)
    db $12,$85,$09,$E0,$03,$CE  ; action queue for NPC 2
    db $FF                      ; ^ continued
    db $B0,$03                  ; start repeat (3 repetitions)
    db $12,$82,$23,$FF          ; action queue for NPC 2
    db $12,$82,$63,$FF          ; action queue for NPC 2
    db $B1                      ; end repeat
    db $12,$82,$CE,$FF          ; action queue for NPC 2
    db $92                      ; wait for 30 frames (1/2 second)
    db $55,$20                  ; flash screen red
    db $F4,$45                  ; play sound effect $45
    db $42,$12                  ; hide NPC 2
    db $3E,$12                  ; delete NPC 2
    db $DB,$3B                  ; clear event bit $53B
    db $FE                      ; return

; event script for Cyan #3
org $CB8B31
    db $B2,$FF,$CA,$00          ; call subroutine $CACAFF (adjust positions)
    db $92                      ; wait for 30 frames (1/2 second)
    db $13,$85,$09,$E0,$03,$CE  ; action queue for NPC 3
    db $FF                      ; ^ continued
    db $B0,$03                  ; start repeat (3 repetitions)
    db $13,$82,$23,$FF          ; action queue for NPC 3
    db $13,$82,$63,$FF          ; action queue for NPC 3
    db $B1                      ; end repeat
    db $13,$82,$CE,$FF          ; action queue for NPC 3
    db $92                      ; wait for 30 frames (1/2 second)
    db $55,$40                  ; flash screen green
    db $F4,$45                  ; play sound effect $45
    db $42,$13                  ; hide NPC 3
    db $3E,$13                  ; delete NPC 3
    db $DB,$3C                  ; clear event bit $53C
    db $FE                      ; return

; event script for Stooge #1
org $CB8B58
    db $C0,$88,$81,$B3,$5E,$00  ; return if $188==On else continue
    db $14,$07,$C2,$DC,$E0,$03  ; action queue for NPC 4
    db $FC,$03,$FF              ; ^ continued
    db $B2,$A6,$8B,$01          ; call subroutine $CB8BA6
    db $42,$14                  ; hide NPC 4
    db $DB,$3D                  ; clear event bit $53D
    db $D2,$88                  ; set event bit $188
    db $FE                      ; return

; event script for Stooge #2
org $CB8B72
    db $C0,$89,$81,$B3,$5E,$00  ; return if $189==On else continue
    db $15,$07,$C2,$DC,$E0,$03  ; action queue for NPC 5
    db $FC,$03,$FF              ; ^ continued
    db $B2,$A6,$8B,$01          ; call subroutine $CB8BA6
    db $42,$15                  ; hide NPC 5
    db $DB,$3E                  ; clear event bit $53E
    db $D2,$89                  ; set event bit $189
    db $FE                      ; return

; event script for Stooge #3
org $CB8B8C
    db $C0,$8B,$81,$B3,$5E,$00  ; return if $18B==On else continue
    db $16,$07,$C2,$DC,$E0,$03  ; action queue for NPC 6
    db $FC,$03,$FF              ; ^ continued
    db $B2,$A6,$8B,$01          ; call subroutine $CB8BA6
    db $42,$16                  ; hide NPC 6
    db $DB,$3F                  ; clear event bit $53F
    db $D2,$8B                  ; set event bit $18B
    db $FE                      ; return

org $CB8BA6
    db $4B,$CD,$0A              ; display caption $0ACD
    db $F4,$45                  ; play sound effect $45
    db $55,$80                  ; flash screen blue
    db $92                      ; wait for 30 frames (1/2 second)
    db $F4,$45                  ; play sound effect $45
    db $55,$80                  ; flash screen blue
    db $FE                      ; return

; event script for final door (repeling the player)
org $CB8BB3
    db $CA,$3A,$05,$3B,$05,$3C  ; return if $53A==Off && $53B==Off && $53C==Off
    db $05,$B3,$5E,$00          ; ^ else continue
    db $F4,$F7                  ; play sound effect $F7
    db $55,$60                  ; flash screen yellow
    db $91                      ; wait for 15 frames (1/4 second)
    db $55,$60                  ; flash screen yellow
    db $91                      ; wait for 15 frames (1/4 second)
    db $B2,$8D,$9A,$01          ; call subroutine $CB9A8D
    db $FE                      ; return

; event script for final door (boss battle)
org $CB8BCA
    db $C0,$79,$81,$59,$8C,$01  ; if $179==On jump to $CB8C59 else continue
    db $55,$20                  ; flash screen red
    db $91                      ; wait for 15 frames (1/4 second)
    db $55,$20                  ; flash screen red
    db $91                      ; wait for 15 frames (1/4 second)
    db $B3,$03,$8D,$9A,$01      ; call subroutine $CB9A8D, 3 times
    db $DA,$3D                  ; set event bit $53D
    db $DA,$3E                  ; set event bit $53E
    db $DA,$3F                  ; set event bit $53F
    db $3D,$14                  ; create NPC 4
    db $3D,$15                  ; create NPC 5
    db $3D,$16                  ; create NPC 6
    db $93                      ; wait for 45 frames (3/4 second)
    db $14,$05,$D5,$2E,$37,$CE  ; action queue for NPC 4
    db $FF                      ; ^ continued
    db $15,$05,$D5,$2E,$37,$CE  ; action queue for NPC 5
    db $FF                      ; ^ continued
    db $16,$85,$D5,$2E,$37,$CE  ; action queue for NPC 6
    db $FF                      ; ^ continued
    db $F4,$55                  ; play sound effect $55
    db $41,$14                  ; show NPC 4
    db $78,$14                  ; enable passability for NPC 4
    db $14,$84,$C2,$DC,$82,$FF  ; action queue for NPC 4
    db $92                      ; wait for 30 frames (1/2 second)
    db $41,$15                  ; show NPC 5
    db $41,$16                  ; show NPC 6
    db $F4,$55                  ; play sound effect $55
    db $15,$05,$C2,$DC,$83,$CE  ; action queue for NPC 5
    db $FF                      ; ^ continued
    db $16,$85,$C2,$DC,$81,$CE  ; action queue for NPC 6
    db $FF                      ; ^ continued
    db $93                      ; wait for 45 frames (3/4 second)
    db $4B,$C9,$8A              ; display caption $8AC9
    db $F4,$55                  ; play sound effect $55
    db $14,$05,$C2,$C7,$DC,$82  ; action queue for NPC 4
    db $FF                      ; ^ continued
    db $15,$05,$C2,$C7,$DC,$82  ; action queue for NPC 5
    db $FF                      ; ^ continued
    db $16,$85,$C2,$C7,$DC,$82  ; action queue for NPC 6
    db $FF                      ; ^ continued
    db $4B,$CE,$8A              ; display caption $8ACE
    db $4D,$5A,$3F              ; invoke event battle: Shemp, Curly, Larry, Moe
    db $B2,$A9,$5E,$00          ; call subroutine $CA5EA9 (post-battle)
    db $DB,$3D                  ; clear event bit $53D
    db $DB,$3E                  ; clear event bit $53E
    db $DB,$3F                  ; clear event bit $53F
    db $D3,$84                  ; clear event bit $184
    db $D3,$85                  ; clear event bit $185
    db $D3,$86                  ; clear event bit $186
    db $42,$14                  ; hide NPC 4
    db $42,$15                  ; hide NPC 5
    db $42,$16                  ; hide NPC 6
    db $96                      ; fade screen back in
    db $D2,$79                  ; set event bit $179
    db $FE                      ; return
