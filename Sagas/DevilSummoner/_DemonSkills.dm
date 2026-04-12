/obj/Skills/Buffs/SlotlessBuffs/Autonomous/DemonDebuffResist
	BuffName = "Demon Ward"
	TimerLimit = 60
	AlwaysOn = 0
	NeedsPassword = 0
	passives = list("DebuffResistance" = 2)

/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/DemonSilence
	BuffName = "Demon Silence"
	TimerLimit = 5
	AlwaysOn = 0
	NeedsPassword = 0
	passives = list("Silenced" = 1)

/datum/demon_skill_vfx
	var/icon_file = null
	var/icon_state = ""
	var/effect_x = 0
	var/effect_y = 0
	var/effect_size = 1
	var/effect_life = 5

	New(file, state = "", x = 0, y = 0, size = 1, life = 5)
		icon_file = file
		icon_state = state
		effect_x = x
		effect_y = y
		effect_size = size
		effect_life = life

var/global/list/DEMON_SKILL_VFX = list()

/proc/InitDemonSkillVFX()
	// Build into a local list and assign at the end — BYOND 516 has a quirk where
	// `DEMON_SKILL_VFX = list()` followed immediately by `DEMON_SKILL_VFX[k] = v`
	// fails with "bad index" because the new list doesn't materialize in time.
	var/list/vfx_db = list()

	// ===== FIRE =====   (Fire VFX1/6/7/10/3 = 128x128 frame → -48,-48 | Fire VFX2 = 192x128 → -80,-48)
	vfx_db["Agi"]          = new /datum/demon_skill_vfx('Icons/Effects/Fire VFX1.dmi',  "", -48, -48, 1,   5)
	vfx_db["Agidyne"]      = new /datum/demon_skill_vfx('Icons/Effects/Fire VFX6.dmi',  "", -48, -48, 1.5, 5)
	vfx_db["Inferno"]      = new /datum/demon_skill_vfx('Icons/Effects/Fire VFX7.dmi',  "", -48, -48, 2,   6)
	vfx_db["Maragi"]       = new /datum/demon_skill_vfx('Icons/Effects/Fire VFX10.dmi', "", -48, -48, 1,   5)
	vfx_db["Maragidyne"]   = new /datum/demon_skill_vfx('Icons/Effects/Fire VFX3.dmi',  "", -48, -48, 1.5, 5)
	vfx_db["Fire Dance"]   = new /datum/demon_skill_vfx('Icons/Effects/Fire VFX2.dmi',  "", -80, -48, 1,   4)

	// ===== ICE =====   (VFX1/5/6/Knight6 = 128x128 → -48,-48 | Frost Mage VFX7 = 256x128 → -112,-48)
	vfx_db["Bufu"]         = new /datum/demon_skill_vfx('Icons/Effects/Frost Mage VFX1.dmi',   "", -48,  -48, 1,   5)
	vfx_db["Bufudyne"]     = new /datum/demon_skill_vfx('Icons/Effects/Frost Mage VFX5.dmi',   "", -48,  -48, 1.5, 5)
	vfx_db["Mabufu"]       = new /datum/demon_skill_vfx('Icons/Effects/Frost Mage VFX7.dmi',   "", -112, -48, 1,   5)
	vfx_db["Mabufudyne"]   = new /datum/demon_skill_vfx('Icons/Effects/Frost Mage VFX6.dmi',   "", -48,  -48, 1.5, 5)
	vfx_db["Ice Dance"]    = new /datum/demon_skill_vfx('Icons/Effects/Frost Knight VFX6.dmi', "", -48,  -48, 1,   4)

	// ===== ELEC =====   (VFX4/3 = 128x256 → -48,-112 | VFX6/5 = 128x128 → -48,-48)
	vfx_db["Zio"]          = new /datum/demon_skill_vfx('Icons/Effects/Lightning VFX4.dmi', "", -48, -112, 1,   5)
	vfx_db["Ziodyne"]      = new /datum/demon_skill_vfx('Icons/Effects/Lightning VFX3.dmi', "", -48, -112, 1.5, 5)
	vfx_db["Mazio"]        = new /datum/demon_skill_vfx('Icons/Effects/Lightning VFX6.dmi', "", -48,  -48, 1,   5)
	vfx_db["Maziodyne"]    = new /datum/demon_skill_vfx('Icons/Effects/Lightning VFX5.dmi', "", -48,  -48, 1.5, 5)
	vfx_db["Elec Dance"]   = new /datum/demon_skill_vfx('Icons/Effects/Lightning VFX3.dmi', "", -48, -112, 1,   4)

	// ===== FORCE =====   (Hit Effect Wind = 96x96 → -32,-32)
	vfx_db["Zan"]          = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Wind.dmi', "", -32, -32, 1,   5)
	vfx_db["Zandyne"]      = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Wind.dmi', "", -32, -32, 1.5, 5)
	vfx_db["Mazan"]        = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Wind.dmi', "", -32, -32, 1,   5)
	vfx_db["Mazandyne"]    = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Wind.dmi', "", -32, -32, 1.5, 5)
	vfx_db["Force Dance"]  = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Wind.dmi', "", -32, -32, 1,   4)

	// ===== ALMIGHTY =====   (all Priest VFX = 128x128 → -48,-48)
	vfx_db["Holy Strike"]  = new /datum/demon_skill_vfx('Icons/Effects/Priest VFX4.dmi', "", -48, -48, 1.5, 5)
	vfx_db["Megido"]       = new /datum/demon_skill_vfx('Icons/Effects/Priest VFX3.dmi', "", -48, -48, 1,   5)
	vfx_db["Megidolaon"]   = new /datum/demon_skill_vfx('Icons/Effects/Priest VFX2.dmi', "", -48, -48, 1.5, 6)
	vfx_db["Judgement"]    = new /datum/demon_skill_vfx('Icons/Effects/Priest VFX5.dmi', "", -48, -48, 2,   6)
	vfx_db["Holy Dance"]   = new /datum/demon_skill_vfx('Icons/Effects/Priest VFX8.dmi', "", -48, -48, 1,   4)

	// ===== PHYSICAL =====
	// Impacts VFX4 = 64x64 → -16,-16
	// Warrior VFX1/2/3/4/5 = 128x128 → -48,-48
	// Blood Knight VFX1 = 192x128 → -80,-48 | VFX3 = 128x128 → -48,-48
	// Warrior VFX6 = 192x128 → -80,-48
	vfx_db["Power Hit"]    = new /datum/demon_skill_vfx('Icons/Effects/Impacts VFX4.dmi',       "", -16, -16, 1,   4)
	vfx_db["Mighty Hit"]   = new /datum/demon_skill_vfx('Icons/Effects/Impacts VFX4.dmi',       "", -16, -16, 1.5, 4)
	vfx_db["Brutal Hit"]   = new /datum/demon_skill_vfx('Icons/Effects/Warrior VFX5.dmi',       "", -48, -48, 2,   5)
	vfx_db["Anger Hit"]    = new /datum/demon_skill_vfx('Icons/Effects/Impacts VFX4.dmi',       "", -16, -16, 1,   5)
	vfx_db["Piercing Hit"] = new /datum/demon_skill_vfx('Icons/Effects/Warrior VFX2.dmi',       "", -48, -48, 1,   4)
	vfx_db["Fatal Strike"] = new /datum/demon_skill_vfx('Icons/Effects/Blood Knight VFX1.dmi',  "", -80, -48, 1.5, 4)
	vfx_db["Assassinate"]  = new /datum/demon_skill_vfx('Icons/Effects/Blood Knight VFX3.dmi',  "", -48, -48, 1.5, 5)
	vfx_db["Desperation"]  = new /datum/demon_skill_vfx('Icons/Effects/Warrior VFX6.dmi',       "", -80, -48, 2,   6)
	vfx_db["Multi-Strike"] = new /datum/demon_skill_vfx('Icons/Effects/Warrior VFX1.dmi',       "", -48, -48, 1,   4)
	vfx_db["Deathbound"]   = new /datum/demon_skill_vfx('Icons/Effects/Warrior VFX1.dmi',       "", -48, -48, 1.5, 5)
	vfx_db["Mow Down"]     = new /datum/demon_skill_vfx('Icons/Effects/Warrior VFX4.dmi',       "", -48, -48, 1.5, 5)
	vfx_db["Hassohappa"]   = new /datum/demon_skill_vfx('Icons/Effects/Warrior VFX1.dmi',       "", -48, -48, 1.5, 4)
	vfx_db["Berserk"]      = new /datum/demon_skill_vfx('Icons/Effects/Warrior VFX4.dmi',       "", -48, -48, 1,   5)

	// ===== DRAIN =====   (Warlock VFX3/8 = 128x128 → -48,-48)
	vfx_db["Drain"]        = new /datum/demon_skill_vfx('Icons/Effects/Warlock VFX3.dmi', "", -48, -48, 1,   5)
	vfx_db["Life Drain"]   = new /datum/demon_skill_vfx('Icons/Effects/Warlock VFX8.dmi', "", -48, -48, 1.5, 5)

	// ===== HEALING =====   (all Paladin VFX1 = 128x128 → -48,-48)
	vfx_db["Dia"]          = new /datum/demon_skill_vfx('Icons/Effects/Paladin VFX1.dmi', "", -48, -48, 1,   5)
	vfx_db["Diarama"]      = new /datum/demon_skill_vfx('Icons/Effects/Paladin VFX1.dmi', "", -48, -48, 1.5, 5)
	vfx_db["Diarahan"]     = new /datum/demon_skill_vfx('Icons/Effects/Paladin VFX1.dmi', "", -48, -48, 2,   5)
	vfx_db["Media"]        = new /datum/demon_skill_vfx('Icons/Effects/Paladin VFX1.dmi', "", -48, -48, 1.5, 5)
	vfx_db["Mediarahan"]   = new /datum/demon_skill_vfx('Icons/Effects/Paladin VFX1.dmi', "", -48, -48, 2,   5)
	vfx_db["Prayer"]       = new /datum/demon_skill_vfx('Icons/Effects/Paladin VFX1.dmi', "", -48, -48, 2,   6)

	// ===== REVIVAL =====
	vfx_db["Recarm"]       = new /datum/demon_skill_vfx('Icons/Effects/Paladin VFX1.dmi', "", -48, -48, 1.5, 5)
	vfx_db["Samarecarm"]   = new /datum/demon_skill_vfx('Icons/Effects/Paladin VFX1.dmi', "", -48, -48, 2,   6)
	vfx_db["Recarmloss"]   = new /datum/demon_skill_vfx('Icons/Effects/Paladin VFX1.dmi', "", -48, -48, 1.5, 5)

	// ===== SUPPORT =====   (Priest VFX2 = 128x128 → -48,-48)
	vfx_db["Amrita"]       = new /datum/demon_skill_vfx('Icons/Effects/Paladin VFX1.dmi', "", -48, -48, 1.5, 5)
	vfx_db["Nigayomogi"]   = new /datum/demon_skill_vfx('Icons/Effects/Paladin VFX1.dmi', "", -48, -48, 2,   6)
	vfx_db["Shield All"]   = new /datum/demon_skill_vfx('Icons/Effects/Paladin VFX1.dmi', "", -48, -48, 1.5, 5)
	vfx_db["Power Charge"] = new /datum/demon_skill_vfx('Icons/Effects/Priest VFX2.dmi',  "", -48, -48, 1.5, 5)
	vfx_db["Death Call"]   = new /datum/demon_skill_vfx('Icons/Effects/Priest VFX2.dmi',  "", -48, -48, 1,   5)
	vfx_db["Might Call"]   = new /datum/demon_skill_vfx('Icons/Effects/Priest VFX2.dmi',  "", -48, -48, 1,   5)
	vfx_db["Taunt"]        = new /datum/demon_skill_vfx('Icons/Effects/Priest VFX2.dmi',  "", -48, -48, 1.5, 5)
	vfx_db["Makarakarn"]   = new /datum/demon_skill_vfx('Icons/Effects/Priest VFX2.dmi',  "", -48, -48, 1.5, 5)
	vfx_db["Tetrakarn"]    = new /datum/demon_skill_vfx('Icons/Effects/Priest VFX2.dmi',  "", -48, -48, 1.5, 5)
	vfx_db["Extra Cancel"] = new /datum/demon_skill_vfx('Icons/Effects/Priest VFX2.dmi',  "", -48, -48, 1,   5)

	// ===== STATUS =====   (Mystic Eyes = 48x48 → -8,-8 | Warrior VFX3/5 = 128x128 → -48,-48)
	vfx_db["Marin Karin"]  = new /datum/demon_skill_vfx('Icons/Effects/Mystic Eyes Activation.dmi', "",  -8,  -8, 1,   5)
	vfx_db["Gigajama"]     = new /datum/demon_skill_vfx('Icons/Effects/Mystic Eyes Activation.dmi', "",  -8,  -8, 1.5, 5)
	vfx_db["Sexy Gaze"]    = new /datum/demon_skill_vfx('Icons/Effects/Mystic Eyes Activation.dmi', "",  -8,  -8, 1,   5)
	vfx_db["Paral Eyes"]   = new /datum/demon_skill_vfx('Icons/Effects/Mystic Eyes Activation.dmi', "",  -8,  -8, 1,   5)
	vfx_db["Petra Eyes"]   = new /datum/demon_skill_vfx('Icons/Effects/Mystic Eyes Activation.dmi', "",  -8,  -8, 1,   5)
	vfx_db["Weak Kill"]    = new /datum/demon_skill_vfx('Icons/Effects/Warrior VFX3.dmi',           "", -48, -48, 1.5, 5)
	vfx_db["Snipe"]        = new /datum/demon_skill_vfx('Icons/Effects/Warrior VFX5.dmi',           "", -48, -48, 1.5, 4)
	vfx_db["Multi-Hit"]    = new /datum/demon_skill_vfx('Icons/Effects/Warrior VFX1.dmi',           "", -48, -48, 1,   4)

	DEMON_SKILL_VFX = vfx_db

