
org db $d85000
;************************************************************************************************
;	00 = type 01,02 = who ?0f = elemental properties 
;	10= vigor + speed 11 = speed + stamina 12 = spellcast 14= attack val 15=b hit rate 1C = Sp. Efx
;
;	00,01,02,03,04,05,06,07,08,09,0a,0b,0c,0d,0e,0f,10,11,12,13,14,15,16,17,18,19,1a,1b,1c,1d

	11,0A,13,00,00,00,00,00,00,00,00,00,10,00,01,00,0B,03,00,A2,3C,FF,00,00,00,00,00,C0,E8,03	;00 HealingShiv
	11,0A,12,00,00,00,00,00,00,00,00,00,10,00,41,00,00,00,00,82,32,64,00,00,00,00,00,00,64,00	;01 MythrilDirk
	11,08,00,00,00,00,00,00,00,00,00,00,11,00,41,00,00,70,00,00,AF,64,00,00,00,00,11,6C,02,00	;02 Kagenui     
	11,0A,12,00,00,00,00,00,00,00,00,00,10,00,41,00,03,00,00,82,4B,64,00,00,00,00,00,40,F4,01	;03 Butterfly   
	11,0A,12,00,00,00,00,00,00,00,00,00,10,00,41,00,50,00,00,82,64,64,00,00,00,00,01,14,02,00	;04 Switchblade 
	11,0A,12,00,00,00,00,00,00,00,00,00,10,00,41,00,33,00,00,82,78,64,00,00,00,00,01,F4,02,00	;05 Demonsbane  
	11,0A,12,00,00,00,00,00,00,00,00,00,10,00,41,00,05,00,00,82,A0,64,00,00,00,00,00,40,10,27	;06 ManEater   
	11,00,00,00,00,00,00,00,00,00,00,00,00,00,41,00,00,00,00,00,28,FF,00,00,00,00,00,04,00,00	;07 Kunai       
	11,0A,12,00,00,00,00,00,00,00,00,00,10,00,41,20,55,00,00,82,C8,64,00,00,00,00,01,04,02,00	;08 Avenger     
	01,02,00,00,00,00,00,00,00,00,00,00,10,00,00,00,05,00,00,00,AF,64,00,00,00,00,01,A4,02,00	;09 Valiance    
	01,53,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,4B,64,00,00,00,00,01,05,FA,00	;0A MythrilBolo
	01,53,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,00,00,80,64,64,00,00,00,00,01,05,F4,01	;0B IronCutlass
	01,53,00,00,00,00,00,00,00,00,00,00,12,00,00,00,33,00,00,80,96,64,00,00,00,00,01,05,C4,09	;0C Scimitar    
	01,53,00,00,00,00,00,00,00,00,00,00,00,00,00,01,03,30,45,80,7D,64,00,00,00,00,10,00,88,13	;0D Flametongue 
	01,53,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00,33,46,80,7D,64,00,00,00,00,10,00,88,13	;0E Icebrand    
	01,53,00,00,00,00,00,00,00,00,00,00,00,00,00,04,30,30,47,80,7D,64,00,00,00,00,10,00,88,13	;0F ElecSword     
	01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;10               
	01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;11          
	01,53,00,00,00,00,00,00,00,00,00,00,00,00,00,00,05,05,58,80,A0,64,00,00,00,00,01,05,02,00	;12 BloodSword 
	01,40,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,A5,64,00,00,00,00,00,00,D0,07	;13 Imperial    
	01,53,00,00,00,00,00,00,00,00,00,00,00,00,00,00,05,50,00,80,96,64,00,00,00,00,10,70,A8,61	;14 RuneBlade  
	01,53,00,00,00,00,00,00,00,00,00,00,12,00,00,00,55,00,00,80,C8,64,00,00,00,00,01,05,10,27	;15 Falchion    
	01,53,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,78,59,80,AF,64,00,00,00,00,10,00,02,00	;16 SoulSabre     
	01,53,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;17 
	01,53,00,00,00,00,00,00,00,00,00,00,18,00,00,00,07,70,00,C0,FF,64,00,00,00,00,11,75,02,00	;18 Excalibur   
	01,53,00,00,00,00,00,00,00,00,00,00,02,00,00,00,77,00,00,80,D2,FF,00,00,00,00,22,D5,02,00	;19 Zantetsuken
	01,40,00,00,00,00,00,00,00,00,00,00,00,00,00,00,55,55,4E,80,B4,64,00,00,00,00,11,70,02,00	;1A Illumina   
	01,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,55,55,4F,80,B4,64,00,00,00,00,11,70,02,00	;1B Apocalypse 
	01,53,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,E1,64,00,00,00,00,00,20,02,00	;1C AtmaWeapon 
	01,10,04,00,00,00,00,00,00,00,00,00,48,00,00,00,00,00,00,40,50,64,00,00,00,00,00,00,02,00	;1D MythrilPike
	01,10,04,00,00,00,00,00,00,10,00,00,48,00,00,80,00,00,00,40,64,64,00,00,00,00,00,00,B8,0B	;1E Trident    
	01,10,04,00,00,00,00,00,00,04,00,00,48,00,00,00,00,00,00,40,5A,64,00,00,00,00,00,00,DC,05	;1F StoutSpear 
	01,10,04,00,00,00,00,00,00,04,00,00,48,00,00,00,00,00,00,40,96,64,00,00,00,00,00,00,28,23	;20 Partisan   
	01,10,04,00,00,00,00,00,00,04,00,00,48,00,00,20,00,00,00,40,B4,64,00,00,00,00,00,00,02,00	;21 Longinus   
	01,10,04,00,00,00,00,00,00,10,00,00,48,00,00,01,00,00,00,40,78,64,00,00,00,00,00,00,70,17	;22 FireLance  
	01,10,04,00,00,00,00,00,00,08,00,00,48,00,00,00,00,00,00,40,A0,FF,00,00,00,00,00,00,02,00	;23 Gungnir    
	11,00,00,00,00,00,00,00,00,00,00,00,00,00,41,00,00,00,00,00,1E,FF,00,00,00,00,00,00,00,00	;24 PointyStick
	11,08,00,00,00,00,00,00,00,00,00,00,10,00,41,00,20,00,00,00,4B,64,00,00,00,00,11,0C,02,00	;25 Tanto      
	11,08,00,00,00,00,00,00,00,00,00,00,10,00,41,00,30,00,00,00,64,64,00,00,00,00,11,8C,FA,00	;26 Kunai 
	11,08,00,00,00,00,00,00,00,00,00,00,10,00,41,00,30,50,48,00,7D,64,00,00,00,00,11,0C,E8,03	;27 Sakura     
	11,08,00,00,00,00,00,00,00,00,00,00,10,00,41,00,50,00,00,00,96,64,00,00,00,00,11,8C,C4,09	;28 Ninjato    
	11,08,00,00,00,00,00,00,00,00,00,00,11,00,41,00,00,70,00,00,AF,64,00,00,00,00,11,6C,02,00	;29 Kagenui    
	11,08,00,00,00,00,00,00,00,00,00,00,10,00,41,00,70,00,00,00,C8,64,00,00,00,00,11,8C,02,00	;2A Orochi     
	01,0C,00,00,00,00,00,00,00,00,00,00,18,00,00,00,00,02,00,42,5A,64,00,00,00,00,01,05,02,00	;2B Hanzo      
	01,0C,00,00,00,00,00,00,00,00,00,00,1A,00,00,00,03,03,00,42,78,64,00,00,00,00,01,05,EE,02	;2C Kotetsu    
	01,0C,00,00,00,00,00,00,00,00,00,00,18,00,00,00,30,03,00,42,8C,64,00,00,00,00,01,D0,DC,05	;2D Ichimonji  
	01,0C,00,00,00,00,00,00,00,00,00,00,18,00,00,00,50,05,00,42,96,64,00,00,00,00,01,B0,02,00	;2E Kazekiri   
	01,0C,00,00,00,00,00,00,00,00,00,00,1A,00,00,00,05,05,00,42,A0,64,00,00,00,00,01,05,02,00	;2F Murasame   
	01,0C,00,00,00,00,00,00,00,00,00,00,1A,00,00,00,07,07,00,42,B4,64,00,00,00,00,01,05,02,00	;30 Masamune   
	11,00,00,00,00,00,00,00,00,00,00,00,00,00,41,00,00,00,00,00,14,00,00,00,00,00,00,00,00,00	;31 Spoon      
	01,0C,00,00,00,00,00,00,00,00,00,00,18,00,00,00,70,07,00,42,D2,64,00,00,00,00,01,E0,02,00	;32 Mutsunokami
	01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,00,00,00,00,5A,64,00,00,00,00,00,00,00,00	;33 SpookStick 
	01,80,15,00,00,00,00,00,00,00,00,00,00,00,00,00,00,03,00,00,5A,64,00,00,00,00,00,70,02,00	;34 MythrilRod 
	21,80,15,00,00,00,00,00,00,00,00,00,80,00,61,00,00,30,C5,00,78,64,00,00,00,00,00,70,C4,09	;35 Fire Rod
	21,80,15,00,00,00,00,00,00,00,00,00,80,00,61,00,00,30,C6,00,78,64,00,00,00,00,00,70,C4,09	;36 Ice Rod
	21,80,15,00,00,00,00,00,00,00,00,00,80,00,61,00,00,30,C7,00,78,64,00,00,00,00,00,70,C4,09	;37 Thunder Rod
	01,80,01,00,00,00,00,00,00,00,00,00,00,00,00,00,50,05,00,00,B4,64,00,00,00,00,01,E0,02,00	;38 WindBreaker
	01,80,15,00,00,00,00,00,00,00,00,00,80,00,00,00,00,33,4D,00,96,64,00,00,00,00,01,70,98,3A	;39 Doomstick
	01,80,15,00,00,00,00,00,00,00,00,00,80,00,00,00,00,07,57,00,96,64,00,00,00,00,01,70,88,13	;3A Quartrstaff
	01,80,15,00,00,00,00,00,00,00,00,00,80,00,00,00,00,77,50,00,96,64,00,00,00,00,01,70,02,00	;3B Punisher
	01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;3C
	01,00,11,00,00,00,00,00,00,00,00,04,01,00,01,00,00,30,00,20,3C,FF,00,00,00,00,10,C4,02,00	;3D Light Brush
	01,00,11,00,00,00,00,00,00,00,00,04,01,00,01,00,30,30,62,20,50,FF,00,00,00,00,10,C4,88,13	;3E Monet Brush
	01,00,11,00,00,00,00,00,00,00,00,04,01,00,01,00,30,50,63,20,64,FF,00,00,00,00,10,C4,02,00	;3F DaliBrush   
	01,00,11,00,00,00,00,00,00,00,00,04,01,00,01,00,50,50,68,20,78,FF,00,00,00,00,10,C4,02,00	;40 RossBrush  
	11,08,10,00,00,00,00,00,00,00,00,00,00,00,61,00,00,00,00,20,5A,FF,00,00,00,00,00,00,C8,00	;41 Shuriken   
	01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;42           
	11,08,10,00,00,00,00,00,00,00,00,00,00,00,61,00,00,00,00,20,FF,FF,00,00,00,00,00,00,02,00	;43 NinjaStar  
	01,00,28,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,32,64,00,00,00,00,00,00,F4,01	;44 Club       
	01,43,04,00,00,00,00,00,00,00,00,00,10,00,00,00,00,00,00,20,64,64,00,00,00,00,00,80,B8,0B	;45 Full Moon
	01,41,00,00,00,00,00,00,00,00,00,00,00,00,00,00,A0,00,00,00,7D,64,00,00,00,00,00,50,88,13	;46 Morning Star
	01,43,04,00,00,00,00,00,00,00,00,00,10,00,00,00,00,00,00,20,32,64,00,00,00,00,00,80,DC,05	;47 Boomerang
	01,43,04,00,00,00,00,00,00,00,00,00,10,00,00,00,00,00,00,20,82,64,00,00,00,00,00,80,28,23	;48 Rising Sun
	01,08,10,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,64,64,00,00,00,00,00,30,D0,07	;49 Kusarigama 
	01,00,28,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,64,00,00,00,00,00,00,02,00	;4A Bone Club   
	01,00,08,00,00,00,00,00,00,00,00,00,00,00,00,00,00,70,00,00,40,64,00,00,00,00,00,00,02,00	;4B MagicBone  
	01,43,04,00,00,00,00,00,00,00,00,00,10,00,00,00,00,00,00,20,A0,64,00,00,00,00,00,80,02,00	;4C Wing Edge
	01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;4D           
	01,00,02,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,78,64,00,00,00,00,00,00,E8,03	;4E Darts      
	01,00,02,00,00,00,00,00,00,00,00,00,00,00,00,20,00,00,00,20,8C,64,00,00,00,00,00,F0,02,00	;4F Tarot      
	01,00,02,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,A0,64,00,00,00,00,00,70,02,00	;50 ViperDarts 
	01,00,02,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,01,02,00,00,00,00,00,90,88,13	;51 Dice       
	01,00,02,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,01,03,00,00,00,00,00,90,02,00	;52 FixedDice  
	01,20,00,00,00,00,00,00,00,00,00,00,10,00,00,00,00,00,00,00,3C,64,00,00,00,00,00,00,02,00	;53 MythrilClaw
	01,20,00,00,00,00,00,00,00,00,00,00,10,00,00,20,23,00,66,00,50,64,00,00,00,00,00,00,EE,02	;54 SpiritClaw 
	01,20,00,00,00,00,00,00,00,00,00,00,10,00,00,08,03,02,43,00,5A,64,00,00,00,00,00,00,DC,05	;55 PoisonClaw 
	01,20,00,00,00,00,00,00,00,00,00,00,10,00,00,80,05,03,58,00,64,64,00,00,00,00,00,00,C4,09	;56 OceanClaw  
	01,20,00,00,00,00,00,00,00,00,00,00,10,00,00,01,35,00,40,00,78,64,00,00,00,00,00,00,88,13	;57 HellClaw   
	01,20,00,00,00,00,00,00,00,00,00,00,10,00,00,02,07,05,41,00,96,64,00,00,00,00,00,00,02,00	;58 Frostgore  
	01,20,00,00,00,00,00,00,00,00,00,00,10,00,00,04,57,00,42,00,B4,64,00,00,00,00,00,00,02,00	;59 Stormfang  
	03,d3,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,0a,0a,00,00,00,00,01,06,64,00	;5A

	03,53,00,00,00,00,00,00,00,00,00,00,00,00,00,00,a0,00,00,00,14,14,00,00,00,00,01,06,f4,01	;5B
	03,d3,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,0f,0f,00,00,00,00,01,06,e8,03	;5C
