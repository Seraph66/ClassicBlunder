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
		MakesArmor=0
		TurfShift='WhiteTurfShift.dmi'
		TurfShiftInstant=1
		OffMult=1.25
		IconLock='CE Divergent Fist.dmi'
		TimerLimit=90
		passives = list("TechniqueMastery" = 5, "BuffMastery" = 10, "MovementMastery" = 10) // this is temp i just grabbed that shit from x-antibody LOL
		DarkChange=1
		ActiveMessage="...!"
		OffMessage="cools down."
		adjust(mob/p)
			if(p.isBlackFlashFirstUse()) spawn() p.BlackFlashGlazing(src)
			else ActiveMessage = "gets in tune with their energy output, unlocking 120% of their potential!"

#define JJK_NARRATOR_COLOUR "#f7da1b"
/mob/proc/JJKNarrate(txt)
	OMessage(50, Msg = "<font color=[JJK_NARRATOR_COLOUR]>[txt]</font color>");

/mob/proc/BlackFlashGlazing(obj/Skills/Buffs/bfSkill)
	setBlackFlashFirstUse();
	JJKNarrate("It is not a technique you'd be able to see commonly. Not in these parts.");
	sleep(30)
	JJKNarrate("Most would simply use their energy to empower their whole body all at once- But this tends to cause a lag of sort, between your body and your energy.");
	sleep(30)
	JJKNarrate("This, inherently, lessen the impact your own energy has on your body. However...");
	sleep(30)
	JJKNarrate("If one was to infuse their energy, within one millionth of a second from a physical impact...");
	sleep(30)
	JJKNarrate("Space may distort for that moment- Energy sparking dark- And the destructive power of their attack raises to the power of two and a half.");
	sleep(30)
	JJKNarrate("A phenomenon known as a Black Flash. Following this, the user enters a state of awakening to their own energies-");
	sleep(30)
	JJKNarrate("Not too dissimilar to athletes entering 'The Zone', manipulating their power becomes as easy and natural as breathing.");
	sleep(30)
	JJKNarrate("In other words... For one minute and thirty seconds...");
	sleep(30)
	JJKNarrate("<b>[src] fights at one hundred and twenty percent of their potential.</b>");


/mob/proc/
	getBlackFlashSecret()
		if(hasSecret("Black Flash")) return secretDatum;
		return 0;
	isBlackFlashFirstUse()
		var/SecretInformation/BlackFlash/bf = getBlackFlashSecret();
		if(bf) return bf.BlackFlashFirstTimeUse;
	setBlackFlashFirstUse()
		var/SecretInformation/BlackFlash/bf = getBlackFlashSecret();
		bf.BlackFlashFirstTimeUse=0;
	getBlackFlashChance()
		var/SecretInformation/BlackFlash/bf = getBlackFlashSecret();
		var/force = bf.BlackFlashForcedChance;
		if(bf.BlackFlashChance < bf.BlackFlashBaseChance)
			bf.BlackFlashChance = bf.BlackFlashBaseChance
		if(force) return force;
		else
			bf.BlackFlashChance += 5
			return clamp(bf.BlackFlashChance-5, bf.BlackFlashBaseChance, 90);