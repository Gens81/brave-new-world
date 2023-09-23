hirom

; Fix Double Counterattack Bug
; Bropedio

; Description
; Seibaby's AI code for the FC 05 00 01 (melee/MP-dmg) conditional
; forgets to clear the carry before returning to the regular "Hit
; at All" routine, which causes the condition to return "true" even
; if the attack didn't cause any damage (or reach the HP dmg routine).
;
; This patch completely rewrites Seibaby's work and refactors the handling
; for FC 01 - FC 05 so that counterattacks cannot trigger countertattacks.

; #####################################################
; Overwrite spell/command/item-specific counter data
; when null

org $C235F8 : STA $3D49,Y : BEQ $01 ; save $FF (empty) for data and entity
org $C23606 : STA $3D5C,Y : BEQ $01 ; save $FF (empty) for data and entity

; #####################################################
; This assumes that B8/B9 is only used locally here, to determine
; if was hit. This change bakes B1:01 into that flag

org $C24BFD
DeathCounterFix:
  TRB $3A56        ; clear "entity died since last 1F"
  BNE .has_died    ; allow script if has died
  TRB $33FC        ; clear "no 1F this batch"
  BEQ .skip_it     ; bypass script if already run
org $C24C28
.has_died
  TRB $33FC        ; clear "no 1F this batch" if died override
org $C24C52
.skip_it

org $C24C68
RewritePrepare:
  STZ $B8            ; zero targets for counterattack
  STZ $B9            ; zero targets for counterattack
  LDA $B1            ; check for "normal" attack
  LSR                ; carry: "non-normal" attack
  BCS .skip          ; branch if ^
  LDA $32E0,X        ; "hit by attack"
  BPL .skip          ; branch if not ^
  ASL                ; get attacker index
  STA $EE            ; save in scratch RAM
  CPX $EE            ; target === attacker?
  BEQ .skip          ; branch if ^
  TAY                ; attacker index
  REP #$20           ; 16-bit A
  LDA $3018,Y        ; attacker unique bit
  STA $B8            ; save target for counterattack
  LDA $3018,X        ; current target bit
  TRB $33FE          ; flag to use full reactive script
.skip
  REP #$20           ; 16-bit A
  LDA $3018,X        ; current target bit
  BIT $3A56          ; "died since last reactive script"
  SEP #$20           ; 8-bit A
  BNE .react         ; branch if "died", so force script
  LDA $B8            ; else, check if was attacked by normal
  ORA $B9            ; ^
  BEQ .next          ; no counterattack if not ^
  LDA $32CD,X        ; entry point to counterattack queue
  BPL .retort        ; branch if already something queued
.react
  LDA $3269,X        ; top byte of reactive script pointer
  BMI .retort        ; branch if null ^
warnpc $C24CA8
padbyte $EA
pad $C24CA7
org $C24CB1
.retort
org $C24CBE
.next

; #####################################################
; Replace (semi-broken) x-magic counters patch
; Alternate approach -- org C201D5 : JMP $00C2 (automatically finish queues)

org $C2140C : JSR $4C5B ; revert to vanilla
org $C20847 : ASL $32E0,X : LSR $32E0,X ; revert to vanilla

org $C26744
MayReset:
  LDA #$FF         ; "null"
  LDX $B0          ; loop flags
  BMI .exit        ; exit if in middle of X-Magic
  STA $33FC        ; clear bytes tracking "reaction script ran"
  STA $33FD        ; clear bytes tracking "reaction script ran"
.exit
  RTS

org $C20084
CounterFlags:
  JSR MayReset     ; determine whether to clear 33FC-33FD
  STA $33FE        ; clear bytes tracking "was attacked"
  STA $33FF        ; clear bytes tracking "was attacked"
warnpc $C2008F
padbyte $EA
pad $C2008E

; #####################################################
; Rewritten FC conditionals

org $C21D57
ConditionalLookup:
  dw Command01     ; command counter
  dw Command02     ; spell counter
  dw Command03     ; item counter
  dw Command04     ; element counter
  dw Command05     ; hit at all counter

org $C21C3B
Command01:
  TDC
  BRA Pivot
Command02:
  LDA #$01
  BRA Pivot
Command03:
  LDA #$14
Pivot:
  JSL CounterCheck
  BMI .fail
  LDA $3D48,X      ; attack command/spell/item ID
  CMP $3A2E        ; match first arg
  BEQ Match        ; if ^, set target + carry
  CMP $3A2F        ; match second arg
  BEQ Match        ; if ^, set target + carry
.fail
  CLC
  RTS

Match:             ; [vanilla code]
  REP #$20         ; 16-bit A
  LDA $3018,Y      ; last attacker bit
  STA $FC          ; save as target
  SEC              ; indicate "true" conditional
  RTS

Command04:
  LDA #$15         ; offset to attacker index data
  JSL CounterCheck
  BMI .exit
  LDA $3D48,X      ; attack elements
  BIT $3A2E        ; compare to arg1
  BNE Match        ; if match, set target + carry
.exit
  RTS

Command05:
  TYX              ; target index
  JSL TargetMelee  ; perform melee/mp checks
  BEQ Match        ; if match, set counter target
.exit
  RTS

warnpc $C21C80

; ##########################################
; C3 Helpers (new code)

org $C3F577
AttkBackup:
  TXA              ; attack index
  STA $3290,Y      ; save target's last attacker
  LDA $11A3        ; attack flags
  ROL #2           ; $01: mp damage
  PHA              ; store on stack 
  LDA $B3          ; attack flags
  EOR #$FF         ; invert them
  LSR              ; shift $20 to $10
  ORA $11A7        ; get combined "respect row" flag ($10)
  LSR #4           ; shift it into $01
  AND $11A2        ; combine with "physical" flag ($01)
  LSR              ; carry: "melee attack"
  PLA              ; restore flags
  ROL #2           ; shift "mp dmg" to $04, "melee" to $02
  PHA              ; store on stack again 
  LDA $B1          ; attack flags
  LSR              ; shift "special turn" into carry
  PLA              ; restore row flags
  ROR              ; shift "special" to $80, "mp dmg" to $02, "melee" to $01
  AND #$83         ; only keep these flags
  STA $327D,Y      ; store result
  RTL

TargetMelee:
  LDY $327C,X      ; last attacker
  BMI .exit        ; exit w/o match if "null" (no last attacker)
  LDA $327D,X      ; last attack data
  BMI .exit        ; exit w/o match for "double-counters"
  AND $3A2F        ; match with op arg2 (condition bits)
  CMP $3A2F        ; return with Z flag if are all conditions are met
.exit
  RTL

CounterCheck:
  STY $E8          ; save target index
  ADC $E8          ; add with A offset
  TAX              ; save index to relevant data
  LDA $327D,Y      ; last attack flags
  BMI .exit        ; branch if was "counterattack"
  LDY $3290,X      ; relevant attacker index
.exit
  RTL
warnpc $C3F5C1