;	03,53,06,00,00,00,00,00,00,00,00,00,00,00,00,80,a0,00,00,00,1e,1e,00,00,00,00,11,06,b8,0b	;5D 93 Gold Shield
	03,53,06,00,00,00,00,00,08,00,00,00,00,00,00,00,50,00,00,00,19,19,00,00,00,00,22,0e,02,00	;5E Aegis Shield
;	03,53,06,00,00,00,00,00,00,00,00,00,00,00,00,04,a0,00,00,00,28,23,00,00,00,00,11,06,88,13	;5F 95 Diamond Kite
;	03,d3,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,03,30,00,00,14,1e,01,00,00,00,10,0a,02,00	;60 96 Flameguard
;	03,d3,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,00,33,00,00,14,1e,02,00,00,00,10,0a,02,00	;61 97 Iceguard
;	03,d3,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,30,30,00,00,14,1e,04,00,00,00,10,0a,02,00	;62 98 Thunderguard
;	03,53,06,00,00,00,00,00,00,00,00,00,00,00,00,10,a0,00,00,00,32,28,00,00,00,00,11,06,10,27	;63 99 Crystal Kite
	03,53,06,00,00,00,00,00,40,00,00,00,00,00,00,00,05,05,00,00,2d,1e,00,00,00,00,02,06,02,00	;64 Genji Shield
