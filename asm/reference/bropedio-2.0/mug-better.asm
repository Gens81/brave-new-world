hirom
; header

; BNW - Mug Better
; Bropedio (July 27, 2019)
;
; Make Mug's behavior more consistent, yet still distinct from
; the Fight command.
;
; * Preserve weapon special effects when Mugging
; * Only Mug on first strike when dual wielding
; * If steal fails, make strike miss altogether
;
; REQUIRES: "xkill-anim" (cleave changes)

!long_free = $C0DF6B     ; 53 bytes
!long_warn = $C0DFA1

; ############################################################
; Since Mug is no longer guaranteed to deal damage, it should
; be removed as an option for Berserk characters.
; NOTE: This address is for BNW, not vanilla

org $C204C8 : db $01     ; remove "Capture" ($40) from flags

; ############################################################
; Bypass instant-death for Cleave if not "Fight" command
; Note: It would be more robust to specifically check for
; "Jump" and "Mug", but I don't think this special hook is
; used for anything other than "Fight"/"Mug"/"Jump", so this
; works for now.
; Note: Requires "xkill-anim" patch
; Note: Inform Miss does not conflict, but it could, if we
;       decide to display "Null" for these death immunes.

org $C266B0
CleaveFix:
  AND #$04               ; "death immune"
  ORA $B5                ; or any non-Fight command
  BNE .crit              ; do crit if either ^
  NOP

org $C266BA
.crit

; ############################################################
; Skip handling that sets "Steal" special effect for "Mug".
; We now have special handling to check for "Mug" in $B5.
; Now, this code resets the backup command to "Fight", so
; only the first strike of a dual-wield attack will mug.

org $C231AE
  LDA #$00              ; "Fight" command ID
  STA $3413             ; replace backup command with "Fight"

; ############################################################
; Skip slice auto-kill effect if mugging (or jumping)
; Hopefully, Mug/Jump will never reach this point, due to
; handling in the Zantetsuken special effect

org $C2388C
XKillAbort:

org $C238AB
  LDA $B5               ; command ID
  CMP #$16              ; "Jump" ID
  BEQ XKillAbort        ; abort if "Jump"
  CMP #$06              ; "Mug" ID
  BEQ XKillAbort        ; abort if "Mug"
  NOP
warnpc $C238B7

; ############################################################
; Run extra special effect if Mugging

org $C2345C
  JSL MugHelper
  NOP #2

; ############################################################
; Disable "HawkEye" Special Effect when Mugging (and Throwing)

org $C238FD
HawkRts:

org $C238FE
HawkEye:
  LDA $B5               ; command ID
  CMP #$00              ; "Fight" ID
  BNE HawkRts           ; exit if not "Fight" ("Mug"/"Throw")
  JSR $4B53             ; 50% chance of carry set
  BCC HawkRts           ; exit 50% of the time
  INC $BC
  INC $BC               ; dmg x2
  LDA $3EF9,Y           ; target status4
  BPL $04               ; skip x3 dmg if not floating

; ############################################################
; Move command exit check before random JSR, and skip setting
; "Steal" special effect -- it will be handled by new check
; for "Mug" command.

org $C23E8B

SwitchBlade:            ; 17 bytes (replaced)
  LDA $B5               ; subtract command ID, maybe w/ carry
  JSR $4B53             ; 50% chance of carry set
  ROL                   ; combine Carry and Command ID
  BNE .nope             ; exit if carry set or not "Fight"
  LDA #$06              ; "Mug" command ID
  STA $B5               ; set as command
  RTS
.nope
  STZ $11A9             ; remove switchblade effect
  RTS

LongSpecial:            ; 4 bytes
  JSR $387E             ; long access to special effect routine
  RTL

warnpc $C23EA1

; ############################################################
; New Code (C0)

org !long_free
MugHelper:              ; 50 bytes
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
warnpc !long_warn

