/mob/var/list/acquiredSpellPassives=list();

/mob/proc/unlockSpellPassive(magic_node/mn)
    findOrAddSkill(/obj/Skills/Utility/Enchant_Spell);//give enchant spell obj if it doesn't already exist
    for(var/type in mn.grantsSpellPassives)
        var/spell_passive/sp = new type;
        acquiredSpellPassives |= sp;

/obj/Skills/Utility
    var/tmp/enchanting=0;
    Enchant_Spell
        verb/Enchant_Spell()
            set category="Utility"
            if(!usr.canEnchant(enchanting)) return;
            enchanting=1;
            usr.enchantSpellMain();
            enchanting=0;

        verb/Disenchant_Spell()//insert the mcr link here
            set category="Utility"
            if(!usr.canEnchant(enchanting)) return;
            enchanting=1;
            usr.disenchantSpellMain();
            enchanting=0;

/mob/proc/canEnchant(enchantMenuOpen=0)
    if(enchantMenuOpen) return 0;
    if(KO) return 0;
    return 1;

/mob/proc/enchantSpellMain()
    var/list/slots = getSpellSlots();
    if(!slots)
        src << "You don't have any available spells to enchant!"
        return;
    slots.Add("Nevermind");
    var/list/spellPass = getAvailableSpellPassives();
    if(!spellPass)
        src << "You don't have any available spell passives to invest!"
        return;
    spellPass.Add("Nevermind");

    var/obj/Skills/slot = input(src, "What spell slot do you want to enchant?", "Enchant Spell") in slots;
    if(slot=="Nevermind") return;

    var/currentPassives="";
    for(var/spell_passive/enchantedPassive in slot.SpellPassives)
        currentPassives += "[enchantedPassive.name]"
        if(!isLastItemInList(enchantedPassive, slot.SpellPassives)) currentPassives += ", ";

    var/spell_passive/sp = input(src, "What passive do you want to enchant into [slot]? It currently has the following passives:\n[currentPassives]", "Enchant Spell ([slot])") in spellPass;
    if(sp=="Nevermind") return;

    enchantSpellWithPassive(slot, sp);


/mob/proc/isValidEnchantment(obj/Skills/slot, spell_passive/sp)
    //if we want to put disqualifying mechanics, we can put them here
    return 1;

/mob/proc/enchantSpellWithPassive(obj/Skills/slot, spell_passive/sp)
    if(!isValidEnchantment()) return 0;
    slot.SpellPassives.Add(sp);
    sp.enchantedIn=slot;
    src << "You've enchanted [slot] with [sp], increasing its magickal power!";

/mob/proc/getAvailableSpellPassives(element = "All")
    var/list/r = list();
    for(var/spell_passive/sp in acquiredSpellPassives)
        if(sp.enchantedIn) continue
        if(spellPassiveMatchesElement(sp, element)) r |= sp;
    return r.len > 0 ? r : 0;

/proc/spellPassiveMatchesElement(spell_passive/sp, element)
    if(element=="All") return 1;
    if(sp.spellElement == element) return 1;
    return 0;

/mob/proc/disenchantSpellMain()
    var/list/slots = getSpellSlotsWithPassives();
    if(!slots)
        src << "You don't have any available spells to disenchant!"
        return;
    slots.Add("Nevermind");
    
    var/obj/Skills/slot = input(src, "What spell slot do you want to disenchant?", "Disenchant Spell") in slots;
    if(slot=="Nevermind") return;

    var/list/choices = list("All") + slot.SpellPassives;
    choices.Add("Nevermind")
    var/spell_passive/choice = input(src, "What spell passive do you want to disenchant from [slot]?", "Disenchant Spell") in choices;
    if(choice=="Nevermind") return;
    if(choice=="All")
        for(var/spell_passive/sp in slot.SpellPassives)
            disenchantSpellWithPassive(slot, sp);
    else disenchantSpellWithPassive(slot, choice);

/mob/proc/disenchantSpellWithPassive(obj/Skills/slot, spell_passive/sp)
    slot.SpellPassives.Remove(sp);
    sp.enchantedIn=0;
    src << "You've dischanted [slot] with [sp], decreasing its magickal resonance...";

/spell_passive
    var/obj/Skills/enchantedIn;//what skill is it stuck in?
    var/name
    var/flavor
    var/desc
    var/spellElement;//determines what kind of spells can be enchanted with this passive (unless you break the rules)
    var/list/passives=list();
    var/list/autohitOnlyPassives=list();
    var/list/projectileOnlyPassives=list();
    var/list/buffOnlyPassives=list();
    var/list/knowledgeTypes=list();//what enchantment items does it unlock?
    New()
        ..();
        desc = "[name]\n[flavor]\nGrants the following passives to a Spell when applied to it: \n"
        var/list/allPassives = passives+autohitOnlyPassives+projectileOnlyPassives+buffOnlyPassives;
        for(var/p in allPassives)
            desc += "[p]";
            if(p in autohitOnlyPassives) desc += "(Autohit Only)"
            if(p in projectileOnlyPassives) desc += "(Projectile Only)"
            if(p in buffOnlyPassives) desc += "(De/Buff Only)"
            if(p != allPassives[allPassives.len]) desc += "\n";

    water
        spellElement="Water"
        barotrauma//drowning
            name="Barotrauma"
        overflow//flooding
            name="Overflow"
        flashfreeze
            name="Flashfreeze"
        sublimate
            name="Sublimate"
        
    fire
        spellElement="Fire"
        blaze//fire
            name="Blaze"
        magma
            name="Magma"
        ash
            name="Ash"
        nuclear
            name="Nuclear"
    air
        spellElement="Air"
        galeforce
            name="Gale Force"
        cuttingpressure
            name="Cutting Pressure"
        fogcloud
            name="Fog Cloud"
        rapidity
            name="Rapidity"
        
    earth
        spellElement="Earth"
        crystallize
            name="Crystallize"
        hewnearth
            name="Hewn Earth"
        blinddust
            name="Blind Dust"
        tectonicquake
            name="Tectonic Quake"

    light
        spellElement="Light"
        sanctified
            name="Sanctify"
        farsight
            name="Far Sight"
        mirrored
            name="Mirrored"
        cauterizing
            name="Cauterizing"

    time
        spellElement="Time"
        paradox
            name="Paradox"
        echo
            name="Echo"
        stasis
            name="Stasis"
        passage
            name="Passage"
    dark
        spellElement="Dark"
        disaster//primordial
            name="Disaster"
        ravenous//cost hp, refund hp if hit
            name="Ravenous"
        Vampyric
            name="Vampyric"
        Hemomantic//more like homo amirite
            name="Hemomantic"

    space
        spellElement="Space"
        nebula
            name="Nebula"
        supernova//gets blink
            name="Supernova"
        quasar
            name="Quasar"
        constellation
            name="Constellation"
