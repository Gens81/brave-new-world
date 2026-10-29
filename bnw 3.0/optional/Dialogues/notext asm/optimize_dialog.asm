hirom
; header

; First, turn the majority of the "display dialogue" action 48 handler
;   into a subroutine, since its implementation is duplicated in action 4B

org $C0A49F
  rts                   ; Return instead of the load and jump
  padbyte $FF           ; Erase the rest of this routine
  pad $C0A4A6           ; 6B free space... hooray?

!loadtext = $A475       ; The start of the old 48 handler, now a
                        ;   subroutine for loading text without
                        ;   displaying the dialogue window

; Next, rip the old 4B handler apart, turning it into two routines:
;   one, a handler for action 48, the other a handler for action 4B
;   (AND free up 31B to boot)

org $C0A4BC

Handler48:
  jsr !loadtext         ; Call the subroutine above
  sta $BA               ; Dialogue box open = true
AdvanceQueue:
  lda #$03              ; Number of bytes to advance event queue
  jmp $9B5C             ; Continue

Handler4B:
  jsr !loadtext         ; See above
  sta $BA               ; Dialogue box open = true
  lda #$01              ;
  sta $EB               ;
  lda #$00              ; The rest of this is for inserting a subroutine
  sta $EC               ;   call ("Wait for dialogue" @ $CA/0001) onto
  sta $ED               ;   the event stack before continuing to the next
  lda #$03              ;   item in the event queue.
  jmp $B1A3             ;   Preserved from original implmentation.

RecycledSpace:
  padbyte $FF           ; Erase the rest of this routine
  pad $C0A4F9           ; 31B free space


; Finally, slice into the event handler jump table

org $C098EA             ; action 48
  dw Handler48

org $C098F0             ; action 4B
  dw Handler4B
