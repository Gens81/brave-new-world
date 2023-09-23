hirom
; header

; Based on Think/Seibaby's RNG patch
; Clean up remaining RNG uses to use JSL


org $C0FD00
Random:

; Based on context, these are all likely RNG
org $E5F992 : JSL Random   ; confirmed code by novalia's E5 disasm
org $E5F9AB : JSL Random   ; confirmed code by novalia's E5 disasm
org $E5F9C9 : JSL Random   ; confirmed code by novalia's E5 disasm
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

org $EE86A6 : JSL Random   ; novalia: sets Doomgaze's position
org $EE86B4 : JSL Random   ; novalia: sets Doomgaze's position

; confirmed
org $C26D2F : JSL Random   ; this is moved to 7E/5639 (used in title screen)
org $C2806F : db $22       ; this is converted to two separate RNG calls (7E/6F89, 7E/6F90)
