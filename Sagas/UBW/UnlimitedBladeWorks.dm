mob/var/usingUBW = FALSE

/mob/Admin3/verb/GiveDomainExpansion()
	set category = "Admin"
	set name = "Give Domain Expansion"
	var/identifier = input(src, "What is the identifier for this domain, exact? (e.g. 'foo' will use Maps/map_foo_Domain.sav)") as text|null
	if(!identifier)
		src << "Cancelled."
		return
	var/expectedMap = "[identifier]_Domain"
	if(!fexists("Maps/map_[expectedMap].sav"))
		var/makeIt = alert(src, "No map file Maps/map_[expectedMap].sav exists yet. Create one now?",, "Yes", "No")
		if(makeIt != "Yes")
			src << "Cancelled. Create the domain map first with CreateSwapMap, using the name '[expectedMap]'."
			return
		var/firstX = input(src, "X1?") as null|num
		var/firstY = input(src, "Y1?") as null|num
		var/secondX = input(src, "X2?") as null|num
		var/secondY = input(src, "Y2?") as null|num
		var/Z = input(src, "Z?") as null|num
		if(isnull(firstX) || isnull(firstY) || isnull(secondX) || isnull(secondY) || isnull(Z))
			src << "Cancelled. Domain map coords incomplete."
			return
		SwapMaps_SaveChunk(expectedMap, locate(firstX, firstY, Z), locate(secondX, secondY, Z))
		SwapMaps_Save(expectedMap)
		src << "Saved domain map as Maps/map_[expectedMap].sav."
	var/obj/Skills/Buffs/SlotlessBuffs/Domain_Expansion/d = new()
	d.range = input(src, "What is the range of the domain activation when used wide?") as num
	d.identifier = identifier
	var/mob/p = input(src, "Who to give to?") in players
	if(!p) return
	src?:Edit(d)
	p.AddSkill(d)



mob
	proc
		DomainExpansion(identifier, range, target)
			if(!fexists("Maps/map_[identifier]_Domain.sav"))
				AdminMessage("[src] tried to use Domain Expansion but no map file exists. The file should be at Maps/map_[identifier]_Domain.sav. Create it with CreateSwapMap using the name '[identifier]_Domain' (no 'map_' prefix - the engine adds it).")
				src << " No Domain Map, Admins Alerted . . . "
				return
			var/list/targets = list()
			if(target && Target)
				targets += Target
				targets += src
			else if(range)
				for(var/mob/m in range(range))
					if(m.client)
						targets |= m
			if(!targets.len)
				return
			var/swapmap/newMap = SwapMaps_CreateFromTemplate("[identifier]_Domain")
			if(!newMap)
				AdminMessage("[src]'s Domain Expansion failed: map_[identifier]_Domain could not be loaded.")
				src << " Domain Map failed to load."
				return
			var/turf/center = newMap.CenterTile()
			if(!center)
				AdminMessage("[src]'s Domain Expansion failed: loaded map has no center turf.")
				return
			for(var/mob/teleportThese in targets)
				teleportThese.PrevX=teleportThese.x
				teleportThese.PrevY=teleportThese.y
				teleportThese.PrevZ=teleportThese.z
				teleportThese.in_tmp_map = newMap.id
				teleportThese.loc = locate(center.x+rand(-10,10), center.y+rand(-10,10), center.z)


		stopDomainExapansion()
			var/swapmap/map = swapmaps_byname[in_tmp_map]
			for(var/turf/t in block(map.x1, map.y1, map.z1, map.x2, map.y2))
				for(var/mob/m in t)
					m.x = m.PrevX
					m.y = m.PrevY
					m.z = m.PrevZ
					m.PrevX = null
					m.PrevY = null
					m.PrevZ = null
					m.in_tmp_map = null
			map.Del()


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
			for(var/turf/t in block(map.x1, map.y1, map.z1, map.x2, map.y2))
				for(var/mob/m in t)
					m.x = m.PrevX
					m.y = m.PrevY
					m.z = m.PrevZ
					m.PrevX = null
					m.PrevY = null
					m.PrevZ = null
					m.in_tmp_map = null
			map.Del()