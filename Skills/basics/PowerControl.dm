/mob/proc/canPC(goingUp=0)
    if(KO) return 0;
    if(hasHeavenlyPURestriction()) return 0;
    //PoweringDown does not take time so it is fine to remove its check
    if(passive_handler.Get("Piloting")) return 0;
    if(CheckSlotless("Great Ape"))
        if(goingUp) CanTransform()
        return 0;
    if(goingUp)
        if(CheckActive("Ki Control") && !canMangPU()) return 0;
    return 1;

/mob/proc/canDoATransform()
    if(!canPC()) return 0;//doesn't check for ki control
    if(isRace(HUMAN)) return 0;//humans do not transform like this!
    if(ChangelingTransformRequirements()) return 1;//changelings transform weird
    if(StandardTransformRequirements()) return 1;
    return 0;

/mob/proc/StandardTransformRequirements()
    if(ActiveBuff || icon_state=="Train")
        if(transActive() < transUnlocked)
            return 1;
    return 0;
/mob/proc/ChangelingTransformRequirements()
    if(isRace(CHANGELING))
        if(CheckSpecial("One Hundred Percent Power") || CheckSpecial("Fifth Form"))
            if(transUnlocked < 4)
                if(transActive() < transUnlocked)
                    return 1;
    return 0;



mob/proc/PowerUp() // Handles Normal (read: Not Kaioken/Shin) power up related code
    if(canDoATransform())
        Transform();
        return;
    if(!canPC(goingUp=1)) return 0;
    if(hasSecret("Shin") && ActiveBuff && canMangPU())
        if(!KO) MangPowerUp()
        return
    if(passive_handler.Get("Kaioken"))
        if(!KO) KaiokenPowerUp()
        return
    if(HasPULock()) return
    if(!PoweringUp)
        PoweringUp=1
        if(PowerControl>=100)
            if(Saga=="Cosmo")
                OMsg(src, "[src] ignites their Cosmo!!")
            else if(custom_powerup)
                if(customPUnameInclude)
                    OMsg(src, "[src] [src.custom_powerup]")
                else
                    OMsg(src, "[src.custom_powerup]")
            else
                OMsg(src, "[src] begins gathering power!!")
            Auraz("Add")
        else
            PowerControl=100
            src << "You return to normal power."
            PoweringUp=0

// Handles Normal Power Down related code
mob/proc/PowerDown()
    if(!canPC()) return;
    if(passive_handler.Get("Kaioken"))
        KaiokenPowerDown() // This Proc is at line 156
        return
    if(Secret == "Shin" && usingMangBuff())
        MangPowerDown() // This proc is at line 202
        if(GetMangLevel()==0)
            MangToShin()
        return
    if(HasPULock())
        return
    if(PoweringUp)
        PoweringUp=0
        src << "You stop powering up."
        Auraz("Remove")
        return
    else
        if(CheckActive("Ki Control"))
            for(var/obj/Skills/Buffs/ActiveBuffs/Ki_Control/KC in src)
                UseBuff(KC)
                return
        if(CheckSpecial("One Hundred Percent Power"))
            for(var/obj/Skills/Buffs/SpecialBuffs/OneHundredPercentPower/FF in src)
                UseBuff(FF)
                return
        if(CheckSpecial("Fifth Form"))
            for(var/obj/Skills/Buffs/SpecialBuffs/FifthForm/FF in src)
                UseBuff(FF)
                return
        if(HasKiControl() && src.PowerControl > 100)
            PowerControl=100
            Auraz("Remove")
            src << "You return to normal power."
            return
        if(transActive&&!HasNoRevert()&&!isMazokuHuman())
            for(var/obj/Skills/Buffs/B in src)
                if(BuffOn(B)&&B.Transform&&!B.AlwaysOn)
                    B.Trigger(src)
                    return
            Revert()
            src << "You revert from your transformed state."
            return
        else
            if(PowerControl!=1)
                PowerControl=1
                src << "You restrain your power..."
                Auraz("Remove")
                return

