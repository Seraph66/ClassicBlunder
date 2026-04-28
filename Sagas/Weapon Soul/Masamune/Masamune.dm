obj/Items/Sword/Light/Legendary/WeaponSoul/Sword_of_Purity//Masamune
	name="Sword of Purity"
	icon='Masamune.dmi'
	passives = list("Purity" = 1)
	Ascended=6
	ShatterTier=0
	Destructable=0

obj/Skills/AutoHit/Divine_Cleansing
	NeedsSword = 1
	Area="Circle"
	Slow=0.5
	StrOffense=1
	HitSelf = TRUE
	DamageMult=1//set in adjust code
	Cleansing = 1//set in adjust code
	Cooldown=30
	Rounds=1
	Distance = 5
	RoundMovement=1
	Shockwaves=3
	Shockwave=2
	ShockIcon = 'ShockwaveIce.dmi'
	Icon='HitEffectSnow.dmi'
	IconX=-32
	IconY=-32
	Size=10
	TurfStrike=1
	HitSparkIcon='SparkleBlue.dmi'
	HitSparkX = 0;
	HitSparkY = 0;
	HitSparkCount = 2;
	HitSparkDispersion = 8;
	TurfShift='SnowFloor.dmi'
	TurfShiftDuration = 10
	EnergyCost=1
	ActiveMessage="cuts through debilitation with the power of Masamune's purity!"
	adjust(mob/p)
		DamageMult = p.SagaLevel
		Cleansing = p.SagaLevel
		Size = 5
	verb/Divine_Cleansing()
		set category="Skills"
		adjust(usr)
		usr.Activate(src)

obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Masamune
	name = "Heavenly Regalia: Blessed Blade"
	StrMult=1.3
	OffMult=1.3
	DefMult=1.3
	passives = list("BeyondPurity" = 1, "PureReduction" = 4) // may god have mercy on my soul
	IconLock='EyeFlameC.dmi'
	ActiveMessage="'s soothing treasures ring in resonance: Heavenly Regalia!"
	OffMessage="'s treasures lose their healing luster..."
	verb/Heavenly_Regalia()
		set category="Skills"
		src.Trigger(usr)