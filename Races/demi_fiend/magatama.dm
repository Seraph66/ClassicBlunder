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
	desc = "The first Magatama, born when the Conception reshaped the world. A writhing, parasitic organism that awakens the demonic potential within its host."
	base_passives = list("UnarmedDamage" = 1, "PhysPleroma" = 0.25, "Momentum" = 1)
	passive_scaling = list("UnarmedDamage" = 0.1, "PhysPleroma" = 0.075, "Momentum" = 0.075, "Fa Jin" = 0.05, "CounterMaster" = 0.1)
	ascension_passives = list("1" = list("Fa Jin" = 1, "CounterMaster" = 1))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Lunge)
	ascension_skills = list("1" = list(/obj/Skills/AutoHit/DemiFiend/Berserk))

obj/Items/Magatama/Wadatsumi
	name = "Wadatsumi"
	desc = "A Magatama borne of the sea god Wadatsumi. Those who ingest it command the bitter cold and the rhythmic power of ocean waves."
	base_passives = list("IceAge" = 50, "Chilling" = 2, "Familiar" = 1, "WaveDancer" = 1)
	passive_scaling = list("IceAge" = 0.5, "Chilling" = 0.2, "Familiar" = 0.05)
	ascension_passives = list("1" = list("BlizzardBringer" = 1))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Ice_Breath)
	ascension_skills = list("1" = list(/obj/Skills/AutoHit/DemiFiend/Fog_Breath))
	craft_cost = 5000

obj/Items/Magatama/Ankh
	name = "Ankh"
	desc = "A Magatama shaped like the ancient symbol of life. Its restorative power soothes wounds and wards off the touch of darkness."
	base_passives = list("AngelicInfusion" = 1, "Harden" = 1, "EvilResist" = 1)
	passive_scaling = list("Harden" = 0.1, "EvilResist" = 0.02, "ControlResist" = 0.01)
	ascension_passives = list("1" = list("ControlResist" = 1))
	magatama_skills = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Dia)
	ascension_skills = list("2" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Media))
	craft_cost = 5000

obj/Items/Magatama/Iyomante
	name = "Iyomante"
	desc = "A Magatama born from the Ainu bear-sending ritual. Its power enfeebles those who stand against its host, sapping the strength of body and spirit."
	base_passives = list("ControlResist" = 1, "CrippleResist" = 1, "ChillResist" = 1)
	passive_scaling = list("ControlResist" = 0.02, "CrippleResist" = 0.02, "ChillResist" = 0.02)
	magatama_skills = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Tarunda)
	ascension_skills = list("1" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Sukunda), "2" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Rakunda))
	craft_cost = 5000

obj/Items/Magatama/Shiranui
	name = "Shiranui"
	desc = "A Magatama that blazes with foxfire. Named for the mysterious lights that dance above the seas of Kyushu, its sacred flame consumes all in its path."
	base_passives = list("BurnResist" = 1, "Scorching" = 2, "Combustion" = 50)
	passive_scaling = list("BurnResist" = 0.1, "Scorching" = 0.15, "Combustion" = 0.5)
	ascension_passives = list("1" = list("FireHerald" = 1))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Flame_Breath)
	ascension_skills = list("1" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Taunt))
	craft_cost = 5000

obj/Items/Magatama/Hifumi
	name = "Hifumi"
	desc = "A Magatama of howling gales and cutting force. Named for the opening moves of a master strategist, it bends the wind to its host's will."
	base_passives = list("AttackSpeed" = 1, "BlurringStrikes" = 1, "ShearResist" = 1)
	passive_scaling = list("AttackSpeed" = 0.05, "BlurringStrikes" = 0.05, "ShearResist" = 0.02)
	ascension_passives = list("1" = list("ControlResist" = 1))
	magatama_skills = list(/obj/Skills/Projectile/DemiFiend/Tornado)
	ascension_skills = list("1" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/War_Cry))
	craft_cost = 5000

