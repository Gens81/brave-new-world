hirom

; C0 Bank

incsrc ram.asm

; #########################################################################
; Local access to RNG routine

org $C0062E : JSL Random : RTS
org $C00636 : JSL Random ; [TODO: Remove -- redundant with above]

; #########################################################################
; RNG

org $C04012 : JSL Random

; #########################################################################
; Diagonal Movement Handlers
;
; Modified to add various handling to diagonal movement (eg on stairs)
; Original patch by Lenophis

org $C0496A
FancyWalking:
  JSR $4A03 ; add to step count, deal with poison damage, save point use, etc
  LDA #$01
  STA $57
  STZ $078E
  RTS
padbyte $FF : pad $C04978
warnpc $C04978+1

; #########################################################################
; Movement Helpers (Auto-Dash)

org $C04A65 : BRA C04A93 ; skip tintinabar effect (now freespace)

Dash:            ; Helper for auto-sprint shoes
  LDA $4219      ; controller 1 input-2
  ROL            ; C: "Pressing B"
  LDA $1D4E      ; config option flags
  BIT #$10       ; "B-Button Dash"
  BEQ .exit      ; exit if ^
  BCC .carry     ; else, toggle carry
  CLC            ; ^
  RTS
.carry
  SEC            ; ^
.exit
  RTS

org $C04A93 : C04A93:

org $C04E28
MovementSpeed:
  JSR Dash
  NOP #2
  BCC .no_dash   ; branch if not dashing
org $C04E33
.no_dash

; #########################################################################
; General Actions pointer updates
;
; Action $66 now used to set character lvl to Max(lvl, [18,19,20,21])
; Action $67 is now used to reset ELs for current party
; Action $7F (Change Character Name) is optimized and shifted to make
; room for a fix to Action $8D (Unequip Character).

org $C09926 : dw Level18
org $C09928 : dw RespecELs
org $C09958 : dw CharName

; #########################################################################
; Level Averaging (General Action $77)

org $C09F45 : BCC SkipExpReset ; don't zero experience when level unchanged
org $C09F73 : SkipExpReset:

; #########################################################################
; Random Encounters (Overworld)

org $C0C257 : CMP #$D0 ; increase chance of third/forth formation encounters

; #########################################################################
; Random Encounters (Dungeons)

org $C0C3F0 : CMP #$D0 ; increase chance of third/forth formation encounters

; #########################################################################
; Random Encounters Helpers

; -------------------------------------------------------------------------
; Encounter chance RNG
; Should raise the minimum number of steps for a random encounter to 10,
; while still maintaining the overall rate

org $C0C48C
  LDA #$E9          ; 233
  JSR RandomRangeC0 ; random(233) [uses C2 routine]
  CLC               ; clear carry
  ADC #$04          ; random(4..236)

; -------------------------------------------------------------------------
; Formation selection RNG

org $C0C4A9 : JSL $C0FD00

; #########################################################################
; Unequip Character (General Action $8D) [end of routine]
;
; Leet Sketcher's "Unequipium" patch adds handling at the end of this
; routine to ensure equipment properties and stat changes are removed
; when the equipment is removed.

org $C0A035
  LDA $EB          ; character ID
  JSL $C20006      ; recalculate properties from equipment
  LDA #$02         ; args to advance
  BRA Advance      ; advance script

; #########################################################################
; Character Name Change (General Action $7F)
;
; Shifted and optimized to make room for code directly above. Otherwise
; unchanged. Note that the "Advance" label is now used by the code above.

CharName:
  JSR $9DAD        ; [?]
  LDA $EC          ; character ID
  PHA              ; store on stack
  STA $4202        ; save multiplicand
  LDA #$06         ; length of name
  STA $4203        ; multiply
  STA $EC          ; initialize counter
  NOP #2           ; wait for multiplication
  LDX $4216        ; offset to name
  PHX              ; store X
  PHY              ; store Y

.loop
  LDA $C478C0,X    ; next name char
  STA $1602,Y      ; save character name
  INX              ; next source index
  INY              ; next SRAM index
  DEC $EC          ; six characters total
  BNE .loop        ; loop through all 6 chars
  PLY              ; restore Y
  PLX              ; restore X
  PLA              ; restore $EC
  STA $EC          ; restore $EC value
  LDA #$03         ; advance script by 3

Advance:
  JMP $9B5C        ; advance script

padbyte $EA : pad $C0A07C
warnpc $C0A07C+1

