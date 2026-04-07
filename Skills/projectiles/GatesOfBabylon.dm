// Gates of Babylon Scaling Sig

// Mastery 1 : 8  projectiles
// Mastery 2 : 11 projectiles + 1 legendary guaranteed + 1 sentinel weapon
// Mastery 3 : 14 projectiles + 2 legendaries + 2 sentinels + Rapid Barrage mode
// Mastery 4 : 17 projectiles + Enkidu - Chains of Heaven granted
// Mastery 5 : 20 projectiles + Enuma Elish granted


// Cached weapon pool, built on first use
var/list/gob_weapon_pool = null


// Particle effect for Enuma Elish charge-up
/particles/ea_gathering
	icon      = 'particle.dmi'
	width     = 700
	height    = 700
	count     = 120
	spawning  = 5
	lifespan  = 45
	fade      = 10
	scale     = generator("num", 2.0, 4.5)
	// Spawn scattered around/below the focal point (at the user's body level)
	position  = generator("box", list(-72, -88, 0), list(72, -20, 0))
	gravity   = list(0, 2.0)    // pulled upward toward the focal point
	friction  = 0.10
	drift     = generator("box", list(-0.8, -0.8, 0), list(0.8, 0.8, 0))
	color     = "#ff3311"

proc/BuildGoBWeaponPool()
	var/list/pool = list()

	for(var/C in typesof(/obj/Items/Sword))
		var/obj/Items/Sword/S = new C
		// Skip abstract/placeholder types
		if(!S.icon || !S.name)
			del S
			continue
		// might add more conditions here later
		if(!S.LegendaryItem)
			del S
			continue
		// Skip Celestial weapons maybe
		// Keeping this here depending on what I decide later for Celestial weps
		// if(istype(S, /obj/Items/Sword/Celestial)) { del S; continue; }

		pool += list(list(
			"icon"      = S.icon,
			"element"   = S.Element,
			"legendary" = S.LegendaryItem,
			"name"      = S.name,
			"px"        = S.pixel_x,
			"py"        = S.pixel_y
		))
		del S

	// --- Keychains (standard) ---
	for(var/KC in glob.Keychains)
		var/ico = GetKeychainIcon(KC)
		if(!ico) continue
		pool += list(list(
			"icon"      = ico,
			"element"   = GetKeychainElement(KC),
			"legendary" = FALSE,
			"name"      = KC,
			"px"        = -32,
			"py"        = -32
		))

	// --- Keychains (legendary / final) ---
	for(var/KC in glob.FinalKeychains)
		var/ico = GetKeychainIcon(KC)
		if(!ico) continue
		pool += list(list(
			"icon"      = ico,
			"element"   = GetKeychainElement(KC),
			"legendary" = TRUE,
			"name"      = KC,
			"px"        = -32,
			"py"        = -32
		))

	return pool


proc/SelectGoBWeapons(list/pool, count, mastery)
	var/list/selected = list()
	var/list/pool_copy = pool.Copy()

	for(var/i = 1 to count)
		if(!pool_copy.len) break
		var/idx = rand(1, pool_copy.len)
		var/entry = pool_copy[idx]
		selected += list(entry)
		pool_copy.Remove(entry)

	// Legendary guarantee
	var/needed_leg = 0
	if(mastery >= 2) needed_leg = 1
	if(mastery >= 3) needed_leg = 2

	if(needed_leg > 0)
		var/have_leg = 0
		for(var/e in selected)
			if(e["legendary"]) have_leg++

		if(have_leg < needed_leg)
			// Gather legendaries from full pool not already selected
			var/list/sel_names = list()
			for(var/e in selected) sel_names += e["name"]
			var/list/leg_pool = list()
			for(var/e in pool)
				if(e["legendary"] && !(e["name"] in sel_names))
					leg_pool += list(e)

			// Swap out non-legendary slots
			var/to_swap = min(needed_leg - have_leg, leg_pool.len)
			var/swap_done = 0
			for(var/j = 1 to selected.len)
				if(swap_done >= to_swap) break
				if(!selected[j]["legendary"])
					selected[j] = leg_pool[swap_done + 1]
					swap_done++

	return selected


