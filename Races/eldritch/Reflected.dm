mob/var
	EldritchPacted
	ReflectedPactType="None"
	ReflectedPactOwner
obj/Skills/Utility
	Offer_Pact
		desc="Offer a pact for power."
		verb/Offer_Pact()
			set category="Utility"
			if(src.Using)
				return
			src.Using=1
			var/Cost=1*glob.progress.EconomyCost
			var/list/mob/Players/Options=list("Cancel")
			for(var/mob/Players/P in get_step(usr, usr.dir))
				if(P.EldritchPacted)
					continue
				Options.Add(P)
			if(Options.len<2)
				usr << "There's nobody to pact!"
				src.Using=0
				return
			var/mob/Players/Choice=input(usr, "What person do you wish to pact?", "Offer Pact") in Options
			if(Choice=="Cancel")
				src.Using=0
				return
			var/Confirm=alert(usr, "Do you wish to offer [Choice] a pact?  It will cost [Commas(Cost)] mana fragments.", "Offer Pact", "No", "Yes")
			if(Confirm=="No")
				src.Using=0
				return
			if(!usr.HasMoney(Cost)) //note to self, make this fragments instead of money
				usr << "You don't have enough fragments.  It requires [Commas(Cost)]."
				src.Using=0
				return
			OMsg(usr, "[usr] begins weaving a pact to grant [Choice] power...")
			var/list/PactTypes=list("Devotion (Balanced)", "Power (Strength)", "Knowledge (Force)", "Ambition (Speed)", "Survival (Endurance)")
			var/choice2
			choice2=input(Choice, "What skill do you want?", "Martial Keyblade Skill") in PactTypes
			switch(choice2)
				if("Devotion (Balanced)")
					Choice.ReflectedPactType="Devotion"
				if("Power (Strength)")
					Choice.ReflectedPactType="Power"
				if("Knowledge (Force)")
					Choice.ReflectedPactType="Knowledge"
				if("Ambition (Speed)")
					Choice.ReflectedPactType="Ambition"
				if("Survival (Endurance)")
					Choice.ReflectedPactType="Survival"
			Choice.EldritchPacted=1
			Choice.ReflectedPactOwner=usr.key