;	03,d3,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,bb,bb,00,00,14,1e,00,07,00,00,10,0a,10,27	;65 101 Multiguard
	03,43,00,00,00,00,00,00,00,00,00,00,00,00,00,00,05,50,00,00,28,28,00,00,00,40,11,0e,02,00	;66
	03,43,00,00,00,00,00,00,02,00,00,00,00,00,00,00,05,50,00,01,28,28,00,00,00,00,11,0e,02,00	;67
	03,53,06,00,00,00,00,00,20,00,00,00,00,00,00,00,00,50,00,00,1e,2d,00,00,00,00,20,0a,02,00	;68 Force Shield
	04,ff,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,0f,0a,00,00,00,00,00,00,64,00	;69
	04,41,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,00,00,05,0f,00,00,00,00,10,00,96,00	;6A
	04,ff,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,05,0a,00,00,00,00,11,00,fa,00	;6B
	04,0a,00,00,00,00,00,00,00,00,00,00,02,00,00,00,55,00,00,00,0a,19,00,00,00,00,11,00,02,00	;6C Ninja Mask
	04,c1,14,00,00,00,00,00,00,20,00,00,00,00,00,00,00,32,00,00,05,23,00,00,00,00,10,00,70,17	;6D Magus Hat
	04,ff,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,22,00,00,00,05,0a,00,00,00,00,01,00,c8,00	;6E
	04,55,00,00,00,00,00,00,00,00,00,00,00,00,00,00,a0,00,00,00,1e,14,00,00,00,00,00,00,f4,01	;6F
	04,ff,3f,00,00,00,00,00,00,00,00,00,00,00,00,00,00,07,00,00,1e,1e,00,00,00,00,00,00,02,00	;70
	04,ff,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,55,55,00,00,0a,0a,00,00,00,00,00,00,d0,07	;71
	04,ff,1f,00,00,00,00,00,00,90,00,00,00,00,00,00,00,03,00,00,0a,0a,00,00,00,00,11,00,e8,03	;72 Green Beret
	04,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;73
	04,5f,06,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,1e,14,00,00,00,00,00,00,d0,07	;74
	04,41,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,30,00,00,05,14,00,00,00,00,10,00,d0,07	;75
