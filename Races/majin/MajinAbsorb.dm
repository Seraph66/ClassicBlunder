/*
The intention of absorb is to absorb the person when they are KO'd
 and apply a minor tax
As well as a wound / maiming to the person who absorbed the person
When absorbing people will be able to take passives from the target
and there's a limit to how many they can have
Super can absorb more and have more passives (stacking mayhaps?)
Only issue i see with this is we either tie it to a slotless buff
making it a style will cause issues.
*/


majinAbsorb
    var/list/absorbed = list() // list of absorbed people
    var/list/passives = list() // passives that are attacked to buffs
    var/list/racialPassives = list() // passives attached to racials
    var/absorbLimit = 2
    var/absorbCount = 0
    var/absorbTax = 5 // 3% tax
    var/absorbPassiveTickLimit = 0.5
    var/tickPerAbsorb = 0.25
    // Some passives work differently and will get a boost, also some races provide more
majinAbsorb/proc/updateVariables(mob/p, clear = FALSE)
    var/Super = p.Class == "Super" ? TRUE : FALSE
    var/asc = p.AscensionsAcquired
    absorbLimit = MAJIN_ABSORB_LIMIT + (Super ? (asc*2) : asc)
    absorbPassiveTickLimit = MAJIN_PASSIVE_LIMIT + ( (asc-1) * MAJIN_PASSIVE_LIMIT ) + (Super ? MAJIN_PASSIVE_LIMIT : 0)
    absorbTax = 3 + (MAJIN_ABSORB_TAX * asc)
    tickPerAbsorb = 0.25 + ((asc*0.5) * 1) + (Super ? 1.25 : 0.25)
    absorbCount = absorbed.len

#define BOOSTPASSIVES list("Piloting Prowess", "Intimidation")
#define NERFPASSIVES list("StealsStats", "HellPower","GodKi","SpiritPower", "BuffMastery", "Desperation", "DemonicDurability")
#define MAKEFULL list("EnhancedSmell", "EnhancedHearing")
#define NORMALBOOST 2.5
#define SHINJINBOOST 5


majinAbsorb/proc/addAbsorbee(mob/p)
    absorbed["[p.ckey]"] = p.ckey
    p<< "You feel a part of your powers get absorbed away!"

majinAbsorb/proc/nerfAbsorbee(mob/p)
    var/nerf = absorbTax / 100
    p.StrTax += nerf
    p.EndTax += nerf
    p.ForTax += nerf

majinAbsorb/proc/addRacialPassive(passiveName)
    if(passiveName in racialPassives)
        return
    racialPassives += passiveName

majinAbsorb/proc/adjustPassive(passiveName, race/race)
    if(race.name == "Shinjin")
        return SHINJINBOOST
    if(passiveName in BOOSTPASSIVES)
        return NORMALBOOST
    if(passiveName in NERFPASSIVES)
        return 0.75
    return 1

/mob/proc/getMajinRacials()
    . = list()
    switch(Class)
        if("Innocent")
            . += "DemonicDurability"
            . += "Blubber"
        if("Super")
            . += "Steady"
            . += "FluidForm"
        if("Unhinged")
            . += "UnhingedForm"
            . += "Adrenaline"
            . += "Hustle"
    var/newPickslist = list()
    if(length(majinPicks) > 0)
        for(var/pick in majinPicks)
            newPickslist = majinPicks["[pick]"]
    // make newpickslist into a list but split the string by a comma
    // so basically "Harness Evil,Brutality" becomes "Harness Evil" and "Brutality
    // then we can use the switch statement to add the passives
    newPickslist = splittext(newPickslist, ",")
    if(length(newPickslist)> 0)
        switch(newPickslist[1])
            if("Harness Evil")
                switch(newPickslist[2])
                    if("Brutality")
                        . += "Pursuer"
                        . += "UnhingedForm"
                    if("Both")
                        . += "Pursuer"
                        . += "UnhingedForm"
            if("Remain Consistent")
                switch(newPickslist[2])
                    if("Adaptability")
                        . += "Adaptation"
                        . += "Flicker"
                        . += "Huslte"
                        if(AscensionsAcquired > 2)
                            . += "StealsStats"
                    if("Consistency")
                        . += "Steady"
                        . += "DebuffResistance"
                        . += "StableBP"
                    if("Both")
                        . += "Steady"
                        . += "DebuffResistance"
                        . += "StableBP"
                        . += "Adaptation"
                        . += "Flicker"
                        . += "Huslte"
                        if(AscensionsAcquired > 2)
                            . += "StealsStats"
            if("Become Docile")
                switch(newPickslist[2])
                    if("Stability")
                        . += "VenomResistance"
                        . += "DebuffResistance"
                        . += "Juggernaut"
                    if("Peace")
                        . += "Flow"
                        . += "VoidField"
                    if("Both")
                        . += "VenomResistance"
                        . += "DebuffResistance"
                        . += "Juggernaut"
                        . += "Flow"
                        . += "VoidField"