proc/ApplyGoBElement(obj/Skills/Projectile/_Projectile/proj, element, forced)
	if(!element || element == 0) return
	switch(element)
		if("Fire")
			if(forced) proj.Scorching  = 1
			else       proj.Burning    = 1
		if("Water")
			if(forced) proj.Freezing   = 1
			else       proj.Chilling   = 1
		if("Earth")
			if(forced) proj.Shattering = 1
			else       proj.Crushing   = 1
		if("Wind")
			if(forced) proj.Paralyzing = 1
			else       proj.Shocking   = 1
		if("Poison")
			if(forced) proj.Toxic      = 1
			else       proj.Poisoning  = 1
		if("HellFire")
			proj.Scorching = 1
			proj.Toxic     = 1
		if("Ultima")
			proj.Scorching = 1
			proj.Freezing  = 1
			proj.Shattering = 1
			proj.Paralyzing = 1
			proj.Toxic     = 1
		if("Truth")
			if(prob(50))
				proj.Scorching  = 1
				proj.Toxic      = 1
			else
				proj.Freezing   = 1
				proj.Shattering = 1
				proj.Paralyzing = 1
		// Dark, Light, Void, Love, Death stuff later


//Actual skill
obj/Skills/Projectile/Gates_of_Babylon
	SignatureTechnique = 3
	name = "Gates of Babylon"
	Cooldown = 200
	CooldownStatic = 1

	Speed       = 0.25
	Distance    = 25
	DamageMult  = 0.5
	AccMult     = 1.5
	Homing      = 3
	HyperHoming = 1
	Instinct    = 1
	Striking    = 1

	ZoneAttack  = 1
	ZoneAttackX = 7
	ZoneAttackY = 7
	FireFromSelf  = 1
	FireFromEnemy = 0
	Hover   = 42   // (~4 seconds)
	Variation = 0

	ActiveMessage = "opens the Gates of Babylon, drawing forth weapons from the treasury of creation!"

	var/granted_enkidu      = FALSE
	var/granted_enuma_elish = FALSE

	proc/ProjCount()
		return 5 + (Mastery * 3)   // M1=8  M2=11  M3=14  M4=17  M5=20

	proc/CheckMasteryGrants(mob/p)
		if(Mastery >= 4 && !granted_enkidu)
			if(!locate(/obj/Skills/Projectile/Enkidu_Chains, p))
				p.AddSkill(new/obj/Skills/Projectile/Enkidu_Chains)
				p << "<font color='gold'><b>The Chains of Heaven, Enkidu, manifest within your treasury!</b></font>"
			granted_enkidu = TRUE

		if(Mastery >= 5 && !granted_enuma_elish)
			if(!locate(/obj/Skills/Projectile/Enuma_Elish, p))
				p.AddSkill(new/obj/Skills/Projectile/Enuma_Elish)
			if(!locate(/obj/Skills/Summon_Ea, p))
				p.AddSkill(new/obj/Skills/Summon_Ea)
			p << "<font color='gold'><b>The Sword of Rupturing Heaven, Ea, rests within your treasury — and with it, the power to shatter heaven itself.</b></font>"
			granted_enuma_elish = TRUE

	proc/FireGoBSalvo(mob/shooter, barrage_mode = FALSE)
		if(src.Using) return
		if(!shooter.Target || shooter.Target == shooter)
			shooter << "You need a target to use Gates of Babylon."
			return

		if(!gob_weapon_pool)
			gob_weapon_pool = BuildGoBWeaponPool()
		if(!gob_weapon_pool.len)
			shooter << "No weapons could be found in the treasury."
			return

		CheckMasteryGrants(shooter)

		var/count   = ProjCount()
		var/mastery = Mastery
		var/list/weapons = SelectGoBWeapons(gob_weapon_pool, count, mastery)
		var/forced  = (mastery >= 3)
		var/hover_t = barrage_mode ? 0 : Hover

		src.Cooldown(1, null, shooter)

		OMsg(shooter, "<b><font color='gold'>[shooter] [ActiveMessage]</font></b>")

		var/list/spawned_projs = list()

		for(var/entry in weapons)
			var/turf/spawn_t = locate(
				shooter.x + rand(-ZoneAttackX, ZoneAttackX),
				shooter.y + rand(-ZoneAttackY, ZoneAttackY),
				shooter.z
			)
			if(!istype(spawn_t, /turf)) spawn_t = shooter.loc

			var/old_lx = LockX
			var/old_ly = LockY
			var/px = entry["px"]
			var/py = entry["py"]
			LockX = px ? px : 0
			LockY = py ? py : 0

			var/old_hover = Hover
			if(barrage_mode) Hover = 0

			var/list/before = shooter.active_projectiles.Copy()
			shooter.Blast(src, spawn_t, 0, entry["icon"])

			LockX = old_lx
			LockY = old_ly
			if(barrage_mode) Hover = old_hover

			var/obj/Skills/Projectile/_Projectile/proj = null
			for(var/p in shooter.active_projectiles)
				if(!(p in before))
					proj = p
					break

			if(proj)
				if(!barrage_mode)
					proj.alpha = 0
					animate(proj, alpha = 128, time = max(1, hover_t - 6))
					proj.filters += filter(type="wave", x=2, y=2, size=1.5)
				else
					proj.filters += filter(type="wave", x=1, y=1, size=1.0)
					var/obj/Skills/Projectile/_Projectile/bf = proj
					spawn(8) if(bf) bf.filters = list()

				// Elemental debuff
				ApplyGoBElement(proj, entry["element"], forced)

				// Damage multiplier
				var/dmg = 1 + (mastery * 0.1)
				if(entry["legendary"]) dmg *= 1.5
				if(barrage_mode)       dmg *= 0.7   // barrage trades damage for speed
				proj.DamageMult *= dmg

				spawned_projs += proj

			if(barrage_mode)
				sleep(3)

		if(!barrage_mode)
			spawn(hover_t)
				for(var/obj/Skills/Projectile/_Projectile/p in spawned_projs)
					if(p && p.loc)
						p.filters = list()       // clear the hover ripple on launch
						animate(p, alpha = 255, time = 5)

			var/sentinel_count = 0
			if(mastery >= 2) sentinel_count = 1
			if(mastery >= 3) sentinel_count = 2
			if(sentinel_count > 0)
				spawn(hover_t + 8)
					SpawnGoBSentinels(shooter, sentinel_count, weapons, mastery)

	proc/SpawnGoBSentinels(mob/shooter, count, list/weapons, mastery)
		if(!shooter || !shooter.loc) return
		var/list/used_names = list()
		for(var/i = 1 to count)
			if(!shooter || !shooter.loc) return
			// Pick a weapon not already used as a sentinel this cast
			var/list/candidates = list()
			for(var/e in weapons)
				if(!(e["name"] in used_names))
					candidates += list(e)
			if(!candidates.len) break
			var/entry = candidates[rand(1, candidates.len)]
			used_names += entry["name"]

			var/obj/GoB_Sentinel/s = new(shooter.loc)
			s.icon      = entry["icon"]
			s.pixel_x   = entry["px"] ? entry["px"] : 0
			s.pixel_y   = entry["py"] ? entry["py"] : 0
			s.Owner     = shooter
			s.WeaponElement  = entry["element"]
			s.IsLegendary    = entry["legendary"]
			s.SentinelMastery = mastery
			s.OrbitOffset = (i - 1) * (360 / count)
			spawn()
				s.BeginOrbit()

	verb/Gates_of_Babylon()
		set category = "Skills"
		FireGoBSalvo(usr, FALSE)

	verb/Gates_of_Babylon_Barrage()
		set category = "Skills"
		if(Mastery < 3)
			usr << "<font color='red'>You haven't mastered the Gates of Babylon enough for Rapid Barrage.</font>"
			return
		FireGoBSalvo(usr, TRUE)


