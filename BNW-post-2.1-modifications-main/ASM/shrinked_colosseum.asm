arch 65816
hirom
table "menu.tbl", ltr

!EL = $1D10
!EP = $1CF8
!EP_Chart = $ED8BCA
!Ramuh_Chk = $F392
!Char_Chk = $F399
!EL_bank = $1D1C
  
; #########################################################################
; Draw Item Row (used in item menu and colosseum)

org $C37FD0 : JMP ItemNameFork ; hook for colosseum item row


; ------------------------------------------------------------------------
; Colosseum Item Row drawing helpers
; Include prize item on line with item row

org $C3F1B8
ItemNameFork:
  LDA $26                 ; current system op
  CMP #$71                ; "Init Colosseum Item Selection"
  BEQ .colosseum_menu     ; branch if ^
  CMP #$72                ; "Sustain Colosseum Item Selection"
  BEQ .colosseum_menu     ; branch if ^
  JSR $80B9               ; else, do regular "Item Menu" rows
  JMP $7FD3
  ;JSR $7FD9               ; display text
  ;JMP $7FE6               ; display item type
.colosseum_menu
  JSR Set_Arrow			  ; check if the item to print return a prize
  JSR colosseum_setup     ; setup colosseum variables  
  JSR string_init         ; init the string
  JSR string_bet          ; display bet item
  JSR string_display      ; display the string
  JSR position_advance_1A ; advance position for next display
  JSR string_init         ; init the string
  JSR string_delimiter    ; dislay delimiter
  JSR string_display      ; display the string
  JSR position_advance_02 ; advance position for next display
  JSR string_init         ; init the string
  JSR string_reward       ; display reward item
  JSR string_display      ; display the string
  JSR position_advance_1A ; advance position for next display
  RTS

 
colosseum_setup:
  TDC                     ; zero A/B
  LDA $E5                 ; row index in menu
  TAY                     ; index it
  LDA $0250,Y             ; item ID in slot
  STA $0205               ; save item to bet
  JSR $B22C               ; setup Colosseum variables
  RTS

string_init:
  LDX #$9E8B              ; start of text in WRAM buffer
  STX $2181               ; set WRAM destination
  RTS

string_display:
  JSR $7FD9               ; draw string [TODO: remove needless wrapper]
  RTS

string_fill:
  LDX #$000D              ; length of item name
.loop
  STA $2180               ; write fill character
  DEX                     ; decrement iterator
  BNE .loop               ; loop till all written
  STZ $2180               ; set EOL
  RTS

position_advance_02:
  LDX #$0002              ; advance $02 spaces
  BRA position_advance
position_advance_1A:
  LDX #$001A              ; advance $1A spaces
position_advance:
  REP #$20                ; 16-bit A
  TXA                     ; tiles to advance
  CLC                     ; clear carry
  ADC $7E9E89             ; add to text tilemap position
  STA $7E9E89             ; set new text tilemap position
  SEP #$20                ; 8-bit A
  RTS

string_reward:
  LDA $0209               ; mask flag
  BNE .case_mask          ; branch if hidden prize
  LDA $0205               ; bet item ID
  CMP #$FF                ; null?
  BEQ .case_empty         ; branch if empty item
.case_default
  LDA $0207               ; reward item
  JSR $C068               ; load item name [TODO JMP]
  RTS
.case_mask
  LDA #$BF                ; '?' character
  JSR string_fill         ; fill item name with '????'
  RTS
.case_empty
  LDA #$FF                ; ' ' character
  JSR string_fill         ; fill item name with '    '
  RTS

string_delimiter:
  LDA $0205               ; bet item ID
  CMP #$FF                ; null?
  BEQ .case_empty         ; branch if ^
.case_default
  LDA #$D5                ; '>' character (right-facing arrow)
  BRA .set_char           ; branch and write ^
.case_empty
  LDA #$FF                ; ' ' character
.set_char
  STA $2180               ; write chosen delimiter
  STZ $2180               ; end of string
  RTS

string_bet:
  LDA $0205               ; item ID to bet
  CMP #$FF                ; null?
  BEQ .case_empty         ; branch if ^
.case_default
  LDA $0205               ; item ID to bet [TODO: Redundant]
  JSR $C068               ; load item name [TODO: JMP]
  RTS
