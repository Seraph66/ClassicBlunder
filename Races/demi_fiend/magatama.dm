#define MAGATAMA_SWAP_COOLDOWN 36000 // 1 hour in deciseconds
#define MAGATAMA_COST_ESCALATION 0.25 // +25% base cost per magatama crafted

mob/var
	magatama_last_swap = 0
	magatama_last_type
	magatama_crafted = 0
	magatama_cooldown_until = 0
	list/magatama_allowed_set = list()
	list/magatama_equip_times = list()

mob/proc/getMagatamaEquippedTypes()
	var/list/types = list()
	for(var/obj/Items/Magatama/M in src)
		if(M.suffix == "*Equipped*")
			types[M.type] = 1
	return types

mob/proc/getMagatamaMaxSlots()
	if(passive_handler?.Get("Shijima"))
		return 1 + AscensionsAcquired
	return 1

mob/proc/getMagatamaEquippedCount()
	var/count = 0
	for(var/obj/Items/Magatama/M in src)
		if(M.suffix == "*Equipped*")
			count++
	return count

obj/Items/Magatama
	Stealable = 0
	Pickable = 0
	var/list/base_passives = list()
	var/list/passive_scaling = list()
	var/list/ascension_passives = list()
	var/list/magatama_skills = list()
	var/list/ascension_skills = list()
	var/list/scaled_passives
	var/craft_cost = 0
	var/craft_ascension = 0
	var/mastery = 0
	var/mastery_required_type
	var/mastery_required_amount = 0

	Drop()
		usr << "Magatama are bound to your soul and cannot be dropped."
		return

	verb/Check_Mastery()
		set category = "Demi-fiend"
		set src in usr
		usr << "[name] Mastery: [round(mastery, 0.1)] / 100"

	proc
		gainMastery(amount)
			if(mastery >= 100) return
			var/was_below = mastery < 100
			mastery = min(100, mastery + amount)
			if(was_below && mastery >= 100)
				var/mob/user = loc
				if(user)
					user << "<font color='#FFD700'><b>You have achieved full Mastery over [name]. New possibilities await...</b></font>"

		getMasteryProgress()
			return mastery

		potentialBonus(mob/user, rate)
			if(!rate) return 0
			var/effective_rate = rate
			if(user.passive_handler?.Get("Shijima"))
				effective_rate *= 0.5
			return max(0, user.Potential * effective_rate)

		getScaledPassives(mob/user)
			var/list/result = list()
			for(var/p in base_passives)
				var/rate = (p in passive_scaling) ? passive_scaling[p] : 0
				result[p] = base_passives[p] + potentialBonus(user, rate)
			for(var/level_str in ascension_passives)
				if(user.AscensionsAcquired >= text2num(level_str))
					var/list/asc_list = ascension_passives[level_str]
					for(var/p in asc_list)
						var/rate = (p in passive_scaling) ? passive_scaling[p] : 0
						if(p in result)
							result[p] += asc_list[p] + potentialBonus(user, rate)
						else
							result[p] = asc_list[p] + potentialBonus(user, rate)
			if(user.passive_handler?.Get("Yosuga"))
				var/yosuga_mult = 1 + (0.25 * user.AscensionsAcquired)
				for(var/p in result)
					result[p] *= yosuga_mult
			return result

		grantSkills(mob/user)
			for(var/S in magatama_skills)
				var/obj/Skills/existing = locate(S) in user
				if(!existing)
					user.AddSkill(new S)
			for(var/level_str in ascension_skills)
				if(user.AscensionsAcquired >= text2num(level_str))
					var/list/skill_list = ascension_skills[level_str]
					for(var/S in skill_list)
						var/obj/Skills/existing = locate(S) in user
						if(!existing)
							user.AddSkill(new S)

		revokeSkills(mob/user)
			for(var/S in magatama_skills)
				var/obj/Skills/existing = locate(S) in user
				if(existing) user.DeleteSkill(existing)
			for(var/level_str in ascension_skills)
				var/list/skill_list = ascension_skills[level_str]
				for(var/S in skill_list)
					var/obj/Skills/existing = locate(S) in user
					if(existing) user.DeleteSkill(existing)

		equipMagatama(mob/user)
			suffix = "*Equipped*"
			scaled_passives = getScaledPassives(user)
			user.passive_handler.increaseList(scaled_passives)
			if(!user.passive_handler?.Get("Musubi"))
				grantSkills(user)
			if(!user.passive_handler?.Get("Shijima"))
				user.magatama_last_swap = world.time
				user.magatama_last_type = type
			else
				if(!user.magatama_equip_times) user.magatama_equip_times = list()
				user.magatama_equip_times[type] = world.time
			user << "You ingest [src]. Its power courses through your veins."

		unequipMagatama(mob/user)
			if(user.passive_handler?.Get("Shijima"))
				if(!user.magatama_allowed_set) user.magatama_allowed_set = list()
				user.magatama_allowed_set = user.getMagatamaEquippedTypes()
				user.magatama_cooldown_until = world.time + MAGATAMA_SWAP_COOLDOWN
			if(scaled_passives)
				user.passive_handler.decreaseList(scaled_passives)
				scaled_passives = null
			revokeSkills(user)
			suffix = null
			user << "[src]'s influence recedes from your body."

		refreshPassives(mob/user)
			if(suffix != "*Equipped*") return
			if(scaled_passives)
				user.passive_handler.decreaseList(scaled_passives)
			scaled_passives = getScaledPassives(user)
			user.passive_handler.increaseList(scaled_passives)
			revokeSkills(user)
			if(!user.passive_handler?.Get("Musubi"))
				grantSkills(user)

	ObjectUse(mob/Players/User = usr)
		if(!(src in User))
			return

		if(!User.isRace(/race/demi_fiend))
			User << "Only a Demi-fiend can harness the power of a Magatama."
			return

		if(suffix == "*Equipped*")
			if(!User.passive_handler?.Get("Musubi"))
				var/can_unequip = 0
				if(User.passive_handler?.Get("Shijima"))
					if(!User.magatama_equip_times) User.magatama_equip_times = list()
					var/equip_time = User.magatama_equip_times[type]
					if(!equip_time)
						can_unequip = 1
					else if(world.time >= equip_time + MAGATAMA_SWAP_COOLDOWN)
						can_unequip = 1
					else if(world.time < equip_time)
						can_unequip = 1
				else if(!User.magatama_last_swap || world.time >= User.magatama_last_swap + MAGATAMA_SWAP_COOLDOWN)
					can_unequip = 1
				else if(world.time < User.magatama_last_swap)
					can_unequip = 1
				if(!can_unequip)
					var/remaining = 0
					if(User.passive_handler?.Get("Shijima") && User.magatama_equip_times && User.magatama_equip_times[type])
						remaining = (User.magatama_equip_times[type] + MAGATAMA_SWAP_COOLDOWN - world.time) / 10
					else
						remaining = (User.magatama_last_swap + MAGATAMA_SWAP_COOLDOWN - world.time) / 10
					var/mins = max(0, round(remaining / 60))
					var/secs = max(0, round(remaining % 60))
					User << "Your body is still bonded to [src]. You must wait [mins]m [secs]s before you can release it."
					return
			unequipMagatama(User)
			return

		var/max_slots = User.getMagatamaMaxSlots()
		if(User.getMagatamaEquippedCount() >= max_slots)
			User << "All your Magatama slots are full ([max_slots]). Unequip one first."
			return

		var/skip_cooldown = User.passive_handler?.Get("Musubi")
		if(!skip_cooldown)
			if(User.passive_handler?.Get("Shijima"))
				if(!User.magatama_allowed_set) User.magatama_allowed_set = list()
				if(!(type in User.magatama_allowed_set))
					if(!User.magatama_cooldown_until || world.time >= User.magatama_cooldown_until || world.time < User.magatama_cooldown_until - MAGATAMA_SWAP_COOLDOWN)
						skip_cooldown = 1
					if(!skip_cooldown && world.time < User.magatama_cooldown_until)
						var/remaining = (User.magatama_cooldown_until - world.time) / 10
						var/mins = max(0, round(remaining / 60))
						var/secs = max(0, round(remaining % 60))
						User << "Your body is still adjusting to your current Magatama. You must wait [mins]m [secs]s before ingesting a different one."
						return
			else if(type != User.magatama_last_type && User.magatama_last_swap)
				if(world.time < User.magatama_last_swap)
					skip_cooldown = 1
				else
					var/elapsed = world.time - User.magatama_last_swap
					if(elapsed < MAGATAMA_SWAP_COOLDOWN)
						var/remaining = (MAGATAMA_SWAP_COOLDOWN - elapsed) / 10
						var/mins = round(remaining / 60)
						var/secs = round(remaining % 60)
						User << "Your body is still adjusting. You must wait [mins]m [secs]s before ingesting a different Magatama."
						return

		equipMagatama(User)

