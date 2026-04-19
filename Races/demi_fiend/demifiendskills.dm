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

// =========================================================================
// Anathema skills
// =========================================================================

obj/Skills/Projectile/DemiFiend/Mamudo
	name = "Mamudo"
	ElementalClass = "Dark"
	SpellElement = "Dark"
	IconLock = 'DarkShock.dmi'
	IconSize = 1
	LockX = -16
	LockY = -16
	Speed = 0.3
	Distance = 20
	DamageMult = 4
	ForRate = 1
	Homing = 1
	Cooldown = 30
	verb/Mamudo()
		set category = "Skills"
		if(!altered)
			DamageMult = 4 + (1 * usr.AscensionsAcquired)
			Distance = 20 + (2 * usr.AscensionsAcquired)
		usr.UseProjectile(src)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/EvilGazeApply
	TimerLimit=30
	ActiveMessage="is gripped by primal terror..."
	OffMessage="shakes off the dread."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Evil_Gaze
	applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/EvilGazeApply
	AffectTarget=1
	EndYourself=1
	Range=12
	Cooldown=60
	KenWave=1
	KenWaveIcon='SparkleIndigo.dmi'
	KenWaveSize=3
	ActiveMessage="fixes their target with a dreadful gaze!"
	OffMessage="finishes the gaze."
	verb/Evil_Gaze()
		set category="Skills"
		if(!usr.Target || usr.Target==usr)
			usr << "You need to target someone else."
			return
		if(!altered)
			adjust(usr)
			applyToTarget?:adjust(usr)
		usr.Target.AddTerrifying(40, usr)
		src.Trigger(usr)

/obj/Skills/AutoHit/DemiFiend/Mamudoon
	ElementalClass="Dark"
	SpellElement="Dark"
	Area="Circle"
	Distance=1
	Wander=10
	DamageMult=8
	ForOffense=2
	SpecialAttack=1
	NoLock=1
	NoAttackLock=1
	ObjIcon=1
	Icon='SuperDarkness.dmi'
	IconX=-16
	IconY=-16
	Size=2
	Rounds=8
	DelayTime=2
	HitSparkIcon='BLANK.dmi'
	HitSparkX=0
	HitSparkY=0
	Cooldown=90
	WindUp=0.5
	WindupMessage="calls upon the voice of the damned..."
	ActiveMessage="erupts in a wave of deathly darkness!"
	verb/Mamudoon()
		set category="Skills"
		if(!altered)
			DamageMult = 6 + (2 * usr.AscensionsAcquired)
			Wander = 8 + (2 * usr.AscensionsAcquired)
			ForOffense = 2 + (0.25 * usr.AscensionsAcquired)
		usr.Activate(src)

// =========================================================================
// Miasma skills
// =========================================================================

obj/Skills/Projectile/DemiFiend/Glacial_Blast
	name = "Glacial Blast"
	ElementalClass = "Water"
	SpellElement = "Water"
	IconLock = 'IceCoffin.dmi'
	IconSize = 2
	LockX = -32
	LockY = -32
	Speed = 0.35
	Distance = 25
	DamageMult = 5
	ForRate = 1
	Chilling = 50
	Freezing = 20
	Piercing = 1
	Homing = 1
	Cooldown = 45
	verb/Glacial_Blast()
		set category = "Skills"
		if(!altered)
			DamageMult = 5 + (1.5 * usr.AscensionsAcquired)
			Distance = 25 + (2 * usr.AscensionsAcquired)
		usr.UseProjectile(src)

/obj/Skills/AutoHit/DemiFiend/Wild_Dance
	ElementalClass="Ultima"
	Area="Wave"
	Distance=6
	Rush=4
	ControlledRush=1
	DamageMult=6
	StrOffense=1
	ForOffense=1
	SpecialAttack=1
	GuardBreak=1
	ObjIcon=1
	Icon='Aurora.dmi'
	IconX=-16
	IconY=-16
	Size=1.5
	Rounds=6
	DelayTime=2
	HitSparkIcon='Hit Effect Wind.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1
	HitSparkDispersion=1
	TurfStrike=1
	Cooldown=75
	WindUp=0.3
	WindupMessage="begins a spiraling dance..."
	ActiveMessage="whirls through their foes in a frenzied Wild Dance!"
	verb/Wild_Dance()
		set category="Skills"
		if(!altered)
			DamageMult = 5 + (1.5 * usr.AscensionsAcquired)
			Distance = 6 + (2 * usr.AscensionsAcquired)
			Rush = 4 + (1 * usr.AscensionsAcquired)
			StrOffense = 1 + (0.25 * usr.AscensionsAcquired)
			ForOffense = 1 + (0.25 * usr.AscensionsAcquired)
		usr.Activate(src)

