hirom
; header

; BNW - Rod Break Clear (Seibaby)
; Bropedio (September 7, 2019)
;
; Make spells cast from breaking rods remove "vanish"
; status. In vanilla, they inherit the "ignore vanish"
; flag set for all items.

; ########################################
; Remove old item command patch/helper

org $C20557
padbyte $FF
pad $C20560

org $C21897
  STZ $3414          ; restore vanilla code

org $C218C1
  LDA $3411          ; restore vanilla code

; #######################################
; New item magic handling

org $C2382D
UnblockCast:         ; end of spellcast proc routine

org $C218F3
  JSR UnblockCast    ; set unblockable, unreflectable
  LDA #$80
  TSB $B3            ; allow clear/vanish removal
  DEC $3414          ; allow dmg modification
