hirom
; header

; BNW - EL Boost Bug Fixes
; Bropedio

; Seraph not blocking Zombie
org $C0D762
SeraphStatus:
  db $C2              ; add Zombie to Seraph's status block byte

; Ragnarok bonus
; This is failing because the esper bonus patch is placing the MagDmg% bonus
; in the old "double earrings" bit, which is no longer checked.
; The simplest solution is to add handling at the end of the C0/D79E subroutine
; to copy the "double earring" flag over to the "single earring" bit

!earringfree = $C0D827 ; 14 bytes

org $C0D7C2
  JSR EarringFix      ; extend handling in subroutine

org !earringfree
EarringFix:
  TSB $11D4           ; set aggregate equipment bits
  SEP #$20            ; 8-bit A
  XBA                 ; A = 11D5 bits 
  AND #$02            ; isolate earring bit
  TSB $11D7           ; set earring bit
  REP #$20            ; 16-bit A
  RTS

; Fenrir +1 Mag Evade bug
; This bug is caused by a carry flag. We can avoid adding an explicit CLC
; by swapping the LSR and AND statements below, ensuring C flag is always
; zero after the last LSR.

org $C0D7F0
  AND #$F0
  LSR
  LSR
  LSR
  LSR


; Related ADC Bugs that haven't been noticed yet. These can only be solved
; by inserting the requisite CLC ops before ADC. This requires updating
; several branch and/or jump arguments. Since these bugs are low-priority,
; I'm only listing the CLC insertion points here.

; -> D7E9 - If an esper gives Mag+8 (or greater), the top bit will carry to +1 evade
; -> D807 - Unlikely bug: M.Block overflow will carry over +1 defense
; -> D815 - Defense overflow will carry over +1 mag.def.
