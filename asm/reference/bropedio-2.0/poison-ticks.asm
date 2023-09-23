hirom

; BNW - Poison Tick Adjustments
; Bropedio (December 10, 2019)

!free = $C0D930
!warn = !free+14

org $C2503C
PoisonTicks:
  LDA $3E24,Y     ; poison incrementor
  JSL TickLogic   ; compute next tick
  CMP #$20        ; above max increment (31)
  BCC .valid      ; branch if not ^
  LDA #$1F        ; use max increment 31
.valid
  STA $3E24,Y     ; save new increment value
warnpc $C2504D

org !free
TickLogic:
  STA $BD         ; set damage increment
  BEQ .incr       ; initialize tick to 100%
  CPY #$08        ; monster range
  BCC .incr       ; branch if player target
  ASL             ; double tick for monsters
  INC             ; +50% more damage
  RTL
.incr
  INC #2          ; add 100% more damage
  RTL
warnpc !warn+1