.case_empty
  LDA #$FF                ; space character
  JSR string_fill         ; fill item name with spaces
  RTS    

; Load item description in Colosseum menu

org $C3FF00
load_item_desc:
	JSR $8308	; Set desc ptrs
    TDC			; Clear A
	LDA $4D		; load column position
	CMP #$01	; is reward column?
	BEQ .reward ; branch if so
    LDA $4B		; Cursor slot
	LSR			; /2 (cursor slot must be /2 due to 2 column menu)
	TAY			; Index it
    LDA $0250,Y	; Item in slot
.load
	JSR $5738	; Load description
	RTS
.reward
	LDA $4B		; cursor slot
	DEC $4B		; subtract $01 and make pair number
	LSR			; /2 (like above)
	TAY			; index it
	LDA $0D40,Y ; reward in slot
	BRA .load	; branch and load desc.

Set_Arrow:
    LDA #$75				; load new colosseum limit 
	STA $5C					; set
    lda #$FF             
	sta $357a
	JMP check_reward_item
;-------------------------------------------------------------------------;
;   This routine make a kind of "mirroring" effect on the items that      ;
;   return a reward in the colosseum menu.                                ;
;                                                                         ;
;   loop go on seeking untill it find an item that return a reward and    ;
;   and than print the progression ID in RAM thanks to loop2              ;
;-------------------------------------------------------------------------;

check_reward_item:
	LDY $00         ; clear Y
.loop2
    PHY             ; save Y
    LDY $F0         ; load Y
.loop
    TDC             ; clear A
    LDA $1869,Y     ; load item ID in slot  
    REP #$20        ; 16-bit A      
    ASL A           ; x2                 
    ASL A           ; x4                
    TAX             ; index it      
    PHX             ; save X (in case you have a reward item)
    SEP #$20        ; 8-bit A     
    INY             ; increase Y (for next item)
    LDA $DFB602,X   ; load value if the item get a reward or not
    PLX             ; load X
    CMP #$BC        ; can you have a reward?
    BEQ .loop       ; branch if not
    CPY #$0100      ; compare if you have check all the reward item
    BEQ .end        ; branch
    STY $F0         ; save actual Y index in $F0
	PLY 			; restore Y
	STA $0D40,Y		; save reward item id
	REP #$20        ; 16-bit A
    TXA             ; transfer X to A 
    LSR             ; /4
    LSR             ; /2
    SEP #$20        ; 8-bit A
    STA $0250,Y     ; save A (item reward ID)
    INY             ; increment Y
    BRA .loop2      ; go on
.end                
    STZ $F0         ; clear $F0
    STZ $F1
    PLY             ; (no use, just to restore the stack)
    RTS             ; go on
Colosseum_Cursor:
	LDA $26                 ; current system op
    CMP #$71                ; "Init Colosseum Item Selection"
    BEQ .colosseum_menu     ; branch if ^
    CMP #$72                ; "Sustain Colosseum Item Selection"
    BEQ .colosseum_menu     ; branch if ^
	JMP $7D1C               ; jump and init menu navigation data
.colosseum_menu
; Load navigation data for Colosseum
    LDY #Col_Navi_Data      ; C3/7D2B
    JMP $05FE               ; Load navig data
; Navigation data forColosseum
handle_D_Pad:
    JSR $81C7           ; Handle D-Pad
finger_pos:
    LDY #Col_Curs_Pos       ; C3/7D30
    JMP $0648               ; Relocate cursor
; Navigation data & Cursor positions for Colosseum
Col_Navi_Data:
    db $01              ; Wraps horizontally
    db $00              ; Initial column
    db $00              ; Initial row
    db $02              ; 1 column
    db $0B              ; 11 rows
Col_Curs_Pos: 
    dw $4a08+$400            ; Item 1
    dw $4a6F+$400			; Reward 1	
    dw $5608+$400            ; Item 2
    dw $566F+$400			; Reward 2	
    dw $6208+$400            ; Item 3
    dw $626F+$400			; Reward 3	
    dw $6e08+$400            ; Item 4
    dw $6e6F+$400			; Reward 4	
    dw $7a08+$400            ; Item 5
    dw $7a6F+$400			; Reward 5	
    dw $8608+$400            ; Item 6
    dw $866F+$400			; Reward 6	
    dw $9208+$400            ; Item 7z
    dw $926F+$400			; Reward 7	
    dw $9e08+$400            ; Item 8
    dw $9e6F+$400			; Reward 8	
    dw $aa08+$400            ; Item 9
    dw $aa6F+$400			; Reward 9	
    dw $b608+$400            ; Item 10
    dw $b66F+$400			; Reward 10	
    dw $c208+$400            ; Item 11
	dw $c26F+$400			; Reward 11
