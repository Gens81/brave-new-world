arch 65816
hirom
table "menu.tbl", ltr

;****************************************************;
;                       							 ;
; Create Lightning Y button						     ;
;                        							 ;
;****************************************************;

!bank = #$ED

org $EDFCB0
; Update Y's sprite
EDFCB0:  TAX             ; Index mode
         JMP (EDFCB4,X)  ; Handle mode

; Jump table for the above
EDFCB4:  dw EDFCB8       ; Initialize button
         dw EDFCDC       ; Sustain button

; Mode 0: Initialize Y
EDFCB8:  LDX $2D         ; Queue index
         REP #$20        ; 16-bit A
         LDA #EDFCF5     ; Anim table ptr
         STA $32C9,X     ; Set sprite's
         SEP #$20        ; 8-bit A
         LDA !bank       ; Bank: $ED
         STA $35CA,X     ; Set ptr HB
         %FakeC3(1206)   ; Set pose timer
         INC $3649,X     ; Mode +1
         LDA #$01        ; Pans with BG1
         STA $364A,X     ; Set sprite flags
		 
; Mode 1: Sustain Y
EDFCDC:  LDX $2D
		 LDA #$E8         ; Cursor's X
         STA $33CA,X      ; Set sprite's
         LDA #$c6         ; Cursor's Y
		 STA $344A,X      ; Set sprite's
         %FakeC3(1221)    ; Define OAM
		 SEC              ; Set to requeue
         RTL              ; Exit


; Animation table for pushing Y
EDFCF5:  dw EDFCFE       ; Top button sprite
         db $18          ; Frames: 18
         dw EDFD03       ; Pushed button sprite
         db $18          ; Frames: 18
         dw EDFCFE       ; Bogus... 
         db $FF          ; Loop

; OAM for unpushed Y
EDFCFE:  db $01          ; Tiles: 1
         dw $0080        ; 16x16, X+0, Y+0
         dw $3C2E        ; Tile ??, pal 6, prio 3

; OAM for pushed Y
EDFD03:  db $01          ; Tiles: 1
         dw $0080        ; 16x16, X+0, Y+0
         dw $3C0E        ; Tile ??, pal 6, prio 3

; Animation table for holding Y
EDFD06:  dw EDFCFE       ; Top button sprite
         db $18          ; Frames: 18
         dw EDFD03       ; Pushed button sprite
         db $36          ; Frames: 36
         dw EDFCFE       ; Bogus... 
         db $FF          ; Loop

; Update Y's sprite shop
EDFD12:  TAX             ; Index mode
         JMP (EDFD14,X)  ; Handle mode

; Jump table for the above
EDFD14:  dw EDFD1B       ; Initialize button
         dw EDFD2B       ; Sustain button

; Mode 0: Initialize Y
EDFD1B:  LDX $2D         ; Queue index
         REP #$20        ; 16-bit A
         LDA #EDFD06     ; Anim table ptr
         STA $32C9,X     ; Set sprite's
         SEP #$20        ; 8-bit A
         LDA !bank       ; Bank: $ED
         STA $35CA,X     ; Set ptr HB
         %FakeC3(1206)   ; Set pose timer
         INC $3649,X     ; Mode +1
         LDA #$01        ; Pans with BG1
         STA $364A,X     ; Set sprite flags
		 
; Mode 1: Sustain Y
EDFD2B:  LDA $47          ; Menu flags
         AND #$01         ; Actors shown?
         BEQ .DELETE      ; Delete if not
		 LDA $26		  ; Sub-flag
		 CMP #$28		  ; Buying item?
		 BEQ .DELETE	  ; Delete if it is
		 CMP #$27         ; Buying item?
		 BEQ .DELETE      ; Delete if it is
		 LDX $2D
		 LDA #$E8         ; Cursor's X
         STA $33CA,X      ; Set sprite's
         LDA #$86         ; Cursor's Y
		 STA $344A,X      ; Set sprite's
         %FakeC3(1221)    ; Define OAM
		 SEC              ; Set to requeue
         RTL              ; Exit
.DELETE  CLC
		 RTL
		 
; Update Y's sprite
EDFD68:  TAX             ; Index mode
         JMP (EDFD6C,X)  ; Handle mode
		 
; Jump table for the above
EDFD6C:  dw EDFC71       ; Initialize button
         dw EDFC90       ; Sustain button
		 
; Mode 0: Initialize Y
EDFC71:  LDX $2D         ; Queue index
         REP #$20        ; 16-bit A
         LDA #EDFD06     ; Anim table ptr
         STA $32C9,X     ; Set sprite's
         SEP #$20        ; 8-bit A
         LDA !bank       ; Bank: $ED
         STA $35CA,X     ; Set ptr HB
         %FakeC3(1206)   ; Set pose timer
         INC $3649,X     ; Mode +1
         LDA #$01        ; Pans with BG1
         STA $364A,X     ; Set sprite flags
		 
; Mode 1: Sustain Y
EDFC90:  LDA $26
		 CMP #$0A
		 BEQ .delete
		 CMP #$4D
		 BEQ .delete
		 LDX $2D
		 LDA #$E8         ; Cursor's X
         STA $33CA,X      ; Set sprite's
         LDA #$1f         ; Cursor's Y
		 STA $344A,X      ; Set sprite's
         %FakeC3(1221)    ; Define OAM
		 SEC              ; Set to requeue
         RTL              ; Exit
.delete	 CLC
		 RTL
		 
warnpc $edfe00		 

org $ED5AC0
incbin "../GFX/2D5AC0_Y_button_Sprite.bin"