; #########################################################################
; HP and MP Addition/Subtraction Actions
; Fix so HP refill also refills MP, eg. in the Lineup Menu

org $C0AE83
HPChangeAction:
.exit
  JMP $AF90        ; exit via MP change code instead
org $C0AEAC
  BRA .exit        ; update exit branch
org $C0AEC7
  BRA .exit        ; update exit branch
org $C0AED5
  JMP $AF3E        ; after maxing HP, jump to MP code

; #########################################################################
; Initializing SRAM on Game Creation
;
; Modified to free up SRAM for EL/EP/SP system (synchysi)
; Modified to initialize RNG seed to non-zero (Think)

org $C0BDE2
InitStuff:
  NOP
  INC $01F1      ; initialize RNG seed to 1 [?]
  LDX $00        ; zero X
.ep_loop
  STZ !EP,X      ; zero SRAM (starting with EP)
  INX            ; next byte
  CPX #$0030     ; zero 48 bytes
  BNE .ep_loop   ; loop till done

org $C0BE03
  CPX #$0077     ; for SP SRAM initialization, plus extra space, too

; #########################################################################
; Freespace

; -------------------------------------------------------------------------
; Helper for "Raise Lvl to 18" general action
; Now uses variable "minimum" level based on when character rejoins party

org $C0D613
Level18:
  LDA $1D4D          ; config settings
  AND #$08           ; "Experience Enabled"
  BNE .lvlup         ; branch if ^ (else, A=0)
.finish
  JMP $9F35          ; A will be minimum new level
.lvlup
  LDA $EB            ; event param
  TAX                ; X = character #
  LDA.l RejoinLvl,X  ; A = rejoin level
  BRA .finish        ; set new level

RejoinLvl:
  db $15 ; Terra
  db $15 ; Locke
  db $15 ; Cyan
  db $15 ; Shadow
  db $13 ; Edgar
  db $12 ; Sabin
  db $12 ; Celes
  db $15 ; Strago
  db $15 ; Relm
  db $14 ; Setzer
  db $15 ; Mog
  db $15 ; Gau
  db $15 ; Gogo
  db $15 ; Umaro

; Fill remaining (now unused) bytes
padbyte $FF
pad $C0D636

; -------------------------------------------------------------------------
; Helper for Respec general action

org $C0D636
RespecELs:
  LDA #$16         ; length of character base stats data
  STA $4202        ; set multiplier
  LDA $EB          ; character ID
  STA $4203        ; set multiplicand
  TAY              ; index character ID
  LDA !EL,Y        ; character's esper level
  STA !EL_bank,Y   ; set in unspent esper levels
  NOP              ; wait for multiplication
  LDX $4216        ; get offset to character base stats
  PHX              ; store ^
  JSR $9DAD        ; Y: offset to character's info block
  PLX              ; restore offset to character base stats
  LDA $ED7CA6,X    ; character base vigor
  STA $161A,Y      ; reset current vigor
  LDA $ED7CA7,X    ; character base speed
  STA $161B,Y      ; reset current speed
  LDA $ED7CA8,X    ; character base stamina
  STA $161C,Y      ; reset current stamina
  LDA $ED7CA9,X    ; character base magic
  STA $161D,Y      ; reset current magic
  LDA $ED7CA0,X    ; character base level 1 MaxHP
  STA $160B,Y      ; reset current MaxHP (lobyte)
  LDA $ED7CA1,X    ; character base level 1 MaxMP
  STA $160F,Y      ; reset current MaxMP (lobyte)
  TDC              ; zero A/B
  STA $160C,Y      ; zero current MaxHP (hibyte)
  STA $1610,Y      ; zero current MaxMP (hibyte)
  STZ $20          ; zero scratch RAM
  STZ $21          ; zero scratch RAM
  LDA $1608,Y      ; character level
  JMP $9F4A        ; run level averaging to set new max HP/MP and check
  LDA #$02         ; [unused] TODO Remove this
  JMP $9B5C        ; [unused] TODO Remove this

; -------------------------------------------------------------------------
; Esper Junctions (Equip Bonuses)
; TODO: Could save lots of space by converting data to script
;       eg. [op][arg], so Ramuh could be [elem_op][$04]

