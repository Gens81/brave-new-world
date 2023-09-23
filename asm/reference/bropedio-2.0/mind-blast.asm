hirom
; header

; BNW - Mind Blast Expansion
; Bropedio, April 23, 2019
; 
; Increases Mind Blast hits to 5.
; This change utilizes (supposedly) empty battle RAM at 7E/3F54 - 7E/3F5D.
; Please double check that these bytes have not already been spoken for by
; other patches in BNW. According to FF6Hacking, they are unused in vanilla.
;
; Battle RAM used:  7E/3F54 - 7E/3F5D
; Battle RAM freed: 7E/3A5C - 7E/3A63

org $C2413E
MoarBlast:
  LDY #$08            ; add 1 more pair of targeting bytes

org $C24145
  STA $3F54,Y         ; store Mind Blast targets in new RAM location

org $C23BB8
  LDX #$08            ; loop through all 5 targets
  BIT $3F54,X         ; check against targeting at new RAM location

; Alternate Approach: Another approach is possible, but would require more
; significant code changes, and would limit Mind Blast to targeting characters
; only. This approach would have supported up to 8 hits. It would involve
; processing and storing only the character targets ($A4) in single bytes, in
; the existing 8 bytes of Mind Blast RAM.
