obj/Items/Sword/Heavy/Legendary/WeaponSoul/Blade_of_Chaos
	name="Blade of Chaos"
	icon='SoulEdge.dmi'
	ExtraClass=1
	Ascended=6
	passives = list("Extend" = 1)
	Destructable=0
	ShatterTier=0

obj/Skills/AutoHit/Soul_Drain
	NeedsSword=1
	Distance=10
	DistanceAround=6
	Gravity=5
	WindUp=1
	WindupMessage="channels the chaos of Soul Edge...."
	DamageMult=3
	StrOffense=1
	ActiveMessage="unleashes a tidal wave of chaos into the area!"
	Area="Around Target"
	GuardBreak=1
	PassThrough=1
	MortalBlow=0.25
	HitSparkIcon = null
	TurfStrike=1
	TurfShiftLayer=EFFECTS_LAYER
	TurfShiftDuration=-10
	TurfShiftDurationSpawn=0
	TurfShiftDurationDespawn=5
	TurfShift='Gravity.dmi'
	Cooldown=30
	EnergyCost=15
	Instinct=1
	adjust(mob/p)
		DamageMult = 5 + p.SagaLevel
		WindUp = 1 - p.SagaLevel/10
	verb/Soul_Drain()
		set category="Skills"
		adjust(usr)
		usr.Activate(src)

obj/Skills/Buffs/SpecialBuffs/Heavenly_Regalia/Soul_Edge
	name = "Heavenly Regalia: Chaos Armament"
	StrMult=1.3
	OffMult=1.3
	EndMult=1.3
	passives = list("DemonicDurability" = 3, "Instinct" = 4, "Momentum" = 2, "EnhancedSmell" = 1, "EnhancedHearing" = 1)
	IconLock='EyeFlameC.dmi'
	ActiveMessage="'s chaotic treasures ring in resonance: Heavenly Regalia!"
	OffMessage="'s treasures lose their chaotic luster..."
	verb/Heavenly_Regalia()
		set category="Skills"
		src.Trigger(usr)
/obj/Skills/Buffs/NuStyle/SwordStyle //slightly weaker than t2. maybe make it scaling???
	Stained_Memories
		StyleActive="Stained Memories"
		passives = list("CallousedHands" = 0.1, "Shearing" = 2)
		StyleEnd=1.25
		StyleStr=1.25
		Finisher="/obj/Skills/Queue/Finisher/Rook_Splitter"
		adjust(mob/p)
	        StyleStr = 1.05 + (0.05 * p.SagaLevel)
	        StyleEnd = 1.05 + (0.05 * p.SagaLevel)
			passives["CallousedHands"] = 0.1 + (0.05* p.SagaLevel)
			passives["Shearing"] = 2+p.SagaLevel
		verb/Stained_Memories()
			set hidden=1
			adjust(usr)
			Trigger(usr)
/obj/Skills/Queue/Finisher
	Rook_Splitter
		DamageMult=8
		HitSparkIcon='Slash - Zan.dmi'
		HitSparkX=-32
		HitSparkY=-32
		BuffSelf="/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher/Grim_Lord"
		HitMessage = "crushes the very world with the might of Soul Edge!"
/obj/Skills/Buffs/SlotlessBuffs/Autonomous/QueueBuff/Finisher
	Grim_Lord
		StrMult=1.3
		EndMult=1.3
		passives = list("DemonicDurability" = 1, "AngerAdaptiveForce" = 0.5, "CallousedHands" = 0.15)