; Immunity 1    Immunity 2       Status 1      Special           Elem-half
; $80: Death    $80: Sleep       $80: Reflect  $80: MP +12.5%    $80: Water
; $40: Petrify  $40: Seizure     $40: Safe     $40: MP +50%      $40: Earth
; $20: Imp      $20: Muddle      $20: Shell    $20: MP +25%      $20: Pearl
; $10: Clear    $10: Berserk     $10: Stop     $10: HP +12.5%    $10: Wind
; $08: MagiTek  $08: Mute        $08: Haste    $08: HP +50%      $08: Poison
; $04: Poison   $04: Image       $04: Slow     $04: HP +25%      $04: Bolt
; $02: Zombie   $02: Near Fatal  $02: Regen    $02: MDamage +25% $02: Ice
; $01: Dark     $01: Condemned   $01: Float    $01: PDamage +25% $01: Fire

; Speed/Vigor   Magic/Stamina    Defense       MDef              Mblock/Evade
; $x0: Speed    $x0: Magic       $xx: Defense  $xx: Mdef         $x0: Mblock
; $x0: Speed    $x0: Magic       $xx: Defense  $xx: Mdef         $x0: Mblock
; $x0: Speed    $x0: Magic       $xx: Defense  $xx: Mdef         $x0: Mblock
; $x0: Speed    $x0: Magic       $xx: Defense  $xx: Mdef         $x0: Mblock
; $0x: Vigor    $0x: Stamina     $xx: Defense  $xx: Mdef         $0x: Evade
; $0x: Vigor    $0x: Stamina     $xx: Defense  $xx: Mdef         $0x: Evade
; $0x: Vigor    $0x: Stamina     $xx: Defense  $xx: Mdef         $0x: Evade
; $0x: Vigor    $0x: Stamina     $xx: Defense  $xx: Mdef         $0x: Evade

org $C0D690
  dw $0000                ; Ramuh: Status immunity 1/2
  db $00                  ; Ramuh: Innate status
  db $00                  ; Ramuh: Damage & HP%/MP% bonuses
  db $04                  ; Ramuh: Elemental resistance
  db $00                  ; Ramuh: Speed & Vigor
  db $00                  ; Ramuh: Magic & Stamina
  db $00                  ; Ramuh: Defense
  db $00                  ; Ramuh: Magic Defense
  db $00                  ; Ramuh: M.Block & Evade

  dw $0000 : db $00,$00,$01,$00,$00,$00,$00,$00    ; Ifrit
  dw $0000 : db $00,$00,$02,$00,$00,$00,$00,$00    ; Shiva
  dw $3800 : db $00,$00,$00,$00,$00,$00,$00,$00    ; Siren
  dw $0000 : db $00,$00,$40,$00,$00,$00,$00,$00    ; Terrato
  dw $0000 : db $00,$00,$00,$00,$05,$00,$00,$00    ; Shoat
  dw $0000 : db $00,$00,$10,$00,$00,$00,$00,$00    ; Maduin
  dw $0000 : db $00,$00,$80,$00,$00,$00,$00,$00    ; Bismark
  dw $0025 : db $00,$00,$00,$00,$00,$00,$00,$00    ; Stray
  dw $0000 : db $08,$00,$00,$00,$00,$00,$00,$00    ; Palidor
  dw $0000 : db $20,$00,$00,$00,$00,$00,$00,$00    ; Tritoch
  dw $0000 : db $00,$00,$00,$50,$00,$00,$00,$00    ; Odin
  dw $0000 : db $00,$00,$00,$00,$00,$00,$00,$00    ; Raiden
  dw $0000 : db $40,$00,$00,$00,$00,$00,$00,$00    ; Bahamut
  dw $0000 : db $80,$00,$00,$00,$00,$00,$00,$00    ; Crusader
  dw $0000 : db $00,$02,$00,$00,$00,$00,$00,$00    ; Ragnarok
  dw $0000 : db $00,$01,$00,$00,$00,$00,$00,$00    ; Alexandr
  dw $0000 : db $00,$00,$00,$00,$50,$00,$00,$00    ; Kirin
  dw $0000 : db $00,$00,$00,$00,$00,$00,$0A,$00    ; Zoneseek
  dw $0000 : db $02,$00,$00,$00,$00,$00,$00,$00    ; Carbunkl
  dw $0000 : db $00,$00,$00,$00,$00,$00,$00,$A0    ; Phantom
  dw $80C2 : db $00,$00,$00,$00,$00,$00,$00,$00    ; Seraph
  dw $0000 : db $00,$00,$00,$00,$00,$0A,$00,$00    ; Golem
  dw $0000 : db $00,$00,$00,$05,$00,$00,$00,$00    ; Unicorn
  dw $0000 : db $00,$00,$00,$00,$00,$00,$00,$0A    ; Fenrir
  dw $0000 : db $00,$20,$00,$00,$00,$00,$00,$00    ; Starlet
  dw $0000 : db $00,$04,$00,$00,$00,$00,$00,$00    ; Phoenix

