globalTracker/var/
    list/WaterTreeNodes=list();
    list/FireTreeNodes=list();
    list/AirTreeNodes=list();
    list/EarthTreeNodes=list();
    list/LightTreeNodes=list();
    list/TimeTreeNodes=list();
    list/DarkTreeNodes=list();
    list/SpaceTreeNodes=list();

/proc/initMagicNodes()
    initWaterTree();
    initFireTree();
    initAirTree();
    initEarthTree();
    initLightTree();
    initTimeTree();
    initDarkTree();
    initSpaceTree();
/proc/clearMagicNodes()
    glob.WaterTreeNodes=list();//resetti the spaghetti
    glob.FireTreeNodes=list();
    glob.AirTreeNodes=list();
    glob.EarthTreeNodes=list();
    glob.LightTreeNodes=list();
    glob.TimeTreeNodes=list();
    glob.DarkTreeNodes=list();
    glob.SpaceTreeNodes=list();
/proc/
    initWaterTree()
        for(var/t in subtypesof(/magic_node/water_tree))
            var/magic_node/mn = new t;
            glob.WaterTreeNodes[mn.name] = mn;
    initFireTree()
        for(var/t in subtypesof(/magic_node/fire_tree))
            var/magic_node/mn = new t;
            glob.FireTreeNodes[mn.name] = mn;
    initAirTree()
        for(var/t in subtypesof(/magic_node/air_tree))
            var/magic_node/mn = new t;
            glob.AirTreeNodes[mn.name] = mn;
    initEarthTree()
        for(var/t in subtypesof(/magic_node/earth_tree))
            var/magic_node/mn = new t;
            glob.EarthTreeNodes[mn.name] = mn;
    initLightTree()
        for(var/t in subtypesof(/magic_node/light_tree))
            var/magic_node/mn = new t;
            glob.LightTreeNodes[mn.name] = mn;
    initTimeTree()
        for(var/t in subtypesof(/magic_node/time_tree))
            var/magic_node/mn = new t;
            glob.TimeTreeNodes[mn.name] = mn;
    initDarkTree()
        for(var/t in subtypesof(/magic_node/dark_tree))
            var/magic_node/mn = new t;
            glob.DarkTreeNodes[mn.name] = mn;
    initSpaceTree()
        for(var/t in subtypesof(/magic_node/space_tree))
            var/magic_node/mn = new t;
            glob.SpaceTreeNodes[mn.name] = mn;

/mob/proc/initPersonalMagicTrees()
    initWaterTreeButtons();
    initFireTreeButtons();
    initAirTreeButtons();
    initEarthTreeButtons();
    initLightTreeButtons();
    initTimeTreeButtons();
    initDarkTreeButtons();
    initSpaceTreeButtons();
    hideRevealedButtons();

/mob/proc
    initWaterTreeButtons()
        loadButtons(glob.WaterTreeNodes);
    initFireTreeButtons()
        loadButtons(glob.FireTreeNodes);
    initAirTreeButtons()
        loadButtons(glob.AirTreeNodes);
    initEarthTreeButtons()
        loadButtons(glob.EarthTreeNodes);
    initLightTreeButtons()
        loadButtons(glob.LightTreeNodes);
    initTimeTreeButtons()
        loadButtons(glob.TimeTreeNodes);
    initDarkTreeButtons()
        loadButtons(glob.DarkTreeNodes);
    initSpaceTreeButtons()
        loadButtons(glob.SpaceTreeNodes);

/magic_node/var
    name = "Magic Node";
    xLoc;
    yLoc;
    lockedNodeImage;
    unlockedNodeImage;
    command;
    nodeType;//aoe, autohit, buff, debuff, line, projectile; mage, crown, spell
    list/unlocksNodes=list();
    list/grantsSkills=list();
    list/grantsPassives=list();
    list/grantsKnowledges=list();

/magic_node/
    New()
        ..()
        setNodeImages();

    proc/getTreeAOEImage()
    proc/getTreeAutohitImage()
    proc/getTreeBuffImage()
    proc/getTreeDebuffImage()
    proc/getTreeLineImage()
    proc/getTreeMagePassiveImage()
    proc/getTreePinnacleImage()
    proc/getTreeProjectileImage()
    proc/getTreeSpellPassiveImage()
    
    proc/setNodeImages()
        switch(nodeType)
            if("AOE")
                lockedNodeImage=LOCKED_AOE;
                unlockedNodeImage=getTreeAOEImage();
            if("Autohit")
                lockedNodeImage=LOCKED_AUTOHIT;
                unlockedNodeImage=getTreeAutohitImage();
            if("Buff")
                lockedNodeImage=LOCKED_BUFF;
                unlockedNodeImage=getTreeBuffImage();
            if("Debuff")
                lockedNodeImage=LOCKED_DEBUFF;
                unlockedNodeImage=getTreeDebuffImage();
            if("Line")
                lockedNodeImage=LOCKED_LINE;
                unlockedNodeImage=getTreeLineImage();
            if("Mage Passive")
                lockedNodeImage=LOCKED_MAGEP;
                unlockedNodeImage=getTreeMagePassiveImage();
            if("Pinnacle")
                lockedNodeImage=LOCKED_PINNACLE;
                unlockedNodeImage=getTreePinnacleImage();
            if("Projectile")
                lockedNodeImage=LOCKED_PROJ;
                unlockedNodeImage=getTreeProjectileImage();
            if("Spell Passive")
                lockedNodeImage=LOCKED_SPELLP;
                unlockedNodeImage=getTreeSpellPassiveImage();

