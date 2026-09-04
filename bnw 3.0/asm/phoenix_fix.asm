; Adjustment to "Miss animation selection routine (rewritten for "Doggy Miss" patch)"
; This will prevent the shield animation from playing when a ressurection ability misses a living target
; This prevents:
; Phoenix from breaking graphics
; Phoenix from bugging Setzer when summoned with BAR-BAR-BAR
; The occassional dead person from coming alive to hold a shield

hirom

; Add back Phoenix to the BAR BAR BAR pool
org $C237DD
    db $1B

org $C223D3
  JMP CheckReviveTarget  ; was LDA $11A2 -- same size, offloaded

org $C2AEE7             ; free space stolen from "battle status name table"
CheckReviveTarget:      ; 15 bytes
  LDA $11A2             ; attack flags 1
  BIT #$04              ; resurrection-targeting flag
  BEQ .continue         ; flag clear -> proceed normally
  LDA #$00              ; force empty animation pool, same as vanilla's "no block anim" case
  JMP $23DD             ; flag set -> jump straight to .exit
.continue
  JMP $23D6             ; flag clear -> resume at .resume (the old LSR)