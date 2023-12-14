# Upcoming

### b23 (not yet released)
- added a line about the new rage menu to Gau's tutorial
- difficulty selector in config menu (Nowea, Seibaby): Normal/Hard (Hard doubles enemy's speed)
- added Choreography hack (by Sir Newton Fig) for testing:

This patch restructures the Dance command, breaking each biome's list of steps up into two categories: Shift steps and Repeat steps.
Shift steps are those that can be chosen from when you dance a new background.
Repeat steps are those that can be chosen when you choose a dance that matches the current background.
There are 2 steps in each category, with probabilities as follows:
Shift steps: 80%/20%
Repeat steps: 60%/40%

Due to the fluid nature of this system, the following core Dance mechanics have also changed:
Dance status is no longer persistent under any circumstances.
Instead, the Moogle Charm removes stumble rates entirely (otherwise dictated by Stamina).
The intended purpose of this patch is to replace unpredictability with effort and planning.
Any time you select a Dance, there will only be 2 possible outcomes, one of which is more likely than the other to occur. By mixing up dances from round to round, you can create routines of desired effects instead of simply camping out on a single Dance and hoping for the best – though this can still be useful at times, too. 

### 2.2 roadmap:
- Power/target alt description 
- Fixed dual wield penalty shown regardless of whether you're using a second weapon
- Fixed "If Near Fatal causes Zinger to be removed from a target, any remaining strikes will target whoever is in the 2nd slot"
- Added Brave New World subtitle to the ingame animated title
- Allow Esper menu to open "Curative Ally Targeting" submenu
- Import Alphabetical Lore by Silent Enigma: useless for english version but useful for translations or future lores edits
- Phoenix glitch fix
- Disintegration animation for enemies that get petrified
- fix Hp leak (aka Phantasm) doing more damage on chars with high stamina

### "Bro new world" features to port:
- If "Fight" will yield a desperation attack, the text is yellow 
- Scan anytime (HP/MP accessible via X, Status via Y, weaknesses and AI hints via scan)
- Status tick rate not affected by speed/haste/slow
- Defend work against piercing (ignore defense) attacks
- Dog Block and Golem preempt check for cover
- Smart targeting
	Random targeting behaves differently 50% of the time
	If setting/toggling status, selects target without the status
	If lifting status, select target with the status
	If damaging/healing, selects near fatal target

### Events
- Restore Shadow cutscene during Soul train fight
- Banon's death reference at the end of Thamasa events 
	Terra: Where's Banon?
	Edgar: (head down) He_<D> didn't make it out.
- Add "CT - Mistery from the past" track to Ultima's sealed door
- Add Esper portrait to the menu before Phunbaba 3rd fight

### Bugfixes/features temporarily discarded:
- Import Snaphat compression algorythm
- Stuck in a pose (walking pose in events like npc unequip)
- Bird bars (setzer position after bar-bar-bar palidor)
- Banon riding chocobo pose 
- Imperial camp dialogue fix (sabin aware of doma without speaking to Shadow)
- Bottom shadow for menu letters q,p,g,y,j
- Oceanic line anomaly
- Good doggy by Bropedio (no dmg numbers on dog block)

### BIB ideas:
- Myria fixed back attack
- Rods consume MP only when procs spells
- Physical blitzes can crit
- Remove 1 fight in IAF and/or Mine Cart
- Magitek rided by humans are stealable
- Remove Siren from BAR-BAR-BAR pool
- Gray out null values on shop details menu
- Raise Slow accuracy

### Long-term goals (3.0?):
- Colosseum overhaul
- Multiparty FC
