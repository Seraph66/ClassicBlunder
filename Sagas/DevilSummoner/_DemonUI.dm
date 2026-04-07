// Clean this up after placeholders are filled
/proc/DemonPortraitHTML(datum/demon_data/dd, size)
	if(!dd) return "<div style='width:[size]px;height:[size]px;background:#222;border:1px solid #555;'></div>"
	var/initial = copytext(dd.demon_name, 1, 2)
	return "<div style='width:[size]px;height:[size]px;background:#1a1a2e;border:1px solid #4a2a6e;display:flex;align-items:center;justify-content:center;color:#c8b8ff;font-size:[round(size*0.4)]px;font-weight:bold;'>[initial]</div>"

/proc/InvalidPortraitHTML(size)
	return "<div style='width:[size]px;height:[size]px;background:#300;border:2px solid #f00;display:flex;align-items:center;justify-content:center;color:#f44;font-size:[round(size*0.5)]px;font-weight:bold;'>X</div>"

#define DS_STYLE "background:#0a0a0f;color:#c8b8ff;font-family:'Arial',sans-serif;"
#define DS_HEADER_STYLE "background:#1a0a2e;color:#e8d0ff;padding:8px 12px;font-size:14px;font-weight:bold;border-bottom:1px solid #4a2a6e;"
#define DS_BTN_STYLE "background:#2a1a4e;color:#e8d0ff;border:1px solid #6a4a9e;padding:4px 10px;cursor:pointer;text-decoration:none;font-size:11px;"
#define DS_BTN_VALID "background:#1a3a1e;color:#80ff80;border:1px solid #3a8a3e;padding:4px 10px;cursor:pointer;text-decoration:none;font-size:11px;"

/mob/proc/RefreshDemonSummonWindow()
	var/party_size = demon_party ? demon_party.len : 0
	for(var/i = 1 to 10)
		var/slot = "DemonSlot_[i]"
		var/label = "DemonSlotName_[i]"
		if(i <= party_size)
			var/datum/party_demon/pd = demon_party[i]
			var/datum/demon_data/dd = DEMON_DB[pd.demon_name]
			if(dd)
				winset(src, slot,  "image=[dd.demon_portrait];is-visible=true")
				// Indicate active demon with a highlight
				var/tag = (pd.demon_name == demon_active_name) ? "[pd.demon_name] *" : pd.demon_name
				winset(src, label, "text='[tag]';is-visible=true")
			else
				winset(src, slot,  "image=;is-visible=false")
				winset(src, label, "text=;is-visible=false")
		else
			winset(src, slot,  "image=;is-visible=false")
			winset(src, label, "text=;is-visible=false")

/mob/verb/DemonSlotClick(index as num)
	set hidden = TRUE
	if(Saga != "Devil Summoner") return
	if(!demon_party || index < 1 || index > demon_party.len) return
	if(world.time < demon_summon_cooldown)
		var/remaining = round((demon_summon_cooldown - world.time) / 10)
		src << "Summon Demon is on cooldown. ([remaining]s remaining)"
		return
	var/datum/party_demon/pd = demon_party[index]
	if(!pd) return

	winshow(src, "DemonSummonWindow", FALSE)

	if(pd.demon_name == demon_active_name)
		DemonUnsummon()
	else
		DemonSummonFromParty(pd.demon_name)