// =========================================================================
// Nirvana skills
// =========================================================================

obj/Skills/Projectile/DemiFiend/Divine_Shot
	name = "Divine Shot"
	ElementalClass = "Light"
	SpellElement = "Light"
	IconLock = 'AvalonLight.dmi'
	IconSize = 1
	LockX = -16
	LockY = -16
	Speed = 0.25
	Distance = 25
	DamageMult = 5
	ForRate = 1
	CriticalChance = 20
	Homing = 1
	Cooldown = 30
	verb/Divine_Shot()
		set category = "Skills"
		if(!altered)
			DamageMult = 5 + (1.5 * usr.AscensionsAcquired)
			Distance = 25 + (2 * usr.AscensionsAcquired)
		usr.UseProjectile(src)

/obj/Skills/AutoHit/DemiFiend/Violet_Flash
	ElementalClass="Light"
	SpellElement="Light"
	Area="Wave"
	Distance=8
	DamageMult=10
	ForOffense=2
	SpecialAttack=1
	ObjIcon=1
	Icon='SparkleViolet.dmi'
	IconX=-16
	IconY=-16
	Size=2
	Rounds=10
	DelayTime=2
	HitSparkIcon='BLANK.dmi'
	HitSparkX=0
	HitSparkY=0
	Cooldown=90
	WindUp=0.5
	WindupMessage="gathers radiant light..."
	ActiveMessage="unleashes a blinding flash of violet radiance!"
	verb/Violet_Flash()
		set category="Skills"
		if(!altered)
			DamageMult = 8 + (2 * usr.AscensionsAcquired)
			Distance = 8 + (2 * usr.AscensionsAcquired)
			ForOffense = 2 + (0.25 * usr.AscensionsAcquired)
		usr.Activate(src)

// =========================================================================
// Murakumo skills
// =========================================================================

/obj/Skills/AutoHit/DemiFiend/Chaos_Blade
	Area="Wave"
	Distance=5
	Rush=5
	ControlledRush=1
	DamageMult=12
	StrOffense=2
	SpecialAttack=1
	GuardBreak=1
	ObjIcon=1
	Icon='Slash - Ragna.dmi'
	IconX=-16
	IconY=-16
	Size=1.5
	Rounds=8
	DelayTime=2
	HitSparkIcon='Hit Effect Wind.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1
	HitSparkDispersion=1
	TurfStrike=1
	Cooldown=60
	WindUp=0.4
	WindupMessage="draws the cloud-gathering blade..."
	ActiveMessage="cleaves everything with Chaos Blade!"
	verb/Chaos_Blade()
		set category="Skills"
		if(!altered)
			DamageMult = 8 + (2 * usr.AscensionsAcquired)
			Distance = 5 + (2 * usr.AscensionsAcquired)
			Rush = 5 + (1 * usr.AscensionsAcquired)
			StrOffense = 2 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)

