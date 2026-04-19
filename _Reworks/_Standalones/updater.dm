/*
essentially check if we are -on update x, if not, update to x, if so, do nothing
*/

// make it so on world load we make the current version datum and use it for all people
proc/generateVersionDatum()
	var/update/updateversion
	for(var/i in subtypesof(/update))
		if(!ispath(i)) continue
		var/update/check = new i
		if(!check) continue
		if(updateversion && check.version > updateversion.version)
			updateversion = check
		else if (!updateversion)
			updateversion = check
	if(updateversion)
		glob.currentUpdate = updateversion

globalTracker
	var/UPDATE_VERSION = 3
	var/tmp/update/currentUpdate

	proc/updatePlayer(mob/p)
		if(!p.updateVersion)
			var/updateversion = "/update/version[UPDATE_VERSION]"
			p.updateVersion = new updateversion
			p.updateVersion.updateMob(p)
		if(UPDATE_VERSION == p.updateVersion.version)
			return
		if(p.updateVersion.version + 1 == UPDATE_VERSION)
			var/updateversion = "/update/version[p.updateVersion.version + 1]"
			var/update/update = new updateversion
			update.updateMob(p)
		else if(p.updateVersion.version + 1 < UPDATE_VERSION)
			for(var/x in 1 to abs(p.updateVersion.version - UPDATE_VERSION))
				// get the number of updates we are missing
				var/updateversion = "/update/version[p.updateVersion.version + 1]"
				var/update/update = new updateversion
				update.updateMob(p)


mob/var/update/updateVersion

update
	var/version = 1

	proc/updateMob(mob/p)
		if(version>1) p << "You have been updated to version [version]"
		p.updateVersion = src

	version1
		version = 1;
		updateMob(mob/p)
			. = ..()//left alone for easy copy pasting
	version2
		version = 2;
		updateMob(mob/p)
			. = ..()//left alone for easy copy pasting
			if(p.isRace(ELDRITCH))
				p.race.transformations += new /transformation/eldritch/partial_manifestation()
				p.race.transformations += new /transformation/eldritch/full_manifestation()
			if(p.isRace(HUMAN))
				if(p.Class=="Resourceful")
					for(var/x in p.knowledgeTracker.learnedKnowledge)
						p<<"You have had [x] refunded. (Tech)"
						var/theCost=glob.TECH_BASE_COST / p.Intelligence
						p.removeTechKnowledge(p, x, theCost, FALSE)
						del x
					for(var/x in p.knowledgeTracker.learnedKnowledge)
						if(x in EnchantmentKnowledge)
							del x
							p<<"You have had [x] refunded. (ench)"
					for(var/obj/Skills/S in p.Skills)
						if(S.Copyable>0&&S.SkillCost>1&&!S.Copied)
							p.refund_skill(S)
					p.RPPSpent=0
					p.RPPSpendable=p.RPPCurrent
					p.Intelligence=3
					p.AngerMax=1.25
					p.RPPMult=1.25
					p.Imagination=3
					p.ChooseSpawn()
					if(p.AscensionsAcquired==1)
						p.SpdAscension=0.4
	version3
		version = 3;
		updateMob(mob/p)
			. = ..()//left alone for easy copy pasting
			var/list/BasicElementPinnacles = list("Alight", "Awash", "Aerde", "Aloft")
			var/list/AdvancedElementPinnacles = list("Mender", "Survivor", "Future", "Kinematics")
			for(var/mage_passive/mp in p.acquiredMagePassives)
				if(mp.name in BasicElementPinnacles)
					mp.passives["ManaGeneration"] = 1;
					p.passive_handler.Decrease("ManaGeneration", 2);
					p << "Your Basic Element Pinnacles have had their Mana Generation reduced. This should only trigger once per element."
				if(mp.name in AdvancedElementPinnacles)
					mp.passives["ManaGeneration"] = 2;
					p.passive_handler.Decrease("ManaGeneration", 3);
					p << "Your Advanced Element Pinnacles have had their Mana Generation reduced. This should only trigger once per element."
				
					

/globalTracker/var/COOL_GAJA_PLAYERS = list("Thorgigamax", "Gemenilove" )
/globalTracker/var/GAJA_PER_ASC_CONVERSION = 0.25
/globalTracker/var/GAJA_MAX_EXCHANGE = 1

/mob/proc/gajaConversionCheck()
	if(key in glob.COOL_GAJA_PLAYERS)
		verbs += /mob/proc/ExchangeMinerals

/mob/proc/gajaConversionRateUpdate()
	if(isRace(GAJALAKA) && key in glob.COOL_GAJA_PLAYERS)
		var/asc = AscensionsAcquired
		var/ascRate = 0.5 + (glob.GAJA_PER_ASC_CONVERSION * asc) // 1.25 max
		for(var/obj/Money/moni in src)
			if(moni.Level >= 10000)
				var/boon = round(moni.Level * 0.00001, 0.1)
				if(boon > glob.GAJA_MAX_EXCHANGE) // so 1.75 total
					boon = glob.GAJA_MAX_EXCHANGE
				playerExchangeRate = ascRate + boon

