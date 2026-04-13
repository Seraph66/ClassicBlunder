//earth
/obj/Skills/AutoHit/Magic/Earth
	SpellElement="Earth"
	SpellSlot=1
	Seismic_Entry
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
		ActiveMessage="invokes: <font size=+1>SEISMIC ENTRY!</font size>"
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
		verb/Prickly_Ballet()
			set category="Skills"
			adjust(usr)
			src.Trigger(usr)