// =========================================================================
// Geis skills
// =========================================================================

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/DiaramaApply
	StableHeal=1
	HealthHeal=25
	TimerLimit=10
	ActiveMessage="is bathed in potent restorative energy!"
	OffMessage="releases the restorative energy."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Diarama
	ElementalClass="Light"
	applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/DiaramaApply
	AffectTarget=1
	EndYourself=1
	Range=12
	Cooldown=180
	KenWave=1
	KenWaveIcon='SparkleYellow.dmi'
	KenWaveSize=4
	KenWaveX=105
	KenWaveY=105
	ActiveMessage="invokes potent restorative energy upon their target!"
	OffMessage="finishes casting Diarama."
	verb/Diarama()
		set category="Skills"
		if(!usr.Target || usr.Target==usr)
			usr << "You can't use Diarama on yourself!"
			return
		if(!altered)
			adjust(usr)
			applyToTarget?:adjust(usr)
		src.Trigger(usr)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/MediaramaApply
	StableHeal=1
	HealthHeal=30
	TimerLimit=10
	ActiveMessage="is bathed in powerful restorative energy!"
	OffMessage="the healing energy fades..."
	MagicNeeded=0

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Mediarama
	ElementalClass="Light"
	EndYourself=1
	Cooldown=300
	KenWave=1
	KenWaveIcon='SparkleYellow.dmi'
	KenWaveSize=5
	KenWaveX=105
	KenWaveY=105
	ActiveMessage="invokes powerful restorative magic upon their party!"
	OffMessage="finishes casting Mediarama."
	verb/Mediarama()
		set category="Skills"
		var/mob/User = usr
		if(!User.party || !User.party.members || User.party.members.len == 0)
			User << "You need to be in a party to use Mediarama."
			return
		if(src.cooldown_remaining > 0)
			User << "[src] is on cooldown."
			return
		if(!altered)
			adjust(User)
		var/baseHeal = 35
		for(var/mob/m in User.party.members)
			if(!m || !ismob(m)) continue
			var/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/MediaramaApply/applyBuff = new
			applyBuff.HealthHeal = (m == User ? baseHeal / 2 : baseHeal)
			applyBuff.StableHeal = 1
			applyBuff.TimerLimit = 10
			applyBuff.Trigger(m, 1)
		User.OMessage(1, null, "[User] invokes powerful restorative energy upon [User.party.members.len == 1 ? "themselves" : "their party"]!")
		src.Cooldown(1, null, User)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/DiarahanApply
	StableHeal=1
	HealthHeal=200
	TimerLimit=3
	ActiveMessage="is enveloped in an overwhelming wave of restorative light!"
	OffMessage="the flood of healing recedes."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Diarahan
	ElementalClass="Light"
	applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/DiarahanApply
	AffectTarget=1
	EndYourself=1
	Range=12
	Cooldown=600
	KenWave=1
	KenWaveIcon='SparkleYellow.dmi'
	KenWaveSize=6
	KenWaveX=105
	KenWaveY=105
	ActiveMessage="invokes an overwhelming flood of restorative light!"
	OffMessage="finishes casting Diarahan."
	verb/Diarahan()
		set category="Skills"
		if(!usr.Target || usr.Target==usr)
			usr << "You can't use Diarahan on yourself!"
			return
		if(!altered)
			adjust(usr)
			applyToTarget?:adjust(usr)
		src.Trigger(usr)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/TetrajaApply
	EndMult=3
	TimerLimit=10
	ActiveMessage="is shrouded by a sacred ward!"
	OffMessage="the sacred ward fades."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Tetraja
	ElementalClass="Light"
	applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/TetrajaApply
	EndYourself=1
	Cooldown=180
	ActiveMessage="invokes a sacred ward upon themselves!"
	OffMessage="finishes casting Tetraja."
	verb/Tetraja()
		set category="Skills"
		if(!altered)
			adjust(usr)
			applyToTarget?:adjust(usr)
		src.Trigger(usr)

