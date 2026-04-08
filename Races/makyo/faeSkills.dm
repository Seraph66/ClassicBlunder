/obj/Skills/Buffs/SlotlessBuffs/Makyo/Awaken_Star_Power
	passives = list("StarPower" = 1)
	VaizardHealth = 50
	VaizardShatter = 1
	StrTax=0.45
	ForTax=0.45
	SpdTax=0.25
	EndTax=0.45
	OffTax=0.45
	DefTax=0.45
	Cooldown=600
	HealthThreshold = 75
	StrMult=1.5
	ForMult=1.5
	EndMult=1.5
	ActiveMessage="ignites the spark of the Makyo Star within them, as its power, once thought lost, shines brightly within them!!!"
	OffMessage="shrivels up as the power of the star leaves them."
	verb/Awaken_Star_Power()
		set category="Skills"
		src.Trigger(usr)
/obj/Skills/Buffs/SlotlessBuffs/Makyo/Sword_of_Sunlight
	MakesSword=1
	FlashDraw=1
	SwordName="Sword of Sunlight"
	SwordIcon='Aether Blade.dmi' //PLACEHOLDER
	SwordX=-32
	SwordY=-32
	SwordAscension=2
	MagicSword=1
	ActiveMessage="manifests a beam of hardened sunlight in the shape of a blade...."
	OffMessage="dispels their Sword of Sunlight!"
	var/saved_icon = 'Ripple Arms.dmi' //PLACEHOLDER
	adjust(mob/p)
		var/asc = p.AscensionsAcquired
		if(p.usingStyle("UnarmedStyle"))
			MakesSword = 0
			passives = list("SpiritHand" = (1 + (asc/2)) / 2, "MartialMagic" = 1, "BurningShot" = (0.5 + (0.1 * asc)), "BurnHit" = (2 * asc))
			ElementalOffense = "Fire"
			BurnAffected=5 * asc
			IconLock = saved_icon
		else
			passives = list("SpiritSword" = (1 + (asc/2)) / 2, "MagicSword" = 1, "BurningShot"=(0.5 + (0.1 * asc)), "BurnHit" = (2 * asc))
			SwordAscension = asc
			SwordAscensionSecond = asc
			SwordAscensionThird = asc
			ElementalEnchantment = "Fire"
			BurnAffected=5 * asc
			IconLock = null
	verb/Modify_Sword_of_Sunlight()
		set category="Skills"
		src.SwordIcon=input(usr, "What icon will your Sword of Sunlight use?", "Sword of Sunlight Icon") as icon|null
		src.SwordX=input(usr, "Pixel X offset.", "Sword of Sunlight Icon") as num
		src.SwordY=input(usr, "Pixel Y offset.", "Sword of Sunlight Icon") as num
		src.SwordClass=input(usr, "What class will your Sword of Sunlight be?", "Sword of Sunlight Icon") in list("Heavy", "Medium", "Light", "Wooden")
		saved_icon = input(usr, "What do you want your unarmed variant icon to be?") as icon|null
		LockX = input(usr, "Pixel X offset.", "Unarmed Variant Icon") as num
		LockY = input(usr, "Pixel Y offset.", "Unarmed Variant Icon") as num
	verb/Sword_of_Summer()
		set category="Skills"
		if(!usr.BuffOn(src))
			adjust(usr)
			src.Trigger(usr)

/obj/Skills/Buffs/SlotlessBuffs/Makyo/Crown_of_Rime // Winter Active
	MakesArmor=1
	ArmorElement= "Water"
	ArmorClass= "Light"
	ArmorIcon= 'Elf_Crown.dmi'
	ActiveMessage= "dons a crown of hoarfrost!"
	OffMessage= "discards their crown of arctic sovereignity..."
	adjust(mob/p)
		var/asc = p.AscensionsAcquired
		if(p.AscensionsAcquired>=3)
			TimerLimit=null
			passives = list("Erosion" = 0.25 * asc, "Harden" = 1 * asc, "AbsoluteZero" = 1, "VoidField" =1 * asc, "DeathField" = 1 * asc)
		else
			TimerLimit= 60 * asc
			passives = list("Erosion" =0.1 * asc, "Harden" = 0.5 * asc, "VoidField"= 0.5 * asc)
	verb/Mould_Crown()
		set category="Skills"
		src.ArmorIcon=input(usr, "What icon will your Crown of Rhime use?", "Crown of Rhime Icon") as icon|null
		src.ArmorX=input(usr, "Pixel X offset.", "Crown of Rhime Icon") as num
		src.ArmorY=input(usr, "Pixel Y offset.", "Crown of Rhime Icon") as num
		src.ArmorClass=input(usr, "What class will your Crown of Rhime be?", "Crown of Rhime Class") in list("Heavy", "Medium", "Light")
	verb/Crown_of_Rime()
		set category="Skills"
		if(!usr.BuffOn(src))
			adjust(usr)
			src.Trigger(usr)

/obj/Skills/Buffs/SlotlessBuffs/Makyo/Fall/Shedding_Leaves
	EndMult=0.6
	TimerLimit=60
	passives= list("DebuffImmunity"=1, "ManaGeneration"= 10, "EnergyGeneration" =10,"PureReduction"= -5)
	verb/Shed_Leaves()
		set category="Skills"
		src.Trigger(usr)
/obj/Skills/Buffs/SlotlessBuffs/Makyo/Fall/Harvest_Time
	SpdMult=0.25
	TimerLimit=60
	passives= list("SlayerMod"=5, "FavoredPrey"= "Mortal", "GodspeedDisabled"= 1, "Extend" = 1, "Gum-Gum" = 1)
	verb/Time_to_Harvest()
		set category="Skills"
		src.Trigger(usr)
/obj/Skills/Buffs/SlotlessBuffs/Makyo/Fall/Hibernation_Preparation
	EndMult=1.5
	TimerLimit=60
	ManaDrain=5
	FatigueDrain=5
	passives= list("PureReduction" = 5, "Blubber" = 3)
	verb/Hibernation_Preparation()
		set category="Skills"
		src.Trigger(usr)
	//To do: Make these mutually exclusive, similar to Spiritwalker Stances, make scale with ascension, and tinker with values