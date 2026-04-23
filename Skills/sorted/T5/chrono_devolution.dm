/obj/Skills/AutoHit/Chrono_Devolution
	SkillCost=TIER_5_COST
	Copyable=6
	SignatureTechnique=5
	Area="Target"
	Distance=10
	EnergyCost=30
	ForOffense=1
	StrOffense=0
	DamageMult=40
	Cooldown=-1
	CanBeDodged=0
	CanBeBlocked=0
	GuardBreak=1
	AllOutAttack=1
	HitSparkIcon='BLANK.dmi'
	WindupMessage="reaches out toward their target's timeline..."
	ActiveMessage="rewinds their target's personal history, ripping them back to an earlier state of being!"
	BuffAffected="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Chrono_Devolution"
	verb/Chrono_Devolution()
		set category="Skills"
		if(!usr.Activate(src))
			return
		playChronoDevolutionVisual(usr, usr.Target)

// Visual

var/global/list/CHRONO_DEV_GREYSCALE_MATRIX = list(
	0.33, 0.33, 0.33,
	0.33, 0.33, 0.33,
	0.33, 0.33, 0.33,
	0,    0,    0)

/proc/playChronoDevolutionVisual(mob/user, atom/target)
	set waitfor = FALSE
	if(!target) return

	var/max_radius = 10
	var/apply_hold = 5
	var/ring_delay = 3

	for(var/cycle in 1 to 3)
		var/turf/origin = get_turf(target)
		if(!origin) return

		var/list/rings = list()
		for(var/i in 1 to max_radius + 1)
			rings += list(list())

		for(var/turf/T in range(max_radius, origin))
			var/dx = T.x - origin.x
			var/dy = T.y - origin.y
			var/dist = sqrt(dx*dx + dy*dy)
			if(dist > max_radius) continue
			var/r = round(dist + 0.5) // nearest-int ring index, biased outward
			if(r < 0) r = 0
			if(r > max_radius) r = max_radius
			var/list/slot = rings[r + 1]
			slot += T

		var/list/tile_orig = list()
		var/list/atom_orig = list()

		// Paint everything grey, innermost ring first so layered visuals update
		// in a predictable order.
		for(var/r in 0 to max_radius)
			var/list/slot = rings[r + 1]
			for(var/turf/T in slot)
				if(!T) continue
				tile_orig[T] = T.color
				animate(T, color = CHRONO_DEV_GREYSCALE_MATRIX, time = 1)
				for(var/atom/movable/A in T)
					if(A == user) continue
					if(A in atom_orig) continue
					atom_orig[A] = A.color
					animate(A, color = CHRONO_DEV_GREYSCALE_MATRIX, time = 1)

		sleep(apply_hold)

		// Shrink the greyscale zone back toward the origin, ring by ring.
		for(var/r = max_radius, r >= 0, r--)
			var/list/slot = rings[r + 1]
			for(var/turf/T in slot)
				if(!T) continue
				if(T in tile_orig)
					animate(T, color = tile_orig[T], time = ring_delay)
					tile_orig -= T
				for(var/atom/movable/A in T)
					if(A in atom_orig)
						animate(A, color = atom_orig[A], time = ring_delay)
						atom_orig -= A
			sleep(ring_delay)

		// Final sweep: anything that moved out of the zone or wasn't caught
		// during ring restoration gets its original color forced back.
		for(var/turf/T as anything in tile_orig)
			if(T) T.color = tile_orig[T]
		for(var/atom/movable/A as anything in atom_orig)
			if(A) A.color = atom_orig[A]

/mob/proc/forceRevertAll()
	var/safety = 10
	while(transActive > 0 && safety-- > 0)
		var/prev = transActive
		Revert()
		if(transActive >= prev)
			break

