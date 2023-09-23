hirom
table table_c3.tbl,rtl

; BNW - Randomize Party 2
; Bropedio (September 14, 2019)
;
; Can be patched directly on top of Randomize Party 1.
; Instead of randomizing just 5-12 of the final lineup,
; randomize the entire final lineup.
;
; Further, limit party selection in all other cases
; to choosing only team leaders. All characters beyond
; the first are randomized. If the player wants to
; compose a 3-person team, they must leave the leader
; empty.
;
; Floating Continent
; Only 2 random characters will be added to the leader,
; to leave room for Shadow
; Since the player must battle immediately after this
; party selection, the main menu will be opened after
; any party selection, automatically.
;
; Hidon
; The Hidon event trigger has been changed to only
; require Strago in the party, since characters 2-4
; will always be randomized.

!free = $C3F612
!free_end = $C3F647

; ###############################################
; Only require Strago for Hidon event
; Replace check for Relm with duplicate Strago check

org $CB75DB : db $A7,$01

; ###############################################
; Regular Lineup Menu
; * Change heading
; * Shrink team windows to only fit one character
; * Fill empty slots on menu close
; * Automatically open main menu
; * Lock non-leader character slots

org $C37A97 : db "Select leader(s).    ",$00
org $C37AB9 : db "More groups needed!",$00
org $C375AC : dw $5D0D,$0302  ; 10x08 at $5D0B (Party 1)
org $C375B0 : dw $5D21,$0302  ; 10x08 at $5D1F (Party 2)
org $C375B4 : dw $5D35,$0302  ; 10x08 at $5D33 (Party 3)

org $C3729F
  JSR ShufflePool    ; When exiting lineup, fill empty slots randomly
  NOP

org $C372BF
  JSR MenuNext       ; prepare main menu opening
  LDA #$04           ; "Initialize main menu" next (instead of closing)

org $C37915
LockSlots:
  JSR TryLock        ; set carry if forced character or slot 2-4
  BCS .lockit        ; lock slot if carry set
org $C3792F
.lockit

org $C37566
  JSR WhichText      ; pick heading
  BEQ .fixed_lead
  LDY #$7A95         ; "select leader"
.fixed_lead
  JMP $02F9          ; draw heading

; Skip error message for invalid groups
; This routine may not actually be necessary at
; all anymore, since the randomization forces members.
; Use freed space for new heading for forced leaders.
org $C372CB
  JMP $0EC0          ; play buzzer and exit
PressStart:
  dw $391D : db "Just press start     ",$00
warnpc $C372EA

org $C375F7
WhichText:           ; replace group number drawing routine
  LDA $0201          ; forced memebers flag in bit 7
  BMI .can_pick
  LDY #PressStart    ; "press start"
  TDC                ; set Z flag
.can_pick
  RTS
warnpc $C37614

; If forced members, shift order to top
org $C3763E
  JSR ShiftOrder

; ###############################################
; Final Lineup Menu
; * Change heading
; * Don't load "End" or "Reset" options
; * Only draw one list in center
; * Shuffle candidates on load

org $C3AC98 : dw $391D : db "Final Lineup",$00

org $C3AB31
  LDX #$AC88          ; load top heading only
  LDY #$0002          ; one string only

org $C3AB89
  LDY #$3A25          ; shift left names column to center
org $C3AC1D
  LDY #$3A1F          ; shift left numbers column to center
org $C3AC27
  JMP $AC3B           ; only draw left numbers
org $C3AB3D
  JSR ShuffleList

; ###############################################
; Remove most of Final Lineup Menu Handling
; Replace freespace with new Shuffle code

org $C3AA25

; Simplified routine to sustain final lineup
SustainFinal:
  LDA $09            ; No-autofire keys
  BIT #$10           ; Pushing Start?
  BNE .close
  LDA $08            ; No-autofire keys
  BIT #$80           ; Pushing A?
  BEQ .continue
.close
  JSR $0EB2          ; Sound: Click
  JSR $AACA          ; Auto-fill list
  LDA #$FF           ; Null value
  STA $27            ; Queue menu exit
  STZ $26            ; Next: Fade-out
.continue
  RTS                ; ...

; New helper to shuffle an array (Y = last array index)
ShuffleOne:          ; 17 bytes
  STX $E7            ; offset of array to shuffle
  LDA #$7E           ; array bank
  STA $E9            ; save it
.loop
  JSR RandomInRange  ; random slot in array
  TAX                ; index it
  JSR SwapSlots      ; swap with slot Y
  DEY                ; narrow array left to shuffle
  BNE .loop          ; shuffle all array items
  RTS

; Shuffle final battle lineup before drawing
ShuffleList:         ; 13 bytes
  JSR $AB4D          ; compile candidates
  LDY #$000B         ; candidate array length
  LDX #$9D8A         ; candidate array offset
  JSR ShuffleOne     ; shuffle candidate array
  RTS

