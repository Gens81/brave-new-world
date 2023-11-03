hirom

; C1 Bank

; ########################################################################
; NMI

; ------------------------------------------------------------------------
; Add hook to listen for "Select" button press

org $C10CFA : JSR CheckSel

; ########################################################################
; New Items Buffer
;
; Fix Item Buffer Overflow
; Was causing some items to get eaten up when Weapon Swapping too
; many times in a row.

org $C112D5 : CPX #$0050 ; wipe entire "pending item transfer" buffer

; ########################################################################
; RNG

org $C11861 : JSL Random

; ########################################################################
; Status Graphics (cont.)
;
; Large portion after $2E69 rewritten by dn to support cycling auras.

org $C12E2D
StatusGraphics:
org $C12E4F
  BRA ResetAura      ; reset aura cycling if Poison
org $C12E5C
  BRA ResetAura      ; reset aura cycling if Zombie
org $C12E69
  BRA ResetAura      ; reset aura cycling if Berserk
  LDA #$1E           ; "Stop/Haste/Slow/Regen"
  TRB $38            ; ignore ^ status-3, which no longer use aura graphics
  LDA !aura_cycle,Y  ; current outline rotation for character
.loop
  BIT $38            ; check for current status-3
  BNE SetColor       ; branch if status set
  LSR                ; else, check next
  ADC #$00           ; maintain "wait" bit
  STA !aura_cycle,Y  ; update current aura color
  CMP #$20           ; loop over 3 statuses (80,40,20)
  BCS .loop          ; loop till done
ResetAura:
  LDA #$80           ; no aura, so reset to Rflect
UpdateAura:
  STA !aura_cycle,Y  ; update current aura color
  RTS
SetColor:
  AND #$E0           ; clear "wait" bit
  JSR $1A0F          ; convert bitmask to bit index in X
  LDA.l .clr_table,X ; get outline colour
.clr_table
  BRA AuraControl  ; implement
  db $04 ; Slow [unused]
  db $03 ; Haste [unused]
  db $07 ; Stop [unused]
  db $02 ; Shell
  db $01 ; Safe
  db $00 ; Rflect

CycleAura:
  LDA !aura_cycle,Y  ; current outline colour rotation
.loop
  LSR                ; get next aura, C: "wait" bit
  BCS ResetAura      ; branch to reset aura if ^
  AND #$FC           ; keep 6 bits TODO only need 3 bits now
  BEQ ResetAura      ; branch to reset if no more auras in sequence
  BIT $38            ; check current status for this aura
  BEQ .loop          ; loop until match found
  BRA UpdateAura     ; set new aura color
  RTS                ; [unneeded] TODO
%nop($C12EB4)
  RTS                ; ensure earlier $C12EB4 branches still work

org $C12EC3
AuraControl:
  PHA                ; [unchanged] store aura index         
  LDA $0E            ; [unchanged] frame counter
  STA $2C            ; [unchanged] save ^ in scratch
  PLA                ; [unchanged] restore aura index
AuraControl2:
  PHA                ; [unchanged] store aura index
  LDA $2C            ; [unchanged] frame counter
  AND #$03           ; [unchanged] isolate which character slot
  TAX                ; [unchanged] index ^
  LDA $C2E3AA,X      ; [unchanged] 0/8/16/24, based on character
  CLC                ; [unchanged] clear carry
  ADC $2C            ; [unchanged] add to frame counter to stagger graphics
  STA $36            ; [unchanged] save ^ in scratch
  AND #$3C           ; remove character slot frame data
  LSR A              ; / 2
  STA $2C            ; save aura brightness
  STZ $2D            ; zero hibyte
  LDA $36            ; full frame counter
  ASL #2             ; x4
  BCC .transition    ; branch if < $40 ($2C < $20)
  LDA #$1F           ; else, pivot counter around #$1F
  SBC $2C            ; subtract counter from pivot
  STA $2C            ; update counter (-32 through -1)
.transition
  LDA $2C            ; aura brightness
  CMP #$1F           ; at minimum brightness (31)
  BNE .get_color     ; branch if not ^
  JSR CycleAura      ; set (pending) next aura color
  BRA .get_color     ; get current aura color palette
  NOP                ; [unused]
warnpc $C12EF7
org $C12EF7
.get_color

; ########################################################################
; Fix Vanilla Bug that blocks running animation for Morph instead of
; the Frozen status. From assassin