mob/proc/refreshMagatama()
	for(var/obj/Items/Magatama/M in src)
		if(M.suffix == "*Equipped*")
			M.refreshPassives(src)

mob/proc/CraftMagatama()
	set name = "Craft Magatama"
	set category = "Demi-fiend"

	if(!isRace(/race/demi_fiend))
		return

	var/list/craft_names = list()
	var/list/craft_paths = list()
	var/list/craft_costs = list()

	for(var/T in subtypesof(/obj/Items/Magatama))
		var/obj/Items/Magatama/template = new T
		if(template.craft_cost <= 0)
			del template
			continue
		if(template.craft_ascension > src.AscensionsAcquired)
			del template
			continue
		if(locate(T) in src)
			del template
			continue
		if(template.mastery_required_type)
			var/obj/Items/Magatama/req = locate(template.mastery_required_type) in src
			if(!req || req.mastery < template.mastery_required_amount)
				del template
				continue
		var/actual_cost = template.craft_cost
		if(!passive_handler?.Get("Musubi"))
			actual_cost = round(template.craft_cost * (1 + magatama_crafted * MAGATAMA_COST_ESCALATION))
		craft_names += template.name
		craft_paths += T
		craft_costs += actual_cost
		del template

	if(!craft_names.len)
		src << "There are no Magatama available to craft right now."
		return

	var/list/display = list()
	for(var/i = 1; i <= craft_names.len; i++)
		display += "[craft_names[i]] ([Commas(craft_costs[i])] Mana Bits)"
	display += "Cancel"

	var/choice = input(src, "Select a Magatama to craft.", "Craft Magatama") in display
	if(choice == "Cancel" || !choice) return

	var/idx = display.Find(choice)
	if(idx < 1 || idx > craft_names.len) return

	var/cost = craft_costs[idx]
	var/craft_path = craft_paths[idx]

	var/obj/Items/mineral/bits = locate(/obj/Items/mineral) in src
	if(!bits || bits.value < cost)
		src << "You need [Commas(cost)] Mana Bits to craft this Magatama."
		return

	src.TakeMineral(cost)
	var/obj/Items/Magatama/M = new craft_path
	src.AddItem(M)
	magatama_crafted++
	src << "You have crafted [M.name]."

