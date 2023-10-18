hirom

; frees up previous script location $CFAC22-$CFAD20 (255 bytes)

; uses the documented freespace $CFCF50-$CFD0CF (384 bytes)
!free = $CFCF50
!warn #= !free+384

; update pointer to AI script
org $CF8654 : dw Kefka-$CF8700

; updated AI script, changes are marked with [ADDED] or [UPDATED]
org !free
Kefka:
    db $FC,$0D,$24,$03          ; if variable $24 >= 3
    db $FC,$15,$00,$00          ; if ~(variable $00 & 0)
    db $F8,$00,$01              ; variable $00 = 1
    db $F3,$5F,$00              ; show caption: $5F
    db $FA,$0A,$01,$00          ; animation: $0A, $01, $00
    db $FE                      ; endif
    db $FC,$0D,$24,$03          ; if variable $24 >= 3
    db $FC,$0D,$03,$01          ; if variable $03 >= 1
    db $C0                      ; use attack: Fallen One
    db $EE                      ; use attack: Battle
    db $FD                      ; wait until next turn, then continue
    db $F0,$EC,$D2,$E0          ; random attack: Brown Note/Train/Purge
    db $EE                      ; use attack: Battle
    db $F8,$03,$00              ; variable $03 = 0
    db $FB,$04,$00              ; reset global battle timer
    db $FE                      ; endif
    db $FC,$0D,$03,$01          ; if variable $03 >= 1
    db $DE                      ; use attack: Goner
    db $F8,$03,$00              ; variable $03 = 0
    db $FB,$04,$00              ; reset global battle timer
    db $FE                      ; endif
    db $FC,$0D,$24,$01          ; if variable $24 >= 1
    db $FC,$15,$00,$00          ; if ~(variable $00 & 0)
    db $F8,$00,$01              ; variable $00 = 1
    db $FC,$0B,$0A,$00          ; [ADDED] if local battle timer > 10
    db $13                      ; use attack: Meteor
    db $FB,$00,$00              ; [ADDED] reset local battle timer
    db $FE                      ; endif
    db $FC,$15,$04,$00          ; [UPDATED] if ~(variable $04 & 0)
    db $F8,$04,$01              ; [UPDATED] variable $04 = 1
    db $F7,$20                  ; trigger event: $20
    db $FE                      ; endif
    db $FC,$0D,$24,$02          ; if variable $24 >= 2
    db $F0,$EF,$EC,$0B          ; random attack: Special/Brown Note/Bolt 3
    db $F0,$EE,$EE,$FE          ; random attack: Battle/Battle/None
    db $F8,$01,$81              ; variable $01 += 1
    db $FD                      ; wait until next turn, then continue
    db $F0,$EF,$D2,$0A          ; random attack: Special/Train/Ice 3
    db $F0,$EE,$EE,$FE          ; random attack: Battle/Battle/None
    db $F8,$01,$81              ; variable $01 += 1
    db $FD                      ; wait until next turn, then continue
    db $F0,$EF,$E0,$09          ; random attack: Special/Purge/Fire 3
    db $F0,$EE,$EE,$FE          ; random attack: Battle/Battle/None
    db $F8,$01,$81              ; variable $01 += 1
    db $FE                      ; endif
    db $F0,$EC,$09,$0B          ; random attack: Brown Note/Fire 3/Bolt 3
    db $F0,$EE,$FE,$FE          ; random attack: Battle/None/None
    db $F8,$02,$81              ; variable $02 += 1
    db $FD                      ; wait until next turn, then continue
    db $F0,$D2,$0B,$0A          ; random attack: Train/Bolt 3/Ice 3
    db $F0,$EE,$FE,$FE          ; random attack: Battle/None/None
    db $F8,$02,$81              ; variable $02 += 1
    db $FD                      ; wait until next turn, then continue
    db $F0,$E0,$0A,$09          ; random attack: Purge/Ice 3/Fire 3
    db $F0,$EE,$FE,$FE          ; random attack: Battle/None/None
    db $F8,$02,$81              ; variable $02 += 1
    db $FF                      ; end of script
    db $FC,$06,$36,$00          ; if Self's HP < 0
    db $F5,$00,$00,$01          ; unhide $01 w/ max HP using animation $00
    db $F8,$00,$00              ; variable $00 = 0
    db $F8,$24,$81              ; variable $24 += 1
    db $FC,$0D,$24,$03          ; if variable $24 >= 3
    db $F3,$60,$00              ; show caption: $60
    db $FA,$0D,$01,$00          ; animation: $0D, $01, $00
    db $F5,$11,$01,$FF          ; remove $FF (preserves HP) using animation $11
    db $FE                      ; endif
    db $FC,$16,$50,$00          ; if global battle timer > 80
    db $FC,$05,$00,$00          ; if hit at all
    db $F8,$03,$01              ; variable $03 = 1
    db $FE                      ; endif
    db $FC,$0D,$01,$03          ; if variable $01 >= 3
    db $FC,$05,$00,$01          ; if hit at all
    db $F8,$01,$00              ; variable $01 = 0
    db $EF                      ; use attack: Special
    db $EE                      ; use attack: Battle
    db $EE                      ; use attack: Battle
    db $FE                      ; endif
    db $FC,$05,$00,$01          ; if hit at all
    db $F0,$EF,$FE,$FE          ; random attack: Special/None/None
    db $F8,$01,$81              ; variable $01 += 1
    db $F8,$02,$00              ; variable $02 = 0
    db $FE                      ; endif
    db $FC,$0D,$02,$03          ; if variable $02 >= 3
    db $FC,$05,$00,$00          ; if hit at all
    db $F8,$02,$00              ; variable $02 = 0
    db $FC,$0B,$0A,$00          ; [ADDED] if local battle timer > 10
    db $F1,$47                  ; targeting: Use normal targeting
    db $13                      ; use attack: Meteor
    db $FB,$00,$00              ; [ADDED] reset local battle timer
    db $FE                      ; endif
    db $FC,$05,$00,$00          ; if hit at all
    db $F0,$D1,$FE,$FE          ; random attack: Hyperdrive/None/None
    db $F8,$02,$81              ; variable $02 += 1
    db $F8,$01,$00              ; variable $01 = 0
    db $FF                      ; end of script
warnpc !warn
