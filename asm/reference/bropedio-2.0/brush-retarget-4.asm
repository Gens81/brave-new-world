hirom
; header

; BNW - Retarget Brushes on Target Death
; Bropedio (August 9, 2019)
;
; The default "Fight" targeting byte value ($41) is always used for
; Fight (and Mug) command execution, regardless of the equipped weapons'
; targeting bytes. This means that healing weapons will not retarget
; properly when their initial target is invalid at the time of hit execution.
;
; To fix retargeting for invalid targets:
;
; Before selecting random targets via a command's targeting byte ($BB),
; replace that targeting with the equipped weapons' targeting, unless
; the user is Berserked (always target enemies) or Muddled (always target
; allies). This should only apply for the "Fight" and "Mug" commands.
;
; Requires: x-fight-crits.asm (freespace)
; Requires: filter-rages.asm (builds on changes)

!x_fight_free = $C229FE ; 48 bytes

; ##############################################
; Flip Brush Targeting when Muddled, etc

org $C2040B : JSR MuddleBrush

; ##############################################
; Update cursor update pointers

org $C252FA : dw UpdateFightCursor
org $C252FC : dw UpdateFightCursor

; ##############################################
; Code to determine Fight targeting

org !x_fight_free
FlipTargeting:       ; 13 bytes
  CPX #$08           ; is attack a monster
  BCS .exit          ; exit if so (0 weapon index for monsters looks like shiv)
  PHY                ; store Y for later
  TXY                ; put character index in Y
  JSR GetTargeting   ; get weapon targeting 
  STA $BB            ; update targeting byte
  PLY                ; restore Y
.exit
  RTS

HandTargeting:       ; 17 bytes
  LDA $3B68,Y        ; get hand's power
  BEQ .exit          ; exit if no power (not used by Fight/Capture)
  LDA $3CA8,Y        ; get weapon ID
  JSR $2B63          ; A * 30
  TAX
  LDA $D8500E,X      ; load targeting byte
.exit
  RTS

MuddleBrush:         ; 23 bytes
  JSR $26D3          ; load command data (vanilla)
  LDA $3A7A          ; load temp command id
  BEQ .valid         ; continue if "Fight"
  CMP #$06           ; "Mug"
  BNE .nope          ; exit if not "Mug" or "Fight"
.valid
  LDA $3EE5,X        ; attacker status 2
  BIT #$10           ; "berserk"
  BNE .nope          ; exit if "berserk"
  JSR FlipTargeting  ; reset targeting based on equipment
.nope
  RTS

warnpc $C22A34

org $C25301          ; (replaces menu update cursor hook for Fight/Mug)
UpdateFightCursor:   ; 13 bytes
  JSR GetTargeting   ; get weapon targeting
  PHA                ; save targeting byte
  TDC                ; clear high byte of A
  LDA $04,S          ; A = address of menu slot (low byte only, high is $20)
  TAX                ; index to menu slot data
  PLA                ; get targeting byte again
  STA $2002,X        ; store targeting byte (fixed index high byte $20)
  RTS

org $C25105          ; (replaces Fight/Mug cursor targeting helper)
GetTargeting:        ; 23 bytes
  PHX
  PHP
  REP #$10           ; 16-bit X,Y
  JSR HandTargeting  ; get right-hand targeting
  BNE .finish        ; finish if targeting found
  INY                ; point to left-hand
  JSR HandTargeting  ; get left-hand targeting
  DEY                ; revert to true character index
.finish
  CMP #$01           ; "healing" weapon targeting
  BEQ .exit          ; exit if ^
  LDA #$41           ; use default fight targeting
.exit
  PLP
  PLX
  RTS
warnpc $C25121