// =========================================================================
// Djed skills (self-buffs)
// =========================================================================

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/TarukajaApply
	StrMult=1.25
	ForMult=1.25
	TimerLimit=30
	ActiveMessage="has their offensive power bolstered!"
	OffMessage="the offensive bolster fades."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Tarukaja
	applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/TarukajaApply
	EndYourself=1
	Cooldown=60
	ActiveMessage="bolsters their offensive power!"
	OffMessage="finishes casting Tarukaja."
	verb/Tarukaja()
		set category="Skills"
		if(!altered)
			adjust(usr)
			applyToTarget?:adjust(usr)
		src.Trigger(usr)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/RakukajaApply
	EndMult=1.25
	TimerLimit=30
	ActiveMessage="has their endurance bolstered!"
	OffMessage="the defensive bolster fades."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Rakukaja
	applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/RakukajaApply
	EndYourself=1
	Cooldown=60
	ActiveMessage="bolsters their endurance!"
	OffMessage="finishes casting Rakukaja."
	verb/Rakukaja()
		set category="Skills"
		if(!altered)
			adjust(usr)
			applyToTarget?:adjust(usr)
		src.Trigger(usr)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/SukukajaApply
	SpdMult=1.25
	OffMult=1.25
	DefMult=1.25
	TimerLimit=30
	ActiveMessage="has their agility bolstered!"
	OffMessage="the agility bolster fades."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Sukukaja
	applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/SukukajaApply
	EndYourself=1
	Cooldown=60
	ActiveMessage="bolsters their agility!"
	OffMessage="finishes casting Sukukaja."
	verb/Sukukaja()
		set category="Skills"
		if(!altered)
			adjust(usr)
			applyToTarget?:adjust(usr)
		src.Trigger(usr)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/MakakajaApply
	ForMult=1.25
	TimerLimit=30
	ActiveMessage="has their magical fortitude bolstered!"
	OffMessage="the magical bolster fades."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Makakaja
	applyToTarget = new/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/MakakajaApply
	EndYourself=1
	Cooldown=60
	ActiveMessage="bolsters their magical fortitude!"
	OffMessage="finishes casting Makakaja."
	verb/Makakaja()
		set category="Skills"
		if(!altered)
			adjust(usr)
			applyToTarget?:adjust(usr)
		src.Trigger(usr)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/DekajaApply
	StrMult=0.75
	ForMult=0.75
	EndMult=0.75
	SpdMult=0.75
	OffMult=0.75
	DefMult=0.75
	TimerLimit=20
	ActiveMessage="has all their enhancements stripped away!"
	OffMessage="recovers from the Dekaja dispel."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Dekaja
	EndYourself=1
	Cooldown=120
	ActiveMessage="invokes a sweeping dispel!"
	OffMessage="finishes casting Dekaja."
	verb/Dekaja()
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
			var/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/DekajaApply/applyBuff = new
			applyBuff.Trigger(m, 1)
			hit++
		if(hit)
			User.OMessage(1, null, "[User] invokes Dekaja, stripping enhancements from [hit] nearby foe\s!")
		else
			User << "No enemies nearby to dispel."
			return
		src.Cooldown(1, null, User)

// =========================================================================
// Muspell skills
// =========================================================================

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/TentarafooApply
	TimerLimit=20
	ActiveMessage="is beset by dizzying phantasms!"
	OffMessage="the phantasms fade."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Tentarafoo
	EndYourself=1
	Cooldown=75
	ActiveMessage="unleashes dizzying phantasms!"
	OffMessage="finishes casting Tentarafoo."
	verb/Tentarafoo()
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
			m.AddConfusing(40, User)
			var/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/TentarafooApply/applyBuff = new
			applyBuff.Trigger(m, 1)
			hit++
		if(hit)
			User.OMessage(1, null, "[User] invokes Tentarafoo, confusing [hit] nearby foe\s!")
		else
			User << "No enemies nearby."
			return
		src.Cooldown(1, null, User)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/MakajamonApply
	TimerLimit=20
	ActiveMessage="is silenced by an ancient curse!"
	OffMessage="the silencing curse fades."

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Makajamon
	EndYourself=1
	Cooldown=75
	ActiveMessage="unleashes a silencing curse!"
	OffMessage="finishes casting Makajamon."
	verb/Makajamon()
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
			m.AddPacifying(1, User)
			var/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/MakajamonApply/applyBuff = new
			applyBuff.Trigger(m, 1)
			hit++
		if(hit)
			User.OMessage(1, null, "[User] invokes Makajamon, silencing [hit] nearby foe\s!")
		else
			User << "No enemies nearby."
			return
		src.Cooldown(1, null, User)

/obj/Skills/AutoHit/DemiFiend/Xeros_Beat
	Area="Wave"
	Distance=8
	DamageMult=14
	StrOffense=2
	SpecialAttack=1
	CriticalChance=30
	ObjIcon=1
	Icon='Impacts VFX1.dmi'
	IconX=-16
	IconY=-16
	Size=2
	Rounds=12
	DelayTime=2
	HitSparkIcon='Hit Effect Wind.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1
	HitSparkDispersion=1
	TurfStrike=1
	Cooldown=90
	WindUp=0.5
	WindupMessage="crushes the ground underfoot..."
	ActiveMessage="unleashes a devastating Xeros Beat!"
	verb/Xeros_Beat()
		set category="Skills"
		if(!altered)
			DamageMult = 10 + (2 * usr.AscensionsAcquired)
			Distance = 8 + (2 * usr.AscensionsAcquired)
			StrOffense = 2 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)

// =========================================================================
// Gehenna skills
// =========================================================================

