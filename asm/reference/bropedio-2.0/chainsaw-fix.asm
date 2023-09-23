hirom
; header

; BNW - Chainsaw Update
; Bropedio (July 21, 2019)
;
; IMPORTANT: Depends on informative miss "SetNull" subroutine
;
; Removes stamina evasion support
; Only use hockey mask for death

!chaininit = $C22B2A   ; 21 bytes (5 freed)
!chaineffect = $C22C09 ; 24 bytes
!SetKill = $C0D83F

org $C22B20 : dw ChainsawInit   ; new location for init handling

org !chaininit
padbyte $FF         ; clear 5 unused bytes
pad $C22B2F

ChainEffect2:       ; 6 bytes
  JSR $35BB         ; update animation queue
  JMP $3A85         ; add "death" to statuses to set

ChainsawInit:       ; 15 bytes
  LDA #$AC
  STA $11A9         ; set special effect index
  LDA #$20
  TSB $11A2         ; set "ignore defense" flag
  LSR
  TSB $11A7         ; set "respect row" flag
  RTS

warnpc $C22B45

org !chaineffect
ChainsawEffect:     ; 24 bytes replaced
  JSR $4B5A
  CMP #$40
  BCS .rts          ; exit 75% of the time
  JSL !SetKill      ; requires label defined in informative-miss
  BNE .rts          ; exit if target immune to instant-death
  LDA #$08
  STA $B6           ; set Hockey Mask animation
  STZ $11A6         ; zero battle power
  JMP ChainEffect2  ; add "death" to statuses to set
.rts
  RTS

warnpc $C22C22
