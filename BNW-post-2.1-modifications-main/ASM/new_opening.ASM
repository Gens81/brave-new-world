
norom
table "intro.tbl", ltr

org $000cfb
	dw #concept+$5000  : db $01 : dw #name_1+$5000    : db $80 : dw #xx5dc4+$5000 : db $01
	dw #hacking+$5000  : db $01 : dw #name_2+$5000    : db $80 : dw #xx5dc4+$5000 : db $01
	dw #hacking+$5000  : db $01 : dw #name_3+$5000    : db $80 : dw #xx5dc4+$5000 : db $01
	dw #hacking+$5000  : db $01 : dw #name_4+$5000    : db $80 : dw #xx5dc4+$5000 : db $01
	dw #hacking+$5000  : db $01 : dw #name_5+$5000    : db $80 : dw #xx5dc4+$5000 : db $01
	dw #design+$5000   : db $01 : dw #name_6+$5000    : db $80 : dw #xx5dc4+$5000 : db $01
	dw #design+$5000   : db $01 : dw #name_7+$5000    : db $80 : dw #xx5dc4+$5000 : db $01
	dw #design+$5000   : db $01 : dw #name_8+$5000    : db $80 : dw #xx5dc4+$5000 : db $01
	dw #design+$5000   : db $01 : dw #name_9+$5000    : db $80 : dw #xx5dc4+$5000 : db $01
	dw #design+$5000   : db $01 : dw #name_10+$5000   : db $80 : dw #xx5dc4+$5000 : db $01
	dw #design+$5000   : db $01 : dw #name_11+$5000   : db $80 : dw #xx5dc4+$5000 : db $01
	dw #music+$5000	   : db $01 : dw #name_22+$5000   : db $80 : dw #xx5dc4+$5000 : db $01
	dw #graphic+$5000  : db $01 : dw #name_12+$5000   : db $80 : dw #xx5dc4+$5000 : db $01
	dw #mterial+$5000  : db $01 : dw #name_13+$5000   : db $80 : dw #xx5dc4+$5000 : db $01
	dw #script+$5000   : db $01 : dw #name_14+$5000   : db $80 : dw #xx5dc4+$5000 : db $01
	dw #translat+$5000 : db $01 : dw #name_15+$5000   : db $80 : dw #xx5dc4+$5000 : db $01
	dw #or_hack+$5000  : db $01 : dw #name_16+$5000   : db $80 : dw #xx5dc4+$5000 : db $01
	dw #or_hack+$5000  : db $01 : dw #name_17+$5000   : db $80 : dw #xx5dc4+$5000 : db $01
	dw #or_hack+$5000  : db $01 : dw #name_18+$5000   : db $80 : dw #xx5dc4+$5000 : db $01
	dw #or_hack+$5000  : db $01 : dw #name_19+$5000   : db $80 : dw #xx5dc4+$5000 : db $01
	dw #tools+$5000    : db $01 : dw #name_20+$5000   : db $80 : dw #xx5dc4+$5000 : db $01
	dw #thanks+$5000   : db $01 : dw #name_21+$5000   : db $80 : dw #xx5dc4+$5000 : db $01
	dw #xx5dc4+$5000   : db $fe                                          
warnpc $000dc4                                                          


ORG $001543
;00,00,00,00
;00,00,04,00
;04,00,00,00
;00,04,00,00
;00,04,04,00
;04,04,00,00
;04,00,04,00
;00,04,00,04

intro_text:	;  VRAM, X, PAL
concept:	dw $4450,$0024	:	db "original concept",$00
name_1:		dw $44D8,$0120	:	db "   BTB",$FE
								db "SYNCHYSI",$00
hacking:	dw $4454,$0024	:	db " hacking",$00
name_2:		dw $44D4,$0320	:	db "SYNCHYSI",$FE
								db " BROPEDIO",$FE
								db "  QLIPHOTH",$00
name_3:		dw $44D4,$0320	:	db "FIG",$fe
								db " FEANOR",$FE
								db "  SEIBABY",$00
name_4:		dw $44D4,$0120	:	db "RYO_HAZUKI",$FE
								db "THINK0028",$FE
								db " GRAYSHADOWS",$00
name_5:		dw $44D4,$0420	:	db "MADSIUR",$FE
								db " GI NATTAK",$00
design:		dw $4458,$0624	:	db "design",$00
name_6:		dw $44D6,$0020	:	db " MISHRAK",$FE
								db "  NOWEA",$FE
								db "   GENS",$00
name_7:		dw $44D4,$0020	:	db "THZFZNNYMZN",$FE
								db " CECIL188",$FE
								db "  CAINEN",$00
name_8:		dw $44D4,$0120	:	db "DANDACHEERMAN",$FE
								db " DESCHAIN",$FE
								db "  HERO",$00								
name_9:		dw $44D8,$0320	:	db "LETHA",$FE
								db " LOCKIRBY",$00
name_10:	dw $44d6,$0020	:	db "KAIN STRYDER",$FE
								db " THRAXIS",$00
name_11:	dw $44d0,$0020	:	db "AND THE FF6HACKING",$FE
								db "   COMMUNITY",$00
music:		dw $445a,$0224	:	db "music",$00
name_22:	dw $44D8,$0220	:	db "JACKIMUS",$00							
graphic:	dw $4458,$0024	:	db "graphics",$00
name_12:	dw $44d2,$0020	:	db "AUTUMN SHINESPARK",$FE
								db "   BAUGLIR",$00
mterial:	dw $444a,$0224	:	db " promotional material",$00
name_13:	dw $44d8,$0120	:	db "A DUMMY",$00

script:		dw $444E,$0224	:	db " script editing",$00
name_14:	dw $44d0,$0020	:	db "DESCHAIN $ BEAR",$FE
								db " BISHOP",$FE
								db "  FIELD",$00
								
translat:	dw $4454,$0124	:	db "translations",$00
name_15:	dw $44d8,$0120	:	db "GENS",$FE
								db " UMARO",$00	
								
or_hack:	dw $4452,$0024	:	db " original hacks",$00
name_16:	dw $44D6,$0420	:	db "ASSASSIN17",$fe
								db " ARMORVIL",$FE
								db "  BYDOLESS",$00
name_17:	dw $44D4,$0120	:	db "LEET SKETCHER",$FE
								db " IMZOGELMO",$FE
								db "   HATZEN",$00
name_18:	dw $44d4,$0720	:	db "NOVALIA SPIRIT",$FE
								db " MASTER ZED",$FE								
								db "  SERITY",$00
name_19:	dw $44d4,$0120	:	db "SILENTENIGMA",$FE
								db " TERII SENSHI",$FE
								db "   ZEEMIS",$00
tools:		dw $4458,$0024	:	db " tools",$00	
name_20:	dw $44d4,$0120	:	db "FF3USME",$FE
								db " ZONE DOCTOR",$FE
								db "   FF6TOOLS",$00
thanks:		dw $444c,$0024	:	db "special thanks to the",$00								
name_21:	dw $44C8,$0120	:	db "NGPLUS DISCORD COMMUNITY",$FE
								db "       and the",$fe
								db "   BAD IDEA BRIGADE",$00


; Clear screen data
xx5dc4:								
	db $46,$44
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$fe
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$fe 
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$fe
	db $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00


padbyte $ea
pad $00194f
								
warnpc $00194f

org $002ac4
	jsl $c0fcb0
