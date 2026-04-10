/mob/proc/DemonInParty(dname)
	if(!demon_party) return FALSE
	for(var/datum/party_demon/pd in demon_party)
		if(pd.demon_name == dname) return TRUE
	return FALSE

/mob/proc/DemonUIBusy()
	if(demon_fusion_open)   return TRUE
	if(demon_inherit_open)  return TRUE
	if(demon_pending_fuse_result && demon_pending_fuse_result != "") return TRUE
	return FALSE

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

	demon_fusion_open = FALSE
	demon_compendium_open = FALSE
	demon_record_open = FALSE
	demon_withdraw_open = FALSE
	demon_inherit_open = FALSE

	demon_pending_fuse_a = ""
	demon_pending_fuse_b = ""
	demon_pending_fuse_result = ""
	demon_pending_fuse_base_skills = null
	demon_pending_fuse_pool = null
	demon_pending_fuse_open_slots = 0

	for(var/datum/party_demon/pd in demon_party)
		if(!pd.demon_skills || !pd.demon_skills.len)
			var/datum/demon_data/dd = DEMON_DB[pd.demon_name]
			if(dd && dd.demon_skills) pd.demon_skills = dd.demon_skills.Copy()
		pd.skill_cooldowns = list()

/mob/proc/DevilSummonerLogout()
	if(Saga != "Devil Summoner") return
	if(SagaLevel >= 4)
		RemoveDemonRacialPassive()
	ClearDemonSkillHUD()

	demon_fusion_open = FALSE
	demon_compendium_open = FALSE
	demon_record_open = FALSE
	demon_withdraw_open = FALSE
	demon_inherit_open = FALSE

	demon_pending_fuse_a = ""
	demon_pending_fuse_b = ""
	demon_pending_fuse_result = ""
	demon_pending_fuse_base_skills = null
	demon_pending_fuse_pool = null
	demon_pending_fuse_open_slots = 0

	if(demon_active)
		var/mob/Player/AI/Demon/d = demon_active
		if(d)
			for(var/datum/party_demon/pd in demon_party)
				if(pd.demon_name == d.name)
					pd.current_hp = d.demon_hp
					break
			ai_followers -= d
			d.ai_owner = null
			del(d)
		demon_active = null
		demon_active_name = ""


/mob/proc/verb_SummonDemon()
	set name     = "Summon Demon"
	set category = "Devil Summoner"

	if(DemonUIBusy())
		src << "Close your current Demon menu before summoning."
		return

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

	if(DemonUIBusy())
		src << "Close your current Demon menu first."
		return

	OpenRecordDemonUI()

/mob/proc/verb_OpenCompendium()
	set name     = "Compendium"
	set category = "Devil Summoner"

	if(SagaLevel < 2)
		src << "Unlock Tier 2 of Devil Summoner to access the Compendium."
		return

	if(DemonUIBusy())
		src << "Close your current Demon menu first."
		return

	OpenCompendiumUI()

/mob/proc/verb_OpenFusion()
	set name     = "Fuse Demons"
	set category = "Devil Summoner"

	if(SagaLevel < 3)
		src << "Unlock Tier 3 of Devil Summoner to access Fusion."
		return

	if(demon_record_open || demon_compendium_open || demon_withdraw_open)
		src << "Close your current Demon menu first."
		return

	OpenFusionUI()


