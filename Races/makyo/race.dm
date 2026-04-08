race
	makyo
		name = "Makyo" //PLACEHOLDER
		desc = "These spiritual beings are rumored to have connections to the Courts of the Fae.."
		visual = 'Makyos.png'
		locked = FALSE
		strength = 1.5
		endurance = 1.75
		speed = 1
		force = 1 // 1.25?
		offense = 1.25 // 1.25?
		defense = 1
		imagination = 2
		skills = list(/obj/Skills/Buffs/SlotlessBuffs/Makyo/Awaken_Star_Power)
		passives = list("Juggernaut" = 0.5, "DemonicDurability" = 0.5, "HeavyHitter" = 0.5)
		onFinalization(mob/user)
			. = ..()