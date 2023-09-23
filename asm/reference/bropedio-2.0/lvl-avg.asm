hirom
; header

; Tweak level averaging in WOR to use Lvl 21 for all characters other than
; Celes, Sabin, Edgar, Setzer
; Bropedio (May 21, 2019)

org $C09F73
SkipExpReset:

org $C09F45 : BCC SkipExpReset ; don't zero experience when level unchanged

org $C0D613
RaiseLevel:   LDA $1D4D
              AND #$08         ; is experience enabled
              BNE .lvlup       ; if yes, get new level (else, A=0)
.finish
              JMP $9F35        ; A will be minimum new level
.lvlup
              LDA $EB
              TAX              ; X = character #
              LDA Levels,X     ; A = rejoin level
              BRA .finish      ; set new level

Levels:
  db $15 ; Terra
  db $15 ; Locke
  db $15 ; Cyan
  db $15 ; Shadow
  db $13 ; Edgar
  db $12 ; Sabin
  db $12 ; Celes
  db $15 ; Strago
  db $15 ; Relm
  db $14 ; Setzer
  db $15 ; Mog
  db $15 ; Gau
  db $15 ; Gogo
  db $15 ; Umaro

; Fill remaining (now unused) bytes

padbyte $FF
pad $C0D636
