arch 65816
hirom

; Text shifting table for stats in ship menu

org $C375E4
	db $20,$04,$00  ; Title
	db $08,$00,$00  ; Nothing
	db $07,$04,$00  ; Nothing
	db $0C,$10,$00  ; Level
	db $0C,$14,$00  ; HP
	db $0C,$18,$00  ; MP
	db $00          ; End
	
; Navigation data for non-party area of Lineup menu
org $C374BE
	db $81          ; Never wraps
	db $00          ; Initial column
	db $00          ; Initial row
	db $07          ; 7 columns
	db $02          ; 2 rows
	
; Cursor positions for non-party area of Lineup menu
org $C374C3
	dw $6408		; Slot 1
	dw $6428		; Slot 2
	dw $6448		; Slot 3
	dw $6468		; Slot 4
	dw $6488		; Slot 5
	dw $64a8		; Slot 6
	dw $64c8		; Slot 7
	dw $8008		; Slot 8
	dw $8028		; Slot 9
	dw $8048		; Slot 10
	dw $8068		; Slot 11
	dw $8088		; Slot 12
	dw $80a8		; Slot 13
	dw $80c8		; Slot 14
	dw $ffff		; Slot 15
	dw $ffff		; Slot 16

; X positions for candidates in Lineup menu
org $C376CA
	db $18			; Slot 1
	db $38			; Slot 2
	db $58			; Slot 3
	db $78			; Slot 4
	db $98			; Slot 5
	db $b8			; Slot 6
	db $d8			; Slot 7
	db $18			; Slot 8
	db $38			; Slot 9
	db $58			; Slot 10
	db $78			; Slot 11
	db $98			; Slot 12
	db $b8			; Slot 13
	db $d8			; Slot 14
	db $ff			; Slot 15
	db $ff			; Slot 16
	
; Y positions for candidates in Lineup menu
org $C376DA
	db $5C			; Slot 1
	db $5C			; Slot 2
	db $5C			; Slot 3
	db $5C			; Slot 4
	db $5C			; Slot 5
	db $5C			; Slot 6
	db $5C			; Slot 7
	db $78			; Slot 8
	db $78			; Slot 9
	db $78			; Slot 10
	db $78			; Slot 11
	db $78			; Slot 12
	db $78			; Slot 13
	db $78			; Slot 14
	db $ff			; Slot 15
	db $ff			; Slot 16
	
; portrait y pos.

org $C37944
	LDA #$2B		; Y

org $C375A0
	dw $598B,$041C	; 30x07 at $598B (Stats)

; New cursor column upon entering 3-party area of Lineup menu
org $C37466  
		 db $00,$00      ; 1 -> 1
         db $01,$01      ; 2 -> 2
         db $02,$01      ; 3 -> 2
         db $03,$02      ; 4 -> 3
         db $04,$03      ; 5 -> 4
         db $05,$04      ; 6 -> 5
         db $06,$05      ; 7 -> 5
         db $07,$06      ; 8 -> 6

; New cursor column upon leaving 3-party area of Lineup menu
C37476:  db $00,$00      ; 1 -> 1
         db $01,$01      ; 2 -> 2
         db $02,$03      ; 3 -> 4
         db $03,$04      ; 4 -> 5
         db $04,$05      ; 5 -> 7
         db $05,$06      ; 6 -> 8