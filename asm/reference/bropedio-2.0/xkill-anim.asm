hirom
; header

; BNW - Swap X-Kill and Cleave Animations
; Bropedio (July 21, 2019)
;
; IMPORTANT: Requires "chainsaw-fix" patch, to add JSR to correct address
;
; Zantetsuken --> Cleave animation
; Tarot/Demonsbane --> X-Kill animation

!free_slice = $C2372B ; 7 bytes (freespace from "skip-criticals-flag" patch)

; Add Cleave death animation to Chainsaw
org $D0921C : db $0B  ; not sure how, but this byte sets cleave anim

; Add X-Kill animation data back
org $D08696 : db $FF,$FF,$7F,$02,$FF,$FF,$35,$35,$00,$CC,$1B,$FF,$FF,$10

; Set Zantetsuken to use Cleave animation
org $C266B4 : NOP #3  ; animation already set to #EE, don't overwrite with #7E

; Disable counters for X-Kill/Cleave
org $C238D2
  JSR DisableCounter

; Disable counters for Chainsaw kill
org $C22C1A
  JSR DisableCounter

org !free_slice
DisableCounter:       ; 7 bytes
  STZ $11A6           ; vanilla code
  STZ $341A           ; disable counterattacks
  RTS
