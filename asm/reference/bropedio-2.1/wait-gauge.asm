hirom
table table_c3.tbl,rtl

; Wait Gauge
; Bropedio

org $C25C5A : JSL WaitRemaining
org $C14AB7 : LDA #$00 ; Always disable morph
org $C22493 : BRA $03 ; Never turn off gauges

; ####################################
; Update Gauge Toggle Code

org $C3F444
SelectGauge:
  STZ $2021         ; default to flag "off"
  LDA $0B           ; semi-auto keys
  ASL #2            ; shift "Select" to $80
  BMI .exit         ; branch if ^
  DEC $2021         ; else set flag "on" ($FF)
.exit
  RTL
GaugeLabel:
  dw $3B8F : db "Show Delay",$00
GaugeOn:
  LDA #$80          ; 'Show Delay' flag
  STA $1D4E         ; init config option
  RTS
warnpc $C3F46B

org $C370C5 : JSR GaugeOn

; Swap "Off" and "On" for new "Wait Gauge" setting
org $C33C7E : LDY #OnWait
org $C34935
OffWait:
  dw $3BA5 : db "Off",$00
OnWait:
  dw $3BB5 : db "On",$00

; New Label for "Gauge" option
org $C3499B : dw GaugeLabel

; ####################################

org $EEB1C4
HelpCaps:
  BMI .full        ; branch if ATB is full
  PEA $FAF9        ; empty endcaps
  BRA .done
.full
  PEA $FCFB        ; special endcaps
.done
  PHA              ; save gauge value
  TDC              ; clear B
  PLA              ; restore gauge value
  AND #$7C         ; masked
  TAX              ; index it
  PLA              ; get first cap value 
  JML FinGauge     ; finish up
NormDraw:
  PHA
  LDA $4E
  XBA
  LDA #$35
  STA $4E
  PLA
  JSL LongDraw
  XBA
  STA $4E
  TDC
  RTL
warnpc $EEB201 

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
warnpc $C16873

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
warnpc $C19103

; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
; BNW - ATB Draw Fix
; Bropedio (July 12, 2019)
; NOTE: Modified for wait gauges
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
ATBDrawFix:
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
  LDA $619E,X      ; Character's ATB (or wait) gauge value
  JSR $6854        ; Draw the gauge
  PLA              ; Get saved text color
  STA $4E          ; Store text color
.exit
  RTS
LongDraw:
  JSR $66F3
  RTL
warnpc $C16899

org $C16898
drawMaxHP:
  LDA #$C0         ; Draw a "/" as HP divider
  db $20,$F3,$66,$A9,$09 ; vanilla reversion - remove

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
