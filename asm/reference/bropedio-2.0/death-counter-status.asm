hirom
; header

; BNW - Death Status Counters
; Bropedio (July 21, 2019)
;
; When monsters die, avoid removing the following statuses
; until after any possible counterattack or additional strike
; has a chance to execute. Otherwise, that counterattack or
; strike will behave as though these statuses were not set.
; Statuses: Dark, Mute, Shell, Safe, Sleep, Muddle, Berserk, Freeze, Stop
;
; Frees battle RAM $3E61-3E88 (30 bytes)
; Repurposes first quasi status byte for later status removal flags

!died_flag = $3E60     ; 1 RAM byte to track status removal needs
!c2_space = $C261D6    ; 19 bytes (using "esper-simplify" freespace)
!c0_space = $C0D8F0    ; 58 bytes

org $C20081
  JSR StatusFinish     ; ensure above statuses are removed
org $C24C11
  LDA $3EE4,X          ; load real status 1-2, instead of quasi
org $C24C19
  LDA $3EF8,X          ; load real status 3-4, instead of quasi
org $C24572
  BRA $08              ; skip setting quasi bytes (no longer used)

; Set Death/Petrify hook 
org $C2460E            ; 15 bytes rearranged/replaced
  JSL StatusRemove     ; handle bytes 3-4, death flag
  LDA #$FE15           ; statuses removed by death
  BCC .clear           ; branch if character
  LDA #$4614           ; skip removing Dark, Mute, Sleep, Muddle, Berserk
.clear
  JSR $4598            ; mark statuses in A to be cleared
warnpc $C2461E

org !c2_space
StatusFinish:          ; 19 bytes
  REP #$20             ; 16-bit A
  LDA !died_flag       ; bitmask of entities needing status cleanup
  BEQ .done            ; if none, exit
  JSL StatusFinHelp    ; prepare status cleanup
  JSR $4391            ; cleanup statuses to for clearing
.done
  SEP #$20             ; 8-bit A
  JMP $47ED            ; vanilla code
warnpc $C261EA

org !c0_space
StatusRemove:          ; 25 bytes
  CPY #$08             ; is target a monster?
  BCC .skip            ; branch if character
  LDA $3018,Y          ; unique entity bit
  TSB !died_flag       ; flag this entity for status cleanup
.skip
  LDA $FA              ; vanilla code (curr status 3-4)
  ORA $FE              ; vanilla code (status to set 3-4)
  AND #$9BFF           ; statuses removed by death
  BCC .all
  AND #$998F           ; skip removing Shell, Safe, Freeze, Stop
.all
  TSB $F6              ; set status-to-clear 3-4
  RTL

StatusFinHelp:         ; 33 bytes
  LDX #$12             ; prepare loop through all entities
.loop
  LDA $3018,X          ; entity's unique bit
  TRB !died_flag       ; did this entity just die?
  BEQ .next            ; branch if not
  LDA $3EE4,X          ; status 1-2
  AND #$B801           ; Dark, Mute, Sleep, Muddle, Berserk
  STA $3DFC,X          ; status-to-clear 1-2
  LDA $3EF8,X          ; status 3-4
  AND #$0270           ; Frozen, Stop, Safe, Shell
  STA $3E10,X          ; status-to-clear 3-4
.next
  DEX
  DEX                  ; point to next lowest entity
  BPL .loop            ; loop through all entities
  RTL
