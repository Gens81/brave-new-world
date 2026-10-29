hirom
;header

;; Turn the Stereo/Mono switch into a Text: Enabled/Off switch
;;incsrc "repurpose_sound_switch.asm"

; Recycle the largely redundant 4B handler to make some nearby space
incsrc "optimize_dialog.asm"

; Existing free space in C0 for new logic.
; This location is set for BNW, but can be as early as $C0D613 for vanilla

!freespace = $C0DB30
; !freespace = $C0D613

; Define logic for determining if dialogue should be skipped or displayed
incsrc "field_dialogue_handlers.asm"

; Relocate code from Battle Event handler 01 (display dialogue at bottom of screen)
incsrc "battle_dialogue_handlers.asm"
