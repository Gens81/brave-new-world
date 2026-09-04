hirom

; Blue Wait Gauge
;
; Tweak wait gauge to be blue instead of white.
; Reproduces a couple ATB draw helpers to insert new code

org $EEB1C4

HelpCaps:
  BMI .full        ; branch if ATB is full
  PEA $FAF9        ; empty endcaps
  BRA .done
.full
; ------ New code here ------- ;
  PHA              ; store ATB value
  INC              ; check for full ATB
  BEQ .nope        ; branch if ^
  LDA #$25         ; color: Blue
  STA $4E          ; set "Wait" palette color
.nope
  PLA              ; restore ATB value
; ------ End of new code ------- ;
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
warnpc $EEB200

; ---------------------------------------------
; Some pointers to the other ATB draw routines

org $C16858 : FinGauge:
org $C16890 : LongDraw:

; ---------------------------------------------
; Update some pointers to the NormDraw helper (now shifted)

org $C16858 : JSL NormDraw
org $C1686C : JSL NormDraw
