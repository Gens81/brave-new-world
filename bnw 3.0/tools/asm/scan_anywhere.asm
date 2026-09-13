hirom
table "menu.tbl", ltr

; #########################################################################
; Scan Anywhere
;
; Pressing X or Y while targeting a foe in battle now automatically
; shows its HP/MP or status ailments, without the need to cast Scan.
;
; "Scan" still shows enemy weaknesses.

!hints_raw = #$5A ; offset where the block of hints live in battle messages
!hints = !hints_raw-1 ; accounts for 1-based indexing

; #########################################################################
; NOTE: Uses RAM: $3A5C-$3A5D
; This RAM used to be for Mind Blast, but is now free, I think

!auto_scan = $3A5C ; enemy pending to be auto-scanned

; #########################################################################
; Hook into main battle engine for Scan check (clears Quick handling)

org $C2001B
CheckScanCursor:
  LDA $06             ; get X pressed
  ORA $07             ; get Y pressed
  NOP
  JSR AutoScan        ; continue scan check

; #########################################################################
; Scan Effect (overwrites "scan-free.asm" from 2.0)
; Uncomment the asm below to make the following changes to Scan:
; * No longer prevent counterattack
; * No longer grant free turn for characters
; 
; org $C23C5B
; ScanEffect:
;   TYX             ; put target index in X
;   LDA #$27        ; scan command id
;   JMP $4E91       ; queue scan command in global action queue
; %free($C23C6E)

; #########################################################################
; Point to new scan command location
org $C21A15 : dw FullScan ; (not changed)

; #########################################################################
; (no change, just ensuring labels are at correct org)

org $C250DD         
LongMsgArg:
  STA $2F35           ; save param for message
LongMsg:
  PHA                 ; store A
  PHP                 ; store flags
  SEP #$20            ; 8-bit A
  LDA #$04            ; "Message" animation type
  JSR $6411           ; process message animation
  PLP                 ; restore flags
  PLA                 ; restore A
  RTL

; #########################################################################
; Move and rewrite full scan command, add various helpers

org $C25120

FullScan:
  LDX $B6             ; get target of original casting
  JSL ScanWeak
  RTS

AutoScan:
  AND #$40            ; check for X or Y pressed
  BEQ .set_buff       ; set scan buffer to zero if not pressed
  LDA $7B7E           ; current cursor enemy bitmask
  CMP !auto_scan      ; does it match last scanned
  BEQ .done           ; exit if same as last scanned
.set_buff
  STA !auto_scan      ; save bitmask of last enemy scanned (or zero)
  CMP #$00            ; no target selected or no X/Y press
  BEQ .done           ; exit if no enemy targeted
  JSL AutoScanFork    ; else, continue scan fork
.done
  RTS

; #########################################################################
; JSL Scan routines

org $C4F1D0

ScanInit:
  LDA #$FF            ; null (end of script marker)
  STA $2D72           ; set end-of-script flag
  LDA #$02            ; "Display Battle Msg" command ID
  STA $2D6E           ; set battle command ID
  STZ $2F37           ; clear message parameter
  STZ $2F3A           ; clear message parameter
  RTS

AutoScanFork:
  PHP                 ; store flags
  LDX #$06            ; first monster index minus 2
.loop
  INX #2              ; next monster index
  LSR                 ; shift bitmask
  BCC .loop           ; loop till index is found
  BNE .exit           ; skip if multiple enemies selected
  JSR ScanInit        ; clear params, set "battle message" op

.check_x
  BIT $06             ; pressing X check
  BVC .check_y        ; branch if not ^
.scan_hp
  LDA #$2F            ; "No weakness" TODO: Modify this message
  STA $2D6F           ; set message ID
  LDA $3C95,X         ; enemy flags-2
  ASL                 ; shift "scripted death" bit to N
  BMI .msg_exit       ; branch if ^
  LDA $3C80,X         ; enemy flags-1
  BIT #$04            ; "fractional immune"
  BNE .msg_exit       ; branch if ^
  INC $2D6F           ; "HP .../..." message ID
  REP #$20            ; 16-bit A
  LDA $3C1C,X         ; max HP
  STA $2F38           ; save in msg data
  LDA $3BF4,X         ; current HP 
  JSL LongMsgArg      ; set arg, execute msg
  INC $2D6F           ; "MP .../..." message ID
  LDA $3C30,X         ; max MP
  BEQ .exit           ; skip MP display if zero max mp
  STA $2F38           ; save in msg data
  LDA $3C08,X         ; current MP
.msg_exit
  JSL LongMsgArg      ; set arg, execute msg
.exit
  PLP                 ; restore flags
  RTL

.check_y
  BIT $07             ; pressing Y check 
  BVC .exit           ; show statuses if ^
