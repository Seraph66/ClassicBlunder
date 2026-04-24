// Absorb is now lethal-and-imprisoning. A KO'd victim is sent
// to the Majin's personal absorb room on z = MAJIN_ABSORB_Z and
// stays there (even while logged out) until the Majin dies or
// something pulls them out of the zone.
//
//  Innocent: regular absorb slots / skills; blob mechanic.
//  Super:    +2 absorb slots, +2 stolen skills per victim.
//  Unhinged: Power counts 2x in damage calcs

// Pending ejection registry. When a Majin dies (or otherwise releases a
// victim) while that victim is logged out, it records who should be ejected.
var/global/list/MAJIN_PENDING_EJECTIONS = list()

majinAbsorb
    var/list/absorbed = list()

    // refreshed any time class or ascension changes.
    var/absorbLimit = MAJIN_BASE_ABSORB_LIMIT
    var/skillsPerVictim = MAJIN_BASE_SKILLS_PER_VICTIM

majinAbsorb/proc/updateVariables(mob/p)
    if(!p) return
    var/isSuper = (p.Class == "Super")
    var/asc = p.AscensionsAcquired
    absorbLimit = MAJIN_BASE_ABSORB_LIMIT + asc + (isSuper ? MAJIN_SUPER_ABSORB_BONUS : 0)
    skillsPerVictim = MAJIN_BASE_SKILLS_PER_VICTIM + (isSuper ? (MAJIN_SUPER_SKILL_BONUS + asc) : 0)

majinAbsorb/proc/SumAbsorbedPeakPower(mob/absorber)
    . = 0
    if(!absorbed || !absorbed.len) return
    var/list/stale = null
    for(var/key in absorbed)
        var/list/entry = absorbed[key]
        if(!islist(entry)) continue
        var/mob/victim = entry["mob"]
        var/valid = 0
        if(victim && victim.z == MAJIN_ABSORB_Z)
            valid = 1
        else if(!victim && entry["was_logged_in"] == FALSE)
            valid = 1
        if(valid)
            . += entry["peak"]
        else
            if(!stale) stale = list()
            stale += key
    if(stale)
        for(var/k in stale)
            releaseVictim(absorber, k, "left_zone")

// Skill stealing

majinAbsorb/proc/IsStealableSkill(obj/Skills/s)
    if(!s) return 0
    if(!istype(s, /obj/Skills)) return 0
    // Never steal Absorb itself or variants.
    if(istype(s, /obj/Skills/Absorb)) return 0
    if(istype(s, /obj/Skills/Target_Clear)) return 0
    if(istype(s, /obj/Skills/Target_Switch)) return 0
    // No teleports
    if(istype(s, /obj/Skills/Teleport)) return 0
    return 1

majinAbsorb/proc/CollectStealable(mob/absorbee)
    . = list()
    if(!absorbee) return
    for(var/obj/Skills/s in absorbee.contents)
        if(IsStealableSkill(s))
            . += s

majinAbsorb/proc/StealSkills(mob/absorber, mob/absorbee)
    var/list/result = list("types" = list(), "refs" = list())
    var/list/available = CollectStealable(absorbee)
    if(!available.len)
        absorber << "[absorbee] has no skills you can absorb."
        return result

    var/max_picks = skillsPerVictim
    var/picks_left = max_picks
    while(picks_left > 0 && available.len > 0)
        var/list/menu = list("Cancel")
        var/list/menu_lookup = list()
        for(var/obj/Skills/s in available)
            var/label = "[s.name ? s.name : s.type]"
            menu += label
            menu_lookup[label] = s
        var/choice = input(absorber, "Pick a skill to absorb ([picks_left] picks left):", "Absorb Skills") in menu
        if(choice == "Cancel" || !choice) break
        var/obj/Skills/picked = menu_lookup[choice]
        if(!picked) continue
        var/chosenType = picked.type
        var/obj/Skills/copy = new chosenType
        absorber.AddSkill(copy)
        result["types"] += chosenType
        result["refs"] += copy
        available -= picked
        picks_left -= 1
        absorber << "You rip the knowledge of [choice] from [absorbee] and make it your own."
    return result

majinAbsorb/proc/doAbsorb(mob/absorber, mob/absorbee)
    if(!absorber || !absorbee) return
    updateVariables(absorber)

    // Already absorbed by us?
    if(absorbed["[absorbee.ckey]"])
        absorber << "You have already absorbed [absorbee]."
        return

    // Room slot exhaustion
    if(absorbed.len >= absorbLimit)
        absorber << "You cannot contain any more bodies in your stomach. Release one first."
        return

    // Ensure a room is claimed
    if(!absorber.majinOwnedRoom)
        absorber.ClaimMajinRoom()
    if(!absorber.majinOwnedRoom)
        return // error already shown

    // might overwrite mid-transport otherwise?
    var/peak = max(absorbee.PeakPowerObserved, absorbee.Power)

    // Steal skills
    var/list/stolen = StealSkills(absorber, absorbee)

    // Move victim into the Majin's room
    var/turf/dest = absorber.GetMajinRoomTurf()
    if(!dest)
        absorber << "Your stomach is nowhere to be found. Report this to an Admin."
        for(var/obj/Skills/s in stolen["refs"])
            absorber.DeleteSkill(s)
        return

    absorbee.absorbedBy = absorber.ckey
    absorbee.majinRoomIndex = absorber.majinOwnedRoom
    absorbee.loc = dest

    absorbed["[absorbee.ckey]"] = list(
        "mob" = absorbee,
        "skills" = stolen["types"],
        "skill_refs" = stolen["refs"],
        "peak" = peak,
        "was_logged_in" = (absorbee.client ? TRUE : FALSE)
    )

    absorber << "You absorb [absorbee] into your stomach. Their power becomes yours."
    absorbee << "You are absorbed into [absorber]! Your power and knowledge flow into them."
    OMsg(absorber, "[absorber] absorbs [absorbee]!")

