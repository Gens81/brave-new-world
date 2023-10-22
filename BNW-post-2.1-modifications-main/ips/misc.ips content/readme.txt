[n]blush_disease (Novalia Spirit).ips

Fixes a bug that in vanilla makes Edgar and/or Sabin blush together with Celes after Setzer's proposal (due to shared palette)

[n]bridge_correction (Gi Nattak).ips

This obscure patch corrects two small, rather hard to notice graphical issues with the Sealed Gate battle background

[n]cafe_to_pub.ips (Gens)

Uncensor patch that changes all the "Cafe" signs restoring the "Pub" signs used in the japanese version.

[n]castle_party (Leet Sketcher).ips

During the scene where Sabin infiltrates the Imperial Camp near Doma Castle, the game repeatedly switches back and forth between him in the camp and Cyan in Doma. As the game switches back from Cyan to Sabin, sometimes the game changes the order of the members of Sabin's party. This is especially poignant if Shadow is in Sabin's party. This patch ensures that the order of all members in both parties is always maintained.

[n]drained_pool_tile (Gi Nattak).ips

Corrects a map tile after the pool of water is drained from the Serpent Trench cave and the menu is opened & closed.

[n]eddie_bg (Gens).ips

This is my masterpiece: Eddie face appears in all its splendor into the Final Kefka battle background

[n]figaro_guard_fix (DrakeyC).ips

This patch corrects an oversight with four guards in Figaro Castle - the two guards by the doors to the wings of the castle, and the two guards by the doors to the throne room.
In the event for Sabin’s flashback to when he left the castle, an event bit is cleared to remove these guards for the scene where he and Edgar are outside the castle, but this bit is never re-set. So, if Sabin’s flashback is viewed at any time, all four of these guards vanish and never reappear.
This patch adds a small jump to the end of the flashback to reset the event bit and cause the guards to reappear.

[n]more_walkable_beach (Fëanor).ips
This patch makes walkable more beach tiles in solitary island so that grabbing fishes for Cid is now much easier and fast

[n]solar_wind (Leet Sketcher).ips

W Wind and Spiraler both show a tornado as part of their animations. The Lore Quasar has a glitch wherein if you cast it before using either W Wind or Spiraler, the tornado will be messed up and come out looking like a wavy stripe pattern. This patch fixes that glitch.
(the bug was present in bnw as well even if triggered differently)

[n]tube_job (Gi Nattak).ips

The large glass tubes inside the Magitek Factory Laboratory have an issue with two of the background layer 3 tiles, an incorrect palette of $00 being assigned instead of $0C like the rest of the tube's tiles. Palette $00 is reserved for the font color, so whatever color the font is set to, two tiles at the top-right and top-left of the tube would show this same color.

[n]train_chests (Dark Mage).ips

This patch makes the 2 invisible chest in the soul train visible. I altered the original patch to edit the content of the previously unreachable chest. It includes 1000 GP per BTB decision.
