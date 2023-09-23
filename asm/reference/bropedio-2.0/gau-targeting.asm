hirom
; header

; BNW - Gau Targeting Fix
; Bropedio (August 14, 2019)
;
; Allow Gau to single-target allies across the field
; during a Side Attack.

; Trick is, the side removal happens before the single-target coin flip.
; The coin flip needs to be moved before this code, so if "single-target"
; is selected, the side removal can be skipped.

!long_free = $C0DEA0 ; 24 bytes

org $C258E4
  BRA $07            ; skip redundant spread code

org $C259DA
  JSL SpreadRandom   ; if manual target (and not multi), flip coin
  PHA                ; store $0C mask on stack (vanilla code)
  CMP #$08           ; "one party" and not "both parties"
                     ; vanilla BNE will skip side/pincer filter
                     ; for single-target or "both sides"

org !long_free
SpreadRandom:        ; 24 bytes
  LDA $BB            ; targeting byte (vanilla code)
  AND #$2C           ; "multi" flags or "manual" flag
  CMP #$20           ; "manual party select"
  BEQ .chance        ; if only "manual" set, flip coin
  AND #$0C           ; "both parties"/"one party" (vanilla code)
  RTL
.chance
  JSL $C0FD00        ; random number
  LSR                ; 50% chance of carry set
  TDC                ; neither "multi" flags set
  BCC .done          ; finish 50% of time (single target)
  LDA #$08           ; "autoselect one party"
  TSB $BB            ; spread targeting
.done
  RTL
