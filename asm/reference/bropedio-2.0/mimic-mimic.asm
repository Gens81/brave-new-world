hirom

; BNW - Mimic Mimic
; Bropedio (December 8, 2019)
;
; Gogo should not be able to Mimic himself, creating endless
; chains of repeat attacks. While typically not a useful
; strategy, these repeat mimics can be abused when combined
; with Palidor, who can be summoned repeatedly without delay.
;
; REQUIRES: Mind Blast expansion

!mimic = $3A62 ; battle RAM, used to be mind blast target
!free = $C2FB7D
!stop = !free+34

; ###########################################################
; Follow-up mimic handling by clearing command

org $C20224 : JSR ResetMimic
org $C20115 : JSR TrackMimic

org !free
TrackMimic:
  STA !mimic      ; set "mimic" flag
  JMP $01D9       ; continue to mimic handling
ResetMimic:
  LDA !mimic      ; was this turn a mimic 
  BNE .reset      ; branch if so
  LDA $3A7C       ; just-executed command
  RTS
.reset
  STZ !mimic      ; clear mimic variable
  STZ $3F20       ; zero last command
  STZ $3F22       ; zero last targets
  LDA #$12        ; default command placeholder
  STA $3F24       ; remove "gembox" command
  STA $3F28       ; remove "jump" command
  ASL             ; ensure A is > #$1E
  RTS
warnpc !stop+1
