hirom
; header

; BNW - Variance Overflow Fix
; Bropedio

org $C2A789
VarianceFix:  PHA         ; store stat (stam or vig/2) on stack
              LSR
              LSR
              STA $E8     ; E8 = stat/4
              LDA #$1E    ; A = 30
              SEC
              SBC $E8     ; A = 30 - stat/4 (this is the variance range)
                          ; (hi = 255-stat, lo=225-.75stat. hi - lo = 30 - .25stat)
              BCC .store  ; if negative, immediately store this value as E8
              INC
              JSR $4B65   ; A = rand(0...max_variance)

.store        STA $E8     ; E8 = random variance OR negative diff between hi and lo
              PLA         ; A = stat
              EOR #$FF    ; A = 255 - stat
              
              SEC
              SBC $E8     ; A = (255 - stat) - random_variance
              STA $E8     ; if E8 is negative, A will equal the low bound

padbyte $EA
pad $C2A7A9

