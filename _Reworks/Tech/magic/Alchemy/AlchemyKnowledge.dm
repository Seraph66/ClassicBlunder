// First we need to know what 'Alchemy' as a system needs
// This shit also just needs to be cheaper fuck you mean a 1 int race has to pay fucking 30 on some of this shit

/knowledgePaths/magic/alchemy   

// I have to integrate this somehow to make sure it increases magic level (does magic level even matter? idfk)
/knowledgePaths/magic/alchemy/Basic_Alchemy //I hate it too but for the sake of preserving things
    name = "Basic Alchemy"
    breakthrough = TRUE
    requires = list()

/knowledgePaths/magic/alchemy/Refreshment_Herbs // Buff or Remove this
    name = "Refreshment Herbs"
    requires = list("Basic Alchemy")
/knowledgePaths/magic/alchemy/Healing_Herbs // Buff or remove this
    name = "Healing Herbs"
    requires = list("Basic Alchemy")
/knowledgePaths/magic/alchemy/Magic_Herbs // Buff or remove this
    name = "Magic Herbs"
    requires = list("Basic Alchemy")
/knowledgePaths/magic/alchemy/Toxic_Herbs //I like this mechanic but needs a balance lookover first.
    name = "Toxic Herbs"
    requires = list("Basic Alchemy")
/knowledgePaths/magic/alchemy/Philter_Herbs // Remove or rename this due to the IMPLICATION
    name = "Philter Herbs"
    requires = list("Basic Alchemy")
/knowledgePaths/magic/alchemy/Improved_Alchemy
    name = "Improved Alchemy"
    breakthrough = TRUE
    requires = list("Basic Alchemy")
/knowledgePaths/magic/alchemy/Stimulant_Herbs
    name = "Stimulant Herbs"
    requires = list("Improved Alchemy")
/knowledgePaths/magic/alchemy/Relaxant_Herbs
    name = "Relaxant Herbs"
    requires = list("Improved Alchemy")
/knowledgePaths/magic/alchemy/Numbing_Herbs
    name = "Numbing Herbs"
    requires = list("Improved Alchemy")
/knowledgePaths/magic/alchemy/Distillation_Process
    name = "Distillation Process"
    requires = list("Improved Alchemy")
/knowledgePaths/magic/alchemy/Mutagenic_Herbs
    name = "Mutagenic Herbs"
    requires = list("Improved Alchemy")