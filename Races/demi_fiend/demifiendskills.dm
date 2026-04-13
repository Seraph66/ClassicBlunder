/obj/Skills/AutoHit/DemiFiend/Lunge
	Area="Wave"
	Distance=5
	DamageMult=3
	Rush=5
	ControlledRush=1
	Cooldown=30
	StrOffense=1
	RushAfterImages=3
	RushNoFlight=1
	ActiveMessage="lunges forward with blinding speed!"
	var/MaxCharges=2
	var/Charges=2
	var/Recharging=0

	verb/Lunge()
		set category="Skills"
		src.Trigger(usr)

	skillDescription()
		..()
		description += "Charges: [Charges]/[MaxCharges]\n"

	adjust(mob/p)
		var/scaling = round(p.Potential / 25)
		Distance = 5 + scaling
		DamageMult = 3 + scaling
		Rush = 5 + scaling

	Trigger(mob/p)
		adjust(p)
		if(Charges <= 0)
			return FALSE
		var/aaa = p.Activate(src)
		return aaa

	Cooldown(modify = 1, Time, mob/p)
		var/mob/m = src.loc
		if(p)
			m = p
		Charges--
		if(Charges <= 0)
			Using = 1
		if(!Time && m)
			if(!CooldownStatic)
				if(glob.SPEED_COOLDOWN_MODE)
					modify /= clamp(glob.SPEED_COOLDOWN_MIN, m.GetSpd()**glob.SPEED_COOLDOWN_EXPONENT, glob.SPEED_COOLDOWN_MAX)
				if(m.HasTechniqueMastery())
					var/TM = m.GetTechniqueMastery() / glob.TECHNIQUE_MASTERY_DIVISOR
					if(TM < 0)
						modify *= clamp(1 + abs(TM), 1.1, glob.TECHNIQUE_MASTERY_LIMIT)
					else if(TM > 0)
						modify /= clamp((1 + TM), 0.1, glob.TECHNIQUE_MASTERY_LIMIT)
			else
				if(m.Hustling())
					modify *= 0.75
			Time = src.Cooldown * 10 * modify
		if(isnull(Time) || Time == 0)
			Time = src.Cooldown * 10
		if(m)
			if(m.PureRPMode)
				return
			if(m.cooldownAnnounce)
				m << "Lunge: [Charges]/[MaxCharges] charges remaining. Next charge in [Time / 10]s."
			if(!Recharging)
				Recharging = 1
				RechargeLoop(Time, m)

	proc/RechargeLoop(Time, mob/m)
		spawn(Time)
			Charges = min(Charges + 1, MaxCharges)
			if(Charges > 0)
				Using = 0
			if(m && m.cooldownAnnounce)
				m << "<font color='white'><b>Lunge charge restored. ([Charges]/[MaxCharges])</b></font color>"
			if(Charges < MaxCharges)
				RechargeLoop(Time, m)
			else
				Recharging = 0

/obj/Skills/AutoHit/DemiFiend/Ice_Breath
	ElementalClass="Water"
	StrOffense=0
	ForOffense=2
	SpecialAttack=1
	GuardBreak=0
	DamageMult=15
	Chilling=100
	ObjIcon=1
	Icon='SnowBurst2.dmi'
	IconX=-16
	IconY=-16
	WindUp=0.5
	WindupMessage="breathes deeply..."
	ActiveMessage="lets loose an enormous breath infused with frost!"
	Cooldown=60
	Distance=30
	Slow=1
	Area="Arc"
	verb/Ice_Breath()
		set category="Skills"
		if(!altered)
			DamageMult = 3 + (1.5 * usr.AscensionsAcquired)
			Distance = 6 + (3 * usr.AscensionsAcquired)
			ForOffense = 2 + (0.25 * usr.AscensionsAcquired)
		usr.Activate(src)

/obj/Skills/AutoHit/DemiFiend/Flame_Breath
	ElementalClass="Fire"
	StrOffense=1
	ForOffense=1
	SpecialAttack=1
	GuardBreak=0
	DamageMult=10
	Scorching=30
	TurfErupt=1
	WindUp=0.5
	WindupMessage="breathes deeply..."
	ActiveMessage="lets loose an enormous breath infused with flame!"
	Cooldown=60
	Distance=40
	Slow=1
	Area="Arc"
	verb/Flame_Breath()
		set category="Skills"
		if(!altered)
			DamageMult = 5 + (1.5 * usr.AscensionsAcquired)
			Distance = 10 + (3 * usr.AscensionsAcquired)
			ForOffense = 1 + (0.25 * usr.AscensionsAcquired)
			StrOffense = 1 + (0.25 * usr.AscensionsAcquired)
		usr.Activate(src)