obj/Items/Magatama/Marogareh
	name = "Marogareh"
	desc = "The first Magatama. A writhing, parasitic organism that awakens the demonic potential within its host."
	base_passives = list("UnarmedDamage" = 1, "PhysPleroma" = 0.25, "Momentum" = 1)
	passive_scaling = list("UnarmedDamage" = 0.1, "PhysPleroma" = 0.075, "Momentum" = 0.075, "Fa Jin" = 0.05)
	ascension_passives = list("1" = list("Fa Jin" = 1))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Lunge)
	ascension_skills = list("1" = list(/obj/Skills/Queue/Curbstomp))

obj/Items/Magatama/Wadatsumi
	name = "Wadatsumi"
	desc = "A Magatama of frozen seas. Those who ingest it command the bitter cold and the rhythmic power of ocean waves."
	base_passives = list("IceAge" = 50, "Chilling" = 2, "Familiar" = 1, "WaveDancer" = 1)
	passive_scaling = list("IceAge" = 0.5, "Chilling" = 0.2, "Familiar" = 0.05)
	ascension_passives = list("1" = list("BlizzardBringer" = 1))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Ice_Breath)
	ascension_skills = list("1" = list(/obj/Skills/AutoHit/DemiFiend/Fog_Breath))
	craft_cost = 5000

obj/Items/Magatama/Ankh
	name = "Ankh"
	desc = "A Magatama awaiting its power."
	magatama_skills = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Dia)
	ascension_skills = list("2" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Media))
	craft_cost = 5000

obj/Items/Magatama/Iyomante
	name = "Iyomante"
	desc = "A Magatama awaiting its power."
	magatama_skills = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Tarunda)
	ascension_skills = list("1" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Sukunda), "2" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Rakunda))
	craft_cost = 5000

obj/Items/Magatama/Shiranui
	name = "Shiranui"
	desc = "A Magatama awaiting its power."
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Flame_Breath)
	craft_cost = 5000

obj/Items/Magatama/Hifumi
	name = "Hifumi"
	desc = "A Magatama awaiting its power."
	magatama_skills = list(/obj/Skills/Projectile/DemiFiend/Tornado)
	craft_cost = 5000

obj/Items/Magatama/Kamudo
	name = "Kamudo"
	desc = "A Magatama awaiting its power."
	craft_cost = 5000
	mastery_required_type = /obj/Items/Magatama/Marogareh
	mastery_required_amount = 100

obj/Items/Magatama/Narukami
	name = "Narukami"
	desc = "A Magatama awaiting its power."
	craft_cost = 5000
