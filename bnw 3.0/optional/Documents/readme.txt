
			    Final Fantasy VI: Brave New World - README

				       TABLE OF CONTENTS
				       -----------------
				    1. A PERSONAL MESSAGE FROM BTB
				    2. INSTALLATION
				    3. CHARACTERS & GAME BALANCE
				    4. PATCHES & ASSEMBLY HACKS
				    5. BUGS & KNOWN ISSUES
				    6. VERSION HISTORY
				    7. CREDITS & CLOSING

---------------------------------------------------------------------------------------------------------




				    1. A PERSONAL MESSAGE FROM BTB




---------------------------------------------------------------------------------------------------------

One day back in 2011, a coworker of mine showed me a Final Fantasy VI ROM editor that he'd found on the
world-wide pornography receptacle known as the internet. We got to talking about how the editor could be
used to fix bugs and other issues in the game, like how some asshole left the caps lock on when he was
naming everybody. This soon led to a discussion about how cool it would be if you could restrict certain
espers to certain characters, beyond which the story differs depending on which one of us you ask since
neither one of us wants to assume credit for instigating this mess. What we can agree on, however, is
that the resulting product is something that we're very proud of.

What is Brave New World? This is a question that I've found myself often at odds to succinctly answer
over the last eight years. In short, it's the mechanics and ideas set forth by the original game fully
realized with the assistance of over 25 years' worth of additional technology and design theory - not to
mention that, as a fan project, Brave New World is not bound by corporate deadlines and has thus been in
active development for nearly a decade. What began as a pet project between two coworkers has blossomed
into a massive community undertaking larger than either of us could have possibly dreamed.

Final Fantasy VI presented an unusually large cast for its time: 12 characters (plus two "hidden" ones)
alongside a veritable slew of abilities to use with them. But lurking just beneath the surface of this
illusion of choice was the harsh reality of homogeneity - there was little to individualize characters
who all had access to the exact same magic spells which far outstripped their unique skills in terms of
usefulness and whose statistical diversity was rendered largely moot by the fact that only one of the
four core attributes was even remotely functional. Although the game would often present a variety of
options at any point - Gau's list of 255(*) rages, for example - these options would generally consist
almost entirely of bad/useless ones with a select few ranging from being overpowered to flat-out broken.
Often, entire mechanics would be invalidated, such as Cyan's "SwordTech" skill not considering the power
of his sword so that the legendary blade which split the heavens in twain ultimately had the exact same
effect in battle as the crap he starts out with (which he probably bought on the Home Shopping Network).

	*Several are unobtainable due to various bugs, which the original game was also full of

Brave New World seeks to offer meaningful choices to players by means of unique spellsets and multiple
growth options for each character and a challenge sufficient to warrant that investment. But unlike what
might immediately come to mind when the average person thinks of a "difficulty" hack, the goal here is
simply to provide a well-balanced game that acts as a vehicle for players to use the skills that their
characters will acquire rather than punishing (and then mocking) them for taking the most logical course
of action. Similarly, it seeks to avoid the "one road to victory" approach of offering several inferior
choices alongside the one "intended" option that anyone interested in finishing the game should choose.

But far and away the absolute best thing about Brave New World is the amazing community that has come to
surround it. I owe so many relationships with so many wonderful people to this hack that I can say with
no conceit that it's the best thing I have ever done. To everyone who has ever played or livestreamed or
even just told anyone about Brave New World, you have my heartfelt gratitude. Brave New World is what it
is today because of you. And as for those about to play... we salute you.

					-BTB, May 2019

---------------------------------------------------------------------------------------------------------




				    2. INSTALLATION




---------------------------------------------------------------------------------------------------------

Brave New World is distributed as an .ips patch, which is the standard for console mods as it avoids the
legal issues of distributing a fully-patched ROM. To make things as easy as possible for everyone, we've
also included a utility called "Lunar IPS" which will apply the patch to the ROM directly rather than
having to set it up through your emulator.

To install the patch, just follow these easy instructions:

      •	ALWAYS PATCH A CLEAN ROM - that is, a Final Fantasy 3 US (version 1.0 or 1.1, it doesn't matter)
	ROM with nothing else already patched in. This also applies to when you are updating to a newer
	version of the mod. IF YOU DON'T PATCH A CLEAN ROM, YOU'RE GONNA HAVE A BAD TIME.

      •	There are two versions of the patch: one for headered ROMS (H) and one for unheadered ROMS (N).
	If you're unsure, check your ROM's file size: headered ROMS are 3073 Kb, unheadered are 3072 Kb.

      •	If desired, apply one of the translation patches AFTER applying Brave New World.

      •	The most immediate indication you'll receive that the patch took is the new default window style
	when the game loads (the patch doesn't change the title screen - awesome as it would be - to its
	official logo). You can also view what version of the patch you're playing in the config menu.

Finally, note that while applying an updated version of the patch to your game will not invalidate your
existing save states, you should save the game the normal way (that is, by using an in-game save rather
than a save state) prior to updating and then reset the game afterward. This is to clear data out of the
SRAM, which often includes shit that we fix in our updates.

---------------------------------------------------------------------------------------------------------




				    3. CHARACTERS & GAME BALANCE




---------------------------------------------------------------------------------------------------------

The discussion of a subject as broad as overall game balance should probably start at the same place we
did in development, which is at the characters themselves. Final Fantasy VI had a fairly unique system
wherein pretty much the entirety of character development was tied to espers, which carried a few rather
obvious downsides. The first is that, due to bad coding/poor life choices, only one stat (magic) was at
all worth raising in the first place. This led to a lot of munchkining despite nothing at all resembling
enough difficulty to warrant it, especially considering that, because any character could use any esper,
the endgame invariably devolved into an Ultima spam-fest (which would be the other downside).

Thus, two major sets of changes were made to the code. One, we had to change how the game handles every
other stat so that magic isn't the only one with any value whatsoever. Two, we had to take care of that
pesky "everybody can equip every esper" problem. This allowed me to mold each character into a special
flower with unique spell lists and growth options. For further details on the various hacks that make
Brave New World different from vanilla, skip ahead to section four. Otherwise, what follows is a quick
(not really) rundown of each character in the game and the roles that they now fill.

---------------------------------------------------------------------------------------------------------

				    TERRA & CELES
				    -------------

			    MAJOR STATS: All but Speed (Terra) / All (Celes)
			    MAGIC TYPES: All types

Terra and Celes are discussed together because they both still function very similarly to one another.
They're essentially red mages on steroids: Jills-of-all-trades who can easily adapt to any team you put
them in and who can excel in any role that they're set up for. Both lack a directly offensive special
skill, and so their usefulness is largely dependent on their spells and equipment. Lucky for them, they
have access to most of the game's best equipment along with more espers (and thus more spells) than the
rest of the cast. Terra's main advantages are a superior spell selection and a skill that capitalizes on
her beat-stick nature, while Celes is more well-rounded with better stats and support magic.

Runic and Morph have both been through some significant mechanical changes, as well. The former has been
standardized to work on all white, grey, and black magic (any spell that starts with a colored dot), but
not on any "blue" magic (any attack that doesn't). This, along with the fact that many more enemies use
such spells in general, is meant to make using the skill both more intuitive to use and worth your while
to do so. A few assembly hacks (discussed in section four) also fix some bugs it had so that it feels a
lot more like a proper ability instead of a broken mess.

Regarding Morph, it's now a toggled stance rather than a timed one and the first of several skills that
aims to rescue stamina from the "dump stat" heap by allowing it to reduce the doubled damage that Terra
now takes in her esper form in return for the offensive boost that it provides. This makes using Morph
a decision that hinges on more than just a simple matter of Terra being "charged up" for it, and those
who are willing to suffer the drawbacks will find that a morphed Terra is easily Brave New World's most
fearsome warrior and will likely be the first (and possibly only) character to hit the damage cap.

	http://ngplus.net/index.php?/forums/topic/146-terra-branford-the-power-of-love/
	http://ngplus.net/index.php?/forums/topic/151-celes-chere-dog-of-the-empire/

---------------------------------------------------------------------------------------------------------

					LOCKE
					-----

				MAJOR STATS: Vigor, Speed, HP, MP
				MAGIC TYPES: White, Black

At first glance, Locke appears to be nothing more than an inferior version of Terra and Celes. He lacks
their raw magical power and their massive spell repertoires, instead focusing mainly on physical attacks
and healing magic. But what he lacks in their versatility he picks back up with high speed and evasion.
Neither stat featured very prominently in the original game, and Locke serves as a good example of just
how significant these advantages are now. He tends toward armor of the lighter variety and dual-wielding
is now baked in to his weapon of choice rather than enabled by a relic, so his main defense is just not
getting hit in the first place. Furthermore, his speed advantage will be felt both in his role as healer
as well as his ability to dish out physical damage much faster than most other characters can.

Locke's magical abilities are also aided by the fact that he is now one of the three characters to which
the X-Magic ability is restricted. However, dual-casting with Locke is something of a double-edged sword
and an effective demonstration of how the more limited MP pools for the game's non-primary spellcasters
relegates them to more physical roles. That said, Locke is more than capable of outperforming the girls
on the magical front, but it requires a focus on building and managing his MP in order to pull off.

Rounding out Locke's skillset is Steal, which was reworked to make a bit of fucking sense. Only enemies
who might be actually holding something (i.e. humans) can be stolen from on Brave New World - trying to
steal from a bear will just get you a very dead Locke. The idea is that fewer and more obvious targets
for theft along with better rewards for doing so will make treasure hunting more attractive. The formula
has been reworked to use Locke's speed for both the odds of success and of getting a "rare" steal (which
was previously a set 1/8 chance), while a successful theft now immediately refills Locke's ATB meter so
that attempts can be chained together. This not only makes it easier to rob entire enemy parties, but
also upgrades "Mug" to a tactical multi-strike against human mobs.

	http://ngplus.net/index.php?/forums/topic/147-locke-cole-treasure-hunter/

---------------------------------------------------------------------------------------------------------

					EDGAR
					-----

				MAJOR STATS: Vigor, Magic, Speed, HP
				MAGIC TYPES: Grey, White

In stark contrast to the above, Edgar is a character whose usefulness is tied almost completely to his
special skills. Although one of our overall goals was to make regular physical attacks more competitive,
Edgar remains the game's one character with a clearly preferable alternative in his Chainsaw and/or his
Drill. In the original game, Edgar peaked early due to his tools being very overpowered initially, but
they failed to scale well and left him with little else to do in the endgame besides dragooning. We've
thus overhauled his tools and their effects in an attempt to keep the skill relevant into the late game,
as well as to reduce the gross amount of redundancy. Of note are his new tools - the Defibrillator and
Mana Battery - which provide a degree of utility and allow for a viable magical/support build.

Of course, making Edgar a physical powerhouse is still very much an option, and his weapons have been
reworked to ensure that they remain an important part of his load-out even if they are only functioning
as stat sticks. Swords provide good basic stat boosts, whereas spears have been retooled into defensive
weapons that boost max HP and allow him protect his allies. Spears now also possess the "hold with both
hands for moar damage" property (i.e. the "Gauntlet" effect), which can combine with the inherent bonus
that spears already add to jump attacks for truly amazing damage. In part because of this, and in part
because of the whole "unique flower" thing, dragooning is now exclusive to Edgar and Mog (...and Gogo).
One advantage of particular note in going the dragoon route is that jumping is not subject to the back-
row damage penalty, whereas the Drill and Chainsaw (see section four below) now are.

Ultimately, Edgar's most notable feature in pretty much any build is likely his ability to tank. He gets
a lot of HP through both his equipment and espers and he likes his heavy armor. He also gets more than
one long-range physical attack (that Autocrossbow may end up more useful in the late game than you may
think), so camping in the back row is always an option for The King. He gets several healing and support
spells to assist him in this role, but he must rely exclusively on his other skills for damage output.

	http://ngplus.net/index.php?/forums/topic/149-edgar-roni-figaro-hail-to-the-king-baby/

---------------------------------------------------------------------------------------------------------

					SABIN
					-----

				MAJOR STATS: Vigor, Stamina, HP
				MAGIC TYPES: Grey, Black

Sabin has been through quite a lot of changes in Brave New World in order to make him fit his character
archetype. Whereas his brother is basically Kain from FF4 with Tools and a permanent hard-on, Sabin now
more closely resembles Yang. The mere presence of Blitz originally relegated his regular attacks to the
rubbish bin, and his claws didn't even make for decent stat sticks since the best blitzes all did magic
damage. Taking a cue from Yang, the new name of Sabin's game is a lot of punchy elemental damage with a
lot of added effects: his claws now all deal elemental damage and have random spellcasts attached. He's
then forced to dual-wield them in true monk style by no longer being able to equip shields. He makes up
for this, as well as his inability to wear much other armor, with some truly impressive base stats.

Blitzes have also been reworked, just as Tools were, in an attempt to keep them useful throughout the
game. The result is a varied skillset that provides a choice as to how to develop Sabin's stats. A vigor
Sabin, for example, will focus more on physical blitzes like Pummel and Suplex, both of which continue
his "added effects" theme by setting "sap" and "stop", respectively. The former remains relevant since
sap is a significant presence in boss fights while the latter remains useful to disable random enemies.
On the other hand, several blitzes are now affected by Sabin's stamina, making him one of the best users
of this once-useless stat. A stamina-based Sabin is a more defensive Sabin who assists his allies with
Mantra and its new counterpart (Chakra) that restores his team's MP instead of their HP while relying on
the now stamina-based Aurabolt and Sonic Boom (formerly "Air Blade") for the bulk of his damage.

Early in the game, Sabin's natural stats will make him one of the most powerful and beefiest characters
available. Later on, his limited armor options will become more of an issue and he'll have to rely more
on his high HP to stay on his feet. One advantage that Sabin has in this regard is that his high vigor
and stamina will help him take much more consistent damage from enemy attacks due to how they function
now as a sort of "natural" defense (see section four below for details), but he still ends up eating a
lot more of it in the long run than characters who can actually wear armor.

      http://ngplus.net/index.php?/forums/topic/150-sabin-rene-figaro-well-dont-that-just-beat-all/

---------------------------------------------------------------------------------------------------------

					CYAN
					----

				MAJOR STATS: Vigor, Stamina, HP
				MAGIC TYPES: White, Black

Cyan suffered immensely in the original game for being the most physically-oriented fighter in a world
where magical damage reigned supreme and shitty balance decisions made 7/8 of his special attacks not
worth the fucking lifetime it took to use them. He gets a much-needed overhaul in Brave New World in the
form of a both a new global physical damage formula that renders his style of combat no longer complete
shit, as well as some special attention to his special skills in the same vein as Tools and Blitz before
them. From the undead-vanquishing powers of Mindblow (the "Dies if MP=0" flag is now used exclusively on
all undead foes) to the supreme destruction of Tempest (AKA "Quadra Slice"), every bushido has a purpose
to fill and a chance to shine. Also, the Bushido meter no longer takes a fucking lifetime to charge and
the strength of his sword actually factors into the strength of his sword skills (what a novel concept).

Like Sabin, Cyan is now denied the use of shields in order to force the inherent "can be held with both
hands for extra damage" bonus on all of his weapons, which helps make even his regular physical blows a
mighty force to be reckoned with. Also like Sabin, Bushido techniques that do physical damage will only
be half as strong to those without a brave warrior spirit who cower in the back row. But even with these
drawbacks, Cyan's heavy armor and earlier access to Empowerer ensures that he's just as good at taking
damage as he is at dishing it out. Furthermore, the overall lack of diversity in his esper bonuses more
or less guarantees that he'll end up with more vigor and/or HP than just about anyone else.

Build-wise, Cyan really only has two options. You either pump his vigor to solidify him as the resident
king of physical damage or make him a impenetrable brick wall. Like Edgar, he has several healing spells
so that he can bring his allies back from the brink whenever he finds himself the last man standing, and
the fact that Empowerer also absorbs MP makes him one a good out-of-battle patch-up guy, to boot.

	http://ngplus.net/index.php?/forums/topic/148-cyan-garamonde-retainer-to-the-king-of-doma/

---------------------------------------------------------------------------------------------------------

					SHADOW
					------

				MAJOR STATS: Vigor, Speed
				MAGIC TYPES: Grey, White

Being a ninja, Shadow naturally winds up in the role of "fragile speedster" in this mod. He doesn't use
shields because ninjas have no interest in defending themselves when they can instead be dual-wielding
totally sweet ninja weapons, and the armor that he wears is of the "don't get hit in the first place"
variety. Shadow thus tends to die whenever he gets hit, but he almost never does. He does nearly end up
with the same problem as Edgar where his special skill completely outclasses his regular attacks - thus
relegating him to permanent "back-row" status - but the high price of throwables along with the option
for X-Fight later in the game are sufficient to lure him out to the front lines.

Regarding Throw, it's now restricted exclusively to knives, scrolls, and stars (no more chucking swords
or rods), and each type of throwable now functions more uniquely than before. Knives tend to do the most
damage, but are more expensive and only single target, whereas throwing stars can now be "spread" like a
spell to hit a group of enemies. Scrolls, as always, do elemental damage that can be extremely powerful
against a single target since the damage is forcibly "split" against multiple targets. Finally, Shadow
can now set the "image" status (also known as "blink") on his teammates rather than just on himself with
Smoke Bombs (known in the original game as "Shadow Edges"), which along with his handful of healing and
support spells make him an excellent utility character to have on hand.

