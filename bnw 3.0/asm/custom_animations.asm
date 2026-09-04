; #########################################################################
;
; Custom Animation Hack made for Brave New World
; Animation Designs, Sprites, and Hack by Khaos (IAmUrza) 2026-08-27 v.1.09
;
; Requirements:
;  	D20000_3bpp_battle_tile_formation.bin
;	D30000_3bpp_battle_graphics_1.bin
;	D40000_3bpp_battle_graphics_2.bin
; 	BNW ROM, unheadered (not compatible with Vanilla FF6 ROM)
;
; Name changes are not captured in this hack (this will cause small issues with BNW v2.1)
; Keep in mind that I don't know what I'm doing. This could be heavily cleaned up.
;
; #########################################################################

;	Future To-Do List:
;		Organize animation scripts based on address.
;		Track all available spare bytes.
;		Track all unused animation script ID #'s.
;		Fill in missing Animation Data, even if unchanged (?)

hirom
 
org $D20000
	incbin D20000_3bpp_battle_tile_formation.bin

org $D30000
	incbin D30000_3bpp_battle_graphics_1.bin

org $D40000
	incbin D40000_3bpp_battle_graphics_2.bin
 
; #########################################################################
; Sound Effect Scripts
; #########################################################################

; [ Sound Effect Script: Pearl (A) ] (Code modified from original)

org $C52BBE
	db $C8,$17,$C1			; Bend duration 46 to 23 units
	db $24					; D, 16 ticks
org $C52BCD
	db $C8,$0E,$33			; Bend duration 28 to 14 units
	db $1D					; D, 96 ticks
	db $A9					; Tie, 96 ticks
	
; [ Sound Effect Script: Pearl (B) ] (Code modified from original)

org $C52BDA
	db $C8,$4A,$09			; Pitch bend duration halved
	db $5A					; F# 72 ticks to 36 ticks
	db $E2,$03				; Repeat 4 times
org $C52BE5
	db $E2,$01				; Repeat 2 times
org $C52BF0
	db $C8,$1E,$17			; Pitch bend duration halved
 