proc/removeDuplicates(list/list1)
    var/list/newList = list()
    for(var/element in list1)
        if(element in newList)
            continue
        newList += element
    return newList



/mob/proc/getAllRacials()
    . = list()
    for(var/x in list("Majin", "Half Saiyan", "Saiyan", "Human", "Makyo", "Namekian", "Monster", "Shinjin", "Demon", "Celestial", "Angel", "Makaioshin", "Popo", "Beastkin", "Yokai", "Eldritch", "Dragon"))
        . += getRacialPassives(x)
    return .

/mob/proc/findAlteredVariables()
    for(var/x in getAllRacials())
        if(vars[x] > 0)
            src<<"You have an extra variable: [x], if you got this from absorb, you will need to get it removed and added back via an admin"
            // we could do it auto with a bit more digging, as a majin will have some of these passives, and they could have potentially absorbed more to have more than they already have
            if(passive_handler.Get(x))
                src << "You have an extra passive: [x], if you got this from absorb, you will need to get it removed and added back via an admin"

            for(var/mob/admin in world)
                if(admin.Admin)
                    admin << "[src] has an extra variable: [x], if they got this from absorb, you will need to get it removed and add it back"


/mob/proc/getRacialPassives(hardRace = FALSE)
    . = list()
    if(!hardRace)
        hardRace = race.type
    switch(hardRace)
        if(MAJIN)
            . = getMajinRacials()
        if(HALFSAIYAN)
            . += "Tenacity"
            . += "Brutalize"
            . += "Adrenaline"
        if(ELF)
            . += "Deicide"
            . += "TechniqueMastery"
            . += "Flow"
            . += "Unstoppable"
            . += "BladeFisting"
        if(SAIYAN)
            . += "Brutalize"
            if(Class=="Honor")
                . += "Honor"
                . += "Defiance"
                . += "Juggernaut"
            if(Class=="Pride")
                . += "Pride"
                . += "PureDamage"
            if(Class=="Zeal")
                . += "Zeal"
                . += "Adaptation"
        if(HUMAN)
            . += "Tenacity"
            . += "Adrenaline"
            . += "Innovation"
        if(MAKYO)
            . += "Juggernaut"
            . += "DemonicDurability"
            . += "HeavyHitter"
        if(NAMEKIAN)
            if(Class=="Dragon")
                . += "QuickCast"
                . += "ManaGeneration"
            if(Class=="Warrior")
                . += "Pursuer"
                . += "Tenacity"
                . += "TechniqueMastery"
        if(BEASTKIN)
            if(Class=="Heart of The Beastkin")
                . += "Grit"
            if(Class=="Unseen Predator")
                . += "Steady"
                . += "Brutalize"
            if(Class=="Monkey King")
                . += "Harden"
                . += "Instinct"
                . += "Nimbus"
            if(Class=="Undying Rage")
                . += "Fury"
                . += "Wrathful Tenacity"
            if(Class=="Feather Cowl")
                . += "Harden"
                . += "Pressure"
                . += "BladeFisting"
            if(Class=="Feather Knife")
                . += "Tossing"
                . += "Momentum"
                . += "BladeFisting"
            if(Class=="Fox Fire")
                . += "SoftStyle"
                . += "SoulFire"
            if(Class=="Spirit Walker")
                . += "Flow"
                . += "Instinct"
        if(YOKAI)
            . += "ManaGeneration"
            . += "Touch of Death"
        if(ELDRITCH)
            . += "Void"
            . += "VenomResistance"
            . += "SoulFire"
            . += "DeathField"
            . += "VoidField"
        if(DEMON)
            . += "CursedWounds"
            . += "AbyssMod"
            . += "SpaceWalk"
            . += "StaticWalk"
            . += "FakePeace"
            . += "MartialMagic"
        if(ELF)
            . += "Xenobiology"
            . += "Deicide"
            . += "TechniqueMastery"
        if(GAJALAKA)
            . += "CashCow"
            . += "Blubber"
        if(DRAGON)
            if(Class=="Water")
                . += "SoftStyle"
                . += "Fishman"
                . += "FluidForm"
            if(Class=="Fire")
                . += "DemonicDurability"
                . += "SpiritHand"
            if(Class=="Metal")
                . += "Harden"
                . += "KBRes"
            if(Class=="Gold")
                . += "Blubber"
                . += "CashCow"
        if(ANGEL)
            . += "SpiritPower"
            . += "HolyMod"
            . += "StaticWalk"
            . += "SpaceWalk"
            . += "MartialMagic"
            if(Class=="Mentor")
                . += "TechniqueMastery"
                . += "StyleMastery"
                . += "SpiritPower"
                . += "HolyMod"
                . += "StaticWalk"
                . += "SpaceWalk"
                . += "MartialMagic"
        if(CELESTIAL)
            . += "Tenacity"
            . += "Adrenaline"
        if(MAKAIOSHIN)
            . += "SpiritPower"
            . += "HellPower"
            . += "HolyMod"
            . += "AbyssMod"
            . += "StaticWalk"
            . += "SpaceWalk"
            . += "FakePeace"
            . += "MartialMagic"
            . += "BladeFisting"
        if(POPO)
            . += "ManaGeneration"
            . += "QuickCast"
            . += "CashCow"
            . += "TechniqueMastery"
            . += "StyleMastery"
            . += "Holding Back"
    . = removeDuplicates(.)