; -------------------------------------------------------------------------
; Esper Equip Bonus application

org $C0D79E
EsperBonuses:
  LDA $15FB,X       ; equipped esper
  BPL .chk_bonus    ; branch if not null ^
  JMP .finish       ; else, exit/finish
.chk_bonus
  XBA               ; store esper index
  LDA #$0A          ; size of esper item block
  REP #$20          ; 16-bit A
  STA $004202       ; set multiplication register
  PHX               ; store X
  PHY               ; store Y
  NOP               ; wait for multiplication
  LDA $004216       ; esper data offset
  TAX               ; index it ^
  LDA $C0D690,X     ; Status protection
  TSB $11D2         ; add to equipment status protection
  LDA $C0D692,X     ; Innate statuses and percent bonuses
  JSR EarringFix    ; hook to extend handling in subroutine
  LDA $C0D695,X     ; Stat bonuses
  LDY #$0006        ; stat iterator (4 stats)
.loop
  PHA               ; store stat bonuses
  AND #$000F        ; buttom nibble
  CLC               ; clear carry
  ADC $11A0,Y       ; add to equipment stat bonus byte
  STA $11A0,Y       ; update ^
  PLA               ; restore stat bonuses
  LSR #4            ; shift next stat into place
  DEY #2            ; decrement iterator
  BPL .loop         ; loop through all 4 core stats
  SEP #$20          ; 8-bit A
  LDA $C0D699,X     ; Evade & Mblock
  PHA               ; store ^
  AND #$0F          ; bottom nibble TODO: Missing CLC
  ADC $11A8         ; add to equipment Evade stat
  STA $11A8         ; update ^
  PLA               ; restore Evade/MBlock
  AND #$F0          ; get MBlock TODO: Unnecessary AND, just CLC after LSR
  LSR #4            ; shift MBlock into place
  ADC $11AA         ; add to equipment MBlock stat
  STA $11AA         ; update ^
  LDA $C0D694,X     ; Elemental resistances
  TSB $11B9         ; add to equipment resistances
  LDA $C0D697,X     ; Defense TODO: Missing CLC, but probably no bug
  ADC $11BA         ; add to equipment defense
  BCC .noCap1       ; branch if no overflow
  LDA #$FF          ; else use max 255
.noCap1
  STA $11BA         ; update equipment defense
  LDA $C0D698,X     ; M.Def TODO: Missing CLC
  ADC $11BB         ; add to equipment M.Def
  BCC .noCap2       ; branch if no overflow
  LDA #$FF          ; else use max 255
.noCap2
  STA $11BB         ; update equipment M.Def
  PLY               ; restore Y
  PLX               ; restore X
.finish
  LDA $15ED,X       ; [displaced] MaxMP hibyte
  AND #$3F          ; [displaced] mask +% effects
  RTL

org $C0D827
EarringFix:         ; TODO: Move this code in-line
  TSB $11D4         ; [displaced] add to equipment innate statuses/etc
  SEP #$20          ; 8-bit A
  XBA               ; A = 11D5 bits 
  AND #$02          ; isolate earring bit
  TSB $11D7         ; set earring bit
  REP #$20          ; 16-bit A
  RTS

; -------------------------------------------------------------------------
; Informative Miss Helpers

org $C0D835
MaybeNull:        ; 33 bytes
  LDA $11A4       ; attack flags
  AND #$0004      ; does attack lift status?
  BEQ SetNull     ; set null flag if not
  TDC             ; set Z flag
  RTL
SetKill:
  LDA $3AA1,Y     ; check immune to instant death bit
  BRA BitSet
SetFrac:          ; TODO: This label is unused now
  LDA $3C80,Y     ; check fractional dmg immunity bit
BitSet:
  BIT #$04        ; immune to instant death (or fractional)
  BEQ SetEnd      ; if not immune, exit
SetNull:
  PHP             ; save M, Z flags
  REP #$20        ; 16-bit A
  LDA $3018,Y     ; get unique bit for target
  TSB !null       ; set null miss bit
  PLP             ; restore 8-bit A, no zero flag
SetEnd:
  RTL

