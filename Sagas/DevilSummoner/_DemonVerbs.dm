/mob/proc/DevilSummonerRestoreVerbs()
	if(Saga != "Devil Summoner") return
	if(SagaLevel >= 1)
		src.verbs += /mob/proc/verb_SummonDemon
		src.verbs += /mob/proc/verb_CallDemon
	if(SagaLevel >= 2)
		src.verbs += /mob/proc/verb_RecordDemon
		src.verbs += /mob/proc/verb_OpenCompendium
	if(SagaLevel >= 3)
		src.verbs += /mob/proc/verb_OpenFusion
	if(!demon_party) demon_party = list()
	if(!demon_compendium) demon_compendium = list()
	demon_active = null
	demon_active_name = ""
	demon_summon_cooldown = 0
	demon_call_cooldown = 0

/mob/proc/DevilSummonerLogout()
	if(Saga != "Devil Summoner") return
	if(demon_active)
		var/mob/Player/AI/Demon/d = demon_active
		if(d)
			for(var/datum/party_demon/pd in demon_party)
				if(pd.demon_name == d.name)
					pd.current_hp = d.demon_hp
					break
			d.ai_owner = null
			del(d)
		demon_active = null
		demon_active_name = ""

/mob/proc/verb_SummonDemon()
	set name     = "Summon Demon"
	set category = "Devil Summoner"

	if(!demon_party || !demon_party.len)
		src << "You have no demons in your party."
		return

	if(world.time < demon_summon_cooldown)
		var/remaining = round((demon_summon_cooldown - world.time) / 10)
		src << "Summon Demon is on cooldown. ([remaining]s remaining)"
		return

	RefreshDemonSummonWindow()
	winshow(src, "DemonSummonWindow", TRUE)


/mob/proc/verb_CallDemon()
	set name     = "Call Demon"
	set category = "Devil Summoner"

	if(!demon_active)
		src << "You have no demon currently summoned."
		return

	if(world.time < demon_call_cooldown)
		var/remaining = round((demon_call_cooldown - world.time) / 10)
		src << "Call Demon is on cooldown. ([remaining]s remaining)"
		return

	var/mob/Player/AI/Demon/d = demon_active
	if(d)
		d.loc = locate(src.x, src.y, src.z)
		src << "You call [d.name] to your side."
		demon_call_cooldown = world.time + 150  // 15 seconds

/mob/proc/verb_RecordDemon()
	set name     = "Record Demon"
	set category = "Devil Summoner"

	if(SagaLevel < 2)
		src << "Unlock Tier 2 of Devil Summoner to access the Compendium."
		return

	OpenRecordDemonUI()

/mob/proc/verb_OpenCompendium()
	set name     = "Compendium"
	set category = "Devil Summoner"

	if(SagaLevel < 2)
		src << "Unlock Tier 2 of Devil Summoner to access the Compendium."
		return

	OpenCompendiumUI()

/mob/proc/verb_OpenFusion()
	set name     = "Fuse Demons"
	set category = "Devil Summoner"

	if(SagaLevel < 3)
		src << "Unlock Tier 3 of Devil Summoner to access Fusion."
		return

	OpenFusionUI()

/mob/proc/DemonSummonFromParty(demon_name)
	var/datum/party_demon/pd = null
	for(var/datum/party_demon/p in demon_party)
		if(p.demon_name == demon_name)
			pd = p
			break
	if(!pd)
		src << "That demon is not in your party."
		return

	if(pd.current_hp <= 0)
		src << "[demon_name]'s HP is depleted. Meditate to restore them."
		return

	if(demon_active)
		var/mob/Player/AI/Demon/old = demon_active
		if(old)
			animate(old, alpha=0, time=8)
			spawn(8) del(old)
		ai_followers -= demon_active
		demon_active = null
		demon_active_name = ""

	var/datum/demon_data/dd = DEMON_DB[demon_name]
	if(!dd) return

	var/mob/Player/AI/Demon/d = new
	ticking_ai.Remove(d)
	d.alpha = 0
	d.loc = locate(src.x, src.y, src.z)
	animate(d, alpha=255, time=10)
	d.DemonInit(dd, src)
	d.demon_hp = pd.current_hp  // restore HP

	demon_active      = d
	demon_active_name = demon_name

	src << "You summon <b>[demon_name]</b>!"
	demon_summon_cooldown = world.time + 600  // 60s

/mob/proc/DemonUnsummon()
	if(!demon_active) return
	var/mob/Player/AI/Demon/d = demon_active
	if(d)
		for(var/datum/party_demon/pd in demon_party)
			if(pd.demon_name == demon_active_name)
				pd.current_hp = d.demon_hp
				break
		animate(d, alpha=0, time=8)
		spawn(8)
			ai_followers -= d
			del(d)
	demon_active      = null
	demon_active_name = ""
	src << "You unsummon your demon."
	demon_summon_cooldown = world.time + 600  // 60s

