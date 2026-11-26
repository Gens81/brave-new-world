arch 65816
hirom

; used to calculate relative offsets for jumps and subroutine calls
org $CA0000 : NewEventBase:

; -----------------------------------------------------------------------------
; Allows you to warp out of the ancient castle and its associated cave without soft locking yourself
; Written by Khaos (IAmUrza) 2026-07-27
; -----------------------------------------------------------------------------

org $EDC2B2
    db $06			    	; enable warp in ancient castle cave 1

org $EDC2D3
    db $06			    	; enable warp in ancient castle cave 2

org $EDC357
    db $02			    	; enable warp in ancient castle 1

org $EDC378
    db $02			    	; enable warp in ancient castle 2

org $EDC399
    db $02			    	; enable warp in ancient castle 3

org $CA0144							
    db $B2				    ; call subroutine
    dl WarpHook-NewEventBase	; ^ continued

org $CB84A7
WarpHook:
    db $C0, $6F, $02			; If "bumped something" event bit $26F is clear, break
    dl .skip-NewEventBase     	    	; ^ continued
    db $D5, $6F				; clear "bumped something" event bit $26F
    db $D5, $B7				; clear "prison door is open" event bit $2B7
	db $D7, $97				; clear "sealed castle doors" NPC event bit $397
    db $D3, $06				; clear "castle in east" event bit $106
    db $D0, $DC				; set "castle in west" event bit $0DC
    db $C0, $B9, $02			; if "castle arrival bit" event bit $2B9 is clear, break
    dl .skip-NewEventBase   	      	; ^ continued
    db $D2, $06				; set "castle in east" event bit $106
    db $D1, $DC				; clear "castle in west" event bit $0DC
    db $D4, $B9				; set "castle arrival bit" event bit  event bit $2B9 (sets when you arrive at south figaro. clears when you arrive at kohlingen)
.skip
    db $B2, $59, $01, $00		; call subroutine $CA0159 (overwritten code from warp handler hook)
    db $FE				; return
NewEventScriptFreespace_1:

; -----------------------------------------------------------------------------
; Changes the train conductors in Gogo's Lair so they go away after they knock you down once.
; This code uses event bits $0EE, $0EF, and $0F0.
; Written by Khaos (IAmUrza) 2026-07-17
; -----------------------------------------------------------------------------

org $C45283	
    dl GogoNPC1Hook-NewEventBase		; change set_npc_event jump for conductor #1

org $C4528C
    dl GogoNPC2Hook-NewEventBase		; change set_npc_event jump for conductor #2

org $C45295
    dl GogoNPC3Hook-NewEventBase		; change set_npc_event jump for conductor #3

org $CB7DC4
    db $B2
    dl GogoNPCRoomHook-NewEventBase	; hook to new code when you enter the conductor's room

org NewEventScriptFreespace_1
GogoNPC1Hook:
    db $D0, $EE				    ; set event bit $0EE
    db $B2, $51, $82, $01		; jump to normal "get knocked off" code
    db $FE			        	; return
GogoNPC2Hook:
    db $D0, $EF			    	; set event bit $0EF
    db $B2, $51, $82, $01		; jump to normal "get knocked off" code
    db $FE				        ; return
GogoNPC3Hook:
    db $D0, $F0			    	; set event bit $0F0
    db $B2, $51, $82, $01		; jump to normal "get knocked off" code
    db $FE			        	; return
GogoNPCRoomHook:
    db $7C, $11, $7C, $12		; displaced code from above hook (enables NPC collisions)
    db $C0, $EE, $00			; if event bit $0EE clear, jump over next line
    dl .skip1-NewEventBase			; ^ continued
    db $42, $10			    	; hide conductor #1
.skip1
    db $C0, $EF, $00			; if event bit $0EF clear, jump over next line
    dl .skip2-NewEventBase			; ^ continued
    db $42, $11			    	; hide conductor #2
.skip2
    db $C0, $F0, $00			; if event bit $0F0 clear, jump over next line
    dl .skip3-NewEventBase			; ^ continued
    db $42, $12			    	; hide conductor #3
.skip3
    db $FE			        	; return
NewEventScriptFreespace_2:

; “Banon riding chocobo” pose is missing
; This prevents the bug and gives the player fun dialog

org $CC3336							; Hook to new code if you say 'yes' and hire a Chocobo
	dl BanonCheck-NewEventBase