StamPhase:        ; 27 bytes
  LDA $11A4
  BIT #$20        ; check for "cannot dodge" flag (needed for 2nd phase)
  BNE .exit       ; if cannot dodge, exit without Carry change
  BIT #$10        ; check for stamina evade flag
  BEQ .exit       ; if no stamina evade, exit without Carry change
  ORA $11A3       ; top bit holds fractional|MP bit
  BMI .first      ; first phase if Fractional or MP
  LDA $11A9       ; special effect
  CMP #$52        ; "North Cross"
  BEQ .first      ; first phase if N.Cross
.second
  SEC             ; return carry set for second phase
.exit
  RTL
.first
  CLC             ; return carry clear for first phase
  RTL

TootHelp1:        ; 61 bytes
  LDA $11A9       ; Special Effect index
  AND #$00FF      ; zero B 
  CMP #$0076      ; Evil Toot
  BNE .mind       ; if not toot, check mind blast next
  LDY #$01        ; else, set one random status
  BRA .end
.mind
  CMP #$0050      ; Mind Blast
  BNE TootHelp2   ; use regular handling if not mind blast or evil toot
  STZ $E8         ; used to flag whether target was targeted
  LDA $3018,Y     ; target's unique bit
  LDY #$00        ; start w/ no random statuses
  LDX #$08        ; prepare mind blast loop
.loop
  BIT !blast,X    ; check mind blast target bytes
  BEQ .next       ; if not this target, try next
  INC $E8         ; mark target as intended target
  PHA             ; store unique bit
  SEP #$20        ; 8-bit A
  JSL $C0FD00     ; get rand(0..256)
  LSR             ; rand(0..128)
  CLC             ; this aligns with C2 stamina evade check math
  SBC $3B40,Y     ; compare to stamina 
  REP #$20        ; 16-bit A
  PLA             ; restore unique bit
  BCC .next       ; skip hit if stamina evades
  INY             ; else, add 1 random status to set
.next
  DEX
  DEX             ; get next mind blast target index
  BPL .loop       ; end loop after checking index 0
  DEC $E8
  BMI .miss       ; if this target was not targeted, flag miss
  CPY #$00
  BNE .end        ; if was targeted, and a hit landed, exit
  TSB !fail       ; if all hits were evaded, flag "fail"
.miss
  TSB !miss       ; flag "miss" (overriden by fail above)
.end
  RTL

TootHelp2:        ; 10 bytes
  LDA $11AA       ; attack status bytes 1-2
  STA $FC         ; set status-to-set bytes 1-2
  LDA $11AC       ; attack status bytes 3-4
  STA $FE         ; set status-to-set bytes 3-4
  PLA             ; remove C2 address of RTL
  PEA $447A       ; make RTL below return to end (must keep aligned w/ old_miss)

TootHelp3:        ; 9 bytes
  LDA $F8         ; current status 1-2
  TRB $FC         ; remove from status to set
  LDA $FA         ; current status 3-4
  TRB $FE         ; remove from status to set
  RTL

StatusHelp:       ; 20 bytes
  BEQ .miss       ; if Z flag set, no fail bit
  LDA $3018,Y     ; get unique bit for target
  TSB !fail       ; set fail miss bit
.miss
  PHA             ; save unique bit (or zero)
  LDA $11A7
  LSR             ; "miss if status unchanged" flag
  PLA             ; load unique bit (or empty)
  BCC .end        ; if no full miss, exit
  TSB !miss       ; else, set full miss bit
.end
  RTL

; -------------------------------------------------------------------------
; Status Removal After Death (delayed) Helpers
;
; When monsters die, avoid removing the following statuses
; until after any possible counterattack or additional strike
; has a chance to execute. Otherwise, that counterattack or
; strike will behave as though these statuses were not set.
; Statuses: Dark, Mute, Shell, Safe, Sleep, Muddle, Berserk, Freeze, Stop

org $C0D8F0
StatusRemove:
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

; -------------------------------------------------------------------------
; Helper for Poison Tick Adjustments (from C2)

org $C0D930
TickLogic:
  STA $BD         ; set damage increment
  BEQ .incr       ; initialize tick to 100%
  CPY #$08        ; monster range
  BCC .incr       ; branch if player target
  ASL             ; double tick for monsters
  INC             ; +50% more damage
  RTL
.incr
  INC #2          ; add 100% more damage
  RTL
warnpc $C0D93E+1

; -------------------------------------------------------------------------
; Helper for North Cross targeting
; (runs immediately before status phase)