;	04,55,06,00,00,00,00,00,00,00,00,00,00,00,00,80,a0,00,00,00,1e,19,00,00,00,00,00,00,94,11	;76 118 Gold Helm
;	04,20,08,00,00,00,00,00,00,00,00,00,00,00,00,01,35,00,00,00,05,0f,00,00,00,00,02,00,b8,0b	;77 119 Tiger Mask
	04,ff,1f,00,00,00,00,00,00,24,00,00,00,00,00,00,00,05,00,00,0f,0f,00,00,00,00,11,00,02,00	;78 Red Cap
	04,41,00,00,00,00,00,00,00,00,00,00,80,00,00,00,02,30,00,00,05,19,00,00,00,00,01,00,88,13	;79
	04,c1,14,00,00,00,00,00,00,40,00,00,00,00,00,00,00,53,00,00,0a,2d,00,00,00,00,10,00,a8,61	;7A Circlet
	04,10,14,00,00,00,00,00,00,00,80,00,00,00,00,00,05,30,00,00,14,28,00,00,00,00,10,00,02,00	;7B
;	04,55,06,00,00,00,00,00,00,00,00,00,00,00,00,04,a0,00,00,00,23,1e,00,00,00,00,00,00,4c,1d	;7C 124 Diamond Helm
	04,ff,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,50,00,00,00,0a,19,00,00,00,00,02,00,10,27	;7D
