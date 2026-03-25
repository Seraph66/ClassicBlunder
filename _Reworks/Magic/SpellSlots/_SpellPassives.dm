/spell_passive
    var/spellElement;//determines what kind of spells can be enchanted with this passive (unless you break the rules)
    var/list/passives=list();
    var/list/autohitOnlyPassives=list();
    var/list/projectileOnlyPassives=list();
    var/list/buffOnlyPassives=list();
    var/list/knowledgeTypes=list();//what enchantment items does it unlock?
    water
        spellElement="Water"
    fire
        spellElement="Fire"
    air
        spellElement="Air"
    earth
        spellElement="Earth"
    light
        spellElement="Light"
    time
        spellElement="Time"
    dark
        spellElement="Dark"
    space
        spellElement="Space"
