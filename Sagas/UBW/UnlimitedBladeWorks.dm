mob/var/usingUBW = FALSE

mob/var/tmp/domainExpansionActive = 0
mob/var/tmp/list/domainExpansionFloors = null
mob/var/tmp/list/domainExpansionBarriers = null
turf/var/tmp/mob/domain_expansion_owner = null

obj/DomainExpansionBarrier
	name = "Domain Boundary"
	icon = 'Roofs.dmi'
	icon_state = "Roof1"
	color = "#000000"
	density = 1
	opacity = 1
	mouse_opacity = 0
	Savable = 0
	Enter(atom/A)
		return 0

obj/DomainExpansionRoof
	name = "Domain Shroud"
	icon = 'Roofs.dmi'
	icon_state = "Roof1"
	color = "#000000"
	alpha = 170
	density = 0
	opacity = 0
	mouse_opacity = 0
	Savable = 0

/mob/Admin3/verb/GiveDomainExpansion()
	set category = "Admin"
	set name = "Give Domain Expansion"
	var/demonName = input(src, "What is the name of the Demon? (e.g. 'Malovent Imperium' -> activation says 'X says: Domain Expansion.. Malovent Imperium')", "Domain Expansion - Name") as text|null
	if(!demonName || !length(demonName))
		src << "Cancelled. No demon name provided."
		return
	var/icon/customTurfIcon = input(src, "Upload the custom floor icon for the Domain (32x32 .dmi, single state).", "Domain Expansion - Turf Icon") as icon|null
	if(!customTurfIcon)
		src << "Cancelled. No custom turf icon provided."
		return
	var/rawRange = input(src, "Range of the Domain Expansion (1 to 50).", "Domain Expansion - Range", 10) as num|null
	if(isnull(rawRange))
		src << "Cancelled. No range provided."
		return
	var/finalRange = round(rawRange)
	if(finalRange < 1) finalRange = 1
	if(finalRange > 50) finalRange = 50
	var/mob/p = input(src, "Who to give this Domain Expansion to?", "Domain Expansion - Recipient") in players
	if(!p)
		src << "Cancelled. No recipient."
		return
	var/obj/Skills/Buffs/SlotlessBuffs/Domain_Expansion/d = new()
	d.demonName = demonName
	d.customTurfIcon = customTurfIcon
	d.range = finalRange
	d.ActiveMessage = "says: Domain Expansion.. [demonName]!"
	d.OffMessage = "conceals the domain of [demonName]..."
	p.AddSkill(d)
	src << "Gave [p] a Domain Expansion ([demonName], range [finalRange])."


mob
	proc
		DomainExpansion(obj/Skills/Buffs/SlotlessBuffs/Domain_Expansion/buff)
			if(!buff)
				return
			if(!buff.customTurfIcon)
				AdminMessage("[src] tried to use Domain Expansion but the buff has no custom turf icon set. Recreate the skill via Give Domain Expansion.")
				src << "Your Domain Expansion is not set up. Admins alerted."
				return
			if(src.domainExpansionActive)
				return
			var/useRange = buff.range
			if(useRange < 1) useRange = 1
			if(useRange > 50) useRange = 50
			var/centerX = src.x
			var/centerY = src.y
			var/centerZ = src.z
			var/list/floors = list()
			var/list/barriers = list()
			var/icon/floorIcon = buff.customTurfIcon
			for(var/turf/t in range(useRange, src))
				if(t.domain_expansion_owner && t.domain_expansion_owner != src)
					continue
				var/dist = max(abs(t.x - centerX), abs(t.y - centerY))
				if(t.z != centerZ)
					continue
				if(dist == useRange)
					var/obj/DomainExpansionBarrier/b = new(t)
					barriers += b
					t.domain_expansion_owner = src
					floors[t] = list(null, null)
				else
					var/list/backup = list(t.icon, t.icon_state)
					t.icon = floorIcon
					t.icon_state = ""
					var/obj/DomainExpansionRoof/r = new(t)
					barriers += r
					t.domain_expansion_owner = src
					floors[t] = backup
			src.domainExpansionFloors = floors
			src.domainExpansionBarriers = barriers
			src.domainExpansionActive = 1


		stopDomainExapansion()
			if(!src.domainExpansionActive)
				return
			if(src.domainExpansionBarriers)
				for(var/obj/b in src.domainExpansionBarriers)
					if(b)
						del(b)
			if(src.domainExpansionFloors)
				for(var/turf/t in src.domainExpansionFloors)
					if(!t)
						continue
					if(t.domain_expansion_owner != src)
						continue
					var/list/backup = src.domainExpansionFloors[t]
					if(backup && backup.len >= 2 && backup[1] != null)
						t.icon = backup[1]
						t.icon_state = backup[2]
					t.domain_expansion_owner = null
			src.domainExpansionFloors = null
			src.domainExpansionBarriers = null
			src.domainExpansionActive = 0


		UnlimitedBladeWorks()
			if(usingUBW) return
			var/list/targets = list()
			for(var/mob/m in range(15))
				targets |= m
			if(!fexists("Maps/map_[src.UniqueID]_UBW.sav"))
				SwapMaps_SaveChunk("[src.UniqueID]_UBW", locate(1,71,1), locate(61, 121,1))
				SwapMaps_Save("[src.UniqueID]_UBW")

			var/swapmap/newMap = SwapMaps_CreateFromTemplate("[src.UniqueID]_UBW")
			var/turf/center = newMap.CenterTile()
			usingUBW = TRUE
			for(var/mob/teleportThese in targets)
				teleportThese.PrevX=teleportThese.x
				teleportThese.PrevY=teleportThese.y
				teleportThese.PrevZ=teleportThese.z
				teleportThese.in_tmp_map = newMap.id
				teleportThese.loc = locate(center.x+rand(-10,10), center.y+rand(-10,10), center.z)

		stopUnlimitedBladeWorks()
			if(!usingUBW) return
			var/swapmap/map = swapmaps_byname[in_tmp_map]
			usingUBW = FALSE
			if(!map)
				return
			for(var/turf/t in block(locate(map.x1, map.y1, map.z1), locate(map.x2, map.y2, map.z2)))
				for(var/mob/m in t)
					if(isnull(m.PrevX) || isnull(m.PrevY) || isnull(m.PrevZ))
						continue
					m.loc = locate(m.PrevX, m.PrevY, m.PrevZ)
					m.PrevX = null
					m.PrevY = null
					m.PrevZ = null
					m.in_tmp_map = null
			map.Del()