/obj/Skills/AutoHit/DemiFiend/Fog_Breath
	ElementalClass="Water"
	StrOffense=0
	ForOffense=1
	DamageMult=3
	SpecialAttack=1
	GuardBreak=1
	Slow=1
	Freezing=15
	NoLock=1
	NoAttackLock=1
	Area="Circle"
	Distance=1
	Wander=10
	ObjIcon=1
	Icon='FogBreath.dmi'
	IconX=-16
	IconY=-16
	Size=1.5
	Cooldown=60
	Rounds=40
	DelayTime=5
	HitSparkIcon='BLANK.dmi'
	HitSparkX=0
	HitSparkY=0
	ActiveMessage="releases a chilling fog!"
	verb/Fog_Breath()
		set category="Skills"
		usr.Activate(src)

// Target debuff skills - apply stat-reducing debuffs for 30 seconds
obj/Skills/Buffs/SlotlessBuffs/DemiFiend/TarundaApply
	StrMult=0.75
	ForMult=0.75
	TimerLimit=30
	ActiveMessage="has their strength and fortitude sapped!"
	OffMessage="recovers from the Tarunda debuff."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Tarunda
	applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/TarundaApply
	AffectTarget=1
	EndYourself=1
	Range=12
	Cooldown=60
	ActiveMessage="saps the target's strength and fortitude!"
	verb/Tarunda()
		set category="Skills"
		if(!usr.Target || usr.Target==usr)
			usr << "You need to target someone else."
			return
		if(!altered)
			adjust(usr)
			applyToTarget?:adjust(usr)
		src.Trigger(usr)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/SukundaApply
	SpdMult=0.75
	OffMult=0.75
	DefMult=0.75
	TimerLimit=30
	ActiveMessage="has their speed, offense, and defense reduced!"
	OffMessage="recovers from the Sukunda debuff."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Sukunda
	applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/SukundaApply
	AffectTarget=1
	EndYourself=1
	Range=12
	Cooldown=60
	ActiveMessage="reduces the target's speed, offense, and defense!"
	verb/Sukunda()
		set category="Skills"
		if(!usr.Target || usr.Target==usr)
			usr << "You need to target someone else."
			return
		if(!altered)
			adjust(usr)
			applyToTarget?:adjust(usr)
		src.Trigger(usr)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/RakundaApply
	EndMult=0.75
	TimerLimit=30
	ActiveMessage="has their endurance sapped!"
	OffMessage="recovers from the Rakunda debuff."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Rakunda
	applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/RakundaApply
	AffectTarget=1
	EndYourself=1
	Range=12
	Cooldown=60
	ActiveMessage="saps the target's endurance!"
	verb/Rakunda()
		set category="Skills"
		if(!usr.Target || usr.Target==usr)
			usr << "You need to target someone else."
			return
		if(!altered)
			adjust(usr)
			applyToTarget?:adjust(usr)
		src.Trigger(usr)

// Healing skills
obj/Skills/Buffs/SlotlessBuffs/DemiFiend/DiaApply
	StableHeal=1
	HealthHeal=10
	TimerLimit=10
	ActiveMessage="is healed by restorative energy!"
	OffMessage="releases the healing energy."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Dia
	ElementalClass="Light"
	applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/DiaApply
	AffectTarget=1
	EndYourself=1
	Range=12
	Cooldown=150
	KenWave=1
	KenWaveIcon='SparkleYellow.dmi'
	KenWaveSize=3
	KenWaveX=105
	KenWaveY=105
	ActiveMessage="invokes restorative energy upon their target!"
	OffMessage="finishes casting Dia."
	verb/Dia()
		set category="Skills"
		if(!usr.Target || usr.Target==usr)
			usr << "You can't use Dia on yourself!"
			return
		if(!altered)
			adjust(usr)
			applyToTarget?:adjust(usr)
		src.Trigger(usr)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/MediaApply
	StableHeal=1
	HealthHeal=10
	TimerLimit=10
	ActiveMessage="is healed by powerful restorative energy!"
	OffMessage="the healing energy fades..."
	MagicNeeded=0

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Media
	ElementalClass="Light"
	EndYourself=1
	Cooldown=300
	KenWave=1
	KenWaveIcon='SparkleYellow.dmi'
	KenWaveSize=4
	KenWaveX=105
	KenWaveY=105
	ActiveMessage="invokes restorative magic upon their party!"
	OffMessage="finishes casting Media."
	verb/Media()
		set category="Skills"
		var/mob/User = usr
		if(!User.party || !User.party.members || User.party.members.len == 0)
			User << "You need to be in a party to use Media."
			return
		if(src.cooldown_remaining > 0)
			User << "[src] is on cooldown."
			return
		if(!altered)
			adjust(User)
		var/baseHeal = 15
		for(var/mob/m in User.party.members)
			if(!m || !ismob(m)) continue
			var/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/MediaApply/applyBuff = new
			applyBuff.HealthHeal = (m == User ? baseHeal / 2 : baseHeal)
			applyBuff.StableHeal = 1
			applyBuff.TimerLimit = 10
			applyBuff.Trigger(m, 1)
		User.OMessage(1, null, "[User] invokes restorative energy upon [User.party.members.len == 1 ? "themselves" : "their party"]!")
		src.Cooldown(1, null, User)