;	04,55,06,00,00,00,00,00,00,00,00,00,00,00,00,10,a0,00,00,00,28,23,00,00,00,00,00,00,98,3a	;7E 126 Crystal Helm
	04,41,00,00,00,00,00,00,00,00,00,00,80,00,00,00,03,50,00,00,0a,23,00,00,00,00,01,00,20,4e	;7F
	04,00,09,00,00,00,00,00,00,00,00,00,00,00,00,00,50,50,00,00,0a,1e,00,00,00,00,11,00,02,00	;80
	04,5f,06,00,00,00,00,00,00,00,00,00,00,00,00,00,05,03,00,00,28,14,00,00,00,00,01,00,02,00	;81
	04,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;82
	04,ff,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;83
	02,ff,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,1e,19,00,00,00,00,00,00,2c,01	;84
	02,e1,04,00,00,00,00,00,00,00,00,00,00,00,00,00,00,22,00,00,14,1e,00,00,00,00,10,00,f4,01	;85
	02,2a,08,00,00,00,00,00,00,00,00,00,00,00,00,00,22,00,00,00,19,14,00,00,00,00,01,00,90,01	;86
	02,55,00,00,00,00,00,00,00,00,00,00,00,00,00,00,b0,00,00,00,2d,1e,00,00,00,00,00,00,e8,03	;87
	02,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;88
	02,ff,1f,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,28,19,00,00,00,00,01,00,e8,03	;89
	02,2a,08,00,00,00,00,00,00,00,00,00,00,00,00,00,33,00,00,00,1e,14,00,00,00,00,02,00,c4,09	;8A
	02,41,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,50,00,00,14,28,00,00,00,00,20,00,b8,0b	;8B
	02,5f,06,00,00,00,00,00,00,00,00,00,00,00,00,00,a0,00,00,00,32,23,00,00,00,00,00,00,94,11	;8C
;	02,2a,0c,00,00,00,00,00,00,00,00,00,00,00,00,40,03,05,00,00,23,1e,00,00,00,00,02,00,88,13	;8D 141 Gaia Gear
	02,ff,1f,00,00,00,00,00,08,00,00,00,00,00,00,00,70,00,00,00,23,23,00,00,00,00,22,00,02,00	;8E Mirage Vest
;	02,55,06,00,00,00,00,00,00,00,00,00,00,00,00,80,b0,00,00,00,37,28,00,00,00,00,00,00,28,23	;8F 143 Gold Armor
	02,55,06,00,00,00,00,00,00,00,00,00,00,00,00,00,05,03,00,00,28,19,00,00,00,00,00,00,4c,1d	;90
	02,e1,04,00,00,00,00,00,00,00,00,00,00,00,00,00,00,55,00,00,19,32,00,00,00,00,20,00,98,3a	;91
;	02,ff,1f,00,00,00,00,00,00,00,00,00,00,00,00,04,00,00,00,00,37,23,00,00,00,00,01,00,10,27	;92 146 Diamond Vest
	02,30,00,00,00,00,00,00,00,04,00,00,00,00,00,00,05,00,00,00,32,28,00,00,00,00,02,00,02,00	;93 147 Royal Jacket