/mob/proc/DemonSummonFromParty(demon_name)
	if(DemonUIBusy())
		src << "Complete or cancel your current Demon action first."
		winshow(src, "DemonSummonWindow", FALSE)
		return

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
		if(SagaLevel >= 4)
			RemoveDemonRacialPassive()
		ClearDemonSkillHUD()
		var/mob/Player/AI/Demon/old = demon_active
		if(old)
			// Save HP back to party before switching
			for(var/datum/party_demon/old_pd in demon_party)
				if(old_pd.demon_name == old.name)
					old_pd.current_hp = old.demon_hp
					break
			old.ai_owner = null // Stop AI loop immediately
			animate(old, alpha=0, time=8)
			spawn(8) del(old)
		ai_followers -= demon_active
		demon_active = null
		demon_active_name = ""

	var/datum/demon_data/dd = DEMON_DB[demon_name]
	if(!dd) return

	if(!pd.demon_skills || !pd.demon_skills.len)
		pd.demon_skills = dd.demon_skills.Copy()
	if(!pd.skill_cooldowns)
		pd.skill_cooldowns = list()

	var/mob/Player/AI/Demon/d = new
	ticking_ai.Remove(d)
	d.alpha = 0
	d.loc = locate(src.x, src.y, src.z)
	animate(d, alpha=255, time=10)
	d.DemonInit(dd, src, pd)
	d.demon_hp = pd.current_hp  // restore HP

	demon_active      = d
	demon_active_name = demon_name

	src << "You summon <b>[demon_name]</b>!"
	demon_summon_cooldown = world.time + 600  // 60s

	// Tier 4+ racial passive
	if(SagaLevel >= 4 && dd.demon_race)
		ApplyDemonRacialPassive(dd.demon_race)

	BuildDemonSkillHUD(pd)

/mob/proc/DemonUnsummon()
	if(!demon_active) return
	if(SagaLevel >= 4)
		RemoveDemonRacialPassive()
	ClearDemonSkillHUD()
	var/mob/Player/AI/Demon/d = demon_active
	if(d)
		for(var/datum/party_demon/pd in demon_party)
			if(pd.demon_name == demon_active_name)
				pd.current_hp = d.demon_hp
				break
		d.ai_owner = null // Stop AI loop immediately
		animate(d, alpha=0, time=8)
		spawn(8)
			ai_followers -= d
			del(d)
	demon_active      = null
	demon_active_name = ""
	src << "You unsummon your demon."
	demon_summon_cooldown = world.time + 600  // 60s


/mob/proc/ExecuteFusion(name_a, name_b)
	if(DemonUIBusy())
		return

	var/datum/party_demon/pd_a = null
	var/datum/party_demon/pd_b = null
	for(var/datum/party_demon/pd in demon_party)
		if(pd.demon_name == name_a) pd_a = pd
		if(pd.demon_name == name_b) pd_b = pd
	if(!pd_a || !pd_b)
		src << "One or both demons are no longer in your party."
		return

	if(pd_a.current_hp <= 0)
		src << "<b>[name_a]</b> is defeated. Meditate to restore them before fusing."
		return
	if(pd_b.current_hp <= 0)
		src << "<b>[name_b]</b> is defeated. Meditate to restore them before fusing."
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

	if(DemonInParty(result_name))
		src << "[result_name] is already in your party. You cannot have duplicates."
		return

	var/confirm = alert(src, "Fuse [name_a] and [name_b] to create [result_name]? Both original demons will be lost.", "Confirm Fusion", "Fuse", "Cancel")
	if(confirm != "Fuse") return

	if(!DemonInParty(name_a) || !DemonInParty(name_b)) return

	var/datum/demon_data/result_dd = DEMON_DB[result_name]
	if(!result_dd)
		src << "Error: result demon [result_name] not found in database."
		return

	// Check if skill inheritance is possible
	var/list/base_skills = result_dd.demon_skills.Copy()
	var/open_slots = 4 - base_skills.len

	pd_a = null
	pd_b = null
	for(var/datum/party_demon/pd in demon_party)
		if(pd.demon_name == name_a) pd_a = pd
		if(pd.demon_name == name_b) pd_b = pd
	if(!pd_a || !pd_b) return

	if(open_slots > 0)
		var/list/parent_pool = list()
		if(pd_a.demon_skills)
			for(var/s in pd_a.demon_skills)
				if(s && s != "None" && !(s in base_skills) && !(s in parent_pool))
					parent_pool += s
		if(pd_b.demon_skills)
			for(var/s in pd_b.demon_skills)
				if(s && s != "None" && !(s in base_skills) && !(s in parent_pool))
					parent_pool += s

		if(parent_pool.len > 0)
			// Show skill inheritance UI - fusion completes from Topic handler
			demon_pending_fuse_a = name_a
			demon_pending_fuse_b = name_b
			demon_pending_fuse_result = result_name
			demon_pending_fuse_base_skills = base_skills
			demon_pending_fuse_pool = parent_pool
			demon_pending_fuse_open_slots = open_slots
			ShowSkillInheritanceUI(result_name, base_skills, parent_pool, open_slots)
			return

	// No inheritance needed
	FinishFusion(name_a, name_b, result_name, list())

