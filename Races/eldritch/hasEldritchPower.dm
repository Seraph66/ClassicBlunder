/mob/proc/hasEldritchPower()
    if(hasSecret("Eldritch") && CheckSlotless("True Form")) return 1;
    if(hasSecret("Eldritch (Shrouded)") && WoundIntent) return 1;
    if(hasSecret("Eldritch (Reflected)" && get_potential()>= 40)) return 1;
    return 0;