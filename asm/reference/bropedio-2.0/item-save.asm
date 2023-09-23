hirom
;header

; BNW - Item Overwrite Fix
; Bropedio (July 20, 2019)
;
; Stealing an item while the Item or Weapon Swap commands
; are pending will overwrite the pending item or swap-in
; weapon. Similarly, if a character steals more than one
; item in a turn, only the last item stolen will be added
; to inventory.
;
; If a character dies before executing a queued Item or
; Weapon Swap command, the pending item will be lost if
; the character queues another Item, Weapon Swap, or Steal
; command executes prior to the end of battle.

!free_c2 = $C2654B ; 31 bytes

; ###############################################
; Return reserve items to inventory on queue wipe

org $C20A2B
ReserveCheck:
  JMP ReturnReserve

; ###############################################
; Immediately add Stolen items to inventory, preserving
; any existing reserve item.

org $C23A7C
Metamorph:
  XBA               ; store acquired item in B
  LDA $3018,X       ; character's unique bit
  JSR SaveItem      ; save new item to buffer
  NOP #2

org $C239EC
Steal:
  XBA               ; store acquired item in B
  JSR $3CB8         ; free-turn + load unique bit
  JSR SaveItem      ; save new item to buffer
  NOP #2

; ###############################################
; New Code (in C2)

org !free_c2
SaveItem:           ; 21 bytes
  TSB $3A8C         ; set character's reserve item to be added
  LDA $32F4,X       ; load current reserve item
  PHA               ; save reserve item on stack
  XBA               ; get new item in A
  STA $32F4,X       ; store new item in reserve byte
  PHX               ; save X
  JSR $62C7         ; add reserve to obtained-items buffer
  PLX               ; restore X
  PLA               ; restore previous reserve item
  STA $32F4,X       ; store in reserve item byte again
  RTS

ReturnReserve:      ; 10 bytes
  LDA $3018,X       ; character's unique bit
  TSB $3A8C         ; return reserve to inventory at turn end
  LDA $3219,X       ; ATB top byte (vanilla code)
  RTS