; New code if pushing A in colosseum menu
Handle_A:
	TDC				; Clear A
	LDA $4D			; load column position
	CMP #$01		; is reward column?
	BEQ .error
    LDA $4B			; Selected slot
	LSR
	JMP $ACF9
.error
	JMP $AD0E	
Clear_0D40:
	STA $27         ; Queue menu exit
    STZ $26         ; Next: Fade-out
	LDX $00			; clear x
.clear_0D40
	STZ $0D40,X
	INX
	CPX #$0100
	BNE .clear_0D40
	RTS
	
warnpc $C40000

; 71: Initialize Colosseum item menu
org $C3ACAA
    STZ $0201       ; Face Shadow: No
    LDA $0205       ; Empty item...
    JSR $9D5E       ; Add to stock...
    JSR $1AE2       ; Init list vars
    JSR finger_pos  ; Relocate cursor
    JSR $AD27       ; Draw/Upload menu
    TDC             ; Gradient set: 0
    JSL $D4CA1D     ; Create gradient
    JSR $1B0E       ; Shift & OBJ & Fade
    JSR $3F99       ; Apply user font
    LDA #$01        ; CGRAM: Refresh
    TSB $45         ; Set NMI flag
    JSR $1368       ; Refresh screen
    LDA #$72        ; C3/ACDC
    STA $27         ; Queue: Sustain menu
    LDA #$02        ; Main cursor: On
    STA $46         ; Bar/Blinker: Off
    JSR $07B0       ; Queue cursor OAM
    JMP $3541       ; BRT:1 + NMI
    
; Load description
org $C3AD65  
    JSR load_item_desc	; Load description

; 72: Sustain Colosseum item menu
org $C3ACDC
	LDA #$10			; Description: On
	TRB $45				; Set menu flag
	STZ $2A				; List type: Stock
	JSR $0EFD			; Queue list upload
	JSR $1F64			; Handle L and R
	BCS $3C 			; Exit if pushed
	JSR handle_D_Pad	; Handle D-Pad
	JSR load_item_desc	; Load description

; Fork: Handle A
org $C3ACF0  
    LDA $08        ; No-autofire keys
    BIT #$80       ; Pushing A?
    BEQ .AD14      ; Branch if not
    JMP Handle_A
	TAX            ; Index it
    LDA $0250,X    ; Item in slot
    CMP #$FF       ; None?
    BEQ .AD0E      ; Fail if so
    STA $0205      ; Set item bet
    JSR $0EB2      ; Sound: Click
    LDA #$75       ; C3/ADB7
	NOP
	JSR Clear_0D40	; go to Subroutine that clear WRAM if push A
    RTS       
	
warnpc $C3AD0E

; Fork: Invalid selection
.AD0E
	JSR $0EC0      ; Play buzzer
	JSR $305D      ; Pixelate screen

; Fork: Handle B
.AD14
	LDA $09         ; No-autofire keys
	BIT #$80        ; Pushing B?
	BEQ $0C			; Exit if not
	JSR $0EA9		; Sound: Cursor
	LDA #$FF        ; Empty item
	STA $0205       ; Clear item bet
	NOP
	JSR Clear_0D40	; go to Subroutine that clear WRAM if push B
;C3AD26  
	RTS

; Initialize item list variables (Item, Colosseum)
org $C31AE2
    JSR $352F      ; Reset/Stop stuff
    JSR $1B99      ; Queue desc anim
    JSR $6904      ; Reset BGs' X/Y
    STZ $4A         ; List scroll: 0
    STZ $49         ; Top BG1 WR row: 1
    LDA #$F5        ; Top row: Slot 246
    STA $5C         ; Set scroll limit
    LDA #$0A        ; Onscreen rows: 10
    STA $5A         ; Set rows per page
    LDA #$01        ; Onscreen cols: 1
    STA $5B         ; Set cols per page
    JMP Colosseum_Cursor        ; Load navig data
