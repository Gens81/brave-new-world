arch 65816
hirom

!free1 = $D1F9D0                  ; Unused Space (48 bytes)
!free2 = $C0DB24                  ; Free space following "GetBatPwr" at $C0DB01 (28 bytes)

;
; This hack specifies an alternate "Magic" command label w/ crystal icon to indicate
; they have a summon available to cast. It uses the set of flags at $3F2E to determine
; which label to display for the current character when rendering their command menu.
;

org $D8CFEC
  db $8C,$9A,$A0,$A2,$9C,$FF,$6B  ; "Magic" w/ crystal indicator

org $C169FA
  JSL CmdNameSlice

org !free1                        ; 44 bytes used
CmdNameSlice:
  CMP #$000E                      ; offset 0E = Magic
  BNE .end
  SEP #$30                        ; 8-bit A,X,Y
  LDA $ECEF
  BIT #$08                        ; Espers acquired?
  BEQ .no_icon                    ; skip if not
  LDA $62CA                       ; current character slot
  ASL                             ; double it
  TAX                             ; index it
  LDA $3018,X                     ; get positional bit for character slot
  BIT $3F2E                       ; check if current character has esper available
  BNE .no_icon
  REP #$30                        ; 16-bit A,X,Y
  LDA #$014C                      ; offset to magic string with esper indicator
  BRA .end
.no_icon
  REP #$30                        ; 16-bit A,X,Y
  LDA #$000E                      ; offset to regular magic string
.end                              ; displaced by subroutine call
  TAX
  TDC
  SEP #$20
  RTL

;
; This portion of the hack adds a piece to combat initialization to "correctly" flag
; characters with no Esper equipped as having no Esper available.
;

org $C256A5                       ; "Generate a character's Esper Menu"
  JSL FlagNullEsper
  NOP

org !free2                        ; 16 bytes used
FlagNullEsper:
  LDA $161E,Y                     ; get equipped Esper (displaced by JSL)
  STA $F7                         ; save it
  BPL .end
  LDA $3018,X                     ; get positional bit for character slot
  TSB $3F2E                       ; flag character as having Esper unavailable
  LDA $F7
.end
  RTL