/mob/proc/ExecuteFusion(name_a, name_b)
	var/datum/party_demon/pd_a = null
	var/datum/party_demon/pd_b = null
	for(var/datum/party_demon/pd in demon_party)
		if(pd.demon_name == name_a) pd_a = pd
		if(pd.demon_name == name_b) pd_b = pd
	if(!pd_a || !pd_b)
		src << "One or both demons are no longer in your party."
		return

	var/result_name = GetFusionResultByLevel(name_a, pd_a.party_level,
	                                          name_b, pd_b.party_level)
	if(!result_name || copytext(result_name, 1, 9) == "_ELEMENT_")
		// Element fusion
		if(copytext(result_name, 1, 9) == "_ELEMENT_")
			ExecuteElementFusion(name_a, name_b, result_name)
		else
			src << "That fusion is not possible."
		return

	var/confirm = alert(src, "Fuse [name_a] and [name_b] to create [result_name]? Both original demons will be lost.", "Confirm Fusion", "Fuse", "Cancel")
	if(confirm != "Fuse") return

	if(demon_active_name == name_a || demon_active_name == name_b)
		DemonUnsummon()

	// Remove ingredients from party
	var/plen = length(demon_party)
	for(var/i = plen, i >= 1, i--)
		var/datum/party_demon/pd = demon_party[i]
		if(pd.demon_name == name_a || pd.demon_name == name_b)
			demon_party.Remove(pd)
			del(pd)

	var/datum/demon_data/result_dd = DEMON_DB[result_name]
	if(!result_dd)
		src << "Error: result demon [result_name] not found in database."
		return

	var/datum/party_demon/result_pd = new /datum/party_demon()
	result_pd.demon_name  = result_name
	result_pd.party_level = result_dd.demon_lvl  // starts at base level
	result_pd.current_hp  = 100
	demon_party += result_pd

	src << "<b>Fusion successful!</b> [name_a] and [name_b] combined into <b>[result_name]</b>!"

	// Close fusion window and reopen it
	src << browse(null, "window=DemonFusion")
	if(demon_party.len >= 2) OpenFusionUI()

// Element fusion path
/mob/proc/ExecuteElementFusion(name_a, name_b, encoded_result)
	var/parts = splittext(encoded_result, "_")
	var/element_race = parts[3]
	var/shift_up = (element_race == "Aquans" || element_race == "Aeros")
	var/target_demon = name_a

	var/result_name = GetElementFusionResult(element_race, target_demon, shift_up)
	if(!result_name)
		src << "No valid Element fusion result found."
		return

	var/confirm = alert(src, "Element Fusion: [target_demon] -> [result_name]? [name_b] (the element) will be consumed.", "Confirm Fusion", "Fuse", "Cancel")
	if(confirm != "Fuse") return

	if(demon_active_name == name_a || demon_active_name == name_b) DemonUnsummon()

	var/elen = length(demon_party)
	for(var/i = elen, i >= 1, i--)
		var/datum/party_demon/pd = demon_party[i]
		if(pd.demon_name == name_a || pd.demon_name == name_b)
			demon_party.Remove(pd)
			del(pd)

	var/datum/demon_data/result_dd = DEMON_DB[result_name]
	if(!result_dd) return

	var/datum/party_demon/result_pd = new /datum/party_demon()
	result_pd.demon_name  = result_name
	result_pd.party_level = result_dd.demon_lvl
	result_pd.current_hp  = 100
	demon_party += result_pd

	src << "<b>Element Fusion!</b> [name_a] became <b>[result_name]</b>!"
	src << browse(null, "window=DemonFusion")

/mob/proc/ExecuteWithdraw(demon_name, level_choice)
	if(!demon_compendium || !(demon_name in demon_compendium)) return
	var/datum/compendium_demon/cd = demon_compendium[demon_name]
	var/datum/demon_data/dd = DEMON_DB[demon_name]
	if(!dd) return

	if(demon_party && demon_party.len >= demon_party_cap)
		src << "Your party is full."
		return

	var/chosen_level = cd.base_level
	var/cost = cd.base_level * 500

	if(level_choice == "recorded")
		chosen_level = cd.recorded_level
		cost = cd.recorded_level * 500

	if(!HasFragments(cost))
		src << "Insufficient Mana Bits. You need [cost] to withdraw [demon_name]."
		return
	TakeFragments(cost)
	src << "Spent [cost] Mana Bits."

	var/datum/party_demon/pd = new /datum/party_demon()
	pd.demon_name  = demon_name
	pd.party_level = chosen_level
	pd.current_hp  = 100
	demon_party += pd

	src << "[demon_name] added to your party at level [chosen_level]."
	src << browse(null, "window=DemonWithdraw")
	OpenCompendiumUI()

