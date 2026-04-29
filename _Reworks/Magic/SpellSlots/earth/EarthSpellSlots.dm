//earth
/obj/Skills/AutoHit/Magic/Earth
	SpellElement="Earth"
	SpellSlot=1
	MagicNeeded=1
	Seismic_Entry
		ElementalOffense="Earth"
		Area="Circle"
		Distance=4
		DamageMult=5
		Crushing=3
		SpecialAttack=1
		StrOffense=1
		CanBeDodged=1
		CanBeBlocked=0
		FlickAttack=1
		ManaCost=5
		Cooldown=45
		HitSparkIcon='Hit Effect Ripple.dmi'
		HitSparkSize=1
		HitSparkDispersion=8
		HitSparkTurns=0
		TurfStrike=1
		TurfShift='Dirt1.dmi'
		TurfShiftDuration=3
		ActiveMessage="invokes: <font size=+1>SEISMIC ENTRY!</font size>"
		adjust(mob/p)
			if(!altered)
				if(p.isInnovative(FAE, "Any") && !isInnovationDisable(p))
					DamageMult=7.5
					Distance=6
					ActiveMessage="invokes a powerful: <font size=+1>SEISMIC ENTRY!</font size>"
		verb/Seismic_Entry()
			set category="Skills"
			adjust(usr)
			usr.Activate(src)

/obj/Skills/Buffs/SlotlessBuffs/Magic/Earth
	SpellElement="Earth"
	SpellSlot=1
	Ward_of_Stone
		TimerLimit=20
		Cooldown=90
		ManaCost=8
		ManaDrain=0.01
		EndMult=1.15
		PureReduction=2
		passives=list("Harden" = 1, "Grit" = 1, "MeleeResist" = 1)
		ActiveMessage="wraps themselves in a ward of living stone!"
		OffMessage="lets the stone crumble away..."
		adjust(mob/p)
			if(!altered)
				if(p.isInnovative(FAE, "Any") && !isInnovationDisable(p))
					TimerLimit=40
					Cooldown=70
					EndMult=1.25
					PureReduction=3
					ActiveMessage="wraps themselves in a barrier of living stone!"
		// Combat damage grows passive_handler["Grit"] beyond the buff's listed
		// value of 1 via AdjustGrit. The stock decreaseList call only knocks
		// off that listed +1 on toggle-off, so the combat-accumulated portion
		// would otherwise leak past the buff and keep Grit visibly active for
		// the player long after the buff itself has expired. Clear it here if
		// no other Grit source is still up.
		Trigger(mob/User, Override = 0)
			var/was_on = User.BuffOn(src)
			..()
			if(was_on && !User.BuffOn(src))
				if(!User.hasActiveGritSource())
					User.passive_handler.Set("Grit", 0)
		verb/Ward_of_Stone()
			set category="Skills"
			adjust(usr)
			src.Trigger(usr)

	Prickly_Ballet
		AffectTarget=1
		Range=10
		TimerLimit=10
		Cooldown=60
		ManaCost=8
		ShatterAffected=3
		CrippleAffected=2
		ActiveMessage="curses the earth beneath their target!"
		OffMessage="releases the curse!"
		adjust(mob/p)
			if(!altered)
				if(p.isInnovative(FAE, "Any") && !isInnovationDisable(p))
					TimerLimit=15
					Cooldown=55
					ShatterAffected=4
					CrippleAffected=3
					ActiveMessage="hexes the earth beneath their target!"
		verb/Prickly_Ballet()
			set category="Skills"
			adjust(usr)
			src.Trigger(usr)
