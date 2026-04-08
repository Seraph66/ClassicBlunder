/mob/Player/AI/Demon
	var/datum/demon_data/demon_data = null
	var/demon_owner_key = ""

	var/next_melee_tick   = 0
	var/next_skill_tick   = 0
	var/demon_melee_rate  = 25
	var/demon_skill_rate  = 150

	var/demon_hp = 100
	var/next_attack_multiplier = 1
	var/demon_reflect_until = 0
	var/image/reflect_overlay_self = null
	var/image/reflect_overlay_owner = null

	New()
		..()

	proc/DemonInit(datum/demon_data/dd, mob/owner)
		demon_data = dd
		ai_owner   = owner
		demon_owner_key = owner.ckey
		name       = dd.demon_name
		icon       = dd.demon_icon
		icon_state = dd.demon_icon_state
		ai_follow  = TRUE
		ai_focus_owner_target = TRUE
		density    = FALSE
		ai_alliances = list("[owner.ckey]")
		owner.ai_followers += src

		var/scale = max(1, owner.Potential) / 100
		StrMod = max(1, round(dd.demon_str * scale, 0.01))
		ForMod = max(1, round(dd.demon_for * scale, 0.01))
		EndMod = max(1, round(dd.demon_end * scale, 0.01))
		SpdMod = max(1, round(dd.demon_spd * scale, 0.01))
		OffMod = max(1, round(dd.demon_off * scale, 0.01))
		DefMod = max(1, round(dd.demon_def * scale, 0.01))
		Potential = owner.Potential * 0.5
		potential_power_mult = owner.potential_power_mult * 0.5

		demon_melee_rate = max(8, 30 - round(dd.demon_spd * 0.7))

		aiGain()
		spawn() DemonLoop()

	proc/DemonLoop()
		set waitfor = FALSE
		while(src && ai_owner)
			if(!ai_owner || !ai_owner.client)
				DemonDespawn()
				return
			DemonUpdate()
			sleep(2)

	proc/DemonUpdate()
		if(!ai_owner) return

		if(ai_owner.PureRPMode)
			FollowOwner()
			return

		var/mob/target = ai_owner.Target

		if(!(next_skill_tick - world.time > 0))
			if(DemonUseSkill(target))
				next_skill_tick = world.time + demon_skill_rate
			else
				next_skill_tick = world.time + 50

		if(!target)
			FollowOwner()
			return

		if(!(next_melee_tick - world.time > 0))
			if(get_dist(src, target) > 1)
				step_to(src, target, 1)
			else
				DemonMeleeAttack(target)
				next_melee_tick = world.time + demon_melee_rate

	proc/FollowOwner()
		if(!ai_owner) return
		if(ai_owner.icon_state == "Meditate")
			icon_state = "Meditate"
			return
		icon_state = ""
		if(get_dist(src, ai_owner) >= 3)
			if(ai_owner.z != src.z)
				loc = locate(ai_owner.x, ai_owner.y, ai_owner.z)
			step_to(src, ai_owner, 1)
			if(loc == ai_owner.loc) step_away(src, ai_owner)

	proc/DemonMeleeAttack(mob/target)
		if(!target || !target.client) return
		if(ai_owner && "[ai_owner.ckey]" in target.ai_alliances) return
		if(ai_owner && ai_owner.party && ai_owner.party.members && (target in ai_owner.party.members)) return
		var/dmg = max(1, round(StrMod * 0.1 * next_attack_multiplier))
		if(next_attack_multiplier > 1)
			if(ai_owner) ai_owner << "<font color='#ffaa00'>[name]'s charged attack connects!</font>"
			next_attack_multiplier = 1
		target.DoDamage(src, TrueDamage(dmg))
		Bump(target)

	proc/DemonDespawn()
		DemonRemoveReflectOverlays()
		if(ai_owner)
			ai_owner.ai_followers -= src
			ai_owner.demon_active = null
			ai_owner.demon_active_name = ""
			ai_owner << "<b>[name] has been defeated and returned.</b> Meditate to restore them."
		del(src)

	DoDamage(mob/attacker, damage_type/damage)
		if(ai_owner && ai_owner.PureRPMode) return
		if(ai_owner && istype(attacker, /mob))
			if(attacker == ai_owner) return
			if(ai_owner.party && ai_owner.party.members && (attacker in ai_owner.party.members)) return
		if(demon_reflect_until > world.time && istype(attacker, /mob))
			var/reflect_dmg = max(1, round(ForMod * 0.3))
			demon_reflect_until = 0
			DemonRemoveReflectOverlays()
			if(ai_owner) ai_owner << "<font color='#88ddff'>[name]'s barrier reflects the attack!</font>"
			attacker.DoDamage(src, TrueDamage(reflect_dmg))
			return
		. = ..()
		if(!ai_owner) return
		for(var/datum/party_demon/pd in ai_owner.demon_party)
			if(pd.demon_name == name)
				pd.current_hp = demon_hp
				if(demon_hp <= 0)
					DemonDespawn()
				return