org $C1353F : AND #$02

; ########################################################################
; Keep time frozen during some battle actions

org $C17792 : NOP #3 ; when selecting target via "Fight" command cursor
org $C17D25 : NOP #3 ; [?]

; ########################################################################
; Bushido Menu

org $C17D8A : JSR SwdTechMeter ; add handling for bushido meter scroll

; ########################################################################
; Slots Battle Menu
; De-rigs the slots

org $C1806D
SlotsBatMenu:
  BRA .r2_rig
org $C18089 : .r2_rig
org $C180A6
  BRA .r3_rig
org $C180D7 : .r3_rig

; ########################################################################
; Lore Battle Menu

org $C18336 : CMP #$0C    ; lore menu length - 4 (x2)
org $C1838F : LDA #$0C    ; lore menu scrollbar rows + 4 (see above)

; ########################################################################
; Rage Battle Menu

org $C184F9 : CMP #$1C    ; (64 rages / 2) - 4(onscreen)
org $C1854A : LDA #$1C    ; rage menu scrollbar rows (see above)
org $C1854E : LDX #$0140  ; pixels per rage menu scrollbar row [?]

; ########################################################################
; Equipment Swap Menu Sustain and Validation
;
; Only update equipment status when swap executes
; One exception is when swapping left and right hand
; equips with each other -- in that case, the update
; flag is set immediately, without incurring a turn.
; Use free space for swap finishing helper
;
; Store swap-in item id in $32F4,X (item reserve).
; If weapon swap is interrupted, this item will be
; returned to inventory.
;
; Route weapon swap through "Defend" command, using
; attack id to indicate mode:
; $FF: Defend, $00: Righthand, $01: Lefthand
;
; Note: There is a substantial amount of weapon swap code that
; never runs, due to the game disabling the equipment menu when
; an item is selected first. Since this code never runs, I have
; not implemented these changes for that particular code path.
; The branch that never happens: $C18E5A


org $C189E4      ; code determines if swap can execute
  LDA $7B3C      ; still-equipped item's flags
  JSR SwapDual   ; set carry if not able to dual wield
  BCS $11        ; branch if no dual wield

org $C18A0C      ; skip setting status update flag (until command code)
  CLC            ; clear carry to indicate valid equipment
  RTS
HalfTurn:        ; 6 bytes in new freespace TODO: Move this into C2
  LDA #$7E       ; half-full ATB
  STA $3219,X    ; set new ATB value
  RTL
%free($C18A18)   ; frees 4 bytes

org $C18A90
ValidSwap:
  LDA $7B00      ; selected item column
  LSR            ; carry set if righthand (left column)
  LDA $2686,X    ; swap-in item id 
  JMP QueueSwap
%nop($C18A9D)

org $C18B4D
QueueSwap:          ; 84 bytes
  BCS .right        ; branch if right-hand
  CMP $2B9A,Y       ; compare w/ left-hand equip id
  BRA .continue
.right
  CMP $2B86,Y       ; compare w/ right-hand equip id
.continue
  BEQ .finish       ; branch if same (no reserve item)
  PHA               ; store swap-in item id
  LDA $62CA         ; character slot number
  ASL               ; x2
  TAY               ; use as index to data
  PLA               ; restore swap-in item id
  STA $32F4,Y       ; store in character's reserve
  LDA $2689,X       ; swap-in item quantity
  CMP #$02          ; less than 2? 
  BCC .empty
  DEC $2689,X       ; decrement quantity
  BRA .finish
.empty
  LDA #$FF
  STA $2686,X       ; clear item id
  LDA #$80          ; "unusable in battle"
  STA $2687,X       ; set item flags
  STZ $2688,X       ; zero targeting
  STZ $2689,X       ; zero quantity
  STZ $268A,X       ; zero equip blacklist
.finish
  STZ $890C         ; reset equipment swap mode
  STZ $7BAF         ; unfreeze item menu cursor
  STZ $7BB5         ; unfreeze equip menu cursor
  STZ $7B02         ; unset item swapping flag
  JSR $7E19         ; set "Defend" command, queue menu close, set Y
  LDA $7B00         ; column position (1 = left, 2 = right)
  DEC               ; shift down for mode id
  STA $2BB0,Y       ; set subcommand (default $FF triggers defend)
  CLC               ; indicate no item usage
  RTS

