; -----------------------------------------------------------------------------
; Synopsis: Makes rows behave as one would expect in the second phase of the
;           battle against Intangir.
;     Base: BNW 2.2b17.1
;   Author: Fëanor
;  Created: 2023-06-25
; -----------------------------------------------------------------------------
hirom

; -----------------------------------------------------------------------------
; NOTICE:
; This hack works on the assumption that there are only front attack to back
; attack mid-battle transitions. If in the future other mid-battle transitions
; (e.g. front attack to pincer attack) are added, this hack will need to be
; replaced with a more generalized version.
; -----------------------------------------------------------------------------

!free_c2 = $C239C8      ; 11 bytes required
!warn_c2 = !free_c2+11  ; 11 bytes available

!free_c4 = $C4F2DB      ; 18 bytes required
!warn_c4 = !free_c4+37  ; 37 bytes available

; -----------------------------------------------------------------------------
; Command $20: Battle Change [C25072]
; ...
; C2/50B3: 20 C9 26     JSR $26C9
; C2/50B6: 20 3A 2E     JSR $2E3A
org $C250B9 
    JSR BattleChangeSplice
; C2/50BC: 8D 2B 3A     STA $3A2B
; C2/50BF: AD 1E 20     LDA $201E
; ...
; -----------------------------------------------------------------------------

; swaps both mechanical and graphical row flags when a battle change (i.e. a
; formation swap) is performed mid-battle
org !free_c2
BattleChangeSplice: ; [11 bytes]
    JSR $2ECE       ; swap mechanical row flags
    JSL SwapRows    ; swap graphical row flags
    LDA $3A75       ; [displaced]
    RTS
warnpc !warn_c2

; custom subroutine to swap graphical row flags of party
org !free_c4
SwapRows:           ; [18 bytes]
    LDX #$60
  - LDA $2EC5,X     ; load graphical row flag
    EOR #$01        ; toggle it
    STA $2EC5,X     ; store it
    TXA
    SEC             ; set carry flag
    SBC #$20
    TAX
    BPL -           ; loop until < 0
    RTL
warnpc !warn_c4

;Deleted Intangir from formation 338 2nd slot to avoid transfering its weaknesses to Intangir Z

org $CF75D1 
db $FF

org $CF75D7
db $00
