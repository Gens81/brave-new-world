
;##############################################################################
;                          FWF character identifiers
;##############################################################################


;==============================================================================
; Notes:
; • $00 is the string terminator.
; • $20-$52 are diacritic control codes (SFC remnant).
; • $51 and $52 are diacritics (SFC remnant).
; • $D8-$E7 are item icons; refer to C3/26F5.
; • Refer to C3/5C1C for blitz inputs.
; • $FF is a blank space.
;==============================================================================


; Palette squares from Config menu (BG1 only)
 !pal1 = $01      ; Color 1
 !pal2 = $02      ; Color 2
 !pal3 = $03      ; Color 3
 !pal4 = $04      ; Color 4
 !pal5 = $05      ; Color 5
 !pal6 = $06      ; Color 6
 !pal7 = $07      ; Color 7

; Numerical digits
 !num0 = $B4      ; 0
 !num1 = $B5      ; 1
 !num2 = $B6      ; 2
 !num3 = $B7      ; 3
 !num4 = $B8      ; 4
 !num5 = $B9      ; 5
 !num6 = $BA      ; 6
 !num7 = $BB      ; 7
 !num8 = $BC      ; 8
 !num9 = $BD      ; 9

; Signs
 !ques = $BF      ; Question mark
 !coln = $C1      ; Colon
 !3dot = $C7      ; Ellipsis
 !perc = $CD      ; Percent
 !unkn = $CF      ; Unknown (:|:)
 !2dot = $D3      ; Two-dot leader
 !up   = $D4      ; Upward arrow
 !mult = $D7      ; Multiplication

; Base item icon
 !icon = $D8      ; Dirk

; Magic icons
 !whit = $E8      ; White
 !blck = $E9      ; Black
 !gray = $EA      ; Gray

; Gauge segments (RGB, ATB)
 !bar0 = $F0      ; 0/8 full
 !bar1 = $F1      ; 1/8 full (ATB only)
 !bar2 = $F2      ; 2/8 full
 !bar3 = $F3      ; 3/8 full (ATB only)
 !bar4 = $F4      ; 4/8 full
 !bar5 = $F5      ; 5/8 full (ATB only)
 !bar6 = $F6      ; 6/8 full
 !bar7 = $F7      ; 7/8 full (ATB only)
 !bar8 = $F8      ; 8/8 full
 !barl = $F9      ; Left side
 !barr = $FA      ; Right side


;##############################################################################
;                       FWF string pointers and lengths
;##############################################################################

; Tag for isolating bank byte
 !h = >>16

; Actor naming menu options
 !anm_ct  = $D8E8C8

; Battle commands
 !cmd_ns  = $0007   ; Text length
 !cmd_np  = $D8CEA0 ; Text address

; Dance names
 !dnc_ns  = $000C   ; Text length
 !dnc_np  = $E6FF9D ; Text address

; Enemy names
 !nme_ns  = $000A   ; Text length
 !nme_np  = $CFC050 ; Text address

; Esper names
 !esp_ns  = $0008   ; Text length
 !esp_np  = $E6F6E1 ; Text address

; Esper bonuses
 !esb_ns  = $0009   ; Text length
 !esb_np  = $CFFEAE ; Text address

; Item classes
 !itm_cs  = $0007   ; Text length
 !itm_cp  = $D26F00 ; Text address

; Item names
 !itm_ns  = $000D   ; Text length
 !itm_np  = $D2B300 ; Text address

; Lore names
 !lor_ns  = $000A   ; Text length
 !lor_np  = $E6F9FD ; Text address

; Magic names
 !mag_ns  = $0007   ; Text length
 !mag_np  = $E6F567 ; Text address

; Rare item names
 !rar_ns  = $000D   ; Text length
 !rar_np  = $CEFBA0 ; Text address

; SwdTech names
 !swt_ns  = $000C   ; Text length
 !swt_np  = $CF3C40 ; Text address


;##############################################################################
;                          VWF description pointers
;##############################################################################

; Blitz descriptions
 !btz_d_h = $CF     ; Data bank
 !btz_d_p = $FF9E   ; Text pointers
 !btz_d_l = $FC00   ; Text address

; Esper bonus descriptions
 !esb_d_h = $ED     ; Data bank
 !esb_d_p = $FFD0   ; Text pointers
 !esb_d_l = $FE00   ; Text address

; Esper effect descriptions
 !esp_d_h = $CF     ; Data bank
 !esp_d_p = $FE40   ; Text pointers
 !esp_d_l = $3940   ; Text address

; Item descriptions
 !itm_d_h = $ED     ; Data bank
 !itm_d_p = $7AA0   ; Text pointers
 !itm_d_l = $6400   ; Text address

; Lore descriptions
 !lor_d_h = $ED     ; Data bank
 !lor_d_p = $7A70   ; Text pointers
 !lor_d_l = $77A0   ; Text address

; Magic descriptions
 !mag_d_h = $D8     ; Data bank
 !mag_d_p = $CF80   ; Text pointers
 !mag_d_l = $C9A0   ; Text address

; Rare item descriptions
 !rar_d_h = $CE     ; Data bank
 !rar_d_p = $FB60   ; Text pointers
 !rar_d_l = $FCB0   ; Text address

; SwdTech descriptions
 !swt_d_h = $CF     ; Data bank
 !swt_d_p = $FFAE   ; Text pointers
 !swt_d_l = $FD00   ; Text address