/mob/proc/OpenFusionUI()
	if(!demon_party || demon_party.len < 2)
		src << "You need at least 2 demons in your party to fuse."
		return

	var/list/pairs = list()
	for(var/a = 1 to demon_party.len)
		for(var/b = a+1 to demon_party.len)
			var/datum/party_demon/pd_a = demon_party[a]
			var/datum/party_demon/pd_b = demon_party[b]
			var/result = GetFusionResultByLevel(pd_a.demon_name, pd_a.party_level,
			                                    pd_b.demon_name, pd_b.party_level)
			// Check if result is element fusion
			var/is_element = result && copytext(result, 1, 9) == "_ELEMENT_"
			var/valid = result && !is_element
			if(is_element && SagaLevel >= 6) valid = TRUE

			pairs += list(list(
				"a"       = pd_a.demon_name,
				"b"       = pd_b.demon_name,
				"result"  = result,
				"valid"   = valid,
				"element" = is_element
			))

	var/list/valid_pairs   = list()
	var/list/invalid_pairs = list()
	for(var/entry in pairs)
		if(entry["valid"]) valid_pairs   += list(entry)
		else               invalid_pairs += list(entry)
	pairs = valid_pairs + invalid_pairs

	demon_fusion_page = max(1, min(demon_fusion_page, ceil(pairs.len / 5)))
	src << browse(BuildFusionHTML(pairs, demon_fusion_page), "window=DemonFusion;size=640,560")

/proc/BuildFusionHTML(list/pairs, page)
	var/total_pages = max(1, ceil(pairs.len / 5))
	var/page_start  = (page - 1) * 5 + 1
	var/page_end    = min(page_start + 4, pairs.len)

	var/html = "<html><head><style>"
	html += "body {[DS_STYLE] margin:0; padding:0;}"
	html += ".header {[DS_HEADER_STYLE]}"
	html += ".row {display:flex;align-items:center;border-bottom:1px solid #2a1a4e;padding:6px 8px;gap:8px;}"
	html += ".dname {font-size:10px;color:#9a88cc;text-align:center;width:96px;}"
	html += ".plus {font-size:20px;color:#6a4a9e;margin:0 4px;}"
	html += ".eq {font-size:20px;color:#6a4a9e;margin:0 4px;}"
	html += ".fuseBtn {[DS_BTN_VALID] margin-left:auto;}"
	html += ".pager {display:flex;align-items:center;gap:8px;padding:6px 12px;justify-content:flex-end;}"
	html += ".pagerBtn {[DS_BTN_STYLE]}"
	html += "</style></head><body>"

	html += "<div class='header'>FUSION LABORATORY &nbsp;&nbsp; Page [page] / [total_pages]</div>"

	for(var/i = page_start, i <= page_end, i++)
		var/list/pair = pairs[i]
		var/name_a  = pair["a"]
		var/name_b  = pair["b"]
		var/result  = pair["result"]
		var/valid   = pair["valid"]
		var/element = pair["element"]

		var/datum/demon_data/da = DEMON_DB[name_a]
		var/datum/demon_data/db = DEMON_DB[name_b]

		html += "<div class='row'>"

		// Demon A
		html += "<div>"
		html += DemonPortraitHTML(da, 96)
		html += "<div class='dname'>[name_a]<br><span style='color:#7a6aaa;'>[da ? da.demon_race : "?"] Lv[da ? da.demon_lvl : "?"]</span></div>"
		html += "</div>"

		html += "<div class='plus'>+</div>"

		// Demon B
		html += "<div>"
		html += DemonPortraitHTML(db, 96)
		html += "<div class='dname'>[name_b]<br><span style='color:#7a6aaa;'>[db ? db.demon_race : "?"] Lv[db ? db.demon_lvl : "?"]</span></div>"
		html += "</div>"

		html += "<div class='eq'>=</div>"

		// Result
		if(valid)
			var/result_clean = element ? copytext(result, findtext(result, "_", 9) + 1) : result
			var/datum/demon_data/dr = DEMON_DB[result_clean]
			html += "<div>"
			html += DemonPortraitHTML(dr, 96)
			html += "<div class='dname'>[result_clean]<br>"
			if(dr) html += "<span style='color:#7a6aaa;'>[dr.demon_race] Lv[dr.demon_lvl]</span>"
			html += "</div></div>"
			// Fuse button
			html += "<a class='fuseBtn' href='byond://?src=\ref[world];demon_fuse_a=[name_a];demon_fuse_b=[name_b]'>FUSE</a>"
		else
			html += "<div>[InvalidPortraitHTML(96)]<div class='dname' style='color:#663333;'>Invalid</div></div>"

		html += "</div>"  // end row

	// Pagination
	html += "<div class='pager'>"
	if(page > 1)
		html += "<a class='pagerBtn' href='byond://?src=\ref[world];demon_fusion_page=[page-1]'>&lt; Prev</a>"
	html += "<span style='color:#9a88cc;'>Page [page] / [total_pages]</span>"
	if(page < total_pages)
		html += "<a class='pagerBtn' href='byond://?src=\ref[world];demon_fusion_page=[page+1]'>Next &gt;</a>"
	html += "</div>"

	html += "</body></html>"
	return html

