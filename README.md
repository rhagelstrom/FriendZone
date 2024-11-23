
# Pets

[![Build FG Extension](https://github.com/rhagelstrom/Pets/actions/workflows/create-release.yml/badge.svg)](https://github.com/rhagelstrom/Pets/actions/workflows/create-release.yml) [![Luacheckrc](https://github.com/rhagelstrom/Pets/actions/workflows/luacheck.yml/badge.svg)](https://github.com/rhagelstrom/Pets/actions/workflows/luacheck.yml) [![Markdownlint](https://github.com/rhagelstrom/Pets/actions/workflows/markdownlint.yml/badge.svg)](https://github.com/rhagelstrom/Pets/actions/workflows/markdownlint.yml)

**Current Version:** ~dev_version~ \
**Updated:** ~date~

This extension adds support for managing companions, or "pets," in Fantasy Grounds. It allows NPCs to be controlled by players as pets and scales their power based on the player's attributes.

---

## Features

* Assign NPCs as controllable pets for players.
* Support for pets that scale in power with the player's proficiency bonus (PB), such as **Primal Companions** from *Tasha's Cauldron of Everything* or **Monstrous Companions** from MCDM.

---

## Order of Adding Pet to Character Sheet

To add a pet to a character sheet, follow these steps:

1. **Drag the NPC** to the player's **Pets** tab.
2. **Drag the NPC link** from the Pets tab to the **Combat Tracker (CT)**.
3. **Drag the token** from the CT and place it on the map.

---

## Primal Companion

Primal Companion NPCs (e.g., **Beast of the Land** from *Tasha’s Cauldron of Everything*) can be added to a Ranger's **Pets** tab and included in the Combat Tracker. Any statistics influenced by the player's attributes will automatically update.

* **Example Trait for Primal Companion**:
  * "You can add your proficiency bonus (PB) to any ability check or saving throw that the beast makes."

---

## Homebrew Scaling

You can adjust homebrew NPCs to automatically scale with the parent’s proficiency bonus (PB). Here’s how:

* **Armor Class**: Add `+ PB` to the natural armor value.
* **Damage**: On hit, add `1d6 + PB` slashing damage.
* **Saving Throws**: Use the formula `Str +3 (+ PB)`.
* **Skills**: Perception = `+4 (+ PB)`.

---

## Power Parsing

| Text | Description | Example |
| ---| --- | --- |
| `DC Players [Ability]` | Replaces `Players` with the parent [Ability] score. | If the beast moves at least 20 feet straight toward a target and then hits it with a maul attack on the same turn, the target takes an extra 1d6 slashing damage. If the target is a creature, it must succeed on a DC Players Strength saving throw or be knocked prone. |
| `extra PB [DamageType]` damage | Adds extra PB damage of the specified type.  [DamageType] | Ranged Weapon Attack: your spell attack modifier to hit, range 30 ft., one target you can see. Hit: 1d4 + PB force damage takes an extra PB force damage. |
| `takes PB [DamageType] damage` | Deals PB damage of the specified type to the target. | the target must succeed on a DC 18 Constitution saving throw against this magic or takes PB slashing damage |
| `your spell attack modifier` | Adds the parent spell attack modifier to the roll. | Melee Spell Attack: your spell attack modifier to hit, reach 5 ft., one creature. Hit: 1d8 + 3 + the spell's level psychic damage. |
| `your [PowerGroup] attack modifier` | Adds the parent [PowerGroup] attack modifier to the roll. | Melee Spell Attack: your eldrich invocation attack modifier to hit, reach 5 ft., one creature. Hit: 1d8 + 3 + the spell's level psychic damage. |
| `[deals,gains,takes] (N) times PB` | Multiplies PB by (N). |the target must succeed on a DC 18 Constitution saving throw against this magic or takes 5 times PB slashing damage |
| `+(N) + PB` | Adds PB to the given value. | Hit: 1d4 +2 + PB slashing damage |
| `(D) + PB` | Adds PB to the dice roll value. | Hit: 1d4 + PB slashing damage |
| `PB(D)` | Multiplies the dice value by PB. | Hit: PBd4 slashing damage |
| `equal to (N) times the [class] level` | Multiplies the class level by (N). | the target must succeed on a DC 18 Constitution saving throw against this magic or equal to 5 times the Wizard level slashing damage and |

* **(D)** = Dice (e.g., `d6`, `d8`).
* **(N)** = Numeric values.
* **[Ability]** = Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma
* **[DamageType]** = acid, cold, fire, force, lightning, necrotic, poison, psychic, radiant, thunder, adamantine, bludgeoning, cold-forged iron, magic, piercing, silver, slashing
* **[PowerGroup]** = Group name of the associated power on the Parent character sheet.
* **[class]** = RAW class or homebrew class (e.g., Wizard, Fighter).

---

### Notes Tab Automation

For automation to work properly, include the following in the NPC's Notes tab:

* **Armor Class**: Add `+PB` before any parenthesis.
* **Hit Points**: Will automatically adjust if the creature is added to the pets list and Combat Tracker, and if the **Life Ledger** extension is active.
* **Hit Dice**: Works the same way as HP when **Life Ledger** is enabled.
* **Saving Throws**: Add `( +PB )` after the number for each saving throw.
* **Bite Attack**: Change "plus PB" to `+PB` in both the attack and damage text.
* **Breath Weapon**: Replace "DC (spell save)" with `DC Players`.

---

## Attribution

Based on **Friend Zone** by MeAndUnique.

Icon based on [Bear Head](https://game-icons.net/1x1/delapouite/bear-head.html) by Delapouite, modified by rhagelstrom with permission ([CC 3.0](https://creativecommons.org/licenses/by/3.0/)).

SmiteWorks retains rights to code sections copied from their rulesets, used with permission for Fantasy Grounds community development.

**'Fantasy Grounds'** is a trademark of SmiteWorks USA, LLC.
Copyright 2004-2024 SmiteWorks USA LLC.
