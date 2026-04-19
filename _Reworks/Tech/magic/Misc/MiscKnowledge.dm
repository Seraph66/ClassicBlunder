
/knowledgePaths/magic/misc

/*
/knowledgePaths/magic/misc/SummonMagic
    name = "General Magic Knowledge"
    requires = list()
    // make this go up to 5

/knowledgePaths/magic/misc/SealingMagic
    name = "SealingMagic"
    breakthrough = TRUE
    requires = list()
*/
/knowledgePaths/magic/misc/Spell_Sealing // this has been removed
    // allow this to seal a spell in a tome, making it unable to cast it
    name = "Spell Sealing"
    requires = list("SealingMagic")
/knowledgePaths/magic/misc/Object_Sealing
    name = "Object Sealing"
    requires = list("Spell Sealing")
/knowledgePaths/magic/misc/SpaceMagic // add counterspell, bascially ais but for magic
    name = "SpaceMagic"
    breakthrough = TRUE
    requires = list("SealingMagic")
/knowledgePaths/magic/misc/Counterspell
    name = "Counterspell"
    requires = list("SpaceMagic", "SealingMagic")

/knowledgePaths/magic/misc/Holding_Magic
    name = "Holding Magic"
    requires = list("Counterspell")

/knowledgePaths/magic/misc/Teleportation
    name = "Teleportation"
    requires = list("Holding Magic")

/knowledgePaths/magic/misc/Retrieval
    name = "Retrieval"
    requires = list("Teleportation")
/knowledgePaths/magic/misc/Bilocation
    name = "Bilocation"
    requires = list("Retrieval")

/knowledgePaths/magic/misc/TimeMagic // time + teleport gives you haste
    name = "TimeMagic"
    breakthrough = TRUE
    requires = list("Teleportation")


/knowledgePaths/magic/misc/Transmigration
    name = "Transmigration"
    requires = list("TimeMagic")
/knowledgePaths/magic/misc/Life_Warranty
    // impart a +1 void roll
    name = "Life Warranty"
    requires = list("Transmigration")
/knowledgePaths/magic/misc/Temporal_Displacement
    // increased chance to void
    name = "Temporal Displacement"
    requires = list("Life Warranty")

/knowledgePaths/magic/misc/Temporal_Acceleration // haste
    name = "Temporal Acceleration"
    requires = list("TimeMagic", "Teleportation")

/knowledgePaths/magic/misc/Temporal_Rewinding // A HEAL
    name = "Temporal Rewinding"
    requires = list("Temporal Acceleration")
