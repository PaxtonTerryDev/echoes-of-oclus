# Player Progression

## Overview

In general, player (player character, more specifically) progression is determined by the following areas:

1. `Attributes`
2. `Stats`
3. `Skills` 
4. `Traits`
5. `Talents`

## Note
In designing the system, we want to avoid coupling things together too much.  Each should be able to exist on their own -> this is so we can quickly iterate on gameplay and implementation ideas without requiring a lot of cross-system refactors.  In general, this means the following

#### Isolated Systems with Defined API's
Each system should not have dependencies on other systems.  To accomplish this, for each system we need to define clear api's for the entrance and exit points.  

When systems are required to interface with one another, we should be defining separate structures that manage the relationships between the two.  This adds more code, but gives us the ability to modify individual modules freely, as well as modify the relationships between systems without affecting the source code.  

Functionally, these interaction structures will function like middleware -> when an object requests data from any of the structures, it will pass through several layers, where the payload can be modified.

##### A Quick Example
The level up system needs to know how much an attribute will cost to improve.  Instead of coding into the Attribute 

```
if Player.traits.has_trait("burly") and Player.skills.has_skill("two_handed_axe"):
 return 10
```

doing this approach hard couples several of the systems together. Instead, we define an access layer that gets the base cost from the attribute system and defines hooks that different middleware systems can tie into to modify the payload before it is returned to the level up system. 
## Attributes
Attributes are freely defined by the player -> when they create their character, and as they level up.  Attributes are comprised of the following types: 

1. Strength - How strong the character is
2. Agility - How fast / flexible the character is
3. Intelligence - The character's ability to comprehend things
4. Willpower - The mental strength of the character
5. Fortitude - How healthy the character is
6. Charisma - How persuasive the character is

Upon leveling up, players receive points they can allocate to their character, which drives the rest of the system.  Depending on how the player plays the game, certain attributes may become easier or harder to level up. For example, talking to a lot of npcs makes the Charisma attribute easier to level.

## Stats
Stats are derived from the player's attributes - at least one or more. 

### Distribution Strategy
When more than one attribute is derived, we assign a weight to the particular attribute.  The attribute is then assigned a weighted average between all of the derived stats.

### Scaling Curves
Additionally, each Stat's derived relationship is assigned a curve value that shows the scaling value.  For example, increasing the character's fortitude will provide large improvements to the character's health at first, but start to plateau out as the Fortitude attribute increases. 

## Skills
Skills emerge as the player's stats improve.  Skills are special "abilities" that the player can be trained in by npcs.  Once they pay (either in money or barter), and are taught, they are able to perform the skill.    

Skills always have stat requirements, either min or max -> IE, certain spells may require a higher intelligence level, but require a lower strength level.  Some skills will also require the presence of certain traits, which are discussed next.

## Traits
Traits are another emergent property -> think of them like "characteristics" of the player's character.  Functionally, traits effect all other progression categories - 

- Attributes
	- Can make attributes cost more or less
	- Provide bonuses based on attribute levels
- Stats
	- Change scaling levels positively or negatively in relation to attributes
- Skills
	- Provide access to unique skills
	- Restrict access to other skills

Traits are awarded based on actions the player takes throughout their play through. A few traits are available to be chosen when the player is creating their character, but most are given by the player playing a certain way.  For example, the player engaging in trade with merchants can award the "quick-talker" trait, which improves intelligence and charisma scaling, and gives access to the "low-ball" skill.  It may, however, reduce strength scaling, or reduce the player's reputation.  We should strive to make the traits reasonable in the world setting, and not arbitrarily assign buffs / debuffs just to scale it.  

Traits can be assigned or removed ad hoc, depending on the game state. In one town, you may have the "village-hero" trait, which improves your charisma greatly, and gives access to the "demand tribute" skill. But you might only be the village hero in one village -> other villages don't care about you at all. You lose this trait upon leaving, and regain it when entering the town. 

## Talents
An idea, mainly.  Talents are basically fixed 'traits' that are assigned at player creation and cannot be changed.  They may be able to be discovered later on through various actions. 

This needs some fleshing out before implementation