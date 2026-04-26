obj/Skills/Buffs/NuStyle/NobodyLegendary
	CyberSignature = 1
	Legacy_of_Ashes // T0/1. This is based on the Legendary styles from last wipe. Fire/Sword
		SignatureTechnique=1
		NeedsSword = 1
		Copyable=0
		StyleSpd=1.3
		StyleStr=1.15
		ElementalOffense="Fire"
		ElementalDefense="Fire"
		passives = list("BlurringStrikes" = 1, "GodSpeed" = 1, "Momentum" = 1, "DoubleStrike" = 1, "Instinct" = 2, "Iaido" = 1, "Iaijutsu" = 1,\
						"Musoken" = 1, "BurnHit" = 30, "Combustion" = 30, "Parry" = 2,"Ashen One" = 1)
		StyleActive="Legacy of Ashes"
		Finisher="/obj/Skills/Queue/Finisher/Session"
		verb/Legacy_of_Ashes()
			set hidden=1
			adjust(usr)
			src.Trigger(usr)