/mob/var/
    list/magicKnowledge=list();
    list/accessedMagicTrees=list();
    list/acquiredMagicNodes=list();

globalTracker/var
    MagicNodeRPPCost=20;
    SecondElementPotential=20;
    AdvancedElementPotential=40;

/mob/proc/
    unlockMagicNode(node as text)
        set name=".unlockMagicNode"
        set hidden = 1;
        if(!node in VALID_MAGIC_NODES) return;

/mob/proc/canUnlockMagicTree(element)
    if(!(element in VALID_MAGIC_ELEMENTS))
        alert(src, "Uhm? Somehow, you've tried to unlock an element that doesn't exist in the valid element list...", "ERROR", "OK");
        return; //if this isn't a real element
    if((element in ADVANCED_MAGIC_ELEMENTS) && !canObtainAdvancedElements())
        alert(src, "[element] is an Advanced element; you have to be over [glob.AdvancedElementPotential] Potential and have invested a T3 into Mage Status to unlock it!", "ERROR", "OK");
        return;
    if(element in accessedMagicTrees && HyperInvestmentCriteraNotMet(element))
        alert(src, "[element]-type Magic has already been unlocked for you, and you don't yet match the criteria for hyper investment...", "ERROR", "OK");
        return; //if this has already been unlocked
    return 1;

/mob/proc/canObtainAdvancedElements()
    if(hasEarlyMagicAdvancement()) return 1;
    if(Potential >= glob.AdvancedElementPotential) return 1;
    return 0;

/mob/proc/hasEarlyMagicAdvancement()
    if(hasSecret("Eldritch (Reflected)")) return 1;
    return 0;

/mob/proc/getMagicalDeficiency()
    . = 0
    //if any one or any thing is supposed to be bad at magic, accumulate a negative value here
    if(. > 0) . *= (-1)//and if you forget, and make it a positive value, this will flip it around to negative
    . = clamp(., -999, 0);

/mob/proc/AnnounceNextUnlockCriteria()
    switch(accessedMagicTrees.len + getMagicalDeficiency())
        if(0)
            alert("You don't have any existing arcane knowledge to skew your perception. You can freely unlock another branch of magic!");
        if(1)
            alert("You must fully understand your first branch of arcane knowledge before diluting it with another path, and even then, it may take some time to learn new elemental principles. (Master your first Tree and then attempt to learn after potential [glob.SecondElementPotential])");
        if(2)
            alert("You've mastered all the magic you can without dedicating yourself as a mage (Investment of a T3).  Are you sure you want to give up other avenues of power?");
        if(3)
            alert("In order to achieve greater magical mastery, you'll have to access knowledge beyond the normal progression of a mage (Investment of a T4). Are you sure you want to dedicate that level of training?");
        if(4)
            alert("You've reached the peak of magical mastery! ... There's nothing beyond this point, you've learned all you can! ... Right?")
            return 0;
        else
            alert("You're too far beyond the natural laws of magic. It'd take an act of ᛜⳘᚾᛊᚱ ᛁᚢᚾᛊᚱꓦᛊᚢᚾᛁᛜᚢ to keep increasing your magical knowledge...");
            return 0;
    return 1;

/mob/proc/unlockTreeChoice(element)
    if(!AnnounceNextUnlockCriteria()) return 0;
    return (alert(src, "Do you want to unlock [element]-type magic? This is your [accessedMagicTrees.len+1]\th magic tree unlock. The initial unlock costs [glob.MagicNodeRPPCost] RPP, and it grants you the first node.", "Unlock [element] Tree", "No", "Yes") == "Yes");

/mob/proc/HyperInvestmentCriteraNotMet(element)
    //implement criteria for lapping elements later
    return 0;
/mob/proc/magicTreeHyperInvestment(element)
    src << "Calm down."

/mob/proc/unlockEntryNode(element)//happens for free when you buy the tree
    var/nodeName = glob.vars["[element]TreeNodes"][1];
    unlockNode(glob.vars["[element]TreeNodes"][nodeName]);

/mob/proc/unlockNode(magic_node/mn)
    acquiredMagicNodes |= mn
    DEBUGMSG("unlocking node [mn]");

/mob/proc/unlockMagicTree(element)
    if(element in accessedMagicTrees)
        magicTreeHyperInvestment(element);
        return;
    accessedMagicTrees |= element;
    
    src << "You've unlocked the ability to choose [element] magic tree nodes!";
    src << "Each node costs [glob.MagicNodeRPPCost] RPP to unlock.";
    unlockEntryNode(element);
    updateSelectionNodes();  

/mob/verb/
    Unlock_Access_Node(element as text)
        set name = ".unlockAccessNode"
        set hidden = 1;
        if(!canUnlockMagicTree(element)) return;
        if(unlockTreeChoice(element))
            unlockMagicTree(element);