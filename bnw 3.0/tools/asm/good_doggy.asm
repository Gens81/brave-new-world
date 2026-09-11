; Good Doggy
; author: Bropedio
;
; Skip showing damage on Interceptor when he blocks

!free = $C2FC58 ; 10 bytes
!warn = $C2FC68

org $C23451 : JSR ShouldSkipDog ; include Doggy in Zinger check

org !free
ShouldSkipDog:
  TDC             ; A=0000
  BIT $3A82       ; Doggy block in hibyte ($3A83) - N: NoDog, Z: On
  BPL .exit       ; skip hit if Doggy block (no dmg numbers)
  CPY $33F8       ; [displaced] Check if target is Zingered
.exit
  RTS             ; if Z flag is set, will not be targeted
warnpc !warn
