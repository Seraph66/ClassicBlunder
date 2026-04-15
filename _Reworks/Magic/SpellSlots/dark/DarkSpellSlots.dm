//dark
/obj/Skills/AutoHit/Magic/Dark
	SpellElement="Dark"
	SpellSlot=1
	Shadow_Cleave
		Area="Arc"
		Distance=3
		DamageMult=6
		SpecialAttack=1
		StrOffense=1
		CanBeDodged=1
		CanBeBlocked=0
		FlickAttack=1
		ManaCost=5
		Cooldown=40
		HitSparkIcon='Hit Effect Dark.dmi'
		HitSparkSize=1
		HitSparkDispersion=6
		HitSparkTurns=0
		TurfStrike=1
		TurfShift='Dark.dmi'
		TurfShiftDuration=3
		ActiveMessage="invokes: <font size=+1>SHADOW CLEAVE!</font size>"
		verb/Shadow_Cleave()
			set category="Skills"
			adjust(usr)
			usr.Activate(src)

/obj/Skills/Projectile/Magic/Dark
	SpellElement="Dark"
	SpellSlot=1
	Arachnae_Touch
		DamageMult=4
		Speed=2
		Distance=12
		ManaCost=5
		Cooldown=40
		IconLock='Hit Effect Dark.dmi'
		ActiveMessage="invokes: <font size=+1>ARACHNAE TOUCH!</font size>"
		verb/Arachnae_Touch()
			set category="Skills"
			usr.UseProjectile(src)

	Void_Blast
		DamageMult=5
		Homing=1
		Explode=2
		Knockback=2
		ManaCost=6
		Cooldown=45
		IconLock='Hit Effect Dark.dmi'
		IconSize=1.5
		ActiveMessage="invokes: <font size=+1>VOID BLAST!</font size>"
		verb/Void_Blast()
			set category="Skills"
			usr.UseProjectile(src)
