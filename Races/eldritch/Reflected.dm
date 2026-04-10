mob/var
	EldritchPacted = 0
	ReflectedPactType="None"
	ReflectedPactOwner = null
obj/Skills/Utility
	Offer_Pact
		desc="Offer a pact for power to a nearby person."
		verb/Offer_Pact()
			set category="Utility"
			if(src.Using)
				return
			src.Using=1
			if(!usr.hasSecret("Eldritch (Reflected)"))
				usr << "Only a Reflected Eldritch can offer pacts."
				src.Using=0
				return
			var/Cost=1*glob.progress.EconomyCost
			var/list/mob/Players/Options=list()
			for(var/mob/Players/P in oview(1, usr))
				if(P.EldritchPacted)
					continue
				Options.Add(P)
			if(Options.len<1)
				usr << "There's nobody nearby to pact!"
				src.Using=0
				return
			var/mob/Players/Choice=input(usr, "Who do you wish to offer a pact to?", "Offer Pact") as null|anything in Options
			if(!Choice)
				src.Using=0
				return
			var/Confirm=alert(usr, "Do you wish to offer [Choice] a pact? It will cost [Commas(Cost)] mana fragments.", "Offer Pact", "Yes", "No")
			if(Confirm=="No")
				src.Using=0
				return
			if(!usr.HasMoney(Cost))
				usr << "You don't have enough fragments. It requires [Commas(Cost)]."
				src.Using=0
				return
			//Target must accept
			var/TargetConfirm=alert(Choice, "[usr] is offering you a pact for power. Do you accept?", "Eldritch Pact", "Accept", "Refuse")
			if(!usr || !usr.client)
				src.Using=0
				return
			if(TargetConfirm=="Refuse")
				usr << "[Choice] has refused your pact."
				src.Using=0
				return
			if(!Choice || !Choice.client)
				usr << "The target is no longer available."
				src.Using=0
				return
			if(get_dist(usr, Choice) > 1)
				usr << "[Choice] has moved too far away."
				src.Using=0
				return
			OMsg(usr, "[usr] begins weaving a pact to grant [Choice] power...")
			var/list/PactTypes=list("Devotion (Balanced)", "Power (Strength)", "Knowledge (Force)", "Ambition (Speed)", "Survival (Endurance)")
			var/choice2=input(Choice, "What type of pact do you wish to accept?", "Pact Type") as null|anything in PactTypes
			if(!choice2)
				usr << "[Choice] could not decide on a pact."
				src.Using=0
				return
			if(!usr || !usr.client)
				src.Using=0
				return
			if(!Choice || !Choice.client)
				usr << "The target is no longer available."
				src.Using=0
				return
			if(get_dist(usr, Choice) > 1)
				usr << "[Choice] has moved too far away."
				src.Using=0
				return
			//Take payment only after everything is confirmed
			usr.TakeMoney(Cost)
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
			OMsg(usr, "[usr] has forged a pact with [Choice], granting them the gift of [Choice.ReflectedPactType]!")
			Choice << "You feel eldritch power flow through you. Your pact type is [Choice.ReflectedPactType]."
			src.Using=0

	Revoke_Pact
		desc="Revoke a pact you have granted, stripping its power."
		verb/Revoke_Pact()
			set category="Utility"
			if(src.Using)
				return
			src.Using=1
			if(!usr.hasSecret("Eldritch (Reflected)"))
				usr << "Only a Reflected Eldritch can revoke pacts."
				src.Using=0
				return
			var/list/mob/Players/Pacted=list()
			for(var/mob/Players/P in world)
				if(P.EldritchPacted && P.ReflectedPactOwner == usr.key)
					Pacted.Add(P)
			if(Pacted.len < 1)
				usr << "You have no active pacts."
				src.Using=0
				return
			var/mob/Players/Target=input(usr, "Whose pact do you wish to revoke?", "Revoke Pact") as null|anything in Pacted
			if(!Target)
				src.Using=0
				return
			Target.EldritchPacted = 0
			Target.ReflectedPactType = "None"
			Target.ReflectedPactOwner = null
			Target << "The eldritch power drains from your body as your pact is revoked."
			OMsg(usr, "[usr] severs the pact with [Target], stripping them of eldritch power.")
			src.Using=0
