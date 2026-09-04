arch 65816
hirom

; Draw info for member 1
org $C33309
	ldx #$1078

; Draw info for member 2
org $C33355
	ldx #$4078

; Draw info for member 3
org $C333A1
	ldx #$7078

; Draw info for member 4
org $C333ED
	ldx #$A078

; Status icon in Skill menu

org $c34ef0
	ldx #$4050	; Y-X axis 

; Display status effects in Status menu
org $C3625E
	LDX #$0A78	; Icon position

; Display status effects in lineup menu
org $C37983
	ldx #$2A48
