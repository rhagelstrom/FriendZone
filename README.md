
# Pets

[![Build FG Extension](https://github.com/rhagelstrom/Pets/actions/workflows/create-release.yml/badge.svg)](https://github.com/rhagelstrom/Pets/actions/workflows/create-release.yml) [![Luacheckrc](https://github.com/rhagelstrom/Pets/actions/workflows/luacheck.yml/badge.svg)](https://github.com/rhagelstrom/Pets/actions/workflows/luacheck.yml) [![Markdownlint](https://github.com/rhagelstrom/Pets/actions/workflows/markdownlint.yml/badge.svg)](https://github.com/rhagelstrom/Pets/actions/workflows/markdownlint.yml)

**Current Version:** ~dev_version~ \
**Updated:** ~date~

Adds support for companions of any sort

## Features

* NPC's can be given to players as Pets to control
* Support for pets that scale in power with their caregiver, such as Primal Companions from Tasha's Cauldron of Everything or MCDM's Monstrous Companions.

## Order of Adding Pet to Character Sheet

To add a pet to a character sheet the DM must add the pet in the following order

* Drag NPC to the players 'pets' tab
* Drag the NPC link from the players 'pets' tab to the Combat Tracker
* Drag the token from the CT and place on map.

## Primal Companion

* Primal Companion NPC from TCoE (e.g. Beast of the Land) on to the Ranger's Cohorts tab and add to the CT. All statistics that are influenced by the player will now automatically parse and evaluate accordingly.
* A trait can be added to any NPC with the following text to act as a Primal Companion. "You can add your proficiency bonus to any ability check or saving throw that the beast makes."

## Homebrew

The following is how to adjust individual fields to auto scale with the caregiver proficiency bonus.

* Armor Class: + PB (natural armor)
* Damage: On hit: 1d6 +PB slashing Damage
* Saving Throws: Str +3 (+ PB)
* Skills: Perception: +4 (+ PB)

### Notes Tab


* Drag NPC to the players 'pets' tab
* Drag the NPC link from the players 'pets' tab to the Combat Tracker
* Drag the token from the CT and place on map.

## Primal Companion

* Primal Companion NPC from TCoE (e.g. Beast of the Land) on to the Ranger's Pets tab and add to the CT. All statistics that are influenced by the player will now automatically parse and evaluate accordingly.
* A trait can be added to any NPC with the following text to act as a Primal Companion. "You can add your proficiency bonus to any ability check or saving throw that the beast makes."

## Homebrew

The following is how to adjust individual Pet (NPC) fields to auto scale with the Parent's proficiency bonus.

* Armor Class: + PB (natural armor)
* Damage: On hit: 1d6 +PB slashing Damage
* Saving Throws: Str +3 (+ PB)
* Skills: Perception: +4 (+ PB)

## Power Parsing

| Text | Description | Example |
| ---| --- | --- |
| DC Players [Ability] | Replaces 'Players' with the Parent [Ability] score | If the beast moves at least 20 feet straight toward a target and then hits it with a maul attack on the same turn, the target takes an extra 1d6 slashing damage. If the target is a creature, it must succeed on a DC Players Strength saving throw or be knocked prone.|
| extra PB [DamageType] damage | Add the effect to the Pet which is DMG: (Parent proficiency bonus) [DamageType] | Ranged Weapon Attack: your spell attack modifier to hit, range 30 ft., one target you can see. Hit: 1d4 + PB force damage takes an extra PB force damage.|
| takes PB [DamageType] damage | Damages the target for (Parent proficiency bonus) [DamageType] | |
| your spell attack modifier | Adds Parent spell attack modifier to the roll | Melee Spell Attack: your spell attack modifier to hit, reach 5 ft., one creature. Hit: 1d8 + 3 + the spell's level psychic damage. |
| your [PowerGroup] attack modifier | Adds Parent [PowerGroup] attack modifier to the roll | Melee Spell Attack: your eldrich invocation attack modifier to hit, reach 5 ft., one creature. Hit: 1d8 + 3 + the spell's level psychic damage. |
| [deals,gains,takes] (N) times PB | Adds Parent proficiency bonus multiplied by (N) |the target must succeed on a DC 18 Constitution saving throw against this magic or takes 5 times PB slashing damage|
|+(N) + PB | Adds Parent proficiency bonus| Hit: 1d4 +2 + PB slashing damage|
|(D) + PB | Adds Parent proficiency bonus| Hit: 1d4 + PB slashing damage|
|PB(D)| Multiply (D) by Parent proficiency bonus| Hit: PBd4 slashing damage|
|equal to (N) times the [class] level | Damage is equal to (N) multiplied by the Parents class level| the target must succeed on a DC 18 Constitution saving throw against this magic or equal to 5 times the Wizard level slashing damage and |

* **(D)** = Dice and numbers supported for value attribute
* **(N)** = Only numbers supported for value attribute
* **[Ability]** = Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma
* **[DamageType]** = acid, cold, fire, force, lightning, necrotic, poison, psychic, radiant, thunder, adamantine, bludgeoning, cold-forged iron, magic, piercing, silver, slashing
* **[PowerGroup]** = Group name of the associated power on the Parent character sheet.
* **[class]** = any defined RAW class or homebrew class

### Notes Tab

The following text formats can be added to the notes tab to provide automation

* **Armor Class** - Add "+PB" before the parenthesis.
* **Hit Points** - Already works so long as the creature is added to the pets list first then the combat tracker if Life Ledger extension is also present.
* **Hit Dice** - Work the same as HP if the Life Ledger extension is also present.
* **Saving Throws** - Add "(+PB)" after the number for each one.
* **Bite Attack** - Change "plus PB" to "+PB" for both the attack and damage text to automate.
* **Breath Weapon** - change "DC (spell save)" to "DC Players".

## Attribution

Based on **Friend Zone** by MeAndUnique.

Icon based on [Bear Head](https://game-icons.net/1x1/delapouite/bear-head.html) by Delapouite, modified by rhagelstrom with permission ([CC 3.0](https://creativecommons.org/licenses/by/3.0/)).

SmiteWorks retains rights to code sections copied from their rulesets, used with permission for Fantasy Grounds community development.
**'Fantasy Grounds'** is a trademark of SmiteWorks USA, LLC.
**'Fantasy Grounds'** is Copyright 2004-2024 SmiteWorks USA LLC.
