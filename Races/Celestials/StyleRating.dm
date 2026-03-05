/mob/var/StyleRating = 0
/mob/var/tmp/StyleRatingExpiry = 0
/mob/var/tmp/StyleRatingDecaying = FALSE
/mob/var/tmp/StyleRatingLastWasPose = FALSE

/mob/proc/getStyleRank()
    switch(StyleRating)
        if(1) return "F"
        if(2) return "E"
        if(3) return "D"
        if(4) return "C"
        if(5) return "B"
        if(6) return "A"
        if(7) return "S"
        if(8) return "SS"
        if(9) return "SSS"
    return ""

/mob/proc/getStyleRankColor()
    switch(StyleRating)
        if(1) return "#888888"
        if(2) return "#cccccc"
        if(3) return "#44cc44"
        if(4) return "#4488ff"
        if(5) return "#aa44ff"
        if(6) return "#ffaa00"
        if(7) return "#ff2222"
        if(8) return "#ff4400"
        if(9) return "#ff00ff"
    return "#ffffff"

/mob/proc/getStyleBonusMult()
    if(passive_handler.Get("Smokin' Sick Style!!!"))
        return 2
    if(passive_handler.Get("Smokin'!"))
        return 1.5
    return 1

/mob/proc/gainStyleRating(n = 1, wasPose = FALSE)
    if(!passive_handler.Get("Stylish")) return
    if(wasPose && StyleRatingLastWasPose) return
    StyleRatingLastWasPose = wasPose
    StyleRating = min(StyleRating + n, 9)
    StyleRatingExpiry = world.time + Second(10)
    client?.updateStyleRating()
    startStyleRatingDecay()

/mob/proc/startStyleRatingDecay()
    if(StyleRatingDecaying) return
    StyleRatingDecaying = TRUE
    spawn()
        while(StyleRating > 0)
            sleep(10)
            if(StyleRating > 0 && world.time >= StyleRatingExpiry)
                resetStyleRating()
                break
        StyleRatingDecaying = FALSE

/mob/proc/resetStyleRating()
    StyleRating = 0
    StyleRatingLastWasPose = FALSE
    client?.updateStyleRating()

/client/var/tmp/obj/styleRatingHolder = new()

/client/proc/updateStyleRating()
    if(styleRatingHolder)
        if(mob.StyleRating > 0)
            if(!(styleRatingHolder in screen))
                styleRatingHolder.screen_loc = "RIGHT-0.25,BOTTOM+1.28"
                screen += styleRatingHolder
            var/rank = mob.getStyleRank()
            var/color = mob.getStyleRankColor()
            styleRatingHolder.maptext = {"<b><font color='[color]' size='+1'>[rank]</font></b>"}
            styleRatingHolder.maptext_width = 400
        else
            screen -= styleRatingHolder