/obj/Skills/AutoHit/DemiFiend/Hellfire
	ElementalClass="Fire"
	SpellElement="Fire"
	Area="Wave"
	Distance=10
	DamageMult=16
	StrOffense=1
	ForOffense=2
	SpecialAttack=1
	GuardBreak=1
	Scorching=100
	Combustion=50
	ObjIcon=1
	Icon='fevExplosion - Hellfire.dmi'
	IconX=-16
	IconY=-16
	Size=2
	Rounds=10
	DelayTime=2
	HitSparkIcon='BLANK.dmi'
	HitSparkX=0
	HitSparkY=0
	TurfErupt=1
	Cooldown=90
	WindUp=0.8
	WindupMessage="draws breath from the valley of flames..."
	ActiveMessage="unleashes the roar of Hellfire!"
	verb/Hellfire()
		set category="Skills"
		if(!altered)
			DamageMult = 10 + (3 * usr.AscensionsAcquired)
			Distance = 10 + (2 * usr.AscensionsAcquired)
			ForOffense = 2 + (0.5 * usr.AscensionsAcquired)
			StrOffense = 1 + (0.25 * usr.AscensionsAcquired)
		usr.Activate(src)

/obj/Skills/AutoHit/DemiFiend/Magma_Axis
	ElementalClass="Fire"
	SpellElement="Fire"
	Area="Wave"
	Distance=6
	Rush=5
	ControlledRush=1
	DamageMult=14
	StrOffense=2
	ForOffense=1
	SpecialAttack=1
	GuardBreak=1
	Scorching=75
	ObjIcon=1
	Icon='Slash - Hellfire.dmi'
	IconX=-16
	IconY=-16
	Size=2
	Rounds=8
	DelayTime=2
	HitSparkIcon='Hit Effect Wind.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1
	HitSparkDispersion=1
	TurfStrike=1
	TurfErupt=1
	Cooldown=75
	WindUp=0.5
	WindupMessage="ignites the ground along the blade's path..."
	ActiveMessage="cleaves forward with Magma Axis!"
	verb/Magma_Axis()
		set category="Skills"
		if(!altered)
			DamageMult = 10 + (2 * usr.AscensionsAcquired)
			Distance = 6 + (2 * usr.AscensionsAcquired)
			Rush = 5 + (1 * usr.AscensionsAcquired)
			StrOffense = 2 + (0.5 * usr.AscensionsAcquired)
			ForOffense = 1 + (0.25 * usr.AscensionsAcquired)
		usr.Activate(src)

// =========================================================================
// Kamurogi skills
// =========================================================================

/obj/Skills/AutoHit/DemiFiend/Blight
	Area="Wave"
	Distance=7
	DamageMult=14
	StrOffense=2
	SpecialAttack=1
	GuardBreak=1
	Poisoning=60
	ObjIcon=1
	Icon='PoisonGas.dmi'
	IconX=-16
	IconY=-16
	Size=2
	Rounds=10
	DelayTime=2
	HitSparkIcon='BLANK.dmi'
	HitSparkX=0
	HitSparkY=0
	Cooldown=75
	WindUp=0.5
	WindupMessage="gathers virulent essence..."
	ActiveMessage="unleashes a choking wave of Blight!"
	verb/Blight()
		set category="Skills"
		if(!altered)
			DamageMult = 14 + (2 * usr.AscensionsAcquired)
			Distance = 7 + (2 * usr.AscensionsAcquired)
			StrOffense = 2 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)

/obj/Skills/AutoHit/DemiFiend/Iron_Claw
	Area="Wave"
	Distance=4
	Rush=4
	ControlledRush=1
	DamageMult=12
	StrOffense=3
	SpecialAttack=1
	GuardBreak=1
	ObjIcon=1
	Icon='Slash - Ragna.dmi'
	IconX=-16
	IconY=-16
	Size=1.5
	Rounds=3
	DelayTime=1
	HitSparkIcon='Hit Effect Wind.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1
	Cooldown=45
	WindUp=0.3
	WindupMessage="tenses their hand into a claw..."
	ActiveMessage="lashes out with Iron Claw!"
	verb/Iron_Claw()
		set category="Skills"
		if(!altered)
			DamageMult = 12 + (2 * usr.AscensionsAcquired)
			Distance = 4 + (1 * usr.AscensionsAcquired)
			Rush = 4 + (1 * usr.AscensionsAcquired)
			StrOffense = 3 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)

