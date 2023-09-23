hirom
; header

; Name: Mug Worser
; Author: Bropedio
; Date: July 20, 2020

; #####################################
; Description
;
; Modifies "Steal" command to be affected by
; the Blind status.

; #####################################
; Code

org $C21592
  JSR $3C3D   ; Redirect Steal to helper used by GP Rain

; #####################################
; EOF