org $C0D940
NorthCrossMiss:
  PHP
  LDA $11A9              ; special effect
  CMP #$52               ; "N.Cross" special index
  BNE .exit              ; exit if not "N.Cross"
  REP #$20               ; 16-bit A
  LDA !miss              ; get "missed" targets
  STA !fail              ; use "failed" message
  LDA $A4                ; remaining targets
  TSB !miss              ; set all as missed
  PHX                    ; store X
  JSL PostCheckHelp      ; will change X
  PLX                    ; restore X
  ORA $E8                ; combine both targets
  STA $A4                ; set as new targets
  TRB !miss              ; remove from "missed" targets
.exit
  PLP
  RTL

; -------------------------------------------------------------------------
; Helpers for Elemental Status Null patch

Nulled:
  JSR RemoveStatuses  ; if null dmg, remove statuses
  STZ $F0             ; zero dmg lobyte [moved]
  STZ $F1             ; zero dmg hibyte [moved]
  RTL
Absorb:
  JSR RemoveStatuses  ; if absorb dmg, remove statuses
  LDA $F2             ; attack flags [moved]
  EOR #$01            ; toggle "Heal" [moved]
  RTL
RemoveStatuses:
  PHP                 ; store flags 
  TDC                 ; zero A/B
  REP #$20            ; 16-bit A
  STA $3DD4,Y         ; clear status-to-set 1, 2
  STA $3DE8,Y         ; clear status-to-set 3, 4
  LDA $3018,Y         ; unique bit for target
  TRB !null           ; remove "null" message (if set)
  TRB !fail           ; remove "fail" message (if set)
  PLP                 ; restore flags
  RTS
warnpc $C0D990+1


; -------------------------------------------------------------------------
; Helpers for Palidor Redux (in C2)

org $C0D990

WaitTimer:
  LDA $3204,X            ; load 3204,X and 3205,X
  BPL .flying            ; branch if entity is riding Palidor
  LDA $3AC8,X            ; ATB timer incrementor
  LSR                    ; divided by two
  RTL
.flying
  LDA #$00C8             ; use fixed ATB increment while flying
  RTL

BetterPaliFlags:
  BMI .done              ; if not landing, return
  ORA #$80               ; "has landed since boarding Palidor"
  STA $3205,X            ; set "has landed" bit
  LDA $3AA0,X            ; get battle flow byte
  BPL .done              ; skip setting flag if no extra turn
  ORA #$08               ; set bit 3 to preserve ATB
  STA $3AA0,X            ; update battle flow byte
.done
  RTL

ClearWaitQ:
  LDY $3A64              ; current wait queue index
.loop
  TXA                    ; put this rider's index in A
  CMP $3720,Y            ; is this rider in wait queue here?
  BNE .next              ; if not, branch
  LDA #$FF               ; null
  STA $3720,Y            ; set this wait queue entry to null
.next
  INY                    ; get next wait queue index
  CPY $3A65              ; is this lower than the next unfilled entry?
  BCC .loop              ; continue loop if so
  LDA $3205,X            ; vanilla code
  AND #$7F               ; vanilla code
  RTL

; -------------------------------------------------------------------------
; Helper for X Fight Retargeting Fix (in C2)

org $C0D9D0
HandleXFight:            ; 27 bytes
  LDA #$20               ; "First strike of turn"
  TRB $B2                ; test and clear
  BNE .retarget          ; if set, exit without setting "no retarget"
  LDA $B5                ; command ID
  BNE .no_retarget       ; if not "Fight", set "no retarget"
  LDA #$01               ; odd bit set for right-hand swings
  BIT $3A70              ; # of hits remaining (after this one)
  BNE .retarget          ; if right-hand, skip setting "no retarget"
  LDA $3B68,X            ; right-hand battle power
  BNE .no_retarget       ; if nonzero, lefthand is dualwield, so no retarget
.retarget
  LDA #$20               ; prepare BIT check (and clear zero flag)
  RTL
.no_retarget
  TDC                    ; set zero flag
  RTL

; -------------------------------------------------------------------------
; Helpers for Invalid Targets Spellproc fix (C2)
; Fix vanilla bug that allows procs to fire even if
; the accompanying weapon strike had no targets to
; strike.

org $C0D9F0
ProcFix:               ; 12 bytes
  LDA $B8              ; character targets
  ORA $B9              ; enemy targets
  BEQ .exit            ; if none, abort spellcast
  LDA $3A89            ; spellcast byte (vanilla code)
  BIT #$40             ; "cast randomly" flag
.exit
  RTL                  ; on return, abort spellcast if Z flag set
