hirom
; header

; BNW - Proc Bugfix
; Bropedio (August 13, 2019)
;
; Fix vanilla bug that allows procs to fire even if
; the accompanying weapon strike had no targets to
; strike.
;
; NOTE: Also changes patched Kagenui code

!long_free = $C0D9F0   ; 26 bytes

org $C23649
  JSL ProcFix
  NOP

org $C23ED6
  XBA                  ; save spell #
  JSL ProcFix2
  RTS

org !long_free
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
  STA $3400            ; set addition magic (bnw)
  INC $3A70            ; increment number of remaining strikes (bnw)
.exit
  RTL
