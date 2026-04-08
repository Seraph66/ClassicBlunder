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
	DEMON_SKILL_VFX = list()

	// ===== FIRE =====
	DEMON_SKILL_VFX["Agi"]          = new /datum/demon_skill_vfx('Icons/Effects/fevExplosion - Hellfire.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Agidyne"]      = new /datum/demon_skill_vfx('Icons/Effects/fevExplosion - Hellfire.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Inferno"]      = new /datum/demon_skill_vfx('Icons/Effects/fevExplosion - Hellfire.dmi', "", 0, 0, 2, 6)
	DEMON_SKILL_VFX["Maragi"]       = new /datum/demon_skill_vfx('Icons/Effects/fevExplosion - Hellfire.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Maragidyne"]   = new /datum/demon_skill_vfx('Icons/Effects/fevExplosion - Hellfire.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Fire Dance"]   = new /datum/demon_skill_vfx('Icons/Effects/fevExplosion - Hellfire.dmi', "", 0, 0, 1, 4)

	// ===== ICE =====
	DEMON_SKILL_VFX["Bufu"]         = new /datum/demon_skill_vfx('Icons/Effects/SnowBurst2.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Bufudyne"]     = new /datum/demon_skill_vfx('Icons/Effects/SnowBurst2.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Mabufu"]       = new /datum/demon_skill_vfx('Icons/Effects/SnowBurst2.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Mabufudyne"]   = new /datum/demon_skill_vfx('Icons/Effects/SnowBurst2.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Ice Dance"]    = new /datum/demon_skill_vfx('Icons/Effects/SnowBurst2.dmi', "", 0, 0, 1, 4)

	// ===== ELEC =====
	DEMON_SKILL_VFX["Zio"]          = new /datum/demon_skill_vfx('Icons/NSE/Hitsparks/HitElectro.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Ziodyne"]      = new /datum/demon_skill_vfx('Icons/NSE/Hitsparks/HitElectro.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Mazio"]        = new /datum/demon_skill_vfx('Icons/NSE/Hitsparks/HitElectro.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Maziodyne"]    = new /datum/demon_skill_vfx('Icons/NSE/Hitsparks/HitElectro.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Elec Dance"]   = new /datum/demon_skill_vfx('Icons/NSE/Hitsparks/HitElectro.dmi', "", 0, 0, 1, 4)

	// ===== FORCE =====
	DEMON_SKILL_VFX["Zan"]          = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Wind.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Zandyne"]      = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Wind.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Mazan"]        = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Wind.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Mazandyne"]    = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Wind.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Force Dance"]  = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Wind.dmi', "", 0, 0, 1, 4)

	// ===== ALMIGHTY =====
	DEMON_SKILL_VFX["Holy Strike"]  = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Divine.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Megido"]       = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Divine.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Megidolaon"]   = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Divine.dmi', "", 0, 0, 1.5, 6)
	DEMON_SKILL_VFX["Judgement"]    = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Divine.dmi', "", 0, 0, 2, 6)
	DEMON_SKILL_VFX["Holy Dance"]   = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Divine.dmi', "", 0, 0, 1, 4)

	// ===== PHYSICAL =====
	DEMON_SKILL_VFX["Power Hit"]    = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect.dmi', "", 0, 0, 1, 4)
	DEMON_SKILL_VFX["Mighty Hit"]   = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect.dmi', "", 0, 0, 1.5, 4)
	DEMON_SKILL_VFX["Brutal Hit"]   = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect.dmi', "", 0, 0, 2, 5)
	DEMON_SKILL_VFX["Anger Hit"]    = new /datum/demon_skill_vfx('Icons/Effects/SparkleRed.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Piercing Hit"] = new /datum/demon_skill_vfx('Icons/Effects/Slash.dmi', "", -32, -32, 1, 4)
	DEMON_SKILL_VFX["Fatal Strike"] = new /datum/demon_skill_vfx('Icons/Effects/Slash.dmi', "", -32, -32, 1.5, 4)
	DEMON_SKILL_VFX["Assassinate"]  = new /datum/demon_skill_vfx('Icons/Effects/Slash - Black.dmi', "", -32, -32, 1.5, 5)
	DEMON_SKILL_VFX["Desperation"]  = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Ripple.dmi', "", 0, 0, 2, 6)
	DEMON_SKILL_VFX["Multi-Strike"] = new /datum/demon_skill_vfx('Icons/Effects/Claw markings.dmi', "", 0, 0, 1, 4)
	DEMON_SKILL_VFX["Deathbound"]   = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Ripple.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Mow Down"]     = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Hassohappa"]   = new /datum/demon_skill_vfx('Icons/Effects/Slash.dmi', "", -32, -32, 1.5, 4)
	DEMON_SKILL_VFX["Berserk"]      = new /datum/demon_skill_vfx('Icons/Effects/SparkleRed.dmi', "", 0, 0, 1, 5)

	// ===== DRAIN =====
	DEMON_SKILL_VFX["Drain"]        = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Dark.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Life Drain"]   = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Dark.dmi', "", 0, 0, 1.5, 5)

	// ===== HEALING =====
	DEMON_SKILL_VFX["Dia"]          = new /datum/demon_skill_vfx('Icons/Effects/HitsparkStar.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Diarama"]      = new /datum/demon_skill_vfx('Icons/Effects/HitsparkStar.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Diarahan"]     = new /datum/demon_skill_vfx('Icons/Effects/HitsparkStar.dmi', "", 0, 0, 2, 5)
	DEMON_SKILL_VFX["Media"]        = new /datum/demon_skill_vfx('Icons/Effects/HitsparkStar.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Mediarahan"]   = new /datum/demon_skill_vfx('Icons/Effects/HitsparkStar.dmi', "", 0, 0, 2, 5)
	DEMON_SKILL_VFX["Prayer"]       = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Divine.dmi', "", 0, 0, 2, 6)

	// ===== REVIVAL =====
	DEMON_SKILL_VFX["Recarm"]       = new /datum/demon_skill_vfx('Icons/Effects/HitsparkStar.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Samarecarm"]   = new /datum/demon_skill_vfx('Icons/Effects/HitsparkStar.dmi', "", 0, 0, 2, 6)
	DEMON_SKILL_VFX["Recarmloss"]   = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Dark.dmi', "", 0, 0, 1.5, 5)

	// ===== SUPPORT =====
	DEMON_SKILL_VFX["Amrita"]       = new /datum/demon_skill_vfx('Icons/Effects/HitsparkStar.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Nigayomogi"]   = new /datum/demon_skill_vfx('Icons/Effects/HitsparkStar.dmi', "", 0, 0, 2, 6)
	DEMON_SKILL_VFX["Shield All"]   = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Divine.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Power Charge"] = new /datum/demon_skill_vfx('Icons/Effects/SparkleRed.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Death Call"]   = new /datum/demon_skill_vfx('Icons/Effects/SparkleRed.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Might Call"]   = new /datum/demon_skill_vfx('Icons/Effects/SparkleRed.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Taunt"]        = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Ripple.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Makarakarn"]   = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Divine.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Tetrakarn"]    = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Divine.dmi', "", 0, 0, 1.5, 5)
	DEMON_SKILL_VFX["Extra Cancel"] = new /datum/demon_skill_vfx('Icons/Effects/HitsparkStar.dmi', "", 0, 0, 1, 5)

	// ===== STATUS =====
	DEMON_SKILL_VFX["Marin Karin"]  = new /datum/demon_skill_vfx('Icons/Effects/HitsparkStar.dmi', "", 0, 0, 1, 5)
	DEMON_SKILL_VFX["Gigajama"]     = new /datum/demon_skill_vfx('Icons/Effects/Hit Effect Dark.dmi', "", 0, 0, 1.5, 5)

/mob/Player/AI/Demon

	proc/DemonSpawnVFX(mob/on_target)
		if(!demon_data || !on_target) return
		var/datum/demon_skill_vfx/vfx = DEMON_SKILL_VFX[demon_data.demon_skill]
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

	proc/DemonUseSkill(mob/target)
		if(!demon_data) return FALSE
		var/skill = demon_data.demon_skill
		if(!skill || skill == "None") return FALSE
		var/used = FALSE
		switch(skill)
			if("Agi")
				used = DemonSingleDamage(target, ForMod * 0.3, "Fire", 3)
			if("Agidyne")
				used = DemonSingleDamage(target, ForMod * 0.6, "Fire", 6)
			if("Inferno")
				used = DemonSingleDamage(target, ForMod * 0.9, "Fire", 8)
			if("Maragi")
				used = DemonAoeDamage(target, 5, ForMod * 0.15, "Fire", 2)
			if("Maragidyne")
				used = DemonAoeDamage(target, 5, ForMod * 0.35, "Fire", 5)
			if("Fire Dance")
				used = DemonDanceSkill(target, ForMod * 0.12, "Fire", 2, 3, 6)
			if("Bufu")
				used = DemonSingleDamage(target, ForMod * 0.3, "Ice", 3)
			if("Bufudyne")
				used = DemonSingleDamage(target, ForMod * 0.6, "Ice", 6)
			if("Mabufu")
				used = DemonAoeDamage(target, 5, ForMod * 0.15, "Ice", 2)
			if("Mabufudyne")
				used = DemonAoeDamage(target, 5, ForMod * 0.35, "Ice", 5)
			if("Ice Dance")
				used = DemonDanceSkill(target, ForMod * 0.12, "Ice", 2, 3, 6)
			if("Zio")
				used = DemonSingleDamage(target, ForMod * 0.3, "Elec", 3)
			if("Ziodyne")
				used = DemonSingleDamage(target, ForMod * 0.6, "Elec", 6)
			if("Mazio")
				used = DemonAoeDamage(target, 5, ForMod * 0.15, "Elec", 2)
			if("Maziodyne")
				used = DemonAoeDamage(target, 5, ForMod * 0.35, "Elec", 5)
			if("Elec Dance")
				used = DemonDanceSkill(target, ForMod * 0.12, "Elec", 2, 3, 6)
			if("Zan")
				used = DemonSingleDamage(target, ForMod * 0.3, "Force", 3)
			if("Zandyne")
				used = DemonSingleDamage(target, ForMod * 0.6, "Force", 6)
			if("Mazan")
				used = DemonAoeDamage(target, 5, ForMod * 0.15, "Force", 2)
			if("Mazandyne")
				used = DemonAoeDamage(target, 5, ForMod * 0.35, "Force", 5)
			if("Force Dance")
				used = DemonDanceSkill(target, ForMod * 0.12, "Force", 2, 3, 6)
			if("Holy Strike")
				used = DemonSingleDamage(target, ForMod * 0.55, "Almighty", 2)
			if("Megido")
				used = DemonAoeDamage(target, 5, ForMod * 0.25, "Almighty", 1)
			if("Megidolaon")
				used = DemonAoeDamage(target, 5, ForMod * 0.45, "Almighty", 2)
			if("Judgement")
				used = DemonAoeDamage(target, 6, ForMod * 0.6, "Almighty", 3)
			if("Holy Dance")
				used = DemonDanceSkill(target, ForMod * 0.1, "Almighty", 1, 3, 6)
			if("Power Hit")
				used = DemonPhysDamage(target, StrMod * 0.25)
			if("Mighty Hit")
				used = DemonPhysDamage(target, StrMod * 0.45)
			if("Brutal Hit")
				used = DemonPhysDamage(target, StrMod * 0.65)
			if("Anger Hit")
				if(DemonValidTarget(target))
					var/hp_ratio = max(0.1, demon_hp / 100)
					used = DemonPhysDamage(target, StrMod * 0.3 * (2 - hp_ratio))
			if("Piercing Hit")
				used = DemonPhysDamage(target, StrMod * 0.55)
			if("Fatal Strike")
				if(DemonValidTarget(target))
					var/dmg = StrMod * 0.4
					if(prob(25))
						dmg *= 2
						if(ai_owner) ai_owner << "<font color='#ff4444'>[name] lands a critical blow!</font>"
					used = DemonPhysDamage(target, dmg)
			if("Assassinate")
				if(DemonValidTarget(target))
					var/dmg = StrMod * 0.4
					if(prob(15))
						dmg *= 10
						if(ai_owner) ai_owner << "<font color='#ff0000'>[name] strikes a lethal blow!</font>"
					used = DemonPhysDamage(target, dmg)
			if("Desperation")
				used = DemonDesperation(target)
			if("Multi-Strike")
				used = DemonPhysMultiHit(target, StrMod * 0.1, 2, 5)
			if("Deathbound")
				used = DemonPhysAoe(target, 5, StrMod * 0.2)
			if("Mow Down")
				used = DemonPhysAoe(target, 5, StrMod * 0.15)
			if("Hassohappa")
				used = DemonPhysAoeMultiHit(target, 5, StrMod * 0.15, 1, 3)
			if("Drain")
				used = DemonDrain(target, ForMod * 0.3, FALSE)
			if("Life Drain")
				used = DemonDrain(target, ForMod * 0.45, TRUE)
			if("Dia")
				used = DemonHealRandom(30)
			if("Diarama")
				used = DemonHealRandom(60)
			if("Diarahan")
				used = DemonHealRandom(100)
			if("Media")
				used = DemonHealAll(25)
			if("Mediarahan")
				used = DemonHealAll(100)
			if("Prayer")
				used = DemonPrayer()
			if("Recarm")
				used = DemonRevive(50)
			if("Samarecarm")
				used = DemonRevive(100)
			if("Recarmloss")
				used = DemonRecarmloss()
			if("Amrita")
				used = DemonAmrita(FALSE)
			if("Nigayomogi")
				used = DemonAmrita(TRUE)
			if("Shield All")
				used = DemonShieldAll()
			if("Power Charge")
				used = DemonPowerCharge()
			if("Berserk")
				used = DemonBerserk(target)
			if("Death Call")
				used = DemonStrBuff(1.3)
			if("Might Call")
				used = DemonStrBuff(1.2)
			if("Taunt")
				used = DemonTaunt()
			if("Makarakarn")
				used = DemonReflect()
			if("Tetrakarn")
				used = DemonReflect()
			if("Extra Cancel")
				used = DemonExtraCancel()
			if("Marin Karin")
				used = DemonMarinKarin(target)
			if("Gigajama")
				used = DemonGigajama(target)
		if(used)
			DemonAnnounce(skill)
		return used

	proc/DemonValidTarget(mob/target)
		if(!target) return FALSE
		if(get_dist(src, target) > 15) return FALSE
		if(ai_owner && "[ai_owner.ckey]" in target.ai_alliances) return FALSE
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
		animate(target, color = target:MobColor, time = 5)

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
			if(!m.client) continue
			if(ai_owner && m == ai_owner) continue
			if(ai_owner && "[ai_owner.ckey]" in m.ai_alliances) continue
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
		var/orig_str = StrMod
		var/orig_end = EndMod
		var/orig_def = DefMod
		StrMod *= 1.5
		EndMod *= 0.7
		DefMod *= 0.7
		spawn(200)
			if(src)
				StrMod = orig_str
				EndMod = orig_end
				DefMod = orig_def
		var/dmg = max(1, round(StrMod * 0.5))
		target.DoDamage(src, TrueDamage(dmg))
		Bump(target)
		DemonSpawnVFX(target)
		return TRUE

	proc/DemonStrBuff(mult)
		if(!ai_owner || !ai_owner.Target) return FALSE
		var/orig_str = StrMod
		StrMod *= mult
		spawn(300)
			if(src) StrMod = orig_str
		var/orig_pb = ai_owner.PowerBoost
		ai_owner.PowerBoost *= mult
		var/mob/saved_owner = ai_owner
		spawn(300)
			if(saved_owner) saved_owner.PowerBoost = orig_pb
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
