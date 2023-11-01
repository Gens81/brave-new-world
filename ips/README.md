# Brave New World IPS Data

The `ips/` directory contains individual ips patches for
several distinct categories of data modifications to FF6.

We intentionally avoid tracking complete dumps of entire
sections of the ROM, since this begins to enter murky
copyright territory.

When making changes to an ips file, please update this
readme with detailed explanation of changes.

## Files

### FF6 Version Reversion (0-reversion.ips)
Force converts any ff3v1.1 base rom into a ff3v1.0 rom.
All changes are in banks $C1 and $C2, mostly related to
reverting the "official" Sketch bug fix. This patch must
be applied before anything else.

### BTB Base (btb-base.ips)
Contains the majority of data changes that make up BNW.
In the future, we may split this patch up into smaller chunks.

#### Data
- $C19104:$C1911C - Magitek menu and targeting
- $C2ADE1:$C2AF21 - Status diplay when selecting target
- $C46AC0:$C478C0 - Spell data
- $C478C0:$C47A40 - Character names
- $C47A40:$C47AA0 - Blitz codes
- $C47AC0:$C47F40 - Shop data
- $C47F40:$C47FC0 - Metamorph data (cleared out w/ $FF)
- $C487C0:$C48FC0 - Fixed-width font graphics
- $C48FC0:$C490C0 - Variable-width character widths
- $C490C0:$C4A4C0 - Variable-width font graphics
- $CCE600:$CEF100 - Dialog (Script)
- $CEF100:$CEF600 - Map names
- $CEFB60:$CF0000 - Rare item names and descriptions
- $CF0000:$CF3000 - Monster data
- $CF3000:$CF3600 - Monster items
- $CF37C0:$CF3940 - Monster special attacks
- $CF3C40:$CF3D00 - Bushido names
- $CF3D00:$CF4800 - Monster muddle/sketch/rage attacks
- $CF4800:$CF5800 - Battle groups
- $CF5800:$CF5900 - Random battle probabilities
- $CF5900:$CF6200 - Auxiliary battle data
- $CF6200:$CF8400 - Battle data
- $CF8400:$CFC050 - Monster scripts
- $CFC050:$CFD0D0 - Monster names
- $CFD0D0:$CFDFE0 - Special attack names
- $CFDFE0:$CFF450 - Short battle dialog
- $CFFC00:$CFFE00 - Blitz & Bushido descriptions
- $CFFE00:$CFFE40 - Battle command data
- $CFFE40:$CFFE80 - Esper attack descriptions
- $CFFE80:$CFFEA0 - Dance data
- $CFFEAE:$CFFF9E - Esper bonus names
- $CFFF9E:$CFFFBE - Pointers to blitz & bushido descriptions
- $D07FB2:$D09800 - Attack animation data
- $D0D000:$D0FD00 - Long battle dialog
- $D1F000:$D1F9A0 - Battle messages
- $D1F9AB:$D1F9D0 - Dance background data
- $D26F00:$D27000 - Item symbol names
- $D2B300:$D2C000 - Item names
- $D25000:$D83000 - Field sprite graphics (TODO-split out?)
- $D85000:$D86E00 - Item data
- $D86E00:$D87000 - Esper data
- $D8C9A0:$D8CEA0 - Spell descriptions
- $D8CEA0:$D8CF80 - Battle command names
- $D8CF80:$D8D000 - Pointers to spell descriptions
- $DFB400:$DFB600 - Magic points per battle
- $DFB600:$DFBA00 - Colosseum data
- $E68400:$E68780 - Pointers to map names
- $E6F200:$E6F490 - Palette animation color palettes
- $E6F490:$E6F564 - Skills/HP/MP on level up
- $E6F564:$E6F567 - Initial lores
- $E6F567:$E70000 - Magic, esper, attack, esper attack names
- $ECE3C0:$ECE400 - Terra & Celes natural magic levels
- $ECE400:$ECE800 - Weapon and monster animation data
- $ED0000:$ED1D00 - Menu window graphics and palettes
- $ED6400:$ED7CA0 - Item & Lore descriptions
- $ED7CA0:$ED8220 - Character initial properties
- $ED8220:$ED82E4 - Character experience progression table
- $EDFE00:$EE0000 - Esper bonus descriptions
- $EEB200:$EEB260 - Pointers to compressed world data (TODO?)
- $EF4A46:$EF6A56 - World of Ruin graphics (TODO?)

### Graphics (graphics.ips)
Contains `custom-uncensored.ips`, which reverts many graphics
to their original Japanese form.

#### Data
- $D27000:$D27820 - Monster graphics metadata
- $D27820:$D2A820 - Monster palettes
- $D2A820:$D2B300 - Monster graphic maps
- $E97000:$ECE3C0 - Monster graphics
- $ED6300:$ED6400 - Character palettes

### Maps (maps.ips)
Map-related changes, including map tiles and graphics, event
triggers, chest locations, battle formations per map.

* Cave to Ancient Castle now includes underwater section (-Fig)

#### Data
- $C40000:$C41A10 - Event triggers
- $C41A10:$C46AC0 - NPC data

  TODO: Remove this junk. It's garbage from FF3usME, random event offsets
- $CCE602:$CD0000 - Pointers to dialogue TODO WHY
        "start": "cff00",
        "end": "cff58",

- $CF5600:$CF5800 - Map battle groups
- $D1FA00:$D20000 - Map startup event pointers
- $D8E6BA:$D8E800 - Serpent trench palettes
- $D9CD90:$DE0000 - Map formations
- $DFBB00:$DFDA00 - Short entrance triggers
- $ED82F4:$ED8E5B - Treasure data
- $ED8F00:$EDC480 - Map properties