Shadow's greatest asset by far, however, is his unmatched speed. Pound for pound, Shadow has the highest
DPS potential of any character in the game due (mostly) to just how fast he can attack; this is why he's
balanced by being made of tissue paper. Add to this his above-mentioned support capabilities and you get
an incredible addition to any team - provided you can figure out how to keep him alive.

	http://ngplus.net/index.php?/forums/topic/152-shadow-real-ultimate-power/

---------------------------------------------------------------------------------------------------------

					GAU
					---

				MAJOR STATS: Stamina, Speed
				MAGIC TYPES: Grey, White

Gau has always been a love-him-or-hate-him sort of guy, and at least that much hasn't changed here. What
I've tried to do is make it harder to hate loving him by overhauling his Rage list in the same spirit as
the other special skills, thus rendering the 64 remaining rages (down from nearly four times that amount
in the original game) at least as desirable as the select few that were in any way useful before, not to
mention a great deal more diverse. The mechanics of leaping and the Veldt itself have also been fixed so
that those inclined to use him no longer need to invest a lifetime into building him up. Without going
into too much detail, enemies without rages (not to be confused with Men Without Hats) no longer appear
on the Veldt, and you don't actually have to be on the Veldt to learn new rages.

Stat-wise, Gau ends up drinking from the same punchbowl as Shadow: he dies in a gentle breeze, he likes
to evade damage instead of taking it, and he's one speedy little shit. Much like Shadow - perhaps even
more so - Gau ends up ludicrously fast by the end of the game largely due to a lack of other stats to
raise. Combined with the fact that his only means of attack requires no user input beyond the initial
selection, Gau can easily be Brave New World's fastest character.

In the end, though, Gau is still the same as he's always been: useful bordering on broken if used well,
but very difficult to use well. As the majority of his effectiveness stems directly from proper/clever
use of his rages, the info found in the printme should prove especially helpful to Gau fans. Otherwise,
he's designed so that even if you only grab a handful of rages, those few are at least still useful.

	http://ngplus.net/index.php?/forums/topic/160-gau-rage-against-the-magitek/

---------------------------------------------------------------------------------------------------------

					SETZER
					------

				MAJOR STATS: Magic, Stamina, HP, MP
				MAGIC TYPES: White, Black

Setzer, perhaps most importantly, is one of the game's major healers. He's also arguably the beefiest,
with the potential to gain lots of HP and being mostly restricted to heavy armor. While his selection of
healing spells is obviously important to this role, equally notable are his Slots. Losing spins are now
twice as powerful as they were in the original game and act as sort of a poor man's version of Banon's
Health command, thus making for a quite effective - and spammable - full-party heal.

How Setzer likes to heal will depend in part on where his stats are. Traditional cure magic scales with
magic power, as do his Slots. The Remedy and Regen spells, however, now restore HP in addition to their
normal effects and instead scale in power with stamina. Both are of more use here due to a larger focus
on status effects - particularly sap and regen. Brave New World also features an upgraded version of the
Regen spell which will target multiple allies and is one of the bigger selling points of a stamina-based
build, and Setzer is one of the few characters with access to it.

On the offensive side of things, Slots have been de-rigged to favor skill completely instead of RNG, and
a magically-built Setzer can be a highly effective carpet-bomber if he can reliably nail winning spins.
Physically, he has the option to dual-wield, is the exclusive user of the reworked "X-Fight" relic, and
the fact that he's unable to raise his vigor through espers means that his damage output is completely
unaffected by build choice. And finally there's GP Toss: now a free-targeting stamina-based attack and
Setzer's best available source of consistent single-target damage.

The primary constant across any Setzer build is a heavy focus on tanking damage. But unlike Edgar, who
can counteract his choice of heavy armor with multiple speed-boosting espers, Setzer winds up as one of
the slowest characters in the game. But that's not really a problem for him, since he ultimately cares
less about DPS than, say, Terra or Cyan - both of whom have similar issues with speed - and more about
staying alive and keeping his teammates the same way. He doesn't learn a traditional revival spell like
Terra or Locke do and he doesn't have the speed to play fast and loose like Relm can, so his approach to
healing has to be a lot more proactive and preventative as a result. And that's not to say that this all
doesn't leave any room for fighting, just that it tends to be... well, a roll of the dice.

	http://ngplus.net/index.php?/forums/topic/153-setzer-gabbiani-the-angel-the-gambler/

---------------------------------------------------------------------------------------------------------

					MOG
					---

				MAJOR STATS: All but MP
				MAGIC TYPES: Black, Grey

Mog is something of an oddball character in Brave New World. He gets a generous selection of esper stat
boosts and a great potential to maximize them since he's an entirely optional character, but he doesn't
really hybridize well, thus leading to some very unusual and rather extreme build options.

Probably the most obvious choice is to focus on Mog's magic power, which boosts both the potency of his
spells and of his offensive dance steps. With a smattering of offensive and status magic to choose from,
access to the X-Magic ability, and the ability to equip rods, going whole hog into jacking up his magic
power is far from a bad idea. Note, however, that Dance also uses his stamina not only to determine the
odds of stumbling on non-native terrain, but also to raise the effectiveness of the steps that heal the
party. The eight dances themselves have been rebalanced to be more uniquely tailored to specific builds
and situations rather than just being the same thing eight times over, just with different backgrounds.
Water Rondo, for example, is a heavily offensive dance that will be mostly appreciated by a magic-built
Mog looking to deal big damage, whereas Forest Suite is a more defensive dance that can be utilized to
great effect by a tankier build. Both examples are particularly useful in boss battles, whereas other
dances like Love Sonata and Dusk Requiem are more suited to random crowd control.

On the flip-side, Mog can also opt to forgo all of that "magic" crap and embrace his role as the mod's
other potential dragoon. While he may at first appear to be pretty much just Edgar, but cuter, he gains
access to a few things that drastically set him apart from everyone's favorite perv, the least of which
is a weapon type other than spears that make for viable pogo sticks. Generally speaking, Mog most likely
won't be doing much attacking aside from jumping since his physical damage output is otherwise lacking.
Ideally, whenever a physically-built Mog isn't taking a hint from Van Halen, he'll instead be taking
advantage of his spells and dances that don't rely on his raw magic power to be effective.

The conclusion is that, while Mog has many skills and abilities available to him, no one build is really
able to take full advantage of them all. Instead, it's better to focus on what you want out of him and
work toward that goal. Failing that, he tends to be a sub-par character with little purpose other than
being the adorable team/corporate mascot and a rather blatant author avatar.

	http://ngplus.net/index.php?/forums/topic/154-mog-mascot-with-attitude-kupo/

---------------------------------------------------------------------------------------------------------

					STRAGO
					------

				MAJOR STATS: Magic, Stamina, MP
				MAGIC TYPES: Black, Grey

Strago is essentially Cyan's magical counterpart in Brave New World: he casts the spells that makes the
peoples fall down. He boasts the highest natural (and potential) raw magic power in the game, as well as
an ability which makes great use of it. Lore, as you can probably guess by now, has been given the same
treatment as every other skill before it wherein all of the useless garbage has been pruned out and all
that remains is now more useful. His regular spell selection is a bit less impressive, but he does get
X-Magic to keep it competitive/interesting. As for his equipment, rods (Strago's weapon of choice) have
been reworked as viable magic-based weapons (see "MP 4 Crits" in section four for details). All of this
makes him more dependent on MP than any other character to be effective in battle, and he's thus one of
the few who is able to significantly raise it and one of only two to learn the Osmose spell.

Strago's two main disadvantages are that he's squishy and he's slow as fuck. His natural stats and armor
will provide him with good magical defense, but his physical defense and HP will remain low. His shitty
speed can be overcome with enough of the right equipment and his survivability can be upped by a decent
margin with an all-out stamina build, but you really can't do both and either one will tend to come at
the expense of maximizing his magic power. Which direction you choose will hinge mostly on whether you
prefer to use him primarily as a nuker or to take advantage of his many utility spells/lores to support
the rest of the team. In either case, he probably needs to stay in the back row since the only advantage
of not doing so is better spell damage from his rods (which can, admittedly, be worth it in some cases).

	http://ngplus.net/index.php?/forums/topic/155-strago-magus-get-off-my-lawn/

---------------------------------------------------------------------------------------------------------

					RELM
					----

				MAJOR STATS: Magic, Speed, Stamina, MP
				MAGIC TYPES: All types

Relm may seem like a pint-sized, foul-mouthed version of her grandfather at first, but she's actually a
very different beast. Both are glass cannons with an emphasis on powerful magic, but their similarities
end there. First off, she trades a bit of her grandfather's raw magic power to get back some much-needed
speed. Second, Relm possesses a handful of the game's strongest spells both as her main advantage and as
her main weakness. Relm functions well as both an offensive powerhouse and as a traditional healer, but
the downside is that she has little else going on for her otherwise. Her early-game offense is largely
limited to Sketch - which at least works now - and her primary healing ability outside of end-game magic
is whacking her friends with a paint brush. Definitely a late bloomer, this one.

Because of Relm's strong emphasis - that is to say her outright dependence - on powerful magics, she's
the (only) other character who now learns Osmose so that she at the very least remains self-sufficient.
Just remember that she's still quite squishy, so stick her in the rear and use her speed and offensive
magic as a means to eliminate as much of the enemy threat as quickly as possible.

	http://ngplus.net/index.php?/forums/topic/156-relm-arrowny-age-is-just-a-number/

---------------------------------------------------------------------------------------------------------

				    UMARO AND GOGO
				    --------------

These two, lastly, end up in Brave New World as largely enhanced versions of what I presume they were
originally meant to be. Umaro is big, strong, hits like a truck and can take a lot of punishment. Due to
this, he'll appeal greatly to inexperienced players that are just looking for a tank to smash shit up.
But because he can't really do anything else, his long-term usefulness is somewhat limited.

Gogo, on the other hand, looks downright horrid on paper due to his shit stats and generally lackluster
equipment options. However, the mysterious pile of rags holds great rewards for the clever player who
takes the time to unlock his true potential. In the original game, Gogo's role was heavily diminished by
the aforementioned fact that, by the time you found him, your team was already full of faceless Ultima
factories. But if we've at all succeeded in our goal to mold every character into a unique being, each
with their own distinct advantages and disadvantages, then there is tremendous value in someone who can
wield any of those advantages at will. In fact, if not for his abysmal stats, Gogo would be hands-down
the absolute best character in the game. And even with them... he still very well may be.

	http://ngplus.net/index.php?/forums/topic/157-umaro-hulk-smash/
	http://ngplus.net/index.php?/forums/topic/158-gogo-slave-to-the-power-of-death/

---------------------------------------------------------------------------------------------------------




				    4. PATCHES & ASSEMBLY HACKS




---------------------------------------------------------------------------------------------------------

	Esper Restrictions	This is pretty much the cornerstone of the entire mod; it restricts the
	------------------	use of espers only to characters who are compatible with them (refer to
	 (Synchysi)		the printme for a full list), thus allowing us to further individualize
				each character due to the fact that espers are basically the only real
				contributing factor to character development in Final Fantasy VI.

				   (Special thanks to KingMike for help with optimizing this hack)

	   Esper Bonuses	Aside from the above, and complimentary to it, the most sweeping change
				made in Brave New World is transforming the esper level-up stat bonuses
				from an apparent last-minute afterthought in the game's design into the
				core of character development and customization.

				Espers now offer the following (cumulative) stat bonuses:

					• HP +60
					• MP +40
					• HP +30/MP +15
					• HP +30/Stamina +1
					• MP +25/Stamina +1
					• Vigor +1/HP +20
					• Magic +1/MP +15
					• Vigor +1/Speed +1
					• Magic +1/Speed +1
					• Vigor +1/Stamina +1
					• Magic +1/Stamina +1
					• Speed +1/Stamina +1
					• Vigor +2
					• Magic +2
					• Stamina +2
					• Speed +2

	   Esper Experience	We encountered several obstacles regarding esper stat boosts, the least
				of which was that almost every stat sucked (see "nATB System", "Physical
				Damage", and "Stamina Overhaul" below) and the most persistent of which
				was that FF6's leveling system was clearly not designed with esper stat
				boosts in mind. This ultimately resulted in an environment where, after
				everything else was all said and done, players were penalized for not
				keeping levels as low as possible in the early game because every level
				gained without espers was "empty". Late-game characters like Setzer and
				Strago were hit particularly hard by this, as was any character build
				which relied heavily on World of Ruin espers.

				To balance this, stat boosts from espers were given their own leveling
				system independent of regular levels. Each character starts out at an
				"esper level" (EL) of 0 - regardless of their regular level - and gains
				esper points (exp. for esper levels) according to the following formula:

						Esper points = (spell points * exp.) / 8

					(NOTE: Spell points were renamed from "magic points")

				Note that esper levels use the same experience table as regular levels
				and cap at 25. Also note that a character will not gain any esper points
				if (s)he has no esper equipped, which is no longer an issue because...

	   Esper Bank		The newfound advent of character builds eventually found itself at odds
				with the fact that they still had to equip espers to learn spells, which
				meant a lot of battles on the Veldt and/or micromanagement of experience
				gains to avoid gaining unwanted esper levels. To alleviate this concern,
				esper points earned in battle now go into a "bank" for each character,
				and spells are now learned by spending them in the esper menu without
				needing to actually equip that esper and fight with it on. The learning
				rate for spells on espers is now the cost of that spell; the maximum
				amount of spell points that any character can bank at a time is 30.

				Similarly, esper levels are "banked" in the same manner as esper points
				are rather than being granted immediately upon earning them in battle.
				This completely eliminates the need to micro-manage equipped espers for
				the purposes of stat gains, and it also allows for a "re-spec" feature
				later in the game that reverts all of your spent ELs to the bank so that
				you can rebuild characters with different stat boosts. To spend a banked
				EL, just click on the EL bonus in the esper menu.

	   Esper Junctions	The only problem with the esper bank system removing the need to micro-
	   -(Think/dn/Seibaby)	manage espers was exactly that - players no longer had a reason to care
	    (...and Nowea >.>)	who had what equipped since the only functional difference between them
				at that point was summoning them in battle. To address this, espers now
				provide an "on equip" bonus just like a piece of equipment - such as a
				stat boost or reducing incoming elemental damage - that is completely
				separate from that esper's EL bonus.

				For example, Kirin offers a +5 bonus to Magic when equipped, but raises
				HP and Stamina for each EL spent. The former is a static bonus that's
				only present so long as Kirin remains equipped, whereas EL bonuses are
				permanent, cumulative, and not contingent on the esper being equipped.
				Characters may also mix and match EL bonuses from their available espers
				to their liking, whereas only one may be equipped at any given time.

				The equip bonus for each esper is displayed in the esper menu where the
				summon effects were shown previously; summon effects are now shown only
				in the EL/spell acquisition submenus for each esper.

					(Special thanks to SirNewtonFig for getting this working)

---------------------------------------------------------------------------------------------------------

	Levels & Experience	Character levels are now capped at 50 with a "soft" cap starting in the
	-------------------	late 30's (expected end-game levels are mid-30's). Growth is otherwise
	 (Synchysi/BTB)		linear except for three "humps" after levels 10, 20 and 30. For more
				details, consult the experience/level chart in the printme.

	   Level Averaging	In the original game, characters were brought up to the team's average
	   -(Bropedio)		level at set points throughout the game. This was a feature we initially
				removed entirely due to the above-mentioned issues with stat boosts from
				espers as well as to encourage using a variety of characters rather than
				just the same four while everyone else sits on the bench. The EL system
				has since removed the first problem, so we've reinstated level averaging
				in a manner that only addresses the second.

				To the point, level averaging now occurs at only one point in the game
				aside from initial averaging that's done for each character when they
				join (or, in Shadow's case, every time he joins up with you in the World
				of Balance). Everyone gets re-averaged to a static level (see below) at
				the game's halfway mark, which is distinct from how they were originally
				re-averaged upon (re)obtaining them; with it done this way, there's no
				longer any benefit in putting off getting anyone back.

							CHARACTER(S)	LEVEL
							---------------------
							Celes & Sabin	 18
							Edgar		 19
							Setzer		 20
							Everyone Else	 21

					(NOTE: esper levels can't be gained via re-averaging)

				Concerning the initial levels that characters join up at, that has also
				been changed. In the original game, most characters joined at slightly
				above the party average, whereas now everyone except Gogo (average -3)
				and Umaro (average +5) now joins at the exact average.

	   NoGainz		Finally, there is now an option in the config menu to disable exp. gains
				(and, by extension, spell point and EP gains) from battle. This feature
				is mostly intended for challenge gamers trying a low-level game, but can
				also be	useful for someone who wants to farm GP without over-leveling.

---------------------------------------------------------------------------------------------------------

	nATB System		The short explanation of what this hack does is that it pauses the ATB
	-----------		timer during attack animations and while the player is doing anything
	 (Think)		(the original game did not pause during "Fight" targeting or while the
				Bushido meter was charging). This has two effects: one, it makes speed
				contribute more significantly to how fast and often a character acts in
				battle, as well as preventing it from effectively soft-capping at around
				60 or so; two, it removes the exploit of camping in the item menu under
				the "wait" setting to gain a huge speed advantage. The resulting system
				is basically a modified version of "wait", which I mention because there
				is no longer an "active/wait" setting, nor a "battle speed" slider.

	   Speed Balance	Removing the soft cap from speed and thus allowing faster characters to
	   -(Seibaby/Nowea)	get more turns over time turned it into something of a DPS god stat, if
				not just a god stat in general. In response to this, the overall effect
				of speed was lowered at high levels while slightly raising the effective
				speed of slower characters. Refer to the below benchmarks, comparing the
				number of turns gotten by several characters over the same timeframe.

					   CHARACTER		TURNS (OLD)	TURNS (NEW)
					---------------		-----------	-----------
					Strago  (30 SPD)	    4.0		    4.0
					Terra   (48 SPD)	    5.33	    5.0
					Celes   (72 SPD)	    7.0		    6.0
					Shadow (128 SPD)	   10.66	    8.5

					---------------------------------------------------

					OLD FORMULA: (1.5 * (75 * (SPD + 20)) / 16)
					NEW FORMULA: (1 * (75 * (SPD + 51)) / 16)

	   First Strike		Contrary to the above change, a major intended feature of speed was to
	   -(Seibaby/Bropedio)	allow faster characters to act first in battle. The original formula to
				determine characters' initial ATB fill in battle took speed very little
				into account and was instead largely randomized. Speed is now factored
				more heavily, with faster characters like Locke and Shadow now getting
				first strike in battles much more often than not.

					---------------------------------------------------------

							Initial ATB fill% =

					OLD: ([Spd...(2Spd - 1)] + ([0...9] * 8) + 16X) * 256 / 65535
					NEW: ([2Spd...(3Spd + 29)] + ([0...9] * 4) + X) * 256 / 65535

						X = (10 - Number of entities in battle)

					---------------------------------------------------------

				For pincer and back attacks, initial ATB for characters was a modified
				version of the original formula above that didn't factor in speed or the
				number of entities in battle, typically resulting in a very low number.
				In Brave New World, the new formula above sets the first bracketed range
				to a fixed "2Spd" while also setting initial monster ATB values to full.

	   Status Timers	Several status effects utilize a timer to determine when they wear off;
				their durations have been reduced across the board to compensate for the
				fact that their incrementation is constantly being interrupted:

					NEW TIMER SETTINGS	OLD TIMER SETTINGS
					------------------	------------------
					Stop	     5		Stop	     18
					Sleep	     10		Sleep	     18
					Freeze	     10		Freeze	     34
					Reflect	     *		Reflect	     24
					Condemned    **		Condemned    **

				   (*No longer a timed status - see "Rflect Timer" further below)

				Note that cutting the timer for sleep in half renders its duration about
				the same as before, whereas stop and freeze were further shortened as an
				executive balance decision. Condemned is a little bit tricky, since its
				timer is generated by the following formula:

					Random Number = [Caster's Lv...((Caster's Lv * 2) - 1)]

					Timer starts @ higher of 10 or ((79 - Random Number) / 2)

				This formula is largely identical to the one from the original game; all
				that's been changed is that both the end result and the minimum starting
				time have been cut in half to compensate for nATB.

	   Slow & Haste		Because even small speed differences are significant in nATB - and also
				because the "slow" status is now a major element of boss fights - it was
				necessary to narrow the gap between the two speed-impacting statuses:

					NEW MULTIPLIERS		OLD MULTIPLIERS
					---------------		---------------
					Slow	  60x		Slow	  32x
					Normal	  75x		Normal	  64x
					Haste	  90x		Haste	  84x

	   Quickfill		A notable result of the above changes is a net increase to the flow of
	   -(Seibaby)		combat due to the higher speed of all participants. More significantly,
				in order to minimize "empty" downtime the speed of combat is now doubled
				when neither an action is occurring nor any character is ready to act.

	   Command Delays	Complementary to the changes to battle speed in general, we have edited
	 -(Synchysi/Bropedio)	the delays between input and execution to further balance commands:

					NO DELAY       ($00)		SHORT DELAY    ($10)
					--------------------		--------------------
					Steal/Mug			Fight
					Runic				Item
					Leap				Rage
					Mimic				Dance
					Revert				Throw
					Defend/Row			Sketch
					Possess				Health
					MagiTek				???

					MODERATE DELAY ($20)		LONG DELAY     ($40)
					--------------------		--------------------
					Magic/X-Magic*			Morph
					Tools				Summon (esper)
					Blitz
					Bushido				HUGE-ASS DELAY ($70)
					Slots/GP Toss			--------------------
					Lore				Jump (air time)

					*X-Magic's delay is effectively $40 in practice

				In the original game, these delays were invisible to players. Here, the
				ATB bar will count back down to zero when a command is input to indicate
				when it will execute (Bropedio). Seeing as this feature can possibly be
				more distracting than helpful, it may be disabled in the config menu.

	   Quick Actions	The "Defend" and "Row" commands, in addition to the lack of an execution
	   -(Bropedio)		delay seen above, now only consume half a turn instead of an entire one.

						 (See also "Omni-Defend" below)

	   Hotswap Delay	Swapping weapons and/or shields in combat, which was previously a free
	-(Bropedio/GrayShadows)	action, now requires half a turn for one hand or a full turn for both.

						(See also "Hotswap Update" below)

