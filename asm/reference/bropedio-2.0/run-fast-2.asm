hirom
; header

; BNW - Run Fast (Version 2)
;
; Since nATB ensures running cannot charge while attacks
; are animated, the run difficulty value no longer needs
; to scale with the number of enemies.
;
; This patch fixes difficulty at 5 for regular enemy packs,
; and 10 for packs that contain a "hard to run from" enemy.
; Much of the RunLoop code is just shifted from its position
; in vanilla.
;
; A secondary change is the removal of the 7/8 chance to ignore
; run readiness. Now, if a character becomes able to run, they
; will do so at the first opportunity.


org $C25CA4
PrepRunLoop:
  LDA #$05
  STA $3A3B       ; set difficulty to 5 by default
  STZ $3ECA       ; zero unique enemy names
RunLoop:
  LDA $3AA8,Y
  LSR 
  BCC NextEnemy   ; skip if this monster not present
  LDA $3021,Y
  BIT $3A3A   
  BNE NextEnemy   ; skip if this monster deadish or escaped
  BIT $3409
  BEQ NextEnemy
  LDA $3EEC,Y     ; monster status byte 1
  BIT #$C2
  BNE NextEnemy   ; skip if zombie, petrify, wound
  LDA $3C88,Y 
  LSR             ; put "harder to run" in carry
  BIT #$04
  BEQ .cont       ; branch if not "can't escape"
  LDA #$06
  TSB $B1         ; set "can't run" and "can't escape"
.cont
  BCC .reg        ; branch if not "harder to run"
  LDA #$0A
  STA $3A3B       ; else, set difficulty to 10
  NOP #2
.reg
warnpc $C25CDC

org $C25D04
NextEnemy:

org $C25D0A
  BCC RunLoop

; Always queue running when ready
org $C25BE0
  NOP #2