// Handles Kaioken Power Up related code
mob/proc/KaiokenPowerUp()
    if(src.passive_handler.Get("Kaioken"))
        var/Mastery
        for(var/obj/Skills/Buffs/SpecialBuffs/Kaioken/KK in src)
            Mastery=KK.Mastery
        if(src.Kaioken<2+Mastery)
            if(src.passive_handler.Get("Super Kaioken"))
                switch(src.Kaioken)
                    if(0)
                        src.Kaioken=1
                        src <<"<b>Super Kaioken!</b>"
                    if(1)
                        src.Kaioken=2
                        src <<"<b>Super Kaioken Times Three!</b>"
                    if(2)
                        src.Kaioken=3
                        src <<"<b>Super Kaioken Times Four!</b>"
                    if(3)
                        src.Kaioken=4
                        src <<"<b>Super Kaioken Times Ten!</b>"
                    if(4)
                        src.Kaioken=5
                        src <<"<b>Super Kaioken Times Twenty!</b>"
                    if(5)
                        if(src.passive_handler.Get("Kaioken Blue"))
                            src.Kaioken=6
                            src <<"<b>Maximum Kaioken Blue!!!!!!</b>"
                        else
                            src << "You're at your maximum level of Kaioken."
                    if(6)
                        src<<"You cannot push your power any further."

            else
                switch(src.Kaioken)
                    if(0)
                        src.Kaioken=1
                        src <<"<b>Kaioken!</b>"
                    if(1)
                        src.Kaioken=2
                        src <<"<b>Kaioken Times Three!</b>"
                    if(2)
                        src.Kaioken=3
                        src <<"<b>Kaioken Times Four!</b>"
                    if(3)
                        src.Kaioken=4
                        src <<"<b>Kaioken Times Ten!</b>"
                    if(4)
                        src.Kaioken=5
                        src <<"<b>Kaioken Times Twenty!</b>"
                    if(5)
                        src << "You're at your maximum level of Kaioken."
        else
            src << "You don't have enough mastery of Kaioken to push it further."

// Handles Kaioken Power Down related code
mob/proc/KaiokenPowerDown()
    if(src.passive_handler.Get("Kaioken"))
        switch(src.Kaioken)
            if(1)
                src.Kaioken=0
                src <<"<b>You fully relax your Kaioken!</b>"
            if(2)
                src.Kaioken=1
                src <<"<b>You relax your Kaioken to its minimum!</b>"
            if(3)
                src.Kaioken=2
                src <<"<b>You relax your Kaioken to three times!</b>"
            if(4)
                src.Kaioken=3
                src <<"<b>You relax your Kaioken to four times!</b>"
            if(5)
                src.Kaioken=4
                src << "<b>You relax your Kaioken to ten times!</b>"
            if(6)
                src.Kaioken=5
                src << "<b>You relax your Kaioken to twenty times!</b>"
        return
    /*src << "You douse your Kaioken..."
    src.SpecialBuff.Trigger(src)
    sleep()
    if(src.CheckActive("Ki Control"))
        for(var/obj/Skills/Buffs/ActiveBuffs/Ki_Control/KC in src)
            src.UseBuff(KC)
    return*/


// Handles Mang Power Up related code
mob/proc/MangPowerUp()
    if(!ShinActive() && !MangActive()) return //if neither shin nor mang is active, why are you doing here?...
    if(MangManaCost())//minor refactor for the sake of Mang Messages
        if(ShinActive())//if Shin is active
            ShinToMang();//change to mang mode
        else if(MangActive())//BUT, if mang is active
            if(GetMangMastery() >= GetMangLevel()+1)//check for mastery
                AddMangLevel();//increase if mastery allows


// Handles Mang Power Down related code
mob/proc/MangPowerDown()
    if(!GetMangLevel()) // Checks what level your mang is at.
        src <<"<b>You have not manifested any Mang!</b>"
    if(MangActive()) // Reduces your active mang level
        ReduceMangLevel()
    if(!GetMangLevel()) // Turns Mang off if it hits 0?
        MangToShin();



