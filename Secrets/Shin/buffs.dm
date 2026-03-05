#define MANG_BASE_VALUE 0.3 // The base value when you activate mang
#define MANG_MULT_VALUE 0.1 // The extra value from higher mang
#define MANG_MANA_COST 10 // Determines the cost of activating a Mang Ring/Level

/obj/Skills/Buffs/SlotlessBuffs/Shin_Radiance
    passives = list("GiantForm" = 1, "Harden" = 1, "PureReduction" = 1, "Godspeed" = 1, "Deflection" = 1, "ManaGeneration" = 1, "Unnerve" = 1) // SOME OF THESE GET CHANGED IN THE ADJUST
    ActiveMessage="radiates a soft, warding glow of Light."
    OffMessage="suppresses the glow of the Light, letting their emotions flow on."
    TextColor=rgb(203, 198, 47)
    CantHaveTheseBuffs = list("Mang Resonance")
    //Base mults
    EndMult = 1.2 
    DefMult = 1.2
    ManaGlow = "#c7b921"
    ManaGlowSize = 2
    adjust(mob/p)
        var/secretLevel = p.secretDatum.currentTier
        var/mod = (secretLevel-5)
        // Tier Adjusted Mults
        EndMult = 1.2 + (0.05 * secretLevel) 
        DefMult = 1.2 + (0.05 * secretLevel)
        // Tier Adjusted Passives
        passives["Harden"] = clamp(secretLevel*2, 1, 5) // starts at 1, adds 2 per tier, caps at 5 (tier 3)
        passives["PureReduction"] = clamp(secretLevel >= 3 ? (secretLevel+mod) : 0, 0, 5); //Scales from tier 3 (1) to tier 5 (5)
        passives["Godspeed"] = secretLevel
        passives["Deflection"] = (0.5 * secretLevel) //Goes from 1 to 3
        passives["ManaGeneration"] = secretLevel
        passives["Unnerve"] = secretLevel // Aura Farming as a passive.
        // It also replaces your mana name to Shin but REPLACEMANA IS A STUPID FUCKING PASSIVE SO I DID IT IN THE UPDATE_STAT_LABELS PROC FUCK FUCK FUCK


    verb/Shin_Radiance()
        set category = "Skills"
        if(!usr.BuffOn(src)) adjust(usr)
        src.Trigger(usr)

    verb/Shin_Colour()
        set category = "Utility"
        var/colour = input(usr, "Select your Shin Colour", "Shin Colour Selection", rgb(203, 198, 47)) as color | null ;
        ManaGlow = colour

/obj/Skills/Buffs/SlotlessBuffs/Mang_Resonance // FAIL TO READ BELOW THIS UNDER PENALTY OF DEATH
    ActiveMessage="fills the emptiness with their most intense emotion, creating rings that hum with power."
    OffMessage="'s Mang begin to fade as the moment passes."
    TextColor=rgb(203, 198, 167)
    TimerLimit = 30
    Cooldown = 30
    IconLock = 'Icons/Buffs/SecretBuffs/Mang/MangRing1.dmi'
   // IconApart = 1

     /* All of Mang's passives and stats are scattered across passive procs. This is so that they can scale based off of how many Mang you have
     The passives are as follows: Steady, Godspeed, Brutalize, BlurringStrikes, BuffMastery, PureDamage
     They scale off of how many mang you have active. They do NOT show up in the passive handler rn
     Please do not go screaming about how "Mang does nothing" I will gut you myself - Hadoje */
     
    
    /* verb/Manifest_Mang() // This is a debug verb
        set category = "Skills"
        if(!usr.BuffOn(src)) adjust(usr)
        src.Trigger(usr) */

// A bunch of procs that will be used in PowerControl.dmand for passives.

mob/proc/GetMangStats() //This proc is ued in _JinxUtility.dm specifically for adding Strength, Force, Speed, and offense based on the defines. 
    var/SecretInformation/Shin/ShinSecret = secretDatum
    return MANG_BASE_VALUE + (ShinSecret.Mang * MANG_MULT_VALUE)

mob/proc/GetMangLevel() //This proc gets how many Mang you have active is used in _BinaryChecks.dm, BlurringStrikes.dm, and Brutalize.dm
    if(Secret == "Shin")
        var/SecretInformation/Shin/ShinSecret = secretDatum
        return ShinSecret.Mang
    return 0

