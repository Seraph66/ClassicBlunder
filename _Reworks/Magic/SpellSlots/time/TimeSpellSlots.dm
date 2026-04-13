//time
/obj/Skills/AutoHit/Magic/Time
	SpellElement="Time"
	SpellSlot=1
	Tempus_Cessat
		Area="Circle"
		Distance=5
		DamageMult=3
		Slow=1
		SpecialAttack=1
		ForOffense=1
		CanBeDodged=1
		CanBeBlocked=0
		FlickAttack=1
		ManaCost=6
		Cooldown=50
		HitSparkIcon='Magic Time circle.dmi'
		HitSparkSize=1
		HitSparkDispersion=8
		HitSparkTurns=0
		ActiveMessage="invokes: <font size=+1>TEMPUS CESSAT!</font size>"
		verb/Tempus_Cessat()
			set category="Skills"
			adjust(usr)
			usr.Activate(src)

/obj/Skills/Buffs/SlotlessBuffs/Magic/Time
	SpellElement="Time"
	SpellSlot=1
	Haste
		TimerLimit=15
		Cooldown=90
		ManaCost=10
		ManaDrain=0.01
		SpdMult=1.2
		Godspeed=1
		passives=list("Godspeed" = 1, "BlurringStrikes" = 1, "FluidForm" = 1)
		ActiveMessage="accelerates through time!"
		OffMessage="slows back to a normal pace..."
		verb/Haste()
			set category="Skills"
			adjust(usr)
			src.Trigger(usr)

	Wither
		AffectTarget=1
		Range=12
		TimerLimit=12
		Cooldown=60
		ManaCost=8
		SpdTaxDrain=0.02
		StrTaxDrain=0.02
		ActiveMessage="begins to decay the flow of time around their target!"
		OffMessage="releases the temporal hex!"
		verb/Wither()
			set category="Skills"
			adjust(usr)
			src.Trigger(usr)
