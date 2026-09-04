hirom

;;; Zombie Sprites
;;;
;;; Hack by toadstyle, sprites by khaos
;;;
;;; Add custom sprites for party members with zombie status. This hack is purely for
;;; flavor.
;;;
;;; Since tents are not included in BNW, there is a spare slot in each character's sprite
;;; sheet. We replace it with a custom zombie sprite and wire it up through the tertiary
;;; graphic action subroutine at C1/3071. Tertiary graphic actions are a low-priority idle
;;; animation used for things like muddle, sleep, and near fatal poses.
;;;
;;; We repurpose the unused graphic action $17 (table C2/C6A9), which statically displays
;;; graphic frame $19 (table C2/C745), which is seemingly glitchy and otherwise unused. We
;;; reconfigure it to display our new zombie sprite.
;;;
;;; We also tweak battle event command $12 (subroutine C1/FEB9) to prevent zombies from
;;; participating in group animations (e.g. the victory fanfare). This puts them more in
;;; line with other "dead" statuses like wounded and petrified.
;;;
;;; Finally, we also remove some dead code used to set the tertiary graphic action for
;;; Relm's Control command, which is removed in BNW.
;;;
;;; Relevant status flags:
;;;
;;; Status 1: harmful status that persist after battle
;;; 01: Zombie        $02 : $FD
;;; 02: Poison        $04 : $FB
;;; ...
;;; 06: Petrify       $40 : $BF
;;; 07: Wound         $80 : $7F
;;;
;;; Status 2: harmful status that do not persist after battle
;;; ...
;;; 09: Near Fatal    $02 : $FD
;;; ...
;;; 0D: Muddled       $20 : $DF
;;; ...
;;; 0F: Psyche        $80 : $7F (Sleep)

;;; New sprites

org $D50000
incbin "D50000_4bpp_sprites.bin"

org $D60000
incbin "D60000_4bpp_sprites.bin"

org $C2C8D5
    ;; Reconfigure graphic frame $19 to show the zombie sprite.
    dw $FFFF, $FFFF, $14A0, $14C0, $14E0, $1500, $1520, $1540

org $C13071
SetCharacterTertiaryGraphicAction:
    ;; Test status bits and set the tertiary graphic action.

    LDA $2EBD,X                 ; a <- status 1 ("wound" flag in sign bit)
    BPL +                       ; branch unless "wound"
    LDA #$01                    ; "wound" graphic action
    BRA .end

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