/mob/proc/FinishFusion(name_a, name_b, result_name, list/inherited_skills)
	if(!DemonInParty(name_a) || !DemonInParty(name_b))
		src << "<font color='#ff6666'>Fusion cancelled: one or both ingredients are no longer in your party.</font>"
		demon_pending_fuse_a = ""
		demon_pending_fuse_b = ""
		demon_pending_fuse_result = ""
		demon_pending_fuse_base_skills = null
		demon_pending_fuse_pool = null
		demon_pending_fuse_open_slots = 0
		demon_inherit_open = FALSE
		return

	if(DemonInParty(result_name))
		src << "<font color='#ff6666'>Fusion cancelled: [result_name] is already in your party.</font>"
		demon_pending_fuse_a = ""
		demon_pending_fuse_b = ""
		demon_pending_fuse_result = ""
		demon_pending_fuse_base_skills = null
		demon_pending_fuse_pool = null
		demon_pending_fuse_open_slots = 0
		demon_inherit_open = FALSE
		return

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
	result_pd.party_level = result_dd.demon_lvl
	result_pd.current_hp  = 100
	result_pd.demon_skills = result_dd.demon_skills.Copy()
	if(inherited_skills && inherited_skills.len)
		for(var/s in inherited_skills)
			if(result_pd.demon_skills.len < 4 && !(s in result_pd.demon_skills))
				result_pd.demon_skills += s
	result_pd.skill_cooldowns = list()
	demon_party += result_pd

	src << "<b>Fusion successful!</b> [name_a] and [name_b] combined into <b>[result_name]</b>!"
	if(inherited_skills && inherited_skills.len)
		src << "<i>[result_name] inherited: [jointext(inherited_skills, ", ")]</i>"

	// Close fusion window and reopen it
	src << browse(null, "window=DemonFusion")
	demon_fusion_open = FALSE
	src << browse(null, "window=DemonInherit")
	demon_inherit_open = FALSE
	if(demon_party.len >= 2) OpenFusionUI()

// Element fusion path
/mob/proc/ExecuteElementFusion(name_a, name_b, encoded_result)
	var/parts = splittext(encoded_result, "_")
	var/element_race = parts[3]
	var/shift_up = (element_race == "Aquans" || element_race == "Aeros")
	var/target_demon = name_a

	for(var/datum/party_demon/pd in demon_party)
		if(pd.demon_name == name_a && pd.current_hp <= 0)
			src << "<b>[name_a]</b> is defeated. Meditate to restore them before fusing."
			return
		if(pd.demon_name == name_b && pd.current_hp <= 0)
			src << "<b>[name_b]</b> is defeated. Meditate to restore them before fusing."
			return

	var/result_name = GetElementFusionResult(element_race, target_demon, shift_up)
	if(!result_name)
		src << "No valid Element fusion result found."
		return

	// Duplicate check
	if(DemonInParty(result_name))
		src << "[result_name] is already in your party. You cannot have duplicates."
		return

	var/confirm = alert(src, "Element Fusion: [target_demon] -> [result_name]? [name_b] (the element) will be consumed.", "Confirm Fusion", "Fuse", "Cancel")
	if(confirm != "Fuse") return

	// Re-validate
	if(!DemonInParty(name_a) || !DemonInParty(name_b)) return

	// Get the non-element demon's skills for inheritance
	var/datum/party_demon/pd_target = null
	for(var/datum/party_demon/pd in demon_party)
		if(pd.demon_name == name_a) pd_target = pd

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
	result_pd.demon_skills = result_dd.demon_skills.Copy()
	// Carry over non-element parent's inherited skills to open slots
	if(pd_target && pd_target.demon_skills)
		for(var/s in pd_target.demon_skills)
			if(result_pd.demon_skills.len >= 4) break
			if(s && s != "None" && !(s in result_pd.demon_skills))
				result_pd.demon_skills += s
	result_pd.skill_cooldowns = list()
	demon_party += result_pd

	src << "<b>Element Fusion!</b> [name_a] became <b>[result_name]</b>!"
	src << browse(null, "window=DemonFusion")
	demon_fusion_open = FALSE


