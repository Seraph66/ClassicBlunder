/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff
	BlackFlash_Potential
		BuffName = "120% Potential"
		Mastery=-1
		UnrestrictedBuff=1
		StrMult=1.25
		ForMult=1.25
		EndMult=1.25
		SpdMult=1.25
		DefMult=1.25
		OffMult=1.25
		TimerLimit=90
		passives = list("TechniqueMastery" = 5, "BuffMastery" = 5, "MovementMastery" = 10) // this is temp i just grabbed that shit from x-antibody LOL
		FlashChange=1
		ActiveMessage="gets in tune with their energy output, unlocking 120% of their potential!"
		OffMessage="cools down."
		adjust(mob/p)
			var/e = p.secretDatum.secretVariable["BlackFlashFirstTimeUse"]
			if (e == 1)
				ActiveMessage="...!"
				spawn()
					usr.secretDatum.secretVariable["BlackFlashFirstTimeUse"] = 0
					usr.OMessage(10, "<font color='#f7da1b'>It is not a technique you'd be able to see commonly. Not in these parts.</font>")
					sleep(30)
					usr.OMessage(10, "<font color='#f7da1b'>Most would simply use their energy to empower their whole body all at once- But this tends to cause a lag of sort, between your body and your energy.</font>")
					sleep(30)
					usr.OMessage(10, "<font color='#f7da1b'>This, inherently, lessen the impact your own energy has on your body. However...</font>")
					sleep(30)
					usr.OMessage(10, "<font color='#f7da1b'>If one was to infuse their energy, within one millionth of a second from a physical impact...</font>")
					sleep(30)
					usr.OMessage(10, "<font color='#f7da1b'>Space may distort for that moment- Energy sparking dark- And the destructive power of their attack raises to the power of two and a half.</font>")
					sleep(30)
					usr.OMessage(10, "<font color='#f7da1b'>A phenomenon known as a Black Flash. Following this, the user enters a state of awakening to their own energies-</font>")
					sleep(30)
					usr.OMessage(10, "<font color='#f7da1b'>Not too dissimilar to athletes entering 'The Zone', manipulating their power becomes as easy and natural as breathing.</font>")
					sleep(30)
					usr.OMessage(10, "<font color='#f7da1b'>In other words... For one minute and thirty seconds...</font>")
					sleep(30)
					usr.OMessage(10, "<font color='#f7da1b'><b>[usr] fights at one hundred and twenty percent of their potential.</b></font>")