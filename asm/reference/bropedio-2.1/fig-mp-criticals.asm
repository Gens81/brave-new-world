hirom
; header

; Sir Newton Fig
; MP Critical MP Refresh

; Dead-end the unused special effect $0F (the other MP crit)
; It is already dummied out in BNW, and we're gonna steal
; its bytes.
org $C242FF : dw $3E8A                  

; Exit function if "No Critical and Ignore True Knight" is set
org $C23F29 : BNE MPReturn

; Exit function if no targets
org $C23F2E : BEQ MPReturn

; Exit function if weapon would drain more MP than the wielder currently has
org $C23F41 : BCC MPReturn

; This is where MP gets updated on an MP Crit
org $C23F4D                   
MPCritMPUpdate:
  LSR #2               ; Shift #$0200 -> #$0080
  JMP $464C            ; Set bit on $3204,Y and return
MPReturn:
  RTS                  ; Target of the branches in preceding code
  NOP                  ; Just dummying out this lone byte
warnpc $C23F57