/obj/Skills/AutoHit/DemiFiend/Oni_Kagura
	Area="Circle"
	Distance=1
	Wander=10
	DamageMult=18
	StrOffense=3
	SpecialAttack=1
	GuardBreak=1
	ObjIcon=1
	Icon='Slash - Ragna.dmi'
	IconX=-16
	IconY=-16
	Size=2
	Rounds=8
	DelayTime=2
	HitSparkIcon='Hit Effect Wind.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1
	HitSparkDispersion=1
	TurfStrike=1
	Cooldown=120
	WindUp=0.6
	WindupMessage="invokes the ancestral dance of the Oni..."
	ActiveMessage="whirls into the fury of Oni-Kagura!"
	verb/Oni_Kagura()
		set category="Skills"
		if(!altered)
			DamageMult = 18 + (2 * usr.AscensionsAcquired)
			Wander = 10 + (2 * usr.AscensionsAcquired)
			StrOffense = 3 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)

// =========================================================================
// Satan skills
// =========================================================================

/obj/Skills/AutoHit/DemiFiend/Deadly_Fury
	Area="Wave"
	Distance=6
	Rush=5
	ControlledRush=1
	DamageMult=20
	StrOffense=3
	SpecialAttack=1
	GuardBreak=1
	CriticalChance=25
	ObjIcon=1
	Icon='Slash - Ragna.dmi'
	IconX=-16
	IconY=-16
	Size=2
	Rounds=6
	DelayTime=2
	HitSparkIcon='Hit Effect Wind.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1
	Cooldown=120
	WindUp=0.5
	WindupMessage="burns with murderous intent..."
	ActiveMessage="erupts into Deadly Fury!"
	verb/Deadly_Fury()
		set category="Skills"
		if(!altered)
			DamageMult = 20 + (2 * usr.AscensionsAcquired)
			Distance = 6 + (2 * usr.AscensionsAcquired)
			Rush = 5 + (1 * usr.AscensionsAcquired)
			StrOffense = 3 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)

// =========================================================================
// Adama skills
// =========================================================================

/obj/Skills/AutoHit/DemiFiend/Bolt_Storm
	ElementalClass="Wind"
	SpellElement="Wind"
	Area="Circle"
	Distance=1
	Wander=12
	DamageMult=16
	ForOffense=3
	SpecialAttack=1
	Shocking=100
	ObjIcon=1
	Icon='SparkleYellow.dmi'
	IconX=-16
	IconY=-16
	Size=2
	Rounds=14
	DelayTime=2
	HitSparkIcon='BLANK.dmi'
	HitSparkX=0
	HitSparkY=0
	TurfStrike=1
	Cooldown=120
	WindUp=0.6
	WindupMessage="draws down a thundering squall..."
	ActiveMessage="calls forth a Bolt Storm!"
	verb/Bolt_Storm()
		set category="Skills"
		if(!altered)
			DamageMult = 16 + (2 * usr.AscensionsAcquired)
			Wander = 12 + (2 * usr.AscensionsAcquired)
			ForOffense = 3 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)

// =========================================================================
// Vimana skills
// =========================================================================

/obj/Skills/AutoHit/DemiFiend/Tempest
	ElementalClass="Wind"
	SpellElement="Wind"
	Area="Wave"
	Distance=10
	DamageMult=15
	ForOffense=2
	SpecialAttack=1
	Shearing=75
	ObjIcon=1
	Icon='SparkleGreen.dmi'
	IconX=-16
	IconY=-16
	Size=2
	Rounds=10
	DelayTime=2
	HitSparkIcon='Hit Effect Wind.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1
	Cooldown=90
	WindUp=0.5
	WindupMessage="whirls the air into a cutting gale..."
	ActiveMessage="unleashes a howling Tempest!"
	verb/Tempest()
		set category="Skills"
		if(!altered)
			DamageMult = 15 + (2 * usr.AscensionsAcquired)
			Distance = 10 + (2 * usr.AscensionsAcquired)
			ForOffense = 2 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)

