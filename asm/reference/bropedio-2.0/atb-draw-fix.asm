hirom
; header

; BNW - ATB Draw Fix
; Bropedio (July 12, 2019)
;
; This is a small fix, best modified directly to Seibaby's
; ATB colors patch. The patch currently prevents ATB bars
; from drawing while any animations are playing; this is
; done in order to ensure that ATB colors wait to change
; until the attack animations plays out (otherwise, characters
; will appear to receive Haste/Slow/Stop status before the
; player even sees what causes it.
;
; The downside of this approach is that it can allow battle menus
; to open before ATB has a chance to visually update to "full".
;
; The solution below uses the special buffer bytes for character
; statuses. These buffers are not updated until attack animations
; complete, so they ensure ATB color does not change early.

org $C16872        ; 30 bytes (8 bytes fewer than before)
  LDA $2021        ; ATB gauge setting
  LSR              ; Gauge enabled?
  BCC drawMaxHP    ; Branch if disabled
  LDA $4E          ; Text color
  PHA              ; Save it
  LDX $10          ; Offset to character data
  JSL NewFunc      ; Get ATB color based on status
  STA $4E          ; Store palette
  LDA $18          ; Which character is it (0-3)
  TAX              ; Index it
  LDA $619E,X      ; Character's ATB gauge value
  JSR $6854        ; Draw the gauge
  PLA              ; Get saved text color
  STA $4E          ; Store text color
.exit
  RTS

org $C16898
drawMaxHP:
  LDA #$C0         ; Draw a "/" as HP divider

org $EEB19F
NewFunc:           ; 29 bytes (8 bytes fewer than before)
  LDA $0011,X      ; Status byte 3 (buffer)
  BIT #$10         ; Is Stop status set?
  BEQ .slow        ; Branch if not Stopped
  LDA #$3D         ; Select palette #8           STOPPED
  BRA .store       ; Store palette
.slow
  BIT #$04         ; Is Slow status set?
  BEQ .haste       ; Branch if not Slowed
  LDA #$2D         ; Select palette #4           SLOW
  BRA .store       ; Store palette
.haste
  BIT #$08         ; Is Haste status set?
  BEQ .normal      ; Branch if not Hasted
  LDA #$39         ; Select palette #7           HASTE
  BRA .store       ; Store palette
.normal
  LDA #$35         ; Select palette #6           NORMAL
.store
  RTL