; #########################################################################
; Animation Data
; #########################################################################
;
; Some abilities are listed with no animation data changes.
; This is because they are otherwise modified or impacted by this hack.
;
; Base Offset:		$D07FB2
; Tools Offset:		$D091A2
; Items Offset:		$D09220
; Block Size:		$0E
; Address:			( ID_# * Block_Size ) + Offset
;
;	Data Add.		Animat. 1 Animat. 2 Animat. 3 Pal1 Pal2 Pal3 Snd. Ini. Animat. 4 Dly.
org $D07FDC : db	$6F, $02, $6E, $02, $FF, $FF, $C3, $D9, $00, $6E, $10, $FF, $FF, $10	; Sap (Spell #3d)
org $D08022 : db	$54, $01, $FF, $FF, $FF, $FF, $E3, $00, $00, $51, $47, $FF, $FF, $10	; Break (Spell #8d)
																							; Holy (Spell #14d)
org $D08084 : db	$D7, $00, $99, $00, $FF, $FF, $C1, $C1, $00, $00, $15, $FF, $FF, $10	; Flare (Spell #15d)
org $D08092 : db	$E2, $00, $E3, $00, $FF, $FF, $5E, $EB, $00, $0A, $30, $FF, $FF, $10	; Dark (Spell #16d)
																							; Storm (Spell #17d)
org $D080D8 : db	$DA, $00, $B2, $01, $D9, $00, $00, $6F, $6C, $3F, $2D, $FF, $FF, $10	; Merton (Spell #21d)
org $D080E6 : db	$D3, $00, $FF, $FF, $FF, $FF, $BD, $00, $00, $1F, $67, $FF, $FF, $20	; Demi (Spell #22d)
org $D08110 : db	$BA, $00, $BB, $00, $FF, $FF, $48, $5D, $00, $18, $18, $FF, $FF, $10	; Osmose (Spell #25d)
org $D0811E : db	$CC, $00, $FF, $FF, $FF, $FF, $C9, $00, $00, $20, $10, $FF, $FF, $10	; Rasp (Spell #26d)
org $D08156 : db	$7A, $01, $7D, $01, $FF, $FF, $C8, $C8, $00, $58, $57, $FF, $FF, $00	; SleepX (Spell #30d)
org $D08172 : db	$B0, $00, $3B, $00, $FF, $FF, $C0, $DC, $00, $00, $9D, $FF, $FF, $10	; Berserk (Spell #32d)
																							; Safe (Spell #34d)
org $D081E2 : db	$B4, $00, $FF, $FF, $FF, $FF, $D0, $5C, $00, $5C, $1B, $FF, $FF, $10	; Reflect (Spell #40d)
org $D0820C : db	$A2, $00, $A3, $00, $FF, $FF, $3A, $DA, $00, $09, $19, $FF, $FF, $10	; Scan (Spell #43d)
																							; Cure 3 (Spell #47d)
org $D0827C : db	$9D, $00, $9E, $00, $FF, $FF, $D0, $56, $00, $23, $16, $86, $81, $10	; Restore (Spell #51d)
org $D0828A : db	$9F, $00, $3B, $00, $C0, $00, $D0, $00, $48, $1E, $A4, $FF, $FF, $10	; Regen (Spell #52d)
org $D08298 : db	$9F, $00, $57, $01, $FF, $FF, $D0, $00, $00, $1E, $25, $FF, $FF, $10	; RegenX (Spell #53d)
																							; Inferno (Ifrit) (Spell #55d)
org $D082DE : db	$F5, $80, $F3, $00, $F4, $00, $00, $6A, $88, $25, $35, $F5, $80, $10	; Earth Rage (Terrato) (Spell #58d)
org $D082EC : db	$52, $82, $51, $02, $FF, $FF, $D2, $C4, $00, $1A, $34, $52, $82, $10	; Hurricane (Shoat) (Spell #59d)
org $D082FA : db	$1C, $81, $1A, $01, $1B, $01, $0A, $B0, $0F, $BD, $43, $1C, $81, $08	; Chaos Wing (Maduin) (Spell #60d)
org $D08316 : db	$E8, $01, $E9, $01, $FF, $FF, $86, $00, $00, $CB, $68, $FF, $FF, $10	; Cait Sith (Stray) (Spell #62d)
org $D0836A : db	$19, $82, $1A, $02, $AF, $00, $00, $00, $EB, $86, $74, $19, $82, $10	; Jihad (Crusader) (Spell #68d)
org $D08378 : db	$EC, $81, $EE, $01, $ED, $01, $89, $89, $D2, $52, $6A, $EC, $81, $10	; Oblivion (Ragnarok) (Spell #69d)
org $D08394 : db	$0B, $81, $0A, $01, $FF, $FF, $0A, $30, $00, $3A, $3D, $0B, $81, $10	; Life Force (Kirin) (Spell #71d)
org $D083A2 : db	$F9, $00, $FA, $00, $FF, $FF, $5C, $7F, $00, $B1, $37, $FF, $FF, $10	; Light Wall (Zoneseek) (Spell #72d)
org $D083B0 : db	$09, $81, $08, $01, $FF, $FF, $78, $C0, $00, $3B, $3C, $09, $81, $10	; Ruby Blast (Carbunkl) (Spell #73d)
org $D083E8 : db	$90, $01, $0C, $01, $0D, $01, $0A, $56, $84, $3B, $3E, $0E, $81, $10	; Heal Horn (Unicorn) (Spell #77d)
org $D08404 : db	$90, $01, $15, $01, $FF, $FF, $0A, $58, $00, $27, $41, $16, $81, $10	; Group Hug (Starlet) (Spell #79d)
org $D084AC : db	$D4, $01, $D5, $01, $FF, $FF, $32, $D0, $00, $AC, $09, $FF, $FF, $10	; Tempest (Spell #91d)
																							; Fire Dance (Spell #96d)
org $D08500 : db	$FF, $FF, $6E, $00, $FF, $FF, $00, $6C, $00, $57, $0E, $FF, $FF, $10	; Mantra (Spell #97d)
org $D0850E : db	$FF, $FF, $6E, $00, $FF, $FF, $00, $0A, $00, $57, $0E, $FF, $FF, $10	; Chakra (Spell #98d)
																							; Bum Rush (Spell #100d)
org $D08546 : db	$24, $01, $FF, $FF, $FF, $FF, $D0, $00, $00, $66, $47, $25, $81, $10	; Sun Bath (Spell #102d)
org $D08554 : db	$7E, $02, $26, $01, $27, $01, $EB, $EB, $EB, $76, $10, $FF, $FF, $10	; Razor Leaf (Spell #103d)
org $D08562 : db	$28, $01, $29, $01, $2D, $01, $9E, $38, $38, $67, $1C, $FF, $FF, $18	; Harvester (Spell #104d)
org $D08570 : db	$7E, $02, $2A, $01, $FF, $FF, $20, $CF, $00, $73, $1B, $FF, $FF, $10	; Sand Storm (Spell #105d)
org $D0857E : db	$7E, $02, $29, $01, $2D, $01, $2C, $D1, $D1, $67, $48, $56, $00, $10	; Moonlight (Spell #106d)
org $D0859A : db	$31, $01, $46, $02, $FF, $FF, $00, $35, $00, $68, $1B, $FF, $FF, $10	; Bedevil (Spell #108d)
org $D08618 : db	$3D, $01, $3E, $01, $FF, $FF, $91, $39, $00, $8B, $10, $FF, $FF, $10	; Cockatrice (Spell #117d)
org $D08626 : db	$3F, $01, $FF, $FF, $FF, $FF, $92, $00, $00, $83, $10, $FF, $FF, $06	; Wombat (Spell #118d)
org $D08634 : db	$50, $01, $51, $01, $FF, $FF, $38, $94, $00, $D5, $1B, $FF, $FF, $18	; Meerkat (Spell #119d)
org $D08642 : db	$45, $01, $44, $01, $FF, $FF, $4F, $93, $00, $59, $1C, $FF, $FF, $10	; Tapir (Spell #120d)
org $D08650 : db	$41, $01, $3B, $00, $FF, $FF, $91, $00, $00, $BA, $9D, $FF, $FF, $10	; Jackrabbit (Spell #121d)
org $D0865E : db	$45, $01, $4E, $01, $FF, $FF, $C3, $94, $00, $4F, $1C, $FF, $FF, $10	; Raccoon (Spell #122d)
org $D0866C : db	$47, $01, $46, $01, $FF, $FF, $55, $1F, $00, $20, $10, $FF, $FF, $10	; Toxic Frog (Spell #123d)
org $D0867A : db	$48, $01, $49, $01, $FF, $FF, $D0, $9E, $00, $C0, $1B, $FF, $FF, $00	; Snowbird (Spell #124d)
org $D086A4 : db	$1B, $02, $FF, $FF, $FF, $FF, $BA, $00, $00, $83, $25, $FF, $FF, $10	; Trifecta (Spell #127d)
org $D086C0 : db	$1F, $02, $58, $00, $FF, $FF, $C0, $00, $00, $18, $57, $FF, $FF, $16	; Solitaire (Spell #129d)
org $D08722 : db	$50, $01, $FF, $FF, $FF, $FF, $38, $00, $00, $D5, $01, $FF, $FF, $10	; Blink (Spell #136d)
																							; Aqualung (Spell #139d)
org $D0875A : db	$7E, $02, $58, $01, $FF, $FF, $9D, $99, $00, $63, $52, $FF, $FF, $10	; Bad Breath (Spell #140d)
org $D08776 : db	$55, $01, $FF, $FF, $FF, $FF, $C0, $00, $00, $16, $57, $FF, $FF, $38	; Blaze (Spell #142d)
org $D087AE : db	$BA, $00, $BB, $00, $FF, $FF, $C1, $B3, $00, $18, $18, $FF, $FF, $10	; Leech (Spell #146d)
org $D087BC : db	$55, $01, $FF, $FF, $FF, $FF, $86, $00, $00, $16, $57, $FF, $FF, $10	; Raze (Spell #147d)
org $D087CA : db	$50, $01, $FF, $FF, $FF, $FF, $D0, $00, $00, $D5, $01, $FF, $FF, $10	; Refract (Spell #148d)
org $D087D8 : db	$A9, $00, $75, $01, $FF, $FF, $E1, $D8, $00, $48, $1B, $FF, $FF, $08	; Safeguard (Spell #149d)
org $D087F4 : db	$57, $00, $FF, $FF, $FF, $FF, $20, $00, $00, $BF, $57, $FF, $FF, $00	; Jackpot (Spell #151d)
org $D08802 : db	$5A, $01, $5B, $01, $FF, $FF, $D0, $CE, $00, $23, $1B, $FF, $FF, $00	; Kazekiri (Spell #152d)
org $D08810 : db	$5A, $01, $5C, $01, $FF, $FF, $D0, $0B, $00, $73, $1B, $FF, $FF, $00	; Mutsunokami / Wind Breaker (Spell #153d)
org $D08848 : db	$28, $01, $29, $01, $2D, $01, $9E, $38, $38, $67, $1C, $FF, $FF, $10	; Harvester (Enemy) (Spell #157d)
org $D08856 : db	$24, $01, $FF, $FF, $FF, $FF, $D0, $00, $00, $66, $47, $25, $81, $10	; Sun Bath (Enemy) (Spell #158d)
org $D08864 : db	$4B, $01, $33, $01, $FF, $FF, $C0, $C0, $00, $3F, $76, $4C, $01, $00	; Meltdown (Spell #159d)
org $D08872 : db	$11, $02, $12, $02, $FF, $FF, $C9, $C9, $00, $CE, $22, $FF, $FF, $10	; Aqua Slash (Spell #160d)
org $D088AA : db	$7E, $02, $58, $01, $FF, $FF, $9D, $60, $00, $63, $52, $FF, $FF, $10	; Bio Blast (Spell #164d)
																							; Schiller (Spell #167d)
org $D088FE : db	$7E, $02, $8F, $01, $6B, $00, $00, $B9, $00, $79, $1B, $FF, $FF, $10	; Boil (Spell #170d)
org $D0891A : db	$85, $01, $DD, $80, $FF, $FF, $E3, $E3, $00, $FD, $1B, $7D, $81, $14	; Starlight (Spell #172d)
org $D08928 : db	$7E, $02, $75, $02, $FF, $FF, $00, $ED, $00, $95, $1B, $FF, $FF, $10	; Net (Spell #173d)
																							; Aqualung (Enemy) (Spell #175d)
org $D08960 : db	$9F, $00, $3B, $00, $C0, $00, $52, $00, $46, $1E, $A4, $FF, $FF, $10	; Repair (Spell #177d)
org $D0898A : db	$63, $01, $64, $01, $FF, $FF, $73, $73, $00, $9C, $47, $FF, $FF, $20	; Atomic Ray (Spell #180d)
org $D089A6 : db	$67, $81, $68, $01, $FF, $FF, $DB, $E5, $00, $88, $51, $67, $81, $10	; Volt Array (Spell #182d)
org $D089B4 : db	$81, $01, $33, $01, $40, $01, $DF, $53, $53, $D2, $76, $FF, $FF, $10	; Discharge (Spell #183d)
org $D089C2 : db	$34, $01, $FF, $FF, $FF, $FF, $E5, $00, $00, $43, $25, $FF, $FF, $10	; Mega Volt (Spell #184d)
org $D089D0 : db	$96, $01, $EA, $00, $FF, $FF, $D0, $ED, $00, $15, $1B, $FF, $FF, $28	; Giga Volt (Spell #185d)
org $D08A24 : db	$B6, $00, $B7, $00, $B8, $00, $48, $47, $EB, $6C, $20, $FF, $FF, $08	; Barrier (Spell #191d)
org $D08A32 : db	$9A, $00, $FF, $FF, $FF, $FF, $E6, $00, $00, $4B, $14, $FF, $FF, $10	; Fallen One (Spell #192d)
org $D08A40 : db	$7B, $01, $20, $02, $FF, $FF, $E3, $00, $00, $18, $57, $FF, $FF, $10	; Wallchange (Spell #193d)
org $D08A78 : db	$30, $01, $DF, $80, $08, $02, $54, $0C, $00, $36, $10, $FF, $FF, $1C	; N.Cross (Spell #197d)
org $D08A86 : db	$A4, $01, $A5, $01, $A6, $01, $C1, $6B, $5E, $B7, $61, $FF, $FF, $10	; Flare Star (Spell #198d)
																							; Sneeze (Spell #203d)
org $D08B20 : db	$0C, $02, $0D, $02, $FF, $FF, $73, $CA, $00, $13, $72, $FF, $FF, $10	; Hyperdrive (Spell #209d)
org $D08B2E : db	$7E, $02, $83, $01, $84, $01, $38, $66, $C8, $30, $5D, $FF, $FF, $10	; Pale Omen (Spell #210d)
																							; Thriller (Spell #214d)
org $D08BE4 : db	$C5, $01, $FF, $FF, $C2, $01, $C1, $00, $00, $89, $57, $FF, $FF, $10	; Meteo (Spell #223d)
org $D08C00 : db	$0F, $02, $FF, $FF, $10, $02, $E1, $00, $37, $43, $23, $FF, $FF, $00	; Phantasm (Spell #225d)
org $D08C1C : db	$11, $02, $12, $02, $FF, $FF, $C1, $C1, $00, $62, $22, $FF, $FF, $10	; Shock Wave (Spell #227d)
org $D08C54 : db	$34, $01, $FF, $FF, $FF, $FF, $D0, $00, $00, $5C, $25, $FF, $FF, $08	; Air Blast (Spell #231d)
org $D08C62 : db	$38, $01, $FF, $FF, $FF, $FF, $BD, $00, $00, $F0, $4D, $FF, $FF, $10	; Lode Stone (Spell #232d)
org $D08C8C : db	$4D, $01, $46, $02, $FF, $FF, $00, $39, $00, $68, $49, $FF, $FF, $10	; Lifeshaver (Spell #235d)
org $D08D7A : db	$E0, $01, $6E, $02, $FF, $FF, $BF, $36, $00, $97, $0A, $FF, $FF, $10	; Reprisal (Spell #252d)
org $D08D88 : db	$E4, $01, $E5, $01, $FF, $FF, $BF, $16, $00, $97, $1B, $FF, $FF, $10	; Good Boy (Spell #253d)
																							; Noiseblaster (Tool #0d)
																							; Bio Blaster (Tool #1d)
																							; Flash (Tool #2d)
																							; Chainsaw (Normal) (Tool #3d)
org $D091DA : db	$A5, $00, $55, $00, $FF, $FF, $61, $00, $00, $15, $09, $A6, $00, $10	; Defibrillator (Tool #4d)
																							; Drill (Tool #5d)
org $D091F6 : db	$53, $00, $54, $00, $FF, $FF, $69, $00, $00, $0B, $1A, $FF, $FF, $10	; Mana Battery (Tool #6d)
																							; Autocrossbow (Tool #7d)
																							; Chainsaw (Mask) (Tool #8d)
org $D09220 : db	$FB, $01, $FF, $FF, $FF, $FF, $D3, $00, $00, $7D, $7D, $FF, $FF, $10	; Tonic (Item #0d)
org $D0922E : db	$FC, $01, $FF, $FF, $FF, $FF, $D3, $00, $00, $7D, $7D, $FF, $FF, $10	; Potion (Item #1d)
org $D0923C : db	$FD, $01, $FF, $FF, $FF, $FF, $D3, $00, $00, $7D, $5E, $FF, $FF, $00	; X-Potion (Item #2d)
org $D0924A : db	$FB, $01, $FF, $FF, $FF, $FF, $B4, $00, $00, $7D, $7D, $FF, $FF, $10	; Tincture (Item #3d)
org $D09258 : db	$FC, $01, $FF, $FF, $FF, $FF, $C2, $00, $00, $7D, $7D, $FF, $FF, $10	; Ether (Item #4d)
org $D09266 : db	$FD, $01, $FF, $FF, $FF, $FF, $C2, $00, $00, $7D, $5E, $FF, $FF, $00	; X-Ether (Item #5d)
org $D09274 : db	$06, $02, $FF, $FF, $FF, $FF, $C0, $00, $00, $1E, $7D, $FF, $FF, $10	; Elixir (Item #6d)
																							; Megalixir (Item #7d)
org $D092BA : db	$03, $02, $3B, $00, $07, $02, $D4, $00, $00, $E5, $F0, $FF, $FF, $10	; Eyedrops (Item #11d)
org $D092C8 : db	$03, $02, $FF, $FF, $07, $02, $E5, $00, $00, $E5, $F0, $90, $81, $10	; Snake Oil (Item #12d)
org $D092D6 : db	$02, $02, $FF, $FF, $FF, $FF, $C0, $00, $00, $23, $F1, $86, $81, $10	; Remedy (Item #13d)
org $D09300 : db	$00, $02, $FF, $FF, $FF, $FF, $55, $00, $00, $7D, $7D, $FF, $FF, $10	; Green Cherry (Item #16d)
org $D09354 : db	$00, $02, $FF, $FF, $FF, $FF, $C0, $00, $00, $7D, $7D, $FF, $FF, $10	; Dried Meat (Item #22d)
																							; Go Fish (Spell #254d)
org $D08F56 : db	$76, $80, $5E, $01, $77, $00, $C5, $EC, $C5, $03, $12, $76, $00, $10	; Esper Summon (Other #$D08F56)	
																							; Repeat Dance (Other #$D08FB8)		
org $D08FE2 : db	$39, $00, $FF, $FF, $FF, $FF, $20, $00, $00, $28, $5E, $3A, $00, $08	; GP Toss (Other #$D08FE2)
org $D0901A : db	$72, $80, $DB, $00, $62, $02, $1A, $00, $88, $61, $2F, $72, $00, $10	; Sketch (Other #$D0901A)
org $D090A6 : db	$7E, $02, $3F, $00, $FF, $FF, $00, $1F, $00, $E4, $1B, $FF, $FF, $10	; Jump, Atma Weapon  (Other #$D090A6)
org $D090C2 : db	$8F, $00, $FF, $FF, $FF, $FF, $18, $00, $00, $28, $10, $FF, $FF, $10	; Throw, Kunai (Other #$D090C2)
org $D090D0 : db	$8E, $00, $FF, $FF, $FF, $FF, $18, $00, $00, $28, $10, $FF, $FF, $10	; Throw, Knife (Blue) (Other #$D090D0)
org $D090DE : db	$91, $00, $FF, $FF, $FF, $FF, $1C, $00, $00, $28, $10, $FF, $FF, $10	; Throw, Full Moon (Other #$D090DE)
org $D090EC : db	$90, $00, $FF, $FF, $FF, $FF, $18, $00, $00, $28, $10, $FF, $FF, $10	; Throw, Spoon (Other #$D090EC)
org $D090FA : db	$91, $00, $FF, $FF, $FF, $FF, $24, $00, $00, $28, $10, $FF, $FF, $10	; Throw, Rising Sun (Other #$D090FA)
org $D09108 : db	$92, $00, $FF, $FF, $FF, $FF, $94, $00, $00, $28, $10, $FF, $FF, $10	; Throw, Pointy Stick (Other #$D09108)
org $D09116 : db	$0C, $00, $2F, $00, $FF, $FF, $18, $18, $00, $94, $10, $FF, $FF, $00	; Throw, Shuriken (Other #$D09116)
org $D09124 : db	$0D, $00, $30, $00, $FF, $FF, $18, $18, $00, $94, $10, $FF, $FF, $00	; Throw, Ninja Star (Other #$D09124)
org $D09132 : db	$F8, $01, $F4, $01, $FF, $FF, $02, $38, $00, $19, $0A, $A9, $81, $00	; Fire Scroll (Other #$D09132)
org $D09140 : db	$F8, $01, $F6, $01, $F5, $01, $02, $78, $00, $5F, $0C, $A9, $81, $00	; Wave Scroll (Other #$D09140)
org $D0914E : db	$F8, $01, $F7, $01, $F9, $01, $02, $7B, $37, $43, $51, $A9, $81, $00	; Bolt Scroll (Other #$D0914E)
org $D0915C : db	$FA, $01, $FF, $FF, $FF, $FF, $02, $00, $00, $46, $0A, $A9, $81, $00	; Fade Scroll (Other #$D0915C)
org $D0916A : db	$04, $02, $7B, $00, $FF, $FF, $52, $00, $00, $1D, $78, $A9, $81, $10	; Smoke Bomb (Other #$D0916A)
org $D09178 : db	$79, $02, $FF, $FF, $FF, $FF, $22, $00, $00, $28, $10, $FF, $FF, $10	; Throw, Wing Edge (Other #$D09178)
org $D09186 : db	$79, $02, $FF, $FF, $FF, $FF, $18, $00, $00, $28, $10, $FF, $FF, $10	; Throw, Boomerang (Other #$D09186)
org $D09194 : db	$8E, $00, $FF, $FF, $FF, $FF, $19, $00, $00, $28, $10, $FF, $FF, $10	; Throw, Knife (Green) (Other #$D09194)
																							; Shift Dance (Other #$D0946C)
org $D0947A : db	$12, $00, $FF, $FF, $FF, $FF, $D3, $00, $00, $FA, $1C, $FF, $FF, $10	; Fixed Dice (Other #$D0947A)

; #########################################################################
; Item Attributes for Jump and Throw Animations
; #########################################################################
;
; Each item has a byte to determine its jump, throw, and anti-air critical hit animations.
;
;	Byte breakdown: djjjtttt
;
; 	d: Default to fight animation
;		0	Use Throw animation when thrown, based on tttt
;		1	Use Fight animation when thrown, ignore tttt
;
;	j: Jump animation type
;		0	Unarmed
;		1	Short Sword
;		2	Knife
;		3	Long Sword
;		4	Katana
;		5	Rod
;		6	Spear
;		7	Atma Weapon
;
;	t: Throw animation type
;		0	Kunai
;		1	Knife (Blue)
;		2	Full Moon Crit
;		3	Spoon (Sword)
;		4	Rising Sun Crit
;		5	Pointy Stick
;		6	Shuriken
;		7	Ninja Star
;		8	Fire Scroll
;		9	Wave Scroll
;		A	Bolt Scroll
;		B	Fade Scroll
;		C	Smoke Bomb
;		D	Wing Edge Crit
;		E	Boomerang Crit
;		F	Knife (Green)

org $D10041					; Item #	Item Name		Jump Animation	Throw Animation 

	db $2F					; Item #0	Healing Shiv	Knife			Knife (Green)
	db $21					; Item #1	Dirk			Knife			Knife (Blue)
	db $21					; Item #2	Kagenui			Knife			Knife (Blue)
	db $21					; Item #3	Butterfly		Knife			Knife (Blue)
	db $21					; Item #4	Switchblade		Knife			Knife (Blue)
	db $21					; Item #5	Demonsbane		Knife			Knife (Blue)
	db $21					; Item #6	Man Eater		Knife			Knife (Blue)
	db $20					; Item #7	Kunai			Knife			Kunai
	db $21					; Item #8	Avenger			Knife			Knife (Blue)
	db $21					; Item #9	Valiance		Knife			Knife (Blue)
	db $10					; Item #10	Sabre			Short Sword
	db $10					; Item #11	Iron Cutlass	Short Sword
	db $10					; Item #12	Scimitar		Short Sword
	db $10					; Item #13	Flametongue		Short Sword
	db $10					; Item #14	Icebrand		Short Sword
	db $10					; Item #15	Elec Sword		Short Sword
	db $10					; Item #16	-
	db $10					; Item #17	-
	db $40					; Item #18	Blood Sword		Katana
	db $10					; Item #19	Imperial		Short Sword
	db $10					; Item #20	Rune Blade		Short Sword
	db $10					; Item #21	Falchion		Short Sword
	db $40					; Item #22	Soul Sabre		Katana
	db $30					; Item #23	-
	db $30					; Item #24	Excalibur		Long Sword
	db $30					; Item #25	Zantetsuken		Long Sword
	db $30					; Item #26	Illumina		Long Sword
	db $30					; Item #27	Apocalypse		Long Sword
	db $70					; Item #28	Atma Weapon		Atma Weapon
	db $60					; Item #29	Mythril Pike	Spear
	db $60					; Item #30	Trident			Spear
	db $60					; Item #31	Stout Spear		Spear
	db $60					; Item #32	Partisan		Spear
	db $60					; Item #33	Longinus		Spear
	db $60					; Item #34	Fire Lance		Spear
	db $60					; Item #35	Gungnir			Spear
	db $65					; Item #36	Pointy Stick					Pointy Stick
	db $21					; Item #37	Tanto			Knife			Knife (Blue)
	db $20					; Item #38	Kunai			Knife			Kunai
	db $21					; Item #39	Sakura			Knife			Knife (Blue)
	db $21					; Item #40	Ninjato			Knife			Knife (Blue)
	db $21					; Item #41	Kagenui			Knife			Knife (Blue)
	db $2F					; Item #42	Orochi			Knife			Knife (Green)
	db $40					; Item #43	Hanzo			Katana
	db $40					; Item #44	Kotetsu			Katana
	db $40					; Item #45	Ichimonji		Katana
	db $40					; Item #46	Kazekiri		Katana
	db $40					; Item #47	Murasame		Katana
	db $40					; Item #48	Masamune		Katana
	db $43					; Item #49	Spoon							Spoon
	db $40					; Item #50	Mutsunokami		Katana
	db $50					; Item #51	Spook Stick		Rod
	db $50					; Item #52	Magus Rod		Rod
	db $50					; Item #53	Fire Rod		Rod
	db $50					; Item #54	Ice Rod			Rod
	db $50					; Item #55	Thunder Rod		Rod
	db $50					; Item #56	Windbreaker		Rod
	db $50					; Item #57	Doomstick		Rod
	db $50					; Item #58	Quartrstaff		Rod
	db $50					; Item #59	Punisher		Rod
	db $50					; Item #60	-
	db $00					; Item #61	Light Brush		Unarmed
	db $00					; Item #62	Monet Brush		Unarmed
	db $00					; Item #63	Dali Brush		Unarmed
	db $00					; Item #64	Ross Brush		Unarmed
	db $06					; Item #65	Shuriken						Shuriken
	db $80					; Item #66	-
	db $07					; Item #67	Ninja Star						Ninja Star
	db $00					; Item #68	Club			Unarmed
	db $02					; Item #69	Full Moon		Unarmed			Full Moon Crit
	db $00					; Item #70	Morning Star	Unarmed
	db $0E					; Item #71	Boomerang		Unarmed			Boomerang Crit
	db $04					; Item #72	Rising Sun		Unarmed			Rising Sun Crit
	db $20					; Item #73	Kusarigama		Knife
	db $00					; Item #74	Bone Club		Unarmed
	db $00					; Item #75	Magic Bone		Unarmed
	db $0D					; Item #76	Wing Edge		Unarmed			Wing Edge Crit
	db $00					; Item #77	-
	db $80					; Item #78	Darts			Unarmed & Ignore Throw
	db $80					; Item #79	Tarot			Unarmed & Ignore Throw
	db $80					; Item #80	Viper Darts		Unarmed & Ignore Throw
	db $80					; Item #81	Dice			Unarmed & Ignore Throw
	db $80					; Item #82	Fixed Dice		Unarmed & Ignore Throw
	db $00					; Item #83	Mythril Claw	Unarmed
	db $00					; Item #84	Light Claw		Unarmed
	db $00					; Item #85	Poison Claw		Unarmed
	db $00					; Item #86	Ocean Claw		Unarmed
	db $04					; Item #87	Hell Claw		Unarmed			Rising Sun Crit
	db $00					; Item #88	Frostgore		Unarmed
	db $00					; Item #89	Stormfang		Unarmed

; #########################################################################
; Frame Data for Custom Graphics
; #########################################################################
;
; Each frame has one or more two byte pairs, which each represent a 16 x 16 pixel block.
; The Frame Data assembles these blocks into a larger sprite.
;
; Byte 1:		Determines position of the 16 x 16 block
;				For a 3 x 3 (48 pixels x 48 pixels) frame, see the below example:
;				00 10 20
;				01 11 21
;				02 12 22
; Byte 2:		Combines with Tile Index to point to a 16 x 16 block of pixels
;				The Tile Index is higher byte, and this byte is a lower byte
;				Refer to Graphics Data Offsets for Tile Index values

; $00EE Inferno (sprite) (Changed from original)
org $D14461 : db	$00, $00, $10, $01, $20, $02, $01, $08, $11, $09											; Frame $02
			  db	$21, $0A, $02, $10, $12, $11, $22, $18, $03, $20											; Frame $02 (continued)

; $000C Shuriken (sprite)
org $D1E9E4 : db	$00,$00																						; Frame $00 
			  db	$00,$1E																						; Frame $01
			  db	$00,$01																						; Frame $02

; $000D	Ninja Star (sprite)
org	$D1E9EC : db	$00,$04, $10,$05, $01,$0C, $11,$0D															; Frame $00
			  db	$00,$06, $10,$07, $01,$0E, $11,$0F															; Frame $01
			  db	$00,$14, $10,$15, $01,$1C, $11,$1D															; Frame $02

; $0054	Mana Battery (extra)
org	$D108FF : db	$00,$0F																						; Frame $00
			  
; $0055	Defibrillator (bg1)
org	$D10901 : db	$00,$0D, $01,$0C																			; Frame $00

; $008E	Throw, Knife (sprite)
org	$D11371 : db	$00,$00, $10,$01, $01,$08, $11,$09															; Frame $00
			  db	$00,$02, $10,$03, $01,$0A, $11,$0B															; Frame $01
			  db	$00,$04, $10,$05, $01,$0C, $11,$0D															; Frame $02
			  db	$00,$06, $10,$07, $01,$0E, $11,$0F															; Frame $03
			  db	$00,$C9, $10,$C8, $01,$C1, $11,$C0															; Frame $04
			  db	$00,$CB, $10,$CA, $01,$C3, $11,$C2															; Frame $05
			  db	$00,$CD, $10,$CC, $01,$C5, $11,$C4															; Frame $06
			  db	$00,$CF, $10,$CE, $01,$C7, $11,$C6															; Frame $07
			  db	$00,$1F																						; Frame $08

; $01D5 Tempest (bg1)
org $D1E9CA : db	$00,$04, $10,$05, $20,$06, $01,$0C, $11,$0D, $21,$0E										; Frame $00 
			  db	$10,$1E, $20,$1F, $11,$26, $21,$27															; Frame $01

; $013D Cockatrice (sprite)
org $D1E994 : db	$00,$00, $10,$01, $01,$08, $11,$09															; Frame $00 
			  db	$00,$02, $10,$03, $01,$0A, $11,$0B	 														; Frame $01
			  db	$FF,$FF

; $013F Wombat (sprite)
org $D17A0F : db	$00,$04																						; Frame $00 
			  db	$00,$05																						; Frame $01

; $01E5 Scroll Throw (sprite), Fade Scroll (sprite)
org $D17A33 : db	$00,$0F																						; Frame $00 
			  db	$00,$0E																						; Frame $01
			  db	$FF,$FF

; $0151 Meerkat (bg1)
org $D180D1 : db	$01,$58																						; Frame $00 
			  db	$01,$59																						; Frame $01
			  db	$01,$5A																						; Frame $02
			  db	$01,$5B																						; Frame $03
			  db	$00,$5C, $01,$64																			; Frame $04
			  db	$FF,$FF
			  db	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF										; Spare bytes (end with $FFFF if reused.)
			  
; $0141 Jackrabbit (sprite)
org $D1E9A6 : db	$00,$00, $01,$08																			; Frame $00 
			  db	$00,$00, $01,$09																			; Frame $01
			  db	$00,$02, $01,$0A																			; Frame $02
			  db	$00,$03, $01,$0B																			; Frame $03
			  db	$FF,$FF

; $021F Solitaire (sprite)
org $D1D5FB : db	$00,$1E 																					; Frame $00 
			  db	$00,$1F, $01,$1F, $02,$1F, $03,$1E 															; Frame $01
			  db	$00,$1F, $01,$1F, $02,$1F, $03,$1F, $04,$1F, $05,$1F, $06,$1E 								; Frame $02
			  db	$00,$1F, $01,$1F, $02,$1F, $03,$1F, $04,$1F, $05,$1F, $06,$1F, $07,$1F, $08,$1E 			; Frame $03
			  db	$00,$1F, $01,$1F, $02,$1F, $03,$1F, $04,$1F, $05,$1F, $06,$1F, $07,$1F, $08,$1F, $09,$1E	; Frame $04
			  db	$02,$1D, $03,$1F, $04,$1F, $05,$1F, $06,$1F, $07,$1F, $08,$1F, $09,$1E 						; Frame $05
			  db	$05,$1D, $06,$1F, $07,$1F, $08,$1F, $09,$1E 												; Frame $06
			  db	$07,$1D, $08,$1F, $09,$1E 																	; Frame $07
			  db	$08,$1D, $09,$1E 																			; Frame $08
			  db	$08,$1B, $09,$1C 																			; Frame $09
			  db	$08,$19, $09,$1A 																			; Frame $0A
			  db	$09,$18																						; Frame $0B

; $0057 Jackpot (sprite)
org $D1E9B8 : db	$00,$04																						; Frame $00 
			  db	$00,$05																						; Frame $01
			  db	$00,$06																						; Frame $02		
			  db	$00,$07																						; Frame $03
			  db	$00,$08																						; Frame $04
			  db	$00,$09																						; Frame $05
			  db	$00,$0A																						; Frame $06
			  db	$00,$0B 																					; Frame $07
			  db	$FF,$FF

; $014A Go Fish (bg1)
org $D17BC1 : db	$00,$08, $01,$10, $11,$11		 															; Frame $00
			  db	$FF,$FF
org $D1E98A : db	$00,$0A, $01,$12, $10,$0B, $11,$13															; Frame $01
			  db	$FF,$FF

; $01E5 Good Boy (bg1)
org $D1E9E0 : db	$00,$01						 																; Frame $00
			  db	$FF,$FF

; $0015 Disc Hit (sprite)
org $D1EA06 : db	$02,$08																						; Frame $00 
			  db	$21,$0D																						; Frame $01
			  db	$11,$0A, $21,$0B, $12,$0C																	; Frame $02		
			  db	$12,$0E																						; Frame $03
			  db	$02,$07																						; Frame $04
			  db	$FF,$FF

; #########################################################################
; Animation Script Pointers
; #########################################################################
;
; Base Offset:		$D1EAD8
; Block Size:		$02
; Address:			( ID_# * Block_Size ) + Offset
;
;	Pointer Add.	Start Add.	  ID_#		Old Anim. Script Name		New Animation Script Name
org $D1EB0C : db	$DE, $7D	; $001A		Hawk Eye & Sniper (sprite)	Kusarigama (sprite)
org $D1EB30 : db	$57, $7F	; $002C		Spikey Sword (sprite)		Gungnir (sprite)
org $D1EB80 : db	$72, $76	; $0054		Debilitator (bg1)			Mana Battery (bg1)
org $D1EB82 : db	$AD, $36	; $0055		Debilitator (bg3)			Defibrillator (bg1)
org $D1EB84 : db	$93, $76	; $0056		Debilitator (extra)			Moonlight (extra)
org $D1EB88 : db	$B3, $54	; $0058		Air Anchor (extra)			Solitaire (bg1)
org $D1EBE6 : db	$93, $66	; $0087		---							Jump, Short Sword (sprite)
org $D1EBE8 : db	$93, $66	; $0088		---							Jump, Knife (sprite)
org $D1EBFA : db	$41, $3C	; $0091		Throw, Rod (sprite)			Full Moon, Rising Sun Crit (sprite)
org $D1EC24 : db	$81, $61	; $00A6		Rasp (sprite)				Defibrillator (extra)
org $D1ED38 : db	$66, $73	; $0130		Specter (bg1)				N.Cross (sprite)
org $D1ED54 : db	$84, $40	; $013E		Cokatrice (bg1)				Cockatrice (bg1)
org $D1ED58 : db	$81, $41	; $0140		Wombat (bg1)				Discharge (bg3)
org $D1ED5A : db	$31, $3D	; $0141		Whump (sprite)				Jackrabbit (sprite)
org $D1ED64 : db	$E1, $3F	; $0146		Toxic Frog (bg1)			Toxic Frog (bg1)
org $D1ED66 : db	$77, $40	; $0147		Toxic Frog (sprite)			Toxic Frog (sprite)
org $D1ED6A : db	$3B, $40	; $0149		Ice Rabbit (sprite)			Snowbird (bg1)
org $D1ED6E : db	$73, $3E	; $014B		Fire Beam (bg1)				Meltdown (sprite)
org $D1ED70 : db	$A2, $3E	; $014C		Fire/Ice Beam (bg3)			Meltdown (extra)
org $D1ED72 : db	$63, $0D	; $014D		Fire/Ice Beam (sprite)		Lifeshaver (sprite)
org $D1ED78 : db	$CC, $3F	; $0150		Kitty (sprite)				Refract, Blink, Meerkat (sprite)
org $D1ED7A : db	$5F, $3F	; $0151		Kitty (bg1)					Meerkat (bg1)
org $D1ED86 : db	$89, $61	; $0157		Ice Beam (bg1)				RegenX (bg1)
org $D1ED8C : db	$69, $36	; $015A		Grav Bomb (sprite)			!Kazekiri, !Mutsunokami and Wind Breaker (sprite)
org $D1ED8E : db	$76, $36	; $015B		Grav Bomb (bg1)				!Kazekiri (bg1) (shared with below)
org $D1ED90 : db	$76, $36	; $015C		Confuser (bg3)				!Mutsunokami and Wind Breaker (bg1) (shared with above)
org $D1EDA8 : db	$6D, $3A	; $0168		---							Volt Array (bg1)
org $D1EDCC : db	$57, $36	; $017A		Delta Hit (sprite)			SleepX (sprite)
org $D1EDCE : db	$CD, $72	; $017B		Delta Hit (bg1)				Wallchange (sprite)
org $D1EDE2 : db	$F7, $13	; $0185		L.5 Doom (sprite)			Starlight (sprite) 
org $D1EDE4 : db	$1C, $76	; $0186		L.4 Flare (sprite)			Happy Jump (long delay) (extra)
org $D1EDF6 : db	$75, $25	; $018F		---							Aqualung, Aqualung (Enemy), Boil (bg1)
org $D1EDF8 : db	$12, $76	; $0190		L.4 Flare (extra)			Happy Jump (short delay) (extra)
org $D1EE40 : db	$6F, $73	; $01B4		---							Thriller (sprite)
org $D1EE82 : db	$7C, $73	; $01D5		Unused Swdtech (bg1)		Tempest (bg1)
org $D1EEA0 : db	$EA, $57	; $01E4		Takedown (sprite)			Good Boy (sprite)
org $D1EEA2 : db	$2F, $58	; $01E5		Takedown (bg1)				Good Boy (bg1)
org $D1EBC4 : db	$DF, $6A	; $0076		---							Esper Summon (sprite, extra)
org $D1EEC8 : db	$D5, $13	; $01F8		Inviz Edge (sprite)			Scroll Throw (sprite)
org $D1EECA : db	$25, $23	; $01F9		Bolt Edge (bg3)				Bolt Scroll (bg3)
org $D1EEF8 : db	$9B, $3A	; $0210		Phantasm (bg3)				Phantasm (bg3)

; #########################################################################
; Palette Changes
; #########################################################################

org $D261E0
	db $E8,$01,$84,$10,$FF,$77,$FF,$77,$73,$4A,$EF,$39,$EF,$39,$84,$10	; Palette #30 for Dice modified to allow Fixed Dice to use an alternative palette

; #########################################################################
; Graphics Data
; #########################################################################
;
; Base Offset:		$D4D000
; Block Size:		$06
; Address:			( ID_# * Block_Size ) + Offset
;
;					# of	Tile	Frame		Frame	Frame
;	Data Add.		Frames	Index	Data Index	Width	Height	  ID_#	Description
org $D4D048 : db	$03,	$2A,	$86, $0F,	$01,	$01		; $000C	Throw, Shuriken (sprite) uses custom graphics
org $D4D04E : db	$03,	$4D,	$2C, $10,	$02,	$02		; $000D	Throw, Ninja Star (sprite) uses custom graphics
org $D4D07E : db	$05,	$3D,	$2F, $10,	$03,	$03		; $0015	Disc Hit (sprite) uses custom graphics
org $D4D09C : db	$04,	$59,	$9B, $00,	$03,	$03		; $001A	Kusarigama (sprite) uses custom graphics
org $D4D108 : db	$02,	$17,	$E9, $00,	$03,	$03		; $002C	Gungnir (sprite) uses custom graphics
org $D4D1F2 : db	$88,	$09,	$29, $03,	$01,	$01		; $0053	Mana Battery (sprite) uses Osmose graphics
org $D4D1F8 : db	$01,	$2E,	$4F, $01,	$01,	$01		; $0054	Mana Battery (bg1) uses custom graphics
org $D4D1FE : db	$02,	$1F,	$50, $01,	$01,	$02		; $0055	Defibrillator (bg1) uses custom graphics
org $D4D20A : db	$08,	$E2,	$7B, $0F,	$01,	$01		; $0057	Jackpot (sprite) uses custom graphics
org $D4D17A : db	$01,	$20,	$2A, $01,	$02,	$02		; $003F	Jump, Atma Weapon (sprite) alignment adjusted
org $D4D354 : db	$09,	$80,	$FC, $01,	$02,	$02		; $008E	Throw, Knife (sprite) uses custom graphics
org $D4D35A : db	$02,	$80,	$06, $02,	$02,	$01		; $008F	Throw, Kunai (sprite) alignment adjusted
org $D4D360 : db	$02,	$80,	$08, $02,	$02,	$01		; $0090	Throw, Spoon (sprite) alignment adjusted
org $D4D366 : db	$02,	$3C,	$61, $0B,	$01,	$01		; $0091	Full Moon, Rising Sun Crit (sprite) uses Disc graphics
org $D4D36C : db	$02,	$81,	$0C, $02,	$03,	$01		; $0092	Throw, Pointy Stick (sprite) alignment adjusted
org $D4D3DE : db	$0B,	$93,	$55, $04,	$07,	$0A		; $00A5	Defibrillator (sprite) uses Bolt 3 graphics
org $D4D594 : db	$06,	$00,	$89, $04,	$04,	$03		; $00EE	Inferno (sprite) uses custom graphics
org $D4D6F0 : db	$8E,	$09,	$2A, $06,	$02,	$02		; $0128	Harvester (sprite) uses Cure 2 graphics
org $D4D720 : db	$18,	$AF,	$04, $04,	$07,	$07		; $0130	N.Cross (sprite) uses Ice 2 graphics
org $D4D76E : db	$02,	$DB,	$75, $0F,	$02,	$02		; $013D	Cockatrice (sprite) uses custom graphics
org $D4D774 : db	$8F,	$33,	$84, $08,	$06,	$04		; $013E	Cockatrice (bg1) uses ShadowFang graphics
org $D4D77A : db	$02,	$E3,	$C8, $05,	$01,	$01		; $013F	Wombat (sprite) uses custom graphics (moved sprite in data)
org $D4D780 : db	$89,	$58,	$77, $09,	$10,	$0A		; $0140	Discharge (bg3) uses Bolt Edge graphics
org $D4D786 : db	$04,	$E1,	$77, $0F,	$01,	$02		; $0141	Jackrabbit (sprite) uses custom graphics
org $D4D7B0 : db	$09,	$A0,	$A1, $09,	$01,	$01		; $0148	Snowbird (sprite) uses Fenix Down graphics
org $D4D7B6 : db	$0A,	$A0,	$5C, $05,	$02,	$02		; $0149	Snowbird (bg1) uses Harvester graphics
org $D4D7BC : db	$02,	$DC,	$05, $06,	$02,	$02		; $014A	Lagomorph (bg1) uses custom graphics
org $D4D7C2 : db	$0B,	$7C,	$66, $08,	$02,	$02		; $014B	Meltdown (sprite) uses Heartburn graphics
org $D4D7E0 : db	$8B,	$08,	$3F, $08,	$06,	$06		; $0150	Refract, Blink, Meerkat (sprite) uses Big Guard graphics
org $D4D7E6 : db	$05,	$DD,	$24, $06,	$01,	$02		; $0151	Meerkat (bg1) uses custom graphics
org $D4D7F8 : db	$04,	$62,	$D1, $07,	$02,	$04		; $0154	Break (sprite) uses Cyclonic graphics
org $D4D7FE : db	$08,	$10,	$7C, $06,	$02,	$02		; $0155	Blaze, Raze (sprite) uses Fireball graphics
org $D4D81C : db	$98,	$2E,	$8A, $01,	$04,	$02		; $015A	!Kazekiri, !Mutsunokami and Wind Breaker (sprite) uses Air Blade Hit graphics
org $D4D822 : db	$01,	$58,	$85, $05,	$10,	$0A		; $015B	!Kazekiri (bg1) uses Wind Slash graphics
org $D4D828 : db	$01,	$F1,	$D5, $07,	$10,	$0A		; $015C	!Mutsunokami and Wind Breaker (bg1) uses Cyclonic graphics
org $D4D834 : db	$09,	$A0,	$9F, $0A,	$01,	$01		; $015E	Esper Summon (bg1) uses Transform to Magicite graphics
org $D4D8BE : db	$01,	$4F,	$D4, $03,	$04,	$04		; $0175	Safeguard (bg1) uses Safe graphics
org $D4D8DC : db	$08,	$A0,	$A5, $02,	$02,	$02		; $017A	SleepX (sprite) uses Sleep graphics
org $D4D8E2 : db	$4C,	$0C,	$37, $0A,	$01,	$0A		; $017B	Wallchange (sprite) uses Solitaire graphics
org $D4D8EE : db	$01,	$5B,	$4E, $05,	$04,	$04		; $017D	SleepX (bg1), Starlight (extra) uses Fenrir graphics
org $D4D91E : db	$14,	$A9,	$EA, $03,	$06,	$0A		; $0185	Starlight (sprite) uses Ice 1 graphics
org $D4D960 : db	$81,	$0D,	$1B, $05,	$04,	$04		; $0190	Happy Jump (short delay) (extra) uses Kirin graphics
org $D4DA2C : db	$01,	$00,	$BD, $03,	$02,	$04		; $01B2	Merton (sprite) uses Doom graphics
org $D4DAF8 : db	$8B,	$2C,	$24, $00,	$04,	$04		; $01D4	Tempest (sprite) uses Horizontal Slash graphics
org $D4DAFE : db	$02,	$DD,	$83, $0F,	$03,	$02		; $01D5	Tempest (bg1) uses custom graphics
org $D4DB58 : db	$05,	$D7,	$F2, $08,	$02,	$02		; $01E4	Good Boy (sprite) uses Takedown graphics
org $D4DB5E : db	$01,	$31,	$85, $0F,	$01,	$01		; $01E5	Good Boy (bg1) uses custom graphics
org $D4DBD0 : db	$02,	$E3,	$CE, $05,	$01,	$01		; $01F8	Scroll Throw (sprite) uses custom graphics
org $D4DBDC : db	$02,	$E3,	$CE, $05,	$01,	$01		; $01FA	Fade Scroll (sprite) uses custom graphics (same as Scroll Throw (sprite))
org $D4DC5A : db	$0C,	$76,	$0C, $07,	$02,	$02		; $020F	Phantasm (sprite) uses Chokesmoke graphics
org $D4DCBA : db	$4C,	$0C,	$37, $0A,	$01,	$0A		; $021F	Solitaire (sprite) uses custom graphics
org $D4DDE6 : db	$1D,	$18,	$DF, $07,	$10,	$0A		; $0251	Hurricane (Shoat) (sprite) uses Quasar graphics

; #########################################################################
; Frame Data Pointers for Custom Graphics
; #########################################################################
;
; Base Offset:		$D4DF3C
; Address:			( Frame_Data_Index * 2 ) + Offset
;
;					Frame    Frame    Frame
;	Pointer Add.	$00      $01      $02      Etc.							  ID_#	Description
org $D4E1DA : db	$FF,$08													; $0054	Mana Battery (bg1)
org $D4E1DC : db	$01,$09													; $0055	Defibrillator (bg1)
org $D4E334 : db	$71,$13, $79,$13, $81,$13, $89,$13, $91,$13				; $008E Throw, Knife (sprite)
			  db	$99,$13, $A1,$13, $A9,$13, $B1,$13, $B3,$13
org $D4EACC : db	$0F,$7A, $11,$7A										; $013F Wombat (sprite)
org $D4EB46 : db	$C1,$7B, $8A,$E9										; $014A Go Fish (bg1)
org $D4EB84 : db	$D1,$80, $D3,$80, $D5,$80, $D7,$80, $D9,$80				; $0151 Meerkat (bg1)
org $D4EAD8 : db	$33,$7A, $35,$7A										; $01F8 Scroll Throw (sprite), Fade Scroll (sprite)
org $D4F3AA : db	$FB,$D5, $FD,$D5, $05,$D6, $13,$D6, $25,$D6, $39,$D6	; $021F Solitaire (sprite)
			  db	$49,$D6, $53,$D6, $59,$D6, $5D,$D6, $61,$D6, $65,$D6
org $D4FE26 : db	$94,$E9, $9C,$E9										; $013D Cockatrice (sprite)
org $D4FE2A : db	$A6,$E9, $AA,$E9, $AE,$E9, $B2,$E9						; $0141 Jackrabbit (sprite)
org $D4FE32 : db	$B8,$E9, $BA,$E9, $BC,$E9, $BE,$E9, $C0,$E9, $C2,$E9	; $0057 Jackpot (sprite)
			  db	$C4,$E9, $C6,$E9
org $D4FE42 : db	$CA,$E9, $D6,$E9										; $01D5 Tempest (bg1)
org $D4FE46 : db	$E0,$E9 												; $01E5 Good Boy (bg1)
org $D4FE48 : db	$E4,$E9, $E6,$E9, $E8,$E9								; $000C Shuriken (sprite)
org $D4FF94 : db	$EC,$E9, $F4,$E9, $FC,$E9								; $000D Ninja Star (sprite)
org $D4FF9A : db	$06,$EA, $08,$EA, $0A,$EA, $10,$EA, $12,$EA				; $0015 Disc Hit (sprite)

; #########################################################################
; Weapon Animation Data
; #########################################################################
;
; These eight bytes determine the following characteristics for weapon animations:
;
;	Byte 1:	Animation # (Right Hand)
;	Byte 2:	Animation # (Left Hand)
;	Byte 3:	Weapon Palette
;	Byte 4:	Animation # (Target Hit Animation)
;	Byte 5:	Target Hit Palette
;	Byte 6:	Special 1
;	Byte 7:	Sound
;	Byte 8:	Special 2

org $ECE408
	db $26,$26,$1B,$3E,$3D,$00,$94,$00	; Healing Shiv
	db $26,$26,$18,$3E,$36,$00,$94,$00	; Dirk
	db $1C,$1C,$27,$02,$34,$00,$94,$00	; Kagenui
	db $26,$26,$19,$3E,$3D,$00,$94,$00	; Butterfly
	db $26,$26,$26,$3E,$36,$00,$94,$00	; Switchblade
	db $27,$27,$21,$3E,$34,$00,$94,$00	; Demonsbane
	db $27,$27,$19,$3E,$3D,$00,$94,$00	; Man Eater
	db $26,$26,$2A,$3E,$36,$00,$94,$00	; Kunai
	db $5A,$5A,$18,$3E,$32,$00,$94,$00	; Avenger
	db $5A,$5A,$28,$05,$34,$00,$94,$00	; Valiance
	db $5B,$5B,$18,$01,$36,$00,$A4,$00	; Sabre
	db $2B,$2B,$18,$01,$36,$00,$A4,$00	; Iron Cutlass
	db $5B,$5B,$20,$01,$37,$00,$A4,$00	; Scimitar
	db $2A,$2A,$29,$03,$34,$00,$A4,$00	; Flametongue
	db $2A,$2A,$22,$03,$32,$00,$A4,$00	; Icebrand
	db $2A,$2A,$20,$03,$37,$00,$A4,$00	; Elec Sword
	db $00,$00,$00,$00,$00,$00,$00,$00	; -
	db $00,$00,$00,$00,$00,$00,$00,$00	; -
	db $1F,$1F,$29,$03,$34,$00,$A4,$00	; Blood Sword
	db $29,$29,$28,$01,$34,$00,$A4,$00	; Imperial
	db $23,$23,$21,$01,$38,$00,$A4,$00	; Rune Blade
	db $5B,$5B,$18,$01,$36,$00,$A4,$00	; Falchion
	db $1F,$1F,$1A,$03,$40,$00,$A4,$00	; Soul Sabre
	db $00,$00,$00,$00,$00,$00,$00,$00	; -
	db $1E,$1E,$20,$00,$37,$00,$A4,$00	; Excalibur
	db $61,$61,$2B,$05,$36,$00,$A4,$00	; Zantetsuken
	db $5C,$5C,$1A,$00,$32,$00,$A4,$00	; Illumina
	db $5C,$5C,$29,$00,$35,$00,$A4,$00	; Apocalypse
	db $36,$36,$1F,$00,$78,$04,$A4,$00	; Atma Weapon
	db $2D,$2D,$2A,$3E,$36,$00,$A8,$00	; Mythril Pike
	db $60,$60,$1A,$3D,$33,$00,$A8,$00	; Trident
	db $2D,$2D,$18,$3E,$36,$00,$A8,$00	; Stout Spear
	db $2E,$2E,$18,$05,$36,$00,$A8,$00	; Partisan
	db $5D,$5D,$2B,$05,$33,$00,$A8,$00	; Longinus
	db $2D,$2D,$29,$05,$34,$00,$A8,$00	; Fire Lance
	db $2C,$2C,$20,$05,$37,$00,$A8,$00	; Gungnir (has custom graphics data)
	db $60,$60,$1D,$05,$32,$00,$A8,$00	; Pointy Stick
	db $22,$21,$18,$3E,$36,$00,$94,$00	; Tanto
	db $26,$26,$2A,$3E,$36,$00,$94,$00	; Kunai
	db $22,$21,$29,$02,$35,$00,$94,$00	; Sakura
	db $1C,$1C,$18,$01,$36,$00,$94,$00	; Ninjato
	db $1C,$1C,$27,$02,$34,$00,$94,$00	; Kagenui
	db $22,$21,$5C,$3E,$31,$00,$94,$00	; Orochi
	db $1D,$1D,$03,$06,$36,$00,$2E,$00	; Hanzo
	db $1D,$1D,$18,$06,$36,$00,$2E,$00	; Kotetsu
	db $1D,$1D,$21,$01,$38,$00,$2E,$00	; Ichimonji
	db $1D,$1D,$22,$02,$32,$00,$2E,$00	; Kazekiri
	db $1D,$1D,$28,$06,$34,$00,$2E,$00	; Murasame
	db $1D,$1D,$20,$00,$37,$00,$2E,$00	; Masamune
	db $00,$00,$00,$00,$00,$00,$00,$00	; Spoon
	db $1D,$1D,$1A,$02,$33,$00,$2E,$00	; Mutsunokami
	db $5F,$5F,$1F,$08,$36,$00,$8C,$00	; Spook Stick
	db $28,$28,$1A,$09,$4E,$00,$8C,$00	; Magus Rod
	db $28,$28,$2D,$09,$34,$00,$8C,$00	; Fire Rod
	db $28,$28,$2C,$09,$33,$00,$8C,$00	; Ice Rod
	db $28,$28,$25,$09,$37,$00,$8C,$00	; Thunder Rod
	db $5F,$5F,$2C,$08,$32,$00,$8C,$00	; Windbreaker
	db $5F,$5F,$20,$08,$76,$00,$8C,$00	; Doomstick
	db $5F,$5F,$21,$08,$9A,$00,$8C,$00	; Quartrstaff
	db $28,$28,$1C,$09,$30,$00,$8C,$00	; Punisher
	db $00,$00,$00,$00,$00,$00,$00,$00	; -
	db $16,$16,$25,$04,$38,$00,$AF,$00	; Light Brush
	db $16,$16,$19,$04,$30,$00,$AF,$00	; Monet Brush
	db $16,$16,$1A,$04,$32,$00,$AF,$00	; Dali Brush
	db $16,$16,$29,$04,$34,$00,$AF,$00	; Ross Brush
	db $2F,$2F,$18,$0C,$18,$81,$5B,$00	; Shuriken
	db $00,$00,$00,$00,$00,$00,$00,$00	; -
	db $30,$30,$18,$0D,$18,$81,$5B,$00	; Ninja Star
	db $20,$20,$20,$08,$36,$00,$33,$00	; Club
	db $15,$15,$1C,$34,$1C,$82,$28,$00	; Full Moon
	db $19,$19,$19,$08,$36,$00,$33,$00	; Morning Star
	db $0F,$0F,$18,$35,$18,$82,$56,$00	; Boomerang
	db $15,$15,$24,$34,$24,$82,$28,$00	; Rising Sun
	db $1A,$1A,$19,$06,$36,$00,$2E,$00	; Kusarigama (has custom graphics/animation data)
	db $20,$20,$26,$08,$36,$00,$33,$00	; Bone Club
	db $20,$20,$1A,$08,$36,$00,$33,$00	; Magic Bone
	db $0F,$0F,$22,$35,$36,$82,$56,$00	; Wing Edge
	db $10,$10,$18,$0A,$36,$81,$5B,$00	; -
	db $13,$13,$18,$0B,$36,$81,$5B,$00	; Darts
	db $11,$11,$19,$0A,$36,$81,$5B,$00	; Tarot
	db $14,$14,$19,$0B,$36,$81,$5B,$00	; Viper Darts
	db $12,$12,$1E,$0B,$36,$81,$5B,$00	; Dice (has custom graphics data)
	db $12,$12,$D3,$0B,$36,$81,$5B,$00	; Fixed Dice (has custom graphics data)
	db $5E,$5E,$18,$3D,$36,$00,$8B,$00	; Mythril Claw
	db $31,$31,$2A,$07,$36,$00,$8B,$00	; Light Claw
	db $33,$32,$19,$07,$31,$00,$8B,$00	; Poison Claw
	db $33,$32,$18,$07,$33,$00,$8B,$00	; Ocean Claw
	db $33,$32,$28,$3D,$34,$00,$8B,$00	; Hell Claw
	db $5E,$5E,$1A,$3D,$33,$00,$8B,$00	; Frostgore
	db $31,$31,$20,$07,$37,$00,$8B,$00	; Stormfang

; #########################################################################
; Animation Scripts
; #########################################################################

; [ Animation Script $0154: Break (sprite) ]

org $D03DFF
	db $00,$20				; speed 1, align to center of character/monster
	db $E8,$30,$00			; move in polar coordinates (48,0)
	db $EB					; jump based on thread
	db $0D,$3E,$17,$3E		
	db $21,$3E,$3D,$3E		
	db $D1,$01				; invalidate character/monster sprite priority
	db $C9,$00				; play default sound effect
	db $1F					; [---]
	db $1F					; [---]
	db $1F					; [---]
	db $E8,$00,$80			; move in polar coordinates (0,-128)
	db $89,$77				; loop start (119 times)
	db $83,$C0				; move up 1
	db $E8,$00,$FA			; move in polar coordinates (0,-6)
	db $00					; [$00]
	db $8A					; loop end
	db $FF					; end of script
	db $89,$77				; loop start (119 times)
	db $87,$C0				; move target up 1
	db $1F					; [---]
	db $8A					; loop end
	db $89,$0E				; loop start (14 times)
	db $87,$27				; move target down 8
	db $1F					; [---]
	db $8A					; loop end
	db $C9,$60				; play sound effect $60
	db $89,$07				; loop start (7 times)
	db $D6,$02,$01			; scroll background to (2,1)
	db $1F					; [---]
	db $D6,$FE,$FF			; scroll background to (-2,-1)
	db $1F					; [---]
	db $8A					; loop end
	db $D6,$00,$00			; scroll background to (0,0)
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 8d spare bytes
	db $FE,$FE,$FE			

; [ Animation Script $00E4: Holy (sprite) ] (Code modified from original)

org $D018BD
	db $89,$07				; loop start (7 times)
org $D018E5
	db $89,$50				; loop start (80 times)
	db $EF,$00,$06			; move in flattened polar coordinates (0,6)
	db $83,$21				; move down 2
org $D018F9
	db $89,$01				; loop start (1 times)

; [ Animation Script $00E5: Holy (bg1) ] (Code modified from original)

org $D0190A
	db $8B,$07				; animated loop start (7 times, increment frame offset each time)
org $D01910
	db $8B,$07				; animated loop start (7 times, increment frame offset each time)
	db $00					; [$00]
	db $B5,$E4				; increase background color addition by 4 (white)
org $D01918
	db $89,$10				; loop start (16 times)
	db $0F					; [$0F]
	db $8A					; loop end
	db $89,$1F				; loop start (31 times)

; [ Animation Script $00E6: Holy (bg3) ] (Code modified from original)

org $D0193C
	db $89,$03				; loop start (3 times)
	db $B6,$C4				; increase background color subtraction by 4 (blue)
org $D01942
	db $89,$10				; loop start (16 times)
	db $B4,$F2				; decrease bg3 animation palette color subtraction by 2 (black)
org $D0194A
	db $89,$70				; loop start (112 times)

; [ Animation Script $00D7: Flare (sprite) ]

org $D0571A
	db $00,$20				; speed 1, align to center of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $EB					; jump based on thread ($57AB, $572F, $576E, $572F, $576E, $576D, $576D, $576D)
	db $79,$57,$2F,$57		
	db $54,$57,$2F,$57		
	db $54,$57,$53,$57		
	db $53,$57,$53,$57		
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $89,$1F				; loop start (31 times)
	db $1F					; [---]
	db $8A					; loop end
	db $83,$BF				; move up/forward 32
	db $89,$07				; loop start (7 times)
	db $E9,$3F,$3F			; move animation randomly (0..63,0..63)
	db $06					; [$06]
	db $07					; [$07]
	db $08					; [$08]
	db $09					; [$09]
	db $0A					; [$0A]
	db $0B					; [$0B]
	db $0C					; [$0C]
	db $0D					; [$0D]
	db $0E					; [$0E]
	db $8A					; loop end
	db $FF					; end of script
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $89,$1F				; loop start (31 times)
	db $1F					; [---]
	db $8A					; loop end
	db $83,$AF				; move up/forward 16
	db $89,$07				; loop start (7 times)
	db $E9,$1F,$1F			; move animation randomly (0..31,0..31)
	db $06					; [$06]
	db $07					; [$07]
	db $08					; [$08]
	db $09					; [$09]
	db $0A					; [$0A]
	db $0B					; [$0B]
	db $0C					; [$0C]
	db $0D					; [$0D]
	db $0E					; [$0E]
	db $8A					; loop end
	db $FF					; end of script
	db $C9,$31				; play sound effect $31
	db $AF,$40				; set background color subtraction to 0 (purple)
	db $89,$08				; loop start (8 times)
	db $B6,$41				; increase background color subtraction by 1 (purple)
	db $1F					; [---]
	db $1F					; [---]
	db $B6,$C1				; increase background color subtraction by 1 (blue)
	db $1F					; [---]
	db $1F					; [---]
	db $8A					; loop end
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $BF,$BA,$57			; jump to subroutine $57A2
	db $C9,$89				; play sound effect $89
	db $80,$2A,$73			; load animation palette $73, sprite
	db $84,$02				; set animation speed to 3
	db $80,$17				; update sprite layer priority based on target
	db $EC,$01				; change thread layer to bg1
	db $8B,$0D				; animated loop start (13 times, increment frame offset each time)
	db $80,$3B				; change target's color palette to animation palette
	db $00					; [$00]
	db $80,$3C				; restore target's color palette
	db $00					; [$00]
	db $8C					; animated loop end
	db $84,$01				; set animation speed to 2
	db $89,$20				; loop start (32 times)
	db $0F					; [$0F]
	db $8A					; loop end
	db $89,$08				; loop start (8 times)
	db $B6,$51				; decrease background color subtraction by 1 (purple)
	db $B6,$D1				; decrease background color subtraction by 1 (blue)
	db $0F					; [$0F]
	db $8A					; loop end
	db $FF					; end of script
	db $80,$11				; choose random polar angle
	db $E8,$B0,$00			; move in polar coordinates (-80,0)
	db $89,$02				; loop start (2 times)
	db $E8,$F8,$00			; move in polar coordinates (-8,0)
	db $05					; [$05]
	db $8A					; loop end
	db $89,$02				; loop start (2 times)
	db $E8,$F8,$00			; move in polar coordinates (-8,0)
	db $04					; [$04]
	db $8A					; loop end
	db $89,$02				; loop start (2 times)
	db $E8,$F8,$00			; move in polar coordinates (-8,0)
	db $03					; [$03]
	db $8A					; loop end
	db $89,$03				; loop start (3 times)
	db $E8,$F8,$00			; move in polar coordinates (-8,0)
	db $02					; [$02]
	db $8A					; loop end
	db $89,$03				; loop start (3 times)
	db $E8,$F8,$00			; move in polar coordinates (-8,0)
	db $01					; [$01]
	db $8A					; loop end
	db $89,$04				; loop start (4 times)
	db $E8,$F8,$00			; move in polar coordinates (-8,0)
	db $00					; [$00]
	db $8A					; loop end
	db $C0					; return from subroutine

; [ Animation Script $00E3: Dark (bg1) ]

org $D058C4
	db $00,$20				; speed 1, align to center of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $C9,$00				; play default sound effect
	db $DD,$00,$00,$63,$00	; init triangle with diameter 99
	db $DF					; move triangle to target position
	db $DC					; update triangle 2d
	db $00					; [$00]
	db $BD,$A0				; hide bg1 thread
	db $89,$20				; loop start (32 times)
	db $E0,$00,$00,$FD,$06	; move triangle (+0,+0) and change diameter by -3, rotate +6 units
	db $DC					; update triangle 2d
	db $B6,$E1				; increase background color subtraction by 1 (black)
	db $00					; [$00]
	db $8A					; loop end
	db $DD,$00,$00,$00,$00	; init triangle
	db $DC					; update triangle 2d
	db $C9,$1C				; play sound effect $1C
	db $89,$04				; loop start (4 times)
	db $B6,$F8				; decrease background color subtraction by 5 (black)
	db $0F					; [$0F]
	db $8A					; loop end
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 5d spare bytes

; [ Animation Script $01B2: Merton (bg1) ]

org $D0161B
	db $00,$40				; speed 1, align to top of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $90,$20				; set animation tile priority to 2
	db $85					; move to attacker position
	db $83,$CF				; move up 16
	db $83,$83				; move back 4
	db $CC,$FF				; set bg1 animation palette color subtraction to 31 (black)
	db $89,$10				; loop start (16 times)
	db $CF,$F1				; decrease bg1 animation palette color subtraction by 1 (black)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$60				; loop start (96 times)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$10				; loop start (16 times)
	db $CF,$E1				; increase bg1 animation palette color subtraction by 1 (black)
	db $00					; [$00]
	db $8A					; loop end
	db $FF					; end of script

; [ Animation Script $017D: SleepX (bg1), Starlight (extra) ]

org $D0362D
	db $00,$20				; speed 1, align to center of character/monster
	db $80,$2E,$80,$10		; move to (128,16)
	db $90,$00				; set animation tile priority to 0
	db $AF,$E0				; set background color subtraction to 0 (black)
	db $CC,$FF				; set bg1 animation palette color subtraction to 31 (black)
	db $89,$07				; loop start (7 times)
	db $B6,$E1				; increase background color subtraction by 1 (black)
	db $CF,$F1				; decrease bg1 animation palette color subtraction by 1 (black)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$18				; loop start (24 times)
	db $CF,$F1				; decrease bg1 animation palette color subtraction by 1 (black)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$30				; loop start (48 times)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$1F				; loop start (31 times)
	db $CF,$E1				; increase bg1 animation palette color subtraction by 1 (black)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$07				; loop start (7 times)
	db $B6,$F1				; decrease background color subtraction by 1 (black)
	db $8A					; loop end
	db $FF					; end of script

; [ Animation Script $017A: SleepX (sprite) ]

org $D03657
	db $00,$20				; speed 1, align to center of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $83,$CF				; move up 16
	db $EB,$66,$36,$50,$1A	; jump based on thread ($3666, $1A50, $1A4E, $3668) (two threads to original Sleep code)
	db $4E,$1A,$68,$36		
	db $C9,$00				; play default sound effect
	db $FF					; end of script	

; [ Animation Script $00D5: Safe (bg1) ] (Code modified from original)

org $D01A75
	db $C9,$00				; play default sound effect

; [ Animation Script $00A9: Safe (sprite) ] (Code modified from original)

org $D01A8C
	db $D1,$01				; invalidate character/monster sprite priority

; [ Animation Script $009D: Restore (sprite) ] (Code modified from original)

org $D0656E
	db $8B,$0E				; animated loop start (14 times, increment frame offset each time)

; [ Animation Script $009E: Restore (bg1) ] (Code modified from original)

org $D0658D
	db $A6,$00,$EF,$00		; move circle (+0,-16)
	db $89,$0C				; loop start (12 times)
org $D065A0
	db $89,$18				; loop start (24 times)	
	
; [ Animation Script $0224: Cure 3 (sprite) ]

org $D011A9
	db $D1,$01				; invalidate character/monster sprite priority (padding)
org $D011B2
	db $D1,$01				; invalidate character/monster sprite priority (padding)
org $D011BB
	db $D1,$01				; invalidate character/monster sprite priority (padding)
org $D011C4
	db $D1,$01				; invalidate character/monster sprite priority (padding)

; [ Animation Script $0157: RegenX (bg1) ]

org $D06189
	db $20,$20				; speed 3, align to center of character/monster
	db $89,$05				; loop start (5 times)
	db $B5,$61				; increase background color addition by 1 (cyan)
	db $0F					; [$0F]
	db $8A					; loop end
	db $89,$30				; loop start (48 times)
	db $0F					; [$0F]
	db $8A					; loop end
	db $89,$05				; loop start (5 times)
	db $B5,$71				; decrease background color addition by 1 (cyan)
	db $0F					; [$0F]
	db $8A					; loop end
	db $FF					; end of script
	db $FE					; 1d spare byte

; [ Animation Script $00A5: Defibrillator (sprite) ]

org $D0610A
	db $00,$00				; speed 1, align to bottom of character/monster
	db $89,$10				; loop start (16 times)
	db $1F					; [---]
	db $8A					; loop end
	db $81,$07,$07			; change attacker graphic to 7 (jumping)
	db $E7					; calculate vector from attacking character to target
	db $1F					; [---]
	db $E5,$02,$03,$18		; move character forward along vector at speed 2 and height 24, branch back
	db $81,$44,$44			; change attacker graphic to 20 (kneeling)
	db $86,$E5				; move attacker up/back 6
	db $85					; move to attacker position
	db $83,$6F				; move forward 16
	db $83,$C3				; move up 4
	db $C2,$80				; unpause bg1 thread
	db $89,$38				; loop start (56 times)
	db $1F					; [---]
	db $8A					; loop end
	db $81,$16,$16			; change attacker graphic to 22 (hurt)
	db $B0,$FF				; set background color addition to 31 (white)
	db $89,$01				; loop start (1 times)
	db $C9,$00				; play default sound effect
	db $00					; [$00]
	db $01					; [$01]
	db $B5,$F3				; decrease background color addition by 3 (white)
	db $80,$3B				; change target's color palette to animation palette
	db $02					; [$02]
	db $03					; [$03]
	db $B5,$F3				; decrease background color addition by 3 (white)
	db $04					; [$04]
	db $05					; [$05]
	db $B5,$F3				; decrease background color addition by 3 (white)
	db $80,$3C				; restore target's color palette
	db $06					; [$06]
	db $07					; [$07]
	db $B5,$F3				; decrease background color addition by 3 (white)
	db $80,$3B				; change target's color palette to animation palette
	db $08					; [$08]
	db $09					; [$09]
	db $B5,$F3				; decrease background color addition by 3 (white)
	db $0A					; [$0A]
	db $0B					; [$0B]
	db $B5,$F3				; decrease background color addition by 3 (white)
	db $80,$3C				; restore target's color palette
	db $8A					; loop end
	db $86,$05				; move attacker down/forward 6
	db $1F					; [---]
	db $E6,$02,$03,$18		; move character backward along vector at speed 2 and height 24, branch to $7980
	db $81,$14,$14			; change attacker graphic to 20 (kneeling)
	db $87,$63				; move target forward 3
	db $89,$0A				; loop start (10 times)
	db $1F					; [---]
	db $8A					; loop end
	db $87,$83				; move target back 3
	db $89,$0A				; loop start (10 times)
	db $1F					; [---]
	db $8A					; loop end
	db $87,$63				; move target forward 3
	db $89,$0A				; loop start (10 times)
	db $1F					; [---]
	db $8A					; loop end
	db $87,$83				; move target back 3
	db $81,$00,$00			; change attacker graphic to 0 (no action)
	db $89,$0A				; loop start (10 times)
	db $1F					; [---]
	db $8A					; loop end
	db $87,$63				; move target forward 3
	db $89,$0A				; loop start (10 times)
	db $1F					; [---]
	db $8A					; loop end
	db $87,$83				; move target back 3
	db $FF					; end of script

; [ Animation Script $00A6: Defibrillator (extra) ]

org $D06181
	db $00,$00				; speed 1, align to center of character/monster
	db $DB,$03				; branch to 3 bytes forward if character already stepped forward to attack
	db $BF,$19,$70			; jump to subroutine $7019
	db $FF					; end of script

; [ Animation Script $004B: AutoCrossbow (bg1) ] (Code modified from original)

org $D077F1
	db $80,$69				; update sprite layer priority based on attacker

; [ Animation Script $004E: NoiseBlaster (extra) ] (Code modified from original)

org $D07883
	db $83,$C7				; move up 8

; [ Animation Script $0055: Defibrillator (bg1) ]

org $D036AD
	db $00,$00				; speed 1, align to bottom of character/monster
	db $1F					; [---]
	db $1F					; [---]
	db $1F					; [---]
	db $80,$4F				; move to attacking character position
	db $F3,$CC,$36,$BF,$36	; Jump based on current attacker index (needed because Edgar gets misaligned by 1 pixel otherwise)
	db $BF,$36,$CA,$36,$CC	
	db $36					
	db $F0,$CA,$36,$CA,$36	; Jump based on current target index
	db $CC,$36,$CC,$36,$CC	
	db $36					
	db $83,$20				; move down 1
	db $83,$27				; move down 8
	db $D4,$00,$00,$00		; add fixed color to (no layers)
	db $80,$69				; update sprite layer priority based on attacker
	db $EE,$30				; set target sprite tile priority to 2
	db $89,$35				; loop start (53 times)
	db $00					; [$00]
	db $8A					; loop end
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 21d spare bytes
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE					

; [ Animation Script $0053: Mana Battery (sprite) ]

org $D07629
	db $00,$20				; speed 1, align to center of character/monster
	db $89,$08				; loop start (8 times)
	db $1F					; [---]
	db $8A					; loop end
	db $BF,$50,$76			; jump to subroutine $7650
	db $BF,$50,$76			; jump to subroutine $7650
	db $BF,$50,$76			; jump to subroutine $7650
	db $BF,$50,$76			; jump to subroutine $7650
	db $BF,$50,$76			; jump to subroutine $7650
	db $89,$10				; loop start (16 times)
	db $1F					; [---]
	db $8A					; loop end
	db $83,$AF				; move up/forward 16
	db $84,$04				; set animation speed to5
	db $89,$01				; loop start (1 times)
	db $E9,$1F,$1F			; move animation randomly (0..31,0..31)
	db $05					; [$05]
	db $06					; [$06]
	db $07					; [$07]
	db $8A					; loop end
	db $FF					; end of script
	db $80,$11				; choose random polar angle
	db $E8,$80,$00			; move in polar coordinates (-128,0)
	db $89,$02				; loop start (2 times)
	db $E8,$F8,$04			; move in polar coordinates (-8,4)
	db $04					; [$04]
	db $8A					; loop end
	db $89,$02				; loop start (2 times)
	db $E8,$F8,$04			; move in polar coordinates (-8,4)
	db $03					; [$03]
	db $8A					; loop end
	db $89,$02				; loop start (2 times)
	db $E8,$F8,$04			; move in polar coordinates (-8,4)
	db $02					; [$02]
	db $8A					; loop end
	db $89,$02				; loop start (2 times)
	db $E8,$F8,$04			; move in polar coordinates (-8,4)
	db $01					; [$01]
	db $8A					; loop end
	db $C0					; return from subroutine

; [ Animation Script $0054: Mana Battery (bg1) ]

org $D07672
	db $00,$20				; speed 1, align to center of character/monster
	db $DB,$03				; branch to forward 3 bytes if character already stepped forward to attack
	db $BF,$19,$70			; jump to subroutine $7019
	db $80,$69				; update sprite layer priority based on attacker
	db $81,$15,$15			; change attacker graphic to 21 (ready)
	db $85					; move to attacker position
	db $83,$81				; move back 2
	db $83,$25				; move down 6
	db $C9,$00				; play default sound
	db $89,$48				; loop start (72 times)
	db $00					; [$00]
	db $8A					; loop end
	db $C9,$7D				; play $7D sound
	db $89,$48				; loop start (72 times)
	db $00					; [$00]
	db $8A					; loop end
	db $81,$00,$00			; change attacker graphic to 0 (no action)
	db $FF					; end of script

; [ Animation Script $0052: Flash (sprite) ] (Code modified from original)

org $D07847
	db $81,$11,$11			; change attacker graphic to 11 (standing)
	db $83,$A7				; move up/forward 8
	db $83,$C1				; move up 2
	db $89,$10				; loop start (16 times)
	db $00					; [$00]
	db $8A					; loop end
	db $B0,$FF				; set background color addition to 31 (white)

; [ Animation Script $0049: Bio Blaster (sprite) ] (Code modified from original)

org $D07917
	db $81,$11,$11			; change attacker graphic to 11 (standing)
	db $83,$6A				; move forward 11
	db $83,$CC				; move up 13

; [ Animation Script $0051: Chain Saw 2 (sprite) ] (Code modified from original)

org $D0792E
	db $81,$11,$11			; change attacker graphic to 11 (standing)
	db $85					; move to attacker position
	db $83,$25				; move down 6

; [ Animation Script $004F: Drill (sprite) ] (Code modified from original)

org $D07941
	db $81,$11,$11			; change attacker graphic to 11 (standing)
org $D0798A
	db $81,$11,$11			; change attacker graphic to 11 (standing)

; [ Animation Script $01FD: X-Potion, X-Ether (sprite) ] (Code modified from original)

org $D02258
	db $1F,$1F,$1F,$1F		; Initializing code updated to only use 2 threads instead of 4 threads.

; [ Animation Script $01FC: Potion, Ether (sprite) ] (Code modified from original)

org $D02276
	db $1F,$1F				; Deleted 'set animation tile priority to 0' to create opaque bubbles

; [ Animation Script $0206: Elixir (sprite), Megalixir (sprite) ]

org $D021CB
	db $00,$20				; speed 1, align to center of character/monster
	db $90,$00				; set animation tile priority to 0
	db $80,$16				; command $80/$16
	db $EB,$DA,$21,$F1,$21	; jump based on thread ($21DA, $2205, $2214, $2214)
	db $F0,$21,$F0,$21		
	db $C9,$00				; play default sound effect
	db $EF,$28,$00			; move in flattened polar coordinates (40,0)
	db $89,$40				; loop start (64 times)
	db $EF,$00,$FC			; move in flattened polar coordinates (0,-4)
	db $80,$21				; update sprite layer priority based on polar movement angle
	db $98,$04,$08			; increment frame offset every 4 loops (0..8)
	db $80,$65				; change rainbow palette
	db $00					; [$00]
	db $8A					; loop end
	db $BF,$81,$35			; play subroutine $3581 (Happy Jump)
	db $FF					; end of script
	db $EF,$28,$80			; move in flattened polar coordinates (40,-128)
	db $89,$40				; loop start (64 times)
	db $EF,$00,$FC			; move in flattened polar coordinates (0,-4)
	db $80,$21				; update sprite layer priority based on polar movement angle
	db $98,$04,$08			; increment frame offset every 4 loops (0..8)
	db $00					; [$00]
	db $8A					; loop end
	db $FF					; end of script

; [ Animation Script $011D: Sonic Dive (sprite) ] (Continuation of animation script)

org $D02201
	db $89,$3F				; loop start (63 times)
	db $86,$83				; move attacker back 4
	db $86,$20				; move attacker down 1
	db $8A					; loop end
	db $1F					; [---]
	db $A1,$05,$03			; jump backwards along vector at speed 5, branch back 3 bytes
	db $80,$29,$00			; show cursor sprites (esper attack)
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 5d spare bytes

; [ Animation Script $0186: Restore (extra), Remedy (extra) ]

org $D0761C
	db $00,$00				; speed 1, align to bottom of character/monster
	db $89,$60				; loop 96 times
	db $1F					; [---]
	db $8A					; end loop
	db $BF,$81,$35			; play subroutine $3581
	db $FF					; end script
	db $FE,$FE,$FE			; 3d spare bytes
	
; [ Animation Script $0190: Snake Oil (extra), Group Hug (sprite), Heal Horn (sprite) ]

org $D07612
	db $00,$00				; speed 1, align to bottom of character/monster
	db $89,$20				; loop 32 times
	db $1F					; [---]
	db $8A					; end loop
	db $BF,$81,$35			; play subroutine $3581
	db $FF					; end script

; The following subroutine plays whenever a character has all or most of their status effects cured.
; 
; Ability/Item				Method of Implementation
; Restore					Animation 4 added ($0186 with high bit enabled) which plays the subroutine after a long delay.
; Remedy 					Animation 4 added ($0186 with high bit enabled) which plays the subroutine after a long delay.
; Snake Oil					Animation 4 added ($0190 with high bit enabled) which plays the subroutine after a short delay.
; Heal Horn (Unicorn)		Animation 1 changed ($0190) which plays the subroutine after a short delay.
; Group Hug (Starlet)		Animation 1 changed ($0190) which plays the subroutine after a short delay.
; Tapir						Animation 1 script ($0145) now includes a jump to the subroutine.
; Raccoon					Animation 1 script ($0145) now includes a jump to the subroutine.
; Harvester					Animation 1 script ($0128) now includes a jump to the subroutine.
; Megalixir					Animation 1 script ($0206) now includes a jump to the subroutine.
; Elixir					Animation 1 script ($0206) now includes a jump to the subroutine.
;
; [ Subroutine $D03581 : Happy Jump (used by all status curing effects) ]

org $D03581
	db $84,$01				; set animation speed to 2
	db $F0,$8E,$35,$8E,$35	; skip routine if target is a monster
	db $8E,$35,$8E,$35		
	db $D3,$35				
	db $D1,$01				; invalidate character/monster sprite priority
	db $82,$07,$07			; forward jump animation
	db $89,$04				; loop 4 times
	db $87,$C2				; move up 3
	db $82,$07,$07			; forward jump animation
	db $1F					; [---]
	db $8A					; end loop
	db $89,$04				; loop 4 times
	db $87,$C1				; move up 2
	db $82,$18,$18			; up jump animation
	db $1F					; [---]
	db $8A					; end loop
	db $89,$02				; loop 2 times
	db $87,$C0				; move up 1
	db $82,$37,$37			; backward jump animation
	db $1F					; [---]
	db $8A					; end loop
	db $89,$02				; loop 2 times
	db $87,$20				; move down 1
	db $82,$37,$37			; backward jump animation
	db $1F					; [---]
	db $8A					; end loop
	db $89,$04				; loop 4 times
	db $87,$21				; move down 2
	db $82,$17,$17			; down jump animation
	db $1F					; [---]
	db $8A					; end loop
	db $89,$04				; loop 4 times
	db $87,$22				; move down 3
	db $82,$07,$07			; forward jump animation
	db $1F					; [---]
	db $8A					; end loop
	db $89,$18				; loop 24 times
	db $82,$15,$15			; ready animation
	db $1F					; [---]
	db $8A					; end loop
	db $82,$00,$00			; target graphic to no action
	db $C0					; return from subroutine
	db $FE,$FE,$FE,$FE,$FE	; 6d spare bytes
	db $FE					

; [ Animation Script $00F4: Earth Rage (Terrato) (bg3) ] (Code modified from original)

org $D053EA
	db $80,$2C,$EA			; load animation palette $EA (bg3)

; [ Animation Script $00F5: Earth Rage (Terrato) (sprite) ] (Code modified from original)

org $D05432
	db $AF,$E0				; set background color subtraction to 0 (black)
org $D05438
	db $B6,$E1				; increase background color subtraction by 1 (black)
org $D05444
	db $B6,$F2				; decrease background color subtraction by 2 (black)

; [ Animation Script $0252: Hurricane (Shoat) (sprite) ] (Code modified from original)

org $D0547B
	db $89,$B0				; loop start (176 times)

; [ Animation Script $0251: Hurricane (Shoat) (bg1) ]

org $D05489
	db $00,$20				; speed 1, align to center of character/monster
	db $BD,$A0				; hide bg1 thread
	db $80,$2E,$80,$4C		; move to (128,76)
	db $89,$50				; loop start (80 times)
	db $1F					; [---]
	db $8A					; loop end
	db $BD,$80				; show bg1 thread
	db $84,$02				; set animation speed to 3
	db $BF,$AC,$54			; jump to subroutine $54AC
	db $BF,$AC,$54			; jump to subroutine $54AC
	db $BF,$AC,$54			; jump to subroutine $54AC
	db $BF,$AC,$54			; jump to subroutine $54AC
	db $BF,$AC,$54			; jump to subroutine $54AC
	db $BF,$AC,$54			; jump to subroutine $54AC
	db $FF					; end of script
	db $8B,$09				; animated loop start (9 times, increment frame offset each time)
	db $83,$61				; move forward 2
	db $00					; [$00]
	db $8C					; animated loop end
	db $C0					; end of subroutine



; [ Animation Script $021A: Jihad (Crusader) (bg1) ] (Code modified from original)

org $D012BC
	db $80,$42,$00			; disable bg1 mirroring (mode 7)
org $D012C7
	db $83,$C2				; move up 3
org $D012CC
	db $80,$42,$01			; mirror bg1 horizontal (mode 7)
org $D012D7
	db $83,$C2				; move up 3
org $D012E1
	db $D0,$00				; set tile priority to 0 for all character/monster sprites
org $D012F1
	db $80,$41,$FC,$FC		; zoom bg1 (-4,-4), move bg1 (5,2)
	db $05,$02				

; [ Animation Script $0219: Jihad (Crusader) (sprite) ]

org $D0138F
	db $00,$20				; speed 1, align to center of character/monster
	db $80,$32,$97,$13		; jump to $12BC (left) or $12BC (right)
	db $9E,$13				
	db $80,$2E,$1C,$3C		; move to (28,60)
	db $FA,$A2,$13			; jump to $12D9
	db $80,$2E,$E2,$3C		; move to (226,60)
	db $89,$27				; loop start (39 times)
	db $1F					; [---]
	db $8A					; loop end
	db $80,$26,$01			; disable character palette updates
	db $EB					; jump based on thread ($13A4, $13C5, $13F9)
	db $B0,$13,$D4,$13		
	db $D4,$13				
	db $EF,$7F,$00			; flatten polar movement (127,0)
	db $EF,$39,$2A			; flatten polar movement (57,-48)
	db $EF,$00,$FF			; flatten polar movement (0,-1)
	db $89,$08				; loop start (8 times)
	db $01					; [$01]
	db $1F					; [---]
	db $8A					; loop end
	db $89,$28				; loop start (40 times)
	db $01					; [$01]
	db $8A					; loop end
	db $89,$30				; loop start (48 times)
	db $EF,$00,$FE			; flatten polar movement (0,-2)
	db $01					; [$01]
	db $8A					; loop end
	db $89,$39				; loop start (57 times)
	db $01					; [$01]
	db $8A					; loop end
	db $89,$22				; loop start (34 times)
	db $EF,$00,$FE			; flatten polar movement (0,-2)
	db $01					; [$01]
	db $8A					; loop end
	db $FF					; end script

; [ Animation Script $0058: Solitaire (bg1) ]

org $D054B3
	db 	$00,$00				; speed 0, align to bottom of character/monster
	db 	$FA,$3F,$1B			; jump to $1B3F (wallchange)

; [ Animation Script $01EC: Oblivion (Ragnarok) (sprite) ]

org $D02533
	db $00,$40				; speed 1, align to top of character/monster
	db $89,$04				; loop start (4 times)
	db $83,$DF				; move up 32
	db $8A					; loop end
	db $89,$0C				; loop start (12 times)
	db $83,$2B				; move down 12
	db $00					; [$00]
	db $8A					; loop end
	db $C9,$2E				; play sound effect $2E
	db $89,$20				; loop start (32 times)
	db $01					; [$01]
	db $8A					; loop end
	db $C9,$00				; play default sound effect
	db $89,$34				; loop start (52 times)
	db $01					; [$01]
	db $8A					; loop end
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 18d unused bytes
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE			

; [ Animation Script $01ED: Oblivion (Ragnarok) (bg3) ]

org $D0255F
	db $00,$20				; speed 1, align to center of character/monster
	db $83,$24				; move down 5
	db $89,$0D				; loop start (13 times)
	db $09					; [$09]
	db $8A					; loop end
	db $84,$03				; set animation speed to 4
	db $89,$02				; loop start (3 times)
	db $00					; [$00]
	db $01					; [$01]
	db $02					; [$02]
	db $03					; [$03]
	db $04					; [$04]
	db $05					; [$05]
	db $06					; [$06]
	db $07					; [$07]
	db $8A					; loop end
	db $FF					; end of script				

; [ Animation Script $018F: Aqualung, Boil (bg1) ]

org $D02575
	db $40,$20				; speed 5, align to center of character/monster
	db $80,$2E,$80,$50		; move to (128,80)
	db $D0,$20				; set tile priority to 2 for all character/monster sprites
	db $C9,$00				; play default sound effect
	db $8B,$0E				; animated loop start (14 times, increment frame offset each time)
	db $00					; [$00]
	db $8C					; animated loop end
	db $8B,$0E				; animated loop start (14 times, increment frame offset each time)
	db $00					; [$00]
	db $8C					; animated loop end
	db $FF					; end of script
	db $FE,$FE				; 2d spare bytes

; [ Animation Script $01EE: Oblivion (Ragnarok) (bg1) ]

org $D0258A
	db $00,$20				; speed 1, align to center of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $BD,$A0				; hide bg1 thread
	db $89,$07				; loop start (7 times)
	db $B6,$61				; increase background color subtraction by 1 (red)
	db $0F					; [$0F]
	db $8A					; loop end
	db $89,$54				; loop start (84 times)
	db $0F					; [$0F]
	db $8A					; loop end
	db $B0,$FF				; set background animation palette color addition to 31 (white)
	db $B2,$FF				; set sprite animation palette color addition to 31 (white)
	db $BA,$FF				; set monster color addition to 31 (white)
	db $89,$1F				; loop start (31 times)
	db $B5,$F1				; decrease background animation palette color addition by 1 (white)
	db $BB,$F1				; decrease monster animation palette color addition by 1 (white)
	db $0F					; [$0F]
	db $0F					; [$0F]
	db $8A					; loop end
	db $89,$07				; loop start (7 times)
	db $B6,$71				; decrease background color subtraction by 1 (red)
	db $0F					; [$0F]
	db $8A					; loop end
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 7d unused bytes
	db $FE,$FE
	
; [ Animation Script $01D4: Tempest (sprite) ]

org $D07288
	db $00,$20				; speed 1, align to center of character/monster
	db $C5,$93,$72,$A2,$72	; jump based on swdtech hit
	db $A2,$72,$A6,$72		
	db $80,$02				; command $80/$02
	db $C9,$46				; play sound effect $46
	db $C8,$09				; change attacker action to 9 (casting)
	db $89,$10				; loop start (16 times)
	db $E1,$01				; show attacking character sprite
	db $1F					; [---]
	db $E1,$00				; hide attacking character sprite
	db $1F					; [---]
	db $8A					; loop end
	db $BF,$BC,$72			; jump to subroutine ($72BC)
	db $FF					; end of script
	db $BF,$BC,$72			; jump to subroutine ($72BC)
	db $89,$08				; loop start (8 times)
	db $1F					; [---]
	db $8A					; loop end
	db $C9,$46				; play sound effect $46
	db $89,$10				; loop start (16 times)
	db $E1,$00				; hide attacking character sprite
	db $1F					; [---]
	db $E1,$01				; show attacking character sprite
	db $1F					; [---]
	db $8A					; loop end
	db $82,$00,$00			; change target graphic to 0 (no action)
	db $FF					; end of script
	db $C2,$80				; unpause bg1 thread
	db $89,$08				; loop start (8 times)
	db $1F					; [---]
	db $8A					; loop end
	db $C9,$00				; play default sound effect
	db $B0,$6B				; set background color addition to 11 (cyan)
	db $8B,$0B				; animated loop start (11 times, increment frame offset each time)
	db $00					; [$00]
	db $B5,$71				; decrease background color addition by 1 (cyan)
	db $8C					; animated loop end
	db $C0					; return from subroutine

; [ Animation Script $01D5: Tempest (bg1) ]

org $D0737C
	db $00,$20				; speed 1, align to center of character/monster
	db $CC,$FF				; set bg1 animation palette color subtraction to 31 (black)
	db $83,$9F				; move back 32
	db $83,$9F				; move back 32
	db $89,$08				; loop start (8 times)
	db $01					; [$01]
	db $83,$65				; move forward 6
	db $CF,$F3				; decrease bg1 animation palette color subtraction by 3 (black)
	db $8A					; loop end
	db $89,$04				; loop start (4 times)
	db $00					; [$00]
	db $83,$65				; move forward 6
	db $87,$63				; move target forward 4
	db $00					; [$00]
	db $83,$65				; move forward 6
	db $87,$83				; move target back 4
	db $8A					; loop end
	db $89,$08				; loop start (8 times)
	db $00					; [$00]
	db $83,$65				; move forward 6
	db $CF,$E3				; increase bg1 animation palette color subtraction by 3 (black)
	db $8A					; loop end
	db $FF					; end of script

; [ Animation Script $006B: Fire Dance (bg1), Boil (bg3) ] (Code modified from original)

org $D06D7F
	db $BD,$50				; hide bg3 thread

; [ Animation Script $006F: Bum Rush (sprite) ] (Code modified from original)

org $D06C7E
	db $B5,$E1				; increase background color addition by 1 (white)
org $D06C87
	db $B5,$E1				; increase background color addition by 1 (white)
org $D06C95
	db $B5,$F1				; decrease background color addition by 1 (white)
org $D06C9E
	db $B5,$F1				; decrease background color addition by 1 (white)

; [ Animation Script $013D: Cockatrice (sprite) ]

org $D04198
	db $00,$20				; speed 1, align to center of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $89,$04				; loop start (4 times)
	db $83,$FF				; move up/back 32
	db $8A					; loop end
	db $89,$27				; loop start (39 times)
	db $83,$03				; move down/forward 4
	db $00					; [$00]
	db $8A					; loop end
	db $83,$BF				; move up/forward 32
	db $E8,$58,$20			; move in polar coordinates (85,32)
	db $89,$0A				; loop start (10 times)
	db $E8,$00,$FA			; move in polar coordinates (0,-6)
	db $00					; [$00]
	db $8A					; loop end
	db $84,$03				; set animation speed to 4
	db $89,$0C				; loop start (12 times)
	db $83,$A4				; move up/forward 5
	db $00					; [$00]
	db $83,$A4				; move up/forward 5
	db $01					; [$01]
	db $8A					; loop end
	db $FF					; end of script

; [ Animation Script $013E: Cockatrice (bg1) ]

org $D04084
	db $00,$00				; speed 1, align to center of character/monster
	db $C9,$5B				; play dive sound effect
	db $89,$23				; loop start (35 times)
	db $0F					; [$0F]
	db $8A					; loop end
	db $C9,$00				; play default sound effect
	db $84,$03				; set animation speed to 4
	db $8B,$07				; animated loop start (7 times, increment frame offset each time)
	db $00					; [$00]
	db $8C					; animated loop end
	db $C9,$56				; play boomerang sound effect
	db $FF					; end of script
	db $FE,$FE				; 2d spare bytes

; [ Animation Script $013F: Wombat (sprite) ] (Code modified from original)

org $D04131
	db $83,$63				; move forward 4
	db $83,$C4				; move up 5
	db $87,$61				; move target forward 2
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $83,$C3				; move up 4
	db $87,$81				; move target back 2
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $83,$C2				; move up 3
	db $87,$61				; move target forward 2
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $83,$C1				; move up 2
	db $87,$81				; move target back 2
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $83,$21				; move down 2
	db $87,$61				; move target forward 2
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $83,$21				; move down 2
	db $87,$81				; move target back 2
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $83,$21				; move down 2
	db $87,$61				; move target forward 2
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $83,$22				; move down 3
	db $87,$81				; move target back 2
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $83,$23				; move down 4
	db $87,$61				; move target forward 2
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $83,$24				; move down 5
	db $87,$81				; move target back 2
	db $00					; [$00]
	db $89,$3A				; loop start (58 times)
	db $83,$63				; move forward 4
	db $98,$04,$02			; increment frame offset every 4 loops (0..2)
	db $00					; [$00]
	db $8A					; loop end
	db $FF					; end of script

; [ Animation Script $0151: Meerkat (bg1) ]

org $D03F5F
	db $20,$20				; speed 3, align to center of character/monster
	db $D4,$00,$00,$00		; add fixed color to (no layers)
	db $D1,$01				; invalidate character/monster sprite priority
	db $90,$20				; set animation tile priority to 2
	db $85					; move to attacker position
	db $83,$7F				; move forward 32
	db $83,$67				; move forward 8
	db $00					; [$00]
	db $00					; [$00]
	db $00					; [$00]
	db $00					; [$00]
	db $01					; [$01]
	db $02					; [$02]
	db $03					; [$03]
	db $04					; [$04]
	db $89,$30				; loop start (48 times)
	db $04					; [$04]
	db $8A					; loop end
	db $C9,$55				; play sound effect $55
	db $04					; [$04]
	db $03					; [$03]
	db $02					; [$02]
	db $01					; [$01]
	db $00					; [$00]
	db $00					; [$00]
	db $00					; [$00]
	db $00					; [$00]
	db $FF					; end of script

; [ Animation Script $0150: Refract, Blink, Meerkat (sprite) ]

org $D03FCC
	db $30,$20				; speed 4, align to center of character/monster
	db $C9,$00				; play default sound effect
	db $8B,$05				; animated loop start (5 times, increment frame offset each time)
	db $05					; play frame #
	db $8C					; end animated loop
	db $C9,$5C				; play Reflect sound effect
	db $00					; play frame #
	db $01					; play frame #
	db $02					; play frame #
	db $03					; play frame #
	db $C9,$5C				; play Reflect sound effect
	db $03					; play frame #
	db $02					; play frame #
	db $01					; play frame #
	db $00					; play frame #
	db $FF					; end of script

; [ Animation Script $0145: Tapir (sprite), Raccoon (sprite) ] (Code modified from original)

org $D040E6
	db $EB,$EF,$40,$F6,$40	; jump based on thread ($40EF, $40F6, $40FF, $410C)
	db $FF,$40,$0C,$41		
org $D0410B
	db $FF					; end of script
	db $BF,$81,$35			; play subroutine $3581
	db $FF					; end of script

; [ Animation Script $0141: Jackrabbit (sprite) ]

org $D03D31
	db $00,$20				; speed 1, align to center of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $89,$04				; loop start (4 times)
	db $83,$DF				; move up 32
	db $8A					; loop end
	db $C9,$00				; play default sound effect
	db $89,$40				; loop start (64 times)
	db $1F					; [---]
	db $8A					; loop end
	db $89,$20				; loop start (32 times)
	db $02					; [$02]
	db $83,$23				; move down 4
	db $8A					; loop end
	db $80,$72,$13			; branch to forward x bytes if attack hit
	db $89,$10				; loop start (16 times)
	db $02					; [$02]
	db $83,$23				; move down 4
	db $8A					; loop end
	db $81,$1C,$1C			; change attacker graphic to 28 (surprised)
	db $89,$10				; loop start (16 times)
	db $02					; [$02]
	db $83,$23				; move down 4
	db $8A					; loop end
	db $81,$00,$00			; change attacker graphic to 0 (no action)
	db $FF					; end script
	db $C9,$F0				; play loud bang sound
	db $AD,$06				; set bg1 hdma scroll type to 6
	db $AC,$84,$47			; set (bg1) hdma scroll data (amplitude 7, frequency 4, horizontal)
	db $89,$10				; loop start (16 times)
	db $AE,$44				; update (bg1) hdma scroll data (horizontal)
	db $03					; [$03]
	db $D6,$02,$01			; scroll background to (2,1)
	db $03					; [$03]
	db $D6,$FE,$FF			; scroll background to (-2,-1)
	db $8A					; loop end
	db $AC,$84,$45			; set (bg1) hdma scroll data (amplitude 5, frequency 4, horizontal)
	db $AE,$44				; update (bg1) hdma scroll data (horizontal)
	db $03					; [$03]
	db $03					; [$03]
	db $03					; [$03]
	db $03					; [$03]
	db $AC,$84,$43			; set (bg1) hdma scroll data (amplitude 3, frequency 4, horizontal)
	db $AE,$44				; update (bg1) hdma scroll data (horizontal)
	db $03					; [$03]
	db $03					; [$03]
	db $03					; [$03]
	db $03					; [$03]
	db $AC,$84,$41			; set (bg1) hdma scroll data (amplitude 1, frequency 4, horizontal)
	db $AE,$44				; update (bg1) hdma scroll data (horizontal)
	db $03					; [$03]
	db $03					; [$03]
	db $03					; [$03]
	db $03					; [$03]
	db $80,$25				; clear bg1 hdma scroll data
	db $AD,$03				; set bg1 hdma scroll type to 3
	db $89,$06				; loop start (6 times)
	db $00					; [$00]
	db $00					; [$00]
	db $00					; [$00]
	db $00					; [$00]
	db $01					; [$01]
	db $00					; [$01]
	db $01					; [$01]
	db $00					; [$01]
	db $8A					; loop end
	db $C9,$6A				; play sproing sound
	db $89,$20				; loop start (32 times)
	db $03					; [$03]
	db $83,$C3				; move up 4
	db $8A					; loop end
	db $FF					; end script
	db $FE,$FE				; 2d spare bytes

; [ Animation Script $014E: Raccoon (bg1, extra) ]

org $D03F85
	db $20,$20				; speed 3, align to center of character/monster
	db $D4,$00,$00,$00		; add fixed color to (no layers)
	db $C9,$00				; play default sound effect
	db $80,$2E,$20,$37		; move to (32,55)
	db $80,$32				; jump facing left or facing right
	db $9B,$3F,$97,$3F		
	db $80,$2E,$82,$37		; move to (130,55)
	db $CC,$F4				; set bg1 animation palette color subtraction to 20 (black)
	db $89,$04				; loop start (2 times)
	db $CF,$F5				; decrease bg1 animation palette color subtraction by 5 (black)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$02				; loop start (2 times)
	db $83,$E3				; move up/back 4
	db $00					; [$00]
	db $83,$83				; move back 4
	db $01					; [$01]
	db $83,$43				; move down/back 4
	db $00					; [$00]
	db $83,$83				; move back 4
	db $01					; [$01]
	db $8A					; loop end
	db $89,$16				; loop start (22 times)
	db $02					; [$02]
	db $8A					; loop end
	db $89,$03				; loop start (3 times)
	db $83,$E3				; move up/back 4
	db $00					; [$00]
	db $83,$83				; move back 4
	db $01					; [$01]
	db $83,$43				; move down/back 4
	db $00					; [$00]
	db $83,$83				; move back 4
	db $01					; [$01]
	db $8A					; loop end
	db $89,$04				; loop start (4 times)
	db $CF,$E5				; increase bg1 animation palette color subtraction by 5 (black)
	db $00					; [$00]
	db $8A					; loop end
	db $FF					; end of script

; [ Animation Script $0147: Toxic Frog (sprite) ]

org $D04077
	db $30,$00				; speed 4, align to bottom of character/monster
	db $89,$0B				; loop start (11 times)
	db $1F					; [---]
	db $8A					; loop end
	db $C9,$00				; play default sound effect
	db $8B,$1A				; animated loop start (26 times, increment frame offset each time)
	db $00					; [$00]
	db $8C					; animated loop end
	db $FF					; end of script

; [ Animation Script $0146: Toxic Frog (bg1) ]

org $D03FE1
	db $00,$00				; speed 1, align to bottom of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $D4,$00,$00,$00		; add fixed color to (no layers)
	db $89,$06				; loop start (6 times)
	db $83,$9B				; move back 28
	db $8A					; loop end
	db $BF,$0D,$40			; jump to subroutine $400D
	db $BF,$0D,$40			; jump to subroutine $400D
	db $BF,$0D,$40			; jump to subroutine $400D
	db $89,$08				; loop start (8 times)
	db $00					; [$00]
	db $00					; [$00]
	db $00					; [$00]
	db $01					; [$01]
	db $01					; [$01]
	db $01					; [$01]
	db $02					; [$02]
	db $02					; [$02]
	db $02					; [$02]
	db $8A					; loop end
	db $BF,$0D,$40			; jump to subroutine $400D
	db $BF,$0D,$40			; jump to subroutine $400D
	db $BF,$0D,$40			; jump to subroutine $400D
	db $FF					; end script
	db $C9,$CA				; play sound effect $CA
	db $89,$0F				; loop start (15 times)
	db $83,$63				; move forward 4
	db $80,$61,$40,$08,$80	; command $80/$61
	db $00					; [$00]
	db $8A					; loop end
	db $C0					; return from subroutine
	db $FE					; 1d spare byte

; [ Animation Script $0148: Snowbird (sprite) ]

org $D04031
	db $40,$20				; speed 5, align to center of character/monster
	db $89,$10				; loop start (16 times)
	db $1F					; [---]
	db $8A					; loop end
	db $FA,$89,$21			; jump to pheonix down code
	db $FF					; end of script

; [ Animation Script $0149: Snowbird (bg1) ]

org $D0403B
	db $40,$20				; speed 5, align to center of character/monster
	db $D4,$00,$00,$00		; add fixed color to (no layers)
	db $90,$20				; set animation tile priority to 2
	db $80,$2E,$7F,$00		; move to (127,0)
	db $83,$9F				; move back 32
	db $83,$9F				; move back 32
	db $EF,$7F,$7F			; flatten polar movement (127,127)
	db $EF,$20,$40			; flatten polar movement (32,64)
	db $BF,$6A,$40			; jump to subroutine
	db $C9,$00				; play default sound effect
	db $08					; [$08]
	db $09					; [$09]
	db $08					; [$08]
	db $09					; [$09]
	db $08					; [$08]
	db $09					; [$09]
	db $C9,$00				; play default sound effect
	db $08					; [$08]
	db $09					; [$09]
	db $08					; [$08]
	db $09					; [$09]
	db $08					; [$08]
	db $09					; [$09]
	db $BF,$6A,$40			; jump to subroutine
	db $C9,$7D				; play cure sound effect
	db $FF					; end of script
	db $89,$08				; loop start (8 times)
	db $08					; [$08]
	db $EF,$00,$04			; flatten polar movement (0,4)
	db $09					; [$09]
	db $EF,$00,$04			; flatten polar movement (0,4)
	db $8A					; loop end
	db $C0					; return from subroutine
	db $FE					; 1d spare bytes

; [ Animation Script $021B: Trifecta (sprite) ]

org $D01C1B
	db $00,$00				; speed 1, align to bottom of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $C9,$00				; play default sound effect
	db $83,$24				; move down 5
	db $EB					; jump based on thread
	db $32,$1C,$2A,$1C		
	db $30,$1C				
	db $83,$CC				; move up 13
	db $F4,$01				; show sprite behind character/monster sprites
	db $83,$6F				; move forward 16
	db $83,$9F				; move back 32
	db $89,$07				; loop start (7 times)
	db $83,$9F				; move back 32
	db $8A					; loop end
	db $89,$3F				; loop start (63 times)
	db $83,$63				; move forward 4
	db $98,$02,$03			; increment frame offset every 2 loops (0..3)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$07				; loop start (7 times)
	db $83,$63				; move forward 4
	db $98,$02,$03			; increment frame offset every 2 loops (0..3)
	db $87,$62				; move target forward 3
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $87,$82				; move target back 3
	db $00					; [$00]
	db $8A					; loop end
	db $89,$2F				; loop start (47 times)
	db $83,$63				; move forward 4
	db $98,$02,$03			; increment frame offset every 2 loops (0..3)
	db $00					; [$00]
	db $8A					; loop end
	db $C9,$D9				; play wark sound effect
	db $FF					; end of script

; [ Animation Script $0057: Jackpot (sprite) ]

org $D075E2
	db $00,$20				; speed 1, align to center of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $89,$04				; loop start (4 times)
	db $83,$DF				; move up 32
	db $8A					; loop end
	db $EB,$F4,$75,$F7,$75	; jump based on thread
	db $F9,$75,$FB,$75		
	db $C9,$00				; play default sound effect
	db $FF					; end of script
	db $83,$E7				; move up/back 8
	db $83,$C7				; move up 8
	db $89,$22				; loop start (34 times)
	db $83,$23				; move down 4
	db $00					; [$00]
	db $8A					; loop end
	db $89,$08				; loop start (8 times)
	db $83,$21				; move down 2
	db $00					; [$00]
	db $8A					; loop end
	db $84,$03				; set animation speed to 4
	db $8B,$08				; animated loop start (8 times, increment frame offset each time)
	db $83,$20				; move down 1
	db $00					; [$00]
	db $8C					; animated loop end
	db $C9,$7D				; play various healing sound effect
	db $FF					; end of script

; [ Animation Script $0128: Harvester (sprite) ]

org $D04882
	db $00,$20				; speed 1, align to center of character/monster
	db $89,$20				; loop start (32 times)
	db $1F					; [---]
	db $8A					; loop end
	db $EB,$14,$76,$44,$3F	; jump to Cure 2 code or to animation $190 based on thread
	db $49,$3F,$52,$3F		
	db $FE,$FE,$FE,$FE,$FE	; 6d spare bytes
	db $FE					

; [ Animation Script $012D: Harvester, Moonlight (bg3) ] (Code modified from original)

org $D048A5
	db $89,$10				; loop start (16 times)
org $D048AD
	db $89,$90				; loop start (144 times)

; [ Animation Script $0129: Harvester, Moonlight (bg1) ] (Code modified from original)

org $D048DF
	db $89,$6F				; loop start (111 times)

; [ Animation Script $0056: Moonlight (extra) ]

org $D07693
	db $20,$20				; speed 3, align to center of character/monster
	db $AF,$E0				; set background color subtraction to 0 (black)
	db $89,$07				; loop start (7 times)
	db $B6,$E1				; increase background color subtraction by 1 (black)
	db $1F					; [---]
	db $8A					; loop end
	db $F0					; jump based on target
	db $B7,$76,$B7,$76		
	db $B7,$76,$B7,$76		
	db $A8,$76				
	db $89,$1C				; loop start (28 times)
	db $BB,$E1				; increase monster color addition by 1 (white)
	db $1F					; [---]
	db $8A					; loop end
	db $89,$1C				; loop start (28 times)
	db $BB,$F1				; decrease monster color addition by 1 (white)
	db $1F					; [---]
	db $8A					; loop end
	db $FA,$C9,$76			; jump
	db $80,$26,$01			; disable character palette updates
	db $89,$1C				; loop start (28 times)
	db $FD,$E1				; increase character color addition by 1 (white)
	db $1F					; [---]
	db $8A					; loop end
	db $89,$1C				; loop start (28 times)
	db $FD,$F1				; decrease character color addition by 1 (white)
	db $1F					; [---]
	db $8A					; loop end
	db $80,$26,$00			; enable character palette updates
	db $89,$07				; loop start (7 times)
	db $B6,$F1				; decrease background color subtraction by 1 (black)
	db $8A					; loop end
	db $FF					; end of script

; [ Animation Script $0131: Bedevil (sprite) ]

org $D046F4
	db $00,$80				; speed 1, initial position 80
	db $85					; move to attacker position
	db $E7					; calculate vector from attacking character to target
	db $81,$07,$07			; change attacker graphic to 7 (jumping)
	db $1F					; [---]
	db $E5,$08,$03,$18		; move character forward along vector at speed 8 and height 24, branch back 4 bytes
	db $BF,$15,$47			; jump to subroutine
	db $BF,$15,$47			; jump to subroutine
	db $BF,$15,$47			; jump to subroutine
	db $81,$37,$37			; change attacker graphic to 7 (jumping)
	db $1F					; [---]
	db $E6,$08,$03,$18		; move character backward along vector at speed 8 and height 24, branch back 4 bytes
	db $81,$00,$00			; change attacker graphic to 0 (no action)
	db $FF					; end of script
	db $81,$1E,$1E			; change attacker graphic to finger wag 1
	db $89,$10				; loop start (16 times)
	db $1F					; [---]
	db $8A					; loop end
	db $81,$1F,$1F			; change attacker graphic to finger wag 2
	db $89,$10				; loop start (16 times)
	db $1F					; [---]
	db $8A					; loop end
	db $C0					; return from subroutine
	db $FE					; 1d spare byte

; [ Animation Script $0155: Blaze, Raze (sprite) ]

org $D03E46
	db $00,$20				; speed 1, align to center of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $90,$00				; set animation tile priority to 0
	db $EB					; jump based on thread
	db $57,$3E,$55,$3E		
	db $57,$3E,$62,$3E		
	db $F4,$01				; show sprite behind character/monster sprites
	db $C9,$00				; play default sound effect
	db $BF,$63,$3E			; jump to subroutine $3E63
	db $BF,$63,$3E			; jump to subroutine $3E63
	db $BF,$63,$3E			; jump to subroutine $3E63
	db $FF					; end of script
	db $E9,$08,$10			; move animation randomly (0..8,0..16)
	db $83,$9F				; move back 32
	db $8B,$07				; animated loop start (7 times, increment frame offset each time)
	db $83,$67				; move forward 8
	db $00					; [$00]
	db $00					; [$00]
	db $00					; [$00]
	db $8C					; animated loop end
	db $83,$9F				; move back 20
	db $C0					; return from subroutine

; [ Animation Script $0175: Safeguard (bg1) ]

org $D0144A
	db $00,$20				; speed 1, align to center of character/monster
	db $C9,$00				; play default sound effect
	db $85					; move to attacker position
	db $E8,$40,$00			; move in polar coordinates (64,0)
	db $CC,$FF				; set bg1 animation palette color subtraction to 31 (black)
	db $89,$36				; loop start (54 times)
	db $A4,$17,$33			; shift colors (1..8) of bg1 animation/esper palette right (3 loops per shift)
	db $E8,$00,$04			; move in polar coordinates (0,4)
	db $CF,$F4				; decrease bg1 animation palette color subtraction by 4 (black)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$08				; loop start (8 times)
	db $A4,$17,$33			; shift colors (1..8) of bg1 animation/esper palette right (3 loops per shift)
	db $E8,$00,$04			; move in polar coordinates (0,4)
	db $CF,$E4				; increase bg1 animation palette color subtraction by 4 (black)
	db $00					; [$00]
	db $8A					; loop end
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 6d spare bytes
	db $FE					

; [ Animation Script $014B: Meltdown (sprite) ]

org $D03E73
	db $40,$00				; speed 5, align to bottom of character/monster
	db $89,$04				; loop start (5 times)
	db $1F					; [---]
	db $8A					; loop end
	db $82,$16,$16			; change target graphic to 22 (hit)
	db $89,$0F				; loop start (15 times)
	db $1F					; [---]
	db $8A					; loop end
	db $80,$27,$01			; hide character sprites
	db $83,$67				; move forward 8
	db $89,$18				; loop start (24 times)
	db $00					; [$00]
	db $8A					; loop end
	db $01					; [$01]
	db $02					; [$02]
	db $03					; [$03]
	db $04					; [$04]
	db $83,$87				; move back 8
	db $05					; [$05]
	db $06					; [$06]
	db $07					; [$07]
	db $08					; [$08]
	db $09					; [$09]
	db $0A					; [$0A]
	db $89,$18				; loop start (24 times)
	db $1F					; [---]
	db $8A					; loop end
	db $82,$00,$00			; change target graphic to 0 (no action)
	db $84,$01				; set animation speed to 2
	db $BF,$E7,$54			; jump to subroutine $54E7
	db $FF					; end of script

; [ Animation Script $014C: Meltdown (extra) ]

org $D03EA2
	db $00,$00				; speed 1, align to bottom of character/monster
	db $89,$07				; loop start (7 times)
	db $B6,$E1				; increase background color subtraction by 1 (black)
	db $1F					; [---]
	db $8A					; loop end
	db $89,$60				; loop start (96 times)
	db $1F					; [---]
	db $8A					; loop end
	db $B0,$FF				; set background animation palette color addition to 31 (white)
	db $B2,$FF				; set sprite animation palette color addition to 31 (white)
	db $C9,$50				; play sound effect $50
	db $89,$50				; loop start (80 times)
	db $1F					; [---]
	db $8A					; loop end
	db $89,$20				; loop start (32 times)
	db $B5,$F1				; decrease bg1 animation palette color addition by 1 (white)
	db $B7,$F1				; decrease sprite animation palette color addition by 1 (white)
	db $1F					; [---]
	db $8A					; loop end
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 27d spare bytes
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE				

; [ Animation Script $0176: Schiller (sprite) ]

org $D03803
	db $00,$20				; speed 1, align to center of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $C9,$00				; play default sound effect
	db $89,$0F				; loop start (15 times)
	db $B5,$82				; increase background color addition by 2 (red)
	db $B5,$41				; increase background color addition by 1 (green)
	db $1F					; [---]
	db $8A					; loop end
	db $89,$1F				; loop start (15 times)
	db $B5,$91				; decrease background color addition by 1 (red)
	db $1F					; [---]
	db $B5,$91				; decrease background color addition by 1 (red)
	db $B5,$51				; decrease background color addition by 1 (green)
	db $1F					; [---]
	db $8A					; loop end
	db $FF					; end script
	db $FE,$FE,$FE,$FE,$FE	; 5d spare bytes

; [ Animation Script $0185: Starlight (sprite) ]

org $D013F7
	db $10,$00				; speed 2, align to bottom of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $89,$07				; loop start (7 times)
	db $1F					; [---]
	db $8A					; loop end
	db $EC,$01				; change thread layer to bg1
	db $C9,$18				; play sound effect $18
	db $05					; [$05]
	db $04					; [$04]
	db $03					; [$03]
	db $02					; [$02]
	db $80,$3B				; change target's color palette to animation palette
	db $01					; [$01]
	db $00					; [$00]
	db $80,$3C				; restore target's color palette
	db $00					; [$00]
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 12d spare bytes
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE				

; [ Animation Script $0275: Net Hit (bg1) ] (Code modified from original)

org $D0055F
	db $03					; [$03]
	db $03					; [$03]
	db $02					; [$02]
	db $01					; [$01]
	db $00					; [$00]
	db $FF					; end of script
	db $FE,$FE				; 2d spare bytes

; [ Animation Script $0167: Volt Array (sprite) ]

org $D03A53
	db $30,$A0				; speed 4, align to center of screen
	db $D1,$01				; invalidate character/monster sprite priority
	db $80,$2E,$80,$50		; move to (128,80)
	db $83,$88				; move back 9
	db $00					; [$00]
	db $01					; [$01]
	db $02					; [$02]
	db $03					; [$03]
	db $89,$1E				; loop start (30 times)
	db $03					; [$03]
	db $8A					; loop end
	db $03					; [$03]
	db $02					; [$02]
	db $01					; [$01]
	db $00					; [$00]
	db $FF					; end of script
	db $FE,$FE,$FE			; 3d spare bytes

; [ Animation Script $0168: Volt Array (bg1) ]

org $D03A6D
	db $00,$A0				; speed 1, align to center of screen
	db $80,$2E,$80,$4A		; move to (128,74)
	db $C9,$00				; play default sound effect
	db $CC,$FF				; set bg1 animation palette color subtraction to 31 (black)
	db $89,$0F				; loop start (15 times)
	db $CF,$F1				; decrease bg1 animation palette color subtraction by 1 (black)
	db $00					; [$00]
	db $BD,$A0				; hide bg1 thread
	db $8A					; loop end
	db $BD,$80				; show bg1 thread
	db $84,$04				; set animation speed to 5
	db $8B,$0B				; animated loop start (11 times, increment frame offset each time)
	db $00					; [$00]
	db $8C					; animated loop end
	db $8B,$0B				; animated loop start (11 times, increment frame offset each time)
	db $00					; [$00]
	db $8C					; animated loop end
	db $84,$01				; set animation speed to 2
	db $89,$0F				; loop start (15 times)
	db $CF,$E1				; increase bg1 animation palette color subtraction by 1 (black)
	db $0B					; [$0B]
	db $BD,$A0				; hide bg1 thread
	db $8A					; loop end
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 5d spare bytes

; [ Animation Script $0140: Discharge (bg3) ]

org $D04181
	db $20,$20				; speed 3, align to center of character/monster
	db $C4,$40				; move bg3 thread to this thread's position
	db $89,$18				; loop start (24 times)
	db $09					; [$09]
	db $8A					; loop end
	db $AB,$FF				; set bg3 animation palette color addition to 31 (white)
	db $8B,$08				; animated loop start (8 times, increment frame offset each time)
	db $B3,$F4				; decrease bg3 animation palette color addition by 4 (white)
	db $00					; [$00]
	db $8C					; animated loop end
	db $8B,$08				; animated loop start (8 times, increment frame offset each time)
	db $00					; [$00]
	db $8C					; animated loop end
	db $FF					; end of script
	db $FE,$FE				; 2d spare bytes

; [ Animation Script $00B7: Barrier (bg1) ] (Code modified from original)

org $D05E8F
	db $E0,$00,$00,$01,$08	; move triangle (+0,+0) and change diameter by +1, rotate +8 units
org $D05E9C
	db $E0,$00,$00,$FF,$08	; move triangle (+0,+0) and change diameter by -1, rotate +8 units

; [ Animation Script $0220: Solitaire, Wallchange (bg1) ] (Code modified from original)

org $D01B3D
	db $10,$00				; speed 2, align to bottom of character/monster

; [ Animation Script $017B: Wallchange (sprite) ]

org $D072CD
	db $10,$A0				; speed 2, align to center of screen
	db $90,$00				; set animation tile priority to 0
	db $F4,$01				; show sprite behind character/monster sprites
	db $80,$2E,$6A,$15		; move to (106,21)
	db $EB,$E0,$72,$E2,$72	; jump based on thread
	db $E4,$72,$E6,$72		
	db $83,$0F				; move down/forward 16
	db $83,$0F				; move down/forward 16
	db $83,$0F				; move down/forward 16
	db $C9,$00				; play default sound effect
	db $0B					; [$0B]
	db $0A					; [$0A]
	db $09					; [$09]
	db $08					; [$08]
	db $07					; [$07]
	db $06					; [$06]
	db $06					; [$06]
	db $06					; [$06]
	db $EB,$F9,$72,$FD,$72	; jump based on thread
	db $01,$73,$05,$73		
	db $89,$07				; loop start (7 times)
	db $06					; [$06]
	db $8A					; loop end
	db $89,$07				; loop start (7 times)
	db $06					; [$06]
	db $8A					; loop end
	db $89,$07				; loop start (7 times)
	db $06					; [$06]
	db $8A					; loop end
	db $EB,$0E,$73,$61,$73	; jump based on thread
	db $35,$73,$52,$73		
	db $89,$08				; loop start (8 times)
	db $83,$80				; move back 1
	db $06					; [$06]
	db $8A					; loop end
	db $89,$2F				; loop start (47 times)
	db $83,$E0				; move up/back 1
	db $06					; [$06]
	db $8A					; loop end
	db $89,$08				; loop start (8 times)
	db $83,$60				; move forward 1
	db $06					; [$06]
	db $8A					; loop end
	db $C9,$9F				; play sound effect $9F
	db $B2,$FF				; set sprite animation palette color addition to 31 (white)
	db $BA,$FF				; set monster color addition to 31 (white)
	db $89,$10				; loop start (16 times)
	db $B7,$F2				; decrease sprite animation palette color addition by 2 (white)
	db $BB,$F2				; decrease monster color addition by 2 (white)
	db $06					; [$06]
	db $8A					; loop end
	db $89,$10				; loop start (16 times)
	db $B8,$E2				; increase sprite animation palette color subtraction by 2 (black)
	db $06					; [$06]
	db $8A					; loop end
	db $FF					; end of script
	db $C9,$67				; play sound effect $67
	db $89,$10				; loop start (16 times)
	db $06					; [$06]
	db $8A					; loop end
	db $89,$08				; loop start (8 times)
	db $83,$60				; move forward 1
	db $06					; [$06]
	db $8A					; loop end
	db $89,$1F				; loop start (31 times)
	db $83,$00				; move down/forward 1
	db $06					; [$06]
	db $8A					; loop end
	db $89,$08				; loop start (8 times)
	db $83,$80				; move back 1
	db $06					; [$06]
	db $8A					; loop end
	db $89,$20				; loop start (32 times)
	db $06					; [$06]
	db $8A					; loop end
	db $FF					; end of script
	db $89,$18				; loop start (24 times)
	db $06					; [$06]
	db $8A					; loop end
	db $89,$0F				; loop start (15 times)
	db $83,$00				; move down/forward 1
	db $06					; [$06]
	db $8A					; loop end
	db $89,$38				; loop start (56 times)
	db $06					; [$06]
	db $8A					; loop end
	db $FF					; end of script
	db $89,$5F				; loop start (95 times)
	db $06					; [$06]
	db $8A					; loop end
	db $FF					; end of script

; [ Animation Script $0130: N.Cross (sprite) ]

org $D07366
	db $00,$20				; speed 1, align to center of character/monster
	db $80,$72,$01			; branch forward 1 byte if attack hit
	db $FF					; end of script
	db $FA,$60,$59			; branch to Ice 2 (sprite) code

; [ Animation Script $01B4: Thriller (sprite) ]

org $D0736F
	db $00,$20				; speed 1, align to center of character/monster
	db $80,$72,$01			; branch forward 1 byte if attack hit
	db $FF					; end of script
	db $FA,$B6,$2C			; branch to original Disaster (sprite) code
	db $FE,$FE,$FE,$FE		; 4d spare bytes		

; [ Animation Script $01A5: Flare Star (bg1) ] (Code modified from original)

org $D03106
	db $B5,$A1				; increase background color addition by 1 (purple)
org $D03123
	db $B5,$51				; decrease background color addition by 1 (green)
org $D0312E
	db $B5,$B1				; decrease background color addition by 1 (purple)

; [ Animation Script $01C2: Meteo (bg3) ] (Code modified from original)

org $D011DC
	db $AF,$40				; set background color subtraction to 0 (purple)
	db $89,$04				; loop start (4 times)
	db $B6,$41				; increase background color subtraction by 1 (purple)
org $D011E4
	db $89,$86				; loop start (134 times)
org $D011E8
	db $89,$04				; loop start (4 times)
	db $B6,$51				; decrease background color subtraction by 1 (purple)

; [ Animation Script $020F: Phantasm (sprite) ]

org $D01DE9
	db $30,$00				; speed 4, align to bottom of character/monster
	db $83,$9F				; move back 32
	db $83,$9F				; move back 32
	db $83,$9F				; move back 32
	db $83,$8F				; move back 16
	db $89,$10				; loop start (16 times)
	db $1F					; [---]
	db $8A					; loop end
	db $82,$1C,$1C			; change target graphic to 28 (shocked)
	db $BF,$1F,$1E			; jump to subroutine $1E1F
	db $82,$15,$15			; change target graphic to 21 (ready)
	db $83,$7F				; move forward 32
	db $83,$6F				; move forward 16
	db $89,$08				; loop start (8 times)
	db $1F					; [---]
	db $8A					; loop end
	db $BF,$1F,$1E			; jump to subroutine $1E1F
	db $89,$04				; loop start (4 times)
	db $1F					; [---]
	db $8A					; loop end
	db $82,$16,$16			; change target graphic to 22 (hit)
	db $89,$08				; loop start (8 times)
	db $87,$61				; move target forward 2
	db $1F					; [---]
	db $87,$81				; move target back 2
	db $1F					; [---]
	db $8A					; loop end
	db $82,$00,$00			; change target graphic to 0 (no action)
	db $FF					; end of script
	db $89,$02				; loop start (2 times)
	db $0B					; [$0B]
	db $83,$62				; move forward 3
	db $0A					; [$0A]
	db $83,$61				; move forward 2
	db $09					; [$09]
	db $0A					; [$0A]
	db $8A					; loop end
	db $C0					; return from subroutine

; [ Subroutine $D01E2B: Hop Forwards (used by Good Boy) ]

org $D01E2B
	db $89,$08				; loop start (8 times)
	db $86,$62				; move attacker forward 3
	db $86,$C0				; move attacker up 1
	db $1F					; [---]
	db $8A					; loop end
	db $C0					; return from subroutine

; [ Subroutine $D01E34: Hop Backwards (used by Good Boy) ]

org $D01E34
	db $89,$08				; loop start (8 times)
	db $86,$82				; move attacker back 3
	db $86,$20				; move attacker down 1
	db $1F					; [---]
	db $8A					; loop end
	db $C0					; return from subroutine
	db $FE,$FE,$FE			; 3d spare bytes			

; [ Animation Script $0210: Phantasm (bg3) ]

org $D03A9B
	db $10,$20				; speed 2, align to center of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $80,$2E,$50,$40		; move to (80, 64)
	db $AF,$E0				; set background color subtraction to 0 (black)
	db $B1,$E0				; set sprite animation palette color subtraction to 0 (black)
	db $B9,$E0				; set monster color subtraction to 0 (black)
	db $89,$20				; loop start (32 times)
	db $B6,$E1				; increase background color subtraction by 1 (black)
	db $BC,$E1				; increase monster color subtraction by 1 (black)
	db $09					; [$09]
	db $8A					; loop end
	db $C9,$E3				; play sound effect $E3
	db $B0,$FF				; set background color addition to 31 (white)
	db $B2,$FF				; set sprite animation palette color addition to 31 (white)
	db $BA,$FF				; set monster color addition to 31 (white)
	db $AA,$E0				; set bg3 animation palette color subtraction to 0 (black)
	db $89,$08				; loop start (8 times)
	db $B5,$F4				; decrease background color addition by 4 (white)
	db $B7,$F4				; decrease sprite animation palette color addition by 4 (white)
	db $BB,$F4				; decrease monster color addition by 4 (white)
	db $B4,$E4				; increase bg3 animation palette color subtraction by 4 (black)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$08				; loop start (8 times)
	db $B6,$E4				; increase background color subtraction by 4 (black)
	db $B8,$E4				; increase sprite animation palette color subtraction by 4 (black)
	db $BC,$E4				; increase monster color subtraction by 4 (black)
	db $B4,$E4				; increase bg3 animation palette color subtraction by 4 (black)
	db $09					; [$09]
	db $8A					; loop end
	db $89,$18				; loop start (24 times)
	db $09					; [$09]
	db $8A					; loop end
	db $B0,$FF				; set background color addition to 31 (white)
	db $B2,$FF				; set sprite animation palette color addition to 31 (white)
	db $BA,$FF				; set monster color addition to 31 (white)
	db $AA,$E0				; set bg3 animation palette color subtraction to 0 (black)
	db $C9,$CC				; play sound effect $CC
	db $89,$08				; loop start (8 times)
	db $B5,$F4				; decrease background color addition by 4 (white)
	db $B7,$F4				; decrease sprite animation palette color addition by 4 (white)
	db $BB,$F4				; decrease monster color addition by 4 (white)
	db $B4,$E4				; increase bg3 animation palette color subtraction by 4 (black)
	db $01					; [$01]
	db $8A					; loop end
	db $80,$26,$01			; disable character palette updates
	db $89,$08				; loop start (8 times)
	db $B6,$E4				; increase background color subtraction by 4 (black)
	db $B8,$E4				; increase sprite animation palette color subtraction by 4 (black)
	db $BC,$E4				; increase monster color subtraction by 4 (black)
	db $B4,$E4				; increase bg3 animation palette color subtraction by 4 (black)
	db $09					; [$09]
	db $8A					; loop end
	db $89,$10				; loop start (16 times)
	db $09					; [$09]
	db $8A					; loop end
	db $C9,$D4				; play sound effect $D4
	db $FA,$D2,$6B			; jump to space for remainder of this code
	db $FE,$FE,$FE,$FE,$FE	; 5d spare bytes

; [ Animation Script $0210: Phantasm (bg3) ] (Continuation of animation script)

org $D06BD2
	db $89,$0B				; loop start (11 times)
	db $FE,$E2				; increase character color subtraction by 2 (black)
	db $09					; [$09]
	db $8A					; loop end
	db $89,$0B				; loop start (11 times)
	db $FE,$F2				; decrease character color subtraction by 2 (black)
	db $09					; [$09]
	db $8A					; loop end
	db $89,$10				; loop start (16 times)
	db $B6,$F2				; decrease background color subtraction by 2 (black)
	db $BC,$F2				; decrease monster color subtraction by 2 (black)
	db $09					; [$09]
	db $8A					; loop end
	db $80,$26,$00			; enable character palette updates
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 17d spare bytes
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE				

; [ Animation Script $015A: !Kazekiri, !Mutsunokami and Wind Breaker (sprite) ]

org $D03669
	db $00,$20				; speed 1, align to center of character/monster
	db $89,$08				; loop start (8 times)
	db $1F					; [---]
	db $8A					; loop end
	db $84,$02				; set animation speed to 3
	db $8B,$17				; animated loop start (23 times, increment frame offset each time)
	db $00					; [$00]
	db $8C					; animated loop end
	db $FF					; end of script

; [ Animation Script $015B: !Kazekiri (bg1) ] and
; [ Animation Script $015C: !Mutsunokami and Wind Breaker (bg1) ]

org $D03676
	db $00,$20				; speed 1, align to center of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $C4,$80				; move bg1 thread to this thread's position
	db $D0,$20				; set tile priority to 2 for all character/monster sprites
	db $CC,$FF				; set bg1 animation palette color subtraction to 31 (black)
	db $F7,$A0				; wait until scanline 160
	db $D4,$02,$01,$12		; add (sprites, bg2) to (bg1)
	db $00					; [$00]
	db $BD,$A0				; hide bg1 thread
	db $C9,$00				; play default sound effect
	db $89,$1F				; loop start (31 times)
	db $CF,$F1				; decrease bg1 animation palette color subtraction by 1 (black)
	db $A3,$17,$31			; shift colors (1..8) of bg1 animation/esper palette left (3 loops per shift)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$10				; loop start (16 times)
	db $A3,$17,$31			; shift colors (1..8) of bg1 animation/esper palette left (3 loops per shift)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$1F				; loop start (31 times)
	db $CF,$E1				; increase bg1 animation palette color subtraction by 1 (black)
	db $A3,$17,$31			; shift colors (1..8) of bg1 animation/esper palette left (3 loops per shift)
	db $00					; [$00]
	db $8A					; loop end
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 8 spare bytes
	db $FE,$FE,$FE			

; [ Animation Script $01E4: Good Boy (sprite) ]

org $D057EA
	db $00,$00				; speed 1, align to bottom of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $80,$69				; update sprite layer priority based on attacker
	db $85					; move to attacker position
	db $83,$29				; move down 10
	db $83,$60				; move forward 1
	db $89,$06				; loop start (6 times)
	db $83,$9F				; move back 32
	db $8A					; loop end
	db $BF,$67,$15			; jump to subroutine $1567
	db $89,$40				; loop start (64 times)
	db $04					; [$04]
	db $8A					; loop end
	db $C9,$00				; play default sound effect
	db $95					; calculate vector from attacker to target
	db $80,$75,$30,$04,$80	; command $80/$75
	db $00					; [$00]
	db $C1,$04,$08			; command $C1
	db $C9,$94				; play sound effect $94
	db $84,$05				; set animation speed to 6
	db $01					; [$01]
	db $87,$61				; move target forward 2
	db $02					; [$02]
	db $87,$81				; move target back 2
	db $03					; [$03]
	db $87,$61				; move target forward 2
	db $02					; [$02]
	db $87,$81				; move target back 2
	db $01					; [$01]
	db $84,$01				; set animation speed to 2
	db $C9,$00				; play default sound effect
	db $80,$75,$30,$04,$80	; command $80/$75
	db $00					; [$00]
	db $C1,$04,$08			; command $C1
	db $FF					; end of script
	db $FE,$FE,$FE			; 3d spare bytes

; [ Animation Script $01E5: Good Boy (bg1) ]

org $D0582F
	db $00,$00				; speed 1, align to bottom of character/monster
	db $90,$30				; set animation tile priority to 3
	db $89,$10				; loop start (16 times)
	db $1F					; [---]
	db $8A					; loop end
	db $D4,$00,$00,$00		; add fixed color to (no layers)
	db $81,$07,$07			; change attacker graphic to 7 (jumping)
	db $BF,$2B,$1E			; jump to subroutine $1E2B
	db $81,$44,$44			; change attacker graphic to 68 (kneeling)
	db $89,$18				; loop start (24 times)
	db $1F					; [---]
	db $8A					; loop end
	db $85					; move to attacker position
	db $83,$2A				; move down 11
	db $83,$86				; move back 7
	db $89,$10				; loop start (16 times)
	db $1F					; [---]
	db $8A					; loop end
	db $84,$04				; set animation speed to 5
	db $89,$02				; loop start (2 times)
	db $00					; [$00]
	db $83,$60				; move forward 1
	db $00					; [$00]
	db $83,$60				; move forward 1
	db $00					; [$00]
	db $83,$80				; move back 1
	db $00					; [$00]
	db $83,$80				; move back 1
	db $00					; [$00]
	db $8A					; loop end
	db $84,$01				; set animation speed to 2
	db $81,$37,$37			; change attacker graphic to 55 (jumping back)
	db $BF,$34,$1E			; jump to subroutine $1E34
	db $81,$00,$00			; change attacker graphic to 0 (no action)
	db $FF					; end of script

; [ Animation Script $01E0: Reprisal (sprite) ]

org $D0153C
	db $00,$00				; speed 1, align to bottom of character/monster
	db $89,$07				; loop start (7 times)
	db $83,$9F				; move back 32
	db $8A					; loop end
	db $80,$72,$0C			; branch forward 12 bytes if attack hit
	db $83,$37				; move down 24
	db $BD,$A0				; hide bg1 thread
	db $BF,$67,$15			; jump to subroutine $1567
	db $C2,$80				; unpause bg1 thread
	db $FA,$5A,$15			; jump to $155A
	db $BF,$67,$15			; jump to subroutine $1567
	db $C2,$80				; unpause bg1 thread
	db $01					; [$01]
	db $C9,$94				; play sound effect $94
	db $84,$05				; set animation speed to 6
	db $01					; [$01]
	db $03					; [$03]
	db $04					; [$04]
	db $03					; [$03]
	db $01					; [$01]
	db $84,$01				; set animation speed to 2
	db $BF,$67,$15			; jump to subroutine $1567
	db $FF					; end of script
	db $89,$04				; loop start (4 times)
	db $C9,$00				; play default sound effect
	db $83,$63				; move forward 4
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $00					; [$00]
	db $83,$63				; move forward 4
	db $01					; [$01]
	db $83,$63				; move forward 4
	db $01					; [$01]
	db $83,$63				; move forward 4
	db $01					; [$01]
	db $83,$63				; move forward 4
	db $01					; [$01]
	db $83,$63				; move forward 4
	db $02					; [$02]
	db $83,$63				; move forward 4
	db $02					; [$02]
	db $83,$63				; move forward 4
	db $02					; [$02]
	db $83,$63				; move forward 4
	db $02					; [$02]
	db $8A					; loop end
	db $C0					; return from subroutine
	db $FE,$FE,$FE,$FE,$FE	; 7d spare bytes
	db $FE,$FE				

; [ Animation Script $01F8: Scroll Throw (sprite) ]

org $D013D5
	db $00,$20				; speed 1, align to center of character/monster
	db $85					; move to attacker position
	db $C9,$28				; play sound effect $28
	db $81,$12,$13			; change attacker graphic to 18 (walking forward, frame 2) if facing left or 19 (walking forward, hands up) if facing right
	db $83,$27				; move down 8
	db $95					; calculate vector from attacker to target
	db $81,$04,$06			; change attacker graphic to 4 (walking forward, frame 1) if facing left or 6 (walking forward, frame 3) if facing right
	db $00					; [$00]
	db $92,$06,$03			; move along vector at speed 6, branch back 4 bytes
	db $C9,$CC				; play sound effect $CC
	db $89,$18				; loop start (24 times)
	db $01					; [$01]
	db $8A					; loop end
	db $C2,$C0				; unpause bg1 thread, unpause bg3 thread
	db $89,$18				; loop start (24 times)
	db $01					; [$01]
	db $8A					; loop end
	db $81,$00,$00			; change attacker graphic to 0 (no action)
	db $FF					; end of script

; [ Animation Script $01FA: Fade Scroll (sprite) ]

org $D022AF
	db $10,$20				; speed 2, align to center of character/monster
	db $85					; move to attacker position
	db $C9,$28				; play sound effect $28
	db $81,$12,$13			; change attacker graphic to 18 (walking forward, frame 2) if facing left or 19 (walking forward, hands up) if facing right
	db $83,$27				; move down 8
	db $95					; calculate vector from attacker to target
	db $81,$04,$06			; change attacker graphic to 4 (walking forward, frame 1) if facing left or 6 (walking forward, frame 3) if facing right
	db $00					; [$00]
	db $92,$06,$03			; move along vector at speed 6, branch back 4 bytes
	db $C9,$CC				; play sound effect $CC
	db $89,$18				; loop start (24 times)
	db $01					; [$01]
	db $8A					; loop end
	db $80,$72,$01			; branch forward 1 byte if attack hit
	db $FF					; end of script
	db $82,$09,$09			; change target graphic to 9 (casting)
	db $89,$08				; loop start (8 times)
	db $1F					; [---]
	db $8A					; loop end
	db $C9,$00				; play default sound
	db $87,$60				; move target forward 1
	db $1F					; [---]
	db $87,$81				; move target back 2
	db $1F					; [---]
	db $87,$62				; move target forward 3
	db $1F					; [---]
	db $87,$83				; move target back 4
	db $1F					; [---]
	db $87,$64				; move target forward 5
	db $1F					; [---]
	db $87,$85				; move target back 6
	db $1F					; [---]
	db $87,$66				; move target forward 7
	db $1F					; [---]
	db $87,$87				; move target back 8
	db $1F					; [---]
	db $87,$68				; move target forward 9
	db $1F					; [---]
	db $87,$89				; move target back 10
	db $1F					; [---]
	db $87,$6A				; move target forward 11
	db $1F					; [---]
	db $87,$8B				; move target back 12
	db $1F					; [---]
	db $87,$6C				; move target forward 13
	db $1F					; [---]
	db $87,$8D				; move target back 14
	db $1F					; [---]
	db $87,$6E				; move target forward 15
	db $1F					; [---]
	db $87,$8F				; move target back 16
	db $1F					; [---]
	db $87,$70				; move target forward 17
	db $1F					; [---]
	db $87,$91				; move target back 18
	db $1F					; [---]
	db $87,$72				; move target forward 19
	db $1F					; [---]
	db $87,$93				; move target back 20
	db $1F					; [---]
	db $87,$74				; move target forward 21
	db $1F					; [---]
	db $87,$95				; move target back 22
	db $1F					; [---]
	db $87,$76				; move target forward 23
	db $1F					; [---]
	db $87,$97				; move target back 24
	db $1F					; [---]
	db $87,$6B				; move target forward 12
	db $1F					; [---]
	db $82,$00,$00			; change target graphic to 0 (no action)
	db $80,$14				; make target vanish
	db $FF					; end of script

; [ Animation Script $01F9: Bolt Scroll (bg3) ]

org $D02325
	db $10,$20				; speed 1, align to center of character/monster
	db $C4,$40				; move bg3 thread to this thread's position
	db $F3					; jump based on attacker
	db $34,$23,$34,$23		
	db $34,$23,$34,$23		
	db $38,$23				
	db $89,$10				; loop start (16 times)
	db $09					; [$09]
	db $8A					; loop end
	db $C9,$00				; play default sound effect
	db $8B,$08				; animated loop start (8 times, increment frame offset each time)
	db $00					; [$00]
	db $00					; [$00]
	db $8C					; animated loop end
	db $FF					; end of script

; [ Animation Script $01F7: Bolt Scroll (bg1) ]

org $D02340
	db $10,$20				; speed 1, align to center of character/monster
	db $C4,$80				; move bg1 thread to this thread's position
	db $89,$06				; loop start (6 times)
	db $09					; [$09]
	db $8A					; loop end
	db $FA,$29,$23			; jump to Bolt Scroll (bg3) code
	db $FE,$FE,$FE,$FE,$FE	; 7d spare bytes
	db $FE,$FE				

; [ Animation Script $01F5: Wave Scroll (bg3) ]

org $D02352
	db $00,$20				; speed 1, align to center of character/monster
	db $B0,$20				; set background color addition to 0 (blue)
	db $89,$07				; loop start (7 times)
	db $B5,$22				; increase background color addition by 2 (blue)
	db $1F					; [---]
	db $8A					; loop end
	db $80,$2E,$80,$48		; move to (128,72)
	db $89,$07				; loop start (7 times)
	db $83,$9F				; move back 32
	db $8A					; loop end
	db $89,$60				; loop start (96 times)
	db $E9,$0B,$03			; move animation randomly (0..11,0..3)
	db $83,$63				; move forward 4
	db $1F					; [---]
	db $8A					; loop end
	db $89,$07				; loop start (7 times)
	db $B5,$32				; decrease background color addition by 2 (blue)
	db $1F					; [---]
	db $8A					; loop end
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 6d spare bytes
	db $FE					

; [ Animation Script $01F6: Wave Scroll (bg1)]

org $D0237B
	db $00,$A0				; speed 1, align to center of screen
	db $D1,$01				; invalidate character/monster sprite priority
	db $C4,$80				; move bg1 thread to this thread's position
	db $C9,$00				; play default sound effect
	db $89,$07				; loop start (7 times)
	db $83,$9F				; move back 32
	db $8A					; loop end
	db $89,$60				; loop start (96 times)
	db $E9,$0B,$03			; move animation randomly (0..11,0..3)
	db $83,$63				; move forward 4
	db $00					; [$00]
	db $8A					; loop end
	db $C9,$FF				; play sound effect $FF
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 5d spare bytes

; [ Animation Script $01F4: Fire Scroll (bg1) ]

org $D023BC
	db $00,$20				; speed 1, align to center of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $C9,$00				; play default sound effect
	db $AF,$60				; set background color subtraction to 0 (red)
	db $89,$07				; loop start (7 times)
	db $B6,$62				; increase background color subtraction by 2 (red)
	db $0F					; [$0F]
	db $8A					; loop end
	db $C4,$80				; move bg1 thread to this thread's position
	db $84,$03				; set animation speed to 4
	db $D0,$20				; set tile priority to 2 for all character/monster sprites
	db $8B,$0C				; animated loop start (12 times, increment frame offset each time)
	db $00					; [$00]
	db $8C					; animated loop end
	db $89,$07				; loop start (7 times)
	db $B6,$72				; decrease background color subtraction by 2 (red)
	db $0F					; [$0F]
	db $8A					; loop end
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 5d spare bytes

; [ Animation Script $015E: Esper Summon (bg1) ]

org $D03BE2
	db $00,$20				; speed 1, align to center of character/monster
	db $BD,$50				; hide bg3 thread
	db $CC,$EC				; set bg1 animation palette color subtraction to 12 (black)
	db $B1,$FF				; set sprite animation palette color subtraction to 31 (black)
	db $D1,$01				; invalidate character/monster sprite priority
	db $90,$00				; set animation tile priority to 0
	db $85					; move to attacker position
	db $DB,$06				; branch to 6 bytes forward if character already stepped forward to attack
	db $89,$07				; loop start (7 times)
	db $83,$62				; move forward 3
	db $1F					; [---]
	db $8A					; loop end
	db $81,$07,$07			; change attacker graphic to 7 (jumping)
	db $89,$0C				; loop start (12 times)
	db $CF,$F1				; decrease bg1 animation palette color subtraction by 1 (black)
	db $83,$A0				; move up/forward 1
	db $08					; [$08]
	db $8A					; loop end
	db $89,$03				; loop start (3 times)
	db $83,$A0				; move up/forward 1
	db $08					; [$08]
	db $08					; [$08]
	db $8A					; loop end
	db $80,$86,$00			; play default sound effect (pan to thread x position)
	db $84,$08				; set animation speed to 9
	db $83,$C0				; Move up 1
	db $08					; [$08]
	db $83,$C0				; Move up 1
	db $08					; [$08]
	db $83,$20				; move down 1
	db $08					; [$08]
	db $83,$20				; move down 1
	db $08					; [$08]
	db $83,$C0				; Move up 1
	db $CF,$A3				; increase bg1 animation palette color subtraction by 3 (red/blue)
	db $08					; [$08]
	db $83,$C0				; Move up 1
	db $CF,$C3				; increase bg1 animation palette color subtraction by 3 (red/green)
	db $08					; [$08]
	db $83,$20				; move down 1
	db $CF,$E3				; increase bg1 animation palette color subtraction by 3 (black)
	db $08					; [$08]
	db $83,$20				; move down 1
	db $CF,$E3				; increase bg1 animation palette color subtraction by 3 (black)
	db $08					; [$08]
	db $84,$01				; set animation speed to 2
	db $89,$03				; loop start (3 times)
	db $83,$40				; move down/back 1
	db $08					; [$08]
	db $08					; [$08]
	db $8A					; loop end
	db $89,$0C				; loop start (12 times)
	db $83,$40				; move down/back 1
	db $08					; [$08]
	db $8A					; loop end
	db $81,$00,$00			; change attacker graphic to 0 (no action)
	db $FF					; end of script

; [ Animation Script $0077: Esper Summon (bg3) ]

org $D06AC3
	db $00,$20				; speed 1, align to center of character/monster
	db $DB,$03				; branch forward 3 bytes if character already stepped forward to attack
	db $BF,$67,$70			; jump to subroutine $7067
	db $89,$16				; loop start (22 times)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$07				; loop start (7 times)
	db $B8,$F4				; decrease sprite animation palette color subtraction by 4 (black)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$17				; loop start (23 times)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$07				; loop start (7 times)
	db $B8,$E4				; increase sprite animation palette color subtraction by 4 (black)
	db $00					; [$00]
	db $8A					; loop end
	db $FF					; end of script

; [ Animation Script $0076: Esper Summon (sprite, extra) ]

org $D06ADF
	db $00,$20				; speed 1, align to center of character/monster
	db $D1,$01				; invalidate character/monster sprite priority
	db $90,$00				; set animation tile priority to 0
	db $85					; move to attacker position
	db $DB,$06				; branch forward 6 bytes if character already stepped forward to attack
	db $89,$07				; loop start (7 times)
	db $83,$62				; move forward 3
	db $1F					; [---]
	db $8A					; loop end
	db $83,$B0				; move up/forward 16
	db $89,$16				; loop start (22 times)
	db $1F					; [---]
	db $8A					; loop end
	db $89,$22				; loop start (34 times)
	db $80,$0B				; command $80/$0B
	db $00					; [$00]
	db $8A					; loop end
	db $FF					; end of script
	db $FE					; 1d byte of free space

; [ Animation Script $0211: Shock Wave, Aqua Slash (sprite) ] (Code modified from original)

org $D01D8D
	db $C9,$9B				; play sound effect $9B
org $D01D9A
	db $C9,$00				; play default sound effect

; [ Animation Script $0250: Shift Dance (sprite) ]

org $D068E3
	db $00,$20				; speed 1, align to center of character/monster
	db $DB,$03				; branch to $68EA if character already stepped forward to attack
	db $BF,$19,$70			; jump to subroutine $7019
	db $D1,$01				; invalidate character/monster sprite priority
	db $C9,$00				; play default sound effect
	db $BF,$31,$69			; jump to subroutine $6931
	db $C9,$F9				; play sound effect $F9
	db $BF,$80,$6B			; jump to subroutine $6B80
	db $81,$00,$00			; change attacker graphic to 0 (no action)
	db $89,$08				; loop start (8 times)
	db $1F					; [---]
	db $8A					; loop end
	db $C9,$00				; play default sound effect
	db $BF,$31,$69			; jump to subroutine $6931
	db $C9,$F9				; play sound effect $F9
	db $BF,$A9,$6B			; jump to subroutine $6BA9
	db $81,$00,$00			; change attacker graphic to 0 (no action)
	db $FF					; end of script
	db $FE,$FE,$FE			; 3d spare bytes

; [ Subroutine $D06B80: Spin Forward (used by Shift Dance) ]

org $D06B80
	db $84,$02				; set animation speed to 2
	db $81,$17,$17			; change attacker graphic to 23 (hands up, facing down)
	db $86,$61				; move attacker forward 2
	db $1F					; [---]
	db $86,$61				; move attacker forward 2
	db $1F					; [---]
	db $81,$37,$07			; change attacker graphic to 55 (jumping right) if facing left or 7 (jumping left) if facing right
	db $86,$61				; move attacker forward 2
	db $1F					; [---]
	db $86,$61				; move attacker forward 2
	db $1F					; [---]
	db $81,$18,$18			; change attacker graphic to 24 (hands up, facing up)
	db $86,$61				; move attacker forward 2
	db $1F					; [---]
	db $86,$61				; move attacker forward 2
	db $1F					; [---]
	db $81,$07,$37			; change attacker graphic to 7 (jumping left) if facing left or 55 (jumping right) if facing right
	db $86,$60				; move attacker forward 1
	db $1F					; [---]
	db $86,$60				; move attacker forward 1
	db $1F					; [---]
	db $84,$01				; set animation speed to 1
	db $C0					; return from subroutine

; [ Subroutine $D06BA9: Spin Backwards (used by Shift Dance) ]

org $D06BA9
	db $84,$02				; set animation speed to 2
	db $81,$17,$17			; change attacker graphic to 23 (hands up, facing down)
	db $86,$81				; move attacker back 2
	db $1F					; [---]
	db $86,$81				; move attacker back 2
	db $1F					; [---]
	db $81,$37,$07			; change attacker graphic to 55 (jumping right) if facing left or 7 (jumping left) if facing right
	db $86,$81				; move attacker back 2
	db $1F					; [---]
	db $86,$81				; move attacker back 2
	db $1F					; [---]
	db $81,$18,$18			; change attacker graphic to 24 (hands up, facing up)
	db $86,$81				; move attacker back 2
	db $1F					; [---]
	db $86,$81				; move attacker back 2
	db $1F					; [---]
	db $81,$07,$37			; change attacker graphic to 7 (jumping left) if facing left or 55 (jumping right) if facing right
	db $86,$80				; move attacker back 1
	db $1F					; [---]
	db $86,$80				; move attacker back 1
	db $1F					; [---]
	db $84,$01				; set animation speed to 1
	db $C0					; return from subroutine

; [ Animation Script $011D: Sonic Dive (sprite) ]

org $D04A59
	db $00,$20				; speed 1, align to center of character/monster
	db $89,$08				; loop start (8 times)
	db $1F					; [---]
	db $8A					; loop end
	db $1F					; [---]
	db $80,$3F				; command $80/$3F
	db $80,$2D				; jump to $4A80 (normal attack), $4A80 (back attack), or $4A6E (pincer attack)
	db $7C,$4A,$7C,$4A		
	db $6A,$4A				
	db $80,$32				; jump to $4A74 (left) or $4A7A (right)
	db $70,$4A,$76,$4A		
	db $D2,$78,$4C			; set vector target to (120,76)
	db $FA,$7F,$4A			; jump to $4A83
	db $D2,$88,$4C			; set vector target to (136,76)
	db $FA,$7F,$4A			; jump to $4A83
	db $D2,$80,$4C			; set vector target to (128,76)
	db $95					; calculate vector from attacker to target
	db $1F					; [---]
	db $A0,$05,$03			; jump forward along vector at speed 5, branch back 3 bytes
	db $D0,$20				; set tile priority to 2 for all character/monster sprites
	db $89,$3F				; loop start (63 times)
	db $86,$63				; move attacker forward 4
	db $86,$C0				; move attacker up 1
	db $1F					; [---]
	db $8A					; loop end
	db $80,$29,$01			; hide cursor sprites (esper attack)
	db $E1,$00				; hide attacking character sprite
	db $FA,$01,$22			; jump to space for remainder of this code
	db $FE,$FE,$FE			; 3d spare bytes


; [ Animation Script $0072: Sketch (sprite) ] (Code modified from original)

org $D06B5E
	db $83,$6E				; move forward 15
	db $83,$C6				; move up 7
	db $00					; [$00]
	db $01					; [$01]
	db $02					; [$02]
	db $03					; [$03]
	db $83,$28				; move down 9
	db $04					; [$04]
	db $05					; [$05]
	db $06					; [$06]
	db $05					; [$05]
	db $04					; [$04]
	db $83,$C8				; move up 9
	db $03					; [$03]
	db $02					; [$02]
	db $01					; [$01]
	db $00					; [$00]
	db $01					; [$01]
	db $02					; [$02]
	db $03					; [$03]
	db $83,$28				; move down 9
	db $04					; [$04]
	db $05					; [$05]

; [ Animation Script $0034: Full Moon, Rising Sun Hit (bg1) ] (Code modified from original)

org $D07CA5
	db $BF,$39,$16			; jump to Spinning Throw subroutine
	db $FF					; end of script
	db $FE					; 1d spare byte

; [ Subroutine $D01639: Spinning Throw (used by Full Moon, Rising Sun Hit) ]

org $D01639
	db $04					; [$04]
	db $A4,$35,$B1			; shift colors (3..8) of sprite animation palette right (1 loops per shift)
	db $96,$02,$06			; move along boomerang vector, branch back 6 bytes
	db $C0					; return from subroutine
	db $FE					; 1d spare byte

; [ Animation Script $0091: Full Moon, Rising Sun Crit (sprite) ]

org $D03C41
	db $00,$20				; speed 1, align to center of character/monster
	db $85					; move to attacker position
	db $DB,$03				; branch to 3 bytes forward if character already stepped forward to attack
	db $BF,$19,$70			; jump to subroutine $7019
	db $C9,$00				; play default sound effect
	db $81,$12,$13			; change attacker graphic to 18 (walking forward, frame 2) if facing left or 19 (walking forward, hands up) if facing right
	db $95					; calculate vector from attacker to target
	db $93,$08				; move to vector position 8
	db $A4,$35,$B1			; shift colors (3..8) of sprite animation palette right (1 loops per shift)
	db $00					; [$00]
	db $81,$04,$06			; change attacker graphic to 4 (walking forward, frame 1) if facing left or 6 (walking forward, frame 3) if facing right
	db $92,$08,$09			; move along vector at speed 8, branch to back 9 bytes
	db $C9,$94				; play sound effect $94
	db $89,$08				; loop start (8 times)
	db $87,$81				; move target back 2
	db $83,$A7				; move up/forward 8
	db $A4,$35,$B1			; shift colors (3..8) of sprite animation palette right (1 loops per shift)
	db $00					; [$00]
	db $87,$61				; move target forward 2
	db $83,$A7				; move up/forward 8
	db $A4,$35,$B1			; shift colors (3..8) of sprite animation palette right (1 loops per shift)
	db $00					; [$00]
	db $8A					; loop end
	db $81,$00,$00			; change attacker graphic to 0 (no action)
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 77d spare bytes
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE				

; [ Animation Script $0279: Boomerang, Wing Edge Crit (sprite) ] (Code modified from original)

org $D06651
	db $BF,$DB,$36			; jump to Crit Bounce subroutine
	db $81,$00,$00			; change attacker graphic to 0 (no action)
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 12d spare bytes
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE				

; [ Subroutine $D036DB: Crit Bounce (used by Boomerang, Wing Edge Crit) ]

org $D036DB
	db $89,$08				; loop start (8 times)
	db $87,$81				; move target back 2
	db $83,$A7				; move up/forward 8
	db $98,$02,$06			; increment frame offset every 2 loops (0..6)
	db $00					; [$00]
	db $87,$61				; move target forward 2
	db $83,$A7				; move up/forward 8
	db $98,$02,$06			; increment frame offset every 2 loops (0..6)
	db $00					; [$00]
	db $8A					; loop end
	db $C0					; return from subroutine
	db $FE					; 1d spare byte

; [ Animation Script $008E: Throw Knife (sprite) ] (Code modified from original)

org $D06674
	db $98,$02,$08			; increment frame offset every 2 loops (0..8)
	db $00					; [$00]
org $D06680
	db $83,$42				; move down/back 3
	db $80,$4E				; clear frame offset
	db $89,$07				; loop start (7 times)
	db $87,$81				; move target back 2
	db $08					; [$08]
	db $87,$61				; move target forward 2
	db $08					; [$08]
	db $8A					; loop end
	db $81,$00,$00			; change attacker graphic to 0 (no action)
	db $FF					; end of script
	db $FE,$FE				; 2 spare bytes

; [ Animation Script $000C, $000D: Shuriken, Ninja Star (sprite) ]

org $D07C4F
	db $00,$20				; speed 1, align to center of character/monster
	db $89,$0A				; loop start (10 times)
	db $1F					; [---]
	db $8A					; loop end
	db $85					; move to attacker position
	db $83,$27				; move down 8
	db $95					; calculate vector from attacker to target
	db $93,$18				; move to vector position 24
	db $98,$03,$02			; increment frame offset every 3 loops (0..2)
	db $00					; [$00]
	db $92,$06,$06			; move along vector at speed 6, branch back 7 bytes
	db $C9,$00				; play default sound effect
	db $80,$4E				; clear frame offset
	db $89,$10				; loop start (16 times)
	db $02					; [$02]
	db $8A					; loop end
	db $FF					; end of script
	db $FE,$FE,$FE,$FE		; 4 spare bytes

; [ Animation Script $002F, $0030: Shuriken, Ninja Star (bg1) ]

org $D07CFA
	db $00,$20				; speed 1, align to center of character/monster
	db $DB,$03				; branch forward 3 bytes if character already stepped forward to attack
	db $BF,$19,$70			; jump to subroutine $7019
	db $85					; move to attacker position
	db $81,$12,$13			; change attacker graphic to 18 (walking forward, frame 2) if facing left or 19 (walking forward, hands up) if facing right
	db $83,$81				; move back 2
	db $83,$F6				; move up/back 23
	db $84,$03				; set animation speed to 4
	db $1F					; [---]
	db $1F					; [---]
	db $C9,$5B				; play sound effect $5B
	db $83,$70				; move forward 17
	db $83,$16				; move down/forward 23
	db $81,$04,$06			; change attacker graphic to 4 (walking forward, frame 1) if facing left or 6 (walking forward, frame 3) if facing right
	db $01					; [$01]
	db $02					; [$02]
	db $03					; [$03]
	db $81,$00,$00			; change attacker graphic to 0 (no action)
	db $FF					; end of script
	db $FE,$FE,$FE			; 3d spare bytes
	
; [ Animation Script $00EE: Inferno (sprite) ] (Changed from original)

org $D05588
	db $83,$87				; move back 8
	db $83,$C3				; move up 4
	db $89,$40				; loop start (64 times)
	db $02					; [$02]
	db $8A					; loop end
	db $89,$1A				; loop start (26 times)
	db $83,$C3				; move up 4
	db $02					; [$02]
	db $8A					; loop end
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 73d spare bytes
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE,$FE,$FE	
	db $FE,$FE,$FE			

; [ Animation Script $0209: Sneeze (sprite) ] (Changed from original)

org $D01EDE
	db $A4,$17,$B1			; shift colors (1..8) of sprite animation palette right (1 loops per shift)
org $D01EE2
	db $92,$06,$06			; move along vector at speed 6, branch back 6 bytes
org $D01EED
	db $A4,$17,$B1			; shift colors (1..8) of sprite animation palette right (1 loops per shift)

; [ Animation Script $0126: Razor Leaf (bg1) ] (Changed from original)

org $D04917
	db $89,$70				; loop start (112 times)
org $D0491C
	db $83,$63				; move forward 4

; [ Animation Script $0127: Razor Leaf (bg3) ] (Changed from original)

org $D0493E
	db $89,$70				; loop start (112 times)
org $D04943
	db $83,$63				; move forward 4

; [ Animation Script $009C: Regen, RegenX (sprite) ]

org $D065C0
	db $50,$20				; speed 6, align to center of character/monster
	db $9A					; set facing direction to match attacker
	db $83,$AF				; move up/forward 16
	db $C9,$00				; play default sound effect
	db $E9,$1F,$1F			; move animation randomly (0..31,0..31)
	db $8B,$0C				; animated loop start (12 times)
	db $00					; [$00]
	db $8C					; animated loop end
	db $8B,$08				; animated loop start (8 times)
	db $00					; [$00]
	db $8C					; animated loop end
	db $FF					; end of script
	db $FE					; 1d spare byte

; [ Animation Script $00E9: Storm (bg1) ] (Changed from original)

org $D00024
	db $89,$0A				; loop start (10 times)
	db $83,$02				; move down/forward 3
org $D0003C
	db $89,$1E				; loop start (30 times)
	db $83,$02				; move down/forward 3
org $D0005E
	db $89,$40				; loop start (64 times)
org $D00070
	db $89,$0B				; loop start (12 times)


; [ Animation Script $0246: Lifeshaver (bg1) ]

org $D00D35
	db $00,$00				; speed 1, align to bottom of character/monster
	db $EE,$20				; set target sprite tile priority to 2
	db $D1,$01				; invalidate character/monster sprite priority
	db $CC,$FF				; set bg1 animation palette color subtraction to 31 (black)
	db $89,$08				; loop start (8 times)
	db $83,$2F				; move down 16
	db $8A					; loop end
	db $00					; [$00]
	db $BD,$A0				; hide bg1 thread
	db $C9,$00				; play default sound effect
	db $89,$1F				; loop start (31 times)
	db $CF,$F1				; decrease bg1 animation palette color subtraction by 1 (black)
	db $A3,$16,$32			; shift colors (1..7) of bg1 animation/esper palette left (3 loops per shift)
	db $00					; [$00]
	db $BD,$A0				; hide bg1 thread
	db $8A					; loop end
	db $89,$40				; loop start (64 times)
	db $A3,$16,$32			; shift colors (1..7) of bg1 animation/esper palette left (3 loops per shift)
	db $00					; [$00]
	db $8A					; loop end
	db $89,$1F				; loop start (31 times)
	db $CF,$E1				; increase bg1 animation palette color subtraction by 1 (black)
	db $A3,$16,$32			; shift colors (1..7) of bg1 animation/esper palette left (3 loops per shift)
	db $00					; [$00]
	db $8A					; loop end
	db $FF					; end of script

; [ Animation Script $014D: Lifeshaver (sprite) ]

org $D00D63
	db $10,$00				; speed 2, align to bottom of character/monster
	db $80,$72,$01			; branch if attack hit
	db $FF					; end of script
	db $89,$10				; loop start (16 times)
	db $1F					; [---]
	db $8A					; loop end
	db $89,$08				; loop start (8 times)
	db $82,$07,$17			; change target graphic to 7 (jumping) if facing left or 23 (hands up, facing down) if facing right
	db $1F					; [---]
	db $82,$18,$37			; change target graphic to 24 (hands up, facing up) if facing left or 7 (jumping) if facing right
	db $1F					; [---]
	db $82,$37,$18			; change target graphic to 7 (jumping) if facing left or 24 (hands up, facing up) if facing right
	db $1F					; [---]
	db $82,$17,$07			; change target graphic to 23 (hands up, facing down) if facing left or 7 (jumping) if facing right
	db $1F					; [---]
	db $8A					; loop end
	db $82,$00,$00			; change target graphic to 0 (no action)
	db $FF					; end of script
	db $FE,$FE,$FE,$FE,$FE	; 10d spare bytes
	db $FE,$FE,$FE,$FE,$FE	