majinAbsorb/proc/doAbsorb(mob/absorber, mob/absorbee)
    updateVariables(absorber)
    if(length(absorbed) > 0)
        if(absorbed[absorbee.ckey] == absorbee.ckey)
            absorber << "You've already absorbed this person, absorb another person."
            return
    if(absorbCount >= absorbLimit)
        if(absorber.AscensionsAcquired==0 && absorber.Potential >= 10)
            var/ascension/next
            switch(absorber.AscensionsAcquired + 1)
                if(1) next = new /ascension/majin/one
            if(next)
                next.onAscension(absorber)
                absorber << "You've awakened to your next ascension through absorbing countless victims."
        if(absorber.AscensionsAcquired==1 && absorber.Potential >= 20)
            var/ascension/next
            switch(absorber.AscensionsAcquired + 1)
                if(2) next = new /ascension/majin/two
            if(next)
                next.onAscension(absorber)
                absorber << "You've awakened to your next ascension through absorbing countless victims."
        if(absorber.AscensionsAcquired==2 && absorber.Potential >= 45)
            var/ascension/next
            switch(absorber.AscensionsAcquired + 1)
                if(3) next = new /ascension/majin/three
            if(next)
                next.onAscension(absorber)
                absorber << "You've awakened to your next ascension through absorbing countless victims."
        else
            absorber << "You can't absorb any more passives, you've reached your limit."
        return
    var/list/racialPassives = absorbee.getRacialPassives()
    var/passiveInQuestion = input(absorber, "Which passive would you like to absorb?", "Absorb") in racialPassives
    var/maxGain
    var/maxPasssiveCanHave = absorbPassiveTickLimit * adjustPassive(passiveInQuestion, absorbee.race)

    var/absorbeePassiveTicks = absorbee.passive_handler.Get(passiveInQuestion)
    if(absorbeePassiveTicks > 0)
        maxGain = absorbeePassiveTicks
    else
        return // if they don't have the passive, we can't absorb it
    var/passiveticks = tickPerAbsorb
    passiveticks *= adjustPassive(passiveInQuestion, absorbee.race)
    var/existingPassive = absorber.passive_handler.Get(passiveInQuestion) ? absorber.passive_handler.Get(passiveInQuestion) : 0
    // now lets check how much the person absorbing can have
    if((existingPassive + passiveticks) >= maxPasssiveCanHave)
        passiveticks = maxPasssiveCanHave - existingPassive
    else
        if(existingPassive >= maxPasssiveCanHave)
            absorber << "You can not absorb any more of [passiveInQuestion]"
            return
        // make it the limit
    if(passiveticks > maxGain)
        passiveticks = maxGain
    if(existingPassive == maxGain)
        absorber << "You can not absorb any more of [passiveInQuestion]"
        return
    if((existingPassive + passiveticks) > maxGain)
        absorber << "You would exceed the passive limit, you can only absorb [maxGain] ticks of [passiveInQuestion]. Adjusting to [maxGain]"
        passiveticks = maxGain
        absorber.passive_handler.Set(passiveInQuestion, passiveticks)
    else
        if(passiveticks == 0)
            passiveticks = 0.5
        absorber.passive_handler.Increase("[passiveInQuestion]", passiveticks)
    absorber << "You have absorbed [passiveInQuestion] from [absorbee] making your total [absorber.passive_handler.Get(passiveInQuestion)]]!"
    absorbCount++
    passives[passiveInQuestion] = passiveticks
    absorber.HealHealth(15)
    absorber.HealEnergy(15)
    addAbsorbee(absorbee)
    nerfAbsorbee(absorbee)
/mob/proc/absorbSomebody(mob/target)
    var/errorCodes = list("ERROR: CODE ERROR", "TRIED TO USE CURRENT TARGET BUT THERE IS NONE", \
    "TARGET IS SELF", "TARGET IS NOT KNOCKED OUT", "THAT TARGET IS METAL")
    if(!target)
        // let's check if its a code error and they're targeting them
        . = errorCodes[1]
        target = src.Target
        if(!target)
            . = errorCodes[2]
            src << .
        src << . // let's tell them what happened
    if(target == src)
        . = errorCodes[3]
        src << .
    if(!target.KO)
        . = errorCodes[4]
        src<< .
        return
    if(target.isRace(ANDROID))
        . = errorCodes[5]
        src << .
        return
    if(target.client.address == src.client.address || target.client.computer_id == src.client.computer_id )
        if(!soIgnore && target.client.computer_id != src.client.computer_id)
            . = "ERROR: TARGET IS YOU"
            src << .
            return
    if(majinAbsorb)
        majinAbsorb.doAbsorb(src, target)