//  Sentinel Weapon Object
obj/GoB_Sentinel
	name      = "Treasury Weapon"
	icon      = 'SwordBlast2.dmi'
	density   = 0
	layer     = 4.5
	alpha     = 200
	Savable   = 0
	Buildable = 0
	mouse_opacity = 0
	animate_movement = 0

	Owner         = null
	var/WeaponElement     = null
	var/IsLegendary       = FALSE
	var/SentinelMastery   = 1
	var/OrbitOffset       = 0
	var/OrbitDuration     = 70

	proc/BeginOrbit()
		if(!Owner || !Owner.loc) { del src; return }

		var/R              = 22
		var/orbit_speed    = 15
		var/rotation_speed = 45
		var/step_delay     = 2

		var/orbit_angle    = OrbitOffset
		var/rotation_angle = 0
		var/list/orbit_images = list()
		var/elapsed = 0

		while(Owner && Owner.loc && elapsed < OrbitDuration)

			for(var/image/im in orbit_images)
				Owner.overlays -= im
			orbit_images = list()


			orbit_angle    = (orbit_angle    + orbit_speed)    % 360
			rotation_angle = (rotation_angle + rotation_speed) % 360


			var/px = round(cos(orbit_angle) * R)
			var/py = round(sin(orbit_angle) * R)
			var/image/im = image(icon = src.icon, pixel_x = px, pixel_y = py, layer = FLOAT_LAYER)
			im.transform = matrix().Turn(rotation_angle)
			Owner.overlays += im
			orbit_images   += im

			// Auto-attack one nearby enemy per step
			for(var/mob/m in view(2, Owner))
				if(!istype(m, /mob/Player)) continue
				if(m == Owner) continue
				if(Owner.party && (m in Owner.party.members)) continue
				var/dmg = Owner.GetStr() * 0.12
				if(IsLegendary) dmg *= 1.5
				dmg *= 1 + (SentinelMastery * 0.05)
				m.LoseHealth(dmg, Owner)
				if(WeaponElement)
					ElementalCheck(Owner, m, 0, bonusElements = list(WeaponElement))
				break

			sleep(step_delay)
			elapsed += step_delay

		for(var/image/im in orbit_images)
			if(Owner) Owner.overlays -= im
		if(src) del src


