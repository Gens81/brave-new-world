hirom

; BNW - Petrify/Morph Status Immunities
; Bropedio (December 11, 2019)
;
; Remove hacky vanilla code that enforces special
; status immunities for petrified characters by
; resetting "Petrify" status every turn. Instead,
; add more intelligent "immunity" byte routines.
; These routines now enforce Petrify immunities that
; include "Imp", "Death", Zombie". The same routines
; are also used to enforce "Imp" immunity for Morphed
; characters.

!free1 = $C2FBA0
!warn1 = !free1+24
!free2 = $C261C0
!warn2 = !free2+22
!free3 = $C26590
!warn3 = !free3+9

; #####################################
; Clear Imp when Morph status gained

org $C246E6 : dw ClearImp

org !free3
ClearImp:
  LDA #$0020      ; Imp
  JSR $4598       ; mark to be cleared
  JMP $4678       ; continue with normal morph handling
warnpc !warn3+1

; #####################################
; Skip Petrify force-set (BNW location)
org $C2453E : BRA $03 : NOP #3

; #####################################
; Disable Morph command when Imped

org $C252D3 : MenuDis:
org $C252B0
ImpMorphMenu:
  BEQ .skip
  CPX #$0006
  BEQ MenuDis
  BRA .skip
org $C252BA
.skip

; #####################################
; Consider Petrify/Morph immunities

org $C2451C : JSR Vulnerables1 ; BNW location (set block)
org $C24564 : JSR Vulnerables2 ; BNW location (set block)
org $C243E0 : JSR Vulnerables2 ; clear block
org $C243C6
  JSR Vulnerables1 ; clear block
  AND $F4

org !free1
Vulnerables1:
  LDA $331C,Y     ; fixed status vulnerables (1-2)
  STA $E8         ; store them
  LDA $3EF8,Y     ; status bytes 3-4
  BIT #$0800      ; "Morph"
  BEQ .check_pet  ; branch if no ^
  LDA #$0020      ; "Imp"
  TRB $E8         ; remove vulnerable ^
.check_pet
  LDA #$FEB7      ; Dark,Poison,Clear,Wounded,Image,Mute
  JMP FinishPet   ; Berserk,Muddle,Sap,Sleep,Imp,Death,Zombie
warnpc !warn1+1

org !free2
Vulnerables2:
  AND $3330,Y     ; mask fixed status vulnerables (3-4)
  STA $E8         ; store vulnerable status-to-set
  LDA #$9BFF      ; Dance,Regen,Slow,Haste,Stop,Shell,Safe,Reflect
                  ; Rage,Frozen,Morph,Spell,Float
FinishPet:
  PHA             ; store petrify immunities
  LDA $3EE3,Y     ; status bytes 1-2
  ASL #2          ; Carry: "Petrify"
  PLA             ; restore petrify immunities
  BCC .done       ; branch if no "Petrify"
  TRB $E8         ; remove vulnerables
.done
  LDA $E8         ; real vulnerables
  RTS
warnpc !warn2+1