;	02,55,06,00,00,00,00,00,00,00,00,00,00,00,00,07,00,70,00,00,23,46,00,00,00,00,10,00,02,00	;94 148 Force Armor
	02,55,06,00,00,00,00,00,00,00,00,00,00,00,00,04,b0,00,00,00,41,2d,00,00,00,00,00,00,98,3a	;95 149 Diamond Mail
	02,2a,0c,00,00,00,00,00,00,00,00,00,00,00,00,00,55,00,00,00,28,23,00,00,00,00,02,00,20,4e	;96
	02,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;97
;	02,55,06,00,00,00,00,00,00,00,00,00,00,00,00,10,b0,00,00,00,4b,32,00,00,00,00,00,00,30,75	;98 152 Crystal Mail
	02,00,01,00,00,00,00,00,00,20,00,00,80,00,00,00,00,50,00,00,28,32,00,00,00,00,20,00,02,00	;99 Radiant Gown
	02,5f,06,00,00,00,00,00,00,00,00,00,00,00,00,00,07,07,00,00,46,23,00,00,00,00,01,00,02,00	;9A
;	02,ff,1f,00,00,00,00,00,00,00,00,00,00,00,00,14,ff,00,00,00,46,46,00,00,00,00,00,00,20,4e	;9B 155 Lazy Shell
;	02,41,00,00,00,00,00,00,00,00,00,00,00,00,00,00,05,50,00,00,32,32,00,07,00,00,11,00,02,00	;9C 156 Minerva
;	02,80,19,00,00,00,00,00,00,00,00,00,00,00,00,40,30,30,00,00,19,1e,00,00,00,00,11,00,02,00	;9D 157 Tabby Hide
;	02,80,19,00,00,00,00,00,00,00,00,00,00,00,00,80,30,03,00,00,1e,23,00,00,00,00,11,00,02,00	;9E 158 Gator Hide
;	02,80,19,00,00,00,00,00,00,00,00,00,00,00,00,90,50,05,00,00,23,28,00,00,00,00,11,00,02,00	;9F 159 Chocobo Hide
;	02,80,19,00,00,00,00,00,00,00,00,00,00,00,00,50,50,50,00,00,28,2d,00,00,00,00,11,00,02,00	;A0 160 Moogle Hide
;	02,80,19,00,00,00,00,00,00,00,00,00,00,00,00,11,00,77,00,00,32,37,00,00,00,00,11,00,02,00	;A1 161 Dragon Hide
;	02,00,3c,00,00,00,00,00,00,04,00,00,00,00,00,00,b0,00,00,00,3c,3c,00,12,00,00,00,00,02,00	;A2 162 Snow Muffler
	00,10,10,00,00,00,00,00,00,00,00,00,00,00,6a,00,00,00,00,20,00,ff,00,00,00,00,00,00,e8,03	;A3
	00,10,10,00,00,00,00,00,00,00,00,00,00,00,6a,00,00,00,00,20,2d,ff,00,00,00,00,00,00,88,13	;A4
	00,10,10,00,00,00,00,00,00,00,00,00,00,00,6a,00,00,00,00,20,3c,ff,00,00,00,00,00,00,98,3a	;A5
	00,00,00,00,00,00,00,00,00,00,00,00,00,00,41,00,00,00,00,20,ff,ff,00,00,00,00,00,00,02,00	;A6
	00,10,10,00,00,00,00,00,00,00,00,00,00,00,03,00,00,00,00,20,0a,ff,00,00,00,00,00,00,30,75	;A7
	00,10,10,00,00,00,00,00,00,00,00,00,00,00,41,00,00,00,00,20,c8,ff,00,00,00,00,00,00,10,27	;A8
	00,00,00,00,00,00,00,00,00,00,00,00,00,00,03,00,00,00,00,20,00,ff,00,00,00,00,00,00,00,00	;A9
	00,10,10,00,00,00,00,00,00,00,00,00,00,00,6a,00,00,00,00,20,b4,64,00,00,00,00,00,00,f4,01	;AA
	16,08,10,00,00,00,00,00,00,00,00,00,00,00,6e,00,00,00,00,00,00,00,00,00,00,00,00,00,f4,01	;AB
	16,08,10,00,00,00,00,00,00,00,00,00,00,00,6e,00,00,00,00,00,00,00,00,00,00,00,00,00,f4,01	;AC
	16,08,10,00,00,00,00,00,00,00,00,00,00,00,6e,00,00,00,00,00,00,00,00,00,00,00,00,00,f4,01	;AD
	16,00,00,00,00,00,00,00,00,00,00,00,00,00,23,00,00,00,00,00,00,10,00,00,00,00,00,00,e8,03	;AE
	16,08,10,00,00,00,00,00,00,00,00,00,00,00,03,00,00,00,00,00,00,00,04,00,00,00,00,00,64,00	;AF
	05,40,10,00,00,00,00,00,00,00,10,10,42,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00	;B0 Leo's Crest
	05,ff,3f,00,00,00,04,00,00,00,00,00,00,00,00,00,00,22,00,00,00,05,00,00,00,00,00,00,f4,01	;B1 Bracelet
	05,ff,3f,00,00,00,45,00,00,00,00,00,00,00,00,00,05,05,00,00,0f,00,00,00,00,00,00,00,b8,0b	;B2 Spirit Stone
	05,ff,3f,00,00,00,00,b0,00,00,00,00,00,00,00,00,00,55,00,00,00,0f,00,00,00,00,00,00,70,17	;B3 Amulet
	05,ff,3f,00,00,00,20,08,10,00,00,00,00,00,00,00,30,50,00,00,00,00,00,00,00,00,10,07,c4,09	;B4 White Cape
	05,ff,3f,00,00,00,05,00,00,00,00,00,00,00,00,00,03,03,00,00,0a,00,00,00,00,00,00,00,e8,03	;B5 Talisman
	05,ff,3f,00,00,00,00,a0,00,00,00,00,00,00,00,00,00,33,00,00,00,0a,00,00,00,00,00,00,dc,05	;B6 Fairy Charm
	05,ff,3f,00,00,00,00,00,00,00,00,00,00,01,00,00,00,00,00,00,00,14,00,00,00,00,00,00,c4,09	;B7
	05,ff,3f,00,00,00,00,00,00,00,00,00,00,02,00,00,00,00,00,00,14,00,00,00,00,00,00,00,dc,05	;B8
	05,ff,3f,00,00,00,00,00,40,00,00,00,00,00,00,00,00,00,00,00,05,0f,00,00,00,00,00,00,4c,1d	;B9 Guard Ring
	05,ff,3f,00,00,00,00,00,08,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00,b8,0b	;BA Sprint Shoes
	05,ff,3f,00,00,00,00,00,80,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00	;BB Reflect Ring
	06,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;BC
	06,00,00,00,00,00,00,00,00,00,00,00,00,08,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00	;BD
	05,ff,3f,00,00,00,00,00,00,10,00,00,40,00,00,00,35,00,00,00,00,00,00,00,00,00,01,07,e8,03	;BE Knight Cape
	05,10,14,00,00,00,00,00,00,00,04,00,80,00,00,00,53,00,00,00,00,00,00,00,00,00,02,00,88,13	;BF
	05,ff,3f,00,00,00,00,00,00,00,00,00,00,04,00,00,70,05,00,00,00,00,00,00,00,00,11,07,02,00	;C0
	05,ff,3f,00,00,01,00,00,00,00,00,00,20,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,d0,07	;C1
