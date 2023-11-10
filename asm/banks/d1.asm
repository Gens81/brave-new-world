hirom
incsrc vwf.tbl

; D1 Bank (data)

; #########################################################################
; Battle Animation Frame Data

org $D1C649 : db $35,$07 ; Fixes Tritoch animation

; #########################################################################
; Misc. Animation Script Data

; -------------------------------------------------------------------------
; Update Sr. Behemoth entry script to change battle music

org $D1EF90 : dw anim_script_025c

; #########################################################################
; Battle Messages
;
; A large portion of the battle messages data was included in [dn]s
; status messages .ips. We've now included the entire struct here.

!press_a = $07
!var1 = $10
!var2 = $11
!char_name = $12,$00
!item_name = $12,$01
!attk_name = $12,$02
!multi = $D7
!ellip = $C7

org $D1F000
BattleMsg:
.00 db "Failed! ",$00
.01 db "Doesn't have anything!",$00
.02 db "Couldn't steal! ",$00
.03 db "Stole ",!item_name," ",!multi," 1 !",$00
.04 db "Can't control! ",$00
.05 db "Can't dive! ",$00
.06 db "Stumbled! ",$00
.07 db "Mugu mugu?",$00
.08 db "No money! ",$00
.09 db "Can't run away! ",$00
.0A db "Can't escape! ",$00
.0B db $00
.0C db $00
.0D db $00
.0E db $00
.0F db $00
.10 db $00
.11 db $00
.12 db $00
.13 db "Move, and you're dust!",$00
.14 db "Can't possess! ",$00
.15 db "Weak against fire",$00
.16 db "Weak against ice",$00
.17 db "Weak against lightning",$00
.18 db "Weak against dark  ",$00
.19 db "Weak against wind",$00
.1A db "Weak against holy ",$00
.1B db "Weak against earth",$00
.1C db "Weak against water",$00
.1D db "Better off ",!item_name,"!",$00
.1E db !item_name," was crushed!",$00
.1F db "Can't sketch! ",$00
.20 db "Got ",!item_name," ",!multi," 1",!press_a,$00
.21 db "Got ",!item_name," ",!multi," ",!var2,!press_a,$00
.22 db "Preemptive attack",$00
.23 db "Back attack",$00
.24 db "Side attack",$00
.25 db "Pincer attack",$00
.26 db "Got ",!var2," GP",$00
.27 db "Got ",!var1," Exp. point(s)",!press_a,$00
.28 db "Need MP",$00
.29 db "Annihilated",!press_a,$00
.2A db "Dispelled curse on shield",!press_a,$00
.2B db "Level was halved! ",$00
.2C db "No weaknesses!     ",$00
.2D db "Learned ",!attk_name,!press_a,$00
.2E db !char_name," gained a level",!press_a,$00
.2F db "No weakness",$00
.30 db "HP ",!var1,"/",!var2,$00
.31 db "MP ",!var1,"/",!var2,$00
.32 db !char_name," learned ",!attk_name,!press_a,$00
.33 db "Devised a new Blitz!",!press_a,$00
.34 db "Level ",!var1,$00
.35 db "Got ",!var1," Spell Point(s)",!press_a,$00
.36 db "Banon fell",!ellip,$00
.37 db $00
.38 db $00
.39 db $00
.3A db $00
.3B db $00
.3C db $00
.3D db $00
.3E db $00
.3F db !var2," GP was stolen! ",$00
.40 db "Mastered a new dance!",!press_a,$00
.41 db "Can't throw! ",$00
.42 db "Mastered a new technique!",!press_a,$00
.43 db "Incorrect Blitz input!",$00
.44 db "Ogre Nix was broken!",$00
.45 db "Got ",!var1," EP",!press_a,$00
.46 db !char_name," gained an EL",!press_a,$00
.47 db "Status: Blind",$00
.48 db "Status: Poison",$00
.49 db "Status: Imp",$00
.4A db "Status: Mute",$00
.4B db "Status: Bserk",$00
.4C db "Status: Muddle",$00
.4D db "Status: Sap",$00
.4E db "Status: Sleep",$00
.4F db "Status: Regen",$00
.50 db "Status: Slow",$00
.51 db "Status: Haste",$00
.52 db "Status: Stop",$00
.53 db "Status: Shell",$00
.54 db "Status: Safe",$00
.55 db "Status: Rflect",$00
.56 db "Status: Rerise",$00
.57 db "Status: Float",$00
.58 db "Status: None",$00
.59 db $00
.5A db $00
.5B db $00
.5C db $00
.5D db $00
.5E db $00
.5F db $00
.60 db $00
.61 db $00
.62 db $00
.63 db $00
.64 db $00
.65 db $00
.66 db $00
.67 db $00
.68 db $00
.69 db $00
.6A db $00
.6B db $00
.6C db $00
.6D db $00
.6E db $00
.6F db $00
.70 db $00
.71 db $00
.72 db $00
.73 db $00
.74 db $00
.75 db $00
.76 db $00
.77 db $00
.78 db $00
.79 db $00
.7A db $00
.7B db $00
.7C db $00
.7D db $00
.7E db $00
.7F db $00
.80 db $00
.81 db $00
.82 db $00
.83 db $00
.84 db $00
.85 db $00
.86 db $00
.87 db $00
.88 db $00
.89 db $00
.8A db $00
.8B db $00
.8C db $00
.8D db $00
.8E db $00
.8F db $00
.90 db $00
.91 db $00
.92 db $00
.93 db $00
.94 db $00
.95 db $00
.96 db $00
.97 db $00
.98 db $00
.99 db $00
.9A db $00
.9B db $00
.9C db $00
.9D db $00
.9E db $00
.9F db $00
.A0 db $00
.A1 db $00
.A2 db $00
.A3 db $00
.A4 db $00
.A5 db $00
.A6 db $00
.A7 db $00
.A8 db $00
.A9 db $00
.AA db $00
.AB db $00
.AC db $00
.AD db $00
.AE db $00
.AF db $00
.B0 db $00
.B1 db $00
.B2 db $00
.B3 db $00
.B4 db $00
.B5 db $00
.B6 db $00
.B7 db $00
.B8 db $00
.B9 db $00
.BA db $00
.BB db $00
.BC db $00
.BD db $00
.BE db $00
.BF db $00
.C0 db $00
.C1 db $00
.C2 db $00
.C3 db $00
.C4 db $00
.C5 db $00
.C6 db $00
.C7 db $00
.C8 db $00
.C9 db $00
.CA db $00
.CB db $00
.CC db $00
.CD db $00
.CE db $00
.CF db $00
.D0 db $00
.D1 db $00
.D2 db $00
.D3 db $00
.D4 db $00
.D5 db " `Mmmm",!ellip,"munch, munch!^",$00
.D6 db $00
.D7 db $00
.D8 db $00
.D9 db $00
.DA db " Wrexsoul: ",!ellip,"your soul is MINE!",$00
.DB db $00
.DC db $00
.DD db $00
.DE db $00
.DF db $00
.E0 db $00
.E1 db $00
.E2 db $00
.E3 db $00
.E4 db $00
.E5 db $00
.E6 db $00
.E7 db $00
.E8 db $00
.E9 db $00
.EA db $00
.EB db $00
.EC db $00
.ED db $00
.EE db $00
.EF db $00
.F0 db $00
.F1 db $00
.F2 db $00
.F3 db $00
.F4 db $00
.F5 db $00
.F6 db $00
.F7 db $00
.F8 db $00
.F9 db $00
.FA db $00
.FB db $00
.FC db $00
.FD db $00
.FE db $00
.FF db $00

