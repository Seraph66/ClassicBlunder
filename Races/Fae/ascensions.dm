ascension
	fae
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			intimidation = 20
			onAscension(mob/owner)
				switch(owner.Class)//These are jsut concepts right now. Numbers will be adjusted by staff before implimented.

					if("Pixie")
						var/newpassives = list("Flow" = 1, "DualCast" = 1, "Adrenaline" = 1, "Siphon" = 1)
						passives+= newpassives
						speed = 0.25
						force = 0.5
						defense = 0.25
					if("Goblin")
						var/newpassives = list("Instinct" = 1, "Flicker" = 1, "Adrenaline" = 1, "Pursuer" = 1)
						passives+= newpassives
						force = 0.25
						speed = 0.25
						offense = 0.5
				..()

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			intimidation = 30
			onAscension(mob/owner)
				switch(owner.Class)
					if("Pixie")
						var/newpassives = list("QuickCast" = 1, "LikeWater" = 1, "ManaGeneration" = 1, "Godspeed" = 1)
						passives+= newpassives
						speed = 0.35
						force = 0.35
						defense = 0.35
					if("Goblin")
						var/newpassives = list("BlurringStrikes" = 1, "LikeWater" = 1, "ManaSteal" = 1, "Godspeed" = 1)
						passives+= newpassives
						force = 0.35
						speed = 0.35
						offense = 0.35
				..()


		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			intimidation = 40
			onAscension(mob/owner)
				switch(owner.Class)
					if("Pixie")
						var/newpassives = list("Flow" = 1, "DualCast" = 1, "Adrenaline" = 1, "Siphon" = 1)
						passives+= newpassives
						speed = 0.25
						force = 0.25
						defense = 0.25
					if("Goblin")
						var/newpassives = list("Instinct" = 1, "Flicker" = 1, "Adrenaline" = 1, "Pursuer" = 1)
						passives+= newpassives
						force = 0.25
						speed = 0.25
						offense = 0.25
				..()
		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Pixie")
						var/newpassives = list("QuickCast" = 1, "LikeWater" = 1, "ManaGeneration" = 1, "Godspeed" = 1)
						passives+= newpassives
						speed = 0.35
						force = 0.35
						defense = 0.35
					if("Goblin")
						var/newpassives = list("BlurringStrikes" = 1, "LikeWater" = 1, "ManaSteal" = 1, "Godspeed" = 1)
						passives+= newpassives
						force = 0.35
						speed = 0.35
						offense = 0.35
				..()
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Pixie")
						var/newpassives = list("Flow" = 1, "DualCast" = 1, "Adrenaline" = 1, "Siphon" = 1)
						passives+= newpassives
						speed = 0.25
						force = 0.25
						defense = 0.25
					if("Goblin")
						var/newpassives = list("Instinct" = 1, "Flicker" = 1, "Adrenaline" = 1, "Pursuer" = 1)
						passives+= newpassives
						force = 0.25
						speed = 0.25
						offense = 0.25
				..()
		six
			unlock_potential = ASCENSION_SIX_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Pixie")
						var/newpassives = list("QuickCast" = 1, "LikeWater" = 1, "ManaGeneration" = 1, "Godspeed" = 1)
						passives+= newpassives
						speed = 0.5
						force = 0.5
						defense = 0.5
					if("Goblin")
						var/newpassives = list("BlurringStrikes" = 1, "LikeWater" = 1, "ManaSteal" = 1, "Godspeed" = 1)
						passives+= newpassives
						force = 0.5
						speed = 0.5
						offense = 0.5
				..()