obj/Items/Magatama/Kamudo
	name = "Kamudo"
	desc = "A Magatama of the war god's fury. Those who endure its trial become instruments of destruction, wielding power that transcends mortal limits."
	base_passives = list("Brutalize" = 1, "KillerInstinct" = 0.05, "Fury" = 1, "AttackSpeed" = 1)
	passive_scaling = list("Brutalize" = 0.05, "KillerInstinct" = 0.01, "Fury" = 0.1, "AttackSpeed" = 0.05, "Steady" = 0.1)
	ascension_passives = list("1" = list("MeleeResist" = 1, "Steady" = 1))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Heat_Wave, /obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Focus)
	ascension_skills = list("1" = list(/obj/Skills/AutoHit/DemiFiend/Freikugel))
	craft_cost = 5000
	mastery_required_type = /obj/Items/Magatama/Marogareh
	mastery_required_amount = 100

obj/Items/Magatama/Narukami
	name = "Narukami"
	desc = "A Magatama crackling with divine lightning. It carries the wrath of the thunder god, striking with the fury of the storm."
	base_passives = list("ShockResist" = 1, "Shocking" = 2, "CriticalChance" = 15, "CriticalDamage" = 0.1)
	passive_scaling = list("ShockResist" = 0.02, "Shocking" = 0.5, "CriticalChance" = 0.2, "CriticalDamage" = 0.005)
	ascension_passives = list("1" = list("ThunderHerald" = 1))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Thunder_Breath)
	ascension_skills = list("1" = list(/obj/Skills/AutoHit/DemiFiend/Shock))
	craft_cost = 5000

obj/Items/Magatama/Anathema
	name = "Anathema"
	desc = "A Magatama cast from the curse of the excommunicated. Those who ingest it siphon power from the anguish of the damned and return the gift as unblinking judgment."
	base_passives = list("DarkSpellDamage" = 0.15, "EvilResist" = 1, "Terrifying" = 2)
	passive_scaling = list("DarkSpellDamage" = 0.01, "EvilResist" = 0.02, "Terrifying" = 0.2, "EnergyGeneration" = 0.05)
	ascension_passives = list("1" = list("EnergyGeneration" = 1))
	magatama_skills = list(/obj/Skills/Projectile/DemiFiend/Mamudo)
	ascension_skills = list("1" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Evil_Gaze), "2" = list(/obj/Skills/AutoHit/DemiFiend/Mamudoon))
	craft_cost = 15000
	craft_ascension = 3

obj/Items/Magatama/Miasma
	name = "Miasma"
	desc = "A Magatama exhaled by a dying god of winter. Its frigid breath chokes the living and drinks the ice that flows from the wounds it opens."
	base_passives = list("WaterSpellDamage" = 0.15, "ChillResist" = 1, "Chilling" = 3, "Freezing" = 3)
	passive_scaling = list("WaterSpellDamage" = 0.01, "ChillResist" = 0.02, "Chilling" = 0.2, "Freezing" = 0.1)
	ascension_passives = list("1" = list("LifeGeneration" = 0.5))
	magatama_skills = list(/obj/Skills/Projectile/DemiFiend/Glacial_Blast)
	ascension_skills = list("1" = list(/obj/Skills/AutoHit/DemiFiend/Wild_Dance))
	craft_cost = 15000
	craft_ascension = 3
	mastery_required_type = /obj/Items/Magatama/Wadatsumi
	mastery_required_amount = 100

obj/Items/Magatama/Nirvana
	name = "Nirvana"
	desc = "A Magatama that embodies the boundless calm of enlightenment. Its radiance pierces all illusion and grants the bearer perfect poise against every darkness."
	base_passives = list("LightSpellDamage" = 0.15, "GoodResist" = 1, "CriticalChance" = 10, "ControlResist" = 1)
	passive_scaling = list("LightSpellDamage" = 0.01, "GoodResist" = 0.02, "CriticalChance" = 0.2, "ControlResist" = 0.02)
	ascension_passives = list("1" = list("CriticalDamage" = 0.1))
	magatama_skills = list(/obj/Skills/Projectile/DemiFiend/Divine_Shot)
	ascension_skills = list("1" = list(/obj/Skills/AutoHit/DemiFiend/Violet_Flash))
	craft_cost = 15000
	craft_ascension = 3

