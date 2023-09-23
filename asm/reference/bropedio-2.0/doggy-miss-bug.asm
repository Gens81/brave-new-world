hirom

; FF3 - Interceptor/Golem Block Bugfix
; Bropedio (Nov 5, 2019)
;
; Fix bug that randomly prevents Interceptor and Golem
; from blocking attacks, even after they cause the attack
; to miss.
;
; After reaching the miss routine (due to Dog Block or
; Golem), the game selects a miss animation at random from
; the combination of all available equipment and Interceptor
; or Golem. If an equipment block is selected, the miss
; proceeds as though it had been caused by regular evasion.
;
; The end result of this bug is that Interceptor will appear
; less frequently when Shadow's equipment enables various
; block animations: dagger parry, sword parry, shield, and cape.
; If all 4 equipment animations are available, the chance of
; Interceptor appearing is reduced from 50% to 10%, though he
; will still trigger misses 50% of the time.
;
; Additionally, this patch routes Dog/Golem past the check for
; Vanish/M-Tek/Zombie status that similarly cause Interceptor or
; Golem to be silently replaced with a basic "miss" animation.

; ############################################
; Jump/Branch destinations

org $C222BC : EnemyMissCheck:

; ############################################
; Skip M-Tek/Vanish/Zombie check for Dog/Golem

org $C22291 : BRA EnemyMissCheck ; dog block
org $C2229F : BRA EnemyMissCheck ; golem

; ############################################
; Rebalance Golem for more frequent appearance

org $C20CE0 : LDA #$C1 ; Revert to 192 defense

; ############################################
; Update miss check for animation type

org $C222C3 : CPX #$06 ; test if golem or dog block

; ############################################
; Rewrite miss animation selection routine

org $C223BF
ChooseAnimation:       ; 46 bytes
  PHY                  ; store Y
  TDC                  ; clear A/B
  LDA $FE              ; Dog/Golem
  BEQ .normal          ; branch if neither
  CMP #$40             ; "Dog Block"
  BNE .golem           ; if not dog, it's golem
  STY $3A83            ; save dog blockee
  BRA .set_miss        ; set miss animation
.golem
  STY $3A82            ; save golem blockee
  BRA .set_miss        ; set miss animation
.normal
  LDA $11A2            ; attack flags 1
  LSR                  ; carry: Physical
  BCS .get_anim        ; branch if ^
  INY                  ; next equipment byte
.get_anim
  LDA $3CE4,Y          ; phys/magic block animations
  JSR $522A            ; select random animation (A could be zero)
.set_miss
  JSR $51F0            ; get bit number in X (if zero A, carry clear)
  BCC .exit            ; exit if the animation pool (A) was empty
  INX                  ; add one (1-based)
  TYA                  ; target index
  LSR                  ; get target slot
  TAY                  ; use as index
  STX $AA,Y            ; save target animation
.exit
  PLY                  ; restore Y
  RTS
warnpc $C223EE