%free($D1F7A0)

BattleMsgPointers:
  dw BattleMsg_00
  dw BattleMsg_01
  dw BattleMsg_02
  dw BattleMsg_03
  dw BattleMsg_04
  dw BattleMsg_05
  dw BattleMsg_06
  dw BattleMsg_07
  dw BattleMsg_08
  dw BattleMsg_09
  dw BattleMsg_0A
  dw BattleMsg_0B
  dw BattleMsg_0C
  dw BattleMsg_0D
  dw BattleMsg_0E
  dw BattleMsg_0F
  dw BattleMsg_10
  dw BattleMsg_11
  dw BattleMsg_12
  dw BattleMsg_13
  dw BattleMsg_14
  dw BattleMsg_15
  dw BattleMsg_16
  dw BattleMsg_17
  dw BattleMsg_18
  dw BattleMsg_19
  dw BattleMsg_1A
  dw BattleMsg_1B
  dw BattleMsg_1C
  dw BattleMsg_1D
  dw BattleMsg_1E
  dw BattleMsg_1F
  dw BattleMsg_20
  dw BattleMsg_21
  dw BattleMsg_22
  dw BattleMsg_23
  dw BattleMsg_24
  dw BattleMsg_25
  dw BattleMsg_26
  dw BattleMsg_27
  dw BattleMsg_28
  dw BattleMsg_29
  dw BattleMsg_2A
  dw BattleMsg_2B
  dw BattleMsg_2C
  dw BattleMsg_2D
  dw BattleMsg_2E
  dw BattleMsg_2F
  dw BattleMsg_30
  dw BattleMsg_31
  dw BattleMsg_32
  dw BattleMsg_33
  dw BattleMsg_34
  dw BattleMsg_35
  dw BattleMsg_36
  dw BattleMsg_37
  dw BattleMsg_38
  dw BattleMsg_39
  dw BattleMsg_3A
  dw BattleMsg_3B
  dw BattleMsg_3C
  dw BattleMsg_3D
  dw BattleMsg_3E
  dw BattleMsg_3F
  dw BattleMsg_40
  dw BattleMsg_41
  dw BattleMsg_42
  dw BattleMsg_43
  dw BattleMsg_44
  dw BattleMsg_45
  dw BattleMsg_46
  dw BattleMsg_47
  dw BattleMsg_48
  dw BattleMsg_49
  dw BattleMsg_4A
  dw BattleMsg_4B
  dw BattleMsg_4C
  dw BattleMsg_4D
  dw BattleMsg_4E
  dw BattleMsg_4F
  dw BattleMsg_50
  dw BattleMsg_51
  dw BattleMsg_52
  dw BattleMsg_53
  dw BattleMsg_54
  dw BattleMsg_55
  dw BattleMsg_56
  dw BattleMsg_57
  dw BattleMsg_58
  dw BattleMsg_59
  dw BattleMsg_5A
  dw BattleMsg_5B
  dw BattleMsg_5C
  dw BattleMsg_5D
  dw BattleMsg_5E
  dw BattleMsg_5F
  dw BattleMsg_60
  dw BattleMsg_61
  dw BattleMsg_62
  dw BattleMsg_63
  dw BattleMsg_64
  dw BattleMsg_65
  dw BattleMsg_66
  dw BattleMsg_67
  dw BattleMsg_68
  dw BattleMsg_69
  dw BattleMsg_6A
  dw BattleMsg_6B
  dw BattleMsg_6C
  dw BattleMsg_6D
  dw BattleMsg_6E
  dw BattleMsg_6F
  dw BattleMsg_70
  dw BattleMsg_71
  dw BattleMsg_72
  dw BattleMsg_73
  dw BattleMsg_74
  dw BattleMsg_75
  dw BattleMsg_76
  dw BattleMsg_77
  dw BattleMsg_78
  dw BattleMsg_79
  dw BattleMsg_7A
  dw BattleMsg_7B
  dw BattleMsg_7C
  dw BattleMsg_7D
  dw BattleMsg_7E
  dw BattleMsg_7F
  dw BattleMsg_80
  dw BattleMsg_81
  dw BattleMsg_82
  dw BattleMsg_83
  dw BattleMsg_84
  dw BattleMsg_85
  dw BattleMsg_86
  dw BattleMsg_87
  dw BattleMsg_88
  dw BattleMsg_89
  dw BattleMsg_8A
  dw BattleMsg_8B
  dw BattleMsg_8C
  dw BattleMsg_8D
  dw BattleMsg_8E
  dw BattleMsg_8F
  dw BattleMsg_90
  dw BattleMsg_91
  dw BattleMsg_92
  dw BattleMsg_93
  dw BattleMsg_94
  dw BattleMsg_95
  dw BattleMsg_96
  dw BattleMsg_97
  dw BattleMsg_98
  dw BattleMsg_99
  dw BattleMsg_9A
  dw BattleMsg_9B
  dw BattleMsg_9C
  dw BattleMsg_9D
  dw BattleMsg_9E
  dw BattleMsg_9F
  dw BattleMsg_A0
  dw BattleMsg_A1
  dw BattleMsg_A2
  dw BattleMsg_A3
  dw BattleMsg_A4
  dw BattleMsg_A5
  dw BattleMsg_A6
  dw BattleMsg_A7
  dw BattleMsg_A8
  dw BattleMsg_A9
  dw BattleMsg_AA
  dw BattleMsg_AB
  dw BattleMsg_AC
  dw BattleMsg_AD
  dw BattleMsg_AE
  dw BattleMsg_AF
  dw BattleMsg_B0
  dw BattleMsg_B1
  dw BattleMsg_B2
  dw BattleMsg_B3
  dw BattleMsg_B4
  dw BattleMsg_B5
  dw BattleMsg_B6
  dw BattleMsg_B7
  dw BattleMsg_B8
  dw BattleMsg_B9
  dw BattleMsg_BA
  dw BattleMsg_BB
  dw BattleMsg_BC
  dw BattleMsg_BD
  dw BattleMsg_BE
  dw BattleMsg_BF
  dw BattleMsg_C0
  dw BattleMsg_C1
  dw BattleMsg_C2
  dw BattleMsg_C3
  dw BattleMsg_C4
  dw BattleMsg_C5
  dw BattleMsg_C6
  dw BattleMsg_C7
  dw BattleMsg_C8
  dw BattleMsg_C9
  dw BattleMsg_CA
  dw BattleMsg_CB
  dw BattleMsg_CC
  dw BattleMsg_CD
  dw BattleMsg_CE
  dw BattleMsg_CF
  dw BattleMsg_D0
  dw BattleMsg_D1
  dw BattleMsg_D2
  dw BattleMsg_D3
  dw BattleMsg_D4
  dw BattleMsg_D5
  dw BattleMsg_D6
  dw BattleMsg_D7
  dw BattleMsg_D8
  dw BattleMsg_D9
  dw BattleMsg_DA
  dw BattleMsg_DB
  dw BattleMsg_DC
  dw BattleMsg_DD
  dw BattleMsg_DE
  dw BattleMsg_DF
  dw BattleMsg_E0
  dw BattleMsg_E1
  dw BattleMsg_E2
  dw BattleMsg_E3
  dw BattleMsg_E4
  dw BattleMsg_E5
  dw BattleMsg_E6
  dw BattleMsg_E7
  dw BattleMsg_E8
  dw BattleMsg_E9
  dw BattleMsg_EA
  dw BattleMsg_EB
  dw BattleMsg_EC
  dw BattleMsg_ED
  dw BattleMsg_EE
  dw BattleMsg_EF
  dw BattleMsg_F0
  dw BattleMsg_F1
  dw BattleMsg_F2
  dw BattleMsg_F3
  dw BattleMsg_F4
  dw BattleMsg_F5
  dw BattleMsg_F6
  dw BattleMsg_F7
  dw BattleMsg_F8
  dw BattleMsg_F9
  dw BattleMsg_FA
  dw BattleMsg_FB
  dw BattleMsg_FC
  dw BattleMsg_FD
  dw BattleMsg_FE
  dw BattleMsg_FF

; -------------------------------------------------------------------------
; Leftover Wrexsoul dialogue and pointer. TODO: Remove ASAP

org $D1F553
%safepad($D1F5E2,$00)

org $D1F584
  db " `Mmmm",!ellip,"munch, munch!^",$00
  db $00
  db $00
  db $00
  db $00
  db " Wrexsoul: ",!ellip,"your soul is MINE!",$00
  db $00

org $D1F99E : dw $F5E1

