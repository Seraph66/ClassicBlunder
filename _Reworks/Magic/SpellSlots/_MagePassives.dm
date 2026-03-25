/mage_passive//really, this barely needs to be an object, since it is just going to flag passives on the user... but it will be convenient
    //to have a datum so that they can be refunded and updated if needed
    var/list/passives=list();
    var/list/knowledgeTypes=list();//what enchantment items does it unlock?