/obj/Skills/AutoHit/DemiFiend/Javelin_Rain
	ElementalClass="Wind"
	SpellElement="Wind"
	Area="Circle"
	Distance=1
	Wander=10
	DamageMult=14
	ForOffense=2
	SpecialAttack=1
	Shearing=50
	Pacifying=50
	ObjIcon=1
	Icon='SparkleGreen.dmi'
	IconX=-16
	IconY=-16
	Size=1.5
	Rounds=14
	DelayTime=2
	HitSparkIcon='BLANK.dmi'
	HitSparkX=0
	HitSparkY=0
	Cooldown=120
	WindUp=0.6
	WindupMessage="calls down the heavens' spears..."
	ActiveMessage="unleashes a deluge of Javelin Rain!"
	verb/Javelin_Rain()
		set category="Skills"
		if(!altered)
			DamageMult = 14 + (2 * usr.AscensionsAcquired)
			Wander = 10 + (2 * usr.AscensionsAcquired)
			ForOffense = 2 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)

// =========================================================================
// Gundari skills
// =========================================================================

/obj/Skills/Projectile/DemiFiend/Wind_Cutter
	ElementalClass="Wind"
	SpellElement="Wind"
	IconLock='SparkleGreen.dmi'
	IconSize=1
	LockX=-16
	LockY=-16
	Speed=0.2
	Distance=22
	DamageMult=10
	ForRate=1
	Shearing=50
	Homing=1
	Cooldown=45
	verb/Wind_Cutter()
		set category="Skills"
		if(!altered)
			DamageMult = 10 + (1.5 * usr.AscensionsAcquired)
			Distance = 22 + (2 * usr.AscensionsAcquired)
		usr.UseProjectile(src)

/obj/Skills/AutoHit/DemiFiend/Spiral_Viper
	Area="Wave"
	Distance=8
	Rush=7
	ControlledRush=1
	DamageMult=16
	StrOffense=2
	ForOffense=1
	SpecialAttack=1
	GuardBreak=1
	CriticalChance=30
	Shearing=50
	ObjIcon=1
	Icon='Slash - Ragna.dmi'
	IconX=-16
	IconY=-16
	Size=1.5
	Rounds=6
	DelayTime=1
	HitSparkIcon='Hit Effect Wind.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1
	Cooldown=100
	WindUp=0.4
	WindupMessage="coils around themselves like a serpent..."
	ActiveMessage="lashes out with Spiral Viper!"
	verb/Spiral_Viper()
		set category="Skills"
		if(!altered)
			DamageMult = 16 + (2 * usr.AscensionsAcquired)
			Distance = 8 + (2 * usr.AscensionsAcquired)
			Rush = 7 + (1 * usr.AscensionsAcquired)
			StrOffense = 2 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)

// =========================================================================
// Sophia skills
// =========================================================================

/obj/Skills/Projectile/DemiFiend/Thunderclap
	ElementalClass="Light"
	SpellElement="Light"
	IconLock='AvalonLight.dmi'
	IconSize=1
	LockX=-16
	LockY=-16
	Speed=0.2
	Distance=24
	DamageMult=11
	ForRate=1
	Homing=1
	Cooldown=50
	verb/Thunderclap()
		set category="Skills"
		if(!altered)
			DamageMult = 11 + (1.5 * usr.AscensionsAcquired)
			Distance = 24 + (2 * usr.AscensionsAcquired)
		usr.UseProjectile(src)

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/MediarahanApply
	StableHeal=1
	HealthHeal=30
	TimerLimit=10
	ActiveMessage="is bathed in radiant healing light!"
	OffMessage="the radiant healing fades..."
	MagicNeeded=0

obj/Skills/Buffs/SlotlessBuffs/DemiFiend/Mediarahan
	ElementalClass="Light"
	EndYourself=1
	Cooldown=600
	KenWave=1
	KenWaveIcon='SparkleYellow.dmi'
	KenWaveSize=6
	KenWaveX=105
	KenWaveY=105
	ActiveMessage="calls down a flood of miraculous light upon their party!"
	OffMessage="finishes casting Mediarahan."
	verb/Mediarahan()
		set category="Skills"
		var/mob/User = usr
		if(!User.party || !User.party.members || User.party.members.len == 0)
			User << "You need to be in a party to use Mediarahan."
			return
		if(!altered)
			adjust(User)
		for(var/mob/m in User.party.members)
			if(!m || !ismob(m)) continue
			var/obj/Skills/Buffs/SlotlessBuffs/DemiFiend/MediarahanApply/applyBuff = new
			applyBuff.HealthHeal = 30
			applyBuff.StableHeal = 1
			applyBuff.TimerLimit = 10
			applyBuff.Trigger(m, 1)
		User.OMessage(1, null, "[User] calls down a flood of miraculous light upon [User.party.members.len == 1 ? "themselves" : "their party"]!")
		src.Cooldown(1, null, User)

