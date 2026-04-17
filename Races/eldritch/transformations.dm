transformation
	eldritch
		partial_manifestation
			passives = list("Unreality" = 0.1, "Half Manifestation" = 1, "PureDamage"=2, "PureReduction"=2,"DebuffResistance"=0.1, "BuffMastery"=3)
			enduranceadd = 0.5
			offenseadd = 0.5
			defenseadd = 0.5
			strengthadd = 0.5
			forceadd = 0.5
			form_icon_1_icon = 'tentacles_overlay.dmi'
			form_icon_1_x = -32
			form_icon_1_y = -32
		full_manifestation
			passives = list("Unreality" = 0.9, "Full Manifestation" = 1, "PureDamage"=3, "PureReduction"=3,"DebuffResistance"=0.1, "BuffMastery"=3)
			enduranceadd = 1.5
			offenseadd = 1.5
			defenseadd = 1.5
			strengthadd = 1.5
			forceadd = 1.5
/mob/proc/HandleManifestation(var/Stat)
	var/CA=AscensionsAcquired
	var/TA=3
	var/Total
	if(passive_handler.Get("Full Manifestation"))
		TA=6
	if(CA<3)
		Total=PullAscensionStats(CA, TA, Stat)
	else if(CA>=3 && CA<6)
		Total=PullAscensionStats(CA, CA+1, Stat)
	else
		Total=PullAscensionStats(CA, TA, Stat)
	return Total