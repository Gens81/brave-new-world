hirom

; -----------------------------------------------------------------------------
; This hack allows players to hold the B button to progress through dialogue,
; instead of having to mash the A button. It automatically stops at multiple
; choice prompts and works both in and out of battle for consistency.
; -----------------------------------------------------------------------------

!free_c0 = $C0FCCF  ; requires 47 bytes of unused space
!warn_c0 = $C0FD00  ; provides 49 bytes of unused space

!free_c1 = $C13E02  ; requires 18 bytes of unused space
!warn_c1 = $C13E15  ; provides 19 bytes of unused space

; hook into "Update Dialog Text" routine
org $C0821F : JMP HandleFieldText

; hook into "Update A Button Event Bit" routine
org $C0BA94 : JMP HandleEventBit

org !free_c0
HandleFieldText:    ; 26 bytes
    LDA $056F       ; max multiple choice selection
    BNE +           ; branch if multiple choice selection
    NOP #7          ; placeholder for autoscroll patch
    LDA $07         ; buttons pressed this frame (mapped)
    BPL +           ; branch if B button is not down
    JMP $8231       ; move on to next line/page of text
  + LDA $D3         ; [displaced] keypress state (is 1 or 2)
    CMP #$01        ; [displaced]
    JMP $8223       ; continue on with checks
HandleEventBit:     ; 21 bytes
    NOP #7          ; placeholder for autoscroll patch
    LDA $06         ; [displaced] buttons pressed this frame (mapped)
    BMI +           ; branch if A button is down
    LDA $07         ; buttons pressed this frame (mapped)
    BMI +           ; branch if B button is down
    JMP $BAA2       ; unset event bit
  + JMP $BA98       ; set event bit
warnpc !warn_c0

; hook into "Dialog Special String $07: Wait for Keypress" routine
org $C15E97 : JMP HandleBattleText

org !free_c1
HandleBattleText:   ; 18 bytes
    JSR $5E02       ; [displaced]
    NOP #7          ; placeholder for autoscroll patch
    LDA $05         ; buttons pressed this frame (mapped)
    BMI +           ; branch if B button is down
    JMP $5E9A
  + RTS
warnpc !warn_c1
