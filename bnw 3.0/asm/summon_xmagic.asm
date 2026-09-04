; -----------------------------------------------------------------------------
; Synopsis: Unlocks the ability to summon an esper when x-magic is active.
;     Base: BNW 2.2b16
;   Author: Fëanor
;  Created: 2023-06-10
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Explanation
; -----------------------------------------------------------------------------
; The game uses the address $7AE9 to track the number of queued up x-magic
; spells. If x-magic is disabled then its value is always 0, otherwise it's
; either 0 or 1 depending on if the queue is empty or not.
;
; This hack replaces the default behavior which is to check if x-magic is
; enabled/disabled for determing whether summoning is locked/unlocked with
; checking $7AE9 instead (0=unlocked, 1=locked). Thus, summoning is unlocked as
; long as the character has no spells queued up.
; -----------------------------------------------------------------------------
hirom

!free = $C13E15     ;  7 bytes of freespace required
!warn = !free+10    ; 10 bytes available

; -----------------------------------------------------------------------------
; [ update menu state $0e: spell select ]
;   ...
;   BNE $819B
;   INC $94
org $C1818E
    LDA $7AE9       ; load x-magic spell queue size
;   BNE $81A4
;   JSR $829B
;   ...
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; [ update menu state $16: esper select ]
;   ...
;   JSR $6D56
;   LDA #$19
org $C182E6
    JSR SpliceEsperSelect
;   LDA $208E,X
;   STA $7A85
;   ...
; -----------------------------------------------------------------------------

; increment x-magic spell queue size which disables the ability to select a
; second spell in addition to summoning
org !free
SpliceEsperSelect:
    INC $7AE9       ; increment x-magic spell queue size
    STA $2BAF,Y     ; [displaced]
    RTS
warnpc !warn
