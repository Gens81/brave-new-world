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

warnpc $CB8AE3