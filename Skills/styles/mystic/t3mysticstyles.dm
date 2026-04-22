/obj/Skills/Buffs/NuStyle/MysticStyle
// TODO: Deterioration - make energy/mana cost more
//
	Oblivion_Storm
		SignatureTechnique = 3
		passives = list("DemonicInfusion" = 1, "IceHerald" = 1, "ThunderHerald" = 1, "Heavy Strike" = "HellfireInferno", \
		            "Chaos" = 15, "Scorching" = 15, "Combustion" = 80, "IceAge" = 25, "SpiritFlow" = 4, "Familiar" = 3,\
		            "CriticalChance" = 35, "CriticalDamage" = 0.25,"Harden" = 2, "WaveDancer" = 2)
		StyleFor = 1.6
		StyleSpd = 1.2
		StyleOff = 1.2
		StyleActive = "Oblivion Storm"
		Finisher="/obj/Skills/Queue/Finisher/Soul_Seller"
		verb/Oblivion_Storm()
			set hidden=1
			src.Trigger(usr)
	Annihilation
		SignatureTechnique = 3
		passives = list("Atomizer" = 1, "BetterAim" = 3, "SuperCharge" = 2, "Familiar" = 3, "SpiritFlow" = 4, \
		            "ThunderHerald" = 1, "CriticalChance" = 25, "CriticalDamage" = 0.1, "Godspeed" = 3, "AirBend" = 2, \
		            "Harden" = 2, "Scorching" = 8, "Shattering" = 8, "Shocking" = 8, "Freezing" = 8)
		StyleFor = 1.5
		StyleOff = 1.5
		StyleActive = "Annihilation"
		Finisher="/obj/Skills/Queue/Finisher/Atomic_Dismantling"
		verb/Annihilation()
			set hidden=1
			src.Trigger(usr)
	Omnimancer
		SignatureTechnique = 3
		passives = list("Deterioration" = 1, "Erosion" = 0.15, "SpiritFlow" = 4, "Amplify" = 3, "LikeWater" = 4)
		ElementalDefense = "Void"
		ElementalOffense = "Void"
		StyleFor = 1.3
		StyleOff = 1.15
		StyleDef = 1.15
		StyleActive="Singularity"
		var/obj/Skills/demonSkill = FALSE
		Trigger(mob/User, Override)
			if(!demonSkill)
				var/inp = input(User, "What demon skill do you want?") in list("/obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/Hellstorm", "/obj/Skills/Projectile/Magic/HellFire/Hellpyre", "/obj/Skills/Buffs/SlotlessBuffs/Magic/HellFire/OverHeat")
				BuffTechniques = list(inp)
				demonSkill = inp
		proc/swap_stance(o)
			switch(o)
				if("blizzard")
					ElementalOffense = "Water"
					ElementalDefense = "Wind"
					ElementalClass = list("Wind","Water")
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Water"
					passives = list("IceHerald" = 1,"Familiar" = 2, "ThunderHerald" = 1, "CriticalChance" = 20, "CriticalDamage" = 0.2, "SpiritFlow" = 4, "Harden" = 2, \
					                "Freezing" = 5, "Shocking" = 5, "WaveDancer" = 1.5)
					Finisher="/obj/Skills/Queue/Finisher/Frostfist"
					StyleActive = "Blizzard"
					StyleOff=1.15
					StyleSpd=1.15
					StyleFor=1.3
				if("hellfire")
					passives = list("SpiritFlow" = 4, "Familiar" = 2, "Combustion" = 60, "Heavy Strike" = "Inferno",\
						"Scorching" = 1)
					ElementalOffense = "HellFire"
					ElementalDefense = "Fire"
					ElementalClass = "Fire"
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Fire"
					StyleFor = 1.6
					Finisher="/obj/Skills/Queue/Finisher/Deal_with_the_Devil"
					StyleActive = "Hellfire"
				if("plasma")
					ElementalOffense = "Wind"
					ElementalDefense = "Fire"
					ElementalClass = list("Fire","Wind")
					StyleFor = 1.3
					StyleSpd = 1.3
					BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Aura/Earth"
					passives = list("SuperCharge" = 1,"Familiar" = 2, "SpiritFlow" = 4, "ThunderHerald" = 1, "CriticalChance" = 20, "CriticalDamage" = 0.1, \
					                "Godspeed" = 2, "AirBend" = 1.5, "Harden" = 2, "Burning" = 2, "Shattering" = 5, "Shocking" = 2, "Chilling" = 2)
					Finisher="/obj/Skills/Queue/Finisher/Mega_Arm" // Super_mega_buster
					StyleActive = "Plasma"
				if("singularity")
					passives = list("Deterioration" = 1, "Erosion" = 0.15, "SpiritFlow" = 4, "Amplify" = 3, "LikeWater" = 4, /* ??? */)
					ElementalDefense = "Void"
					ElementalOffense = "Void"
					StyleFor = 1.3
					StyleOff = 1.15
					StyleDef = 1.15
					StyleActive="Singularity"
					Finisher="/obj/Skills/Queue/Finisher/The_Void"
		verb/Blizzard_Stance()
			set category="Stances"
			if(usr.BuffOn(src))
				turnOff(usr)
			swap_stance("blizzard")
			Trigger(usr, 1)
			giveBackTension(usr)
		verb/Hellfire_Stance()
			set category="Stances"
			if(usr.BuffOn(src))
				turnOff(usr)
			swap_stance("hellfire")
			Trigger(usr, 1)
			giveBackTension(usr)
		verb/Plasma_Stance()
			set category="Stances"
			if(usr.BuffOn(src))
				turnOff(usr)
			swap_stance("plasma")
			Trigger(usr, 1)
			giveBackTension(usr)
		verb/Singularity_Stance()
			set category="Stances"
			if(usr.BuffOn(src))
				turnOff(usr)
			swap_stance("singularity")
			Trigger(usr, 1)
			giveBackTension(usr)
	Gamma_Style
		SignatureTechnique = 3
		StyleActive = "Betel"
		passives = list("SpiritFlow" = 4, "LikeWater" = 4, "Adaptation" = 4, "Steady" = 4)
		StyleStr = 1.3
		StyleSpd = 1.3
		StyleFor = 1
		StyleEnd = 1
		StyleOff = 1
		StyleDef = 1
		ElementalClass = "Fire"
		ElementalOffense = "Fire"
		ElementalDefense = "Fire"
		Finisher = "/obj/Skills/Queue/Finisher/Sorblow"
		var/lastSlide = 0
		var/gulusActive = 0
		verb/Gamma_Style()
			set hidden=1
			src.Trigger(usr)
		proc/swap_stance(o)
			switch(o)
				if("betel")
					StyleActive = "Betel"
					StyleStr = 1.3
					StyleSpd = 1.3
					StyleFor = 1
					StyleEnd = 1
					StyleOff = 1
					StyleDef = 1
					ElementalClass = "Fire"
					ElementalOffense = "Fire"
					ElementalDefense = "Fire"
					passives = list("Scorching" = 2, "Combustion" = 60, "SpiritHand" = 4, "HeavyStrike" = "Inferno", "Fa Jin" = 2, "Instinct" = 4, "Momentum" = 3)
					Finisher = "/obj/Skills/Queue/Finisher/Sorblow"
				if("kaus")
					StyleActive = "Kaus"
					StyleStr = 1.25
					StyleSpd = 1.6
					StyleFor = 1.25
					StyleEnd = 0.85
					StyleOff = 1
					StyleDef = 1
					ElementalClass = "Wind"
					ElementalOffense = "Wind"
					ElementalDefense = "Wind"
					passives = list("BlurringStrikes" = 3, "Shocking" = 2, "Flicker" = 4, "Flow" = 4, "Speed Force" = 1, "AttackSpeed" = 2, "Skimming" = 2)
					Finisher = "/obj/Skills/Queue/Finisher/Urda_Impulse"
				if("wezen")
					StyleActive = "Wezen"
					StyleStr = 1.2
					StyleSpd = 0.8
					StyleFor = 1.5
					StyleEnd = 1.5
					StyleOff = 1
					StyleDef = 1
					ElementalClass = "Earth"
					ElementalOffense = "Earth"
					ElementalDefense = "Earth"
					passives = list("Harden" = 5, "Blubber" = 4, "Extend" = 2, "Gum Gum" = 2, "GiantForm" = 1, "Juggernaut" = 4, "Shattering" = 5)
					Finisher = "/obj/Skills/Queue/Finisher/Albion"
				if("gulus")
					StyleActive = "Gulus"
					StyleStr = 1.5
					StyleSpd = 1.5
					StyleFor = 1.5
					StyleEnd = 1.5
					StyleOff = 1.5
					StyleDef = 1.5
					ElementalClass = "Dark"
					ElementalOffense = "Dark"
					ElementalDefense = "Dark"
					passives = list("HellPower" = 0.25, "AbyssMod" = 5, "DemonicDurability" = 5, "HellRisen" = 0.5, "SpiritHand" = 4, "SpiritFlow" = 4, "AngerAdaptiveForce" = 0.25, "Scorching" = 5, "Poisoning" = 5)
					Finisher = "/obj/Skills/Queue/Finisher/Desdemona"
		verb/Slide_Evolution()
			set category="Stances"
			if(StyleActive == "Gulus")
				usr << "Slide Evolution is sealed while in Gulus."
				return
			if(lastSlide + 300 > world.time)
				var/remaining = round((lastSlide + 300 - world.time) / 10, 0.1)
				usr << "Slide Evolution is on cooldown: [remaining]s remaining."
				return
			var/next_stance
			switch(StyleActive)
				if("Betel")
					next_stance = "kaus"
				if("Kaus")
					next_stance = "wezen"
				if("Wezen")
					next_stance = "betel"
				else
					next_stance = "betel"
			if(usr.BuffOn(src))
				turnOff(usr)
			swap_stance(next_stance)
			Trigger(usr, 1)
			giveBackTension(usr)
			lastSlide = world.time
		verb/Dark_Evolution()
			set category="Stances"
			if(StyleActive == "Gulus")
				usr << "You are already in Gulus."
				return
			if(usr.Health > 25)
				usr << "Dark Evolution can only be invoked at 25 Health or less."
				return
			var/mob/owner = usr
			var/obj/Skills/Gamma_Dark_Evolution_Lock/lock = owner.FindSkill(/obj/Skills/Gamma_Dark_Evolution_Lock)
			if(!lock)
				lock = new /obj/Skills/Gamma_Dark_Evolution_Lock
				owner.AddSkill(lock)
			if(lock.Using)
				owner << "Dark Evolution has already been invoked this fight. You must meditate to restore it."
				return
			if(owner.BuffOn(src))
				turnOff(owner)
			swap_stance("gulus")
			Trigger(owner, 1)
			giveBackTension(owner)
			lock.Using = 1
			gulusActive = 1
			spawn(600)
				if(!gulusActive)
					return
				gulusActive = 0
				if(!owner || owner.StyleBuff != src)
					return
				if(StyleActive != "Gulus")
					return
				if(!owner.BuffOn(src))
					return
				turnOff(owner)
				swap_stance("betel")
				Trigger(owner, 1)
				giveBackTension(owner)
				owner << "Gulus fades; you return to Betel."

/obj/Skills/Gamma_Dark_Evolution_Lock
	name = "Dark Evolution"
	Cooldown = -1