// compendium UI

/mob/proc/OpenCompendiumUI()
	if(!demon_compendium || !demon_compendium.len)
		src << "Your compendium is empty. Use Record Demon to save a demon."
		return
	src << browse(BuildCompendiumHTML(src), "window=DemonCompendium;size=680,520")

/proc/BuildCompendiumHTML(mob/player)
	var/html = "<html><head><style>"
	html += "body {[DS_STYLE] margin:0; padding:0;}"
	html += ".header {[DS_HEADER_STYLE]}"
	html += ".grid {display:flex;flex-wrap:wrap;gap:12px;padding:12px;}"
	html += ".card {background:#110820;border:1px solid #3a2a6e;padding:6px;text-align:center;width:130px;cursor:pointer;}"
	html += ".card:hover {border-color:#8a5abe;}"
	html += ".dname {font-size:11px;color:#c8b8ff;margin-top:4px;}"
	html += ".dinfo {font-size:10px;color:#7a6aaa;}"
	html += ".withdrawn {opacity:0.4;}"
	html += "</style></head><body>"
	html += "<div class='header'>COMPENDIUM -- [player.demon_compendium.len] Recorded</div>"
	html += "<div class='grid'>"

	for(var/dname in player.demon_compendium)
		var/datum/compendium_demon/cd = player.demon_compendium[dname]
		var/datum/demon_data/dd = DEMON_DB[dname]
		if(!dd) continue

		// Check if already in party (greyed out)
		var/in_party = FALSE
		for(var/datum/party_demon/pd in player.demon_party)
			if(pd.demon_name == dname) { in_party = TRUE; break }

		var/card_class = in_party ? "card withdrawn" : "card"
		var/link = in_party ? "" : "href='byond://?src=\ref[world];demon_withdraw=[dname]'"

		if(in_party)
			html += "<div class='[card_class]'>"
		else
			html += "<a class='[card_class]' [link] style='text-decoration:none;display:block;'>"
		html += DemonPortraitHTML(dd, 110)
		html += "<div class='dname'>[dname]</div>"
		html += "<div class='dinfo'>[dd.demon_race] Lv[dd.demon_lvl]</div>"
		if(cd.recorded_level > cd.base_level)
			html += "<div class='dinfo' style='color:#c8a840;'>* Recorded Lv[cd.recorded_level]</div>"
		if(in_party)
			html += "<div class='dinfo' style='color:#446644;'>\[In Party\]</div>"
		if(in_party)
			html += "</div>"
		else
			html += "</a>"

	html += "</div></body></html>"
	return html