.scan_status
  LDA #$47            ; first status message ID
  STA $2D6F           ; set message ID
  REP #$20            ; 16-bit A
  LDY #$00            ; initialize message counter
  LDA #$F825          ; statuses (1-2) to scan
  STA $EE             ; store ^
  LDA $3EE4,X         ; current status (1-2)
  STA $EC             ; store ^
  JSR CheckEach       ; process these statuses
  LDA #$84FE          ; statuses (3-4) to scan
  STA $EE             ; store ^
  LDA $3EF8,X         ; current status (3-4)
  STA $EC             ; store ^
  JSR CheckEach       ; process these statuses
  DEY                 ; check if count not zero
  BPL .exit           ; exit if at least one status msg
  JSL LongMsg         ; process "No statuses" message (#$58)
  BRA .exit

ScanWeak:
  JSR ScanInit        ; initialize scan args
.ai
  LDA $3C94,X         ; AI hint message ID
.do_hint
  PHA                 ; store backup
  AND #$0F            ; get this nibble
  BEQ .next_hint      ; skip if zero
  CLC : ADC !hints    ; get message ID
  STA $2D6F           ; set message ID
  JSL LongMsg         ; process message box animation
.next_hint
  PLA                 ; get backup hints
  LSR #4              ; shift next hint
  BNE .do_hint        ; loop if hint remaining
.weak
  LDA #$15            ; first weakness message ID
  STA $2D6F           ; set message ID
  TDC                 ; zero A/B
  TAY                 ; zero Y
  DEC                 ; #$FF (elements to scan)
  STA $EE             ; store ^
  LDA $3BE0,X         ; weaknesses to check
  STA $EC             ; store ^
  LDA $3BE1,X         ; resisted elements
  ORA $3BCC,X         ; absorbed elements
  ORA $3BCD,X         ; immune elements
  TRB $EC             ; remove resisted, absorbed, immune elements
  JSR CheckEach       ; process these elements

  ; -- Uncomment this code to show "No Weaknesses" message again --
  ; DEY                 ; check if count not zero
  ; BPL .exit           ; exit if at least one weakness
  ; LDA #$2C            ; "No Weakness" message
  ; STA $2D6F           ; set message ID
  ; JSL LongMsg         ; process "No Weakness" message animation

.exit
  RTL

CheckEach:
  TDC                 ; zero A/B
  INC                 ; first bit to check
.loop  
  BIT $EE             ; check if in list of "to check"
  BEQ .next           ; skip if not checking
  BIT $EC             ; check if in current status
  BEQ .skip           ; skip if not ^
  INY                 ; increment status message counter
  JSL LongMsg         ; process message box animation
.skip
  INC $2D6F           ; set message ID for next status
.next
  ASL                 ; shift bit to check
  BNE .loop           ; loop if still bits left
  RTS

; ------------------------------------------------------------------------
; Helper for Runic Stance patch (copied here, shifted down)

StanceCheck:     ; 21 bytes
  LDA ($78),Y    ; attacker index (vanilla code)
  ASL            ; index * 2
  TAY            ; index it
  LDA $3E4C,Y    ; runic byte
  LSR            ; shift $04 (runic) -> $02
  ORA $3AA1,Y    ; defend byte
  BIT #$02       ; is runic or defend set?
  SEC            ; default to abort
  BNE .abort     ; exit/abort if either set
  TYA            ; attacker index * 2
  LSR            ; restore index
  CMP #$04       ; in character range (abort if carry set)
.abort
  RTL

; ------------------------------------------------------------------------
; Should be free through $C4F2DB
; %free($C4F2DB)

; ------------------------------------------------------------------------
; Reset attacking character sprite to default (update target JSL)

org $C1AB8E : JSL StanceCheck ; Skip reset for Runic or DefendRTL

; Repurposes the "Metamorph" byte for all monsters, for displaying Scan hints (for BNW v3.0)
; Least significant nibble is the first message
; Most significant nibble is the second message, when applicable
;
; Hints (ordered by priority)	Nibble	Freq.	Notes
; ---							0		---		This means no message is displayed
; No useful information			1		28		Used for enemies with very basic scripts
; Dangerous!					2		66		Used for all Bosses
; Kind-hearted...?				3		10		Used for Lakshmi, Magic Pot, Shemp, Umaro, Tritoch, Treachery, Shiva, Ifrit
; Strong attack on a timer		4		62
; Dangerous when alone			5		43
; Dangerous at lower HP			6		33		Used for Zone Eater as well
; Punishes bad status			7		26
; Dangerous when buffed			8		10
; Dangerous when invisible		9		5
; Counters melee attacks		10		53
; Counters any attack			11		26
; Changes tactics when hit		12		14
; Hunts last attacker			13		7
; Weakness is more effective	14		38
; Weaker to a specific status	15		7
;
;					   Enemy Name		First Hint					  Second Hint
org $CF0011 : db $01 ; Guard            No useful information         ---
org $CF0031 : db $01 ; Soldier          No useful information         ---
org $CF0051 : db $0A ; Phalanx          Counters melee attacks        ---
org $CF0071 : db $B9 ; Ninja            Dangerous when invisible      Counters any attack
org $CF0091 : db $06 ; Samurai          Dangerous at lower HP         ---
org $CF00B1 : db $CA ; Shokan           Counters melee attacks        Changes tactics when hit
org $CF00D1 : db $05 ; Mag Roader       Dangerous when alone          ---
org $CF00F1 : db $06 ; Retainer         Dangerous at lower HP         ---
org $CF0111 : db $04 ; Conjurer         Strong attack on a timer      ---
org $CF0131 : db $0C ; Dahling          Changes tactics when hit      ---
org $CF0151 : db $EA ; Parasoul         Counters melee attacks        Weakness is more effective
org $CF0171 : db $05 ; Scrapper         Dangerous when alone          ---
org $CF0191 : db $A5 ; Gargoyle         Dangerous when alone          Counters melee attacks
org $CF01B1 : db $02 ; Wrexsoul         Dangerous!                    ---
org $CF01D1 : db $07 ; Spirit           Punishes bad status           ---
org $CF01F1 : db $05 ; Lich             Dangerous when alone          ---
org $CF0231 : db $08 ; Officer          Dangerous when buffed         ---
org $CF0251 : db $A4 ; Foamy            Strong attack on a timer      Counters melee attacks
org $CF0271 : db $01 ; Sewer Rat        No useful information         ---
org $CF02B1 : db $E6 ; Rhyhorn          Dangerous at lower HP         Weakness is more effective
org $CF02D1 : db $0B ; Ogre Nix         Counters any attack           ---
org $CF02F1 : db $01 ; Leafer           No useful information         ---
org $CF0311 : db $04 ; Stray Cat        Strong attack on a timer      ---
org $CF0331 : db $05 ; Lobo             Dangerous when alone          ---
org $CF0351 : db $A4 ; Banshee          Strong attack on a timer      Counters melee attacks
org $CF0371 : db $01 ; Mammoth          No useful information         ---
org $CF0391 : db $06 ; Pooch            Dangerous at lower HP         ---
org $CF03B1 : db $05 ; Adamantite       Dangerous when alone          ---
org $CF03D1 : db $05 ; Suriander        Dangerous when alone          ---
org $CF03F1 : db $CB ; Chimera          Counters any attack           Changes tactics when hit
org $CF0411 : db $A6 ; Behemoth         Dangerous at lower HP         Counters melee attacks
org $CF0431 : db $04 ; Mesosaur         Strong attack on a timer      ---
org $CF0451 : db $04 ; Albatross        Strong attack on a timer      ---
org $CF0471 : db $0A ; Fossilfang       Counters melee attacks        ---
org $CF0491 : db $02 ; White-D          Dangerous!                    ---
org $CF04B1 : db $03 ; Shemp            Kind-hearted...?              ---
org $CF04F1 : db $E6 ; Tyrano           Dangerous at lower HP         Weakness is more effective
org $CF0511 : db $01 ; Raven            No useful information         ---
org $CF0531 : db $05 ; Beakor           Dangerous when alone          ---
org $CF0551 : db $A4 ; Buzzard          Strong attack on a timer      Counters melee attacks
org $CF0591 : db $01 ; Mudcrab          No useful information         ---
org $CF05B1 : db $ED ; Cyborg           Hunts last attacker           Weakness is more effective
org $CF05D1 : db $0A ; Hornet           Counters melee attacks        ---
org $CF05F1 : db $07 ; Cricket          Punishes bad status           ---
org $CF0611 : db $0C ; Beetle           Changes tactics when hit      ---
org $CF0651 : db $EA ; Trillium         Counters melee attacks        Weakness is more effective
org $CF0671 : db $E4 ; Nightshade       Strong attack on a timer      Weakness is more effective
org $CF0691 : db $0E ; Tumbleweed       Weakness is more effective    ---
org $CF06B1 : db $05 ; Plantpire        Dangerous when alone          ---
org $CF06D1 : db $04 ; Trilobite        Strong attack on a timer      ---
org $CF06F1 : db $32 ; Siegfried        Dangerous!                    Kind-hearted...?
org $CF0711 : db $ED ; Nautiloid        Hunts last attacker           Weakness is more effective
org $CF0731 : db $01 ; Exocite          No useful information         ---
org $CF0751 : db $07 ; Anguiform        Punishes bad status           ---
org $CF0771 : db $0E ; Leap Frog        Weakness is more effective    ---
org $CF0791 : db $A5 ; Basilisk         Dangerous when alone          Counters melee attacks
org $CF07B1 : db $04 ; Chickenlip       Strong attack on a timer      ---
org $CF07D1 : db $FB ; Sand Worm        Counters any attack           Weaker to a specific status
org $CF07F1 : db $A6 ; Thanatos         Dangerous at lower HP         Counters melee attacks
org $CF0831 : db $E7 ; Onion Kid        Punishes bad status           Weakness is more effective
org $CF0851 : db $01 ; Tek Armor        No useful information         ---
org $CF0871 : db $0E ; Sky Armor        Weakness is more effective    ---
org $CF0891 : db $74 ; Telstar          Strong attack on a timer      Punishes bad status
org $CF08B1 : db $B4 ; WEAPON           Strong attack on a timer      Counters any attack
org $CF08D1 : db $A4 ; Vaporite         Strong attack on a timer      Counters melee attacks
org $CF08F1 : db $01 ; Flan             No useful information         ---
org $CF0911 : db $06 ; Jinn             Dangerous at lower HP         ---
org $CF0931 : db $08 ; Humpty           Dangerous when buffed         ---
org $CF0951 : db $04 ; Brainpan         Strong attack on a timer      ---
org $CF0971 : db $06 ; Cave Stuff       Dangerous at lower HP         ---
org $CF0991 : db $01 ; Cactuar          No useful information         ---
org $CF09D1 : db $04 ; Hobo             Strong attack on a timer      ---
org $CF09F1 : db $A6 ; Bomb             Dangerous at lower HP         Counters melee attacks
org $CF0A31 : db $05 ; Boxxy            Dangerous when alone          ---
org $CF0A51 : db $A5 ; Slamdancer       Dangerous when alone          Counters melee attacks
org $CF0A71 : db $B6 ; Giant            Dangerous at lower HP         Counters any attack
org $CF0A91 : db $02 ; Pug              Dangerous!		                ---
org $CF0AB1 : db $03 ; Magic Pot        Kind-hearted...?              ---
org $CF0B11 : db $06 ; Buffalax         Dangerous at lower HP         ---
org $CF0B31 : db $07 ; Eukaryote        Punishes bad status           ---
org $CF0B51 : db $05 ; Wight            Dangerous when alone          ---
org $CF0B71 : db $08 ; Troll            Dangerous when buffed         ---
org $CF0B91 : db $01 ; Sand Ray         No useful information         ---
org $CF0BB1 : db $0A ; Antlion          Counters melee attacks        ---
org $CF0BD1 : db $A4 ; Sea Flower       Strong attack on a timer      Counters melee attacks
org $CF0BF1 : db $01 ; Sand Devil       No useful information         ---
org $CF0C11 : db $E4 ; Europa           Strong attack on a timer      Weakness is more effective
org $CF0C31 : db $E7 ; Marlboro         Punishes bad status           Weakness is more effective
org $CF0C51 : db $01 ; Crawler          No useful information         ---
org $CF0C71 : db $07 ; Eye Goo          Punishes bad status           ---
org $CF0C91 : db $02 ; Captain          Dangerous!                    ---
org $CF0CB1 : db $08 ; Trooper          Dangerous when buffed         ---
org $CF0CD1 : db $0A ; Templar          Counters melee attacks        ---
org $CF0CF1 : db $B9 ; Shinobi          Dangerous when invisible      Counters any attack
org $CF0D11 : db $CA ; Tarokan          Counters melee attacks        Changes tactics when hit
org $CF0D31 : db $04 ; Warlock          Strong attack on a timer      ---
org $CF0D51 : db $0C ; Maiden           Changes tactics when hit      ---
org $CF0D71 : db $EA ; Rain Man         Counters melee attacks        Weakness is more effective
org $CF0D91 : db $05 ; Fighter          Dangerous when alone          ---
org $CF0DB1 : db $A5 ; Mephisto         Dangerous when alone          Counters melee attacks
org $CF0DF1 : db $05 ; Powerslave       Dangerous when alone          ---
org $CF0E11 : db $A4 ; Osteosaur        Strong attack on a timer      Counters melee attacks
org $CF0E31 : db $0A ; Doberman         Counters melee attacks        ---
org $CF0E51 : db $A4 ; Rocky            Strong attack on a timer      Counters melee attacks
org $CF0E71 : db $01 ; Plague Rat       No useful information         ---
org $CF0E91 : db $05 ; Black Bear       Dangerous when alone          ---
org $CF0EB1 : db $E6 ; Rhydon           Dangerous at lower HP         Weakness is more effective
org $CF0ED1 : db $04 ; Rabite           Strong attack on a timer      ---
org $CF0EF1 : db $04 ; Wild Cat         Strong attack on a timer      ---
org $CF0F11 : db $05 ; Red Wolf         Dangerous when alone          ---
org $CF0F31 : db $0A ; Rottweiler       Counters melee attacks        ---
org $CF0F51 : db $E6 ; Tusker           Dangerous at lower HP         Weakness is more effective
org $CF0F71 : db $06 ; Doggo            Dangerous at lower HP         ---
org $CF0FB1 : db $75 ; Wart Puck        Dangerous when alone          Punishes bad status
org $CF0FD1 : db $CB ; Manticore        Counters any attack           Changes tactics when hit
org $CF0FF1 : db $02 ; Intangir Z       Dangerous!                    ---
org $CF1011 : db $04 ; Raptor           Strong attack on a timer      ---
org $CF1031 : db $04 ; Wyvern           Strong attack on a timer      ---
org $CF1051 : db $0A ; Zombone          Counters melee attacks        ---
org $CF1091 : db $E6 ; Brontosaur       Dangerous at lower HP         Weakness is more effective
org $CF10B1 : db $01 ; Dinosaur         No useful information         ---
org $CF10D1 : db $04 ; Cockatrice       Strong attack on a timer      ---
org $CF10F1 : db $75 ; Windrunner       Dangerous when alone          Punishes bad status
org $CF1111 : db $A4 ; Vulture          Strong attack on a timer      Counters melee attacks
org $CF1131 : db $06 ; Griffin          Dangerous at lower HP         ---
org $CF1151 : db $01 ; Hermit           No useful information         ---
org $CF1171 : db $ED ; Robot            Hunts last attacker           Weakness is more effective
org $CF11B1 : db $07 ; Dragonfly        Punishes bad status           ---
org $CF11D1 : db $0C ; Scarab           Changes tactics when hit      ---
org $CF11F1 : db $E4 ; Zorathian        Strong attack on a timer      Weakness is more effective
org $CF1211 : db $EA ; Mandrake         Counters melee attacks        Weakness is more effective
org $CF1231 : db $E4 ; Belladonna       Strong attack on a timer      Weakness is more effective
org $CF1251 : db $0C ; Atlasphere       Changes tactics when hit      ---
org $CF1271 : db $05 ; Weedula          Dangerous when alone          ---
org $CF1291 : db $05 ; Primordite       Dangerous when alone          ---
org $CF12B1 : db $0E ; Callisto         Weakness is more effective    ---
org $CF12D1 : db $ED ; Cephalid         Hunts last attacker           Weakness is more effective
org $CF12F1 : db $05 ; Clawglip         Dangerous when alone          ---
org $CF1311 : db $E7 ; Frogger          Punishes bad status           Weakness is more effective
org $CF1331 : db $A5 ; Komodo           Dangerous when alone          Counters melee attacks
org $CF1351 : db $04 ; Cluck            Strong attack on a timer      ---
org $CF1371 : db $F4 ; Land Worm        Strong attack on a timer      Weaker to a specific status
org $CF1391 : db $A6 ; Reaper           Dangerous at lower HP         Counters melee attacks
org $CF13B1 : db $08 ; Ganymede         Dangerous when buffed         ---
org $CF13D1 : db $E7 ; Tiny Tim         Punishes bad status           Weakness is more effective
org $CF13F1 : db $08 ; Mega Armor       Dangerous when buffed         ---
org $CF1411 : db $74 ; Chaser           Strong attack on a timer      Punishes bad status
org $CF1431 : db $B4 ; Warmech          Strong attack on a timer      Counters any attack
org $CF1451 : db $A4 ; Ectoplasm        Strong attack on a timer      Counters melee attacks
org $CF1491 : db $06 ; Djinni           Dangerous at lower HP         ---
org $CF14B1 : db $08 ; Dumpty           Dangerous when buffed         ---
org $CF14D1 : db $06 ; Pond Scum        Dangerous at lower HP         ---
org $CF14F1 : db $F7 ; Puff Goo         Punishes bad status           Weaker to a specific status
org $CF1511 : db $09 ; Mechanix         Dangerous when invisible      ---
org $CF1531 : db $04 ; Drifter          Strong attack on a timer      ---
org $CF1551 : db $A6 ; Grenade          Dangerous at lower HP         Counters melee attacks
org $CF1571 : db $A4 ; Succubus         Strong attack on a timer      Counters melee attacks
org $CF1591 : db $05 ; Pan Dora         Dangerous when alone          ---
org $CF15B1 : db $A5 ; Souldancer       Dangerous when alone          Counters melee attacks
org $CF15D1 : db $B6 ; Colossus         Dangerous at lower HP         Counters any attack
org $CF15F1 : db $0D ; Mag Roadie       Hunts last attacker           ---
org $CF1631 : db $07 ; Prokaryote       Punishes bad status           ---
org $CF1671 : db $A4 ; Scorpion         Strong attack on a timer      Counters melee attacks
org $CF1691 : db $A4 ; Sponge           Strong attack on a timer      Counters melee attacks
org $CF16B1 : db $01 ; Sea Devil        No useful information         ---
org $CF16F1 : db $E7 ; Devil Weed       Punishes bad status           Weakness is more effective
org $CF1711 : db $04 ; Slurm            Strong attack on a timer      ---
org $CF1731 : db $07 ; Latimeria        Punishes bad status           ---
org $CF1751 : db $0A ; Zombie           Counters melee attacks        ---
org $CF1771 : db $A4 ; Bonelord         Strong attack on a timer      Counters melee attacks
org $CF1791 : db $04 ; Mu               Strong attack on a timer      ---
org $CF17B1 : db $B9 ; Assassin         Dangerous when invisible      Counters any attack
org $CF17D1 : db $C7 ; Madam            Punishes bad status           Changes tactics when hit
org $CF17F1 : db $EA ; Umbro            Counters melee attacks        Weakness is more effective
org $CF1811 : db $07 ; Specter          Punishes bad status           ---
org $CF1831 : db $CA ; Gorokan          Counters melee attacks        Changes tactics when hit
org $CF1871 : db $04 ; Dark Hare        Strong attack on a timer      ---
org $CF1891 : db $F4 ; Wizard           Strong attack on a timer      Weaker to a specific status
org $CF18B1 : db $05 ; Brawler          Dangerous when alone          ---
org $CF18D1 : db $E6 ; Rhyperior        Dangerous at lower HP         Weakness is more effective
org $CF18F1 : db $08 ; Commando         Dangerous when buffed         ---
org $CF1911 : db $06 ; Opinicus         Dangerous at lower HP         ---
org $CF1931 : db $A4 ; Nutkin           Strong attack on a timer      Counters melee attacks
org $CF1951 : db $05 ; Lunaris          Dangerous when alone          ---
org $CF1971 : db $0A ; Foxhound         Counters melee attacks        ---
org $CF1991 : db $04 ; Condor           Strong attack on a timer      ---
org $CF19B1 : db $75 ; Hoodwink         Dangerous when alone          Punishes bad status
org $CF19D1 : db $E6 ; Nastidon         Dangerous at lower HP         Weakness is more effective
org $CF1A11 : db $07 ; Locust           Punishes bad status           ---
org $CF1A31 : db $01 ; Vermin           No useful information         ---
org $CF1A51 : db $E4 ; Mantodea         Strong attack on a timer      Weakness is more effective
org $CF1A71 : db $06 ; Chupacabra       Dangerous at lower HP         ---
org $CF1A91 : db $05 ; Grizzly          Dangerous when alone          ---
org $CF1AB1 : db $0A ; Necrosaur        Counters melee attacks        ---
org $CF1AD1 : db $05 ; Adamantoid       Dangerous when alone          ---
org $CF1AF1 : db $A6 ; Death            Dangerous at lower HP         Counters melee attacks
org $CF1B11 : db $04 ; Dactyl           Strong attack on a timer      ---
org $CF1B51 : db $A4 ; Fuzzy            Strong attack on a timer      Counters melee attacks
org $CF1B71 : db $01 ; Tofu             No useful information         ---
org $CF1B91 : db $06 ; O-Bake           Dangerous at lower HP         ---
org $CF1BB1 : db $04 ; Vagrant          Strong attack on a timer      ---
org $CF1BF1 : db $01 ; Repo Man         No useful information         ---
org $CF1C11 : db $A6 ; Diablos          Dangerous at lower HP         Counters melee attacks
org $CF1C71 : db $0E ; Spitfire         Weakness is more effective    ---
org $CF1C91 : db $CB ; Sphinx           Counters any attack           Changes tactics when hit
org $CF1CB1 : db $05 ; Wraith           Dangerous when alone          ---
org $CF1CD1 : db $A4 ; Osprey           Strong attack on a timer      Counters melee attacks
org $CF1CF1 : db $05 ; Hot Wheels       Dangerous when alone          ---
org $CF1D11 : db $0A ; Wasp             Counters melee attacks        ---
org $CF1D31 : db $A4 ; Anemone          Strong attack on a timer      Counters melee attacks
org $CF1D51 : db $E4 ; Arsenal          Strong attack on a timer      Weakness is more effective
org $CF1D71 : db $75 ; Racer            Dangerous when alone          Punishes bad status
org $CF1D91 : db $06 ; Roc              Dangerous at lower HP         ---
org $CF1DB1 : db $ED ; Android          Hunts last attacker           Weakness is more effective
org $CF1DD1 : db $EA ; Kudzu            Counters melee attacks        Weakness is more effective
org $CF1DF1 : db $09 ; Junkie           Dangerous when invisible      ---
org $CF1E11 : db $A5 ; Tapdancer        Dangerous when alone          Counters melee attacks
org $CF1E31 : db $05 ; Revenant         Dangerous when alone          ---
org $CF1E51 : db $B6 ; Titan            Dangerous at lower HP         Counters any attack
org $CF1E71 : db $D7 ; Low Rider        Punishes bad status           Hunts last attacker
org $CF1EB1 : db $05 ; Gold Bear        Dangerous when alone          ---
org $CF1ED1 : db $B4 ; Searcher         Strong attack on a timer      Counters any attack
org $CF1EF1 : db $0F ; Witch            Weaker to a specific statu    ---
org $CF1F11 : db $05 ; Werewolf         Dangerous when alone          ---
org $CF1F31 : db $A4 ; Didalos          Strong attack on a timer      Counters melee attacks
org $CF1F51 : db $0F ; Fiend            Weaker to a specific statu    ---
org $CF1F71 : db $04 ; Ahriman          Strong attack on a timer      ---
org $CF1F91 : db $EC ; Autobot          Changes tactics when hit      Weakness is more effective
org $CF1FB1 : db $E7 ; Iron Man         Punishes bad status           Weakness is more effective
org $CF1FD1 : db $B4 ; Io               Strong attack on a timer      Counters any attack
org $CF1FF1 : db $0B ; Tonberry         Counters any attack           ---
org $CF2011 : db $02 ; Whelk            Dangerous!                    ---
org $CF2031 : db $0B ; Chesticle        Counters any attack           ---
org $CF2051 : db $08 ; Robomech         Dangerous when buffed         ---
org $CF2071 : db $02 ; Vargas           Dangerous!                    ---
org $CF2091 : db $02 ; Hell Angel       Dangerous!                    ---
org $CF20B1 : db $B6 ; Prometheus       Dangerous at lower HP         Counters any attack
org $CF20D1 : db $02 ; Soul Train       Dangerous!                    ---
org $CF20F1 : db $02 ; Dadaluma         Dangerous!                    ---
org $CF2111 : db $03 ; Shiva            Kind-hearted...?              ---
org $CF2131 : db $03 ; Ifrit            Kind-hearted...?              ---
org $CF2151 : db $02 ; Number 024       Dangerous!                    ---
org $CF2171 : db $02 ; Number 128       Dangerous!                    ---
org $CF2191 : db $02 ; Inferno          Dangerous!                    ---
org $CF21B1 : db $02 ; Crane            Dangerous!                    ---
org $CF2211 : db $03 ; !Umaro           Kind-hearted...?              ---
org $CF2231 : db $02 ; Guardian (Vec    Dangerous!                    ---
org $CF2251 : db $02 ; Guardian         Dangerous!                    ---
org $CF2271 : db $02 ; IAF              Dangerous!                    ---
org $CF22D1 : db $02 ; Heartfire        Dangerous!                    ---
org $CF22F1 : db $02 ; Atma             Dangerous!                    ---
org $CF2311 : db $02 ; Nimufu           Dangerous!                    ---
org $CF2331 : db $0B ; Intangir         Counters any attack           ---
org $CF2371 : db $02 ; Tentacle A       Dangerous!                    ---
org $CF2391 : db $02 ; Dullahan         Dangerous!                    ---
org $CF23B1 : db $02 ; Doom Gaze        Dangerous!                    ---
org $CF23D1 : db $03 ; Lakshmi          Kind-hearted...?              ---
org $CF23F1 : db $02 ; Curly            Dangerous!                    ---
org $CF2411 : db $02 ; Larry            Dangerous!                    ---
org $CF2431 : db $02 ; Moe              Dangerous!                    ---
org $CF2471 : db $02 ; Hidon            Dangerous!                    ---
org $CF2491 : db $64 ; Katanasoul       Strong attack on a timer      Dangerous at lower HP
org $CF24B1 : db $0B ; Lv.4 Mage        Counters any attack           ---
org $CF24D1 : db $02 ; !Blinky          Dangerous!                    ---
org $CF24F1 : db $02 ; Asura            Dangerous!                    ---
org $CF2511 : db $02 ; Isis             Dangerous!                    ---
org $CF2531 : db $02 ; Myria            Dangerous!                    ---
org $CF2551 : db $02 ; Kefka            Dangerous!                    ---
org $CF2571 : db $EB ; Lv.3 Mage        Counters any attack           Weakness is more effective
org $CF2591 : db $02 ; Ultros           Dangerous!                    ---
org $CF25B1 : db $02 ; Ultros           Dangerous!                    ---
org $CF25D1 : db $02 ; Ultros           Dangerous!                    ---
org $CF25F1 : db $02 ; Chupon           Dangerous!                    ---
org $CF2611 : db $04 ; Lv.2 Mage        Strong attack on a timer      ---
org $CF2631 : db $01 ; Zeigfried        No useful information         ---
org $CF2651 : db $01 ; Lv.1 Mage        No useful information         ---
org $CF2671 : db $01 ; Lv.5 Mage        No useful information         ---
org $CF2691 : db $02 ; !Whelk           Dangerous!                    ---
org $CF26B1 : db $07 ; !Chesticle       Punishes bad status           ---
org $CF26F1 : db $02 ; Kaiser           Dangerous!                    ---
org $CF2711 : db $0B ; Master T         Counters any attack           ---
org $CF2731 : db $0F ; Lv.8 Mage        Weaker to a specific statu    ---
org $CF2751 : db $01 ; Merchant         No useful information         ---
org $CF2771 : db $01 ; Nude Dude        No useful information         ---
org $CF2791 : db $02 ; Tentacle B       Dangerous!                    ---
org $CF27B1 : db $02 ; Tentacle C       Dangerous!                    ---
org $CF27D1 : db $02 ; Tentacle D       Dangerous!                    ---
org $CF27F1 : db $02 ; !Rapier          Dangerous!                    ---
org $CF2811 : db $02 ; !Saber           Dangerous!                    ---
org $CF2831 : db $02 ; !Striker         Dangerous!                    ---
org $CF2851 : db $02 ; !Rake            Dangerous!                    ---
org $CF2871 : db $04 ; Lv.9 Mage        Strong attack on a timer      ---
org $CF2891 : db $03 ; !Tritoch         Kind-hearted...?              ---
org $CF28B1 : db $02 ; !Right Bay       Dangerous!                    ---
org $CF28F1 : db $02 ; !Left Bay        Dangerous!                    ---
org $CF2911 : db $02 ; Chadarnook       Dangerous!                    ---
org $CF2931 : db $02 ; Silver-D         Dangerous!                    ---
org $CF2951 : db $02 ; Kefka            Dangerous!                    ---
org $CF2971 : db $02 ; Purple-D         Dangerous!                    ---
org $CF2991 : db $02 ; Brown-D          Dangerous!                    ---
org $CF29B1 : db $05 ; Bear             Dangerous when alone          ---
org $CF2A11 : db $02 ; Gold-D           Dangerous!                    ---
org $CF2A31 : db $02 ; Green-D          Dangerous!                    ---
org $CF2A51 : db $02 ; Blue-D           Dangerous!                    ---
org $CF2A71 : db $02 ; Red-D            Dangerous!                    ---
org $CF2A91 : db $01 ; Piranha          No useful information         ---
org $CF2AB1 : db $02 ; Rizopas          Dangerous!                    ---
org $CF2AD1 : db $04 ; Phantom          Strong attack on a timer      ---
org $CF2AF1 : db $B5 ; Limbo            Dangerous when alone          Counters any attack
org $CF2B11 : db $0B ; Lust             Counters any attack           ---
org $CF2B31 : db $04 ; Gluttony         Strong attack on a timer      ---
org $CF2B51 : db $05 ; Wrath            Dangerous when alone          ---
org $CF2B71 : db $05 ; Greed            Dangerous when alone          ---
org $CF2B91 : db $0B ; Heresy           Counters any attack           ---
org $CF2BB1 : db $0B ; Violence         Counters any attack           ---
org $CF2BD1 : db $45 ; Fraud            Dangerous when alone          Strong attack on a timer
org $CF2BF1 : db $03 ; Treachery        Kind-hearted...?              ---
org $CF2C11 : db $02 ; !Pinky           Dangerous!                    ---
org $CF2C31 : db $02 ; !Kinky           Dangerous!                    ---
org $CF2C51 : db $02 ; !Clyde           Dangerous!                    ---
org $CF2C71 : db $0C ; Lv.6 Mage        Changes tactics when hit      ---
org $CF2C91 : db $08 ; Lv.7 Mage        Dangerous when buffed         ---
org $CF2CB1 : db $E4 ; Proto Man        Strong attack on a timer      Weakness is more effective
org $CF2CD1 : db $02 ; MagiMaster       Dangerous!                    ---
org $CF2CF1 : db $02 ; Soulblazer       Dangerous!                    ---
org $CF2D11 : db $02 ; Ultros           Dangerous!                    ---
org $CF2D31 : db $01 ; Bat Lady         No useful information         ---
org $CF2D51 : db $02 ; Phunbaba (1)     Dangerous!                    ---
org $CF2D71 : db $02 ; Phunbaba (2)     Dangerous!                    ---
org $CF2D91 : db $02 ; Phunbaba         Dangerous!                    ---
org $CF2E31 : db $06 ; Zone Eater       Dangerous at lower HP         ---
org $CF2EB1 : db $01 ; Trooper (Lock    No useful information         ---
org $CF2ED1 : db $02 ; Centurion        Dangerous!                    ---
org $CF2EF1 : db $02 ; Kefka            Dangerous!                    ---
org $CF2FB1 : db $02 ; Ultima           Dangerous!                    ---

