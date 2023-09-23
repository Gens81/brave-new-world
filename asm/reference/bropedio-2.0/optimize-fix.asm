hirom
; header

; BNW - Optimize Fix
; Bropedio (May 10, 2019)
;
; This patch fixes a bug that occurs when character equipment
; is optimized. If no compatible items are found for an equipment
; slot, an item appears to be selected using leftover RAM
;
; The bug will not occur when equipping a two-handed weapon, because
; an empty list is properly handled in that case.
;
; I am unsure why the bug is manifesting in BNW specifically, since
; it appears to be present in vanilla's code

!freespace = $C39781 ; (uses 12 bytes)

; Redirect current "pick item" JMP to new prefix code.
; Would be more efficient to insert the CheckEmpty subroutine here,
; and avoid the extra JMP, but that would require many adjustments
; to branches/jumps above. Probably very doable within the current
; optimize patch asm (would save 3 bytes).
org $C3976D : JMP CheckEmpty

; Existing code used by 2-handed weapon picker
org $C39881
HandleEmpty:

; Current (broken) equipment selection from list
org $C39819
PickItem:

; Interrupt the current (broken) equipment selection routine
org !freespace
CheckEmpty:     LDA $7E9D89     ; A = list size
                BEQ .empty
                JMP PickItem
.empty          JMP HandleEmpty

