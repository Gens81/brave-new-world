arch 65816
hirom

;------------------------------------------------------------------
;Dialogues and DTE table
;------------------------------------------------------------------

org $C0DFA0
	incbin "../scripts/DTE_table.bin"

warnpc $C0E0A0
;-------------------------------------------------------------------

check bankcross off

org $CCE600
	incbin "../scripts/town_dialog.bin"

check bankcross on

warnpc $CEF100
;-------------------------------------------------------------------

org $CFDFE0
	incbin "../scripts/short_battle_dialog.bin"

warnpc $CFF450
;-------------------------------------------------------------------

org $D0D000
	incbin "../scripts/long_battle_dialog.bin"

warnpc $D0FD00

;-------------------------------------------------------------------
;Battle enemy scripts
;------------------------------------------------------------------

org $CF8400

	incbin "../scripts/monster_scripts.bin"
	
warnpc $CFC050

