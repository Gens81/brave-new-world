; #########################################################################
;
; Wrexsoul Battle Update
;
; Gi Nattak changed to apply "Condemned" status
;	- Players will know who is possessed
;	- Should reduce number of self-kills from 2.5 (on average) to 1
;
; MP Damage will cause Wrexsoul to miss a turn instead of casting Gi Nattak
;	- MP damage is still strong, but will not trivialize the fight for veterans
;
; #########################################################################

hirom

org $C476B7

	db $01						; Adds Condemned to Gi Nattak

org $CF8842

	db $F0, $10, $16, $0D		; Use Attack: Dark, Demi, or Doom
	db $FD						; Wait One Turn
	db $F0, $1E, $27, $1A		; Use Attack: SleepX, SlowX, or Rasp
	db $FD						; Wait One Turn
	db $1A						; Use Attack: Rasp
	db $FD						; Wait One Turn
	
	db $FC, $0D, $24, $01		; Conditional: If MONSTER VAR >= 1
	db $F8, $24, $00			; MONSTER VAR = 0
	db $F3, $5C, $00			; Display Monster Dialogue: "Wrexsoul came to his senses!"
	db $FE						; End Conditional

;								  If that conditional doesnt happen, instead this happens:
;	db $DA						  Use Attack: Gi Nattak
;	db $FF						  End of Script


	