obj/Items/Magatama/Murakumo
	name = "Murakumo"
	desc = "The famed cloud-gathering blade, reborn as a Magatama. Legends say it cleaves through any illusion, curse, or chain that binds the soul."
	base_passives = list("MeleeResist" = 1, "ControlResist" = 2, "CrippleResist" = 2, "ShearResist" = 2)
	passive_scaling = list("MeleeResist" = 0.02, "ControlResist" = 0.05, "CrippleResist" = 0.05, "ShearResist" = 0.05)
	ascension_passives = list("1" = list("EvilResist" = 1))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Chaos_Blade)
	ascension_skills = list()
	craft_cost = 15000
	craft_ascension = 3

obj/Items/Magatama/Geis
	name = "Geis"
	desc = "A Magatama of inviolable vow. Its oath binds death, ward, and wound alike, shielding its bearer within the weave of sacred geometries."
	base_passives = list("AngelicInfusion" = 2, "LifeGeneration" = 0.5, "ManaGeneration" = 0.5, "GoodResist" = 1)
	passive_scaling = list("AngelicInfusion" = 0.05, "LifeGeneration" = 0.02, "ManaGeneration" = 0.02, "GoodResist" = 0.02)
	ascension_passives = list("1" = list("EnergyGeneration" = 0.5))
	magatama_skills = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Diarama, /obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Tetraja)
	ascension_skills = list("1" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Mediarama), "2" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Diarahan))
	craft_cost = 15000
	craft_ascension = 3
	mastery_required_type = /obj/Items/Magatama/Ankh
	mastery_required_amount = 100

obj/Items/Magatama/Djed
	name = "Djed"
	desc = "A Magatama shaped like the pillar of stability. Sacred to Osiris, it bears the unshakable spine of order that holds the soul's many bodies aloft."
	base_passives = list("Harden" = 1, "Steady" = 1, "EvilResist" = 1, "GoodResist" = 1)
	passive_scaling = list("Harden" = 0.05, "Steady" = 0.05, "EvilResist" = 0.02, "GoodResist" = 0.02)
	ascension_passives = list("1" = list("ControlResist" = 1))
	magatama_skills = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Tarukaja, /obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Rakukaja)
	ascension_skills = list("1" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Sukukaja, /obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Makakaja), "2" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Dekaja))
	craft_cost = 15000
	craft_ascension = 3

obj/Items/Magatama/Muspell
	name = "Muspell"
	desc = "A Magatama of the burning south. Its howl unmakes minds, sears tongues silent, and crushes the still-standing underfoot."
	base_passives = list("Brutalize" = 1, "Confusing" = 3, "Pacifying" = 3, "Harden" = 1)
	passive_scaling = list("Brutalize" = 0.05, "Confusing" = 0.2, "Pacifying" = 0.2, "Harden" = 0.05)
	ascension_passives = list("1" = list("ControlResist" = 1))
	magatama_skills = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Tentarafoo)
	ascension_skills = list("1" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Makajamon), "2" = list(/obj/Skills/AutoHit/DemiFiend/Xeros_Beat))
	craft_cost = 15000
	craft_ascension = 3

obj/Items/Magatama/Gehenna
	name = "Gehenna"
	desc = "A Magatama drawn from the valley of infernal judgment. Its flame is older than mercy, and it drinks deep from what it consumes."
	base_passives = list("FireSpellDamage" = 0.25, "BurnResist" = 1, "Scorching" = 3, "Combustion" = 75, "FireHerald" = 1)
	passive_scaling = list("FireSpellDamage" = 0.015, "BurnResist" = 0.02, "Scorching" = 0.2, "Combustion" = 0.75)
	ascension_passives = list("1" = list("LifeGeneration" = 0.5, "ManaGeneration" = 0.5))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Hellfire)
	ascension_skills = list("1" = list(/obj/Skills/AutoHit/DemiFiend/Magma_Axis))
	craft_cost = 15000
	craft_ascension = 3
	mastery_required_type = /obj/Items/Magatama/Shiranui
	mastery_required_amount = 100