/mob/proc/ExecuteWithdraw(demon_name, level_choice)
	if(DemonUIBusy())
		src << "Complete or cancel your current Demon action first."
		return
	if(!demon_compendium || !(demon_name in demon_compendium)) return
	var/datum/compendium_demon/cd = demon_compendium[demon_name]
	var/datum/demon_data/dd = DEMON_DB[demon_name]
	if(!dd) return

	// Duplicate check
	if(DemonInParty(demon_name))
		src << "[demon_name] is already in your party."
		return

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
	// Set skills based on withdrawal type
	if(level_choice == "recorded" && cd.recorded_skills && cd.recorded_skills.len)
		pd.demon_skills = cd.recorded_skills.Copy()
	else
		pd.demon_skills = dd.demon_skills.Copy()
	pd.skill_cooldowns = list()
	demon_party += pd

	src << "[demon_name] added to your party at level [chosen_level]."
	src << browse(null, "window=DemonWithdraw")
	demon_withdraw_open = FALSE
	OpenCompendiumUI()


/mob/proc/ExecuteRecordDemon(demon_name)
	var/datum/party_demon/pd = null
	for(var/datum/party_demon/p in demon_party)
		if(p.demon_name == demon_name) { pd = p; break }
	if(!pd) return

	var/datum/demon_data/dd = DEMON_DB[demon_name]
	if(!dd) return

	if(!demon_compendium) demon_compendium = list()

	// Overwrite confirmation if already recorded
	if(demon_name in demon_compendium)
		var/confirm = alert(src, "[demon_name] is already recorded. Overwrite the recorded version?", "Confirm Overwrite", "Overwrite", "Cancel")
		if(confirm != "Overwrite")
			demon_record_open = FALSE
			return

	var/datum/compendium_demon/cd
	if(demon_name in demon_compendium)
		cd = demon_compendium[demon_name]
	else
		cd = new /datum/compendium_demon()
		cd.demon_name = demon_name
		cd.base_level = dd.demon_lvl

	// Recorded level = scaled level based on player Potential
	cd.recorded_level = max(dd.demon_lvl, round(dd.demon_lvl * (max(1, Potential) / 100)))
	// Snapshot current skills
	if(pd.demon_skills && pd.demon_skills.len)
		cd.recorded_skills = pd.demon_skills.Copy()
	else
		cd.recorded_skills = dd.demon_skills.Copy()
	demon_compendium[demon_name] = cd

	src << "<b>[demon_name]</b> has been recorded in your compendium."
	if(cd.recorded_level > cd.base_level)
		src << "Recorded at Level [cd.recorded_level] (base: [cd.base_level]). Higher withdrawal costs Mana Bits."
	if(cd.recorded_skills.len > dd.demon_skills.len)
		src << "Skills recorded: [jointext(cd.recorded_skills, ", ")]"
	src << browse(null, "window=DemonRecord")
	demon_record_open = FALSE


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

	// Duplicate check
	if(DemonInParty(dname))
		src << "<b>[dname]</b> is already in your party."
		return

	if(demon_party.len < demon_party_cap)
		var/datum/party_demon/pd = new /datum/party_demon()
		pd.demon_name  = dname
		pd.party_level = dd.demon_lvl
		pd.current_hp  = 100
		pd.demon_skills = dd.demon_skills.Copy()
		pd.skill_cooldowns = list()
		demon_party += pd
		src << "<b>[dname]</b> has joined your party."
	else
		if(!(dname in demon_compendium))
			var/datum/compendium_demon/cd = new /datum/compendium_demon()
			cd.demon_name     = dname
			cd.base_level     = dd.demon_lvl
			cd.recorded_level = dd.demon_lvl
			cd.recorded_skills = dd.demon_skills.Copy()
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
		// Also remove demons already in party
		for(var/datum/party_demon/pd in demon_party)
			options -= pd.demon_name
		if(!options.len) break

		var/choice = input(src, "Choose demon [n] of 2:", "Starter Demon -- Tier [tier]") as null|anything in options
		if(!choice) break
		picked.Add(choice)

	for(var/dname in picked)
		AddDemonToRoster(dname)