org $CC333D							; "Chocobo hired" event code
HireChocobo:

org NewEventScriptFreespace_2	
BanonCheck:				
	db $E2							; Set CaseWord bits depending on who is the lead of the current party
	db $BE,01						; If character $0E (BANON ) is in the current CaseWord, branch to .denied	
	dw .denied
	db $E1
    db $B2                          ; else, branch to "Chocobo hired" event code
    dl HireChocobo-NewEventBase
	db $FE							; return
.denied				
	db $4B,$0C,$00					; Display dialogue message, wait for button press
	db $FE							; return
NewEventScriptFreespace_3:

; -----------------------------------------------------------------------------
; Do not unequip Gogo (Kupek) when WoB is destroyed
; This prevents the player from getting a free Buckler and Boomerang
; -----------------------------------------------------------------------------

org $CA4F67 : db $8D,$0B        ; Remove all equipment from character $0B (Actor in stot 11) [Duplicate of prior event command]

; -----------------------------------------------------------------------------
; Sealed Gate cutscene adjustment for "leader" dialog
; This event is adjusted in v2.1, and it is further tweaked here to ensure the leader speaks, instead of Terra.
; -----------------------------------------------------------------------------

org $CB3AA5
	db $3F,$00,$00				; Remove Terra from the party [Moved to happen before caption displays]
	db $45						; Refresh objects [New event command]
	db $4B,$6E,$06				; Display dialogue message $066E, wait for button press: TERRA! …the gate…quickly!
	db $92,$B2,$AC,$38,$01		; Pause for 30 units, then JSR $CB38AC
	db $00,$08,$20,$E0,$01
	db $CE,$E0,$01,$CC,$FF		; Action queue for Terra - nod, then face up
	db $92						; Pause for 30 units
	db $4B,$60,$0A				; Call caption 2655
	db $49,$F4,$CD				; Play sound effect 205 (Kefka's laugh)
	db $B0,$06,$16,$82,$1D
	db $FF,$16,$82,$1E,$FF,$B1	; These two lines = Kefka laughing animation
	db $4B,$61,$0A				; Call caption 2656
	db $4B,$62,$0A				; Call caption 2657
	db $B2,$AB,$4F,$01			; JSR $CB4FAB
	db $FD						; NOPs one unused byte [One of two spare bytes from v2.1 used for above new event command]

; Terra is added to the party later (and event bits are moved to be set early, for the space) in order to ensure the leader speaks.
; The character numbers (for movement during the last part of the cutscene) all needs to be decremented by 1 to maintain functionality, since Terra isnt part of the team yet.

org $CB3B86
	db $D9,$6E					; Clear event bit $1E80($46E) [$1F0D, bit 6]
	db $D9,$6F					; Clear event bit $1E80($46F) [$1F0D, bit 7]
	db $D9,$70					; Clear event bit $1E80($470) [$1F0E, bit 0]
	db $D8,$71					; Set event bit $1E80($471) [$1F0E, bit 1]

org $CB3BA1
	db $31,$02					; Begin action queue for character $31 (Party Character 1), 2 bytes long 
	db $09						; Do vehicle/entity graphical action $09 (kneeling)
	
org $CB3BA5 : db $32			; Begin action queue for character $32 (Party Character 2), 2 bytes long 
org $CB3BA9 : db $33			; Begin action queue for character $33 (Party Character 3), 2 bytes long 
org $CB3BCB : db $31			; Begin action queue for character $31 (Party Character 1), 4 bytes long 
org $CB3BD1 : db $32			; Begin action queue for character $32 (Party Character 2), 4 bytes long 
org $CB3BD9 : db $31			; Begin action queue for character $31 (Party Character 1), 2 bytes long 
org $CB3BE3 : db $32			; Begin action queue for character $32 (Party Character 2), 2 bytes long 
org $CB3BED : db $33			; Begin action queue for character $33 (Party Character 3), 2 bytes long 
org $CB3C07 : db $31			; Begin action queue for character $31 (Party Character 1), 2 bytes long 
org $CB3C0D : db $33			; Begin action queue for character $33 (Party Character 3), 5 bytes long 
org $CB3C14 : db $32			; Begin action queue for character $32 (Party Character 2), 5 bytes long 
org $CB3C22 : db $31			; Begin action queue for character $31 (Party Character 1), 3 bytes long 
org $CB3C27 : db $33			; Begin action queue for character $33 (Party Character 3), 3 bytes long 
org $CB3C2C : db $32			; Begin action queue for character $32 (Party Character 2), 3 bytes long 

org $CB3C33
	db $3F,$00,$01				; Assign character $00 (Actor in stot 0) to party 1
	db $3C,$00,$FF,$FF,$FF		; Set up the party as follows: $00 (Actor in stot 0), $FF (<Invalid Character>), $FF (<Invalid Character>), $FF (<Invalid Character>)
	db $B2,$2B,$2E,$01			; Call subroutine $CB2E2B
	db $39						; Free screen
	db $B2,$95,$CB,$00			; Call subroutine $CACB95
	db $3B						; Position character in a "ready-to-go" stance

; -----------------------------------------------------------------------------
; The post-sealed gate scene in the Imperial camp is adjusted so the emoting is less stupid.
; -----------------------------------------------------------------------------

org $CB2632 : db $D5,$05,$11	; Set vehicle/entity's position to (5, 17)
org $CB263B : db $81			; Move vehicle/entity right 1 tile
org $CB2655 : db $D5,$05,$11	; Set vehicle/entity's position to (5, 17)
org $CB265E : db $81			; Move vehicle/entity right 1 tile
org $CB2678 : db $D5,$05,$11	; Set vehicle/entity's position to (5, 17)
org $CB2681 : db $81			; Move vehicle/entity right 1 tile
org $CB269B : db $D5,$05,$11	; Set vehicle/entity's position to (5, 17)
org $CB26A4 : db $81			; Move vehicle/entity right 1 tile
org $CB26BE : db $D5,$05,$11	; Set vehicle/entity's position to (5, 17)
org $CB26C7 : db $81			; Move vehicle/entity right 1 tile

org $CB2753
	db $CE						; Turn vehicle/entity down
	db $E0,$01					; Pause for 4 * 1 (4) frames
	db $23						; Do vehicle/entity graphical action $23    
org $CB276B
	db $CE						; Turn vehicle/entity down
	db $E0,$01					; Pause for 4 * 1 (4) frames
	db $23						; Do vehicle/entity graphical action $23    
org $CB2783
	db $CE						; Turn vehicle/entity down
	db $E0,$01					; Pause for 4 * 1 (4) frames
	db $23						; Do vehicle/entity graphical action $23    
org $CB279B
	db $CE						; Turn vehicle/entity down
	db $E0,$01					; Pause for 4 * 1 (4) frames
	db $23						; Do vehicle/entity graphical action $23    
org $CB27B3
	db $CE						; Turn vehicle/entity down
	db $E0,$01					; Pause for 4 * 1 (4) frames
	db $23						; Do vehicle/entity graphical action $23

; -----------------------------------------------------------------------------
; Adjusts Celes's scene with Locke on the boat to Thamasa to be more in-character.
; -----------------------------------------------------------------------------

org $CBD27E
	db $14,$82					; Begin action queue for character $14 (NPC $14), 2 bytes long (Wait until complete)
	db $63						; 		Do vehicle/entity graphical action $23, flipped horizontally
	db $FF						; 		End queue
	db $94						; Pause for 60 units
	db $78,$31					; Enable ability to pass through other objects for object $31 (Party Character 0)
	db $31,$8B					; Begin action queue for character $31 (Party Character 0), 11 bytes long (Wait until complete)
	db $C2						; 		Set vehicle/entity's event speed to normal
	db $83						; 		Move vehicle/entity left 1 tile
	db $E0,$06					; 		Pause for 4 * 6 (24) frames
	db $23						; 		Do vehicle/entity graphical action $23 
	db $E0,$0A					; 		Pause for 4 * 10 (40) frames
	db $C3						; 		Set vehicle/entity's event speed to fast
	db $86						; 		Move vehicle/entity down 2 tiles
	db $9D						; 		Move vehicle/entity right 8 tiles
	db $FF						; 		End queue
	db $94						; Pause for 60 units
	db $14,$82					; Begin action queue for character $14 (NPC $14), 2 bytes long (Wait until complete)
	db $60	 					; 		Do vehicle/entity graphical action $20, flipped horizontally
	db $FF						; 		End queue
	db $FD,$FD					; Two spare bytes
	db $5A						; Fade screen at speed $03

; -----------------------------------------------------------------------------
; Stops Cid and the Emperor from phasing through senties prior to banquet
; -----------------------------------------------------------------------------

org $CC84BC
	db $B2									; Call subroutine
	dl guard1move-NewEventBase

org $CC8510	: db $CF						; Have Cid face left
org $CC854B	: db $FD      	 				; Have Cid face downwards
org $CC859F	: db $FD,$FD,$FD,$FD,$FD,$FD	; Always move guard up one space up at event end
org $CC85AA	: db $FD,$FD,$FD,$FD,$FD,$FD	; Always move guard up one space up at event end

org $CC85BC
guard1move:
	db $3D,$16								; [DISPLACED] Create object $16
	db $41,$16								; [DISPLACED] Show object $16
	db $C0,$F0,$01							; If ($1E80($1F0) [$1EBE, bit 0] is clear), branch
	dl guard2move-NewEventBase
	db $17,$83								; Begin action queue for character $17 (NPC $17), 3 bytes long (Wait until complete)
	db $83									; Move vehicle/entity left 1 tile
	db $86									; Move vehicle/entity down 2 tiles
	db $FF									; End queue
	db $D3,	$F0								; Clear event bit $1E80($1F0) [$1EBE, bit 0]
guard2move:
	db $C0,$F1,$01							; If ($1E80($1F1) [$1EBE, bit 1] is clear), branch
	dl guardreturn-NewEventBase
	db $18,$83								; Begin action queue for character $18 (NPC $18), 3 bytes long (Wait until complete)
	db $81									; Move vehicle/entity right 1 tile
	db $86									; Move vehicle/entity down 2 tiles
	db $FF									; End queue
	db $D3,$F1								; Clear event bit $1E80($1F1) [$1EBE, bit 1]
guardreturn:
	db $FE									; Return

padbyte $EA : pad $CC85E3

; -----------------------------------------------------------------------------
; Minor dialogue adjustments per the new dialog "unassigned speaker" changes
; -----------------------------------------------------------------------------

org $CA97AD
	db $FD,$FD,$FD				; Delete the second instance of "Terra?" dialog at Ramuh Moot.

org $CA9CAF
	db $FD,$FD,$FD				; Delete the second instance of "Magicite?" dialog at Ramuh Moot.
	
org $CB30DB
	db $4B,$A0,$06			    ; Display caption 1693 instead of 1686 (This caption was moved to fix a bug that I didn't know how to otherwise fix with caption 1685)

; -----------------------------------------------------------------------------
; Fix up Leo's Crest Scene to be a little smoother
; -----------------------------------------------------------------------------

org $EEB0CD
	db $DE							; Load caseword with characters in current party
	db $C0,$A6,$01					; If Celes is not in the party, branch
	dl GenericGrave-NewEventBase
	db $C0,$E1,$01					; If you don't have Leo's Spirits, branch
	dl CelesGrave-NewEventBase
	db $B2,$AC,$C6,$00				; JSR $CAC6AC
	db $B2,$34,$2E,$01				; JSR $CB2E34
	db $3C,$06,$FF,$FF,$FF			; Set up party as follows: Celes, 3x empty
	db $31,$02,$CC,$FF				; Face character $31, face up
	db $32,$04,$C2,$82,$CC,$FF		; Move character $32 down/left, face up
	db $34,$04,$C2,$A2,$CC,$FF		; Move character $34 down, face up
	db $33,$04,$C2,$A1,$CC,$FF		; Move character $33 down/right, face up
	db $93							; Pause for 45 units
	db $06,$02,$21,$FF				; Celes bows her head
	db $94							; Pause for 60 units
	db $4B,$60,$0B					; Display caption #2911
	db $F6,$81,$10,$60				; Change volume of currently playing song to $60, transition time 16
	db $92							; Pause for 30 units
	db $06,$02,$1B,$FF				; Celes puts her hand up
	db $91							; Pause for 15 units
	db $F4,$20						; Play sound effect
	db $F6,$82,$80,$00				; Subcommand $82: Change volume of currently playing sound effect to $00, transition time 128
	db $95							; Pause for 120 units
	db $06,$02,$04,$FF				; Celes puts her hand back down
	db $92							; Pause for 30 units
	db $F4,$8D						; Sound effect
	db $4B,$61,$0B					; Display caption #2912
	db $F6,$81,$10,$FF				; Change volume of currently playing song to $FF, transition time 16
	db $80,$B0						; Add Leo's Crest to party's inventory
	db $D3,$E1						; Remove Leo's Spirits
	db $92							; Pause for 30 units
	db $4B,$29,$05					; Display caption #1320
	db $B2							; Jump to subroutine (we need more space now)
	dl GraveFreespace-NewEventBase
	db $FE							; RTS (followed by one spare byte?)

org NewEventScriptFreespace_3
GraveFreespace:
	db $32,$03,$80,$CC,$FF			; Move character $32 up/right, face up
	db $34,$03,$A0,$CC,$FF			; Move character $34 up, face up
	db $33,$83,$A3,$CC,$FF			; Move character $33 up/left, face up, (Wait until complete)
	db $B2,$2B,$2E,$01				; JSR $CB2E2B
	db $B2,$95,$CB,$00				; JSR $CACB95
	db $FE							; RTS
CelesGrave:
	db $4B,$29,$05,$FE				; Display caption #1320
GenericGrave:
	db $4B,$45,$08,$FE				; Display caption #2116
NewEventScriptFreespace_4:

; -----------------------------------------------------------------------------
; Expand the FC scene with Shadow, adding some lines to explain what happened to Interceptor
; -----------------------------------------------------------------------------

org $CAD9B1
	db $B2							; Call subroutine
	dl HookFC-NewEventBase
	padbyte $FD						; 28 bytes of NOP's (could be optimized)
	pad $CAD9D1

org $CAD9D7
	db $FD							; Remove an extra pause

org NewEventScriptFreespace_4
HookFC:
	db $B2,$AC,$C6,$00				; JSR $CAC6AC
	db $B2,$34,$2E,$01				; JSR $CB2E34
	db $31,$03,$C2,$CE,$FF			; Face character $31, face down (set normal speed)
	db $32,$04,$C2,$83,$CE,$FF		; Move character $32 left, face down (set normal speed)
	db $33,$04,$C2,$A2,$CD,$FF		; Move character $33 left/down, face right (set normal speed
	db $93							; Pause for 45 units
	db $1B,$82,$09,$FF  			; Shadow (NPC $1B) kneels (Wait until complete)
	db $4B,$52,$08  				; Display dialogue message $0852
	db $92   						; Pause for 30 units
	db $1B,$85,$20,$E0,$02,$23,$FF	; Shadow (NPC $1B) turns head (Wait until complete)
	db $4B,$53,$08   				; Display dialogue message $0853
	db $92   						; Pause for 30 units
	db $B2							; Call subroutine
	dl CheckFC-NewEventBase
	db $92   						; Pause for 30 units
	db $4B,$54,$08  				; Display dialogue message $0854
	db $1B,$82,$CC,$FF				; Shadow (NPC $1B) faces up (Wait until complete)
	db $92   						; Pause for 30 units
	db $31,$85,$20,$E0,$03,$CE,$FF	; Nod character $31's head (Wait until complete)
	db $92   						; Pause for 30 units
	db $32,$03,$81,$CE,$FF			; Move character $32 right, face down
	db $33,$83,$A0,$CE,$FF			; Move character $33 right/up, face down (Wait until complete)
	db $B2,$2B,$2E,$01				; JSR $CB2E2B
	db $B2,$95,$CB,$00				; JSR $CACB95
	db $FE							; RTS
CheckFC:
	db $DE							; Load caseword with characters in current party
	db $C0,$A8,$01					; If ($1E80($1A8) [$1EB5, bit 0] is clear), branch to StragoFC
	dl StragoFC-NewEventBase
	db $4B,$6A,$0A					; Display caption $0A6A (Relm)
	db $FE							; RTS
StragoFC:
	db $C0,$A7,$01					; If ($1E80($1A7) [$1EB4, bit 7] is clear), branch to LockeFC
	dl LockeFC-NewEventBase
	db $4B,$6B,$0A					; Display caption $0A6B (Strago)
	db $FE							; RTS
LockeFC:
	db $C0,$A1,$01					; If ($1E80($1A1) [$1EB4, bit 1] is clear), branch to GenericFC
	dl GenericFC-NewEventBase
	db $4B,$6C,$0A					; Display caption $0A6C (Locke)
	db $FE							; RTS
GenericFC:
	db $4B,$6D,$0A					; Display caption $0A6D (Generic)
	db $FE							; RTS
NewEventScriptFreespace_5:

warnpc $CB8AE3