; Handle the "Defend" command executing

SwapOrDefend:       ; 104 bytes
  LDA $B6           ; subcommand (item id)
  BPL SwapMode      ; branch if not mode $FF (defend)
  LDA #$02          ; "defending" flag
  RTL               ; exit
SwapMode:
  TYA               ; character slot * 2
  LSR               ; character slot * 1
  TAX               ; index to *5 table
  INC $2F30,X       ; set flag to recalculate equip properties
  LDA $C14B67,X     ; item data index (x * 5)
  LDX $B6           ; check swap mode
  BEQ .offset       ; branch if right-hand mode
  ADC #$14          ; add left-hand data offset
.offset
  TAX               ; index to equipment data
  LDA $32F4,Y       ; reserve (swap-in) item id
  XBA               ; store temporarily
  LDA $2B86,X       ; swap-out equip id
  STA $32F4,Y       ; set as new reserve item
  CMP #$FF          ; empty?
  BEQ .equip        ; if ^, skip unequip handling
  LDA $3018,Y       ; unique bit for character
  TSB $3A8C         ; return equip to inventory at turn end
  TSB !unequip      ; flag equipment update to remove statuses
.equip
  XBA               ; restore swap-in item
  STA $2B86,X       ; set equip id
  CMP #$FF          ; empty?
  BEQ .unequip      ; if ^, reset equip data to empty
  JSL ItemLookup    ; copy item data into $2E72-2E76
  LDA $2E73         ; item flags
  STA $2B87,X       ; set equip flags
  LDA $2E74
  STA $2B88,X       ; set equip targeting
  LDA #$01          ; only one item
  STA $2B89,X       ; set equip quantity
  LDA $2E76
  STA $2B8A,X       ; set equip blacklist
  BRA .finish
.unequip
  LDA #$80
  STA $2B87,X       ; set unusable in battle
  STZ $2B88,X       ; zero targeting
  STZ $2B89,X       ; zero quantity
  STZ $2B8A,X       ; zero equip blacklist
.finish
  JSL LongUpdate    ; process equipment updates immediately
  TDC               ; don't set "defending" on return
  RTL

; Clear statuses of swapped-out equipment
;
; Vanilla does not recalculate statuses or Max HP/MP on equipment
; swap. This presents a problem for BNW, since several weapons/shields
; modify these properties. Even in vanilla, this was a bug with the
; cursed shield, which could be swapped in without incurring any of its
; negative statuses.

ClearStatus:        ; 42 bytes
  LDA #$FF          ; prepare to toggle equipment statuses
  EOR $3C6C,Y       ; inverted equipment status 2
  AND $D85019,X     ; unequip status 2
  AND $3EE5,Y       ; lost statuses that are currently set
  STA $3DFD,Y       ; set status-to-clear 2
  LDA $3C6D,Y       ; equipment status 3
  EOR #$FF          ; inverted equipment status 3
  AND $D85008,X     ; unequip status 3
  LSR               ; shift permanent float into Carry
  BCC .clear3       ; branch if no float
  PHA               ; save potential clears
  LDA #$80          ; float bit
  STA $3E11,Y       ; set status-to-clear 4
  PLA               ; restore shifted potential clears
.clear3
  ASL               ; shift byte 3 back (without permanent float)
  AND $3EF8,Y       ; remove not-set statuses
  STA $3E10,Y       ; set status-to-clear 3
  RTL

; Set equipment statuses

SetStatus:          ; 54 bytes
  LDA $3EE5,X       ; current status 2
  EOR #$FF          ; inverted current status 2
  AND $3C6C,X       ; equipment statuses that are not set
  ORA $3DD5,X       ; combine with status-to-set 2
  STA $3DD5,X       ; update status-to-set 2
  LSR 
  BCC .byte3        ; branch if Condemned not marked to be set
  LDA $3204,X       ; special turn flags
  AND #$EF          ; turn off bit 4
  STA $3204,X       ; if setting Condemned, omit "disable condemned"
.byte3
  LDA $3C6D,X       ; equipment status 3
  LSR               ; shift permanent float into Carry
  BCC .set3         ; branch if not set
  LDA #$80          ; float bit
  ORA $3DE9,X       ; combine with status-to-set 4
  STA $3DE9,X       ; update status-to-set 4
