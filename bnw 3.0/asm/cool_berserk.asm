hirom

;;; Cool Berserk
;;;
;;; Hack by toadstyle
;;;
;;; To show more status information in battle, reprioritize the list of status
;;; sprites. (In other words, allow berserk characters to look cool with sunglasses.)
;;;
;;; There are various mechanisms to display status information in battle: glowing auras
;;; (i.e. sprite borders), color palettes, status sprites, and ATB bar colors.
;;;
;;; Each of these has its own order of precedence. For example, if a character is both
;;; poisoned and mute, "poison" will win out: the character will have green bubbles above
;;; their head instead of a thought bubble.
;;;
;;; By default, the order of precedence for status sprites looks like this:
;;;
;;; 1. Sleep
;;; 2. Muddle
;;; 3. Berserk
;;; 4. Rage
;;; 5. Poison
;;; 6. Dark
;;; 7. Mute
;;;
;;; We rearrange this list like so:
;;;
;;; 1. Sleep
;;; 2. Muddle
;;; 3. Dark
;;; 4. Mute
;;; 5. Poison
;;; 6. Berserk
;;; 7. Rage
;;;
;;; "Sleep" and "muddle" remain at the highest precedence. Since they have such high
;;; precedence mechanically, it's important to understand clearly when a party member is
;;; afflicted by one of these ailments.
;;;
;;; "Dark" and "mute" are promoted to the next highest slots. Since they are communicated
;;; solely through status sprites, they need to be above "berserk" and "poison" (which
;;; also use palette changes). This way, if a party member is both berserk and blind,
;;; they'll have red skin and sunglasses, communicating two statuses at once.
;;;
;;; Next, we flip the relative order of "poison" and "berserk" (and see also the opposite
;;; change in undead_skin.asm). This is so a character with both statuses will have red
;;; skin and green bubbles over their head. (The alternative, purple skin and rising
;;; steam, doesn't read as clearly.)
;;;
;;; Finally, we demote "rage" to the bottom of the list on the assumption the user can be
;;; trusted to remember when they put Gau (or Gogo) in this mode.
;;;
;;; Relevant status flags:
;;;
;;; Status 1: harmful status that persist after battle
;;; 00: Dark          $01 : $FE
;;; ...
;;; 02: Poison        $04 : $FB
;;; ...
;;;
;;; Status 2: harmful status that do not persist after battle
;;; ...
;;; 0B: Mute          $08 : $F7
;;; 0C: Berserk       $10 : $EF
;;; 0D: Muddled       $20 : $DF
;;; ...
;;; 0F: Psyche        $80 : $7F (Sleep)
;;;
;;; Status 4: only float and interceptor persist after battle
;;; 18: <Rage>        $01 : $FE
;;; ...

org $C12F24
SetStatusSprite:
    LDA $2EBE,X                 ; a <- status 2 ("sleep" in sign bit)
    BPL +                       ; branch unless "sleep"
    LDA #$06                    ; "sleep" sprite
    BRA .end
+
    BIT #$20                    ; test "muddle" bit
    BEQ +                       ; branch unless "muddle"
    LDA #$02                    ; "muddle" sprite
    BRA .end
+
    XBA                         ; b <- status 2
    LDA $2EBD,X                 ; a <- status 1
    ROR                         ; "dark" bit to carry flag
    BCC +                       ; branch unless "dark"
    LDA #$03                    ; "dark" sprite
    BRA .end
+
    XBA                         ; a, b <- status 2, 1
    BIT #$08                    ; test "mute" bit
    BEQ +                       ; branch unless "mute"
    LDA #$05                    ; "mute" sprite
    BRA .end
+
    XBA                         ; a, b <- status 1, 2
    BIT #$02                    ; test "poison" bit (right-shifted)
    BEQ +                       ; branch unless "poison"
    LDA #$01                    ; "poison" sprite
    BRA .end
+
    XBA                         ; a, b <- status 2, 1
    BIT #$10                    ; test "berserk" bit
    BEQ +                       ; branch unless "berserk"
    LDA #$04                    ; "berserk/rage" sprite
    BRA .end
+
    LDA $2EC0,X                 ; a <- status 4
    ROR                         ; "rage" bit to carry flag
    BCC +                       ; branch unless "rage"
    LDA #$04                    ; "berserk/rage" sprite
    BRA .end
+
    TDC
.end:
    STA $61CF,X                 ; set status sprite
    RTS

warnpc $C12F75
padbyte $FF
pad $C12F75
