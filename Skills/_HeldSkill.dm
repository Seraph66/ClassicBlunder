// AutoHits and Projectiles apply this by setting HeldSkill = TRUE
// The skill's verb should call usr.BeginHeldSkill(src) instead of
// usr.Activate(src). Override OnHeldRelease(mob/p, benefit) to
// execute the skill.

// ChargeBenefit is 0-1 (progress through ChargePeriod)
// During the SweetSpot window it is multiplied by SweetSpotBenefit,
// which can push it above 1.0.

/obj/Skills
	var/HeldSkill        = FALSE  // Enable held-charge behavior for this skill
	var/ChargePeriod     = 3      // Max hold time in seconds, hold too long = fizzle
	var/SweetSpot        = 0      // Seconds from charge start when sweet spot opens (0 = disabled)
	var/SweetSpotBenefit = 1.5    // ChargeBenefit multiplier inside the sweet spot window
	var/ChargeOverlay    = null   // Icon displayed on mob while charging
	var/ChargeWaveIcon   = 'Icons/Effects/KenShockwave.dmi'  // Icon for periodic charge shockwave
	var/ChargeWaveBlend  = 1      // Blend mode for the periodic charge shockwave
	var/ChargeBenefit    = 0      // Set on release
	var/HeldVerbName     = null   // Optional override for macro detection;
	                              // defaults to Z.name if null

/obj/Skills/proc/OnHeldRelease(mob/p, var/benefit)
	// Override in individual skills to execute the charged attack.

// Charge state

/mob
	var/tmp/obj/Skills/held_skill         = null
	var/tmp/held_charge_start             = 0
	var/tmp/image/held_charge_overlay_ref = null
	var/tmp/held_skill_macro_key          = null
	var/tmp/held_skill_last_release       = 0


/proc/_normalizeHeldName(s)
	if(!s) return ""
	s = replacetext(s, "_", " ")
	s = replacetext(s, "-", " ")
	return lowertext(s)

// Candidate keys to probe when finding which key the player has the
// skill bound to.

/proc/_heldSkillCandidateKeys()
	return list(
		"A","B","C","D","E","F","G","H","I","J","K","L","M",
		"N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
		"0","1","2","3","4","5","6","7","8","9",
		"F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12",
		"Numpad0","Numpad1","Numpad2","Numpad3","Numpad4",
		"Numpad5","Numpad6","Numpad7","Numpad8","Numpad9",
		"NumpadPlus","NumpadMinus","NumpadStar","NumpadSlash",
		"Space","Tab","Return","Backspace",
		"Insert","Home","Delete","End","PageUp","PageDown"
	)

// BeginHeldSkill is called by the skill's verb instead of Activate

/mob/proc/BeginHeldSkill(var/obj/Skills/Z)
	if(held_skill) return  // Already charging something
	if(!Z || !Z.HeldSkill) return
	var/client/C = client
	if(!C) return

	// re-entry guard
	// BeginHeldSkill call that lands within ~0.5s of a release so the
	// stray fire can't start a second charge or trip findHeldSkillKey.
	if(held_skill_last_release && world.time - held_skill_last_release < 5)
		return

	// Cooldown / in-use check, the held effect must not start if the
	// underlying skill itself isn't allowed to fire.
	if(Z.Using || Z.cooldown_remaining)
		src << "<font color='red'>[Z.name] is on cooldown.</font>"
		return

	// Close the re-entry window immediately so a second verb fire
	// during the slow winget/winset calls below can't spawn a second charge.
	held_skill        = Z
	held_charge_start = world.time
	Z.ChargeBenefit   = 0

	// Visual feedback placement, needs a little bit of tweaking, not quite where I want it
	// the player should see the charge the instant the key is pressed.
	if(Z.ChargeOverlay && !held_charge_overlay_ref)
		var/image/I = image(Z.ChargeOverlay)
		I.layer = MOB_LAYER + 0.1
		held_charge_overlay_ref = I
		overlays += I
	KenShockwave(src, icon=Z.ChargeWaveIcon, Size=0.5, Blend=Z.ChargeWaveBlend, Time=8)

	// Find which key the player has bound this skill to
	var/key = findHeldSkillKey(C, Z)
	if(!key)
		if(held_charge_overlay_ref)
			overlays -= held_charge_overlay_ref
			held_charge_overlay_ref = null
		held_skill        = null
		held_charge_start = 0
		src << "<font color='red'>Bind [Z.name] to a key first.</font>"
		return

	// Install the KEY+UP release macro for the duration of the charge
	installHeldReleaseMacro(C, key)
	held_skill_macro_key = key

	spawn() ChargeLoop(Z)


/mob/proc/findHeldSkillKey(client/C, obj/Skills/Z)
	var/raw_search = Z.HeldVerbName ? Z.HeldVerbName : Z.name
	if(!raw_search) return null
	var/search = _normalizeHeldName(raw_search)

	for(var/k in _heldSkillCandidateKeys())
		var/cmd = winget(C, k, "command")
		if(!cmd) continue
		if(findtext(_normalizeHeldName(cmd), search))
			return k

	return null

// installHeldReleaseMacro installs a KEY+UP macro in every macro
// container, pointing to the Release Held Skill verb. Uses a unique
// id so it doesn't collide with any existing player macro.

