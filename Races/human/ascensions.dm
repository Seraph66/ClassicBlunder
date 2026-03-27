/ascension/sub_ascension/human/hero
	passives = list("UnderDog" = 1,"Persistence" = 1)
	offense = 0.25
	strength = 0.25
	force = 0.25
	defense = 0.25
	endurance = 0.25

/ascension/sub_ascension/human/innovative
	defense = 0.25
	endurance = 0.25



ascension
	human
		one
			unlock_potential = ASCENSION_ONE_POTENTIAL
	//		choices = list("Hero" = /ascension/sub_ascension/human/hero, "Innovative" = /ascension/sub_ascension/human/innovative)
			passives = list("Tenacity" = 1, "Shonen" = 1, "ShonenPower" = 0.15, "UnderDog" = 1,"Persistence" = 1)
			new_anger_message = "grows desperate!"
			on_ascension_message = "You learn the meaning of desperation..."
			onAscension(mob/owner)
				if(!applied)
					switch(owner.Class)
						if("Underdog")
							anger = 0.1
							offense = 0.25
							strength = 0.25
							force = 0.25
							defense = 0.25
							endurance = 0.25
							speed = 0.25
						if("Heroic")
							offense = 0.5
							strength = 0.5
							force = 0.5
							defense = 0.5
							endurance = 0.5
							speed = 0.4
							passives["KiControlMastery"] = 1
						if("Resourceful")
							offense = 0.1
							strength = 0.1
							force = 0.1
							defense = 0.1
							endurance = 0.1
							speed = 0.1
				..()
		two
			unlock_potential = ASCENSION_TWO_POTENTIAL
			passives = list("Tenacity" = 1, "Shonen" = 1, "ShonenPower" = 0.15, "UnderDog"=1, "Adrenaline"=1, "Persistence" = 1, "Adaptation" = 1)
			new_anger_message = "grows determined!"
			on_ascension_message = "You learn the meaning of responsibility..."
			onAscension(mob/owner)
				if(!applied)
					switch(owner.Class)
						if("Underdog")
							anger = 0.1
							offense = 0.25
							strength = 0.25
							force = 0.25
							defense = 0.25
							endurance = 0.25
							speed = 0.25
						if("Heroic")
							offense = 1
							strength = 1
							force = 1
							defense = 1
							endurance = 1
							speed = 0.4
							//TO DO - Something that makes them scale with SSj1. Passives? Inherent buff? hm.
						if("Resourceful")
							offense = 0.1
							strength = 0.1
							force = 0.1
							defense = 0.1
							endurance = 0.1
				..()
		three
			unlock_potential = ASCENSION_THREE_POTENTIAL
			passives = list("Tenacity" = 1, "DemonicDurability" = 0.5, "UnderDog"=1, "Persistence" = 1)
			new_anger_message="grows confident!"
			on_ascension_message = "You learn the meaning of confidence..."
			anger = 0.1
			defense = 0.5
			endurance = 0.25
			offense = 0.25
			strength = 0.25
			force = 0.25
			speed = 0.25
			onAscension(mob/owner)
				if(!applied)
					switch(owner.Class)
						if("Underdog")
							anger = 0.1
							offense = 0.25
							strength = 0.25
							force = 0.25
							defense = 0.25
							endurance = 0.25
							speed = 0.25
						if("Heroic")
							offense = 0.75
							strength = 0.75
							force = 0.75
							defense = 0.75
							endurance = 0.75
							speed = 0.4
							passives["KiControlMastery"] = 1
							//TO DO - Something that makes them scale with SSj2. Passives? Inherent buff? hm.
						if("Resourceful")
							offense = 0.1
							strength = 0.1
							force = 0.1
							defense = 0.1
							endurance = 0.1
				..()

		four
			unlock_potential = ASCENSION_FOUR_POTENTIAL
			passives = list("Tenacity" = 1, "DemonicDurability" = 0.5, "UnderDog"=1, "Persistence" = 1)
			new_anger_message = "gains absolute clarity!"
			on_ascension_message = "You learn the meaning of competence..."
			onAscension(mob/owner)
				if(!applied)
					switch(owner.Class)
						if("Underdog")
							anger = 0.1
							offense = 0.25
							strength = 0.25
							force = 0.25
							defense = 0.25
							endurance = 0.25
							speed = 0.25
						if("Heroic")
							offense = 1
							strength = 1
							force = 1
							defense = 1
							endurance = 1
							speed = 0.4
							//TO DO - Something that makes it not obvious that I just copied and pasted this three times
						if("Resourceful")
							offense = 0.1
							strength = 0.1
							force = 0.1
							defense = 0.1
							endurance = 0.1
				..()

		five
			unlock_potential = ASCENSION_FIVE_POTENTIAL
			passives = list( "Tenacity" = 1, "DemonicDurability" = 0.5, "UnderDog"=1, "Persistence" = 1)
			new_anger_message = "becomes angry!"
			on_ascension_message = "You learn the meaning of humanity..."
			onAscension(mob/owner)
				if(!applied)
					switch(owner.Class)
						if("Underdog")
							anger = 0.1
							offense = 0.25
							strength = 0.25
							force = 0.25
							defense = 0.25
							endurance = 0.25
							speed = 0.25
						if("Heroic")
							offense = 1.5
							strength = 1.5
							force = 1.5
							defense = 1.5
							endurance = 1.5
							speed = 0.4
							passives["KiControlMastery"] = 1
							//TO DO - Something that makes it not obvious that I just copied and pasted this four times
						if("Resourceful")
							offense = 0.1
							strength = 0.1
							force = 0.1
							defense = 0.1
							endurance = 0.1
				..()
		six
			unlock_potential = ASCENSION_SIX_POTENTIAL
			passives = list( "Tenacity" = 1, "DemonicDurability" = 0.5, "UnderDog"=1, "Persistence" = 1)
			new_anger_message = "becomes angry!"
			on_ascension_message = "You learn the meaning of humanity..."
			onAscension(mob/owner)
				if(!applied)
					switch(owner.Class)
						if("Underdog")
							offense = 0.25
							strength = 0.25
							force = 0.25
							defense = 0.25
							endurance = 0.25
							speed = 0.25
						if("Heroic")
							offense = 2
							strength = 2
							force = 2
							defense = 2
							endurance = 2
							speed = 0.4
							//TO DO - Something that makes it not obvious that I just copied and pasted this five times
						if("Resourceful")
							offense = 0.1
							strength = 0.1
							force = 0.1
							defense = 0.1
							endurance = 0.1
				..()