/mob/Player/AI/Demon

	var/list/active_skills = list()
	var/current_skill = ""           // tracks skill being used (for VFX lookup)

	proc/DemonSpawnVFX(mob/on_target)
		if(!on_target) return
		var/datum/demon_skill_vfx/vfx = DEMON_SKILL_VFX[current_skill]
		if(!vfx || !vfx.icon_file) return
		var/obj/E = new(on_target.loc)
		E.icon = vfx.icon_file
		if(vfx.icon_state) E.icon_state = vfx.icon_state
		E.pixel_x = vfx.effect_x
		E.pixel_y = vfx.effect_y
		E.layer = EFFECTS_LAYER
		if(vfx.effect_size != 1)
			var/matrix/M = matrix()
			M.Scale(vfx.effect_size, vfx.effect_size)
			E.transform = M
		spawn(vfx.effect_life)
			if(E) del(E)

	proc/DemonGetPartyDemon()
		if(!ai_owner || !ai_owner.demon_party) return null
		for(var/datum/party_demon/pd in ai_owner.demon_party)
			if(pd.demon_name == name) return pd
		return null


	proc/DemonUseSkill(mob/target)
		if(!active_skills || !active_skills.len) return FALSE
		var/list/shuffled = active_skills.Copy()
		for(var/i = shuffled.len, i > 1, i--)
			var/j = rand(1, i)
			shuffled.Swap(i, j)
		for(var/skill in shuffled)
			if(!skill || skill == "None") continue
			if(DemonSkillOnCooldown(skill)) continue
			if(DemonTrySkill(target, skill))
				DemonSetCooldown(skill)
				DemonAnnounce(skill)
				if(ai_owner) ai_owner.UpdateDemonSkillHUD()
				return TRUE
		return FALSE

	proc/DemonUseSkillManual(skill_name)
		if(!skill_name || skill_name == "None") return FALSE
		if(DemonSkillOnCooldown(skill_name))
			if(ai_owner) ai_owner << "<font color='#ff6666'>[skill_name] is on cooldown.</font>"
			return FALSE
		var/mob/target = null
		if(ai_owner) target = ai_owner.Target
		if(DemonTrySkill(target, skill_name))
			DemonSetCooldown(skill_name)
			DemonAnnounce(skill_name)
			if(ai_owner) ai_owner.UpdateDemonSkillHUD()
			return TRUE
		return FALSE

	proc/DemonSkillOnCooldown(skill_name)
		var/datum/party_demon/pd = DemonGetPartyDemon()
		if(!pd || !pd.skill_cooldowns) return FALSE
		if(!(skill_name in pd.skill_cooldowns)) return FALSE
		return world.time < pd.skill_cooldowns[skill_name]

	proc/DemonSetCooldown(skill_name)
		var/datum/party_demon/pd = DemonGetPartyDemon()
		if(!pd) return
		if(!pd.skill_cooldowns) pd.skill_cooldowns = list()
		pd.skill_cooldowns[skill_name] = world.time + DemonGetSkillCooldown(skill_name)

	proc/DemonGetSkillCooldown(skill_name)
		// Base 60 seconds (600 ticks), reduced by demon speed stat (max 50% reduction)
		var/base_cd = 600
		var/spd = 0
		if(demon_data) spd = demon_data.demon_spd
		var/reduction = min(0.5, spd / 60)
		return round(base_cd * (1 - reduction))

	proc/DemonTrySkill(mob/target, skill_name)
		current_skill = skill_name
		switch(skill_name)
			if("Agi")
				return DemonSingleDamage(target, ForMod * 0.3, "Fire", 3)
			if("Agidyne")
				return DemonSingleDamage(target, ForMod * 0.6, "Fire", 6)
			if("Inferno")
				return DemonSingleDamage(target, ForMod * 0.9, "Fire", 8)
			if("Maragi")
				return DemonAoeDamage(target, 5, ForMod * 0.15, "Fire", 2)
			if("Maragidyne")
				return DemonAoeDamage(target, 5, ForMod * 0.35, "Fire", 5)
			if("Fire Dance")
				return DemonDanceSkill(target, ForMod * 0.12, "Fire", 2, 3, 6)
			if("Bufu")
				return DemonSingleDamage(target, ForMod * 0.3, "Ice", 3)
			if("Bufudyne")
				return DemonSingleDamage(target, ForMod * 0.6, "Ice", 6)
			if("Mabufu")
				return DemonAoeDamage(target, 5, ForMod * 0.15, "Ice", 2)
			if("Mabufudyne")
				return DemonAoeDamage(target, 5, ForMod * 0.35, "Ice", 5)
			if("Ice Dance")
				return DemonDanceSkill(target, ForMod * 0.12, "Ice", 2, 3, 6)
			if("Zio")
				return DemonSingleDamage(target, ForMod * 0.3, "Elec", 3)
			if("Ziodyne")
				return DemonSingleDamage(target, ForMod * 0.6, "Elec", 6)
			if("Mazio")
				return DemonAoeDamage(target, 5, ForMod * 0.15, "Elec", 2)
			if("Maziodyne")
				return DemonAoeDamage(target, 5, ForMod * 0.35, "Elec", 5)
			if("Elec Dance")
				return DemonDanceSkill(target, ForMod * 0.12, "Elec", 2, 3, 6)
			if("Zan")
				return DemonSingleDamage(target, ForMod * 0.3, "Force", 3)
			if("Zandyne")
				return DemonSingleDamage(target, ForMod * 0.6, "Force", 6)
			if("Mazan")
				return DemonAoeDamage(target, 5, ForMod * 0.15, "Force", 2)
			if("Mazandyne")
				return DemonAoeDamage(target, 5, ForMod * 0.35, "Force", 5)
			if("Force Dance")
				return DemonDanceSkill(target, ForMod * 0.12, "Force", 2, 3, 6)
			if("Holy Strike")
				return DemonSingleDamage(target, ForMod * 0.55, "Almighty", 2)
			if("Megido")
				return DemonAoeDamage(target, 5, ForMod * 0.25, "Almighty", 1)
			if("Megidolaon")
				return DemonAoeDamage(target, 5, ForMod * 0.45, "Almighty", 2)
			if("Judgement")
				return DemonAoeDamage(target, 6, ForMod * 0.6, "Almighty", 3)
			if("Holy Dance")
				return DemonDanceSkill(target, ForMod * 0.1, "Almighty", 1, 3, 6)
			if("Power Hit")
				return DemonPhysDamage(target, StrMod * 0.25)
			if("Mighty Hit")
				return DemonPhysDamage(target, StrMod * 0.45)
			if("Brutal Hit")
				return DemonPhysDamage(target, StrMod * 0.65)
			if("Anger Hit")
				if(DemonValidTarget(target))
					var/hp_ratio = max(0.1, demon_hp / 100)
					return DemonPhysDamage(target, StrMod * 0.3 * (2 - hp_ratio))
				return FALSE
			if("Piercing Hit")
				return DemonPhysDamage(target, StrMod * 0.55)
			if("Fatal Strike")
				if(DemonValidTarget(target))
					var/dmg = StrMod * 0.4
					if(prob(25))
						dmg *= 2
						if(ai_owner) ai_owner << "<font color='#ff4444'>[name] lands a critical blow!</font>"
					return DemonPhysDamage(target, dmg)
				return FALSE
			if("Assassinate")
				if(DemonValidTarget(target))
					var/dmg = StrMod * 0.4
					if(prob(15))
						dmg *= 10
						if(ai_owner) ai_owner << "<font color='#ff0000'>[name] strikes a lethal blow!</font>"
					return DemonPhysDamage(target, dmg)
				return FALSE
			if("Desperation")
				return DemonDesperation(target)
			if("Multi-Strike")
				return DemonPhysMultiHit(target, StrMod * 0.1, 2, 5)
			if("Deathbound")
				return DemonPhysAoe(target, 5, StrMod * 0.2)
			if("Mow Down")
				return DemonPhysAoe(target, 5, StrMod * 0.15)
			if("Hassohappa")
				return DemonPhysAoeMultiHit(target, 5, StrMod * 0.15, 1, 3)
			if("Drain")
				return DemonDrain(target, ForMod * 0.3, FALSE)
			if("Life Drain")
				return DemonDrain(target, ForMod * 0.45, TRUE)
			if("Dia")
				return DemonHealRandom(30)
			if("Diarama")
				return DemonHealRandom(60)
			if("Diarahan")
				return DemonHealRandom(100)
			if("Media")
				return DemonHealAll(25)
			if("Mediarahan")
				return DemonHealAll(100)
			if("Prayer")
				return DemonPrayer()
			if("Recarm")
				return DemonRevive(50)
			if("Samarecarm")
				return DemonRevive(100)
			if("Recarmloss")
				return DemonRecarmloss()
			if("Amrita")
				return DemonAmrita(FALSE)
			if("Nigayomogi")
				return DemonAmrita(TRUE)
			if("Shield All")
				return DemonShieldAll()
			if("Power Charge")
				return DemonPowerCharge()
			if("Berserk")
				return DemonBerserk(target)
			if("Death Call")
				return DemonStrBuff(1.3)
			if("Might Call")
				return DemonStrBuff(1.2)
			if("Taunt")
				return DemonTaunt()
			if("Makarakarn")
				return DemonReflect()
			if("Tetrakarn")
				return DemonReflect()
			if("Extra Cancel")
				return DemonExtraCancel()
			if("Marin Karin")
				return DemonMarinKarin(target)
			if("Gigajama")
				return DemonGigajama(target)
			if("Sexy Gaze")
				return DemonMarinKarin(target)
			if("Paral Eyes")
				return DemonParalyze(target)
			if("Petra Eyes")
				return DemonStone(target)
			if("Weak Kill")
				return DemonWeakKill(target)
			if("Snipe")
				return DemonPhysDamage(target, StrMod * 0.5)
			if("Multi-Hit")
				return DemonPhysMultiHit(target, StrMod * 0.12, 2, 4)
		return FALSE

	proc/DemonValidTarget(mob/target)
		if(!target) return FALSE
		if(ai_owner && target == ai_owner) return FALSE
		if(get_dist(src, target) > 15) return FALSE
		if(ai_owner && istype(target, /mob/Player) && "[ai_owner.ckey]" in target.ai_alliances) return FALSE
		if(ai_owner && ai_owner.party && ai_owner.party.members && (target in ai_owner.party.members)) return FALSE
		return TRUE

	proc/DemonAnnounce(skill_name)
		if(ai_owner) ai_owner << "<font color='#aa88ff'>[name] used [skill_name]!</font>"

	proc/DemonFlash(mob/target, element)
		var/flash_color = "#ffffff"
		switch(element)
			if("Fire") flash_color = "#ff2643"
			if("Ice") flash_color = "#578cff"
			if("Elec") flash_color = "#fff757"
			if("Force") flash_color = "#8f7946"
			if("Almighty") flash_color = "#ffffff"
		animate(target, color = flash_color)
		animate(target, color = target.MobColor, time = 5)

	proc/DemonApplyDebuff(mob/target, element, val)
		switch(element)
			if("Fire")
				target.AddBurn(val, src)
			if("Ice")
				target.AddSlow(val, src)
			if("Elec")
				target.AddShock(val, src)
			if("Force")
				target.AddShatter(val, src)
			if("Almighty")
				target.AddBurn(val, src)
				target.AddSlow(val, src)
				target.AddShatter(val, src)
				target.AddShock(val, src)
				target.AddPoison(val, src)
				target.AddCrippling(val, src)

	proc/DemonGetAoeTargets(mob/center, radius)
		var/list/targets = list()
		if(center) targets += center
		for(var/mob/m in range(radius, center))
			if(m == src) continue
			if(m == center) continue
			if(ai_owner && m == ai_owner) continue
			if(ai_owner && istype(m, /mob/Player) && "[ai_owner.ckey]" in m.ai_alliances) continue
			if(ai_owner && ai_owner.party && ai_owner.party.members && (m in ai_owner.party.members)) continue
			targets += m
		return targets

	proc/DemonSingleDamage(mob/target, dmg, element, debuff_val)
		if(!DemonValidTarget(target)) return FALSE
		var/final_dmg = max(1, round(dmg))
		target.DoDamage(src, TrueDamage(final_dmg))
		DemonApplyDebuff(target, element, debuff_val)
		DemonFlash(target, element)
		DemonSpawnVFX(target)
		return TRUE

	proc/DemonAoeDamage(mob/target, radius, dmg, element, debuff_val)
		if(!DemonValidTarget(target)) return FALSE
		var/list/targets = DemonGetAoeTargets(target, radius)
		var/final_dmg = max(1, round(dmg))
		for(var/mob/t in targets)
			t.DoDamage(src, TrueDamage(final_dmg))
			DemonApplyDebuff(t, element, debuff_val)
			DemonFlash(t, element)
			DemonSpawnVFX(t)
		return TRUE

	proc/DemonDanceSkill(mob/target, dmg_per, element, debuff_per, min_hits, max_hits)
		if(!DemonValidTarget(target)) return FALSE
		var/hits = rand(min_hits, max_hits)
		var/final_dmg = max(1, round(dmg_per))
		spawn()
			for(var/i = 1, i <= hits, i++)
				if(!src || !target || !ai_owner) return
				if(target.z != src.z) return
				target.DoDamage(src, TrueDamage(final_dmg))
				DemonApplyDebuff(target, element, debuff_per)
				DemonFlash(target, element)
				DemonSpawnVFX(target)
				if(i < hits) sleep(8)
		return TRUE

	proc/DemonPhysDamage(mob/target, dmg)
		if(!DemonValidTarget(target)) return FALSE
		var/final_dmg = max(1, round(dmg))
		target.DoDamage(src, TrueDamage(final_dmg))
		Bump(target)
		DemonSpawnVFX(target)
		return TRUE

	proc/DemonPhysMultiHit(mob/target, dmg_per, min_hits, max_hits)
		if(!DemonValidTarget(target)) return FALSE
		var/hits = rand(min_hits, max_hits)
		var/final_dmg = max(1, round(dmg_per))
		spawn()
			for(var/i = 1, i <= hits, i++)
				if(!src || !target || !ai_owner) return
				if(target.z != src.z) return
				target.DoDamage(src, TrueDamage(final_dmg))
				Bump(target)
				DemonSpawnVFX(target)
				if(i < hits) sleep(6)
		return TRUE

	proc/DemonPhysAoe(mob/target, radius, dmg)
		if(!DemonValidTarget(target)) return FALSE
		var/list/targets = DemonGetAoeTargets(target, radius)
		var/final_dmg = max(1, round(dmg))
		for(var/mob/t in targets)
			t.DoDamage(src, TrueDamage(final_dmg))
			DemonSpawnVFX(t)
		return TRUE

	proc/DemonPhysAoeMultiHit(mob/target, radius, dmg_per, min_hits, max_hits)
		if(!DemonValidTarget(target)) return FALSE
		var/list/targets = DemonGetAoeTargets(target, radius)
		var/hits = rand(min_hits, max_hits)
		var/final_dmg = max(1, round(dmg_per))
		spawn()
			for(var/i = 1, i <= hits, i++)
				if(!src || !ai_owner) return
				for(var/mob/t in targets)
					if(!t || t.z != src.z) continue
					t.DoDamage(src, TrueDamage(final_dmg))
					DemonSpawnVFX(t)
				if(i < hits) sleep(8)
		return TRUE

	proc/DemonDesperation(mob/target)
		if(!DemonValidTarget(target)) return FALSE
		if(!ai_owner) return FALSE
		var/max_est = max(100, ai_owner.Potential * 5)
		var/missing_ratio = clamp(1 - (ai_owner.Health / max_est), 0, 1)
		var/dmg = max(1, round(StrMod * 0.5 * (1 + missing_ratio * 3)))
		target.DoDamage(src, TrueDamage(dmg))
		Bump(target)
		DemonSpawnVFX(target)
		if(ai_owner) ai_owner << "<font color='#ff4444'>[name] sacrifices itself in a desperate attack!</font>"
		demon_hp = 0
		for(var/datum/party_demon/pd in ai_owner.demon_party)
			if(pd.demon_name == name)
				pd.current_hp = 0
				break
		DemonDespawn()
		return TRUE

	proc/DemonDrain(mob/target, dmg, steal_energy)
		if(!DemonValidTarget(target)) return FALSE
		var/final_dmg = max(1, round(dmg))
		target.DoDamage(src, TrueDamage(final_dmg))
		demon_hp = min(100, demon_hp + final_dmg)
		if(ai_owner)
			for(var/datum/party_demon/pd in ai_owner.demon_party)
				if(pd.demon_name == name)
					pd.current_hp = demon_hp
					break
		if(steal_energy && ai_owner)
			var/energy_steal = max(1, round(final_dmg * 0.5))
			target.LoseEnergy(energy_steal)
			ai_owner.HealEnergy(energy_steal)
		DemonFlash(target, "Almighty")
		DemonSpawnVFX(target)
		return TRUE

	proc/DemonHealRandom(amount)
		if(!ai_owner || !ai_owner.demon_party) return FALSE
		var/list/eligible = list()
		for(var/datum/party_demon/pd in ai_owner.demon_party)
			if(pd.current_hp > 0 && pd.current_hp < 100)
				eligible += pd
		if(!length(eligible)) return FALSE
		var/datum/party_demon/chosen = pick(eligible)
		chosen.current_hp = min(100, chosen.current_hp + amount)
		if(ai_owner.demon_active)
			var/mob/Player/AI/Demon/active = ai_owner.demon_active
			if(active.name == chosen.demon_name)
				active.demon_hp = chosen.current_hp
		DemonSpawnVFX(src)
		if(ai_owner) ai_owner << "<font color='#88ff88'>[name] healed [chosen.demon_name] for [amount] HP!</font>"
		return TRUE

	proc/DemonHealAll(amount)
		if(!ai_owner || !ai_owner.demon_party) return FALSE
		var/healed_any = FALSE
		for(var/datum/party_demon/pd in ai_owner.demon_party)
			if(pd.current_hp > 0 && pd.current_hp < 100)
				pd.current_hp = min(100, pd.current_hp + amount)
				healed_any = TRUE
		if(!healed_any) return FALSE
		if(ai_owner.demon_active)
			var/mob/Player/AI/Demon/active = ai_owner.demon_active
			for(var/datum/party_demon/pd in ai_owner.demon_party)
				if(active.name == pd.demon_name)
					active.demon_hp = pd.current_hp
					break
		DemonSpawnVFX(src)
		return TRUE

	proc/DemonPrayer()
		if(!ai_owner || !ai_owner.demon_party) return FALSE
		var/healed_any = FALSE
		for(var/datum/party_demon/pd in ai_owner.demon_party)
			if(pd.current_hp > 0 && pd.current_hp < 100)
				pd.current_hp = 100
				healed_any = TRUE
		if(ai_owner.demon_active)
			var/mob/Player/AI/Demon/active = ai_owner.demon_active
			for(var/datum/party_demon/pd in ai_owner.demon_party)
				if(active.name == pd.demon_name)
					active.demon_hp = pd.current_hp
					break
		var/had_debuffs = (ai_owner.Burn > 0 || ai_owner.Slow > 0 || ai_owner.Shock > 0 || ai_owner.Shatter > 0 || ai_owner.Poison > 0)
		if(had_debuffs)
			ai_owner.CleanseDebuff(100)
		if(!healed_any && !had_debuffs) return FALSE
		DemonSpawnVFX(src)
		return TRUE

	proc/DemonRevive(hp_amount)
		if(!ai_owner || !ai_owner.demon_party) return FALSE
		var/list/dead = list()
		for(var/datum/party_demon/pd in ai_owner.demon_party)
			if(pd.current_hp <= 0)
				dead += pd
		if(!length(dead)) return FALSE
		var/datum/party_demon/chosen = pick(dead)
		chosen.current_hp = hp_amount
		DemonSpawnVFX(src)
		if(ai_owner) ai_owner << "<font color='#88ffff'>[name] revived [chosen.demon_name]!</font>"
		return TRUE

	proc/DemonRecarmloss()
		if(!ai_owner || !ai_owner.demon_party) return FALSE
		var/list/dead = list()
		for(var/datum/party_demon/pd in ai_owner.demon_party)
			if(pd.current_hp <= 0 && pd.demon_name != name)
				dead += pd
		if(!length(dead)) return FALSE
		var/datum/party_demon/chosen = pick(dead)
		chosen.current_hp = 100
		DemonSpawnVFX(src)
		if(ai_owner) ai_owner << "<font color='#ffaa00'>[name] sacrifices itself to fully revive [chosen.demon_name]!</font>"
		demon_hp = 0
		for(var/datum/party_demon/pd in ai_owner.demon_party)
			if(pd.demon_name == name)
				pd.current_hp = 0
				break
		DemonDespawn()
		return TRUE

	proc/DemonAmrita(party_wide)
		if(!ai_owner) return FALSE
		var/has_debuffs = (ai_owner.Burn > 0 || ai_owner.Slow > 0 || ai_owner.Shock > 0 || ai_owner.Shatter > 0 || ai_owner.Poison > 0)
		if(!has_debuffs) return FALSE
		ai_owner.CleanseDebuff(100)
		var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/DemonDebuffResist/s = ai_owner.findOrAddSkill(/obj/Skills/Buffs/SlotlessBuffs/Autonomous/DemonDebuffResist)
		if(s && !ai_owner.BuffOn(s))
			s.TimerLimit = 60
			s.Trigger(ai_owner, TRUE)
		if(party_wide && ai_owner.party && ai_owner.party.members)
			for(var/mob/m in ai_owner.party.members)
				if(m == ai_owner) continue
				m.CleanseDebuff(100)
				var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/DemonDebuffResist/ms = m.findOrAddSkill(/obj/Skills/Buffs/SlotlessBuffs/Autonomous/DemonDebuffResist)
				if(ms && !m.BuffOn(ms))
					ms.TimerLimit = 60
					ms.Trigger(m, TRUE)
		DemonSpawnVFX(src)
		return TRUE

	proc/DemonShieldAll()
		if(!ai_owner || !ai_owner.Target) return FALSE
		ai_owner.VaizardHealth = min(100, ai_owner.VaizardHealth + 25)
		src.VaizardHealth = min(100, src.VaizardHealth + 25)
		DemonSpawnVFX(src)
		if(ai_owner) ai_owner << "<font color='#aaaaff'>[name] conjures a protective barrier!</font>"
		return TRUE

	proc/DemonPowerCharge()
		if(!ai_owner || !ai_owner.Target) return FALSE
		next_attack_multiplier = 3
		DemonSpawnVFX(src)
		if(ai_owner) ai_owner << "<font color='#ffdd44'>[name] is charging power for the next attack!</font>"
		return TRUE

	proc/DemonBerserk(mob/target)
		if(!DemonValidTarget(target)) return FALSE
		StrMod *= 1.5
		EndMod *= 0.7
		DefMod *= 0.7
		spawn(200)
			if(src)
				StrMod /= 1.5
				EndMod /= 0.7
				DefMod /= 0.7
		var/dmg = max(1, round(StrMod * 0.5))
		target.DoDamage(src, TrueDamage(dmg))
		Bump(target)
		DemonSpawnVFX(target)
		return TRUE

	proc/DemonStrBuff(mult)
		if(!ai_owner || !ai_owner.Target) return FALSE
		StrMod *= mult
		var/mob/saved_owner = ai_owner
		saved_owner.PowerBoost *= mult
		spawn(300)
			if(src) StrMod /= mult
		spawn(300)
			if(saved_owner) saved_owner.PowerBoost /= mult
		DemonSpawnVFX(src)
		return TRUE

	proc/DemonTaunt()
		if(!ai_owner || !ai_owner.Target) return FALSE
		if(ai_owner.BeingTargetted)
			for(var/mob/m in ai_owner.BeingTargetted)
				if(m && m != src && m != ai_owner)
					m.SetTarget(src)
		DemonSpawnVFX(src)
		if(ai_owner) ai_owner << "<font color='#ff8844'>[name] taunts all enemies, drawing their attention!</font>"
		spawn()
			var/end_time = world.time + 300
			while(src && ai_owner && world.time < end_time)
				if(ai_owner.BeingTargetted)
					for(var/mob/m in ai_owner.BeingTargetted)
						if(m && m != src && m != ai_owner)
							m.SetTarget(src)
				sleep(5)
		return TRUE

	proc/DemonReflect()
		if(!ai_owner || !ai_owner.Target) return FALSE
		demon_reflect_until = world.time + 100
		reflect_overlay_self = image('Icons/Buffs/Shield.dmi')
		src.overlays += reflect_overlay_self
		reflect_overlay_owner = image('Icons/Buffs/Shield.dmi')
		ai_owner.overlays += reflect_overlay_owner
		ai_owner.VaizardHealth = min(100, ai_owner.VaizardHealth + 30)
		DemonSpawnVFX(src)
		if(ai_owner) ai_owner << "<font color='#88ddff'>[name] raises a reflective barrier!</font>"
		spawn(100)
			if(src) DemonRemoveReflectOverlays()
		return TRUE

	proc/DemonRemoveReflectOverlays()
		demon_reflect_until = 0
		if(reflect_overlay_self)
			src.overlays -= reflect_overlay_self
			reflect_overlay_self = null
		if(reflect_overlay_owner && ai_owner)
			ai_owner.overlays -= reflect_overlay_owner
			reflect_overlay_owner = null

	proc/DemonExtraCancel()
		if(!ai_owner) return FALSE
		var/reduced_any = FALSE
		for(var/obj/Skills/s in ai_owner)
			if(!s.Using) continue
			if(!s.cooldown_start) continue
			var/elapsed = world.realtime - s.cooldown_start
			var/remaining = s.cooldown_remaining - elapsed
			if(remaining <= 0) continue
			reduced_any = TRUE
			if(remaining <= 300)
				s.Using = 0
				s.cooldown_remaining = 0
				s.cooldown_start = 0
			else
				var/new_remaining = remaining - 300
				var/new_start = world.realtime
				s.cooldown_start = new_start
				s.cooldown_remaining = new_remaining
				spawn(new_remaining)
					if(s && s.cooldown_start == new_start)
						s.Using = 0
						s.cooldown_remaining = 0
						s.cooldown_start = 0
		if(reduced_any)
			DemonSpawnVFX(src)
			if(ai_owner) ai_owner << "<font color='#88ff88'>[name] reduced your skill cooldowns!</font>"
		return reduced_any

	proc/DemonMarinKarin(mob/target)
		if(!DemonValidTarget(target)) return FALSE
		target.applyCharmed(src, 10)
		DemonSpawnVFX(target)
		return TRUE

	proc/DemonGigajama(mob/target)
		if(!DemonValidTarget(target)) return FALSE
		var/list/targets = DemonGetAoeTargets(target, 6)
		for(var/mob/t in targets)
			var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/DemonSilence/s = t.findOrAddSkill(/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/DemonSilence)
			if(s && !t.BuffOn(s))
				s.TimerLimit = 5
				s.Trigger(t, TRUE)
			DemonSpawnVFX(t)
		return TRUE

	proc/DemonParalyze(mob/target)
		if(!DemonValidTarget(target)) return FALSE
		target.AddShock(15, src)
		DemonSpawnVFX(target)
		if(ai_owner) ai_owner << "<font color='#ffff66'>[name] paralyzes [target]!</font>"
		return TRUE

	proc/DemonStone(mob/target)
		if(!DemonValidTarget(target)) return FALSE
		var/dmg = max(1, round(StrMod * 0.3))
		target.DoDamage(src, TrueDamage(dmg))
		target.AddSlow(20, src)
		DemonSpawnVFX(target)
		if(ai_owner) ai_owner << "<font color='#888899'>[name] petrifies [target]!</font>"
		return TRUE

	proc/DemonWeakKill(mob/target)
		if(!DemonValidTarget(target)) return FALSE
		var/debuff_count = 0
		if(target.Burn > 0) debuff_count++
		if(target.Slow > 0) debuff_count++
		if(target.Shock > 0) debuff_count++
		if(target.Shatter > 0) debuff_count++
		if(target.Poison > 0) debuff_count++
		var/dmg = max(1, round(ForMod * 0.4 * (1 + debuff_count * 0.5)))
		target.DoDamage(src, TrueDamage(dmg))
		DemonFlash(target, "Almighty")
		DemonSpawnVFX(target)
		return TRUE
