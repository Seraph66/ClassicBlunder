ascension
	popo
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			passives = list("Persistence" = 1, "Adrenaline" = 1, "TechniqueMastery" = 1, "UnderDog" = 3, "CashCow" = 1, "ManaGeneration" =1 , "QuickCast" = 1, "Holding Back" = -1, "MovementMastery" = 6)
			on_ascension_message = "You come to understand the pecking order."
			postAscension(mob/owner)
				..()
				owner.Class = "The Dirt"
		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			passives = list("Persistence" = 1, "Adrenaline" = 1, "TechniqueMastery" = 1, "UnderDog" = 5, "CashCow" = 1, "ManaGeneration" =1, "QuickCast" = 1, "Holding Back" = -1, "MovementMastery" = 10)
			postAscension(mob/owner)
				..()
				owner.Class = "The Worms Inside The Dirt"
		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			passives = list("Persistence" = 1, "Adrenaline" = 1, "TechniqueMastery" = 1, "UnderDog" = 5, "CashCow" = 1, "ManaGeneration" =1, "QuickCast" = 1, "Holding Back" = -1, "MovementMastery" = 10)
			postAscension(mob/owner)
				..()
				owner.Class = "Popo's Stool"
		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			passives = list("Persistence" = 1, "Adrenaline" = 1, "TechniqueMastery" = 1, "UnderDog" = 5, "CashCow" = 1, "ManaGeneration" =1, "QuickCast" = 1, "Holding Back" = -1, "MovementMastery" = 10)
			postAscension(mob/owner)
				..()
				owner.Class = "Kami"
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			passives = list("Persistence" = 1, "Adrenaline" = 1, "TechniqueMastery" = 1, "UnderDog" = 5, "CashCow" = 1, "ManaGeneration" =1, "QuickCast" = 1, "Holding Back" = -1, "MovementMastery" = 10)
			on_ascension_message = "You finally sit atop the pecking order."
			postAscension(mob/owner)
				..()
				owner.Class = "Popo"
		six
			unlock_potential = ASCENSION_SIX_POTENTIAL
			passives = list("Tenacity" = 20, "Adrenaline" = 1, "TechniqueMastery" = 1, "UnderDog" = 5, "CashCow" = 1, "ManaGeneration" =1, "QuickCast" = 1, "Holding Back" = -5, "MovementMastery" = 20)
			on_ascension_message = "You finally sit atop the pecking order."
			postAscension(mob/owner)
				..()
				owner.Class = "Dumplin'"
