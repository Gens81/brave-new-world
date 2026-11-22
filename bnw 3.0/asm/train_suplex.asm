hirom   

; -------------------------------------------------------------------------
; Use duplicated large caption box battle dialog in different locations to save space
; -------------------------------------------------------------------------

org $D09C73 : db $01,$00	; Display long battle dialogue $00 at bottom of the screen (previously $04)
org $D09F52 : db $01,$5E	; Display long battle dialogue $5E at bottom of the screen (previously $C2)
org $D0A26C : db $01,$29	; Display long battle dialogue $29 at bottom of the screen (previously $37)
org $D0BDDC : db $01,$55	; Display long battle dialogue $55 at bottom of the screen (previously $81)
org $D09F20 : db $01,$55	; Display long battle dialogue $55 at bottom of the screen (previously $BD)

; -------------------------------------------------------------------------
; Update Sr. Behemoth entry script to change battle music
; Updated pointer from v2.1 for more Battle Event space
; -------------------------------------------------------------------------

org $D1EF90 : dw anim_script_025c

; -------------------------------------------------------------------------
; Helper for Sr. Behemoth Battle Event Script
; Relocated from v2.1 for more Battle Event space
; Overwrites part of unused Animation Script $014B: Fire Beam (bg1)
; (This space is shared with the new Meltdown animation, see custom_animations.asm)
; -------------------------------------------------------------------------

org $D03EC1
anim_script_025c:
  db $00,$20                ; speed 1, align to center of character/monster
  db $D1,$01                ; invalidate character/monster sprite priority
  db $C7,$0B,$10,$14,$FF    ; SPC command $10, $14, $FF (play boss music)
  db $89,$37                ; loop start (55 times)
  db $80,$79                ; command $80/$79
  db $0F                    ; [$0F]
  db $8A                    ; loop end
  db $80,$7B                ; command $80/$7B
  db $FF                    ; end of script
							; 9 spare bytes
							
; -------------------------------------------------------------------------
; Move Battle Event script $00 code
; This is so we have more space to make the Battle Event pointer table larger
; -------------------------------------------------------------------------

org $D09800					
dw battleevent0			; Update pointer for Battle Event $00 based on new location

org $D09842
dw battleevent33			; Add a new pointer to the table for Battle Event $21

padbyte $FF : pad $D09876	; Clear out the rest of the junk for the expanded Battle Event pointer table

