// global demon database
var/global/list/DEMON_DB = list()
var/global/list/DEMON_FUSION_CHART = list()
var/global/list/DEMON_SPECIAL_FUSIONS = list()

// Potential divisor for stat scaling
#define DEMON_POTENTIAL_DIVISOR 100

/datum/demon_data
	var/demon_name       = ""
	var/demon_race       = ""
	var/demon_lvl        = 0
	var/demon_str        = 0
	var/demon_for        = 0
	var/demon_end        = 0
	var/demon_spd        = 0
	var/demon_off        = 0
	var/demon_def        = 0
	var/demon_skill      = ""  // primary skill name
	var/demon_unique     = FALSE // TRUE = not a normal fusion result target
	var/demon_icon       = 'Icons/base/default/frisky-male_black_brown.dmi'
	var/demon_icon_state = "walking"
	var/demon_portrait   = 'Icons/DevilSummoner/portrait_placeholder.dmi'
	var/demon_portrait2  = 'Icons/DevilSummoner/portrait_placeholder.dmi'

/datum/party_demon
	var/demon_name    = ""
	var/party_level   = 0   // DS2 base level or recorded level (used in fusion calc)
	var/current_hp    = 100 // max is always 100

/datum/compendium_demon
	var/demon_name       = ""
	var/base_level       = 0   // DS2 base level (static)
	var/recorded_level   = 0   // Potential-scaled level at time of recording

/world/New()
	..()
	InitDemonDatabase()
	InitFusionData()
	InitDemonSkillVFX()
