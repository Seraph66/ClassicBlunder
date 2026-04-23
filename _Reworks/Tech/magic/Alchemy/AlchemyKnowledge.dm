// First we need to know what 'Alchemy' as a system needs
// This shit also just needs to be cheaper fuck you mean a 1 int race has to pay fucking 30 on some of this shit

/knowledgePaths/magic/alchemy   

// I have to integrate this somehow to make sure it increases magic level (does magic level even matter? idfk)
/knowledgePaths/magic/alchemy/Basic_Alchemy //I hate it too but for the sake of preserving things
    name = "Basic Alchemy"
    breakthrough = TRUE
    description = "The Essence of all Alchemy, allows you to make a cauldron, unlocks 5 herbs you can learn."
    requires = list()

/knowledgePaths/magic/alchemy/Refreshment_Herbs // Buff or Remove this
    name = "Refreshment Herbs"
    description = "Refreshment Herbs restore energy when used in a potion."
    requires = list("Basic Alchemy")
/knowledgePaths/magic/alchemy/Healing_Herbs // Buff or remove this
    name = "Healing Herbs"
    description = "Healing herbs restore health when used in a potion."
    requires = list("Basic Alchemy")
/knowledgePaths/magic/alchemy/Magic_Herbs // Buff or remove this
    name = "Magic Herbs"
    description = "Magic herbs restore mana when used in a potion."
    requires = list("Basic Alchemy")
/knowledgePaths/magic/alchemy/Toxic_Herbs //I like this mechanic but needs a balance lookover first.
    name = "Toxic Herbs"
    description = "Toxic herbs deal damage to yourself when used in a potion, but reduce the potion cooldown by half."
    requires = list("Basic Alchemy")
/knowledgePaths/magic/alchemy/Philter_Herbs // Remove or rename this due to the IMPLICATION
    name = "Philter Herbs"
    description = "This makes it so you deal less damage against the person who made the potion? (I think?)... Weirdo."
    requires = list("Basic Alchemy")
/knowledgePaths/magic/alchemy/Improved_Alchemy
    name = "Improved Alchemy"
    breakthrough = TRUE
    description = "Advanced botanical and chemical knowledge allow you to learn 4 new herbs, as well as distillation."
    requires = list("Basic Alchemy")
/knowledgePaths/magic/alchemy/Stimulant_Herbs
    name = "Stimulant Herbs"
    description = "Stimulant herbs give the PureDamage passive when used in potions."
    requires = list("Improved Alchemy")
/knowledgePaths/magic/alchemy/Relaxant_Herbs
    name = "Relaxant Herbs"
    description = "Relaxant herbs give the Flow passive when used in potions."
    requires = list("Improved Alchemy")
/knowledgePaths/magic/alchemy/Numbing_Herbs
    name = "Numbing Herbs"
    description = "Numbing herbs give the Hardening passive when used in potions."
    requires = list("Improved Alchemy")
/knowledgePaths/magic/alchemy/Distillation_Process
    name = "Distillation Process"
    description = "No fucking clue rn lol, will update when I figure it out."
    requires = list("Improved Alchemy")
/knowledgePaths/magic/alchemy/Mutagenic_Herbs
    name = "Mutagenic Herbs"
    description = "Mutagenic Herbs allow you to 'polymorph' into something and I have no idea why that's a good thing. It changes your icon!"
    requires = list("Improved Alchemy")