// Sums up every ascension-derived contribution currently applied to `target`.
// Includes applied base ascensions and their chosen sub-ascensions. Returns a
// snapshot list that the Chrono Devolution debuff uses to drive strAdd/endAdd/
// passives and to stash the "miscellaneous" fields (Intimidation, RPPMult,
// PotentialRate, etc.) that aren't covered by the generic buff machinery.
/mob/proc/buildChronoDevolutionSnapshot()
	var/list/snap = list(
		"powerAdd" = 0,
		"strength" = 0,
		"endurance" = 0,
		"force" = 0,
		"offense" = 0,
		"defense" = 0,
		"speed" = 0,
		"recovery" = 0,
		"intelligenceAdd" = 0,
		"imaginationAdd" = 0,
		"anger" = 0,
		"angerPoint" = 0,
		"intimidation" = 0,
		"intimidationMult" = 1,
		"pilotingProwess" = 0,
		"cyberizeModAdd" = 0,
		"enhanceChips" = 0,
		"rppAdd" = 0,
		"ecoAdd" = 0,
		"passives" = list())

	if(!race) return snap
	var/list/ascs = race.ascensions
	if(!islist(ascs) || !ascs.len) return snap

	var/cap = min(AscensionsAcquired, ascs.len)
	for(var/i = 1, i <= cap, i++)
		var/ascension/a = ascs[i]
		if(!a || !a.applied) continue
		_chronoAddAscensionToSnapshot(a, snap)
		if(a.choiceSelected)
			var/ascension/sub = a.choiceSelected
			if(sub)
				_chronoAddAscensionToSnapshot(sub, snap)
	return snap

/proc/_chronoAddAscensionToSnapshot(ascension/a, list/snap)
	if(!a || !islist(snap)) return
	snap["powerAdd"] += a.powerAdd
	snap["strength"] += a.strength
	snap["endurance"] += a.endurance
	snap["force"] += a.force
	snap["offense"] += a.offense
	snap["defense"] += a.defense
	snap["speed"] += a.speed
	snap["recovery"] += a.recovery
	snap["intelligenceAdd"] += a.intelligenceAdd
	snap["imaginationAdd"] += a.imaginationAdd
	snap["anger"] += a.anger
	if(a.angerPoint)
		snap["angerPoint"] += a.angerPoint
	snap["intimidation"] += a.intimidation
	if(a.intimidationMult && a.intimidationMult != 1)
		snap["intimidationMult"] *= a.intimidationMult
	snap["pilotingProwess"] += a.pilotingProwess
	snap["cyberizeModAdd"] += a.cyberizeModAdd
	snap["enhanceChips"] += a.enhanceChips
	snap["rppAdd"] += a.rppAdd
	snap["ecoAdd"] += a.ecoAdd
	if(islist(a.passives))
		var/list/pmap = snap["passives"]
		for(var/p in a.passives)
			var/v = a.passives[p]
			if(!isnum(v)) continue
			pmap[p] = (isnum(pmap[p]) ? pmap[p] : 0) + v

// Debuff

