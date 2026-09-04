hirom

;;; Undead Skin
;;;
;;; Hack by toadstyle, color palette by khaos
;;;
;;; To avoid the frustration of healing your undead party members into zombies, display
;;; undead characters with blue skin and red eyes to distinguish them visually in battle.
;;;
;;; Undead is the pseudo-status (really more like a monster type flag) stored in the high
;;; bit of $3C95 (+2x). It is set in battle for characters wearing a Ghost Ring, or when
;;; imitating an undead monster via Rage.
;;;
;;; Undead creatures are damaged by normal healing spells, so it's useful to be able to
;;; tell if one of your party members is undead, especially since they turn into zombies
;;; when they die.
;;;
;;; This change also fixes a bug where status auras (i.e. the glowing border to indicate
;;; shell, safe, or reflect) do not appear on poisoned or berserk characters.
;;;
;;; Finally, we flip the precedence of "berserk" and "poison" to give the former higher
;;; priority. This is to allow a character with both statuses to appear with red skin and
;;; green bubbles over their head to communicate both statuses. (See also
;;; cool_berserk.asm.)
;;;
;;; Color palette changes for undead characters:
;;;
;;; | Index | Usage           | RGB      | Hex   |
;;; |-------+-----------------+----------+-------|
;;; |     3 | red pupil       | 19/0/0   | $0013 |
;;; |     6 | light blue skin | 25/27/29 | $7779 |
;;; |     7 | dark blue skin  | 14/18/24 | $624E |
;;;
;;; Relevant status flags:
;;;
;;; Status 1: harmful status that persist after battle
;;; 01: Zombie        $02 : $FD
;;; 02: Poison        $04 : $FB
;;; ...
;;;
;;; Status 2: harmful status that do not persist after battle
;;; ...
;;; 0C: Berserk       $10 : $EF
;;; ...
;;;
;;; Monster type flag:
;;;
;;; $3C95 ui-h-n-m
;;;       u: undead
;;;       i: imp critical ??
;;;       h: human
;;;       n: don't display name
;;;       m: dies at 0 MP

AuraRotationCheckStatus = $C12E6B ; entry point for aura rotation code

org $C12E45
SkinColorCheckStatus:
    ;; Test status bits and branch to update color palettes

    TDC                         ; a <- 0
    TAX                         ; x <- 0
    LDA $37                     ; a <- status 2
    BIT #$10                    ; test "berserk" bit
    BNE SetSkinColorBegin       ; branch if "berserk"

    INX                         ; x <- 1
    LDA $36                     ; a <- status 1
    ROR #2                      ; "zombie" bit to carry flag
    BCS SetSkinColorBegin       ; branch if "zombie"

    INX                         ; x <- 2
    ROR                         ; "poison" bit to carry flag
    BCS SetSkinColorBegin       ; branch if "poison"

    INX                         ; x <- 3

    ;; Y currently has a party member index that is a multiple of $20, but we need one
    ;; that's a multiple of 2. Save the current Y, compute Y/16 (via shifts), load the
    ;; flag, and restore Y.
    ;;
    ;; Note that this value is actually computed and discarded earlier in the
    ;; subroutine starting at C1/2DD3, so in theory we could save more code space by
    ;; saving that value and restoring it here. It seemed simpler to keep the changes
    ;; local.
    PHY                         ; push y
    TYA                         ; a <- y
    LSR #4                      ; a <- a / 16
    TAY                         ; y <- a
    LDA $3C95,Y                 ; a <- monster type
    PLY                         ; pull y

    ;; Note that we have a different branch target for undead versus the above
    ;; statuses; see below.
    BIT #$80                    ; test "undead" bit
    BNE SetUndeadEyeColor       ; branch if "undead"

    ;; Otherwise, branch to aura rotation (which follows this code immediately).
    BRA AuraRotationCheckStatus

warnpc AuraRotationCheckStatus
padbyte $FF
pad AuraRotationCheckStatus

org $C12EA7
    ;; This code repurposes an unused NOP slide in the aura rotation code; see
    ;; dn_aura_cycling.asm.
SetUndeadEyeColor:
    ;; Set index 3 of the color palette to $0013. Since this is the only status
    ;; requiring an eye color change, we hard-code the values rather than using a
    ;; lookup table (as below).
    LDA #$13
    STA $7F86,Y
    TDC
    STA $7F87,Y
    ;; fall through

SetSkinColorBegin:
    ;; Due to space limitations, this routine is split in two parts; see below.

    ;; X is an index to a pair of LUTs (below). Each entry is two bytes, so we need to
    ;; double X.
    TXA                         ; a <- x
    ASL                         ; a <- a * 2
    TAX                         ; x <- a

    BRA SetSkinColorEnd         ; to be continued ...

warnpc $C12EB5
padbyte $FF
pad $C12EB5

org $C12F0D
SetSkinColorEnd:
    ;; Continued from SetSkinColorBegin above.

    REP #$20                    ; 16-bit a

    ;; Set color palette index 6
    LDA SkinColorStatusTable1,X
    STA $7F8C,Y

    ;; Set color palette index 7
    LDA SkinColorStatusTable2,X
    STA $7F8E,Y

    SEP #$20                    ; 8-bit a

    ;; This instruction is load-bearing. We need to clear the high byte of the
    ;; accumulator, or else it will corrupt the jump table index computed in the
    ;; subroutine at C1/5524 (something to do with the menu cursor) during NMI.
    TDC

    JMP AuraRotationCheckStatus ; jump back to the aura rotation code

warnpc $C12F24
padbyte $FF
pad $C12F24

org $C2E3AE
SkinColorStatusTable1:
    ;; Skin colors for palette index 6
    dw $013F                    ; berserk
    dw $3AF5                    ; zombie
    dw $7EDB                    ; poison
    dw $7779                    ; undead

SkinColorStatusTable2:
    ;; Skin colors for palette index 7
    dw $001F                    ; berserk
    dw $3210                    ; zombie
    dw $4DD3                    ; poison
    dw $624E                    ; undead

AuraColorStatusTable:
    ;; Since the above tables are larger than before, move this table and remove
    ;; unused entries.
    dw $6A60                    ; reflect
    dw $031F                    ; safe
    dw $0B64                    ; shell
    dw $7FFF                    ; vanish

warnpc $C2E3CA
padbyte $FF
pad $C2E3CA

;;; Fixes and adjustments

org $C12E02
    RTS                         ; replace a jump to $C12EB4 and return directly
    db $FF, $FF

org $C12E2A
    RTS                         ; replace a jump to $C12EB4 and return directly
    db $FF, $FF

org $C12DFD
    LDA #$03                    ; adjust index for vanish in the above table

org $C12EFF
    LDA AuraColorStatusTable,X  ; adjust address for table lookup
