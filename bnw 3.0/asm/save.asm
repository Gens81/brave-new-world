arch 65816
hirom

;;-----------------------------------------------------
;;-----------------------------------------------------
;;
;;$C3FDD1-$C3FFFF Free Space
;;
;;$C3FDD1:
;;15 bytes used by save menu (New Game -> Nuova Partita)
;;
;;$C3FDE1:
;;10 bytes used by main menu (Order -> Schiera)
;;
;;-----------------------------------------------------
;;-----------------------------------------------------

table "menu.tbl",ltr ; Tabella per le stringhe di testo

;;-----------------------------------------------------
;;-----------------------------------------------------
;;
;;Save menu
;;
;;-----------------------------------------------------
;;-----------------------------------------------------

;;-------------------------------------------------
;;Save pointers
;;-------------------------------------------------

org $C3168D
	dw #Empty
	
org $C316BF
	dw #Empty2
	
org $C316F1
	dw #Empty3
	
org $C31747
	dw #Time1
	
org $C317F4
	dw #Time2
	
org $C31857
	dw #Time3
	
org $C31722
	dw #Colonsave
	
org $C317CF
	dw #Colonsave2
	
org $C31832
	dw #Colonsave3
	
org $C3175B
	dw #LVsave
	
org $C31808
	dw #LVsave2
	
org $C3186B
	dw #LVsave3
	
org $C31765
	dw #Slashsave
	
org $C31812
	dw #Slashsave2
	
org $C31875
	dw #Slashsave3
	
org $C31600
	dw #Savesave
	
org $C3162A
	dw #NewGame

;;-------------------------------------------------
;;Save data
;;-------------------------------------------------
Org $C31A24
Empty:
	db $4F,$7A,"Empty",$00
	
Empty2:
	db $0F,$7C,"Empty",$00
	
Empty3:
	db $CF,$7D,"Empty",$00
	
Time1:
	db $CD,$7A,"Time",$00
	
Time2:
	db $8D,$7C,"Time",$00
	
Time3:
	db $4D,$7E,"Time",$00
	
Colonsave:
	db $11,$7B,":",$00
	
Colonsave2:
	db $D1,$7C,":",$00

Colonsave3:
	db $91,$7E,":",$00

LVsave:
	db $7B,$7A,"LV",$00
	
LVsave2:
	db $3B,$7C,"LV",$00
	
LVsave3:
	db $FB,$7D,"LV",$00
	
Slashsave:
	db $FB,$7A,"/",$00
	
Slashsave2:    
	db $BB,$7C,"/",$00

Slashsave3:    
	db $7B,$7E,"/",$00
	
Savesave:
	db $65,$79,"Save",$00

NewGame:
	db $61,$79,"New Game",$00