.set3
  LDA $3EF8,X       ; current status 3
  EOR #$FF          ; unset statuses 3
  AND $3C6D,X       ; equipment statuses that aren't set
  AND #$EF          ; equipment statuses other than "Stop" that aren't set
  ORA $3DE8,X       ; combine with status-to-set 3
  STA $3DE8,X       ; update status-to-set 3
  RTL

; Update HP/MP based on equipment (16-bit A)

NewMaxHP:           ; 45 bytes
  LDA $160B,Y       ; get max HP
  JSL HPLookup      ; get max HP after equipment/relic boosts
  CMP #$2710
  BCC .notover
  LDA #$270F        ; if it was >= 10000, make it 9999
.notover
  STA $3C1C,X       ; max HP
  CMP $3BF4,X       ; compare to current HP
  BCS .mp
  STA $3BF4,X       ; if current HP too high, set to Max
.mp
  LDA $160F,Y       ; get maximum MP
  JSL HPLookup      ; get max MP after equipment/relic boosts
  CMP #$03E8
  BCC .notover2
  LDA #$03E7        ; if it was >= 1000, make it 999
.notover2
  STA $3C30,X       ; max MP
  RTL

; Additional helpers

DrawDual:           ; 14 bytes
  ORA $2D           ; combine with swap-in item flags
  BRA CanDual       ; branch to check flags
SwapDual:
  ORA $7B3A         ; combine with swap-in item flags
CanDual:
  LSR               ; "block dual wield" in carry
  BCS .nope         ; exit with carry set
  EOR #$FF          ; toggle "allow dual wield" flag
  LSR               ; "not allow dual wield" in carry
.nope
  RTS

FlagDual:           ; 21 bytes
  LDA $D8500C,X     ; battle effect byte 2
  AND #$18          ; dual wield / two-handed
  CMP #$18
  BEQ .end          ; branch if doesn't enable or block dual wield
  LSR
  LSR
  LSR               ; bit 1: enable dual wield, bit 0: block dual wield
  TSB $2E73         ; set in item flags buffer
.end
  REP #$21          ; displaced vanilla code
  STZ $EE           ; displaced vanilla code
  RTL

%free($C18CB7)

org $C18DFC
  NOP #5         ; no status update when equipment first selected

; ########################################################################
; Equip Swap Code that never runs ($C18EFE used as freespace)

; ------------------------------------------------------------------------
; Helpers to prevent pause buffering during Setzers slot machine selection

org $C18EFE
CloseSlotsHelp:
  STA $7BC4     ; vanilla code (moved)
  STZ $EC0F     ; enable pausing (after slot machine)
  RTS
OpenSlotsHelp:
  INC $EC0F     ; disable pausing (during slot machine)
  JMP $5A4A     ; vanilla code (moved)
warnpc $C18F0B

; ------------------------------------------------------------------------
; Wait Gauge helpers

org $C18F85
WaitRemaining:
  LDA $1D4E        ; config options
  ASL              ; carry: "Display Wait Times"
  LDA $3219,X      ; ATB gauge
  PHA              ; store on stack for later
  BCC .atb         ; always display ATB when option turned off
  BNE .atb         ; display ATB when filling
  LDA $3205,X      ; more special flags
  BPL .atb         ; never show wait during Palidor
  LDA $3AA0,X      ; special state flags
  BIT #$04         ; awaiting input
  BNE .atb         ; display ATB when input pending
  LDA $322C,X      ; total wait for command
  INC              ; is it "null"
  BNE .wait        ; branch if not ^
  LDA $3AA1,X      ; special state flags
  BIT #$01         ; "executing attack"
  BNE .empty       ; show empty "wait" when ^
.atb
  LDA $01,S        ; ATB gauge
  DEC
  BRA .set         ; branch and exit
.empty
  LDA #$01         ; use smallest gauge (empty)
  BRA .set         ; branch and exit
.wait
  SEC
  SBC $3AB5,X      ; total wait - wait progress
  CMP #$40         ; largest displayable wait
  BCC .valid       ; branch if less than ^
  LDA #$3F         ; else, enforce cap (affects Jump)
.valid
  ASL #2           ; x4 (make wait larger to see)
.set
  XBA              ; store gauge value
  SEC              ; assume full ATB
  PLA              ; ATB gauge
  BEQ .shift       ; branch if full ATB
  CLC              ; else, clear flag
.shift
  XBA              ; restore gauge value
  ROR              ; shift "full ATB" flag into top bit
  RTL