/mob/proc/installHeldReleaseMacro(client/C, key)
	var/list/sets = params2list(winget(C, null, "macro"))
	for(var/set_name in sets)
		winset(C, "heldskill_release_[set_name]", "parent=[set_name];name=[key]+UP;command=Release-Held-Skill")


/mob/proc/clearHeldReleaseMacro()
	if(!client) return
	var/list/sets = params2list(winget(client, null, "macro"))
	for(var/set_name in sets)
		winset(client, "heldskill_release_[set_name]", "name=")

// ChargeLoop runs for the duration of the hold

/mob/proc/ChargeLoop(var/obj/Skills/Z)
	while(held_skill == Z)
		// Interrupt conditions
		var/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Charmed/charm_skill = locate(/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Charmed) in src
		if(Stunned || Launched || Stasis > 0 || (charm_skill && BuffOn(charm_skill)))
			FizzleHeldSkill(Z)
			return

		// Overheld fizzle
		if(world.time - held_charge_start > Z.ChargePeriod * 10)
			FizzleHeldSkill(Z)
			return

		// closing the visual gap after BeginHeldSkill's initial pulse.
		KenShockwave(src, icon=Z.ChargeWaveIcon, Size=0.5, Blend=Z.ChargeWaveBlend, Time=8)

		sleep(2)

// ReleaseHeldSkill is called by the Release_Held_Skill verb (KEY+UP macro)

/mob/proc/ReleaseHeldSkill()
	var/obj/Skills/Z = held_skill
	if(!Z) return

	var/hold_ticks = world.time - held_charge_start

	// Overheld
	if(hold_ticks > Z.ChargePeriod * 10)
		FizzleHeldSkill(Z)
		return

	// ChargeBenefit is 0-1 based on progress through ChargePeriod
	var/benefit = clamp(hold_ticks / (Z.ChargePeriod * 10), 0.0, 1.0)

	// Sweet spot window is SweetSpot to SweetSpot + 0.25s
	if(Z.SweetSpot && hold_ticks >= Z.SweetSpot * 10 && hold_ticks <= Z.SweetSpot * 10 + 3)
		benefit *= Z.SweetSpotBenefit

	Z.ChargeBenefit = benefit
	ClearHeldChargeState()
	held_skill_last_release = world.time
	Z.OnHeldRelease(src, benefit)

// FizzleHeldSkill for skill being overheld, interrupted, or cancelled

/mob/proc/FizzleHeldSkill(var/obj/Skills/Z)
	if(held_skill != Z) return
	ClearHeldChargeState()
	held_skill_last_release = world.time
	Z.Cooldown(1, null, src)
	src << "<font color='red'>Your technique fizzled!</font>"

// Cleanup

/mob/proc/ClearHeldChargeState()
	held_skill        = null
	held_charge_start = 0
	held_skill_macro_key = null
	if(held_charge_overlay_ref)
		overlays -= held_charge_overlay_ref
		held_charge_overlay_ref = null
	clearHeldReleaseMacro()

// HeldSkillBlocksAction returns TRUE if a held skill is currently
// charging and the requested skill would conflict.

/mob/proc/HeldSkillBlocksAction(obj/Skills/Z)
	if(held_skill && held_skill != Z)
		src << "<font color='red'>You can't do that while charging [held_skill.name].</font>"
		return TRUE
	return FALSE

// Internal verb fired by the temporary KEY+UP macro the system installs.

/mob/verb/Release_Held_Skill()
	set name = "Release Held Skill"
	set hidden = 1
	set instant = 1
	if(usr.held_skill)
		usr.ReleaseHeldSkill()

// Exampleskill

/obj/Skills/AutoHit/Charged_Lightning_Kicks
	Area = "Arc"
	StrOffense = 1
	DamageMult = 2.75  
	Rush = 5
	ControlledRush = 1
	Rounds = 3    
	ComboMaster = 1
	RoundMovement = 0
	NoAttackLock = 1
	NoLock = 1
	Cooldown = 60
	Distance = 2
	EnergyCost = 5
	Launcher = 2
	Instinct = 1
	Icon = 'Nest Slash.dmi'
	IconX = -16
	IconY = -16
	Size = 2
	TurfStrike = 1
	TurfShift = 'Dirt1.dmi'
	TurfShiftDuration = 3
	ActiveMessage = "channels lightning through their legs and delivers a torrent of kicks!"

	// Held skill config
	HeldSkill = TRUE
	ChargePeriod = 3
	SweetSpot = 1.5   
	SweetSpotBenefit = 3.0    
	ChargeOverlay = 'DarkShock.dmi'   
	ChargeWaveIcon = 'Icons/Effects/KenShockwave.dmi'  
	ChargeWaveBlend = 2      

	adjust(mob/p)

	OnHeldRelease(mob/p, var/benefit)
		DamageMult = 2.75 + (2.0 * benefit)  // placeholder scaling

		// Add a fourth round at 70%+ charge
		if(benefit >= 0.7)  // placeholder threshold
			Rounds = 4
		else
			Rounds = 3

		p.Activate(src)

	verb/Charged_Lightning_Kicks()
		set category = "Skills"
		usr.BeginHeldSkill(src)