obj/Skills/Projectile/DemiFiend/Tornado
	name = "Tornado"
	IconLock = 'Tornado.dmi'
	IconSize = 2
	LockX = -32
	LockY = -32
	Speed = 0.4
	Distance = 25
	DamageMult = 3
	StrRate = 0.5
	ForRate = 0.5
	HyperHoming = 1
	Homing = 1
	Launcher = 3
	LingeringTornado = 1
	Piercing = 1
	Cooldown = 60
	verb/Tornado()
		set category = "Skills"
		usr.UseProjectile(src)

/obj/Skills/AutoHit/DemiFiend/Berserk
	Area="Wave"
	Distance=8
	DamageMult=10
	StrOffense=2
	SpecialAttack=1
	Cooldown=45
	Slow=1
	Rounds=10
	DelayTime=2
	RoundMovement=0
	ObjIcon=1
	Icon='roundhouse.dmi'
	IconX=-16
	IconY=-16
	Size=1.5
	HitSparkIcon='Hit Effect Wind.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1
	HitSparkDispersion=1
	TurfStrike=1
	WindUp=0.3
	WindupMessage="enters a berserker rage..."
	ActiveMessage="unleashes a flurry of devastating strikes!"
	verb/Berserk()
		set category="Skills"
		if(!altered)
			DamageMult = 5 + (1.5 * usr.AscensionsAcquired)
			Distance = 8 + (2 * usr.AscensionsAcquired)
			StrOffense = 2 + (0.25 * usr.AscensionsAcquired)
		usr.Activate(src)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/TauntDebuffApply
	StrMult=1.5
	ForMult=1.5
	EndMult=0.5
	TimerLimit=30
	ActiveMessage="is taunted into a reckless frenzy!"
	OffMessage="shakes off the effects of the taunt."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Taunt
	EndYourself=1
	Cooldown=90
	ActiveMessage="taunts all nearby enemies into a reckless frenzy!"
	OffMessage="finishes taunting."
	verb/Taunt()
		set category="Skills"
		var/mob/User = usr
		if(src.cooldown_remaining > 0)
			User << "[src] is on cooldown."
			return
		var/hit = 0
		for(var/mob/m in oview(12, User))
			if(m == User) continue
			if(User.party && (m in User.party.members)) continue
			if(!m.client && !isAI(m)) continue
			var/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/TauntDebuffApply/applyBuff = new
			applyBuff.Trigger(m, 1)
			hit++
		if(hit)
			User.OMessage(1, null, "[User] lets out a taunting roar, provoking [hit] nearby foe\s into a reckless frenzy!")
		else
			User << "No enemies nearby to taunt."
			return
		src.Cooldown(1, null, User)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/WarCryApply
	StrMult=0.6
	ForMult=0.6
	TimerLimit=30
	ActiveMessage="has their fighting spirit shattered by a terrifying war cry!"
	OffMessage="recovers from the war cry."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/War_Cry
	EndYourself=1
	Cooldown=90
	ActiveMessage="lets out a bone-chilling war cry!"
	OffMessage="finishes the war cry."
	verb/War_Cry()
		set category="Skills"
		var/mob/User = usr
		if(src.cooldown_remaining > 0)
			User << "[src] is on cooldown."
			return
		var/hit = 0
		for(var/mob/m in oview(12, User))
			if(m == User) continue
			if(User.party && (m in User.party.members)) continue
			if(!m.client && !isAI(m)) continue
			var/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/WarCryApply/applyBuff = new
			applyBuff.Trigger(m, 1)
			hit++
		if(hit)
			User.OMessage(1, null, "[User] lets out a devastating war cry, weakening [hit] nearby foe\s!")
		else
			User << "No enemies nearby."
			return
		src.Cooldown(1, null, User)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Focus
	StrMult=2.5
	ForMult=2.5
	TimerLimit=5
	Cooldown=120
	ActiveMessage="concentrates their power to its absolute limit!"
	OffMessage="releases their focused state."
	verb/Focus()
		set category="Skills"
		src.Trigger(usr)