GaugeValue:
  CPX $00          ; fully empty gauge?
  BNE .done
  LDA $4E          ; get gauge color
  CMP #$3D         ; red (stop status)
  BEQ .done        ; use default (F1) value if ^
  LDA #$F0         ; else, use fully empty F0
  RTS
.done
  LDA $C168AC,X    ; gauge value
  RTS

; -------------------------------------------------------------------------
; Helper for cover animation sprite priority bug

DetermineRight:
  PHY            ; save offset to character target
  JSR $BC89      ; set attacker in $10
  LDA $10        ; attacker index
  BPL .character ; branch if character
  ASL            ; double monster index, remove monster flag (set carry)
  SBC #$08       ; get monster index 0-10
  TAY            ; index it
  LDA $80F3,Y    ; flipped due to formation
  EOR $617E,Y    ; toggle with muddle/control flipped
  INC            ; toggle lowest bit "Horizontal Flip"
  BRA .done
.character
  TAY            ; character index
  LDA $7B10,Y    ; character facing right (bit 0)
.done
  LSR            ; carry: Facing right
  PLY            ; restore offset to character target
  RTS
warnpc $C19102

; ########################################################################
; Damage number color palette routine
;
; Intercept to check for new MP dmg flag at bit6, part of Imzogelmo's 
; "MP Colors" patch

org $C12D2B : NOP : NOP : JSL PaletteMP
org $C12B9B : NOP : NOP : JSL PaletteMP_mass

; #######################################################################
; Relocate 2bpp palettes

org $C140A8 : LDA Palettes,X     ; Load battle text palettes white and gray
org $C140AF : LDA Palettes+16,X  ; Load battle text palettes yellow and cyan
org $C14100 : LDA Palettes+40,X  ; Load battle gauge palette

; #######################################################################
; Status Text Display for targeting window

org $C14587
StatusTextDisp: ; @returns: bit 0 = Regen, Bit 1 = Rerise, Bit 2 = Sap
  XBA           ; get B
  PHA           ; store ^
  XBA           ; get A again
  LDA $2EBE,X   ; Status byte 2 (for Sap)
  ROL #2        ; Rotate Sap into carry
  TDC           ; Clear A
  ROL           ; Rotate Sap into bit 0
  XBA           ; Save Sap
  LDA $2EC0,X   ; Status byte 4 (Rerise byte)
  LSR #3        ; Shift Rerise into carry
  XBA           ; Get Sap again
  ROL           ; Rotate Rerise into bit 0, Sap into bit 1
  XBA           ; Save Sap and Rerise
  LDA $2EBF,X   ; Status byte (for Regen)
  LSR #2        ; Shift Regen into carry
  XBA           ; Get Sap and Rerise
  ROL           ; Rotate Regen into bit 0, Rerise into bit 1, Sap into bit 2
  XBA           ; store A
  PLA           ; restore original B
  XBA           ; store in B ^
  RTS

; ------------------------------------------------------------------------
; Runic Stance helper

RunicAbsorb:
  JSR $BAB7      ; regular runic absorb animation
  JSR $BCA6      ; get first target index
  CMP #$04       ; is absorber a monster?
  JMP $AB92      ; reset sprite to default if not
%free($C145B3)

; #######################################################################
; Get ATB/Morph/Condemned gauge data for active battle menu ($C14A97)
;
; Since the morph ram is used for the wait gauge now, we need to force
; the code to never draw the morph gauge even if it appears to be on.

org $C14AB7 : LDA #$00 ; Always disable morph gauge

; #######################################################################
; Equipment Swap Palette Drawing

org $C14B87         ; code draws valid swaps in yellow
  LDA $890E         ; still-equipped item's flags
  JSR DrawDual      ; set carry if not able to dual wield
  BCS $0F           ; branch if no dual wield

; #######################################################################
; Slot Machine "Menu"

; -----------------------------------------------------------------------
; When Opening Slots, Disable Pausing
org $C15618 : JMP OpenSlotsHelp

; -----------------------------------------------------------------------
; When Closing Slots, Re-enable Pausing
org $C156B1 : JSR CloseSlotsHelp

; #######################################################################
; Spell Name Message Display
;
; dn's "Spell Dot" hack shifts loop to include prefix dot

org $C1602E : NOP #3 ; skip decrementing spell name length
org $C16031 : LDA $E6F567,X ; decrement starting offset by 1

