hirom

; Fix Bug Causing Imp status to mess with command disabling

org $C252BB : LSR ; use LSR instead of ROR -- commands never have $80 set
