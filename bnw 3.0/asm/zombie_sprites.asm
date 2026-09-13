hirom

org $D514A0	: incbin "zombie/zombie_terra.bin"
org $D52B40	: incbin "zombie/zombie_locke.bin"
org $D541E0	: incbin "zombie/zombie_cyan.bin"
org $D55880	: incbin "zombie/zombie_shadow.bin"
org $D56F20	: incbin "zombie/zombie_edgar.bin"
org $D585C0	: incbin "zombie/zombie_sabin.bin"
org $D59C60	: incbin "zombie/zombie_celes.bin"
org $D5B300	: incbin "zombie/zombie_strago.bin"
org $D5C9A0	: incbin "zombie/zombie_relm.bin"
org $D5E040	: incbin "zombie/zombie_setzer.bin"
org $D5F6E0	: incbin "zombie/zombie_mog.bin"
org $D60D80	: incbin "zombie/zombie_gau.bin"
org $D62420	: incbin "zombie/zombie_gogo.bin"
org $D63AC0	: incbin "zombie/zombie_umaro.bin"
org $D66800	: incbin "zombie/zombie_imp.bin"
org $D6A960	: incbin "zombie/zombie_morph.bin"
org $D6FEE0	: incbin "zombie/zombie_gestahl_fix1.bin"
org $D70000	: incbin "zombie/zombie_gestahl_fix2.bin"

org $C2C8D5
dw $FFFF, $FFFF, $14A0, $14C0, $14E0, $1500, $1520, $1540

;Shifts "Dog Sprite" graphics over six 8x8 blocks, so pose $19 still works with the Dead-Gestahl sprite.
org $C0D124
dw $FFA0

;; Status 1: harmful status that persist after battle
;; 01: Zombie        $02 : $FD
;; 02: Poison        $04 : $FB
;; 07: Wound         $80 : $7F

;; Status 2: harmful status that do not persist after battle
;; 09: Near Fatal    $02 : $FD
;; 0D: Muddled       $20 : $DF
;; 0F: Psyche        $80 : $7F (Sleep)

;; Status 4: only float and interceptor persist after battle
;; 1C: <Trance>      $10 : $EF

org $C13071
SetCharacterTertiaryGraphicAction:

    LDA $2EBD,X                 ; load status 1 ("wound" flag in sign bit)
    BPL +                       ; branch unless "wound"
    LDA #$01                    ; "wound" graphic action
    BRA .end

+
    XBA                         ; B <- status 1
    LDA $2EBE,X                 ; load status 2 ("sleep" flag in sign bit)
    BPL +                       ; branch unless "sleep"
    LDA #$0A                    ; "critical" graphic action
    BRA .end

+
    BIT #$20                    ; test "muddle" bit
    BEQ +                       ; branch unless "muddle"
    LDA #$25                    ; "muddle" graphic action
    BRA .end

+
    BIT #$02                    ; test "near fatal" bit
    BEQ +                       ; branch unless "near fatal"
    LDA #$0A                    ; "critical" graphic action
    BRA .end

+
    XBA                         ; A, B <- status 1, 2
    BIT #$04                    ; test "poison" bit
    BEQ +                       ; branch unless "poison"
    LDA #$0A                    ; "critical" graphic action
    BRA .end

+
    BIT #$02                    ; test "zombie" bit
    BEQ +                       ; branch unless "zombie"
    LDA #$17                    ; "zombie" graphic action
    BRA .end

+
    LDA $61BB,X                 ; character graphic action (i.e. fallback)
    BNE .end                    ; branch if set
    LDA #$06                    ; otherwise, "facing forward" (i.e. default) graphic action
    ;; fall through
    
.end:
    STA $61BF,X                 ; set character tertiary graphic action
    RTS

padbyte $FF
pad $C130C3

+
    XBA                         ; b <- status 1
    LDA $2EBE,X                 ; a <- status 2 ("sleep" flag in sign bit)
    BPL +                       ; branch unless "sleep"
    LDA #$0A                    ; "critical" graphic action
    BRA .end

+
    BIT #$20                    ; test "muddle" bit
    BEQ +                       ; branch unless "muddle"
    LDA #$25                    ; "muddle" graphic action
    BRA .end

+
    BIT #$02                    ; test "near fatal" bit
    BEQ +                       ; branch unless "near fatal"
    LDA #$0A                    ; "critical" graphic action
    BRA .end

+
    XBA                         ; a, b <- status 1, 2
    BIT #$04                    ; test "poison" bit
    BEQ +                       ; branch unless "poison"
    LDA #$0A                    ; "critical" graphic action
    BRA .end

+
    BIT #$02                    ; test "zombie" bit
    BEQ +                       ; branch unless "zombie"
    LDA #$17                    ; "zombie" graphic action
    BRA .end

+
    LDA $61BB,X                 ; character graphic action (i.e. fallback)
    BNE .end                    ; branch if set
    LDA #$06                    ; otherwise, "facing forward" (i.e. default) graphic action
    ;; fall through

.end:
    STA $61BF,X                 ; set character tertiary graphic action
    RTS

warnpc $C130C3
padbyte $FF
pad $C130C3

org $C1FEE2
    ;; By default, zombies participate in group animations in battle, and the victory
    ;; animation in particular. This change (to battle event command $12) treats them more
    ;; like wounded characters, so they won't cheer at the end of battle, and likewise
    ;; they won't enter the frame at the start of battle.

    AND #$C2                    ; test "wound", "petrify", "zombie" bits
