hirom

!freeZinger = $C4B6D9

org $C2FBA0
Vulnerables1:

org $C261C0
Vulnerables2:

org $C207C8
ClearZinger:

; Most of this is copied verbatim from BNW repo
; This claims all 9 unused bytes in the routine
; to add a helper for clearing Zinger when Near Fatal

org $C24517
OvercastFix:
  LDA $3EF8,Y        ; status-3/4 [moved earlier]
  STA $FA            ; backup
  JSR Vulnerables1   ; consider petrify/morph immunities
  PHA                ; store ^
  AND $3DD4,Y        ; non-blocked statuses-to-set-1/2
  STA $FC            ; save ^
  XBA : ROL          ; C: "Death" about to set
  TDC                ; zero A/B
  ROL #2             ; bit1: "Death"
  AND $3E4D,Y        ; combine "Overcast" status
  AND $01,S          ; "Zombie" not blocked
  TSB $FC            ; "Zombie" to-set if not blocked
  XBA                ; 0x0200 if ^
  LSR #2             ; 0x0080 if ^
  TRB $FC            ; remove "Death" to-set
  ASL                ; 0x0100 if ^
  TSB $F4            ; set "Doom" to-clear
  LDA $3EE4,Y        ; status-1/2
  STA $F8            ; save ^
  LDA $3C1C,Y        ; MaxHP
  LSR #3             ; MaxHP / 8
  CMP $3BF4,Y        ; compare to CurrHP
  LDA #$0200         ; "Near Fatal"
  BIT $F8            ; check in current status ^
  BNE .may_remove    ; branch if ^
  BCC .done          ; branch if CurrHP > MaxHP/8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  PHP                ; preserve flags
  PHX                ; preserve X
  JML ZingerHelper   ; clear zinger/charm/love token
  PLA                ; restore low byte of A
  PLX                ; restore X
  PLP                ; restore flags
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.may_remove
  BCS .done          ; branch if CurrHP < MaxHP/8
  TSB $F4            ; else to-clear "Near Fatal"
.done
  PLA                ; restore blocked statuses-1/2
  AND $FC            ; remove from to-set-statuses-1/2
  STA $FC            ; update status-to-set-1/2
  PHA                ; store ^
  LDA $3DE8,Y        ; status-to-set-3/4
  JSR Vulnerables2   ; handle petrify/morph immunities
  STA $FE            ; save ^
  PHA                ; store ^
  LDA $32DF,Y        ; hit by attack
  BPL .finish        ; branch if not ^
  JSR $447F          ; get new status
  BRA .finish        ; no longer set quasi status at all (was LDA $FC)
  STA $3E60,Y        ; save quasi-status-1/2 ; TODO: Remove BRA-bypassed code
  LDA $FE            ; new status-3/4
  STA $3E74,Y        ; save quasi-status-3/4
.finish
  PLA                ; restore status-to-set-3/4
  STA $FE            ; save ^
  PLA                ; restore status-to-set-1/2
  STA $FC            ; save ^
  RTS

org !freeZinger
ZingerHelper:
  TSB $FC            ; to-set "Near Fatal"
  TYX                ; store target in X
  SEP #$20           ; 8-bit A
  PHA                ; stash low byte of A
  PEA $4555          ; set return address for ClearZinger
  JML ClearZinger    ; clear Zinger, Love Token, Charm variables