---------------------------------------------------------------------------------------------------------

	Physical Damage		The formula for physical (non-magical) damage dealt by characters has
	---------------		been completely rewritten so that vigor plays a more significant role.
	 (Synchysi)
						OLD PHYSICAL DAMAGE FORMULA
						---------------------------
					Dmg = Attack + (Lv^2 * (2Vgr + Attack) / 256) * 3/2


						NEW PHYSICAL DAMAGE FORMULA
						---------------------------
					Dmg = 2Vgr + Attack + (Lv^2 * Vgr * Attack / 6144)

				In the original game, Attack (formerly "BatPwr") was capped at 255 since
				it was stored as an 8-bit value. It is uncapped here, which mostly only
				affects the Atma Wepaon when used by Edgar and - mainly - the Excalibur.

					(Extra special thanks to Bropedio for the uncap job)

	   Vigor As Defense	In addition to determining physical damage dealt, vigor now helps reduce
				incoming physical damage, as well. See "Random Variance" in the stamina
				overhaul section below for more details.

	   Back Row Nerfs	The back row now only reduces incoming physical damage by 25%. Outgoing
				physical damage is not only still halved, but the penalty now extends to
				melee (i.e. short-range) damage dealt by Tools, Blitz, and Bushido.

				(For clarification, the only commands that inherently deal row-ignoring
				physical damage regardless of weapon are Jump and Throw.)

	   Blind Accuracy	Further to the above, the blind status (renamed from "dark") now affects
				all physical and stamina-based damage (see "Stamina Attacks" below) from
				special skills, all of which remain otherwise unblockable. This includes
				the Steal skill, but interestingly enough not "Sketch".

					(Thanks to dn for getting blind working with "Jump")

				      (...and to Bropedio for getting it working with "Steal")

				In addition, hitting something in the back (side/pincer attacks) is now
				affected by blindness, whereas previously a back attack would never miss
				under any circumstances. Blindness is also no longer circumvented by
				weapons that never miss or by relics that grant perfect accuracy.

	   No Backstab Bonus	One last note about hitting things in the back is that it no longer does
	   -(Seibaby)		extra damage; see "Irregular Encounters" further below for more details.