; Randomly fill empty slots in regular lineup menu
ShufflePool:         ; 69 bytes
  STA $F3            ; vanilla code
  STZ $F4            ; vanilla code
  LDY #$000F         ; 16th slot
  STY $E0            ; used in later loop
  LDX #$9D89         ; offset for swapping
  JSR ShuffleOne
  INY                ; skip first character per team
  LDX $7E0597        ; calling event address (in CA)
  CPX #$581E         ; is this the Floating Continent lineup
  BNE .slot_loop     ; branch if not
  LDA $7E9D99        ; check if leader selected
  BMI .slot_loop     ; if empty, randomize 3 characters
  INY                ; else, leave one position open
.slot_loop
  TYX                ; slot to check
.team_loop
  LDA $7E9D99,X      ; character ID in this slot
  BPL .filled        ; branch if already filled
.pool_loop
  LDA [$E7]          ; character ID from remaining pool
  BPL .swap          ; swap in if not null
.next
  DEC $E0            ; else, reduce counter of pool size
  BMI .exit          ; exit if pool is empty
  INC $E7            ; point to next pool slot
  BRA .pool_loop     ; loop until swap is made, or pool is empty
.swap
  PHY
  TAY                ; index by character id
  LDA $1850,Y        ; character flags
  BIT #$40           ; is character enabled
  BNE .valid         ; branch if so
  PLY                ; restore Y
  BRA .next          ; try next pool slot
.valid
  AND #$E0           ; remove party/order data
  ORA $C373BF,X      ; add order data for this slot
  ORA $7E9E61,X      ; add party data for this slot
  STA $1850,Y        ; update party/order data
  TYA                ; character ID back in A
  STA $7E9D99,X      ; set pool character in party lineup
  PLY                ; restore Y
  LDA #$FF           ; null id
  STA [$E7]          ; clear pool slot
.filled
  INX #4             ; point to next team
  CPX $F3            ; slot after last team
  BCC .team_loop     ; loop if next team is in bounds
  INY                ; point to next position within each team
  CPY #$0004         ; 4 positions per team
  BNE .slot_loop     ; loop until all 4 positions are checked
.exit
  TDC                ; A = 0000
  TAX                ; X = 0000
  RTS

warnpc $C3AACB
padbyte $FF
pad $C3AACA

; ###############################################
; Remove "Draw Player's List" from final lineup
; Replace with more shuffle helpers

org $C3ABB4          ; remove "Draw player's actor list" routine
RandomInRange:       ; 20 bytes
  TYA                ; max slot in A
  INC                ; full range
  STA $4202          ; first multiplicand (range)
  JSL $C0FD00        ; random number
  STA $4203          ; second multiplicand
  NOP #4             ; wait for calc
  LDA $4217          ; get hi byte of product
  RTS
SwapSlots:           ; 17 bytes
  LDA [$E7],Y        ; item in slot Y
  PHA                ; save it
  PHY
  TXY
  LDA [$E7],Y        ; item in slot X
  PLY
  STA [$E7],Y        ; replace slot Y
  PLA                ; get old slot Y item
  PHY
  TXY
  STA [$E7],Y        ; replace slot X
  PLY
  RTS
warnpc $C3ABDD
padbyte $FF
pad $C3ABDC

; ###############################################
; Final Lineup Menu - remove cursor/navigation
; Replace unused cursor positions with helper

org $C3AC63
  db $00,$00,$00      ; no change from vanilla nav data
  db $01,$01          ; set to 1 column, 1 row (no d-pad)
  dw $BCFF            ; cursor position just off-screen

TryLock:              ; 16 bytes
  TXA                 ; 
  CMP #$10            ; in full character pool
  BCC .allowed        ; don't lock if ^
  AND #$03            ; get position in group
  BNE .exit           ; lock if not slot index 0 (leader)
.allowed 
  TDC                 ; A = 0000
  CLC                 ; clear carry to unlock slot
  LDA $7E9D89,X       ; character in slot
.exit
  RTS

; Immediately open main menu from lineup menu close
MenuNext:            ; 10 bytes
  STZ $0205          ; this maybe does nothing? (vanilla)
  STZ $0201          ; disable save/warp for main menu
  STZ $0200          ; set menu to "main menu" to enable rename card
  RTS

warnpc $C3AC85
padbyte $FF
pad $C3ABDC

; #############################################
; Freespace. Helper to shift forced members' order

org !free
ShiftOrder:       ; 52 bytes
  LDA $0201
  BMI .exit
  PHP             ; save N flag
  LDA #$03        ; loop through 3 parties
  STA $F7         ; store iterator
.party_loop
  TDC             ; A = 0000
  TAX             ; point to first character
  STA $F8         ; zero order position
.char_loop
  LDA $1850,X     ; character flags
  AND #$07        ; party number
  CMP $F7         ; compare to current party
  BNE .next_char  ; branch if not in this party
  LDA $1850,X     ; character flags
  AND #$E7        ; mask order position
  ORA $F8         ; set next order position
  STA $1850,X     ; update character flags
  LDA $F8         ; get last order position
  CLC             ; clear carry
  ADC #$08        ; advance to next order position
  STA $F8         ; store next order position
.next_char
  INX             ; point to next character 
  CPX #$0010      ; checked all characters
  BNE .char_loop  ; loop till all checked
  DEC $F7         ; point to next party
  BNE .party_loop ; loop till all checked
.done
  PLP
.exit
  RTS
warnpc !free_end