/mob/proc/ExecuteRecordDemon(demon_name)
	var/datum/party_demon/pd = null
	for(var/datum/party_demon/p in demon_party)
		if(p.demon_name == demon_name) { pd = p; break }
	if(!pd) return

	var/datum/demon_data/dd = DEMON_DB[demon_name]
	if(!dd) return

	if(!demon_compendium) demon_compendium = list()

	var/datum/compendium_demon/cd
	if(demon_name in demon_compendium)
		cd = demon_compendium[demon_name]
	else
		cd = new /datum/compendium_demon()
		cd.demon_name = demon_name
		cd.base_level = dd.demon_lvl

	// Recorded level = scaled level based on player Potential
	cd.recorded_level = max(dd.demon_lvl, round(dd.demon_lvl * (max(1, Potential) / 100)))
	demon_compendium[demon_name] = cd

	src << "<b>[demon_name]</b> has been recorded in your compendium."
	if(cd.recorded_level > cd.base_level)
		src << "Recorded at Level [cd.recorded_level] (base: [cd.base_level]). Higher withdrawal costs Mana Bits."
	src << browse(null, "window=DemonRecord")

/mob/proc/DemonMeditateCheck()
	if(Saga != "Devil Summoner") return
	if(icon_state == "Meditate")
		if(!demon_meditate_start)
			demon_meditate_start = world.time
			demon_meditate_healed = FALSE
		else if(!demon_meditate_healed && (world.time - demon_meditate_start) >= 150)
			var/any_healed = FALSE
			if(demon_party)
				for(var/datum/party_demon/pd in demon_party)
					if(pd.current_hp < 100)
						pd.current_hp = 100
						any_healed = TRUE
			if(demon_active)
				var/mob/Player/AI/Demon/d = demon_active
				if(d) d.demon_hp = 100
			if(any_healed)
				src << "<b>Your demons have been restored.</b>"
			demon_meditate_healed = TRUE
	else
		demon_meditate_start   = 0
		demon_meditate_healed  = FALSE

/mob/proc/AddDemonToRoster(dname)
	var/datum/demon_data/dd = DEMON_DB[dname]
	if(!dd) return
	if(!demon_party) demon_party = list()
	if(!demon_compendium) demon_compendium = list()

	if(demon_party.len < demon_party_cap)
		var/datum/party_demon/pd = new /datum/party_demon()
		pd.demon_name  = dname
		pd.party_level = dd.demon_lvl
		pd.current_hp  = 100
		demon_party += pd
		src << "<b>[dname]</b> has joined your party."
	else
		if(!(dname in demon_compendium))
			var/datum/compendium_demon/cd = new /datum/compendium_demon()
			cd.demon_name     = dname
			cd.base_level     = dd.demon_lvl
			cd.recorded_level = dd.demon_lvl
			demon_compendium[dname] = cd
			src << "<b>[dname]</b> has been added to your Compendium (party full)."
		else
			src << "<b>[dname]</b> is already recorded in your Compendium."

/mob/proc/GrantStarterDemons(tier)
	var/min_lvl = 0
	var/max_lvl = 0
	switch(tier)
		if(1)
			min_lvl = 1
			max_lvl = 15
		if(2)
			min_lvl = 16
			max_lvl = 30
		if(3)
			min_lvl = 31
			max_lvl = 45
		else
			return

	var/list/eligible = list()
	for(var/dname in DEMON_DB)
		var/datum/demon_data/dd = DEMON_DB[dname]
		if(dd.demon_lvl < min_lvl || dd.demon_lvl > max_lvl) continue
		if(dd.demon_unique) continue
		var/race = dd.demon_race
		if(race == "Erthys" || race == "Aeros" || race == "Aquans" || race == "Flaemis") continue
		eligible.Add(dname)

	if(!eligible.len)
		src << "No eligible demons available for this tier."
		return

	src << "<b>Choose 2 demons</b> to add to your roster (Level [min_lvl]-[max_lvl])."

	var/list/picked = list()
	for(var/n = 1, n <= 2, n++)
		var/list/options = eligible.Copy()
		for(var/p in picked)
			options -= p
		if(!options.len) break

		var/choice = input(src, "Choose demon [n] of 2:", "Starter Demon -- Tier [tier]") as null|anything in options
		if(!choice) break
		picked.Add(choice)

	for(var/dname in picked)
		AddDemonToRoster(dname)
