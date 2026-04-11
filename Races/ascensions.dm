

//changed these to line up with ~10 potential after intended SSj Levels (recorded in saiyan/transformations.dm and below)
#define ASCENSION_ONE_POTENTIAL 10 //Sub-SSj Level
#define ASCENSION_TWO_POTENTIAL 30 //SSj1
#define ASCENSION_THREE_POTENTIAL 40 //SSj2

//This is kind of gonna be a lull period for Ascension races. Tough beans...

#define ASCENSION_FOUR_POTENTIAL 60 //Balanced against SSjG / Golden Oozaru; we're skipping SSj3 specific tier
#define ASCENSION_FIVE_POTENTIAL 75 //SSj4; ascension races catch up a bit quicker on this trans level because they had a slog for the previous ascension
#define ASCENSION_SIX_POTENTIAL 90 //SSjG - Blue Evolved; and we're back to typical ascension race progression

//If you want an ascension race to go beyond asc 6 or match SSj4LB, you're going to have to commit a bit of "Plot"

/*word of Jesse on intended Potentials for SSj unlocks (distinct from auto unlocks!!) - as of 2026.02.08
SSj1 - ~20
SSj2 - ~35
SSj3 - ~45
SSjG / Golden Oozaru - ~60
SSj4 / SSjB - ~70
SSj4LB / BE - ~80
These are idealized values and if your app is denied when the wipe is around the desired potential range, it does not mean the admin team hates you
*/



ascension
	Read(F)
		..()
		// death becomes u
		if(!choiceSelected)
			var/path = "[type]"
			var/ascension/a = new path
			for(var/x in a.passives)
				passives[x] = a.passives[x]
			if(isnull(passives))
				world.log << "Hey. [src] didnt get passives."
				passives = list()

	var
		powerAdd = 0
		strength = 0
		endurance = 0
		force = 0
		offense = 0
		defense = 0
		speed = 0
		recovery = 0
		learning = 0
		intelligenceAdd = 0
		imaginationAdd = 0
		anger = 0
		unlock_potential = 1
		intimidation = 0
		intimidationMult = 1
		pilotingProwess = 0
		cyberizeModAdd = 0
		enhanceChips = 0
		rppAdd = 0
		ecoAdd = 0

		angerPoint
		new_anger_message

		list/skills = list()
		list/passives = list()

		choiceTitle = "Ascension Selection"
		choiceMessage = ""
		list/choices = list()
		ascension/choiceSelected
		tmp/pickingChoice = FALSE

		on_ascension_message

		applied = FALSE

	proc
		revertAscension(mob/owner)
			if(!applied || pickingChoice) return

			owner.PotentialRate -= powerAdd
			owner.StrAscension -= strength
			owner.EndAscension -= endurance
			owner.ForAscension -= force
			owner.OffAscension -= offense
			owner.DefAscension -= defense
			owner.SpdAscension -= speed
			owner.RecovAscension -=  recovery

			if(skills.len > 0)
				for(var/obj/Skills/added_skill in skills)
					if(!locate(added_skill,owner)) continue
					owner.DeleteSkill(new added_skill)

			if(passives.len > 0)
				owner.passive_handler.decreaseList(passives)

			if(angerPoint)
				owner.AngerPoint -= angerPoint

			if(new_anger_message)
				if(owner.race.ascensions[owner.AscensionsAcquired-1].new_anger_message)
					owner.AngerMessage = owner.race.ascensions[owner.AscensionsAcquired-1].new_anger_message
				else
					owner.AngerMessage = "becomes angry!"

			if(anger != 0)
				owner.NewAnger(owner.AngerMax-anger)

			owner.Intimidation -= intimidation
			owner.Intimidation /= intimidationMult

			owner.Intelligence -= intelligenceAdd
			owner.Imagination -= imaginationAdd

			owner.CyberizeMod -= cyberizeModAdd

			owner.RPPMult -= rppAdd
			owner.EconomyMult -= ecoAdd
			owner.PilotingProwess -= pilotingProwess
			owner.EnhanceChipsMax -= enhanceChips
			owner.AscensionsAcquired-=1

			if(choiceSelected)
				var/ascension/choiceAsc = choiceSelected
				choiceAsc.revertAscension(owner)
				choiceSelected = null

			owner.SetCyberCancel()

			applied = FALSE

		onAscension(mob/owner)
			DEBUGMSG("onAscension firing");
			. = TRUE
			if(applied || pickingChoice) return FALSE
			owner << on_ascension_message
			choiceSelection(owner)
			if(choices && choices.len > 0 && !choiceSelected) return FALSE
			applied = TRUE

			owner.PotentialRate += powerAdd
			owner.StrAscension += strength
			owner.EndAscension += endurance
			owner.ForAscension += force
			owner.OffAscension += offense
			owner.DefAscension += defense
			owner.SpdAscension += speed
			owner.RecovAscension +=  recovery

			if(skills.len > 0)
				for(var/added_skill in skills)
					if(locate(added_skill,owner)) continue
					owner.AddSkill(new added_skill)

			if(passives.len > 0)
				owner.passive_handler.increaseList(passives)

			if(angerPoint)
				owner.AngerPoint += angerPoint

			if(new_anger_message)
				owner.AngerMessage = new_anger_message

			if(anger != 0)
				owner.NewAnger(owner.AngerMax+anger)

			owner.Intimidation += intimidation
			owner.IntimidationMult += intimidationMult

			owner.Intelligence += intelligenceAdd
			owner.Imagination += imaginationAdd

			owner.CyberizeMod += cyberizeModAdd

			owner.RPPMult += rppAdd
			owner.EconomyMult += ecoAdd
			owner.PilotingProwess += pilotingProwess
			owner.EnhanceChipsMax += enhanceChips

			if(!istype(src, /ascension/sub_ascension))
				owner.AscensionsAcquired+=1

			if(choiceSelected)
				var/ascension/choiceAsc = new choiceSelected
				choiceAsc.onAscension(owner)

			owner.SetCyberCancel()
			DEBUGMSG("onAscension complete");
			postAscension(owner)

		postAscension(mob/owner)
			DEBUGMSG("postAscension firing");

		choiceSelection(mob/owner)
			if(!choices) return
			if(choices.len == 0 || choiceSelected || pickingChoice) return
			pickingChoice = TRUE
			var/selected = input(owner, choiceMessage, choiceTitle) in choices
			choiceSelected = choices[selected]
			pickingChoice = FALSE

		checkAscensionUnlock(mob/target,potential)
			if(target.AscensionsUnlocked > target.AscensionsAcquired) return 1
			if(unlock_potential==-1 || applied) return 0
			if(potential >= unlock_potential)
				return 1
			return 0