; -------------------------------------------------------------------------
; [ New Battle Event Script $21 ]
;
; Call with Battle script command: $F7 $22
; Sabin suplexing the Soul Train event, ripped wholesale from the MMMMMMAGIC!? event.
; Terra = Sabin
; Edgar = Cyan
; Locke = Shadow
; The below comments need confirming/cleaning up, per the ancient texts (Synchysi's notes)
; -------------------------------------------------------------------------

org $D0CF4A					; 173 bytes
battleevent33:
DB $0E						; Begin action queue(s).
DB $03,$02					; Queue for Cyan.
DB $92,$9F					; Character move 5 tiles right/2 tiles down with a suprised face and finish his move with a jump.
DB $04,$03					; Queue for Shadow.
DB $BA,$9F					; Character jump once. After he has his "ready to fight" pose.
DB $0F						; Execute queue(s).
DB $0E						; Begin action queue(s).
DB $03,$05					; Queue for Sabin.
DB $98,$A1					; Character turn/face left.
DB $04,$03					; Queue for Shadow.
DB $C8,$9F					; Character jump 4 tiles right/ 1 tile down and bounce when he lands.
DB $0F						; Execute queue(s).
DB $11						; Open dialogue window at the bottom of the screen.
DB $01,$4F					; Display message $4F at the bottom of the screen.
DB $0E						; Begin action queue(s).
DB $03,$02					; Queue for Cyan.
DB $E1,$9F					; Character turn 2 times on himself with arms raised.
DB $0F						; Execute queue(s).
DB $01,$50					; Display message $50 at the bottom of the screen.
DB $0E						; Begin action queue(s).
DB $03,$03					; Queue for Shadow.
DB $FF,$9F					; Character turn/face left and then turn/face right.
DB $0F						; Execute queue(s).
DB $01,$51					; Display message $51 at the bottom of the screen.
DB $01,$53					; Display message $53 at the bottom of the screen.
DB $0E						; Begin action queue(s).
DB $03,$03					; Queue for Shadow.
DB $17,$A0					; Character with a suprised face jump three times.
DB $0F						; Execute queue(s).
DB $01,$54					; Display message $54 at the bottom of the screen.
DB $0E						; Begin action queue(s).
DB $03,$03					; Queue for Shadow.
DB $29,$A0					; Character move 2 tiles up/1 tile right and face up.         
DB $04,$02					; Queue for Cyan.
DB $3F,$A0					; Character move 2 tiles up/1 tile left and face up.
DB $0F						; Execute queue(s).
DB $01,$55					; Display message $55 at the bottom of the screen.
DB $0E						; Begin action queue(s).
DB $03,$02					; Queue for Cyan.
DB $55,$A0					; Character jumps 2 tiles left and face left.
DB $04,$03					; Queue for Shadow.
DB $98,$A1					; Character turn/face left.
DB $0F						; Execute queue(s).
DB $01,$56					; Display message $56 at the bottom of the screen.
DB $0E						; Begin action queue(s).
DB $03,$05					; Queue for Sabin.
DB $6B,$A0					; Character move 4 tiles right/1 tile down with head down.
DB $04,$02					; Queue for Cyan.
DB $92,$A1					; Character turn/face down.
DB $05,$03					; Queue for Shadow.
DB $92,$A1					; Character turn/face down.
DB $0F						; Execute queue(s).
DB $01,$5F					; Display message $5F at the bottom of the screen.
DB $0E						; Begin action queue(s).
DB $03,$03					; Queue for Shadow.
DB $83,$A0					; Character jump 1 tile left/move 2 tile down/face down.
DB $04,$02					; Queue for Cyan.
DB $A6,$A0					; Character turn right/fall down/get up and face down.
DB $0F						; Execute queue(s).
DB $01,$60					; Display message $60 at the bottom of the screen.
DB $0E						; Begin action queue(s).
DB $03,$02					; Queue for Cyan.
DB $C7,$A0					; Character move down 3 tiles
DB $0F						; Execute queue(s).
DB $01,$61					; Display message $61 at the bottom of the screen.
DB $01,$62					; Display message $62 at the bottom of the screen.
DB $0E						; Begin action queue(s).
DB $03,$03					; Queue for Shadow.
DB $DD,$A0					; Character jump 2 tiles down/2 tiles right/face left.
DB $0F						; Execute queue(s).
DB $01,$63					; Display message $63 at the bottom of the screen.
DB $0E						; Begin action queue(s).
DB $03,$05					; Queue for Sabin.
DB $F3,$A0					; Character eyes blink.
DB $0F						; Execute queue(s).
DB $01,$64					; Display message $64 at the bottom of the screen.
DB $0E						; Begin action queue(s).
DB $03,$05					; Queue for Sabin.
DB $02,$A1					; Character eyes blink/character turn left.
DB $0F						; Execute queue(s).
DB $01,$65					; Display message $65 at the bottom of the screen.
DB $0E						; Begin action queue(s).
DB $03,$03					; Queue for Shadow.
DB $A4,$A1					; Character turn/face up.
DB $04,$02					; Queue for Cyan.
DB $A4,$A1					; Character turn/face up.  
DB $05,$05					; Queue for Sabin.
DB $4D,$A1					; Character move up 2 tiles/left 1 tile/face down/do a wink/jump left 3 tiles/face right. (jumps back to his postion in battle formation).*
DB $0F						; Execute queue(s).  
DB $0E						; Begin action queue(s).
DB $03,$03					; Queue for Shadow.
DB $11,$A1					; Character slowly go down 1 tile while keeping his "open mouth" pose (facing down).
DB $04,$02					; Queue for Cyan.
DB $11,$A1					; Character slowly go down 1 tile while keeping his "open mouth" pose (facing down).  
DB $0F						; Execute queue(s).
DB $01,$66					; Display message $66 at the bottom of the screen.
DB $0E						; Begin action queue(s).
DB $03,$03					; Queue for Shadow.
DB $31,$A1					; Character jumps 4 tiles up/5 tiles left with raised harms/face right. (jumps back to his position in battle formation).**
DB $04,$02					; Queue for Cyan.
DB $31,$A1					; Character jumps 5 tiles up/1 tile left with raised harms/face right. (jumps back to his position in battle formation).**
DB $0F						; Execute queue(s).  
DB $10						; Close dialogue window at the bottom of the screen.                
DB $FF						; End of event.

padbyte $FF : pad $D0D000	; 9 bytes of free space

; -------------------------------------------------------------------------
; [ Battle Event Script $00 ]
;
; Same as vanilla, but moved.
; Pointer is updated accordingly, see above.
; Overwrites unused Animation Script $01C1. 
; -------------------------------------------------------------------------

org $D02A90
battleevent0:				; 52 bytes
DB $0E						; clear animations
DB $12						; animations for each actor
DB $7B,$98					; actor 0 (Terra) at $987B
DB $94,$98					; actor 1 (Locke) at $9894
DB $C4,$98					; actor 2 (Cyan) at $98C4
DB $F4,$98					; actor 3 (Shadow) at $98F4
DB $1B,$99					; actor 4 (Edgar) at $991B
DB $3B,$99					; actor 5 (Sabin) at $993B
DB $63,$99					; actor 6 (Celes) at $9963
DB $85,$99					; actor 7 (Strago) at $9985
DB $B5,$99					; actor 8 (Relm) at $99B5
DB $F5,$99					; actor 9 (Setzer) at $99F5
DB $26,$9A					; actor 10 (Mog) at $9A26
DB $61,$9A					; actor 11 (Gau) at $9A61
DB $8B,$9A					; actor 12 (Gogo) at $9A8B
DB $D3,$9A					; actor 13 (Umaro) at $9AD3
DB $F4,$98					; actor 14 (Brown Soldier) at $98F4
DB $51,$9B					; actor 15 (Imp) at $9B51
DB $7B,$98					; actor 16 (Leo) at $987B
DB $94,$98					; actor 17 (Banon) at $9894
DB $C4,$98					; actor 18 (Esper Terra) at $98C4
DB $F4,$98					; actor 19 (Merchant) at $98F4
DB $1B,$99					; actor 20 (Ghost) at $991B
DB $3B,$99					; actor 21 (Kefka) at $993B
DB $90,$9B					; actor 22 (Gestahl) at $9B90
DB $76,$98					; actor 23 (Green Soldier) at $9876
DB $0F						; execute animations
DB $FF						; end of script

padbyte $FF : pad $D02ACA	; Clear out the rest of the unused animation junk

; -------------------------------------------------------------------------
; Monster Script pointer updates
; Prometheus's script is relocated to give Soul Train space to expand
; (Add $8700 to these pointers to get the actual pointer)
; -------------------------------------------------------------------------

org $CF860A
DW $387B				; Monster idx=261 (PrometheusScript:)
DW $17B9				; Monster idx=262 (SoulTrainScript:)

; -------------------------------------------------------------------------
; [Monster Battle Script] orig idx=261, "Prometheus", nb. bytes=23
; Relocated to give space to Soul Train
; -------------------------------------------------------------------------

org $CFBF7B
PrometheusScript:
DB $FC,$06,$36,$30		; If target self has less or equal than 6144 HP
DB $F1,$47				; Targeting: use normal targeting
DB $15					; <MB>Quake
DB $FE					; End If and reset targeting
DB $EF					; Special
DB $F0,$EE,$EE,$FE		; Rand. spell: Battle or Battle or Nothing
DB $FF					; End first wave of attack
DB $FC,$05,$00,$00		; If monster has been attacked
DB $F0,$D1,$FE,$FE		; Rand. spell: HyperDrive or Nothing or Nothing
DB $FF					; End

; -------------------------------------------------------------------------
; [Monster Battle Script] orig idx=262, "Soul Train", nb. bytes=89
; Relocated back 23 bytes to add space for the new battle event call
; New code shown with [ADDITION] tag
; -------------------------------------------------------------------------

org $CF9EB9
SoulTrainScript:
DB $FC,$15,$00,$00		; If VAR000 has all the following bit cleared: 0
DB $F8,$00,$01			; Set VAR000 to 1
DB $D3					; Evil Toot
DB $FE					; End If and reset targeting
DB $FC,$16,$1E,$00		; If the global battle timer is greater than 30
DB $FB,$04,$00			; Sets global battle timer to 0
DB $F0,$D3,$D3,$A9		; Rand. spell: Evil Toot or Evil Toot or Acid Rain
DB $FE					; End If and reset targeting
DB $FC,$08,$44,$0C		; If target random ally is affected by status Berserk
DB $6B					; Elf Fire
DB $FE					; End If and reset targeting
DB $EE					; Battle
DB $FF					; End first wave of attack
DB $FC,$06,$36,$00		; If target self has less or equal than 0 HP
DB $F5,$0C,$05,$FF		; Monsters #1, #2, #3, #4, #5, #6 ???, dies like a boss
DB $FE					; End If and reset targeting
DB $FC,$05,$00,$02		; If monster has been attacked
DB $F3,$0F,$00			; Text: "...the Soul Train is feeling pain!"
DB $FE					; End If and reset targeting
DB $FC,$05,$00,$00		; If monster has been attacked
DB $FC,$0D,$24,$01		; If variable VAR036 is greater than or equal to 1
DB $FE					; End If and reset targeting
DB $FC,$02,$5E,$5E		; [ADDITION] If monster has been attacked by spell: Suplex or Suplex, will target attacker
DB $FC,$17,$03,$00		; [ADDITION] If target Shadow (all allies if N/A) is valid, set it, and
DB $F7,$21				; [ADDITION] Trigger event: New Battle Event $21
DB $F8,$24,$81			; [ADDITION] 1 added to VAR036
DB $FE					; [ADDITION] End If and reset targeting
DB $FC,$02,$5E,$5E		; If monster has been attacked by spell: Suplex or Suplex, will target attacker
DB $F3,$0E,$00			; Text: "ACHIEVEMENT UNLOCKED / SUPLEXED A TRAIN"
DB $F8,$24,$81			; 1 added to VAR036
DB $FE					; End If and reset targeting
DB $FC,$05,$00,$00		; If monster has been attacked
DB $F0,$EF,$FE,$FE		; Rand. spell: Special or Nothing or Nothing
DB $FF					; End