obj/Skills/Projectile/Enkidu_Chains
	SignatureTechnique = 3
	name = "Enkidu - Chains of Heaven"
	Cooldown = 120
	CooldownStatic = 1

	Speed      = 0.4
	Distance   = 20
	DamageMult = 1.0
	AccMult    = 1.3
	Homing     = 3
	HyperHoming = 1
	Instinct   = 2
	Striking   = 1
	Snaring    = 8

	ActiveMessage = "hurls the Chains of Heaven, Enkidu, to bind their target!"

	adjust(mob/p)
		var/obj/Skills/Projectile/Gates_of_Babylon/gob = locate(/obj/Skills/Projectile/Gates_of_Babylon, p)
		if(gob)
			Snaring    = 6 + (gob.Mastery * 2)     // M4=14, M5=16 ticks
			DamageMult = 0.8 + (gob.Mastery * 0.1)  // M4=1.2, M5=1.3

	verb/Enkidu_Chains()
		set category = "Skills"
		adjust(usr)
		usr.UseProjectile(src)


obj/Skills/Projectile/Enuma_Elish
	SignatureTechnique = 3
	name = "Enuma Elish"
	Cooldown = 300
	CooldownStatic = 1

	Speed       = 0.15
	Distance    = 35
	DamageMult  = 40
	AccMult     = 2.0
	Homing      = 3
	HyperHoming = 1
	Instinct    = 3
	Striking    = 1
	Explode     = 3
	Radius      = 3
	Dodgeable   = -1
	Deflectable = 0
	Scorching  = 1
	Freezing   = 1
	Shattering = 1
	Paralyzing = 1
	Toxic      = 1
	IconLock   = 'Hellnova.dmi'
	LockX      = -32
	LockY      = -32
	ProjectileSpin = 8

	ActiveMessage = "channels the Sword of Rupturing Heaven — Enuma Elish!"

	proc/ChargeEnumaElish(mob/shooter, mob/target)
		var/charge_start = world.time

		spawn()
			while(shooter && shooter.loc && (world.time - charge_start) < 150)
				LightningStrikeRed(shooter, Offset = 2)
				sleep(rand(12, 20))

		sleep(50)

		if(!shooter || !shooter.loc) return

		var/turf/above = locate(shooter.x, shooter.y + 2, shooter.z)
		if(!istype(above, /turf)) above = shooter.loc

		var/obj/EaVisual/ev = new(above)
		ev.transform = matrix().Scale(0.2)
		ev.particles = new/particles/ea_gathering
		ev.filters += filter(type = "bloom", threshold = 0.1, size = 6, offset = 0)

		spawn()
			while(ev && ev.loc && shooter && shooter.loc)
				var/turf/t = locate(shooter.x, shooter.y + 2, shooter.z)
				if(istype(t, /turf)) ev.loc = t
				sleep(1)

		for(var/step = 1 to 5)
			sleep(20)
			if(!ev || !ev.loc || !shooter || !shooter.loc) break
			animate(ev, transform = matrix().Scale(0.2 + (step * 0.2)), time = 18)

		var/turf/fire_pos = (ev && ev.loc) ? ev.loc : shooter.loc
		if(ev)
			ev.particles = null
			animate(ev, alpha = 0, time = 5)
			sleep(5)
			if(ev) del ev

		if(!shooter || !shooter.loc) return
		if(shooter.Target && shooter.Target != shooter)
			target = shooter.Target
		if(!target || !target.loc || target == shooter) return

		OMsg(shooter, "<b><font color='gold'>[shooter] [ActiveMessage]</font></b>")
		shooter.Blast(src, fire_pos, 0)

	verb/Enuma_Elish()
		set category = "Skills"
		if(src.Using) return

		var/obj/Items/Sword/Medium/Legendary/Ea/ea = locate(/obj/Items/Sword/Medium/Legendary/Ea, usr)
		if(!ea || !ea.suffix)
			usr << "<font color='red'>Ea must be equipped to use Enuma Elish.</font>"
			return

		if(!usr.Target || usr.Target == usr)
			usr << "You need a target to use Enuma Elish."
			return

		src.Cooldown(1, null, usr)
		usr << "<font color='gold'><b>The air tears apart as Ea begins to rotate...</b></font>"

		var/mob/target = usr.Target
		spawn()
			ChargeEnumaElish(usr, target)


obj/Skills/Summon_Ea
	name = "Summon Ea"
	SignatureTechnique = 3

	verb/Summon_Ea()
		set category = "Skills"
		var/obj/Items/Sword/Medium/Legendary/Ea/ea = locate(/obj/Items/Sword/Medium/Legendary/Ea, usr)
		if(ea)

			if(ea.suffix) ea.UnEquip(usr)
			del ea
			usr << "<font color='#aaaaff'>You return Ea to the Gates of Babylon.</font>"
		else

			var/obj/Items/Sword/S = usr.EquippedSword()
			if(S)
				usr << "<font color='red'>You must unequip your weapon before summoning Ea.</font>"
				return

			ea = new/obj/Items/Sword/Medium/Legendary/Ea(usr)
			ea.Equip(usr)
			usr << "<font color='gold'><b>Ea, the Sword of Rupturing Heaven, descends from the treasury!</b></font>"


obj/EaVisual
	name         = "Enuma Elish"
	icon         = 'Hellnova.dmi'
	density      = 0
	layer        = FLOAT_LAYER
	mouse_opacity = 0
	alpha        = 220
	Savable      = 0
	Buildable    = 0
