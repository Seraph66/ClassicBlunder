/spell_passive
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
