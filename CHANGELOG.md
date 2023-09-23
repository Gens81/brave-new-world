# Changelog

## [2.1.0](https://github.com/bropedio/brave-new-world/releases/tag/v2.1.0) - 2022/02/22

### Features

- The ATB bar now decrements to show the delay between command input and execution (-Bropedio)
- Esper summon effects are now shown in the EL/spell acquisition submenu (-SirNewtonFig)
- Wagers are no longer lost at the Colosseum if you lose the battle (-Bropedio)
- Defending now doubles a character's chances to cover healthy allies (-Seibaby)
- The Scan spell now displays HP and MP values for non-boss enemies (-Bropedio)
- The Water Rondo dance is no longer permanently missable (-SirNewtonFig)
- Attack is no longer capped at 255 (-Bropedio); this mostly affects the Excalibur (now 225 attack)
- The South Figaro basement is no longer accessible prior to Locke's scenario
- A certain boss is no longer mandatory once triggered (-Synchysi) and now better telegraphs its moves
- Added a textless patch to the Unlockme (-SirNewtonFig) and an Italian translation (-Gens/Ryo_Hazuki)
- Added an optional multitap patch to support up to 4 players (-SirNewtonFig)
- Added a deleted scene to the Unlockme.txt file

### Tweaks

- Celes now remains in her "Defend" stance as long as Runic is active (-Bropedio)
- The "Blind" status now affects your chance to successfully steal (-Bropedio)
- Increased the damage reduction for "friendly fire" from 50% to 75% (-Bropedio)
- Enemies who counter X-Magic now do so after the first spell rather than the second (-Bropedio)
- Elemental attacks which are nulled or absorbed no longer attempt to set statuses (-Bropedio)
- Golem no longer blocks non-damaging attacks or inherits resistances from its protectee (-Bropedio)
- Changed the palette of the Storm spell to better indicate that it's both wind and water elemental
- Fractional damage attacks will now do minor damage to bosses rather than missing (-Bropedio)
- Swapped the immunity to Blind on Siren with the immunity to Bserk on Stray
- The "Stop" effect on Suplex and the "Muddle" effect on Flurry now check enemy stamina for evasion
- The "7-7-7" Slots spin now heals just as much HP as a losing spin instead of slightly less
- Plasma is now just water damage (was water/bolt)
- Toxic Frog is now water/dark elemental (was just dark)
- Raised the attack of the Rune Blade to 150 (from 140)
- The Multiguard now blocks rather than absorbs Fire/Ice/Bolt
- The White Cape now blocks Stop instead of Bserk (and in addition to Imp/Mute)
- Renamed the Storm Belt (now Psycho Belt) to something more indicative of its true function
- The Megalixir now removes all negative statuses in addition to restoring all HP/MP
- Undead enemies are no longer inherently immune to Stop
- Rewrote the "ATB tutorial" gimmick back into Whelk's script
- Adjusted the timer in Phantom's script (should prevent "cheap" RNG deaths)
- Death by sap/poison/counter-attack no longer prevents the dying attack of "Giant" enemies (-Bropedio)
- Slightly rewrote 024's script to further reinforce the battle's intended mechanic
- Changed the behavior of the Cyborg/Robot/Android enemy group when hit with bolt damage
- The "Tek Armor" enemy group should no longer be able to set barrier on other enemies
- Lowered the magic defense of the Wight/Wraith/Revenant enemy group
- Kudzu and Locusts can now be encountered in the WoR so that their rages are no longer missable
- The "Ninja" enemy group can no longer re-vanish as a counter to having the status cleared
- Slightly adjusted Atma's script to further reinforce the battle's intended mechanic
- Removed inherent regen (which damages the undead) from Belladonna and Nightshade
- The Hoodwink and Windrunner enemies no longer always open with Blight
- Curly now heals Larry and Moe more frequently
- The merchant in Cyan's Nightmare now has better merchandise
- Removed the new Ebot's Rock save point as it was no longer needed
- Changed the Sketch results for Hidon and Guardian to something more (potentially) useful
- Changed the overworld sprites of the elemental dragons to more correctly match their color
- The White and Green Dragons now lose the sap status when healing themselves instead of gaining regen
- Reduced the overall damage output of the "Face" component in the first phase of the final battle
- Clarified several pieces of advice (including the post-Zozo cutscene) and some weapon descriptions
- Improved several minor bits of dialogue (special thanks to Field)
- Renamed a certain minor character (special thanks to Bauglir)
- Made a small improvement to the New Game Plus patch (-Bropedio)

### Bugfixes

- Fixed the exploit where status-prevention relics would cure negative statuses (-Seibaby)
- Enemies can no longer counter-attack counter-attacks (-Bropedio)
- Abilities which cure HP and remove statuses now work properly on petrified characters (-Bropedio)
- Fixed a rare bug where MP would fail to update correctly in the battle spell menu (-SirNewtonFig)
- Subsequent EL resets are now properly denied if the player lacks sufficient funds (-Synchysi)
- Cyan's starting vigor is now correctly set to 42 (instead of 43)
- Bad Breath no longer incorrectly sets Sap
- The Kunai and Ninjato now correctly possess the "anti-air" property
- The Tarot is now properly flagged as Holy elemental
- The Punisher now correctly grants the critical damage bonus to the Dark spell
- The Cursed Shield now correctly sets Sap instead of Condemned
- Crawlers no longer use Magnitude on low-level parties
- Fixed a error in Dadaluma's script when attempting to target invisible characters
- Behemoths and Diablos are now correctly immune to Sleep and are slightly less spammy with Meteo
- Fixed a bug in the Tentacle battle where characters seized at full ATB would freeze when discarded
- Tentacles C and D now have the correct defense and magic defense, respectively
- Fixed a bug where Chesticle's shell was using incorrect or no attacks
- Parasoul is no longer incorrectly immune to Stop
- Wrexsoul now correctly drops Force Armor instead of Genji Armor
- The Hidonites are now properly flagged as undead
- Fixed a targeting error in Hidon's script and made it less likely to miss learning Shield
- Fixed two minor visual bugs relating to cover (-Bropedio)
- The save point in the Ancient Castle is now the correct color
- The Lich and Kudzu rages are now listed in correct (alphabetical) order
- The Mute status no longer prevents Gau/Gogo from using Aqualung with the Chimera rage
- The 5x Chickenlip and 5x Anemone formations are now leapable and will appear on the Veldt
- Fixed minor visual glitches with two enemy formations (Tyrano/Troll and L1/L2 Mage)
- Set the correct enemy to be fought for betting a Life Bell at the Colosseum
- Set the correct battle entrance animation for Zone Eater and Land Worms
- Spellcasting animations should no longer persist through death
- Corrected the menu description for Raze to include the wind element
- Corrected the description for a certain key item to include its second effect
- Corrected the value of a certain hidden rare item (0 -> 2)
- Corrected the description of Lifeshaver in the (Unlockme) Printme
- Fixed an oversight in Asura's script which allowed her to potentially use N.Cross twice in a row
- Fixed an error in Kefka's script that was causing Meteor to be cast more frequently than intended
- Fixed some minor errors/typos in the BNWCP and Printme

## Previous Versions are not tracked by this Doc