obj/Items/Magatama/Kamurogi
	name = "Kamurogi"
	desc = "A Magatama imbued with the primordial authority of the Heavenly Ancestors. Its bearer's wounds close on their own, their skin turns aside what would wound them, and every raised hand is met in kind."
	base_passives = list("LifeGeneration" = 0.75, "CounterMaster" = 1, "BurnResist" = 1, "ChillResist" = 1, "ShockResist" = 1, "ShearResist" = 1)
	passive_scaling = list("LifeGeneration" = 0.03, "CounterMaster" = 0.05, "BurnResist" = 0.02, "ChillResist" = 0.02, "ShockResist" = 0.02, "ShearResist" = 0.02, "Steady" = 0.05, "Harden" = 0.05)
	ascension_passives = list("1" = list("CounterMaster" = 1, "Steady" = 1, "Harden" = 1))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Blight)
	ascension_skills = list("1" = list(/obj/Skills/AutoHit/DemiFiend/Iron_Claw), "2" = list(/obj/Skills/AutoHit/DemiFiend/Oni_Kagura))
	craft_cost = 30000
	craft_ascension = 5
	mastery_required_type = /obj/Items/Magatama/Kamudo
	mastery_required_amount = 100

obj/Items/Magatama/Satan
	name = "Satan"
	desc = "A Magatama that whispers with the voice of the Adversary. Those who endure its trial become a murderous axis of judgment, striking down the wicked with every blow."
	base_passives = list("EvilResist" = 3, "CriticalChance" = 15, "CriticalDamage" = 0.1, "Brutalize" = 2, "ManaGeneration" = 0.75)
	passive_scaling = list("EvilResist" = 0.03, "CriticalChance" = 0.2, "CriticalDamage" = 0.005, "Brutalize" = 0.1, "ManaGeneration" = 0.03, "KillerInstinct" = 0.01)
	ascension_passives = list("1" = list("KillerInstinct" = 0.1, "CriticalDamage" = 0.15))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Deadly_Fury)
	ascension_skills = list()
	craft_cost = 30000
	craft_ascension = 5

obj/Items/Magatama/Adama
	name = "Adama"
	desc = "A Magatama shaped from the red clay of the first-formed. Its bearer draws down the storm — thunder surges through their veins, searing any who dare raise a hand against them."
	base_passives = list("AirSpellDamage" = 0.2, "ShockResist" = 1, "Shocking" = 2, "ManaGeneration" = 1)
	passive_scaling = list("AirSpellDamage" = 0.015, "ShockResist" = 0.03, "Shocking" = 0.3, "ManaGeneration" = 0.03, "ThunderHerald" = 0.05)
	ascension_passives = list("1" = list("ThunderHerald" = 1))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Bolt_Storm)
	ascension_skills = list()
	craft_cost = 30000
	craft_ascension = 5
	mastery_required_type = /obj/Items/Magatama/Djed
	mastery_required_amount = 100

obj/Items/Magatama/Vimana
	name = "Vimana"
	desc = "A Magatama shaped like the sky-chariot of the gods. Its bearer rides the howling stratosphere, striking with the swiftness of divine flight."
	base_passives = list("AirSpellDamage" = 0.2, "ShearResist" = 1, "Shearing" = 2, "AttackSpeed" = 2, "Harden" = 1)
	passive_scaling = list("AirSpellDamage" = 0.015, "ShearResist" = 0.03, "Shearing" = 0.3, "AttackSpeed" = 0.1, "Harden" = 0.05, "Steady" = 0.05)
	ascension_passives = list("1" = list("Steady" = 1))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Tempest)
	ascension_skills = list("1" = list(/obj/Skills/AutoHit/DemiFiend/Javelin_Rain))
	craft_cost = 30000
	craft_ascension = 5
	mastery_required_type = /obj/Items/Magatama/Hifumi
	mastery_required_amount = 100

