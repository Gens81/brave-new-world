hirom

; BNW - Ancient Basement
; Bropedio (December 25, 2019)

org $CC1F8B
  db $FE            ; return

;org $CC1F91
;  db $F4,$1B        ; play picked-up-item sound effect
;  db $4B,$A4,$06    ; display dialogue message $06A4
;  db $80,$AC        ; add item $AC to inventory 
;  db $D4,$DE        ; set event bit (to disable tile?)
;  db $FE            ; return

org $CC1A06
  dw $FDFD          ; null event bit check
  dw $FDFD          ; null event bit check
  dw $FDFD          ; null event bit check