;	05,ff,3f,00,00,00,00,00,00,08,00,00,00,00,00,00,00,00,00,00,00,00,00,28,d7,00,00,00,88,13	;C2 194 Black Heart
	05,ff,3f,00,00,00,00,00,00,40,00,00,00,00,00,00,00,70,00,00,00,00,00,00,00,00,20,00,02,00	;C3 Magic Cube
	
	05,ff,3f,00,00,00,00,00,00,01,00,00,00,00,00,00,07,00,00,00,00,00,00,00,00,00,00,00,02,00	;C4 Power Glove
;	05,00,28,00,00,00,00,00,00,02,00,00,00,00,00,00,00,05,00,00,00,00,00,01,00,00,00,00,02,00	;C5 197 Blizzard Orb
;	05,00,28,00,00,00,00,00,00,01,00,00,00,00,00,00,50,00,00,00,00,00,00,04,00,00,00,00,02,00	;C6 198 Psycho Belt
	05,0a,00,00,00,00,00,00,00,02,00,10,00,00,00,00,30,50,00,00,00,00,00,00,00,00,10,07,02,00	;C7 Rogue Cloak
	05,ff,3f,00,00,00,00,00,20,00,00,00,00,00,00,00,00,00,00,00,0f,05,00,00,00,00,00,00,10,27	;C8 Wall Ring
	05,ff,3f,00,00,00,00,00,00,24,00,00,40,00,00,00,07,70,00,00,00,00,00,00,00,00,00,00,02,00	;C9 Hero Ring
	05,ff,3f,00,00,00,c2,01,10,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,22,00,02,00	;CA Ribbon
	05,ff,1f,00,00,00,00,00,00,05,00,00,00,00,00,00,00,00,00,00,0a,0a,00,00,00,00,00,00,02,00	;CB Muscle Belt
	05,ff,1f,00,00,00,00,00,00,22,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00	;CC Crystal Orb
	05,ff,3f,00,00,00,01,00,00,00,00,00,00,00,00,00,02,02,00,00,05,00,00,00,00,00,00,00,f4,01	;CD Goggles
	05,40,00,00,00,00,00,00,00,00,00,20,00,00,00,00,00,70,00,00,00,14,00,00,00,00,00,00,02,00	;CE
	05,02,10,00,00,00,00,00,00,01,40,00,00,00,00,00,35,00,00,00,00,00,00,00,00,00,01,00,02,00	;CF Thief Glove
	06,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;D0
	06,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;D1
	05,ff,3f,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,10,00,00,88,13	;D2 Hyper Wrist
	05,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;D3
	05,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;D4
	05,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;D5
	05,00,12,00,00,00,00,00,00,00,20,00,00,00,00,00,50,05,00,00,00,0a,00,00,00,00,00,00,02,00	;D6
	05,82,04,00,00,00,00,00,00,00,08,00,00,00,00,00,00,33,00,00,00,0a,00,00,00,00,00,00,02,00	;D7
	05,01,00,00,00,00,00,00,00,00,00,20,00,00,00,00,07,00,00,00,14,00,00,00,00,00,00,00,02,00	;D8
	05,34,00,00,00,00,00,00,00,03,00,00,00,00,00,00,03,03,00,00,0a,00,00,00,00,00,00,00,02,00	;D9 Nirvana Band
	05,00,20,00,00,00,00,00,00,00,00,40,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,00	;DA
	05,08,01,04,32,00,00,00,00,00,00,00,00,00,00,00,00,77,00,01,00,00,00,00,00,00,10,00,02,00	;DB
	05,ff,3f,00,00,00,00,00,60,00,00,00,00,00,00,00,00,07,00,01,00,00,00,00,00,00,00,00,02,00	;DC Quartz Charm