ProcFix2:              ; 14 bytes
  LDA $B8              ; character targets
  ORA $B9              ; enemy targets
  BEQ .exit            ; if none, abort spellcast
  XBA                  ; get spell #
  STA $3400            ; [displaced] set addition magic
  INC $3A70            ; [displaced] increment number of remaining strikes
.exit
  RTL

; -------------------------------------------------------------------------
; Helper for Defending boost to Tank+Spank
;
; Apply on top of Tank+Spank patch to double chance
; of covering healthy allies when in "defend" mode.

DefendBetter:          ; [13 bytes]
  SEP #$20             ; 8-bit A
  LDA $3AA1,X          ; knight's special flags
  LSR #2               ; shift "defending" flag to carry
  LDA #$C0             ; 192 (cover threshold / 255)
  BCC .done            ; branch if not defending
  LSR                  ; 96 (lower cover threshold / 255)
.done
  RTL
warnpc $C0DA17+1

; -------------------------------------------------------------------------
; Helpers for "Half Battle Power" patch

org $C0DA20
GetBushPwr:
  REP #$20        ; 16-bit A [moved]
  PHA             ; save power so far
  SEP #$20        ; 8-bit A
  LDA $3C58,X     ; weapon effects
  BIT #$10        ; dual wielding
  JSR GetBatPwr   ; get base battle power (preserves Z flag)
  REP #$20        ; 16-bit A
  BEQ .norm       ; branch if not dual wielding
  ASL             ; else, double base battle power
.norm
  CLC : ADC $01,S ; add to power-so-far
  STA $01,S : PLA ; clean up stack
  LSR #2          ; [moved]
  RTL

GetPwrFork:
  SEP #$20        ; [moved]
  LDA $B5         ; command ID
  CMP #$16        ; is command "Jump"
  BEQ .get_pwr    ; branch if ^
  LDA $3413       ; backup command (fight/mug)
  BMI .exit       ; exit if not fight/mug or battle
.get_pwr
  JSR GetBatPwr   ; get base battle power
  REP #$21        ; 16-bit A
  ADC $04,S       ; add to stored power on stack
  STA $04,S       ; overwrite with full power
  SEP #$20        ; 8-bit A
.exit
  LDA $B5         ; [moved]
  RTL

org $C0DB01
GetBatPwr:
  PHP             ; store flags (including Z)
  LDA $3ED8,X     ; character X's ID
  STA $004202     ; prep multiplication
  LDA #$16        ; size of character startup block
  STA $004203     ; start mutliplication
  NOP #3          ; wait for processor
  REP #$30        ; 16-bit X/Y,A
  LDA $004216     ; get product
  PHX             ; save character index 
  TAX             ; index to character data
  TDC             ; zero A/B
  SEP #$20        ; 8-bit A
  LDA $ED7CAA,X   ; character battle power
  PLX             ; restore character index
  PLP             ; restore flags (including Z)
  RTS

; -------------------------------------------------------------------------

org $C0DE5E
SetMPDmgFlag:
  ORA #$01           ; [moved] Add "enable dmg numeral" flag
  PHA                ; store flags so far
  LDA ($76)          ; battle dynamics command ID
  CMP #$0B           ; is this the non-alias cmd (for cascade)
  BEQ .done          ; branch if ^
  PLA                ; else, get flags
  ORA #$40           ; add "MP Dmg" flag
  BRA .set           ; branch to exit
.done
  PLA                ; get flags
.set
  STA $631A,X        ; set animation thread flags
  RTL

SetMPDmgFlagMass:
  ORA #$01           ; [moved] Add "enable dmg numeral" flag
  PHA                ; store flags so far
  LDA ($76)          ; battle dynamics command ID
  CMP #$03           ; is this the non-alias cmd (for mass)
  BEQ .done          ; branch if ^
  PLA                ; else, get flags
  ORA #$40           ; add "MP Dmg" flag
  BRA .set           ; branch to exit
.done
  PLA                ; get flags
.set
  STA $7B3F,X        ; set animation thread flags
  RTL

PaletteMP:
  PHA                ; store palette
  LDA $631A,X        ; regular damage numerals
  BRA .check_mp      ; branch to check mp flag
.mass
  PHA                ; store palette
  LDA $7B3F,X        ; mass damage numerals
.check_mp
  AND #$40           ; "MP dmg" flag
  BEQ .normal        ; branch if not ^
  PLA                ; else, get palette
  CLC : ADC #$04     ; and advance to next palette
  BRA .set_palette   ; set palette
