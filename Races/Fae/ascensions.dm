ascension
	fae
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)//These are jsut concepts right now. Numbers will be adjusted by staff before implimented.

					if("Pixie")
						var/newpassives = list("SpiritFlow" = 1, "Adrenaline" = 1, "Siphon" = 1)
						passives+= newpassives
						speed = 0.25
						force = 0.5
						defense = 0.25
						strength = 0.15
						offense = 0.15
						endurance = 0.15
					if("Goblin")
						var/newpassives = list("Flicker" = 1, "Adrenaline" = 1, "Pursuer" = 1)
						passives+= newpassives
						force = 0.25
						speed = 0.25
						offense = 0.5
						strength = 0.15
						defense = 0.15
						endurance = 0.15
				..()

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Pixie")
						var/newpassives = list("QuickCast" = 1, "ManaGeneration" = 1, "Godspeed" = 1)
						passives+= newpassives
						speed = 0.35
						force = 0.35
						defense = 0.35
						strength = 0.15
						offense = 0.15
						endurance = 0.15
					if("Goblin")
						var/newpassives = list("Fury" = 1, "ManaSteal" = 1, "Godspeed" = 1)
						passives+= newpassives
						force = 0.35
						speed = 0.35
						offense = 0.35
						strength = 0.15
						defense = 0.15
						endurance = 0.15
				..()


		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Pixie")
						var/newpassives = list("SpiritStrike" = 1, "Adrenaline" = 1, "Siphon" = 1)
						passives+= newpassives
						speed = 0.25
						force = 0.25
						defense = 0.25
						strength = 0.15
						offense = 0.15
						endurance = 0.15
					if("Goblin")
						var/newpassives = list("Flicker" = 1, "Adrenaline" = 1, "Pursuer" = 1)
						passives+= newpassives
						force = 0.25
						speed = 0.25
						offense = 0.25
						strength = 0.15
						defense = 0.15
						endurance = 0.15
				..()
		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Pixie")
						var/newpassives = list("QuickCast" = 1, "ManaGeneration" = 1, "Godspeed" = 1)
						passives+= newpassives
						speed = 0.35
						force = 0.35
						defense = 0.35
						strength = 0.15
						offense = 0.15
						endurance = 0.15
					if("Goblin")
						var/newpassives = list("Fury" = 1, "ManaSteal" = 1, "Godspeed" = 1)
						passives+= newpassives
						force = 0.35
						speed = 0.35
						offense = 0.35
						strength = 0.15
						defense = 0.15
						endurance = 0.15
				..()
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Pixie")
						var/newpassives = list("MovingCast" = 1, "Adrenaline" = 1, "Siphon" = 1)
						passives+= newpassives
						speed = 0.25
						force = 0.25
						defense = 0.25
						strength = 0.15
						offense = 0.15
						endurance = 0.15
					if("Goblin")
						var/newpassives = list("Flicker" = 1, "Adrenaline" = 1, "Pursuer" = 1)
						passives+= newpassives
						force = 0.25
						speed = 0.25
						offense = 0.25
						strength = 0.15
						defense = 0.15
						endurance = 0.15
				..()
		six
			unlock_potential = ASCENSION_SIX_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Pixie")
						var/newpassives = list("QuickCast" = 1, "ManaGeneration" = 1, "Godspeed" = 1)
						passives+= newpassives
						speed = 0.5
						force = 0.5
						defense = 0.5
						strength = 0.25
						offense = 0.25
						endurance = 0.25
					if("Goblin")
						var/newpassives = list("Fury" = 1, "ManaSteal" = 1, "Godspeed" = 1)
						passives+= newpassives
						force = 0.5
						speed = 0.5
						offense = 0.5
						strength = 0.25
						defense = 0.25
						endurance = 0.25
				..()