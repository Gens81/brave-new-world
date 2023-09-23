hirom

; BNW - Roll Better
; Bropedio (September 17, 2019)
;
; Improve the performance of Dice and Fixed dice by simplifying the
; rolling algorithm and giving Dice the same bonus received by Fixed
; Dice when all the dice show the same number.
;
; Total routine size: 100 bytes (down from vanilla's 142);

org $C24158           ; 81 bytes
DiceDamage:
  STZ $3414           ; (vanilla) set to not modify dmg
  LDA #$20            ; (vanilla)
  TSB $11A4           ; (vanilla) make roll unblockable
  LDA $B5             ; (vanilla) command id (animation)
  BNE .continue       ; (vanilla) skip if command is not "Fight"
  LDA #$26            ; (vanilla) "Dice Toss" animation id
  STA $B5             ; store new animation
.continue
  LDA #$01            ; use base multiplier of x1
  XBA                 ; store multiplier in B
  JSR RollDie         ; roll first die
  STA $E8             ; set potential dubs multiplier
  ASL #4              ; move roll into top nibble
  STA $B7             ; set first roll for animation
  JSR RollDie         ; roll second die
  TSB $B7             ; set second roll for animation
  JSR $239C           ; get hit rate
  CMP #$03            ; "Fixed Dice" count
  LDA #$0F            ; prepare to set 3rd die animation to "null"
  BCC .skip_third     ; skip third die if roll count < 3
  JSR RollDie         ; roll third die
.skip_third
  STA $B6             ; set 3rd die animation
  LDA $11AF           ; attacker's level
  ASL                 ; x2
  JSR $4781           ; get base dmg (die1*die2*die3*lvl*2)
  LDX $E8             ; check dubs bonus
  BEQ .set_dmg        ; branch if no dubs bonus
  INC $E8             ; convert matching die id to multiplier
  JSR $47B7           ; multiply base dmg by dubs bonus
  TDC                 ; A = 0000
  CMP $EA             ; overflow dmg byte 
  REP #$20            ; 16-bit A
  DEC                 ; get max damage 0xFFFF
  BCC .set_dmg        ; if overflow, use max 0xFFFF
  LDA $E8             ; else, load 16-bit damage product
.set_dmg
  REP #$20            ; 16-bit A (duplicate REP needed when no dubs)
  STA $11B0           ; save attacker damage
  RTS

RollDie:              ; 19 bytes
  LDA #$06            ; prepare random range
  JSR $4B65           ; rand(0...5)
  PHA                 ; save zero-based roll
  CMP $E8             ; compare to bonus multiplier
  BEQ .dubs           ; branch if match
  STZ $E8             ; else, zero dubs bonus
.dubs
  INC                 ; get dmg multiplier
  JSR $4781           ; multiply with current multiplier
  XBA                 ; move new multiplier to B
  PLA                 ; restore zero-based roll
  RTS

warnpc $C241E7