/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Debuff/Chrono_Devolution
	AlwaysOn = 1
	NeedsPassword = 1
	PauseInRP = 1
	TimerLimit = 60
	BuffName = "Chrono Devolution"
	IconLock = 'SweatDrop.dmi'
	CantTrans = TRUE
	ActiveMessage = "has been temporally devolved; their amassed power is ripped from their very being!"
	OffMessage = "feels their timeline reassert itself; their power returning to them."

	// Saved ascension-derived values that aren't handled by the generic
	// strAdd / endAdd / passives. These are applied/removed
	// manually in Trigger().
	var/devolved = 0
	var/saved_powerAdd = 0
	var/saved_recovery = 0
	var/saved_intelligenceAdd = 0
	var/saved_imaginationAdd = 0
	var/saved_anger = 0
	var/saved_angerPoint = 0
	var/saved_intimidation = 0
	var/saved_intimidationMult = 1
	var/saved_pilotingProwess = 0
	var/saved_cyberizeModAdd = 0
	var/saved_enhanceChips = 0
	var/saved_rppAdd = 0
	var/saved_ecoAdd = 0

	adjust(mob/target)
		strAdd = 0
		endAdd = 0
		forAdd = 0
		offAdd = 0
		defAdd = 0
		spdAdd = 0
		passives = list()
		if(!target) return
		var/list/snap = target.buildChronoDevolutionSnapshot()
		if(!islist(snap)) return
		strAdd = -snap["strength"]
		endAdd = -snap["endurance"]
		forAdd = -snap["force"]
		offAdd = -snap["offense"]
		defAdd = -snap["defense"]
		spdAdd = -snap["speed"]
		var/list/ascPassives = snap["passives"]
		if(islist(ascPassives))
			for(var/p in ascPassives)
				var/v = ascPassives[p]
				if(!isnum(v)) continue
				passives[p] = -v

	proc/applyMiscDevolution(mob/target)
		if(!target || devolved) return
		var/list/snap = target.buildChronoDevolutionSnapshot()
		if(!islist(snap)) return
		saved_powerAdd        = snap["powerAdd"]
		saved_recovery        = snap["recovery"]
		saved_intelligenceAdd = snap["intelligenceAdd"]
		saved_imaginationAdd  = snap["imaginationAdd"]
		saved_anger           = snap["anger"]
		saved_angerPoint      = snap["angerPoint"]
		saved_intimidation    = snap["intimidation"]
		saved_intimidationMult= snap["intimidationMult"]
		saved_pilotingProwess = snap["pilotingProwess"]
		saved_cyberizeModAdd  = snap["cyberizeModAdd"]
		saved_enhanceChips    = snap["enhanceChips"]
		saved_rppAdd          = snap["rppAdd"]
		saved_ecoAdd          = snap["ecoAdd"]

		target.PotentialRate   -= saved_powerAdd
		target.RecovAscension  -= saved_recovery
		target.Intelligence    -= saved_intelligenceAdd
		target.Imagination     -= saved_imaginationAdd
		target.Intimidation    -= saved_intimidation
		if(saved_intimidationMult && saved_intimidationMult != 1)
			target.Intimidation /= saved_intimidationMult
		target.PilotingProwess -= saved_pilotingProwess
		target.CyberizeMod     -= saved_cyberizeModAdd
		target.EnhanceChipsMax -= saved_enhanceChips
		target.RPPMult         -= saved_rppAdd
		target.EconomyMult     -= saved_ecoAdd
		if(saved_angerPoint)
			target.AngerPoint  -= saved_angerPoint
		devolved = 1

	proc/restoreMiscDevolution(mob/target)
		if(!target || !devolved) return
		target.PotentialRate   += saved_powerAdd
		target.RecovAscension  += saved_recovery
		target.Intelligence    += saved_intelligenceAdd
		target.Imagination     += saved_imaginationAdd
		if(saved_intimidationMult && saved_intimidationMult != 1)
			target.Intimidation *= saved_intimidationMult
		target.Intimidation    += saved_intimidation
		target.PilotingProwess += saved_pilotingProwess
		target.CyberizeMod     += saved_cyberizeModAdd
		target.EnhanceChipsMax += saved_enhanceChips
		target.RPPMult         += saved_rppAdd
		target.EconomyMult     += saved_ecoAdd
		if(saved_angerPoint)
			target.AngerPoint  += saved_angerPoint
		saved_powerAdd = 0
		saved_recovery = 0
		saved_intelligenceAdd = 0
		saved_imaginationAdd = 0
		saved_anger = 0
		saved_angerPoint = 0
		saved_intimidation = 0
		saved_intimidationMult = 1
		saved_pilotingProwess = 0
		saved_cyberizeModAdd = 0
		saved_enhanceChips = 0
		saved_rppAdd = 0
		saved_ecoAdd = 0
		devolved = 0

	Trigger(mob/User, Override = FALSE)
		if(!User.BuffOn(src))
			adjust(User)
			applyMiscDevolution(User)
			User.forceRevertAll()
		else
			restoreMiscDevolution(User)
			Timer = 0
		..()