/obj/Skills/AutoHit/DemiFiend/Heat_Wave
	Area="Wave"
	Distance=8
	DamageMult=10
	StrOffense=2
	SpecialAttack=1
	Cooldown=45
	Slow=1
	WindUp=0.3
	WindupMessage="draws back with burning intent..."
	ActiveMessage="unleashes a devastating heat wave!"
	verb/Heat_Wave()
		set category="Skills"
		if(!altered)
			DamageMult = 4 + (1.5 * usr.AscensionsAcquired)
			Distance = 8 + (2 * usr.AscensionsAcquired)
			StrOffense = 2 + (0.25 * usr.AscensionsAcquired)
		usr.Activate(src)

/obj/Skills/AutoHit/DemiFiend/Freikugel
	ElementalClass="Ultima"
	Area="Wave"
	Distance=6
	DamageMult=15
	Rush=6
	ControlledRush=1
	StrOffense=2
	ForOffense=1
	SpecialAttack=1
	GuardBreak=1
	Cooldown=90
	Slow=1
	RushAfterImages=5
	WindUp=1
	WindupMessage="concentrates an overwhelming surge of power..."
	ActiveMessage="fires a devastating burst of almighty force!"
	verb/Freikugel()
		set category="Skills"
		if(!altered)
			DamageMult = 8 + (3 * usr.AscensionsAcquired)
			Distance = 6 + (2 * usr.AscensionsAcquired)
			Rush = 6 + (2 * usr.AscensionsAcquired)
			StrOffense = 2 + (0.5 * usr.AscensionsAcquired)
			ForOffense = 1 + (0.25 * usr.AscensionsAcquired)
		usr.Activate(src)

/obj/Skills/AutoHit/DemiFiend/Thunder_Breath
	ElementalClass="Wind"
	StrOffense=0
	ForOffense=2
	SpecialAttack=1
	GuardBreak=0
	DamageMult=15
	Shocking=50
	Paralyzing=10
	ObjIcon=1
	Icon='LightningBreath.dmi'
	IconX=-16
	IconY=-16
	Size=1.5
	Rounds=8
	DelayTime=2
	WindUp=0.5
	WindupMessage="crackles with electricity..."
	ActiveMessage="lets loose an enormous breath infused with lightning!"
	Cooldown=60
	Distance=30
	Slow=1
	Area="Arc"
	verb/Thunder_Breath()
		set category="Skills"
		if(!altered)
			DamageMult = 3 + (1.5 * usr.AscensionsAcquired)
			Distance = 6 + (3 * usr.AscensionsAcquired)
			ForOffense = 2 + (0.25 * usr.AscensionsAcquired)
		usr.Activate(src)

/obj/Skills/AutoHit/DemiFiend/Shock
	ElementalClass="Wind"
	StrOffense=0
	ForOffense=2
	SpecialAttack=1
	DamageMult=10
	Shocking=75
	Paralyzing=15
	NoLock=1
	NoAttackLock=1
	Area="Circle"
	Distance=1
	Wander=10
	ObjIcon=1
	Icon='LightningBreath.dmi'
	IconX=-16
	IconY=-16
	Cooldown=75
	Rounds=15
	DelayTime=3
	HitSparkIcon='BLANK.dmi'
	HitSparkX=0
	HitSparkY=0
	ActiveMessage="releases a surge of electricity in all directions!"
	verb/Shock()
		set category="Skills"
		if(!altered)
			DamageMult = 4 + (1 * usr.AscensionsAcquired)
			Wander = 8 + (2 * usr.AscensionsAcquired)
			ForOffense = 2 + (0.25 * usr.AscensionsAcquired)
		usr.Activate(src)