obj/Items/Magatama/Gundari
	name = "Gundari"
	desc = "A Magatama forged in the likeness of the wrathful guardian. It sharpens its bearer into a coiling blade of wind — unblockable, uncatchable, lethal at the first strike."
	base_passives = list("AirSpellDamage" = 0.2, "ShearResist" = 1, "CriticalChance" = 10, "BlurringStrikes" = 2)
	passive_scaling = list("AirSpellDamage" = 0.015, "ShearResist" = 0.03, "CriticalChance" = 0.2, "BlurringStrikes" = 0.1, "CriticalDamage" = 0.005)
	ascension_passives = list("1" = list("CriticalDamage" = 0.15))
	magatama_skills = list(/obj/Skills/Projectile/DemiFiend/Wind_Cutter)
	ascension_skills = list("1" = list(/obj/Skills/AutoHit/DemiFiend/Spiral_Viper))
	craft_cost = 30000
	craft_ascension = 5
	mastery_required_type = /obj/Items/Magatama/Nirvana
	mastery_required_amount = 100

obj/Items/Magatama/Sophia
	name = "Sophia"
	desc = "A Magatama of pure, crystalline wisdom. Its bearer becomes a vessel of holy light — smiting the unclean and bathing their allies in restorative radiance."
	base_passives = list("AngelicInfusion" = 2, "LightSpellDamage" = 0.15, "LifeSteal" = 15, "GoodResist" = 2)
	passive_scaling = list("AngelicInfusion" = 0.05, "LightSpellDamage" = 0.015, "LifeSteal" = 0.2, "GoodResist" = 0.03, "LifeGeneration" = 0.03, "ManaGeneration" = 0.03)
	ascension_passives = list("1" = list("LifeGeneration" = 0.5, "ManaGeneration" = 0.5))
	magatama_skills = list(/obj/Skills/Projectile/DemiFiend/Thunderclap)
	ascension_skills = list("1" = list(/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Mediarahan), "2" = list(/obj/Skills/AutoHit/DemiFiend/Holy_Wrath))
	craft_cost = 30000
	craft_ascension = 5
	mastery_required_type = /obj/Items/Magatama/Geis
	mastery_required_amount = 100

obj/Items/Magatama/Gaea
	name = "Gaea"
	desc = "A Magatama that beats with the slow heart of the living earth. Its bearer becomes an unstoppable avalanche of violence — every swing a sweeping carnage, every wound answered with greater wrath."
	base_passives = list("Brutalize" = 3, "Fury" = 2, "MeleeResist" = 1, "CounterMaster" = 1, "CriticalChance" = 10)
	passive_scaling = list("Brutalize" = 0.1, "Fury" = 0.1, "MeleeResist" = 0.03, "CounterMaster" = 0.05, "CriticalChance" = 0.2, "KillerInstinct" = 0.01)
	ascension_passives = list("1" = list("KillerInstinct" = 0.1))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Deathbound)
	ascension_skills = list("1" = list(/obj/Skills/AutoHit/DemiFiend/Gaea_Rage))
	craft_cost = 30000
	craft_ascension = 5
	mastery_required_type = /obj/Items/Magatama/Iyomante
	mastery_required_amount = 100

obj/Items/Magatama/Kailash
	name = "Kailash"
	desc = "A Magatama that hums with the silence of the unreachable peak. Its bearer strikes with the weight of the underworld itself — a single blow capable of breaking armies."
	base_passives = list("Harden" = 2, "Steady" = 2, "MeleeResist" = 1, "LifeGeneration" = 1, "Brutalize" = 2)
	passive_scaling = list("Harden" = 0.1, "Steady" = 0.1, "MeleeResist" = 0.03, "LifeGeneration" = 0.03, "Brutalize" = 0.1, "KillerInstinct" = 0.01)
	ascension_passives = list("1" = list("KillerInstinct" = 0.1))
	magatama_skills = list(/obj/Skills/AutoHit/DemiFiend/Hades_Blast)
	ascension_skills = list()
	craft_cost = 30000
	craft_ascension = 5
	mastery_required_type = /obj/Items/Magatama/Kamudo
	mastery_required_amount = 100
