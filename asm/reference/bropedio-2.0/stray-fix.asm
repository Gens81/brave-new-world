hirom
; header

; BNW - Stray/Jackpot Ally Targeting Fix
; Bropedio

!strayfree = $C25141  ; hopefully this is freespace

org !strayfree                ; When we get here, A = 11A2 & #80
TargetDead:   PHP             ; store C flag (used later)
              LDX #$9C        ; load 0x4E * 2 (current X does not need saving)
              CPX $11A9       ; compare to attack's special effect
              BNE .end        ; if not set, finish
              ORA #$08        ; else, add target dead flag
.end          TSB $BA         ; finish setting BA bits
              PLP             ; restore C flag
              RTS

org $C22775 : JMP TargetDead  ; check for 4E special
