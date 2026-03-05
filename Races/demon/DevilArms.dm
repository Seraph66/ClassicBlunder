/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2
    passives = list()
    SignatureTechnique=3
    Mastery=0
    Copyable=0
    MakesSword=0
    FlashDraw=1
    SwordName="Demon Blade"
    SwordIcon='SwordBroad.dmi'
    StaffName="Demon Rod"
    StaffIcon='MageStaff.dmi'
    ArmorName="Demon Scales"
    ArmorIcon='DevilScale.dmi'
    TextColor="#adf0ff"
    ActiveMessage=null
    OffMessage=null
    var/secondDevilArmPick
    var/selection
    var/totalEvolvesMain = 0
    var/totalEvolvesSecondary = 0
    var/tmp/evolving=0;
    name = "Devil Arm"
    verb/Examine_Devil_Arm()
        set src in usr
        var/devilArmDetail = "<html><head><title>Devil Arm Detail ([src.name])</title></head>"
        devilArmDetail += "<body bgcolor=black text=white><table cellspacing=6%>"
        for(var/p in src.passives)
            devilArmDetail += "<tr><td><b>[p]</b></td><td>[src.passives[p]]</td></tr>"
        devilArmDetail += "<tr><td>Main Passives Used: </td><td>[src.totalEvolvesMain]</td></tr>"
        if(usr.isRace(DEMON) || usr.isRace(MAKAIOSHIN))
            devilArmDetail += "<tr><td>Side Passives Used: </td><td>[src.totalEvolvesSecondary]</td></tr>"
        devilArmDetail += "</table></body></html>"
        usr << browse(devilArmDetail, "window=DevilArm;size=350x500");

    verb/Customize_Devil_Arm()
        var/options = list("Icon", "Name","ActiveMessage", "OffMessage","TextColor")
        var/thing = input(usr, "What do you want to customize?") in options
        if(thing == "Icon")
            var/selection = input(usr, "Sword, Staff, or Armor Icon?") in list("Sword","Armor","Staff")
            vars["[selection][thing]"] = input(usr, "Change to what?") as icon | null
            vars["[selection]X"] = input(usr, "What is the pixel X?") as num
            vars["[selection]Y"] = input(usr, "What is the pixel y?") as num
        else if("Name")
            vars["[selection][thing]"] = input(usr, "Change to what?") as text
        else
            vars["[thing]"] = input(usr, "Change to what?") as message

    proc/checkEvolve(mob/p)
        if(totalEvolvesMain < p.race?:devil_arm_upgrades)
            return TRUE
        if(totalEvolvesSecondary < p.race?:sub_devil_arm_upgrades)
            return TRUE
        return FALSE
    adjust(mob/p)
        if(passives["CriticalChance"]>30)
            passives["CriticalChance"]=30
            passives["CriticalDamage"]=0.15
        if(passives["BlockChance"]>30)
            passives["BlockChance"]=30
            passives["CriticalBlock"]=0.15
        switch(selection)
            if("Sword")
                passives["SwordAscension"] = p.AscensionsAcquired + 1
            if("Staff")
                passives["StaffAscension"] = p.AscensionsAcquired + 1
            if("Unarmed")
                passives["UnarmedDamage"] = p.AscensionsAcquired + 1
        switch(secondDevilArmPick)
            if("Armor")
                passives["ArmorAscension"] = p.AscensionsAcquired + 1
            if("Sword")
                passives["SwordAscension"] = p.AscensionsAcquired + 1
            if("Staff")
                passives["StaffAscension"] = p.AscensionsAcquired + 1
            if("Unarmed")
                passives["UnarmedDamage"] = p.AscensionsAcquired + 1
        ElementalOffense = "HellFire"
    verb/Devil_Arm()
        set category = "Skills"
        if(!usr.BuffOn(src) && checkEvolve(usr) )
            if(usr.isRace(DEMON) || usr.isRace(MAKAIOSHIN))
                evolve(usr)
                usr << "Activate again after."
                return
        if(!selection)
            pickSelection(usr)
        if(!usr.BuffOn(src))
            adjust(usr)
        src.Trigger(usr)

    proc/checkPassiveAmt(list/theList, input)
        if(passives["[input]"])
            if(passives["[input]"] + theList[input][1] > theList[input][2])
                return FALSE
        return TRUE;
    proc/handlePassive(list/theList, input)
        . = TRUE

        if(checkPassiveAmt(theList, input))
            switch(input)
                if("CriticalChance")
                    passives["[input]"] += theList[input][1]
                    passives["CriticalDamage"] += 0.05
                    return
                if("BlockChance")
                    passives["[input]"] += theList[input][1]
                    passives["CriticalBlock"] += 0.05
                    return
            passives["[input]"] += theList[input][1]
        else
            passives["[input]"] = theList[input][1]


    proc/pickSelection(mob/p, secondary = FALSE)
        var/select
        if(secondary)
            var/list/choices = list("Staff", "Sword", "Unarmed","Armor");
            choices.Remove(selection);
            secondDevilArmPick = input(p, "What thing?") in choices;
            select = secondDevilArmPick;
        else
            selection = input(p, "What thing?") in list("Staff", "Sword", "Unarmed")
            select = selection
        if(select != "Unarmed")
            vars["Makes[select]"] = 1
        var/class
        vars["[select]Name"] = input(p, "Change name to what?") as text
        if(select != "Unarmed")
            if(select == "Staff")
                class = input(p, "What thing?") in list("Wand", "Rod", "Staff")
            else
                class = input(p, "What thing?") in list("Light", "Medium", "Heavy")
            vars["[select]Class"] = class
            var/i = input(p, "Set appearance to what?") as icon | null
            if(i)
                vars["[select]Icon"] = i;
                vars["[select]X"] = input(p, "What is the pixel X?") as num
                vars["[select]Y"] = input(p, "What is the pixel y?") as num
    proc/pickPassive(mob/p, list/choices, list/mainData, secondary = FALSE)
        var/correct = FALSE
        var/attempts = 0
        for(var/d in choices)//hopefully remove passives before they fail
            if(!checkPassiveAmt(mainData, d)) choices.Remove(d);
        while(correct == FALSE)
            var/passive = input(p, "What passive?  [secondary == FALSE ? "Main Branch - [selection] \n([totalEvolvesMain] / [p.race?:devil_arm_upgrades] passives picked)" : "Side Branch - [secondDevilArmPick] \n([totalEvolvesSecondary] / [p.race?:sub_devil_arm_upgrades] passives picked)"]") in choices
            if(attempts >=3)
                p << "You tried too many times, alert an admin"
                break
            if(!handlePassive(mainData, passive))
                p << "Too much passive value"
                choices -= passive
                correct = FALSE // have them go again
            else
                correct = TRUE
            attempts++

    proc/evolve(mob/p)
        if(evolving) return
        evolving=1;
        if(!selection)
            pickSelection(p, FALSE)
        if(!secondDevilArmPick && p.Potential >= ASCENSION_TWO_POTENTIAL)
            pickSelection(p, TRUE);
            p.checkDevilArmUpgrades();
        if(!p.BuffOn(src))
            if(totalEvolvesMain < p.race?:devil_arm_upgrades)
                p << "Evolving Main Branch for the [totalEvolvesMain+1]\th step..."
                var/list/data = getJSONInfo(getPassiveTier(p, totalEvolvesMain), "GENERIC_PASSIVES")
                data.Add(getJSONInfo(getPassiveTier(p, totalEvolvesMain), "[uppertext(selection)]_PASSIVES"))
                var/list/choices = list()
                for(var/a in data)
                    choices += "[a]"
                if(choices.len < 1)
                    evolving=0;
                    p << "The list of passives could not generate for your Main Branch ([selection])"
                    return;
                pickPassive(p, choices, data, FALSE)
                totalEvolvesMain++
            if(secondDevilArmPick && totalEvolvesSecondary < p.race?:sub_devil_arm_upgrades)
                p << "Evolving Side Branch for the [totalEvolvesSecondary+1]\th step..."
                var/list/secondaryData
                secondaryData = getJSONInfo(getPassiveTier(p, totalEvolvesSecondary, TRUE), "[uppertext(secondDevilArmPick)]_PASSIVES")
                var/list/secondChoices = list()
                for(var/a in secondaryData)
                    secondChoices += "[a]"
                if(secondChoices.len < 1)
                    evolving=0;
                    p << "The list of passives could not generate for your Side Branch ([secondDevilArmPick])"
                    return;
                pickPassive(p, secondChoices, secondaryData, TRUE)
                totalEvolvesSecondary++
        evolving=0;

/mob/proc/checkDevilArmUpgrades()
    var/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2/da = FindSkill(/obj/Skills/Buffs/SlotlessBuffs/Devil_Arm2)
    var/max = round(Potential / 5) + 1
    var/max2 = round(Potential / 10) + 1
    if(race?:devil_arm_upgrades < max)
        if(race?:devil_arm_upgrades + 1 > max) // not even possible
            return
        race?:devil_arm_upgrades = max
        src << "Your devil arm evolves, toggle it on and off to use it"
    if(da.secondDevilArmPick)
        if(race?:sub_devil_arm_upgrades < max2)
            if(race?:sub_devil_arm_upgrades + 1 > max2)
                return
            race?:sub_devil_arm_upgrades = max2
            src << "Your secondary devil arm evolves, toggle it on and off to use it"