// Possible FX here at some point
majinAbsorb/proc/releaseVictim(mob/absorber, theCkey, reason = "")
    if(!absorbed || !absorbed[theCkey]) return
    var/list/entry = absorbed[theCkey]

    if(islist(entry["skill_refs"]))
        for(var/obj/Skills/s in entry["skill_refs"])
            if(s) absorber.DeleteSkill(s)

    var/mob/victim = entry["mob"]
    if(victim)
        if(victim.z == MAJIN_ABSORB_Z)
            victim.loc = locate(absorber.x, absorber.y, absorber.z)
        victim.absorbedBy = null
        victim.majinRoomIndex = 0
        victim.KO = 1
        if(victim.client)
            victim << "You are violently expelled from [absorber]!"
    else
        // Victim is currently logged out. Stash an ejection point
            MAJIN_PENDING_EJECTIONS["[theCkey]"] = list(absorber.x, absorber.y, absorber.z, "[absorber]")

    absorbed -= theCkey

    if(!absorbed.len)
        absorber.ReleaseMajinRoom()

majinAbsorb/proc/releaseAll(mob/absorber, reason = "")
    if(!absorbed || !absorbed.len) return
    var/list/keys = absorbed.Copy()
    for(var/k in keys)
        releaseVictim(absorber, k, reason)
    absorbed = list()
    absorber.ReleaseMajinRoom()

// Victims remain locked in their Majin's stomach even across relogs

/proc/FindMajinAbsorbingCkey(theCkey)
    if(!theCkey) return null
    for(var/mob/Players/M in players)
        if(M.majinAbsorb && M.majinAbsorb.absorbed && M.majinAbsorb.absorbed["[theCkey]"])
            return M
    return null

/mob/proc/MajinAbsorbOnLogout()
    if(!ckey) return
    var/mob/Players/M = FindMajinAbsorbingCkey(ckey)
    if(!M) return
    var/list/entry = M.majinAbsorb.absorbed["[ckey]"]
    if(!islist(entry)) return
    entry["was_logged_in"] = FALSE
    entry["mob"] = null

/mob/proc/MajinAbsorbOnLogin()
    if(!ckey) return
    // Safeguard for if this player was absorbed by a Majin that has since died
    var/list/pending = MAJIN_PENDING_EJECTIONS["[ckey]"]
    if(islist(pending) && pending.len >= 3)
        var/turf/T = locate(pending[1], pending[2], pending[3])
        if(T)
            src.loc = T
        src.absorbedBy = null
        src.majinRoomIndex = 0
        src.KO = 1
        var/absorberName = (pending.len >= 4) ? pending[4] : "your captor"
        src << "<font color='red'>You are violently expelled from [absorberName]'s corpse!</font>"
        MAJIN_PENDING_EJECTIONS -= "[ckey]"
        return
    var/mob/Players/M = FindMajinAbsorbingCkey(ckey)
    if(!M) return
    var/list/entry = M.majinAbsorb.absorbed["[ckey]"]
    if(!islist(entry)) return
    entry["mob"] = src
    entry["was_logged_in"] = TRUE
    src.absorbedBy = M.ckey
    src.majinRoomIndex = M.majinOwnedRoom
    var/turf/dest = M.GetMajinRoomTurf()
    if(dest)
        src.loc = dest
        src << "You are currently trapped inside of [M]."

// Manual release
/mob/proc/releaseAbsorbedPrompt()
    if(!isRace(MAJIN) || !majinAbsorb)
        src << "You have nothing absorbed."
        return
    if(!majinAbsorb.absorbed || !majinAbsorb.absorbed.len)
        src << "You have no one absorbed."
        return
    var/list/menu = list("Cancel")
    var/list/menu_lookup = list()
    for(var/key in majinAbsorb.absorbed)
        var/list/entry = majinAbsorb.absorbed[key]
        if(!islist(entry)) continue
        var/mob/victim = entry["mob"]
        var/label = victim ? "[victim.name] ([key])" : "[key] (offline)"
        menu += label
        menu_lookup[label] = key
    var/choice = input(src, "Who do you want to spit out?", "Release Absorb") in menu
    if(!choice || choice == "Cancel") return
    var/targetKey = menu_lookup[choice]
    if(!targetKey) return
    majinAbsorb.releaseVictim(src, targetKey, "voluntary")
    src << "You spit [choice] back out."
    OMsg(src, "[src] violently ejects someone from their body!")

/mob/proc/absorbSomebody(mob/target)
    if(!target)
        target = src.Target
    if(!target)
        src << "You need a target to absorb."
        return
    if(target == src)
        src << "You cannot absorb yourself, retard!"
        return
    if(!target.KO)
        src << "[target] must be knocked out before you can absorb them."
        return
    if(target.isRace(ANDROID))
        src << "[target] is mechanical and cannot be absorbed."
        return
    if(target.isRace(MAJIN))
        src << "You cannot absorb another Majin."
        return
    if(!src.majinAbsorb)
        return
    if(target.client && src.client)
        if(target.client.address == src.client.address || target.client.computer_id == src.client.computer_id)
            if(!soIgnore && target.client.computer_id != src.client.computer_id)
                src << "Nice try, bucko."
                return
    majinAbsorb.doAbsorb(src, target)