mob/proc/GetMangMastery() //This proc gets your max amount of mang
    if(Secret == "Shin")
        var/SecretInformation/Shin/ShinSecret = secretDatum
        return ShinSecret.MangMastery
    return 0

mob/proc/AddMangLevel() // This increases your active mang level
    var/SecretInformation/Shin/ShinSecret = secretDatum
    ShinSecret.Mang++
    OMsg(src, "<b>[GetMangLevel() >= 5 ? "<font color='red'>Ain't that a motherfu--</font color>" : "<font color='[rgb(241, 236, 129)]>[src] manifests [GetMangLevel()] Mang Rings!</font color>"]</b>");

mob/proc/ReduceMangLevel() // This decreases your active mang level
    var/SecretInformation/Shin/ShinSecret = secretDatum
    ShinSecret.Mang--
    OMsg(src, "<b><font color='[rgb(241, 236, 129)]'>[src] manifests [GetMangLevel()] Mang Rings!</font color></b>")

mob/proc/ShinActive() // This checks if Shin is on
    if(Secret == "Shin" && CheckSlotless("Shin Radiance"))
        return 1
    return 0

mob/proc/MangActive() // THis checks if Mang is on
    if(Secret == "Shin" && CheckSlotless("Mang Resonance"))
        return 1
    return 0

mob/proc/MangToShin() // This transitions Mang to Shin (Congratulations on your transition)
    for (var/obj/Skills/Buffs/SlotlessBuffs/Mang_Resonance/mr in contents)
        if(BuffOn(mr)) mr.Trigger(src, Override=1);
    for(var/obj/Skills/Buffs/SlotlessBuffs/Shin_Radiance/sr in contents)
        if(!BuffOn(sr)) sr.Trigger(src, Override=1);

mob/proc/MangManaPay(fullcost = 0) // It's a surprise tool that helps us later
    if(fullcost)
        return clamp(GetMangLevel()+1, 1, 5)
    return 1    

mob/proc/MangManaCost() // Checks if you have the mana before spending it.
    var/MangLevelCost = MANG_MANA_COST * MangManaPay(!MangActive()) // This is later (tl;dr determines if you pay per increment or for all mang)
    if(GetMangMastery() == GetMangLevel()) return
    if(ManaAmount >= MangLevelCost)
        LoseMana(MangLevelCost)
        return 1
    if(ManaAmount < MangLevelCost)
        return 0


mob/proc/MangOnCD()
    for(var/obj/Skills/Buffs/SlotlessBuffs/Mang_Resonance/mr in contents)
        if(mr.Using)
            return 1
    return 0

mob/proc/ShinSecretLevel() // This is currently not in use
        var/secretLevel = src.secretDatum.currentTier
        return secretLevel

//Can you tell I'm losing it yet?


//Thank you for these Yan <3
mob/proc/usingShinBuff() // Checks if we're using shin
  return CheckSlotless("Shin Radiance") ? 1 : 0;

mob/proc/startShinBuff() // Turns Shin on (owo)
  for(var/obj/Skills/Buffs/SlotlessBuffs/Shin_Radiance/sr in contents)
    if(!BuffOn(sr)) sr.Trigger(src, Override=1);

mob/proc/endShinBuff() // Turns Shin off (aww)
  for(var/obj/Skills/Buffs/SlotlessBuffs/Shin_Radiance/sr in contents)
    if(BuffOn(sr)) sr.Trigger(src, Override=1);

mob/proc/usingMangBuff() // Checks if we're using Mang
  return CheckSlotless("Mang Resonance") ? 1 : 0;

mob/proc/startMangBuff() // Turns Mang on (uwu)
  for(var/obj/Skills/Buffs/SlotlessBuffs/Mang_Resonance/mr in contents)
    if(!BuffOn(mr)) mr.Trigger(src, Override=1);

mob/proc/endMangBuff() // Turns Mang off (Oops)
  for(var/obj/Skills/Buffs/SlotlessBuffs/Mang_Resonance/mr in contents)
    if(BuffOn(mr)) mr.Trigger(src, Override=1);

mob/proc/MangCDSwap(obj/Skills/Buffs/SlotlessBuffs/Mang_Resonance/mr) // This is currently commented out in Skills_.dm because it breaks cooldowns
    if(istype(mr, /obj/Skills/Buffs/SlotlessBuffs/Mang_Resonance))
        startShinBuff()