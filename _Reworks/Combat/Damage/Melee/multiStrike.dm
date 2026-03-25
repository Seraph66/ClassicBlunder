/mob/proc/MultiStrike(secondStrike, thirdStrike, asuraStrike)
    if(!AttackQueue)
        if(GetDoubleStrike() && !secondStrike)
            #if DEBUG_MELEE
            log2text("Double Strike", "Double Strike proc'd", "damageDebugs.txt", "[ckey]/[name]")
            #endif
            Melee1(SecondStrike=1)
            if(GetTripleStrike() && !thirdStrike && secondStrike)
                #if DEBUG_MELEE
                log2text("Triple Strike", "Triple Strike proc'd", "damageDebugs.txt", "[ckey]/[name]")
                #endif
                Melee1(SecondStrike=1, ThirdStrike=1) // TODO come back to this, this is odd
                if(GetAsuraStrike() && !asuraStrike && thirdStrike && secondStrike)
                    #if DEBUG_MELEE
                    log2text("Asura Strike", "Asura Strike proc'd", "damageDebugs.txt", "[ckey]/[name]")
                    #endif
                    Melee1(SecondStrike=1, ThirdStrike=1, AsuraStrike=1)