; #######################################################################
; Draw HP or ATB Gauge

; -----------------------------------------------------------------------
; Gauge drawing
; Change the endcaps on the ATB bar based on whether ATB is full or not.
; Requires two new glyphs in the 8x8 font tileset (the two tiles
; immediately following the ATB endcaps, left and right). The endcaps
; are changed so that the uncharged ones don't use colors 2 or 4, just
; the grey and transparency. Then the charged endcaps use colors 4
; (the brightest) and optionally color 2 like the vanilla endcaps did.
;
; Rewritten to support Wait Gauge

org $C16854
DrawGauge:
  JML HelpCaps
FinGauge:
  JSL NormDraw     ; draw it
  LDA #$04         ; gauge iterator
  STA $1A          ; save it
.loop
  JSR GaugeValue   ; get gauge value
  JSR $66F3        ; draw it
  INX              ; next
  DEC $1A          ; next
  BNE .loop        ; loop for all 4 tiles
  PLA              ; get end cap value
  JSL NormDraw     ; draw it
  RTS
  NOP
warnpc $C16872

; -----------------------------------------------------------------------
; Add checks for statuses to ATB drawing routine

org $C16872
ATBDrawFix:
  LDA $2021        ; ATB gauge setting
  LSR              ; Gauge enabled?
  BCC drawMaxHP    ; Branch if disabled
  LDA $4E          ; Text color
  PHA              ; Save it
  LDX $10          ; Offset to character data
  JSL StatusATB    ; Get ATB color based on status
  STA $4E          ; Store palette
  LDA $18          ; Which character is it (0-3)
  TAX              ; Index it
  LDA $619E,X      ; Character's ATB gauge value
  JSR $6854        ; Draw the gauge
  PLA              ; Get saved text color
  STA $4E          ; Store text color
.exit
  RTS
LongDraw:
  JSR $66F3
  RTL
warnpc $C16898

; Leftover from earlier version of patch TODO: Remove below
  PLA              ; Get saved text color
  STA $4E          ; Store text color
  RTS
; Leftover from earlier version of patch TODO: Remove above

org $C16898
drawMaxHP:
  LDA #$C0         ; Draw a "/" as HP divider

; #######################################################################
; Battle Dynamics Commands Jump Table

; Add aliases for existing damage number commands
; Part of "MP Colors" patch

org $C191A0 : dw $A4B3  ; battle dynamics $05, alias to $0B (cascade)
org $C191A6 : dw $9609  ; battle dynamics $08, alias to $03 (mass)

; ######################################################################
; Decode Battle Dynamics Script

org $C1953B : JSL MagicFunction1 ; hook for nATB [$C3](before animation)
org $C19544 : JSL MagicFunction2 ; hook for nATB [$C3](after animation)

; ######################################################################
; Damage Numbers Animation Handler(s)
;
; Add MP dmg flags based on battle dynamics command ID, for MP Colors
; patch
;
; For informative miss:
; Loads in new "miss" message tile data depending on the
; value passed on the high byte of missed targets' damage
; Requires no additional bytes, primarily due to an optimization
; of tile moving to use MVN
;
; The high byte for missed targets is "hm---ii-", where
; the index to the tile offset pointer is stored in ii. In other
; words, the ii value is the message id x 2.

; ----------------------------------------------------------------------
; Label for informative miss

org $C1A4B2 : LastRts:

; ----------------------------------------------------------------------
; Rewritten to save space and support Null/Fail

org $C1A50D      ; 36 bytes replaced
Cascade:
  BEQ LastRts    ; use previous RTS (saves one byte)
  STA $1E        ; save dmg/flag byte for later
  ASL            ; move miss flag to bit 7
  BPL CascDmg    ; if no miss, skip to dmg display
  LDY #$60D3     ; set destination (in $7E) 
  JSR PrepMove   ; set X to source offset, A to #bytes to move, 16-bit A
  MVN $7E,$7F    ; move bytes (bank will not change, already 7E)
  BRA CascFin    ; includes TDC,SEP#20

PrepMove:
  LDA #$08
  STA $14         ; set x_pos for miss tiles
  LDA #$06
  AND $1E         ; isolate bits 1-2 to get tile index (0, 2, or 4)
  TAX
  REP #$20        ; 16-bit A
  LDA.l MissOff,X ; load tile data offset for miss message
  JMP Prep2