.normal
  PLA                ; get hp palette color
.set_palette
  STA $0303,Y        ; store palette [?]
  STA $0307,Y        ; store palette [?]
  RTL
warnpc $C0DEA0+1

; -------------------------------------------------------------------------
; Helper for Gau Targeting (single target across field) support

org $C0DEA0
SpreadRandom:        ; 24 bytes
  LDA $BB            ; targeting byte (vanilla code)
  AND #$2C           ; "multi" flags or "manual" flag
  CMP #$20           ; "manual party select"
  BEQ .chance        ; if only "manual" set, flip coin
  AND #$0C           ; "both parties"/"one party" (vanilla code)
  RTL
.chance
  JSL Random         ; random number
  LSR                ; 50% chance of carry set
  TDC                ; neither "multi" flags set
  BCC .done          ; finish 50% of time (single target)
  LDA #$08           ; "autoselect one party"
  TSB $BB            ; spread targeting
.done
  RTL

; -------------------------------------------------------------------------
; Helper for "Mug Better" patch
;
; Delay check for added "Steal" until special effect routine 
; so other weapon special effects are preserved.

org $C0DF6B
MugHelper:
  PHP                   ; store M/X flags
  SEP #$20              ; 8-bit A
  JSL LongSpecial       ; process original special effect
  LDA $B5               ; command id
  CMP #$06              ; "Mug" command ID
  BNE .exit             ; exit if not
  LDA $11A9             ; weapon special effect
  PHA                   ; store on stack
  LDA #$A4              ; steal effect (id $52)
  STA $11A9             ; set steal as temporary special effect
  JSL LongSpecial       ; run Steal function (for Mug attempt)
  PLA                   ; pull weapon special effect off stack
  STA $11A9             ; restore original special effect byte
  CMP #$02              ; "SwitchBlade" special
  BEQ .exit             ; attack always hits for SwitchBlade proc
  LDA $3401             ; steal result message
  CMP #$03              ; was steal successful?
  BCS .exit             ; branch if ^
  STA $3A48             ; flag target as missed
  LDA #$20              ; "Flash Screen" animation flag
  TRB $A0               ; remove "Flash" from animation flags
.exit
  PLP                   ; restore M/X flags
  LDA $3A48             ; missed flag (vanilla code)
  RTL
warnpc $C0DFA0+1


; #########################################################################
; XOR Shift RNG Algorithm (replaces RNG Table)
; NOTE: The rest of RNG table is cleared out - 192 bytes free!

org $C0FD00
Random:
  PHP            ; store flags
  SEP #$20       ; 8-bit A
  XBA            ; get B
  PHA            ; store B
  REP #$20       ; 16-bit A
  LDA $01F1      ; last RNG value
  ASL #2         ; << 2
  EOR $01F1      ; XOR with RNG
  STA $01F1      ; update RNG
  LSR #7         ; >> 7
  EOR $01F1      ; XOR with RNG
  STA $01F1      ; update RNG
  ASL #15        ; << 15
  EOR $01F1      ; XOR with RNG
  STA $01F1      ; update RNG
  SEP #$20       ; 8-bit A
  PLA            ; restore B
  XBA            ; put B back
  LDA $01F1      ; RNG value
  EOR $01F0      ; XOR with frame counter
  PLP            ; restore flags
  RTL

; -------------------------------------------------------------------------
; Elemental Damage Modification Helper

org $C0FD40
EleModLoop:
  BIT $3BCD,X      ; check immunities
  BNE .next        ; if immune, skip dmg increments
.inys
  BIT $3BE1,X      ; check resistances
  BNE .half        ; only iny 50%
  INY
.half
  INY
  BCS .skip        ; skip weakness check 2nd time
  SEC              ; track weakness loop
  BIT $3BE0,X      ; check weaknesses
  BNE .inys        ; double increments via loop
.skip
  CLC
.next
  INC $EE
  DEC $EE          ; check if no remaining attack elems
  RTL
padbyte $FF
pad $C0FD84

; #########################################################################
; Freespace

org $C0FF90
RandomRangeC0:
  JSL RandomRange ; leverage C2 random in range routine
  RTS

; #########################################################################
; ROM Data for SNES
;
; Note, internal title is set in part to ensure BNW cannot be opened up
; inside of FF3usME, since it overwrites custom event scripting.

org $C0FFC0 : db "FF6: BRAVE NEW WORLD " ; set internal title (ASCII)

