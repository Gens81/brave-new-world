hirom
; header

; Name: Elemental Status Null
; Author: Bropedio
; Date: July 20, 2020

; Description ====================================
; When an attack is nullified (or absorbed) due to
; elemental properties, its associated status(es)
; should also fail.

; Requires =======================================
; elemental-lite.asm
; inform-miss-3.asm

; Variables ======================================
!fail = $3A5C
!null = $3A5E
!freespace = $C0D964
!freerange = $C0D991

; Code ===========================================
org $C20C02 : JSL Nulled
org $C20BDF : JSL Absorb

org !freespace ; (36 bytes needed)
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
warnpc !freerange

; EOF ============================================
