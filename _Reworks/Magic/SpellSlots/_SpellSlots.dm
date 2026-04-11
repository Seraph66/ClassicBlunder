/obj/Skills/var
    SpellElement;//tracks what element a spell belongs to and therefore what kinds of passives can be invested into it (unless you break the rules)
    SpellSlot=0;//hands down the worst way to do this, but unfortunately, we don't use inheritance well for our skills system so it's just gonna have to work
    list/SpellPassives=list();//contains a list of spell passives that are influencing this spell

/mob/proc/unlockSpellSlot(magic_node/mn)
    for(var/t in mn.grantsSkills)
        findOrAddSkill(t);

/mob/proc/getSpellSlots()
    var/list/slots = list()
    for(var/obj/Skills/s in src)
        if(s.SpellSlot) slots |= s;
    return slots.len > 0 ? slots : 0;
/mob/proc/getSpellSlotsWithPassives()
    var/list/slots = list();
    for(var/obj/Skills/s in src)
        if(s.SpellSlot)
            if(s.SpellPassives.len > 0)
                slots |= s;
    return slots.len > 0 ? slots : 0;

var/list/allSpellPassives=list();
/proc/getAllSpellPassives()
    for(var/type in typesof(/spell_passive))
        var/spell_passive/sp = new type;
        allSpellPassives |= sp.passives;
        allSpellPassives |= sp.autohitOnlyPassives;
        allSpellPassives |= sp.projectileOnlyPassives;
        allSpellPassives |= sp.buffOnlyPassives;

#define SET_EXCEPTIONS list("StrOffense", "ForOffense", "StrRate", "ForRate")//these variables are set rather than added
#define MULT_EXCEPTIONS list("DamageMult")//list of variables that are not added to the spell, and instead are multiplied
/obj/Skills/proc/SpellSlotModification()
    if(!SpellSlot) return;
    for(var/spell_passive/sp in SpellPassives)//this loops through the bundle of passives
        for(var/pass in sp.passives)
            if(pass in MULT_EXCEPTIONS)
                vars["[pass]"] = initial(vars["[pass]"]) * sp.passives["[pass]"];
            if(pass in SET_EXCEPTIONS)
                vars["[pass]"] = sp.passives["[pass]"];
            vars["[pass]"] = initial(vars["[pass]"]) + sp.passives["[pass]"];
        for(var/autoPass in sp.autohitOnlyPassives)
            if(autoPass in MULT_EXCEPTIONS)
                vars["[autoPass]"] = initial(vars["[autoPass]"]) * sp.autohitOnlyPassives["[autoPass]"];
            if(autoPass in SET_EXCEPTIONS)
                vars["[autoPass]"] = sp.autohitOnlyPassives["[autoPass]"];
            else
                vars["[autoPass]"] = initial(vars["[autoPass]"]) + sp.autohitOnlyPassives["[autoPass]"];
        for(var/projPass in sp.projectileOnlyPassives)
            if(projPass in MULT_EXCEPTIONS)
                vars["[projPass]"] = initial(vars["[projPass]"]) * sp.projectileOnlyPassives["[projPass]"];
            if(projPass in SET_EXCEPTIONS)
                vars["[projPass]"] = sp.projectileOnlyPassives["[projPass]"];
            else
                vars["[projPass]"] = initial(vars["[projPass]"]) + sp.projectileOnlyPassives["[projPass]"];
        for(var/buffPass in sp.buffOnlyPassives)
            if(buffPass in MULT_EXCEPTIONS)
                vars["[buffPass]"] = initial(vars["[buffPass]"]) * sp.projectileOnlyPassives["[buffPass]"];
            if(buffPass in SET_EXCEPTIONS)
                vars["[buffPass]"] = sp.projectileOnlyPassives["[buffPass]"];
            else
                vars["[buffPass]"] = initial(vars["[buffPass]"]) + sp.projectileOnlyPassives["[buffPass]"];
        

    

/mob/verb/find_spell_slots()
    set category="Debug"
    set name = "DEBUG: Find Spell Slots"
    var/list/slots = getSpellSlots()
    if(!slots)
        src << "no slots"
        return;
    for(var/x in slots)
        src << "slot found: [x]";