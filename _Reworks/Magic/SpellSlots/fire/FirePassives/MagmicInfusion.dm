/obj/Skills/var
    MagmicInfusion=0;//this will TRIGGER magmic buff 

/obj/Skills/proc/hasMagmicInfusion(mob/p)
    if(MagmicInfusion) p.MagmicShieldOn();

/mob/proc/hasMagmicShield()
    if(passive_handler.Get("Magmic")) return 1;
    return 0;
/mob/proc/MagmicShieldOn()
    var/obj/Skills/Buffs/magShield = findOrAddSkill(/obj/Skills/Buffs/SlotlessBuffs/Magmic_Shield);
    if(!magShield.Using && !SlotlessBuffs["[magShield.name]"]) magShield.Trigger(src, 1);
/mob/proc/MagmicShieldOff()
    var/obj/Skills/Buffs/magShield = findOrAddSkill(/obj/Skills/Buffs/SlotlessBuffs/Magmic_Shield);
    if(magShield.Using && SlotlessBuffs["[magShield.name]"]) magShield.Trigger(src, 1);

/obj/Skills/Buffs/SlotlessBuffs/Magmic_Shield
    passives = list("Magmic" = 1)//this stuns the opponent for 3 seconds when they are struck
    Cooldown = 60
    TimerLimit = 30
    BuffName = "Magmic Shield"
    name = "Magmic Shield"
    ActiveMessage = "conjures a magmic shield!"
    OffMessage = "extinguishes the shield..."
    TextColor="#cc3333";
    IconLock = 'Magmic Shield.dmi';
    
    //no active trigger anymore