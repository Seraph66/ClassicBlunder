/obj/Skills/Buffs/SlotlessBuffs/Autonomous/
	FaeBuffs //I actually want to turn these into toggleable buffs instead of automatic. Working on doing that.
		NeedsHealth = 50
		TooMuchHealth = 75
		TooLittleMana=1
		TextColor=rgb(95, 60, 95)
		ActiveMessage="is consumed by magical vigor!"
		OffMessage = "Their mana-enhanced power fades..."
		adjust(mob/p)

		Fury_of_the_Small //Angry Short Person Syndrome
			NeedsHealth = 50
			TooMuchHealth = 75
			TooLittleMana=1
			ActiveMessage = "channels the fury of short people!"
			OffMessage = "is no longer angry, but still short..."
			adjust(mob/p)
				if(altered) return
				var/asc = p.AscensionsAcquired
				spdAdd = 0.15 * asc
				ManaDrain = 0.01 +(0.001 *asc) //This should force mana to drain from being active.
				passives = list("ManaStats" = (1+(asc/2)), "Fury" = (1+(asc/2)), "Brutalize" = (0.5*(asc+1)),\
								"SpiritHand" = (0.5*(asc+1)), "SpiritSword" = (0.5*(asc+1)), "ManaLeak" = (4-(0.5*asc)) )
			Trigger(mob/User, Override = FALSE)
				if(!User.BuffOn(src))
					adjust(User)
				..()

		Pixie_Mania // Manic Pixie Dream Girl
			NeedsHealth = 50
			TooMuchHealth = 75
			TooLittleMana=1
			ActiveMessage = "becomes consumed by a fit of manic laughter!"
			OffMessage = "regains their sanity..."
			adjust(mob/p)
				if(altered) return
				var/asc = p.AscensionsAcquired
				forAdd = 0.15 * asc
				ManaDrain = 0.01 +(0.001 *asc) //This should force mana to drain from being active.
				passives = list("ManaStats" = (1+(asc/2)), "DebuffResistance" = (0.5*(asc+1)), "Reversal" = (0.5*(asc+1)),\
								"TurningCharge" = 1, "MovingCharge" = 1, "ManaLeak" = (4-(0.5*asc)) ) //Does Moving Charge make Turning Charge irrelevant? I have NO IDEA.
			Trigger(mob/User, Override = FALSE)
				if(!User.BuffOn(src))
					adjust(User)
				..()

//Insert Fae-Specific spells here. These should all cost Mana.
//Hideous Laughter: circle-AoE that does little-to-no damage, brief stun from laughing, then applies a debuff. Pixies
//Pack Tactics: Party-wide buff to hitting and dodging. Goblin. Maybe make Goblins have a stronger effect from it. Together... Goblin...strong.