%free($C1A531)    ; 1 unused byte

; ----------------------------------------------------------------------
; Label for informative miss

org $C1A531 : CascDmg:

; ----------------------------------------------------------------------
; Label for informative miss

org $C1A586 : CascFin: ; this branch is moved earlier for MVN cleanup

; ----------------------------------------------------------------------
; For MP damage color display

org $C1A5A9 : NOP : JSL SetMPDmgFlag

; ----------------------------------------------------------------------
; Rewritten to save space and support Null/Fail
; Note: New tile data compressed at D2E000 (see bank d2.asm)

org $C1A627      ; 46 bytes replaced
Multiple:
  ASL            ; move "miss" flag to bit 7
  BPL MultiDmg   ; if no miss, skip to dmg display
  PHB            ; save current bank
  PHY            ; store dmg byte index
  LDA $20        ; get target's index
  ASL            ; carry will be clear after this (adc below)
  TAX            ; make it an index to data word
  LDA #$20       ; start at offset of 2nd tile (out of 4)
  REP #$20       ; 16-bit A
  ADC $C1A749,X  ; add buffer offset for this target
  TAY            ; put destination offset in Y
  TDC            ; clear B
  SEP #$20       ; 8-bit A
  JSR PrepMove   ; set X to tile source, A to #bytes, 16-bit A
  MVN $7F,$7F    ; move bytes (and change data bank)
  BRA MultiEnd   ; finish up (includes TDC,SEP#20,PLY,PLB)

Prep2:
  TAX            ; move offset to X
  LDA #$003F     ; will move 64 bytes (two tiles)
  RTS

MissOff:
  dw $BC00       ; miss tiles address in $7F
  dw $C140       ; fail tiles address in $7F
  dw $C180       ; null tiles address in $7F

%free($C1A655)   ; 10 unused bytes

; ----------------------------------------------------------------------
; Label for informative miss

org $C1A655 : MultiDmg:

; ----------------------------------------------------------------------
; Label for informative miss

org $C1A6B8 : MultiEnd: ; this branch is moved earlier for MVN cleanup

; ----------------------------------------------------------------------
; For MP damage color display

org $C1A6E6 : NOP : JSL SetMPDmgFlagMass

; ######################################################################
; Fix Drain Swirly
;
; When a new black magic spell (Dark) was added, the
; range of black magic spells got slightly larger.
; This range is hard-coded in the animation bank to
; indicate which pre-magic swirly animation is played.

org $C1ABA6 : CMP #$19 ; increase black magic range by 1

; ######################################################################
; Reset attacking character sprite to default

org $C1AB8E : JSL StanceCheck ; Skip reset for Runic or Defend

; ######################################################################
; Odin Animation
; Skip "Cleave" effect in Odin animation

org $C1B0E4 : BRA No_Odin_Cleave
org $C1B0EC : No_Odin_Cleave:

; ######################################################################
; Attack Animations Lookup Table

org $C1B78B : dw RunicPrep
org $C1B7BF : dw RunicAbsorb

; ######################################################################
; Cover Animation
;
; Cover allies on correct side, based on attacker
; facing direction, rather than intended target

org $C1BD8B : JSR DetermineRight : BCS $05

; ######################################################################
; Execute Physical Attack Animation
;
; Fix sprite priority after cover

org $C1C225 : BEQ $05
org $C1C22A : NOP #2

; ######################################################################
; RNG

org $C1CD53 : JSL Random

; ######################################################################
; RNG

org $C1CECF : JSL Random

; ######################################################################
; Freespace (stats at $C1FFE5)

org $C1FFE5

; ----------------------------------------------------------------------
; During NMI, if Select button pressed, swap gauge display

CheckSel:
  JSL SwapGauge  ; (in $C3)
  JMP $0B73      ; [displaced]

; ----------------------------------------------------------------------
SwdTechMeter:
  INC $7B82      ; increment meter position
  LDA $7B82      ; get new meter postion
  ADC $36        ; adds known Bushid count (to speed up)
  STA $7B82      ; update meter position
  RTS
  NOP            ; [unused space] TODO: Remove
  db $FF         ; [unused space] TODO: Remove

; ----------------------------------------------------------------------
; Runic Stance helper

RunicPrep:
  JSR $BAAA      ; regular runic prep animation 
  JMP $914D      ; set sprite to "ready"
warnpc $C20000