// Popup shown when player clicks a demon in the compendium for withdrawal
/mob/proc/OpenWithdrawPopup(demon_name)
	if(!demon_compendium || !(demon_name in demon_compendium)) return
	var/datum/compendium_demon/cd = demon_compendium[demon_name]
	var/datum/demon_data/dd = DEMON_DB[demon_name]
	if(!dd) return

	// Check party space
	var/cap = demon_party_cap
	if(demon_party && demon_party.len >= cap)
		src << "Your party is full ([cap] demons). Release a demon first."
		return

	var/base_cost     = cd.base_level * 500
	var/recorded_cost = cd.recorded_level * 500

	var/html = "<html><head><style>body{[DS_STYLE]margin:8px;}</style></head><body>"
	html += "<b style='font-size:14px;color:#e8d0ff;'>[demon_name]</b><br>"
	html += "<i style='color:#9a88cc;'>[dd.demon_race] -- Base Lv[cd.base_level]</i><br><br>"
	html += DemonPortraitHTML(dd, 110)
	html += "<br><br>"
	html += "<a href='byond://?src=\ref[world];demon_withdraw_confirm=[demon_name];level=base' style='[DS_BTN_STYLE] display:block; margin-bottom:6px;'>Withdraw at Base Lv[cd.base_level] ([base_cost] Mana Bits)</a>"
	if(cd.recorded_level > cd.base_level)
		html += "<a href='byond://?src=\ref[world];demon_withdraw_confirm=[demon_name];level=recorded' style='[DS_BTN_VALID] display:block;'>Withdraw at Recorded Lv[cd.recorded_level] ([recorded_cost] Mana Bits)</a>"
	html += "</body></html>"
	src << browse(html, "window=DemonWithdraw;size=220,320")

// Record Demon UI

/mob/proc/OpenRecordDemonUI()
	if(!demon_party || !demon_party.len)
		src << "You have no demons in your party to record."
		return
	src << browse(BuildRecordDemonHTML(src), "window=DemonRecord;size=560,300")

/proc/BuildRecordDemonHTML(mob/player)
	var/html = "<html><head><style>"
	html += "body {[DS_STYLE] margin:0; padding:0;}"
	html += ".header {[DS_HEADER_STYLE]}"
	html += ".grid {display:flex;flex-wrap:wrap;gap:12px;padding:12px;}"
	html += ".card {background:#110820;border:1px solid #3a2a6e;padding:6px;text-align:center;width:130px;cursor:pointer;}"
	html += ".card:hover {border-color:#d4a0ff;}"
	html += ".dname {font-size:11px;color:#c8b8ff;margin-top:4px;}"
	html += ".dinfo {font-size:10px;color:#7a6aaa;}"
	html += "</style></head><body>"
	html += "<div class='header'>RECORD DEMON -- Choose a demon to save to your compendium</div>"
	html += "<div class='grid'>"

	for(var/datum/party_demon/pd in player.demon_party)
		var/datum/demon_data/dd = DEMON_DB[pd.demon_name]
		if(!dd) continue
		html += "<a class='card' href='byond://?src=\ref[world];demon_record=[pd.demon_name]' style='text-decoration:none;display:block;'>"
		html += DemonPortraitHTML(dd, 110)
		html += "<div class='dname'>[pd.demon_name]</div>"
		html += "<div class='dinfo'>[dd.demon_race] Lv[pd.party_level]</div>"
		html += "</a>"

	html += "</div></body></html>"
	return html


/world/Topic(href, href_list, mob/user)
	for(var/mob/client_mob in players)
		if(client_mob.client && client_mob.client.mob == user)
			user = client_mob
			break

	if(!istype(user, /mob)) return

	// Fusion page navigation
	if(href_list["demon_fusion_page"])
		user.demon_fusion_page = text2num(href_list["demon_fusion_page"])
		user.OpenFusionUI()
		return

	// Fuse two demons
	if(href_list["demon_fuse_a"] && href_list["demon_fuse_b"])
		var/name_a = href_list["demon_fuse_a"]
		var/name_b = href_list["demon_fuse_b"]
		user.ExecuteFusion(name_a, name_b)
		return

	// Open withdrawal popup
	if(href_list["demon_withdraw"])
		user.OpenWithdrawPopup(href_list["demon_withdraw"])
		return

	// Confirm withdrawal
	if(href_list["demon_withdraw_confirm"])
		var/dname = href_list["demon_withdraw_confirm"]
		var/level_choice = href_list["level"]
		user.ExecuteWithdraw(dname, level_choice)
		return

	// Record a demon
	if(href_list["demon_record"])
		user.ExecuteRecordDemon(href_list["demon_record"])
		return

	..()
