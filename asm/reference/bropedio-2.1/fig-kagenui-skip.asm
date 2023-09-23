hirom

!free = $CB52DB
!postIntangir = $CB7A7C

org !postIntangir
  CB7A7C: db $B2,$DB,$52,$01         ; jump to subroutine: $CB51A5
                             
org !free
  ; displaced from above
  CB51A5: db $42,$14                 ; hide NPC $14 (Intangir)
  CB51A7: db $3E,$14                 ; delete NPC $14 (Intangir)

  ; new event code
  CB51A9: db $C0,$A3,$00,$E9,$52,$01 ; skip if Shadow alive
  CB51AF: db $81,$29                 ; remove item: Kagenui1
  CB51B1: db $80,$02                 ; give item: Kagenui2
  CB51B3: db $FE                     ; return from subroutine
