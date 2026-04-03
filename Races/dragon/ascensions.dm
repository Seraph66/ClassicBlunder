ascension
	dragon
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
			intimidation = 20
			onAscension(mob/owner)
				switch(owner.Class)
					if("Metal")
						var/newpassives = list("Juggernaut" = 1, "HeavyHitter" = 0.5, "DeathField" = 1)
						passives+= newpassives
						strength=0.25
						endurance=0.25
						offense=0.5
					if("Fire")
						var/newpassives = list("SpiritHand" = 0.5, "AngerAdaptiveForce" = 0.25, "MeltyBlood" = 1)
						passives+= newpassives
						strength= 0.5
						force= 0.5
						offense= 0.25
						anger=0.25
					if("Water")
						var/newpassives = list("SoftStyle" = 1, "LikeWater" = 1, "Flow" = 1, "Instinct" = 1)
						passives+= newpassives
						strength = 0.25
						force = 0.25
						defense = 0.5
					if("Wind")
						var/newpassives = list("BlurringStrikes" = 0.5, "Flicker" = 1, "Godspeed" = 1, "VenomBlood" = 1, "Adrenaline" = 2)
						passives+= newpassives
						strength = 0.25
						speed = 0.5
						offense = 0.25
					if("Gold")
						var/newpassives = list("Blubber" = 0.25, "CashCow" = 1)
						passives+= newpassives
						ecoAdd = 2
						endurance = 0.5
						speed = 0.25
					if("Dark")
						passives += list("Fury" = 1, "Momentum" = 1)
						strength = 0.35
						speed = 0.35
						offense = 0.35
				..()

		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			intimidation = 30
			onAscension(mob/owner)
				switch(owner.Class)
					if("Metal")
						var/newpassives = list("Juggernaut" = 1, "HeavyHitter" = 0.5, "DeathField" = 1)
						passives+= newpassives
						strength = 0.25
						endurance = 0.25
						defense = 0.25
					if("Fire")
						var/newpassives = list("SpiritHand" = 0.5, "AngerAdaptiveForce" = 0.25)
						passives+= newpassives
						strength = 0.25
						force = 0.25
						offense = 0.25
						anger=0.25
					if("Water")
						var/newpassives = list("SoftStyle" = 1, "LikeWater" = 1, "Flow" = 1, "FluidForm" = 1)
						passives+= newpassives
						strength = 0.25
						force = 0.25
						defense = 0.5
					if("Wind")
						var/newpassives = list("BlurringStrikes" = 0.5, "Flicker" = 1, "Godspeed" = 1)
						passives+= newpassives
						strength = 0.25
						speed = 0.25
						offense = 0.25
					if("Gold")
						passives = list("Blubber" = 0.25, "CashCow" = 1)
						ecoAdd = 1
						endurance = 0.5
						speed = 0.25
					if("Dark")
						passives += list("Fury" = 1, "Momentum" = 1)
						strength = 0.25
						speed = 0.25
						offense = 0.25
				..()

		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			intimidation = 40
			onAscension(mob/owner)
				switch(owner.Class)
					if("Metal")
						var/newpassives = list("Juggernaut" = 1, "HeavyHitter" = 1, "DeathField" = 2)
						passives+= newpassives
						strength = 0.25
						endurance = 0.25
						defense = 0.25
					if("Fire")
						var/newpassives = list("SpiritHand" = 0.5, "DemonicDurability" = 1)
						passives+= newpassives
						strength = 0.25
						force = 0.25
						offense = 0.25
						anger=0.25
					if("Water")
						var/newpassives = list("SoftStyle" = 1, "LikeWater" = 1, "Flow" = 1, "Instinct" = 1)
						passives+= newpassives
						strength = 0.25
						force = 0.25
						defense = 0.25
					if("Wind")
						var/newpassives = list("BlurringStrikes" = 0.5, "Flicker" = 1, "Godspeed" = 1)
						passives+= newpassives
						strength = 0.25
						speed = 0.25
						offense = 0.25
					if("Gold")
						var/newpassives = list("Blubber" = 0.25, "CashCow" = 1, )
						passives+= newpassives
						ecoAdd = 1
						endurance = 0.5
						speed = 0.25
					if("Dark")
						passives += list("Fury" = 1, "Momentum" = 1)
						strength = 0.25
						speed = 0.25
						offense = 0.25
				passives["Incomplete"] = -0.25
				..()
		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Metal")
						var/newpassives = list("HeavyHitter" = 0.5, "DeathField" = 2, "Unstoppable" = 1)
						passives+= newpassives
						strength = 0.25
						endurance = 0.25
						defense = 0.25
					if("Fire")
						var/newpassives = list("SpiritHand" = 0.5, "AdaptiveAngerForce" = 0.25)
						passives+= newpassives
						strength = 0.25
						force = 0.25
						offense = 0.25
						anger=0.25
					if("Water")
						var/newpassives = list("SoftStyle" = 1, "LikeWater" = 1, "Flow" = 1, "FluidForm" = 1, "CalmAnger" = 1)
						passives+= newpassives
						strength = 0.25
						force = 0.25
						defense = 0.25
					if("Wind")
						var/newpassives = list("BlurringStrikes" = 0.5, "Flicker" = 1, "Godspeed" = 1)
						passives+= newpassives
						strength = 0.25
						speed = 0.25
						offense = 0.25
					if("Gold")
						var/newpassives = list("Blubber" = 0.25, "CashCow" = 1, )
						passives+= newpassives
						ecoAdd = 1
						endurance = 0.5
						speed = 0.25
					if("Dark")
						passives += list("Fury" = 1, "Momentum" = 1)
						strength = 0.25
						speed = 0.25
						offense = 0.25
				..()
		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Metal")
						var/newpassives = list("HeavyHitter" = 0.5, "DeathField" = 3)
						passives+= newpassives
						strength = 0.25
						endurance = 0.25
						defense = 0.25
					if("Fire")
						var/newpassives = list("SpiritHand" = 0.5, "AdaptiveAngerForce" = 0.25)
						passives+= newpassives
						strength = 0.25
						force = 0.25
						offense = 0.25
						anger=0.25
					if("Water")
						var/newpassives = list("SoftStyle" = 1, "LikeWater" = 1, "Flow" = 1, "Instinct" = 1)
						passives+= newpassives
						strength = 0.25
						force = 0.25
						defense = 0.25
					if("Wind")
						var/newpassives = list("BlurringStrikes" = 0.5, "Flicker" = 1, "Godspeed" = 1)
						passives+= newpassives
						strength = 0.25
						speed = 0.25
						offense = 0.25
					if("Gold")
						var/newpassives = list("Blubber" = 0.25, "CashCow" = 1, )
						passives+= newpassives
						ecoAdd = 1
						endurance = 0.5
						speed = 0.25
					if("Dark")
						passives += list("Fury" = 1, "Momentum" = 1)
						strength = 0.25
						speed = 0.25
						offense = 0.25
				..()
		six
			unlock_potential = ASCENSION_SIX_POTENTIAL
			onAscension(mob/owner)
				switch(owner.Class)
					if("Metal")
						var/newpassives = list("HeavyHitter" = 0.5, "DeathField" = 3)
						passives+= newpassives
						strength = 0.5
						endurance = 0.5
						defense = 0.5
					if("Fire")
						var/newpassives = list("SpiritHand" = 0.5, "DemonicDurability" = 1)
						passives+= newpassives
						strength = 0.5
						force = 0.5
						offense = 0.5
						anger=0.25
					if("Water")
						var/newpassives = list("SoftStyle" = 1, "LikeWater" = 1, "Flow" = 1, "FluidForm" = 1)
						passives+= newpassives
						strength = 0.5
						force = 0.5
						defense = 0.5
					if("Wind")
						var/newpassives = list("BlurringStrikes" = 0.5, "Flicker" = 1, "Godspeed"=1)
						passives+= newpassives
						strength = 0.5
						speed = 0.5
						offense = 0.5
					if("Gold")
						var/newpassives = list("Blubber" = 0.25, "CashCow" = 1, )
						passives+= newpassives
						ecoAdd = 1
						endurance = 0.5
						speed = 0.25
					if("Dark")
						passives += list("Fury" = 1, "Momentum" = 1)
						strength = 0.5
						speed = 0.5
						offense = 0.5
				..()