arch 65816
hirom
  
; Moving Mog tutorial from South Figaro (relics) to Gogo's room (commands customization)

org $CA790E
  db $FD,$FD,$FD,$FD                        ; Deactivate the cutscene 

org $CB52F3
  db $B2,$C1,$C5,$00,$B2,$F6,$D2,$02,$FE	; New subroutine
  
org $CB823F 
  db $B2,$F3,$52,$01            			; Call new subroutine

org $CCD31D
  db $4B,$40,$0A                			; Display [caption #2623]:
                                            ; <A12> can do much more than just [Mimic].<D>
                                            ; Customize their command list on the status page.
org $CCD321
  db $6A,$16,$21,$08,$06                    ; Change Map: Gogo's room at (8,6);
  
; clears invisible Red-D
; Note: This works only for Red-D because there's a second event bit $0E3
; that's used for tracking its statue state

org $CC204B
    db $DD,$9C                  ; clear event bit $69C
    db $B2,$25,$51,$01          ; call subroutine $CB5125
    db $FD,$FD                  ; clear redundant hide command
warnpc $CC2053


;;; Sealed by... song data (overwritten song ends at $C98D84, added twelve 00 bytes)	
;;org $C98CE8
;;incbin sealed_song.bin
;;
;;; Sealed by... instruments data ($C54695 is the offset for a perfect replica of the same instruments)
;;org $C548B5
;;incbin sealed_inst.bin
;;
;;; replace "machine running" with "wind" song during cranes event
;;org $CC82C9
;;  db $39
;
;; Change the event tile at the exit to Atma's room
;
;org $C414E2
;  db $FA
;
;; Blocks an exit so Atma is a required boss
;; Atma sequence starts at $CC18B4
;
;org $CC18BE : db $B2,$FD,$52,$01   ; JSR $CB52FD
;
;; Helper for making Atma required boss in KT
;
;org $CB52FD
;  db $42,$10,$DD,$BD         ; Displaced code from originating location
;  db $D0,$E1                 ; Set event bit $1E80($0E1) [1E9C, bit 1]
;  db $FE                     ; RTS
;; $CB5304
;  db $C0,$E1,$80,$5C,$13,$02 ; If ($1E80($0E1) [$1E9C, bit 1] is set), branch to $CC135C
;  db $31,$82                 ; Open action queue for on-screen character
;  db $80,$FF                 ; Move character up 1 tile, end queue
;  db $F0,$38                 ; Play "Nighty Night"
;  db $4B,$FB,$00             ; Caption 250
;  db $F3,$10                 ; Fade in previously faded out song with trans. time 16
;  db $FE                     ; RTS

;;Mute magitek sound in Cyan's dream
;org $CB93EF
;	db $FD,$FD
;org $CB93F8
;	db $FD,$FD
;org $CB9400
;	db $FD,$FD
;org $CB9408
;	db $FD,$FD
;org $CB9410
;	db $FD,$FD