/obj/Skills/AutoHit/DemiFiend/Holy_Wrath
	ElementalClass="Light"
	SpellElement="Light"
	Area="Circle"
	Distance=1
	Wander=10
	DamageMult=18
	ForOffense=3
	SpecialAttack=1
	GuardBreak=1
	ObjIcon=1
	Icon='AvalonLight.dmi'
	IconX=-16
	IconY=-16
	Size=2
	Rounds=10
	DelayTime=2
	HitSparkIcon='BLANK.dmi'
	HitSparkX=0
	HitSparkY=0
	Cooldown=150
	WindUp=0.7
	WindupMessage="calls forth divine condemnation..."
	ActiveMessage="unleashes Holy Wrath upon the wicked!"
	verb/Holy_Wrath()
		set category="Skills"
		if(!altered)
			DamageMult = 18 + (2 * usr.AscensionsAcquired)
			Wander = 10 + (2 * usr.AscensionsAcquired)
			ForOffense = 3 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)

// =========================================================================
// Gaea skills
// =========================================================================

/obj/Skills/AutoHit/DemiFiend/Deathbound
	Area="Circle"
	Distance=1
	Wander=8
	DamageMult=16
	StrOffense=3
	SpecialAttack=1
	GuardBreak=1
	CriticalChance=10
	ObjIcon=1
	Icon='Slash - Ragna.dmi'
	IconX=-16
	IconY=-16
	Size=2
	Rounds=8
	DelayTime=2
	HitSparkIcon='Hit Effect Wind.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1
	HitSparkDispersion=1
	Cooldown=100
	WindUp=0.5
	WindupMessage="winds up for a sweeping strike..."
	ActiveMessage="cleaves outward with Deathbound!"
	verb/Deathbound()
		set category="Skills"
		if(!altered)
			DamageMult = 16 + (2 * usr.AscensionsAcquired)
			Wander = 8 + (2 * usr.AscensionsAcquired)
			StrOffense = 3 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)

/obj/Skills/AutoHit/DemiFiend/Gaea_Rage
	Area="Circle"
	Distance=1
	Wander=14
	DamageMult=26
	StrOffense=4
	ForOffense=2
	SpecialAttack=1
	GuardBreak=1
	ObjIcon=1
	Icon='Impacts VFX1.dmi'
	IconX=-16
	IconY=-16
	Size=3
	Rounds=14
	DelayTime=2
	HitSparkIcon='Hit Effect Wind.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=2
	HitSparkDispersion=1
	TurfStrike=1
	Cooldown=180
	WindUp=0.9
	WindupMessage="gathers the fury of the living earth..."
	ActiveMessage="erupts into Gaea Rage!"
	verb/Gaea_Rage()
		set category="Skills"
		if(!altered)
			DamageMult = 26 + (3 * usr.AscensionsAcquired)
			Wander = 14 + (2 * usr.AscensionsAcquired)
			StrOffense = 4 + (0.5 * usr.AscensionsAcquired)
			ForOffense = 2 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)

// =========================================================================
// Kailash skills
// =========================================================================

/obj/Skills/AutoHit/DemiFiend/Hades_Blast
	Area="Circle"
	Distance=1
	Wander=12
	DamageMult=22
	StrOffense=3
	ForOffense=2
	SpecialAttack=1
	GuardBreak=1
	ObjIcon=1
	Icon='Impacts VFX1.dmi'
	IconX=-16
	IconY=-16
	Size=2
	Rounds=12
	DelayTime=2
	HitSparkIcon='Hit Effect Wind.dmi'
	HitSparkX=-32
	HitSparkY=-32
	HitSparkTurns=1
	HitSparkSize=1
	HitSparkDispersion=1
	TurfStrike=1
	Cooldown=150
	WindUp=0.8
	WindupMessage="gathers the unbearable weight of the underworld..."
	ActiveMessage="unleashes a shattering Hades Blast!"
	verb/Hades_Blast()
		set category="Skills"
		if(!altered)
			DamageMult = 22 + (3 * usr.AscensionsAcquired)
			Wander = 12 + (2 * usr.AscensionsAcquired)
			StrOffense = 3 + (0.5 * usr.AscensionsAcquired)
			ForOffense = 2 + (0.5 * usr.AscensionsAcquired)
		usr.Activate(src)