;	05,ff,3f,00,00,00,65,b9,00,00,00,00,00,80,00,00,00,00,00,00,00,00,08,00,21,00,00,00,e8,03	;DD 221 Ghost Ring
	05,00,14,00,00,00,00,00,00,00,00,00,00,20,00,00,70,07,00,00,00,00,00,00,00,00,01,00,02,00	;DE
	05,ff,3f,00,00,00,00,00,00,00,00,10,02,00,00,00,70,00,00,00,00,00,00,00,00,00,00,00,02,00	;DF Black Belt
	05,00,00,00,00,00,00,60,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;D0
	05,ff,3f,00,00,00,00,00,00,00,02,00,00,00,00,00,00,00,00,00,14,14,00,00,00,00,00,00,94,11	;E1
	05,41,01,00,00,00,00,00,00,00,01,00,00,00,00,00,50,03,00,00,00,00,00,00,00,00,20,00,10,27	;E2
	05,ff,3f,00,00,00,00,00,00,90,00,00,00,00,00,00,55,55,00,00,00,00,00,00,00,00,00,00,70,17	;E3 Stat Stick
	05,00,02,00,00,00,00,00,00,00,00,00,01,00,00,00,05,05,00,00,0a,00,00,00,00,00,00,00,02,00	;E4
	05,ff,3f,00,00,00,00,00,02,00,00,00,00,00,00,00,00,05,00,00,00,00,00,00,00,00,00,00,02,00	;E5 Life Bell
	05,41,01,00,00,02,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00	;E6
	46,00,00,00,00,02,00,00,00,00,00,00,00,00,03,00,00,00,00,00,00,00,00,00,00,00,00,ff,39,05   ;E7
	66,00,00,00,00,00,00,00,00,00,00,00,00,00,03,00,00,00,00,88,08,00,00,00,00,00,00,00,f4,01   ;E8
	66,00,00,00,00,00,00,00,00,00,00,00,00,00,03,00,00,00,00,88,0c,00,00,00,00,00,00,00,d0,07   ;E9
	26,00,00,00,00,00,00,00,00,00,00,00,00,00,2e,00,00,00,00,88,0c,00,00,00,00,00,00,00,02,00   ;EA
	66,00,00,00,00,00,00,00,00,00,00,00,00,00,03,00,00,00,00,10,32,00,00,00,00,00,00,00,e8,03   ;EB
	66,00,00,00,00,00,00,00,00,00,00,00,00,00,03,00,00,00,00,90,0c,00,00,00,00,00,00,00,02,00   ;EC
	26,00,00,00,00,00,00,00,00,00,00,00,00,00,2e,00,00,00,00,90,0c,00,00,00,00,00,00,00,02,00   ;ED
	26,00,00,00,00,00,00,00,00,00,00,00,00,00,03,00,00,00,00,b8,10,65,b8,14,00,00,00,04,02,00   ;EE
														   ,