---------------------------------------------------------------------------------------------------------

	Stamina Overhaul	In the original game, stamina did as close to nothing as a stat could
	----------------	possibly do without actually doing nothing. Its main purpose was to act
	 (Synchysi)		as an extra layer of evasion against instant death attacks: a role which
				is expanded here to include fractional damage (i.e. Demi), redirectional
				damage (i.e. "steals HP"), MP damage, and all status effects. To further
				emphasize the role of stamina in defending you against such things, it's
				now the ONLY evasion check against them.

				Further to the above, stamina is now able to consider only the statuses
				set by attacks that also deal damage. Such attacks will use regular (or
				magical) evasion to determine hit success and then runs a stamina check
				if the attack hits to see if the status also gets set (see "Informative
				Miss" below for how this is shown). As with regular evasion (see "Evade
				Bug Fix" above), stamina checks are a (Stamina/128)% chance of success.

				All of this is greatly simplified in the printme by means of listing the
				relevant evasion stat - stamina or (m)evade - for all avoidable attacks.
				Those with a separate stamina check for just the status (see above) use
				the verbiage "may set (status)" instead of "sets (status)"; attacks that
				use stamina as the primary evasion stat will of course show the latter
				since the former would just be double-dipping.

				It should be noted that, while enemies in Brave New World don't have any
				magical evasion, they do possess stamina. The range of values is lowered
				here from 17~40 to 1~32 ([MaxHP/256] capping with 32 at 8192HP). This is
				done so that weaker foes remain vulnerable to status effects while those
				which work on bosses (sap and slow) retain at least a 75% chance to hit.

	   Stamina Variance	In addition to helping you avoid most of the nastier side effects of
				magical attacks, stamina now also acts as an additional layer of defense
				against their primary effects in the same manner that vigor now reduces
				physical damage. This is done via the game's "random variance" formula,
				which is applied to every attack that doesn't do a set amount of damage.

						OLD RANDOM VARIANCE FORMULA:
						----------------------------
					Damage = (Damage * [224...255] / 256) + 1


						NEW RANDOM VARIANCE FORMULA:
						----------------------------
					Damage = (Damage * [Low...High] / 225) + 1

					   Low  = 225 - (Vigor or Stamina * 3/4)
					   High = 255 - (Vigor or Stamina)

				In the original game, random variance was a fixed range between 87% and
				99% of the original value; in Brave New World, high vigor and/or stamina
				will help you take less - and more consistent - damage from attacks. To
				better demonstrate this, here are some examples:

						 24 Vigor/Stamina = 92% ~ 102%
						 30 Vigor/Stamina = 90% ~ 100%
						 36 Vigor/Stamina = 88% ~ 97%
						 42 Vigor/Stamina = 86% ~ 94%
						 48 Vigor/Stamina = 84% ~ 92%
							---
						 60 Vigor/Stamina = 80% ~ 86%
						 90 Vigor/Stamina = 70% ~ 73%
						120 Vigor/Stamina = 60%*

					(*A negligible amount of variance still applies)

				The five benchmarks on the top represent the initial values that (most)
				characters possess for vigor and stamina, while the three on the bottom
				show the effects of raising them via equipment and/or espers. Note that
				the range of damage at 90 vigor/stamina is significantly smaller than at
				the earlier benchmarks, and the variance disappears (*almost) completely
				at 120 when the ceiling hits the floor.

				(Note: curative spells/abilities still use the old variance formula.)

	   Stamina Attacks	Less broadly, stamina is now a factor in several spells/attacks/commands
				(replacing the role of magic in most cases), making it more individually
				appealing to the characters that use them. This includes...

					...the Remedy & Regen spells (which now also cure HP)

					...Harvester & Sun Bath (Rage/Dance moves)

					...Rock, Tentacle, & Shrapnel (Rage attacks)

					...the Aurabolt, Sonic Boom, Mantra(*), & Chakra(**) blitzes

						 *HP restored = (Stamina * (Lv. + (User's HP/64)) / 4)
						**MP restored = (Stamina + Lv.) / 2

					...Bushido #5 (Dragon)

					...random wind attacks from certain weapons

					...Dance (non-native dance success % = (96 + Stam * 2) / 256)

					...Morph (see "Morphology" description below)

					...GP Toss (see "Make It Rain" description below)

					...Umaro's "Blizzard" attack (see "Umaro Hit Hard" below)

					...the Atma Weapon (see "The Atma Weapon" description below)

					...desperation attacks (previously magic-based)

					...Interceptor (ditto)

					...??? = 3/4 ((Lv * Stam) + (User's Current HP))

				To be clear, all of the above except for the Atma Weapon are considered
				magical attacks for the purposes of the back-row damage penalty(*) and
				the "+25% (physical/magical) damage" property on certain relics/espers.
				They are, however, affected by the "blind" status as mentioned earlier.

				    *Exception: Aurabolt is short-range despite being non-physical

	   Tank & Spank		Counter to the above, which sells stamina as an alternative attack stat
	   -(Seibaby)		with some defensive capabilities, we wanted a way of meshing it with the
				other stats in a meaningful way. It was thus decided that it should be
				tied to two equipment-enabled abilities: cover (synergizes with HP) and
				counter-attacks (synergizes with vigor). Hence, "tank & spank".

				As was the case in vanilla, characters with "true knight" equipment will
				always take hits for allies who are at "near fatal" status, even if they
				themselves are also at critical HP. Now, characters who are not in
				critical status themselves, may also take hits for healthy allies.

						Cover% (healthy allies) = Stam / 192

				There are some caveats to this, however:

					---------------------------------------------------------

					• The defender must be in the front row to cover AT ALL

					• The target, if not at low HP, must be in the back row

					---------------------------------------------------------

				Further, a character's evasion is halved when covering an ally. The odds
				of covering a healthy ally are double if the character is defending, but
				the "Defend" status is broken (and its bonus lost) if a cover occurs.

					(See also "Parry & Counter" and "Smart Cover" below)

				For the "spank" half of things, the game's original counter-attack rate
				was 75%. We found this to be excessive once we got other things sorted
				out, so we opted for a new formula that bases the counter-attack rate on
				stamina (starting at a floor of ~50%).

						Counter-Attack% = (Stam + 32) / 128

	   Sap & Regen		Moving on, the formulas for regen and sap/poison (all of which are much
				more prominent here than they were originally) have been edited to allow
				stamina to contribute more significantly toward raising the amount of HP
				restored by the former while now actually defending against the latter
				(originally, stamina RAISED the damage dealt by sap/poison).

						OLD REGEN/SAP FORMULA
						---------------------
					Tick = ((MaxHP * Stam) / 1024) * (random variance)

					(NOTE: If sap on a player character, tick is halved)

						---

						NEW REGEN FORMULA
						-----------------
					Tick = ((MaxHP / 64) + ((Stam * Lv.) / 16)) * (random variance)

					(NOTE: random variance is 87% ~ 99%)

						---

						NEW SAP FORMULA
						---------------
					Tick = (MaxHP / (16 + (Stam / 8)) * (random variance)

					(NOTE: random variance is the new formula for magical damage)

				Note that the first part of the formula is stored in an 8-bit value, and
				is thus capped at 255. The minimum value for random variance is 1, so no
				regen or sap tick can exceed 254 (further, because sap damage to player
				characters was originally halved, it could never exceed 127).

	   Poison Changes	Poison works in a manner similar to sap, except that it only ticks half
	   -(Bropedio)		as frequently and each tick deals incrementally more damage. Originally,
				the increment value was equal to the initial tick for both enemies and
				player characters. In Brave New World, the amount of damage is doubled
				for each tick on enemies, making it a more worthwhile status to inflict.

				We've also corrected an error in the original code wherein the variable
				that increments with each tick doesn't reset when the status is cleared
				(Synchysi), so poison ticks will now start back over at the beginning if
				the status is re-applied to the same unit in the same battle rather than
				picking back up where they left off.

---------------------------------------------------------------------------------------------------------

	Random Number Good	The original game's notoriously streaky Random Number Generator has been
	------------------	gutted and replaced with a new one that wipes clean without leaving any
	 (Think)		streaks behind. After realizing that I had nothing intelligent to say
				about this hack beyond that, I asked Think to describe it himself:

					---------------------------------------------------------

				Normally, the game uses a lookup table for its random number generation.
				It has 256 numbers permanently written down and hands them out, one at a
				time, whenever one is needed, starting over from the beginning whenever
				it runs out. This is a bad implementation for several reasons:

				1) The "random" numbers repeat very frequently, resulting in repeated
				results occurring surprisingly close together.

				2) The table is poorly organized, with streaks of poor results in a row
				that are unlikely to occur in a true random sequence of this size. While
				streaks of this nature can and should occur in a truly random sequence,
				the result is an obviously streaky RNG when combined with point #1.

				3) If you know the table, you can have full control of all the "random"
				numbers in the game.

				To solve this, we replaced the lookup table with an actual RNG algorithm
				(XORSHIFT, for the curious) and added a frame counter, thus rendering it
				essentially impossible for a human player to predict the next output of
				the RNG (you would need to know the exact frame you're on at any given
				time and have a giant reference table handy) and allowing for good and
				bad luck to occur at random instead of at predetermined intervals.

---------------------------------------------------------------------------------------------------------

	Irregular Encounters	In the original game, the chances of any (eligible) random encounter
	--------------------	being a pincer or a side attack was 7/256 for either one, or a combined
	 (Seibaby)		total chance of just over 5%(*), while back attacks had a more favorable
				30/256 (roughly 1/8) chance of appearance. In Brave New World, all three
				non-standard encounter types each have a 32/256 (exactly 1/8) chance of
				being called, making them much more common.

				   *An RNG oversight caused these odds to be even lower in practice

				Pincer attacks in particular were rare in the original game because the
				"back attack" bonus to physical damage meant that a happenstance pincer
				attack would often end an unlucky player's game with no recourse. Side
				attacks saw enemies suffering a similar fate, and any boss battle that
				took place in either one of the two had severe balance issues due to it.
				As mentioned earlier, the "backstab" bonus is removed in Brave New World
				and the challenge of side and pincer attacks instead focuses more on the
				increased difficulty of targeting your commands.

				For example, healing in a side attack is harder because regular "Cure"
				spells can only be spread to cover one side of the field. Further, any
				ability that targets an ally "group" (i.e. the "RegenX" spell) will also
				be unable to affect your entire party. Only abilities that specifically
				target ALL of your allies - such as Holy Wind - can do so.

				Back attacks are much easier to understand: the drawbacks are that your
				characters' rows are inverted and the enemy party gets the first action
				(explained above). Pincer attacks follow the same rules except that all
				of your characters are treated as if they were in the front row.

	   Ten-Step Battles	One of the more aggravating aspects of random encounters in the original
				game was their frequent tendency to "randomly" occur within one or two
				steps of one another. There is now a minimum of 10 steps between random
				encounters under most(*) circumstances.

				   (*This value is lower on the overworld map and in certain dungeons)

	   Formation Odds	The appearance probabilities of the last two enemy formations in a pack
	   -(Synchysi)		have been changed from 5/16 and 1/16 to 3/16 (each). This allows for a
				greater variety of enemy encounters, particularly in larger areas.

---------------------------------------------------------------------------------------------------------

	Conditional Behavior	While the focus of Brave New World is the new esper system and character
	--------------------	development, its enemies are the vehicle through which that ambition is
	 (BTB)			fully realized. If the fun of a game is building up and customizing your
				team, then the final product is only entertaining so long as it provides
				opportunities and incentives to put those skills and abilities to use.
				The vast majority of Brave New World's initial and continued development
				is thus dedicated toward restructuring the game's enemies in a way that
				meaningfully complements its character design.

				Enemies in the original game were not particularly complex, and the few
				that were died so fast that you'd never know it. Brave New World treats
				enemies as puzzles to be solved instead of beef gates to be powerleveled
				through, and so there's a strong element of "figure out what makes this
				enemy behave more aggressively and prevent it from happening" at play.
				Bigger, stronger enemies tend to be more docile unless they're attacked
				first or their companions are killed, while weaker ones appear in larger
				numbers and may use stronger attacks if not dealt with quickly. The goal
				is to identify how to deal with each individual encounter as efficiently
				as possible (and without getting yourself killed); if you're the type of
				player that just mashes "A" to win, then Brave New World is not for you.

				While many enemies in Brave New World behave according to the template
				described in the above paragraph, there are several other conditionals
				that can alter their behavior, such as responding to the presence of a
				particular status effect either on your party members or on themselves.
				Status effects are a major factor in Brave New World, especially in the
				later game when enemy encounters become more difficult to deal with just
				by killing them quickly and/or in the "correct" order. It's my personal
				belief that status effects are the biggest "X-factor" that separates an
				engaging battle system from a pure numbers game, and the overall design
				of Brave New World heavily reflects that belief.

				This design philosophy can be further seen with certain enemies who will
				react to being hit with an elemental weakness in various ways, only some
				of which are immediately obvious. Thus, even as you continue to acquire
				more and more powerful elemental attacks, the lesser ones can remain a
				useful tool to invoke these responses when the situation calls for it.

	   Vindication		Another "alternate" conditional that a few enemies in Brave New World
	   -(Seibaby)		utilize is to just harass the last character to have attacked it. This
				targeting method was slightly flawed in vanilla since it didn't make an
				exception for confused friendlies and could easily lead to enemy mobs
				beating the shit out of each other. Here, they'll only go after you.

	   Melee/MP Counter	Despite the simplicity of how it was used, the original game's AI engine
	   -(Seibaby)		was actually quite robust for its time, allowing enemies to identify and
				respond to any combination of specific spells, skills, and/or commands.
				What it couldn't do was distinguish between physical and magical damage,
				nor could it determine whether the attack was melee (i.e. respects row)
				or ranged, which really makes sense when you think of this mechanic in
				the context of being used for counter-attacks. Thus, many foes in Brave
				New World will counter any row-respecting physical damage, be it a sword
				swing or Edgar's Chainsaw, but will NOT counter an attack from a ranged
				weapon like a boomerang or Edgar's Autocrossbow.

				(NOTE: a bug/feature of this hack is that enemies only consider the last
				 portion of an attack to determine what type it is and so the check will
				 return false so long as the second weapon [if dual-wielding] is set to
				 ignore row or if the last part of the attack was a random spellcast.)

				The second part of this hack also allows foes to identify an attack that
				damages MP instead of (or in addition to) HP. This functionality is used
				mostly on certain bosses where such attacks might be useful (protip: all
				undead enemies - including bosses - die at 0 MP in Brave New World).

	   X-Magic Counter	Although the norm in Brave New World is that only melee attacks can be
	   -(Think/Bropedio)	countered, some enemies - bosses in particular - retain the capacity to
				counter ANY attack. This was slightly problematic for X-Magic users in
				particular since it was originally executed as two separate commands and
				therefore ran an increased risk not only of eating a counter-attack, but
				possibly eating two of them. Thus, enemies are now allowed only a single
				reaction to any X-Magic command, even if both spells affect them.

	   Death Counters	The original game dedicated a significant amount of AI code to ensuring
	   -(Bropedio)		that enemies with counter-attacks would not do so when the attack which
				triggered them was fatal. This code has been removed in Brave New World,
				often leading unobservant players to incorrectly assume that enemies in
				BNW have "death" counters rather than counter-attacks that simply aren't
				prevented by death. However, as part of Brave New World's heavy focus on
				status effects to disable opponents, the enemy "death" routine no longer
				clears them before processing reactive enemy AI. Thus, a sleeping enemy
				will not counter an attack (physical or otherwise) that kills it.

				In earlier versions of Brave New World, the above-mentioned code removal
				also made it possible for counter-attacks made on death to counter even
				another counter-attack (which isn't normally possible because infinite
				loops are bad). This is because the game forces a reactive AI check on
				death regardless of what caused it, except this check would occasionally
				fail - hence why bosses would sometimes die like a normal enemy instead
				of through their special death animation. As part of this exception, the
				game did try to limit the reactive script to only checking conditionals
				that assumed the enemy was dead, except they forgot to include counter-
				attacks in this rule and so they would trigger the full reactive script.
				However, due to the above-mentioned code that forbade most enemies from
				counter-attacking if they were dead, this bug rarely materialized.

				So what does all of this mean? Effectively, not a whole lot. Brave New
				World already had its own method of making sure that bosses die in the
				intended manner (see below) before Bropedio found and fixed this bug, so
				all it ended up doing was fixing the "enemies sometimes counter-attack a
				counter-attack" issue as well as ensuring that giants - the only line of
				enemies in Brave New World that have actually an explicit dying attack -
				will use it even if they die from poison or sap damage.

	   Life Cycles		Speaking of bosses in Brave New World, something else that they can do
	   -(Synchysi)		that was not possible in the original game is have more than 65,535 HP.
				This is done by coding "lives" into an enemy's reactive AI and doesn't
				necessarily require any coding aside from that to work. However, due to
				the above-referenced issue of reactive checks sometimes failing, it was
				thus imperative to put a failsafe in place.

				In response to this, any boss that breaks the 16-bit HP cap in Brave New
				World is flagged simply to not die when their HP is at zero. This forces
				them to die a scripted death only in response to being attacked, meaning
				that while sap damage is an important aspect of boss fights in Brave New
				World, bosses cannot actually die from it (or from counter-attacks).

---------------------------------------------------------------------------------------------------------

	Evade Bug Fix		Physical and magical evasion now function properly instead of magical
	-------------		evasion covering both types and physical evasion doing nothing at all.
	(Terii Senshi)
				For the sake of simplicity, the accuracy of all avoidable attacks, both
				physical and magical, has been set to 101%(*) so that the chance to hit
				is simply ~(evasion/128)%. Of note is that while many foes in Brave New
				World do possess physical evasion, THEY DON'T HAVE ANY MAGICAL EVASION.
				Thus, any magic-evadable attack will only ever miss against the player.

					*Exceptions: Drain/Osmose (90%) and Rock/Meteo (80%)

	   Evasion Statuses	Fixing the evasion system awakened a dormant mechanic from deep within
	   -(Synchysi)		the game's code wherein physical attacks will gain accuracy bonuses or
				penalties (+/-25%) if the target has certain statuses set. Some of these
				made sense and were left alone, like how being slowed, blinded, muddled,
				or zombied will now make the afflicted easier to hit. Others, most oddly
				the rerise (AKA "Life 3") status being subject the same penalty, were
				fucking retarded and were thrown in the trash where they belong.

				The big issue, however, wasn't with the accuracy bonuses, but rather the
				penalties when attacking targets affected by the haste, sap, poison, and
				"near fatal" statuses. Not only did none of these make any sense (except
				for haste, but haste is OP enough already), but their newfound ubiquity
				in Brave New World - haste and sap in particular - made balancing the
				physical game hell. Needless to say, they're gone now.

	   Parry & Counter	On the flip side to the above, a functional evasion system combined with
	   -(Synchysi)		several characters who are very much built for it (Locke and Shadow come
				immediately to mind) rendered the "randomly counters" property less than
				useful since characters could originally only counter attacks that had
				successfully hit them (which in Shadow's case usually left him too dead
				to retaliate). We have removed this requirement, thus allowing the likes
				of Locke and Shadow to parry and counter to their heart's content.

---------------------------------------------------------------------------------------------------------

	Smart Cover		This fixes the "protect allies" effect to behave more intelligently than
	-----------		before. Primarily, it disables blocking attacks that originate from your
	(Seibaby)		own team under most circumstances, which has the significant benefit of
				preventing party members from being "protected" vs. healing weapons (see
				"Ally Retargeting" below). Muddled/Zombied characters will be allowed to
				hit themselves, but not their teammates. One notably important change in
				light of the fact that characters can now cover non-critical allies (see
				"Tank & Spank" above) is that cover will no longer activate on an enemy
				counter-attack - only proactive strikes.

				Cover is also disabled under the the following other conditions:

					If bodyguard has...		If target has...

					Blind				Image
					Bserk				MagiTek
					Image				Death    (*)
					MagiTek				Stone    (*)
					Muddle  (unchanged)		Zombie   (*)
					Sleep   (unchanged)		Clear    (unchanged)
					Death   (unchanged)
					Stone   (unchanged)
					Zombie  (unchanged)
					Clear   (unchanged)

					    *This game was programmed by monkeys, I swear

				(Note that the above changes only apply to the cover effect under normal
				circumstances; the "Love Token" ability will cause its target to cover
				the caster excepting only the statuses that were originally considered.)

				Finally, cover is disabled entirely if Golem is active, and attacks that
				would be nullified/absorbed by the intended target are also not blocked.
				Interceptor will also not show up if Shadow is covering someone else.

					    (See also "The X-Fight Effect" further below)

	   Cover Cleanup	Two minor visual bugs with cover have also been fixed here. The first is
	   (-Bropedio)		a sprite layering issue that caused guarding characters to appear behind
				any protectee who is above them in the party lineup. The second is that
				they will now always appear on the correct side of their protectee in a
				non-standard battle (i.e. side or pincer attack).

---------------------------------------------------------------------------------------------------------

	Vanish/Doom Fix		One of the original game's more infamous bugs (and one of the select few
	---------------		to warrant a shitty patch job in all subsequent releases) regarded the
	(Terii Senshi)		"clear" status circumventing instant death attacks. This issue is fixed
				PROPERLY in Brave New World (shout-outs to Terii Senshi) instead of by,
				I shit you not, just making bosses immune to vanish like FF6A does.

	   Death Special Fix	Lesser known (and infinitely less exploitable) than the Vanish/Doom bug
	   -(Think)		is where enemy "special" attacks that cause instant death would flat-out
				ignore death immunity altogether, vanish or not. The root cause of both
				bugs is the roundabout way that the code treats death as a status, and
				the general lack of enemy specials in the original game that are set to
				apply death leads me to believe that the developers had to have been
				aware of this bug on at least some level. In any case, it's fixed now.

	   Overcast Fix		Similar to the above, this fixes an issue with an attack called Overcast
	   -(Assassin)		forcibly setting zombie on your party irregardless of immunity. This led
				to it being impossible to remedy due to how immunities work in the game;
				Overcast now simply no longer bypasses zombie immunity.

	   Vanish/Clear Fixes	Finally, going back to the original subject of the "clear" status, it's
	   -(Seibaby)		no longer removed from floating targets when ground-based attacks (i.e.
				Quake) don't hit them or from Celes when she absorbs a spell with Runic.
				Further, spells cast by using rods as items now will remove the status.

---------------------------------------------------------------------------------------------------------

	Abort On Enemies	Failing the old "Vanish/Doom" trick, a vanilla player's primary fallback
	----------------	for any undead enemies (including bosses) was simply to toss a Phoenix
	 (Synchysi)		Down or Revivify on it and call it a day. In Brave New World, all items
				(except for Dried Meat) are hard-coded not to work on enemies at all.

				Quite a few of the original game's laundry list of bugs tend to involve
				hitting enemies with shit that's not meant to be used on them, Palidor
				being a rather notable offender. Curiously, there's a targeting flag in
				the game's code to abort an attack in the event that it somehow ends up
				targeting the party, yet there's no equivalent for your enemies, where
				such a flag is actually needed (and, in Brave New World, now exists).

				And as for shit that's fine on regular enemies, but not on bosses...

	   Boss Immunity	The "Suplex" byte, which originally prevented Suplex from targeting
				certain enemies (primarily those of the floating or stationary variety),
				is now a hard override to prevent fractional damage attacks (i.e. Demi,
				Quartr) from being cheesed against bosses. Such attacks originally were
				set to miss anything immune to instant death, so instant death attacks
				were thus always preferable. Fractional damage now deals earth and/or
				wind damage and follows suit with other earth and wind attacks by being
				generally very powerful, but unable to hit a weakness due to a lack of
				them (though some enemies still resist them). Against an enemy with hard
				immunity to them, fractional damage attacks now drop the flag specifying
				them as such and instead do minor damage (thanks to Bropedio).

				And yes, Suplex works on everything now - have fun pile-driving Kefka.

---------------------------------------------------------------------------------------------------------

	Genji Glove Fix		Dual-wielding weapons now results in a 25% decrease in damage from both
	---------------		weapons (as it was originally intended to do). Note that this patch has
	(Assassin/Synchysi)	been modified from the original version to only affect regular physical
				attacks instead of all attacks that deal physical damage (i.e. Blitz).

	   Dual Wind Damage	Another modification to this hack allows the damage penalty to affect
				weapons that randomly deal AoE wind damage in place of regular physical
				damage. See also the Gauntlet fix below for more on this.

	   Dual-Wield Weapons	Finally, note that the dual-wield property is now attached to certain
				weapons (see the printme) rather than to a relic. Any weapon possessing
				the dual-wield property allows a second weapon to be used regardless of
				whether or not the second one allows for it - a sword and dagger combo,
				for example, is a valid setup.

				The only exception to the above is spears, which are disallowed in dual-
				wield setups because I spent most of the mod's development running Mog
				with a spear/boomerang and Synchysi thought it was bloody stupid.

	   Dual-Wield Jump	In the original game, using the "Jump" command with a dual-wield setup
	   -(Bropedio)		was a poor idea since only one weapon (chosen at random) would be used
				for the attack. It's still not the greatest idea in Brave New World, but
				it's at least more consistent - the jumper will always attack only with
				their primary weapon (sans the 25% damage penalty for dual-wielding).

---------------------------------------------------------------------------------------------------------

	Gauntlet (Fix?)		Holding certain weapons in both hands now increases attack power by 50%
	---------------		rather than 75%. This was done because, as with the dual-wield property,
	(Synchysi)		two-handed functionality is now applied to specific weapons rather than
				enabled by a relic and the game's original bonus led us to some balance
				issues (think "dragoon"). A modified version of a hack made by Assassin
				is also used to accurately display their attack power in the equip menu.

	   2-Hand Wind Attack	As also with the above hack, a 50% damage bonus will also apply to wind
				attacks randomly cast from the Kazekiri or Mutsunokami if they are held
				in both hands. Combined, these hacks allow for a very noticeable balance
				between those weapons when used by Shadow (who typically dual-welds) and
				Cyan (who is forced to use both hands since he can't use a shield).

	   Two-Handed Weapons	Finally, note that using two hands for weapons that allow it is entirely
				optional (except for Cyan, who as noted above is forced to do so by his
				equipment restrictions). Specifically, giving Edgar or Mog a spear and a
				shield (i.e. The SPARTAAAAAAAAAAAAAAA! Setup) is allowable; a two-handed
				weapon will turn yellow if the other hand is empty to indicate that the
				damage bonus is present, else it will appear in white as normal.

---------------------------------------------------------------------------------------------------------

	Elemental Mixing	This hack greatly improves the way that the game handles resistance to
	----------------	multi-elemental damage. In the original game, the highest resistance to
	(Think/Bropedio)	any element present would always take precedence regardless of weakness
				or non-resistance to any others. Here, it's more of a sliding scale:

				• Immunity to a multi-elemental attack now requires immunity to BOTH
				  elements; damage is halved if only one element is immune, while a
				  weakness to the other will result in normal damage

				• Resistance to only one element is the same as immunity to only one

				• Absorption of an element trumps all else, even weakness to the other

				This hack also applies to mixing weaknesses and resistances to the same
				element on a player character, namely when Gau takes on enemy weaknesses
				through Rage. In this case, the above rules still apply except that only
				resistance will be cancelled out by weakness to result in normal damage
				while immunity or higher will override a weakness.

	   Elemental Statuses	Additionally, elemental attacks which also set status effects no longer
	   -(Bropedio)		attempt to do so on targets who are immune to or absorb the damage.

---------------------------------------------------------------------------------------------------------

	Omni-Defend		The "defend" battle command now halves both physical and magical damage
	-----------		instead of just physical damage. This is a rather important hack for the
	(Synchysi)		crazies who are trying for a level one Gogo (and yes, it's been done).

---------------------------------------------------------------------------------------------------------

	Ally Retargeting	Curative items and weapons will now properly re-target to a random ally
	----------------	if the intended target becomes invalid before the command is executed,
	(GrayShadows)		with the curative weapons in this case being Relm's paintbrushes.

	   Brush Targeting	In addition to retargeting properly on death, brushes will now correctly
	   -(Synchysi)		target your party by default unless the user is muddled or bserked.

	   Item Retention	Similar to the first issue, if an item user dies or is disabled before
	   -(Bropedio)		the command executes, the item will no longer be consumed regardless.

---------------------------------------------------------------------------------------------------------

	Sketch Fixes		First and foremost, using Sketch should no longer cause the universe to
	------------		implode on itself (Assassin). Second, the Sketch formula now uses Relm's
	(Assassin/Synchysi)	stats instead of the target's so it's actually worth using (Synchysi).

	   Brushless Sketch	Finally, Sketch is now disallowed unless a brush is equipped by a patch
	   -(Assassin)		called "Brushless Sketch" (which does pretty much the exact opposite of
				what its name suggests) because painting with a knife is something that
				only psychopaths do (which Relm kind of is, come to think of it).

---------------------------------------------------------------------------------------------------------

	Auto-Swordless Runic	Similar to the Brushless Sketch patch, Auto-Swordless Runic keeps Celes
	--------------------	from spamming the ever-loving shit out of Runic when she's Muddled or at
	 (Assassin)		the Colosseum if she doesn't have a sword equipped.

	   Non-Elemental Runic	We've also corrected a bug wherein Runic'd spells would not be stripped
	   -(Synchysi)		of their elemental properties, so protection from any element would also
				"protect" Celes (or Gogo) from absorbing the spell's MP cost.

	   Runic Stance		Finally, Celes will now remain in her "ready" stance to provide a visual
	   -(Bropedio)		indication to the player that Runic is still active.

---------------------------------------------------------------------------------------------------------

	Persistent Rage Fix	So called because the original name is stupid (sorry, Assassin) and not
	-------------------	really descriptive of what the patch does. What it does is recalculates
	 (Assassin)		resistances whenever Gau dies so that elemental immunities/weaknesses he
				gains through Rage won't persist (and stack) throughout the battle.

	   Rage Status Patch	This is an extension of the above which makes it also affect statuses.
	   -(Think/Bropedio)	There are several problems here that stem primarily from the fact that
				the game interprets status immunities as "(status) cannot be toggled".
				Thus, a rage that grants an immunity would make that status unremovable
				(except via death) if it was already present when the rage was entered.

				The other problem is a combination of two factors: the game treats any
				"inherent" status granted by equipment or through rage as an immunity to
				that status and the in-battle routine to update status immunities failed
				to clear several of them, including Regen, Haste, Float, Slow, and Stop.
				As a result, gaining any of these statuses through rage (or equipment)
				would render them permanent for the duration of the battle.

				Three things are done to address these issues. First and most obviously,
				the above-mentioned statuses are now included in the routine to update
				status immunities. Secondly, when Gau enters a rage, he's purged of all
				statuses that the rage grants immunity to. Third, the routine to update
				immunities now removes any inherent statuses that it clears.

	   Hotswap Update	The third point above may seem extraneous since the only way to lose the
	   -(Bropedio)		Rage status is to die(*), which clears all statuses regardless. However,
				this routine is also called when changing out weapons and/or shields in
				combat, which had the same persistent status issues as Rage. The routine
				now also properly updates maximum HP/MP as per equipment bonuses, which
				was irrelevant in vanilla since no weapons or shields had them.

				   *It is possible to lose the Rage status without dying in BNW

---------------------------------------------------------------------------------------------------------

	Impology		Imp was always one of the more misunderstood effects in Final Fantasy VI
	--------		since it wasn't very up-front about what it did and even it didn't seem
	(Synchysi)		to have a very good idea about it was trying to be. It was a weird sort
				of offensive debuff/mute hybrid that didn't even behave the same way on
				enemies as it did on your party. And don't even get me started on how
				buggy the animation was (and still is - see "Known Issues" later on).

				Now, imp is a simple output debuff: 50% off everything, both offensively
				and healing-wise. It's basically the exact opposite of Morph (see below)
				except that it doesn't affect incoming damage. Attacks and spells with
				fixed or fractional damage are unaffected, but the penalty does apply to
				sap and regen ticks for the same reason that the Morph bonus does.

				As such, Imp no longer blocks any commands except for Morph as the two
				can't coexist in a way that is visually apparent to the player. If Terra
				is able to Morph while imped due to having already input the command, it
				will override the Morph status. Further, Terra will be immune to imp so
				long as she remains in her Morph stance. And speaking of Morph...

---------------------------------------------------------------------------------------------------------

	Morphology		Terra's Morph ability is now a toggled stance rather than a timed one.
	----------		Rather than doubling her offensive output and halving all magical damage
	(Synchysi)		taken, it now boosts her output by 50% at the expense of doubling all
				damage taken. This damage penalty is reduced by 1/128 for each point of
				stamina that Terra has, down to a minimum of 25% at 96 stamina.

				It's important to note that the 50% output boost from Morph applies to
				pretty much everything. The Morph bonus is added to damage calculation
				as a "multiplier", which in the original game are ignored by any attack
				that ignores defense. This is no longer true - defense-ignoring spells
				and abilities now respect multipliers. This includes curative spells,
				which ignore defense as an obvious necessity.

				On the subject of healing, the above-mentioned damage penalty does not
				distinguish between incoming damage and incoming healing - everything
				will hit her for higher numbers (except for fixed or fractional values).
				This means that, although Terra will be more fragile in her esper state,
				she'll also be much easier to heal. Where things start to get confusing
				is sap and regen ticks, which both receive the Morph damage multiplier
				because the code considers those things to be Terra hitting herself. For
				that same reason, however, they are further boosted by the penalty that
				doubles all incoming damage. This means that the same stat which raises
				the strength of her regen ticks in the first place will, in fact, LOWER
				the boost they get from Morph, making the whole mess a wash.

---------------------------------------------------------------------------------------------------------

	Treasure Hunting	Steal/Mug no longer takes the level of the "treasure hunter" or victim
	----------------	into consideration and is now just a straight-up roll against the RNG
	(Synchysi)		that uses the "hunter"'s speed (% of success = (112 + Speed * 2) / 256).

	   Rare Steals		Speed also affects the likelihood of a rare steal (Speed / 256) instead
	   -(Seibaby)		of the flat 1/8 chance in the original game, making them more common in
				the later game with a little bit of investment in Locke's speed.

	   Quicksteal		Further to the above, successful steal attempts are now treated by the
	   -(Seibaby/Nowea)	game as a "free" action and will immediately refill the ATB gauge of the
				character who performed it (note that this also applies to random steal
				attempts made by a certain knife). This allows the "Mug" command to act
				as a multi-attack rather than just a regular one plus a theft attempt.

	   Mug Effects		Weapons now retain special properties when used with "Mug", such as the
	   -(Bropedio)		anti-human property of the Butterfly or Man Eater or the special effect
				of the Atma Weapon. The only exception is the random "anti-flying" proc
				on thrown weapons (see "Special Weapon Effects" below) that would look
				seriously jacked on a melee strike. Aside from that, however, Mug is now
				equal to the Fight command in terms of damage under any circumstance.

	   Why We "Fight"	To balance the above concern so that Mug isn't just "Fight, but better",
	   -(Bropedio)		the attack will miss if the Steal attempt is unsuccessful. This includes
				failure due to the target not possessing an item, so Mug should only be
				used against enemies that are carrying something. And on that note...

	   Two Legs Good	As I mentioned earlier, treasure hunting has been standardized so that
	   -(BTB)		only humanoid enemies have items for the taking. This not only made it
				easier for me to balance stealables since I had far fewer foes to work
				with, but it also makes it much easier for players to figure out which
				enemies are worth the effort to "hunt" from.

---------------------------------------------------------------------------------------------------------

	Bushido Blade		Physical-damage bushido techniques (Dispatch, Flurry, and Tempest) now
	-------------		account for the user's equipped sword to influence their strength rather
	 (Synchysi)		than having a set power that doesn't improve with better weapons.

				But more importantly...

	   SwordTech Charger	Bushido no longer takes a bloody lifetime to charge up, making the damn
	   -(ArmorVil)		skill actually usable. The meter now charges at an acceptable pace, and
				the speed will further increase as more techniques are learned.

---------------------------------------------------------------------------------------------------------

	Leap Anywhere		The "Leap" command can now be used on any rageable formation, regardless
	-------------		of whether or not you're on the Veldt. While this does give Gau earlier
	 (Seibaby/Bropedio)	access to some key rages in certain areas, it's mostly a quality-of-life
				hack that makes it much easier to collect all of his rages.

				Leap also no longer ends the current battle. Rather, it will remove Gau
				from the party for its duration (he's counted as dead for the purpose of
				what happens if the rest of your party dies); he will learn the rages of
				the enemy party whether you win the fight or run (Seibaby). If Gau knows
				all of the rages in a formation already, Leap is disabled (Bropedio).

	   Easy Rage Hunting	Brave New World completely redesigns the original game's enemy encounter
	   -(BTB)		structure specifically to make collecting every rage on the Veldt itself
				as quick and easy as reasonably possible. Also, any rageable formation
				that can be missed (i.e. appears in an area that you can't go back to)
				can be found in the Grenade Forest or on Triangle Island (WoB only).
				(Also see "Rage and Dance Moves" and "Alphabetical Rage" further below
				for more on what we've done to make this skill more user-friendly.)

---------------------------------------------------------------------------------------------------------

	Throw Effects		As with "Mug", weapons now retain all of their special effects when used
	-------------		with "Throw" (namely the "2x damage to humans" property of Butterfly and
	 (Think)		Man Eater knives), again excluding the random "throw" ability on several
				knives because a random chance of the thing you're throwing being thrown
				is the kind of stupid-ass shit you saw in the original game.

				(For those of you who are curious how Throw determines its damage, it's
				basically a regular attack with the weapon being thrown that ignores the
				user's row, the target's defense, and is given a 100% damage boost.)

	   Go Throw		Gogo can now still use Throw even if Shadow is no longer available.

---------------------------------------------------------------------------------------------------------

	Good Doggo		Although Shadow's "dog block" status provides a 50% chance to avoid any
	----------		physical attack BEFORE standard evasion is considered, Interceptor would
	(Bropedio)		inexplicably appear less frequently later in the original game than he
				did earlier on. This is because after it was determined that doggo had
				blocked an attack, the game would choose randomly from a pool of every
				applicable evade animation from Shadow's equipment instead of always
				using the dog. Correcting this does not affect Shadow's evasion	at all,
				but it does largely increase the odds of Interceptor's counter-attacks
				(50% chance of countering any blocked attack, so 1/4 odds overall).

						(See also "Golem Fixes" further below)

---------------------------------------------------------------------------------------------------------

	Rage & Dance Odds	The two attacks on each rage are now common (2/3 odds of being used) and
	-----------------	uncommon (1/3 odds) instead of it being an even 50/50 chance. Similarly,
	 (Synchysi)		the 2nd and 3rd steps of each dance now have 5/16 and 3/16 odds instead
				of 6/16 and 2/16 (respectively). Both of these changes combine with an
				overhaul of the attacks involved, because diversity (it's a thing now).

---------------------------------------------------------------------------------------------------------

	Slot De-Rigging		The Slots command is no longer rigged to force certain outcomes based on
	---------------		how the RNG is feeling - it's now entirely timing-based, and the reels
	 (Synchysi)		have been edited to group the symbols together, FF7-style:

					REEL 1		REEL 2		REEL 3
					------		------		------
					7		7		7
					Bar		Bar		Bar
					Chocobo		Blackjack	Diamond
					Chocobo		Blackjack	Diamond
					Chocobo		Blackjack	Diamond
					Bar		Bar		Bar
					Bar		Bar		Bar
					Diamond		Chocobo		Blackjack
					Diamond		Chocobo		Blackjack
					Diamond		Chocobo		Blackjack
					Bar		Bar		Bar
					Bar		Bar		Bar
					Blackjack	Diamond		Chocobo
					Blackjack	Diamond		Chocobo
					Blackjack	Diamond		Chocobo
					Bar		Bar		Bar

				   (Refer to the printme for a full list of spins and their effects)

				Furthermore, the 7-7-BAR "fuck you" spin has been disabled and 3 Bars no
				longer skips over Odin as a potential result. However, they now ignore
				Phoenix to prevent a bug where Setzer will take one extra step forward
				for every living character in the party when he uses it.

---------------------------------------------------------------------------------------------------------

	Make It Rain		The formula for GP Toss (AKA "GP Rain") has been reworked to make it an
	------------		attack worth actually using, particularly for a stamina-built Setzer.
	 (Synchysi)
						OLD GP RAIN FORMULA
						-------------------
					GP Rained = Lv * 30
					Dmg = (GP Rained * 2) / # of foes

						NEW GP TOSS FORMULA
						-------------------
					GP Tossed = Stam * 10
					Dmg = (GP Tossed * Lv) / (2 * (# of targets + 1))

				Further, GP Toss has been designated as a "free targeting" attack (press
				L/R to target multiple foes) instead of being forcibly multi-targeted.
				This is a particularly important feature for GP Toss given its special
				damage split formula that penalizes damage output for every target hit
				rather than the flat 50% penalty used by all (most) other attacks.

---------------------------------------------------------------------------------------------------------

	Umaro Hit Hard		Umaro has four attacks: a regular "Fight" attack and three special ones,
	--------------		two of which are enabled by specific relics. If you count the fact that
	 (Synchysi)		his base stats and the attack power of his Bone Club have been adjusted,
				all four of them have been changed in Brave New World.

				..."Tackle", which is always available, is basically just his regular
				fight command set to ignore defense. Because Umaro's base attack power
				combined with that of his weapon give his regular attacks a maxed-out
				attack power of 255, this is basically his equivalent of Bum Rush.

				...the (unnamed) "character toss" ability enabled by the Storm Belt was
				initially just Tackle set to add the attack power of the character being
				tossed to Umaro's. However, since attack power is an 8-bit value (read:
				it caps at 255), this didn't end up being as significant as it was meant
				to be (in other words, it was a clone of Tackle). It now has a set power
				of 255 with the "Gauntlet" bonus applied for an effective power of 382.
				Further, it now deals critical damage if the character being thrown is
				Mog (as it was originally intended to do, but didn't because of a bug).
				As always, Umaro will prioritize throwing allies with the "muddle" or
				"sleep" statuses, as this attack will remove them.

				..."Blizzard" (formerly "Storm"), which the Blizzard Orb relic enables,
				no longer does half damage (AKA "split loss") if more than one target is
				present. Its power has been lowered slightly (100 -> 90), but Umaro's
				stats more than make up for that. Note that this is the same "Blizzard"
				attack that appears in the Snowman Jazz dance (refer to the printme for
				details) with two notable distinctions. One, it uses Umaro's stamina to
				determine its damage rather than his (nonexistent) magic power. Two, it
				bypasses the enemy stamina check to see whether or not it sets blind.

	   Yeti Attack Odds	The odds of each attack being used have also been adjusted. Previously,
				they varied depending on whether Umaro had one or both of his special
				relics equipped - having both on was often undesirable as the odds of
				Rage or Storm being used were higher if only their one special relic was
				equipped. To simplify things, all three of Umaro's special attacks now
				have a hard 76/256 (roughly 30%) chance of being used, otherwise Umaro
				will use his regular fight command. This gives fight a 179/256 chance
				(roughly 70%) of being used if neither special relic is present, 103/256
				odds (or 40%) if one is equipped, and 27/256 (10%) if both are.

	   Bare Naked Yeti	Finally, Umaro's equip menu is no longer locked down so that you can now
				(un)equip him just like a normal character. This change was made purely
				to correct a bug in the original game wherein the "unequip all of your
				d00ds" dude wouldn't take Umaro's relics away since it would also remove
				his other equipment (that you'd then have no way to get back on him).

				(And yes, we're aware that the Snow Muffler he comes with in vanilla is
				meant to be his natural fur coat, which is why it can't be taken off of
				him. We'd just like to think that your party shears him like a sheep.)

---------------------------------------------------------------------------------------------------------

	Special Weapon Effects	Many of the special weapon effects in Brave New World are either changed
	----------------------	from their vanilla incarnations or are entirely new effects altogether:

	   Entangle		The Kusarigama and Kagenui (both weapons for Shadow) have a new effect
	   (-Synchysi)		wherein they have a 50% chance of inflicting "slow" and "stop" on their
				target in addition to dealing damage. These weapons are notable as they
				are Shadow's only access to either status, and "slow" is of particular
				importance in Brave New World due to its effectiveness on bosses.

				In addition to the "entangle" effect, the Kusarigama also deals double
				damage to humans while the Kagenui enables X-Fight, effectively raising
				the chances to entangle with each attack to 75%.

	   Breaking Wind	The Tempest (or "Kazekiri" in Japan) was a katana in the original game
	   (-Synchysi)		which, when attacked with, had a 50% chance of hitting every enemy with
				Wind Slash instead of dealing regular physical damage. It was discussed
				earlier that both the dual-wield penalty and 2-handed damage bonus both
				now apply to this attack, but it's also noteworthy that the wind attack
				itself is now actually a stronger version of Wind Slash (power: 60).

				More drastically, the Mutsunokami ("Sky Render" in vanilla) and a brand
				new rod weapon for Strago and Relm both now have the same effect, except
				that they instead cast a much stronger (power: 120) version of Aero
				(special thanks to Madsiur for speeding up the long-ass animation).

	   Zantetsuken		The 1/4 "cleave" effect on the Zantetsuken (also used by the Ichimonji)
	   (-Synchysi/Bropedio)	will now deal critical damage to targets who are immune to instant death
				(Synchysi) or when used with "Jump" or "Mug" (since the animation would
				otherwise cause issues with those commands -Bropedio). As an interesting
				side-note, this effect won't prevent ordinary critical hits (1/32) from
				occurring, resulting in a 1/128 chance of a DOUBLE critical hit.

	   Chainsaw Massacre	Similar to the above, the 1/4 "hockey mask" probability on the Chainsaw
	   (-Synchysi/Bropedio)	was edited so that the instant death effect is in addition to the damage
				dealt rather than instead of it (Synchysi). Chainsaw insta-kills now use
				the "cleave" death animation instead of the normal one (Bropedio), which
				is mechanically beneficial in that it prevents counter-attacks.

	   Undead-Slayer	Again similar to the above, what you get here is a 50% chance of instant
	   (-Synchysi/Bropedio)	death, except that it only works on the undead. As with the Zantetsuken,
				undeads immune to instant death instead take critical damage (Synchysi).

				Note that this effect uses the "x-kill" animation that certain weapons
				from the original game used (Bropedio), except instead of being useless
				against the undead it now behaves identically to the "cleave" animation
				by preventing counter-attacks from the dead(er) target.

	   Anti-Air Weapons	Two "special"-type weapons from the original game - the Sniper and Hawk
	   (-Synchysi)		Eye - had an undocumented extra effect wherein they had a 50% chance of
				being thrown at the enemy as part of their attack animation (all other
				long-range weapons were thrown as part of their NORMAL attack animation,
				which makes this weird) for an additional 50% damage to most enemies, or
				a whopping 200% more damage if the target enemy was floating. This large
				discrepancy rendered them a bit overpowered in the situations where they
				were useful and on the useless side otherwise, and thus the damage boost
				for grounded enemies has been raised to 100% and the strength of these
				weapons have been balanced accordingly. This effect has been branded as
				"anti-air" and is now a standard feature of the "special" line of thrown
				weapons, as well as several of Shadow's daggers. To clarify their effect
				on grounded enemies, such weapons are additionally described as having a
				high critical rate - even though they technically aren't critical hits,
				the distinction is essentially meaningless to the layperson outside of
				the 1/64 chance of a throw proc compounding an actual critical hit.

				Ostensibly a bug with its vanilla behavior, the animation now correctly
				plays whenever the proc occurs instead of only against floating targets.
				For a similar reason, this effect is now disabled by the "Jump" command
				and is specifically ignored by the hacks that allow "Mug" and "Throw" to
				otherwise respect special properties since all of them will override the
				special animation and would simply deal more damage seemingly at random.

	   Ignores Defense	The morning star, now exclusive to Terra and Celes, is a powerful weapon
	   -(Think)		in Brave New World in most part due to the fact that it ignores defense.
				As both girls lack an offensive secondary skill, the Morning Star is one
				of their few options for consistent damage output.

				Furthermore, as mentioned above in "Morphology", all defense-ignoring
				attacks respect damage multipliers in Brave New World. Aside from Morph,
				the only other effect that change has is that defense-ignoring weapons
				are now boosted	by the "bserk" status, where previously they weren't(*).

				  *There's actually an exception (Dice) since FF6 was coded by monkeys

	   Check My Dubs	Speaking of dice, the way they were designed in the original game meant
	   -(Seibaby/Bropedio)	that the regular kind (two dice) were garbage while the "fixed" variety
				(three dice) were the absolute tits. Aside from the obvious addition of
				a third multiplier to increase their damage output, the first two dice
				(i.e. the only two in a standard set) were weighted toward lower results
				while the third die was - ironically - the only one to roll fairly. To
				top it all off, rolling triples with the Fixed Dice would multiply the
				final damage by the value rolled, easily hitting the damage cap for 4's
				and higher. This bonus now applies to rolling doubles with regular dice,
				and all three dice are now weighted to roll fairly.

				     (Also, dice no longer do 50% more damage with Bserk. -Bropedio)

	   The Atma Weapon	Due to the lower overall levels that everyone will achieve in this mod,
	   (-Synchysi)		the special damage formula used by the Atma Weapon ends up nerfing the
				ever-loving shit out of it since it assumes a "baseline" level of 64(!).
				To remedy this problem, its formula has been gutted:

						OLD ATMA WEAPON FORMULA
						-----------------------
					1. Normal attack (ignores defense)
					2. Dmg = Dmg * Lv
					3. Dmg = Dmg * ((HP / 256) + 1) / ((MaxHP / 256) + 1)
					4. Dmg = (Dmg / 64) + 1


						NEW ATMA WEAPON FORMULA
						-----------------------
					1. Normal attack (ignores defense) w/ stamina in place of vigor
					2. Dmg = Dmg * ((HP / 256) + 1) / ((MaxHP / 256) + 1)

	   Random Spellcasts	The odds of a random spellcast are 1/4 under normal circumstances, but
	   (-Synchysi)		certain pieces of equipment in Brave New World will double those odds to
				1/2, including the relic which enables Jump as well as all rods.

				And speaking of rods...

---------------------------------------------------------------------------------------------------------

	MP 4 Crits		Weapons that consume MP for automatic critical hits now cost an amount
	----------		equal to 1/2 the user's level rather than [12...19]. This is important
	(Synchysi)		primarily because auto-crits are now a standard feature on rods to take
				advantage of an oddity in the game's code that causes random spellcasts
				from them to also do critical damage - something that spells ordinarily
				cannot do. Combined with the above-mentioned feature which doubles the
				odds of a random spellcast occurring, this allows rods to function as
				viable weapons for magically-inclined characters.

				A major caveat to the above, however, is that random spellcast damage is
				affected by row and 3/4 of BNW's rod users die in a gentle breeze. This
				can be bypassed with the "Jump" command and random spellcast damage will
				receive the 50% damage boost from jumping, but the downside is that Jump
				also disables critical hits and critical hits have a higher damage boost
				(100%) than jumping with a rod does (Jump only provides the same damage
				boost as a critical hit when you do it with a spear).

				An astute reader may recognize the above bonuses as damage multipliers,
				and no doubt many of you are thinking (judging by the number of times I
				get asked this) that Bserk would be the perfect way to jack up your rod
				user's damage. Except it's not. Despite the fact that random spellcasts
				benefit from every OTHER damage multiplier (MP-fueled criticals, "Jump",
				Morph), BSERK DOES NOT AFFECT RANDOM SPELLCASTS. Blame Squaresoft.

	   Spoil The Rod	Speaking of poor coding practices, using a rod (or shield) as an item in
				the original game would cause the resulting spell to deal massive damage
				because items ignore all damage modifiers, specifically (magic) defense.
				This has been fixed so that spells cast from rods used as items will do
				the same damage that they would have had the character cast it normally.

				Also, only the three basic elemental rods - Fire, Ice, and Thunder - are
				now breakable. This is also treated as somewhat of a "hidden" feature in
				that it's never explicitly mentioned either in the printme or in-game.

	   Quartr/Doom Crits	Because the random spellcasts on the Quartrstaff and Doomstick don't do
	   -(dn)		"regular" damage, they are not affected by the bugs/"features" mentioned
				above. This hack allows Quartr to affect all enemies when randomly cast
				from an MP-fueled critical hit (it would normally only affect the target
				of the attack) while the Doomstick will instead cast X-Zone (rather than
				Doom) on a group of enemies under the same circumstances.

	   Apocyllumina Crits	Conversely to the above, the Holy and Flare spells are hard-coded NOT to
	   -(Bropedio)		deal critical damage when randomly cast from the Illumina or Apocalypse;
				this is to prevent them from being massively overpowered.

	   Always Load MP	The game now always loads characters' MP at the start of battle, even if
	   -(Think)		the Magic command is not present. This allows Gogo to use his MP for rod
				attacks without needing Magic (or Lore) set as a command. It also has an
				unintended side effect of doing the same for Banon and the rod-wielding
				moogles in the opening battle to save Terra from the guards, although
				none of them possess enough MP for more than one critical hit.

	   Always Halve MP	Weapons that consume MP for critical hits now respect the "1/2 MP costs"
				property on the Gem Box/Soul Box.

	   MP Refresh Fix	Finally, this fixes a bug where a character's MP would occasionally fail
	   -(SirNewtonFig)	to properly update in the spell menu following the use of MP-consuming
				weapons, thus allowing them to attempt to cast spells for which they
				lacked sufficient MP (which would then fail).

---------------------------------------------------------------------------------------------------------

	The X-Fight Effect	The "Offering" effect is now set to make "Fight" a 2x targetable attack
	------------------	with a 25% damage penalty instead of a 4x untargetable attack with a 50%
	(Synchysi/Bropedio)	penalty (Synchysi), although it remains distinct from just dual-wielding
				in that the second attack will pick a new target if the first one kills
				what it hits (Bropedio). X-Fight appears in BNW on a relic exclusive to
				Setzer, a Shadow-exclusive weapon, and on all brushes. As with vanilla,
				Setzer's Dice and the random wind attacks from the Kazekiri/Mutsunokami
				are exempt from the damage penalty, as are random spellcasts (Sakura).

				Finally, the new "X-Fight" also lacks several little-known properties of
				the original: it's not unavoidable, it no longer disables critical hits
				(Bropedio) or random spellcasts (Synchysi), and it will no longer bypass
				cover (this is part of Seibaby's "Smart Cover" hack and	is basically a
				bugfix for the "Love Token" effect).

	   Double Jump		Similar to the above, the ability for "Jump" to strike more than once is
				now attached to a special helmet (instead of a relic) and offers a 1/4
				chance of a second hit (instead of varying odds of up to FOUR), although
				unlike X-Fight, the second jump always selects a target at random.

---------------------------------------------------------------------------------------------------------

	Magic Bonus Fixes	The "+25% magical damage" relic property had several odd effects in the
	-----------------	original game, only one of which - that it could be stacked despite the
	 (Synchysi)		fact that its physical counterpart couldn't - seemed to be intentional.
				It was being applied to periodic damage (i.e. sap/poison ticks) - even
				allowing them to go over the 8-bit cap - and was not being applied to
				curative magic (which, to be fair, may or may not have been intended).

				In any case, all of the above-mentioned issues have been fixed, and the
				equipment that offers +25% bonuses now use the word "output" instead of
				"damage" to indicate that the bonus also applies to curative abilities.
				While it won't affect those with a set output such as Sabin's Mantra and
				Chakra blitzes, it will affect things such as Edgar's Defibrillator and
				Mana Battery tools or the Harvester and Sun Bath rages/dance steps.

	   Golem Fixes		The durability of Golem's effect is now based on the maximum HP of its
	   -(Bropedio)		caster rather than current so that you needn't worry about being at full
				health to summon it (Synchysi).

				Conversely, Golem shares Interceptor's activation check: a 50% chance of
				blocking before regular evasion is considered. It also shares the issue
				of then picking randomly from a pool of all available evasion animations
				instead of always using the correct one, which invisibly prolongs the
				wall's lifespan since it won't take any damage if the wrong animation is
				called. As with Interceptor, Golem now always uses the right animation.

				Finally, Golem will no longer block attacks which deal no damage and it
				will no longer inherit the safe or back row defense bonuses from or the
				elemental immunities of its protectee.

	   Palidor Fixes	Palidor had some pretty serious problems in the original game, least of
	   -(Bropedio)		all being that it was bugged to hell and back and most egregiously the
				fact that using it was a good way to get yourself killed since the first
				character to land would just get pounded while waiting for their allies
				to come back down. Palidor is changed in several ways here: the "hidden"
				status is now properly set on all jumpers (thus fixing bugs with being
				targeted in midair), characters no longer disappear when Palidor misses
				(i.e. fails to target) them, characters now all land in quick succession
				instead of staggered out, and ATB is preserved upon landing rather than
				being reset (note that it will still increment while they are airborne).

	   Gau Explod		Given the much lower HP totals of player characters in Brave New World,
	   -(Seibaby)		it's generally a losing proposition for the squishiest amongst them to
				commit sodoku in order to do piddly damage at best. Thus, Exploder now
				deals 250% of the user's current HP in damage whenever it's used by a
				member of your party, either via the "Bomb" rage or through Sketch.

---------------------------------------------------------------------------------------------------------

	Life Hack		In the original game, the "Life" spell had the exact same effect as a
	---------		tuft of Phoenix Down: both would revive a fallen ally to 1/8 of their
	(dn/Seibaby)		maximum HP. We thought it stupid that a cheap and freely-available item
				was functionally identical to a resource-consuming spell, hence why the
				"Remedy" spell now also restores HP in addition to its normal effects.

				As for the "Life" spell, its fractional nature made it trickier to work
				with: any value that would make it useful in the early game would render
				it strong enough to step on Life 2's toes in the late game. Thus, it was
				decided for it to revive allies to a semi-static value: a random number
				between 250 and 500. This makes it an extremely powerful revival tool in
				the early game when it can almost function as a full heal from the dead,
				but its usefulness gradually diminishes as you progress and it becomes
				less able to bring a newly-revived character out of OHKO territory.

	   Fractional Items	Phoenix Down, conversely, is no longer EVER able to bring a character to
	   -(BTB)		safety as it now restores them to only 1 HP. This is a less significant
				nerf than most players realize since the maximum HP values required for
				1/8 of it to absorb even a single enemy attack are quite high. There do
				now exist Phoenix Tears, which will restore 75% of a character's max HP,
				but they're (quite obviously) rare and in short supply.

				On the flip side of the above, the inability of curative items to heal a
				set amount of HP/MP greater than 8 bits (255) led to them - at least the
				ones that restored HP - being useless damn near right out of the gate.
				Tonics and potions thus restore 1/2 and 3/4 of a character's maximum HP,
				respectively, allowing them to remain useful throughout the game without
				being overpowered early on (although the latter is now quite expensive).
				Ethers follow suit with potions, while the rare X-Potions and X-Ethers
				are now more useful by virtue of targeting the entire party.

	   Revive And Heal	In the original code, any command could be made to target either living
	   -(Bropedio)		or dead targets, but never both. The Kirin summon, "7-7-7" Slots spin,
				and Heal Force can now both heal living allies and revive dead ones.

	   Soften And Heal	Also in the original code, any ability flagged to both lift a status and
	   -(Bropedio)		cure HP would perform the latter action first, meaning that a petrified
				ally would not regain any HP from such an ability. This has been fixed.

---------------------------------------------------------------------------------------------------------

	SOS Reset		Relics which grant statuses when the wearer reaches critical health now
	---------		"reset" on death of the user instead of only going off once per battle.
	(Bropedio)		This allows them to be reliably triggered whenever a dead character is
				revived with a phoenix down (the Life spell is too powerful to do so).

---------------------------------------------------------------------------------------------------------

	Relic Status Fix	Negative statuses can no be longer immediately cured by equipping relics
	----------------	which block their effects (although they will be removed as soon as the
	 (Seibaby)		party gets into a fight, so this is still pretty much an exploit).

---------------------------------------------------------------------------------------------------------

	Relics Blocks Stop	As part of Brave New World's general focus on stamina as a primary means
	------------------	of avoiding status effects, there's no longer a relic that blocks all of
	 (dn/Bropedio)		them. The Ribbon now only guards against "stop", "petrify", and instant
				death (this includes "zombie"), and that first one is most notable since
				the game's code originally did not allow for equipment to block "stop".

	   Sap/Slow Immunity	Similarly, it's also impossible for equipment to offer protection from
	   (-BTB)		the "slow" status, and while it CAN block "Sap", it will also block the
				"Regen" status because whoever coded this nightmare was on crack. With
				this in mind, Brave New World instead offers immunity to these statuses
				by means of equipment that inherently grants their counterparts: "Haste"
				and "Regen", respectively. Enemy design follows suit, with immunity to
				Sap and Slow being nonexistent outside of inherent Regen and Haste.

---------------------------------------------------------------------------------------------------------

	Rflect Timer		The "rflect" status now behaves like the "image" (also known as blink)
	------------		status by having a 1/3 chance of wearing off each time it's activated
	 (Seibaby)		rather than wearing off after a set amount of time. This allows it to
				function more effectively as a defensive status since it won't wear off
				without protecting you at least once or when you least expect it to.

	   Image Nerf		In the original game, image has a 1/4 chance of being broken whenever it
	   -(Synchysi)		blocks a physical attack. As with rflect, those odds are now 1/3.

	   Friendly Fire	Given the severity of the Muddle status, the developers of the original
	   -(Bropedio)		game added a "friendly fire" step in damage calculation that halved all
				damage your party inflicted on itself. Given Brave New World's increased
				focus on status effects, that reduction has been increased to 75%.

---------------------------------------------------------------------------------------------------------

	New Status Display	This is a collection of hacks that greatly improve how the game conveys
	------------------	the presence of status effects on player characters.

	   Color Wheel		In the original game, six different status effects were represented by a
	   -(LeetSketcher/dn)	colored aura glowing on the affected character. The issue is that only a
				single aura could be shown at a time, leading to obvious problems with
				figuring out which characters had which status(es). In Brave New World,
				only the "safe", "shell", and "rflect" statuses are displayed with an
				aura, and those auras now cycle to show more than one of them at once.

	   ATB Stoplight	The "haste", "slow", and "stop" statuses, on the other hand, can now be
	   -(Seibaby)		seen on a character's ATB bar. But rather than maintaining their vanilla
				colors - red for haste seemed somewhat backwards - we instead opted for
				universally-recognized traffic colors: green for haste, yellow for slow,
				and red for stop. There's no need for cycling as with the above since
				none of these statuses can (functionally) coexist.

	   Targeting Panel	When choosing a friendly target for an item or spell in battle, a panel
	   -(dn)		appears to display any status effect present on each character. Similar
				to the problem with auras, only one status could be displayed here at a
				time and the order in which the 25(!) possible results were prioritized
				was questionable at best. This panel now displays ONLY the presence of
				the Rerise and Regen/Sap statuses, and they can be shown concurrently.

---------------------------------------------------------------------------------------------------------

	Scan Improvements	Seeing as the "Scan" spell tells you (almost) nothing that isn't freely
	-----------------	available in the Printme, it is now a "free" action outside of its 1 MP
	(Bropedio/Seibaby)	cost (Bropedio). It also cannot trigger enemy counter-attacks (Seibaby).

	   Status Scan		In the original game, Scan showed enemy HP/MP and elemental weaknesses.
	   -(dn)		Here, it also shows active statuses. And on that subject...

	   Informative Miss	Whenever an attack which sets a negative status - either in addition to
	   -(Bropedio)		dealing damage or not - fails to set that status on its target, it will
				display one of two failure messages:

						"Fail" = status was resisted by stamina
						"Null" = target is immune to the status

				 (NOTE: If the target already had the status, then no message is shown)

---------------------------------------------------------------------------------------------------------

	ATB/HP Toggle		Holding the select button in battle will now display the max HP of your
	-------------		party members in place of the ATB bars. The option to have this display
	 (GrayShadows)		as default has been removed since, as mentioned above, the ATB bar now
				conveys the presence of all speed-based statuses and is thus far more
				important to have on permanent display rather than on-call.

				(As a side effect of this hack, select is no longer remapped to the "R"
				button in battle and thus cannot be used to select multiple targets.)

---------------------------------------------------------------------------------------------------------

	Compact Spell List	The in-battle "magic" menu for each character is now condensed to remove
	------------------	the empty spaces that previously existed due to the nature of how the
	 (GrayShadows)		game's code dynamically generated the lists of known spells.

---------------------------------------------------------------------------------------------------------

	Spell Dots		When any white, black, or grey spell is cast in battle, its colored dot
	----------		will now be properly displayed alongside its name. This is meant as more
	 (dn)			than a mere visual tweak; Brave New World standardizes the "Runic" skill
				to work only on regular magic, and no other enemy skills (aside from the
				ones available as lores) cost MP. Thus, the presence of a colored dot in
				an enemy attack is a clue to the player as to how it can be prevented.

---------------------------------------------------------------------------------------------------------

	HP/MP Text Color	Text coloration in battle will now change to indicate MP damage (red) or
	----------------	healing (blue). A side effect of this patch is that it also alters the
	 (Imzogelmo)		color of the "reflect" shield when attacks are bounced off of it due to
				the fact that the MP healing is piggybacking off of the same palette as
				reflect uses. This also means that the MP healing font is susceptible to
				the same little-known bug as reflect wherein the coloring gets fucked up
				for the duration of any fight in which Crusader is summoned.

---------------------------------------------------------------------------------------------------------

	Original Graphics	Restores the following sprites to their original (uncensored) versions:
	-----------------
	 (Terii Senshi)			• Siren
					• Goddess
					• Chadarnook
					• Critic
					• Barb-E/Madam/Dahling

				(Note that most of these have been renamed)

	   Tritoch GFX Fix	This fixes a minor graphical bug with the Tritoch summon animation that
	   -(Bydoless)		causes the sprite to be missing a small portion of its tail.

---------------------------------------------------------------------------------------------------------

	Menu Improvements	This is a collection of hacks that improve the user interface of the
	-----------------	main menu system in various ways.

	   Clean Status Screen	The character status screen has been completely redesigned to utilize
	   -(Seibaby/Bropedio)	previously blank space and include EL information alongside just regular
				level information. Some attributes have also been renamed for clarity:

					• BatPwr  --> "Attack"
					• Mag.Pwr --> "Magic"
					• Evade % --> "Evade"
					• MBlock% --> "M.Evade"
					• Mag.Def --> "M.Defense"

	   Equip Menu Overhaul	The Equip screen has been redesigned to include relics (eliminating the
	   -(GrayShadows)	need for a separate equip screen for them) and equipment descriptions so
				that you don't need to exit to the inventory screen to view them.

	   Review Screen	Replacing the "Relic" option in the main menu is a shortcut to a little-
	   -(dn/Bropedio)	known feature of the original game which will display an overview of the
				party's loadout (thanks to GrayShadows!). This screen has been edited to
				also show equipped espers since they now function like equipment.

	   Overlay & MP Costs	This removes the small overlay which identifies the skill submenus (i.e.
	   -(dn)		Espers, Spells, Bushido...) because it was unnecessary and it obscured
				the lower-right portion of the information panel above it (the mod makes
				use of this real estate whereas vanilla did not). The only useful piece
				of information that appeared in this overlay was the MP cost of a chosen
				spell; spell costs are now visible by default in the main menu panel.

				(I say "by default" because another little-known feature of the original
				game is that you can press "Y" in the spell menu to toggle MP costs in
				the main panel; what's shown by default is the spell percentage learned,
				which isn't exactly useful/relevant information in Brave New World.)

	   Rage & Dance Moves	Rages now display their primary (2/3) and secondary (1/3) attack in the
	   -(dn)		skill menu while Dances now display all four (7/16, 5/16, 3/16, and 1/6)
				moves. For information about the attacks themselves or the properties of
				enemies (for other effects of their rages), please consult the Printme.

	   Alphabetical Rage	Furthermore, rages are now sorted alphabetically in the rage list rather
	   -(Assassin/dn)	than by their order in the enemy index (Assassin). The rage list in the
				skills submenu is now condensed to display only the first 64 slots (the
				number of rages available in BNW) instead of all 256 (dn).

				(Note: lores have also received the same treatment as the above, but not
				 due to an ASM hack - they've just been re-arranged in the spell index.)

	   Blitz Screen		Blitz names are now displayed in the menu instead of just the inputs.
	   -(LeetSketcher/dn)	(NOTE: all of the inputs are the same as vanilla except for Bum Rush).

	   Unequipium		This fixes a bug wherein characters' max HP/MP values would not update
	   -(LeetSketcher)	after removing equipment that boosts it until they were in active party,
				leading to incorrect values being shown on the party creation screen.

	   Inventory Sorting	Using the "arrange" command in the inventory now sorts item types in a
	   -(BTB)		manner that actually makes some fucking sense:

						NEW ORDER:		OLD ORDER:
						--------------		--------------
						Tool			Dagger
						Throwing Star		Sword
						Ninja Scroll		Spear
						Dagger			Katana
						Sword			Rod
						Spear			Brush
						Claw			Throwing Star
						Katana			"Other" Weapon
						Casino Weapon		Casino Weapon
						Rod			Claw
						Brush			Shield
						"Other" Weapon		Helmet
						Shield			Armor
						Helmet			Tool
						Armor			Ninja Scroll
						Relic			Relic

	   No Inventory Index	This removes the unique item counter from the bottom right of the info
	   -(GrayShadows)	panel in the inventory screen since it serves virtually no purpose in
				Brave New World (collecting 255 items is impossible, and there aren't
				even that many items in BNW to begin with) and was causing text overlap.

---------------------------------------------------------------------------------------------------------

	Shop Preview		Because weapons and armor are now so much more than their primary stats,
	------------		Brave New World removes the arrows which appear in shops comparing their
	 (dn)			wares to what you already have on as well as the display on the purchase
				confirmation screen showing attack power (weapons) or defense (armor).
				Instead, you can now hold "Y" when shopping to view the full stats for
				whatever item you have selected, similar to the "extended" info screen
				you can see by double-clicking any piece of equipment in your inventory
				and then pressing left/right to switch between views.

				  (Special thanks to Ryo_Hazuki for editing this for the translations)

	   No Optimize		Because the "optimize" command only considers raw defense/attack power
				and we just got done establishing why that's a poor measurement of the
				usefulness of equipment, it's no longer an option on the equip menu.

	   Optimize Fix		The only instances in Brave New World where the optimize code is still
	   -(Assassin)		used are when Edgar and Terra are force-equipped when they re-join you
				immediately prior to boss battles, and we utilized an external patch to
				prevent it from doing shit like making Edgar wear a drill as a hat.

					(...or make him wear a suit of Dried Meat. -Bropedio)

				(Also, it no longer ignores the Blood Sword and Soul Sabre. -Seibaby)

---------------------------------------------------------------------------------------------------------

	Rewards Display		The Colosseum menu now displays the prize for any item wagered without
	---------------		having to commit to the wager beforehand.
	 (HatZen08)
				Note that the Colosseum has been completely reworked and standardized to
				make it more obvious/intuitive what items can be wagered to win fabulous
				prizes and what will simply earn you a date with Mr. Chupon. Simply put,
				any item with no resale value is considered rare and can be bet at the
				Colosseum - everything else is not rare and wins you literally nothing.

---------------------------------------------------------------------------------------------------------

	New Window Style	Added a new window style as the default one, with the old default style
	----------------	replacing style 8 (which was used only by assholes and mental patients).
	-(Zeemis)		It's the single most obvious visual change in Brave New World and a good
				quick indicator of what version of Final Fantasy VI someone is playing.

---------------------------------------------------------------------------------------------------------

	B Button Dash		Obsoletes Sprint Shoes by adding a dash button (B). This patch has been
	-------------		modified from the original version by Master ZED to disallow dashing at
	(Master ZED/Synchysi)	the following points in the game where dashing was originally disabled:

					• The opening sequence (MagiTek raid on Narshe)

					• Any other time you're wearing MagiTek armor

					• The "Save Terra" sequence (the moogle battle)

					• The Battle of Narshe

					• Celes's opera solo

					• Daryl's Tomb (the stair/flashback sequence)

				This patch has also been *further* modified to replace the now-useless
				optimize/empty slot in the config menu with the option to make running
				the default speed (where holding B will make you walk at normal speed).

---------------------------------------------------------------------------------------------------------

	Save & Restore		An important evolutionary turning point in the history of console RPGs
	--------------		was when the "random encounter" system that had been ubiquitous in the
	 (Synchysi)		genre since its inception started going the way of the dodo sometime in
				the late 90's - and with good reason. Traditional game design generally
				presented them as little more than annoyances that constantly interrupt
				the flow of the game which were tolerated by sheer virtue of providing
				cash and experience points. And while random trash mobs will always have
				their place as something to hit until you eventually get stronger and/or
				richer, it was always our belief that their true purpose was to serve as
				a means of "wearing the player down" prior to a boss fight, which would
				then be that much more challenging. There was just one tiny problem...

				Given that the ability to save the game at any time is a feature of any
				software required to play this mod in the first place, it was decided to
				actively shift Brave New World's difficulty model away from save denial
				(which, frankly, died out with blast processing and slap bracelets) and
				more toward inventory management with the following changes:

					• Several save points have been added to key areas

					• Some save points are now also "full recovery" points

					• Tents and sleeping bags have been removed from the game

				In short, recovery items are now more important since you can't just pop
				a tent before every boss fight, and random encounters are thus now able
				to serve their function of being a drain on your resources leading up to
				them. This isn't to say that random fights aren't difficult in their own
				right, however - players are just as likely to die at the hands of minor
				foes as they are to major ones. And to that end, the time-honored advice
				advice of "save early and often" holds true because...

	   Game Over, Man!	Death in battle now kicks you back to the menu screen instead of to your
				last save. This was done because, while this would retain all experience
				gained, it would not retain any esper stat boosts (and that's bad).

---------------------------------------------------------------------------------------------------------

	Can't Lose Our Shadow	Shadow won't randomly run off on you anymore at any point during Sabin's
	---------------------	scenario or if you hire him in Kohlingen. He's also kind enough now to
	 (Synchysi)		leave all his shit behind whenever an event forces him out of the party.

	   Zozo Unequip		Speaking of Zozo specifically, the new event that will unequip Shadow as
				he fucks off will also unequip everyone else not in the active party so
				that you don't have to go back to Narshe to get any of your shit back.

	   Arvis Unequip	Further, Arvis is now acts as an "unequip" guy following the Battle of
				Narshe so that you don't have to make a party of your benchwarmers just
				so you can take off all of their gear.

	   Scenario Unequip	Finally, an unequip guy has been added to the scenario select screen so
				that unequipping everyone at the end of each one (or the inability to do
				so in Locke's case) is no longer a consideration in what order to finish
				them in; as their scenario goes directly into combat as it begins, Terra
				and Edgar will be force-optimized to avoid them not having anything on.

	   MP Party Restore	The "choose a party screen" now restores the MP of all characters to max
	   -(Seibaby)		instead of just HP. This was done primarily to act as a full party heal
				prior to the Battle of Narshe, though it's also a good convenience hack.
				Not only does it remove the need to visit an inn after swapping out your
				team, but it also affects picking a character to fight in the Colosseum.

	   Quality Of Life	Many other quality of life changes have been made to various stages of
	   -(Various)		the game, including the Phantom Train, Battle of Narshe, Cyan's Dream,
				Ancient Castle, Ebot's Rock, Fanatics Tower, and more. These edits are
				detailed in the Unlockme archive to which the password will be revealed
				upon completion of the game; for now, I'd like to extend special thanks
				to SirNewtonFig, Madsiur, Gi Nattak, and Deschain for their efforts, as
				well as an EXTRA special thanks to Jackimus for... well, you'll see.

---------------------------------------------------------------------------------------------------------




				    5. BUGS & KNOWN ISSUES




---------------------------------------------------------------------------------------------------------

				EMULATOR-SPECIFIC BUGS
				----------------------

      •	During certain battles, most notably the Cranes, the menu cursor will become difficult to see or
	disappear entirely - this is an issue specific to the (very outdated as of 2020) ZSNES emulator

      •	Also ZSNES: off-screen characters appearing layered over the HUD during in-battle cutscenes

      •	Again ZSNES (noticing a pattern here?): Chadarnook's transition animation is really fucked-up

      •	Using the SNES9x Next (AKA "SNES9x 2010") core with RetroArch may cause the battle interface to
	randomly flash whenever an action is about to take place; fix by switching to standard SNES9x

      •	If playing on a flash cart and you experience screen flickering in the equip menu, you need to
	upgrade your cart's firmware (https://sd2snes.de/blog/compatibility/in-game-hook-compatibility)

	*(NOTE: these bugs are NOT specific to Brave New World and will also appear in vanilla FF6)

---------------------------------------------------------------------------------------------------------

				UNFIXED BUGS FROM VANILLA
				-------------------------

      •	Renaming your characters (especially those with short names like Cyan, Gau, and Mog) can result
	in weird formatting in dialogue boxes; the ones that appear during battle cutscenes are notable
	offenders since they don't wrap normally and can result in text overrunning the dialogue window

      •	Treasure chests containing key items (such as the ones at Ebot's Rock) will close if you go into
	the menu screen and will be empty if you attempt to re-open them

      •	If a character dies while attempting to summon an esper, that esper will be still flagged as
	having been summoned when the appropriate update routine is called

      •	The 255th named ability to be used in a single battle will cause minor graphical errors in the
	text area; although not specific to Brave New World, it is much more likely to be seen here

      •	Foes with the imp status will retain the sprite if cured by anything other than the Imp spell

      •	As mentioned earlier, Crusader will recolor the "rflect" shield for the remainder of the battle

      •	Similar to the above, the "Quasar" attack will screw with the Storm spell animation

      •	You still get a free Buckler and Boomerang when the world ends

---------------------------------------------------------------------------------------------------------

				BRAVE NEW WORLD-SPECIFIC BUGS
				-----------------------------

      •	The new "shop preview" feature can cause lag and will return wrong/null values for Tools

      •	The rich man's house at South Figaro randomly "sticks" your character in place after stepping on
	certain event tiles, locking the d-pad until any of the face buttons (A/B/Y/X) are pressed

      •	The animation for thrown shuriken is always shown to target a single enemy regardless of whether
	or not it was "split" to target a group of foes

      •	When the Quartrstaff multi-targets its spell proc on an MP-fueled auto-crit, it will target ALL
	enemies - including ones who are already dead - due to the way that the targeting is hard-coded

      •	The "bserk" status is cleared by the "zombie" status and can't be re-applied if the character is
	getting bserk inherently from the Hyper Wrist (technically, this is a vanilla bug, but the only
	thing that originally set auto-bserk was the Cursed Shield)

      •	The death animations for some enemies under certain circumstances will play out individually
	instead of simultaneously if more than one of them are killed by the same attack

      •	If the first battle with Ultros ends while Edgar in the air (Jump is available much earlier in
	Brave New World than in vanilla), the following cutscene will play out without him

      •	This little gem: https://www.youtube.com/watch?v=4BaY8C_4TJM

---------------------------------------------------------------------------------------------------------




				    6. VERSION HISTORY




---------------------------------------------------------------------------------------------------------

	Version 2.1.0 (February 22, 2022)

 • The ATB bar now decrements to show the delay between command input and execution (-Bropedio)

 • Esper summon effects are now shown in the EL/spell acquisition submenu (-SirNewtonFig)

 • Wagers are no longer lost at the Colosseum if you lose the battle (-Bropedio)

 • Defending now doubles a character's chances to cover healthy allies (-Seibaby)

 • Celes now remains in her "Defend" stance as long as Runic is active (-Bropedio)

 • The "Blind" status now affects your chance to successfully steal (-Bropedio)

 • Increased the damage reduction for "friendly fire" from 50% to 75% (-Bropedio)

 • Enemies can no longer counter-attack counter-attacks (-Bropedio)

 • Enemies who counter X-Magic now do so after the first spell rather than the second (-Bropedio)

 • Elemental attacks which are nulled or absorbed no longer attempt to set statuses (-Bropedio)

 • Golem no longer blocks non-damaging attacks or inherits resistances from its protectee (-Bropedio)

 • Abilities which cure HP and remove statuses now work properly on petrified characters (-Bropedio)

 • Fixed the exploit where status-prevention relics would cure negative statuses (-Seibaby)

 • Fixed a rare bug where MP would fail to update correctly in the battle spell menu (-SirNewtonFig)

 • Subsequent EL resets are now properly denied if the player lacks sufficient funds (-Synchysi)

 • Cyan's starting vigor is now correctly set to 42 (instead of 43)

 • The Scan spell now displays HP and MP values for non-boss enemies (-Bropedio)

 • Changed the palette of the Storm spell to better indicate that it's both wind and water elemental

 • Fractional damage attacks will now do minor damage to bosses rather than missing (-Bropedio)

 • Swapped the immunity to Blind on Siren with the immunity to Bserk on Stray

 • The "Stop" effect on Suplex and the "Muddle" effect on Flurry now check enemy stamina for evasion

 • The "7-7-7" Slots spin now heals just as much HP as a losing spin instead of slightly less

 • Bad Breath no longer incorrectly sets Sap

 • Plasma is now just water damage (was water/bolt)

 • Toxic Frog is now water/dark elemental (was just dark)

 • The Water Rondo dance is no longer permanently missable (-SirNewtonFig)

 • Raised the attack of the Rune Blade to 150 (from 140)

 • Attack is no longer capped at 255 (-Bropedio); this mostly affects the Excalibur (now 225 attack)

 • The Kunai and Ninjato now correctly possess the "anti-air" property

 • The Tarot is now properly flagged as Holy elemental

 • The Punisher now correctly grants the critical damage bonus to the Dark spell

 • The Cursed Shield now correctly sets Sap instead of Condemned

 • The Multiguard now blocks rather than absorbs Fire/Ice/Bolt

 • The White Cape now blocks Stop instead of Bserk (and in addition to Imp/Mute)

 • Renamed the Storm Belt (now Psycho Belt) to something more indicative of its true function

 • The Megalixir now removes all negative statuses in addition to restoring all HP/MP

 • Undead enemies are no longer inherently immune to Stop

 • Rewrote the "ATB tutorial" gimmick back into Whelk's script

 • Crawlers no longer use Magnitude on low-level parties

 • The South Figaro basement is no longer accessible prior to Locke's scenario

 • Adjusted the timer in Phantom's script (should prevent "cheap" RNG deaths)

 • Death by sap/poison/counter-attack no longer prevents the dying attack of "Giant" enemies (-Bropedio)

 • Fixed a error in Dadaluma's script when attempting to target invisible characters

 • Slightly rewrote 024's script to further reinforce the battle's intended mechanic

 • Changed the behavior of the Cyborg/Robot/Android enemy group when hit with bolt damage

 • The "Tek Armor" enemy group should no longer be able to set barrier on other enemies

 • Lowered the magic defense of the Wight/Wraith/Revenant enemy group

 • Kudzu and Locusts can now be encountered in the WoR so that their rages are no longer missable

 • The "Ninja" enemy group can no longer re-vanish as a counter to having the status cleared

 • Behemoths and Diablos are now correctly immune to Sleep and are slightly less spammy with Meteo

 • Slightly adjusted Atma's script to further reinforce the battle's intended mechanic

 • Fixed a bug in the Tentacle battle where characters seized at full ATB would freeze when discarded

 • Tentacles C and D now have the correct defense and magic defense, respectively

 • Fixed a bug where Chesticle's shell was using incorrect or no attacks

 • Removed inherent regen (which damages the undead) from Belladonna and Nightshade

 • Parasoul is no longer incorrectly immune to Stop

 • The Hoodwink and Windrunner enemies no longer always open with Blight

 • Curly now heals Larry and Moe more frequently

 • The merchant in Cyan's Nightmare now has better merchandise

 • Wrexsoul now correctly drops Force Armor instead of Genji Armor

 • Removed the new Ebot's Rock save point as it was no longer needed

 • The Hidonites are now properly flagged as undead

 • Fixed a targeting error in Hidon's script and made it less likely to miss learning Shield

 • Changed the Sketch results for Hidon and Guardian to something more (potentially) useful

 • Changed the overworld sprites of the elemental dragons to more correctly match their color

 • The White and Green Dragons now lose the sap status when healing themselves instead of gaining regen

 • A certain boss is no longer mandatory once triggered (-Synchysi) and now better telegraphs its moves

 • Fixed an oversight in Asura's script which allowed her to potentially use N.Cross twice in a row

 • Reduced the overall damage output of the "Face" component in the first phase of the final battle

 • Fixed an error in Kefka's script that was causing Meteor to be cast more frequently than intended

 • Fixed several other minor bugs

	--> Fixed two minor visual bugs relating to cover (-Bropedio)
	--> The save point in the Ancient Castle is now the correct color
	--> The Lich and Kudzu rages are now listed in correct (alphabetical) order
	--> The Mute status no longer prevents Gau/Gogo from using Aqualung with the Chimera rage
	--> The 5x Chickenlip and 5x Anemone formations are now leapable and will appear on the Veldt
	--> Fixed minor visual glitches with two enemy formations (Tyrano/Troll and L1/L2 Mage)
	--> Set the correct enemy to be fought for betting a Life Bell at the Colosseum
	--> Set the correct battle entrance animation for Zone Eater and Land Worms
	--> Spellcasting animations should no longer persist through death
	--> Corrected the menu description for Raze to include the wind element
	--> Corrected the description for a certain key item to include its second effect
	--> Corrected the value of a certain hidden rare item (0 -> 2)
	--> Corrected the description of Lifeshaver in the (Unlockme) Printme

 • Clarified several pieces of advice (including the post-Zozo cutscene) and some weapon descriptions

 • Improved several minor bits of dialogue (special thanks to Field)

 • Renamed a certain minor character (special thanks to Bauglir)

 • Added a textless patch to the Unlockme (-SirNewtonFig) and an Italian translation (-Gens/Ryo_Hazuki)

 • Added an optional multitap patch to support up to 4 players (-SirNewtonFig)

 • Made a small improvement to the New Game Plus patch (-Bropedio)

 • Fixed some minor errors/typos in the BNWCP and Printme

 • Added a deleted scene to the Unlockme.txt file

---------------------------------------------------------------------------------------------------------

	Older Versions

 • Release notes for older versions are located at: http://btb2.free.fr/mods/ff6/history.txt

---------------------------------------------------------------------------------------------------------




				    7. CREDITS & CLOSING




---------------------------------------------------------------------------------------------------------

First of all, I would like to thank the Brave New World community as a whole. When our humble hack was
initially released, it was welcomed with open arms by the wonderful people of a modding community that
was then known as Insane Difficulty. It's since grown - and thrived - far beyond what I could have ever
imagined, and all of you are the reason why. Synchysi and I may have been the ones to breathe life into
Brave New World, but it would not exist as it is today without you.

A major turning point for Brave New World was when we were approached by Think regarding a revamped ATB
system that he had designed; up until then it was just Synchysi and I doing all of the work ourselves.
This opened up the floodgates for many talented hackers to join our cause, several of which would become
my right hand (including Think himself) at some point during Brave New World's decade-long lifespan: DN,
Seibaby, GrayShadows, Bropedio, and SirNewtonFig. Bropedio in particular quickly found himself taking on
the role of lead coder alongside Synchysi and has since become a core member of our team.

Of great importance to Brave New World's development is what has affectionately become known as the Bad
Idea Brigade: our most active community members and playtesters whose feedback - which more often than
not consists of deliberately terrible suggestions - spurs the creation of better ones. Unofficially, the
BIB was conceived when Think teamed up with ThzFunnyMzn and Nakar to create the first of what would be
several spinoff mods for Brave New World featuring several hacks and ideas that they wanted to see make
it into Brave New World proper (several of which did). Today, the ranks of the Bad Idea Brigade are far
too numerous to list here lest I suffer the shame of forgetting someone, but I would like to give thanks
to ThzFunnyMzn in particular for being easily the most tenacious of them all.

I would also like to thank Nowea and Mishrak specifically for more love and support than I can possibly
begin to describe. Moreso than just the two people who aren't named BTB, Synchysi, or Bropedio who have
invested more time and effort into this project than anyone else, you've both grown to be dear friends.
Beyond that, a list of all the close relationships I've since formed within the wonderful community that
I now call home would be immeasurable and, again, I dare not attempt it for fear of leaving someone out.

One thing our community is definitely not wanting for is insane challenge gamers with way too much spare
time on their hands. When we were first developing Brave New World, I scoffed at the mere notion that it
would be possible to LLG (low-level game) since it was no longer the gimmie that the original game was.
That feat has since been accomplished by no fewer than four players: Lockirby, Rynzer, KainStrider, and
DanDaCheerman, the latter of which, not content with doing merely one gimmick run of the game, has done
every gimmick run conceivable - and a few that were inconceivable. It's people like him that continue to
find new ways to experience Brave New World who keep our community alive and interesting.

Ultimately, however, the biggest part of what's helped shape Brave New World into what it is today isn't
the people who are closest to it, but its player base at large. In particular, I'm always happy to see -
and join - players who livestream it. I take something away from every player that I watch, and the vast
majority of Brave New World's quality of life improvements came about as a direct result of seeing them.
The same can also be said of many of the most prominent members of our community, who all started out as
just somebody I saw streaming Brave New World and then invited to come join us.

And finally, thanks to everyone else...

	• The original authors of many patches/hacks/other works that Brave New World includes:

		ArmorVil		Assassin17		Bropedio
		Bydoless		DN			Gi Nattak
		GrayShadows		HatZen08		Imzogelmo
		Jackimus		LeetSketcher		Madsiur
		Master ZED		Poco Loco		Seibaby
		Terii Senshi		Think			Zeemis

	• The authors of Synchysi's cipher for this game's tangled mess of spaghetti code:

		Assassin17		Dragonsbretheren	Imzogelmo
		Lenophis		Novalia Spirit		Terii Senshi

	• The creator(s) of Zone Doctor, a map editor used by both Synchysi and myself:

		Geiger			Giangurgolo		Imzogelmo
		Lenophis		Lord J			Novalia Spirit
		Sleepydude		Yousei			---

	• The creator(s) of FF3USME, the editor that I (BTB) primarily used:

		Lord J			Aquillion		Assassin
		Cless			Dennis Ouk		Drakkhen
		Imzogelmo		JCE3000GT		Lenophis
		Master ZED		Novalia Spirit		Pat Buns
		Poco Loco		Sleepy Sheepy		Supernova
		Terii Senshi		The Constable		The Famous Sheep
		Yousei			Warrax			Zeemis

	• Umaro, Gens, & Ryo_Hazuki for the Spanish and Italian translations

	• Deschain and 4bear for the PDF version of the Readme and the "Fan" translation

	• Bauglir for the alternate/bonus Dadaluma and Kaiser sprites (and Madsiur for the patches)

	• (A)Dummy, with extra thanks to Letha, Kain, Lols, and Cainen for providing screenshots

	• Terii Senshi, whose algorithms FAQ has been an invaluable resource for our project

	• Lina Darkstar, whose translation efforts were the basis for many of our own script edits

	• Madsiur and everyone else of the FF6Hacking community for their continued love and support

	• And lastly, my girlfriends and Synchysi's wife for putting up with our shit

---------------------------------------------------------------------------------------------------------

		...looking for the guys responsible for this mess?

			btb@abusemynipples.biz	(BTB)
			synchysi@yahoo.com	(Synchysi)

	Please feel free to contact us with your questions, feedback, comments, concerns, observations,
	complaints, insults, ridicule, screeds, japes, thrusts, death threats, and marriage proposals.

		Or better yet, visit our discussion forums...

			http://www.ngplus.net/index.php?/forums/forum/3-mods/

			...or join us on Discord:

			https://discordapp.com/invite/bsuKp5A

		Is liking things on Facebook your bag, baby? If so, then visit us at:

			http://www.facebook.com/FF6BNW/

	How would you like to own Brave New World on an actual SNES cartridge? Our friends over at Retro
	Circuits specialize in high-quality reproduction carts of both original games and fan-made hacks
	such as ours at competitive prices. I really suck at sales pitches, so here's a link:

		http://www.retrocircuits.com/product/final-fantasy-6-brave-new-world/

	...and how about a legit box to put that fancy cartridge in? A very special thanks to Shane at
	RetroGameCases.com for the design and Daniel at BoxMyGames for the AMAZING final product:

		https://www.boxmygames.com/product/final-fantasy-vi-a-brave-new-world/

---------------------------------------------------------------------------------------------------------

	I'm afraid that's all we know, gentlemen.
