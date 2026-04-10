/proc/InitDemonDatabase()
	// Heqet (Avatar, Lv 13)
	var/datum/demon_data/_dd0 = new /datum/demon_data()
	_dd0.demon_name = "Heqet"
	_dd0.demon_race = "Avatar"
	_dd0.demon_lvl = 13
	_dd0.demon_str = 8
	_dd0.demon_for = 10
	_dd0.demon_end = 7
	_dd0.demon_spd = 4
	_dd0.demon_off = 4
	_dd0.demon_def = 4
	_dd0.demon_skills = list("Bufu")
	_dd0.demon_unique = FALSE
	DEMON_DB["Heqet"] = _dd0

	// Apis (Avatar, Lv 21)
	var/datum/demon_data/_dd1 = new /datum/demon_data()
	_dd1.demon_name = "Apis"
	_dd1.demon_race = "Avatar"
	_dd1.demon_lvl = 21
	_dd1.demon_str = 8
	_dd1.demon_for = 12
	_dd1.demon_end = 8
	_dd1.demon_spd = 9
	_dd1.demon_off = 4
	_dd1.demon_def = 4
	_dd1.demon_skills = list("Fire Dance")
	_dd1.demon_unique = TRUE
	DEMON_DB["Apis"] = _dd1

	// Shiisaa (Avatar, Lv 28)
	var/datum/demon_data/_dd2 = new /datum/demon_data()
	_dd2.demon_name = "Shiisaa"
	_dd2.demon_race = "Avatar"
	_dd2.demon_lvl = 28
	_dd2.demon_str = 13
	_dd2.demon_for = 9
	_dd2.demon_end = 12
	_dd2.demon_spd = 10
	_dd2.demon_off = 7
	_dd2.demon_def = 6
	_dd2.demon_skills = list("Mazio")
	_dd2.demon_unique = FALSE
	_dd2.demon_icon = 'Icons/DevilSummoner/Shiisaa.dmi'
	DEMON_DB["Shiisaa"] = _dd2

	// Kamapua'a (Avatar, Lv 32)
	var/datum/demon_data/_dd3 = new /datum/demon_data()
	_dd3.demon_name = "Kamapua'a"
	_dd3.demon_race = "Avatar"
	_dd3.demon_lvl = 32
	_dd3.demon_str = 14
	_dd3.demon_for = 9
	_dd3.demon_end = 11
	_dd3.demon_spd = 14
	_dd3.demon_off = 7
	_dd3.demon_def = 6
	_dd3.demon_skills = list("Diarahan")
	_dd3.demon_unique = TRUE
	DEMON_DB["Kamapua'a"] = _dd3

	// Bai Ze (Avatar, Lv 37)
	var/datum/demon_data/_dd4 = new /datum/demon_data()
	_dd4.demon_name = "Bai Ze"
	_dd4.demon_race = "Avatar"
	_dd4.demon_lvl = 37
	_dd4.demon_str = 12
	_dd4.demon_for = 15
	_dd4.demon_end = 11
	_dd4.demon_spd = 15
	_dd4.demon_off = 6
	_dd4.demon_def = 6
	_dd4.demon_skills = list("Diarama")
	_dd4.demon_unique = FALSE
	DEMON_DB["Bai Ze"] = _dd4

	// Pabilsag (Avatar, Lv 45)
	var/datum/demon_data/_dd5 = new /datum/demon_data()
	_dd5.demon_name = "Pabilsag"
	_dd5.demon_race = "Avatar"
	_dd5.demon_lvl = 45
	_dd5.demon_str = 19
	_dd5.demon_for = 11
	_dd5.demon_end = 18
	_dd5.demon_spd = 13
	_dd5.demon_off = 10
	_dd5.demon_def = 9
	_dd5.demon_skills = list("Multi-Strike")
	_dd5.demon_unique = TRUE
	DEMON_DB["Pabilsag"] = _dd5

	// Baihu (Avatar, Lv 53)
	var/datum/demon_data/_dd6 = new /datum/demon_data()
	_dd6.demon_name = "Baihu"
	_dd6.demon_race = "Avatar"
	_dd6.demon_lvl = 53
	_dd6.demon_str = 23
	_dd6.demon_for = 10
	_dd6.demon_end = 15
	_dd6.demon_spd = 21
	_dd6.demon_off = 12
	_dd6.demon_def = 8
	_dd6.demon_skills = list("Multi-Strike")
	_dd6.demon_unique = FALSE
	DEMON_DB["Baihu"] = _dd6

	// Airavata (Avatar, Lv 60)
	var/datum/demon_data/_dd7 = new /datum/demon_data()
	_dd7.demon_name = "Airavata"
	_dd7.demon_race = "Avatar"
	_dd7.demon_lvl = 60
	_dd7.demon_str = 20
	_dd7.demon_for = 16
	_dd7.demon_end = 30
	_dd7.demon_spd = 10
	_dd7.demon_off = 10
	_dd7.demon_def = 15
	_dd7.demon_skills = list("Diarahan")
	_dd7.demon_unique = FALSE
	DEMON_DB["Airavata"] = _dd7

	// Ukano Mitama (Avatar, Lv 64)
	var/datum/demon_data/_dd8 = new /datum/demon_data()
	_dd8.demon_name = "Ukano Mitama"
	_dd8.demon_race = "Avatar"
	_dd8.demon_lvl = 64
	_dd8.demon_str = 19
	_dd8.demon_for = 21
	_dd8.demon_end = 17
	_dd8.demon_spd = 23
	_dd8.demon_off = 10
	_dd8.demon_def = 9
	_dd8.demon_skills = list("Mazandyne")
	_dd8.demon_unique = TRUE
	DEMON_DB["Ukano Mitama"] = _dd8

	// Barong (Avatar, Lv 68)
	var/datum/demon_data/_dd9 = new /datum/demon_data()
	_dd9.demon_name = "Barong"
	_dd9.demon_race = "Avatar"
	_dd9.demon_lvl = 68
	_dd9.demon_str = 24
	_dd9.demon_for = 22
	_dd9.demon_end = 19
	_dd9.demon_spd = 19
	_dd9.demon_off = 12
	_dd9.demon_def = 10
	_dd9.demon_skills = list("None")
	_dd9.demon_unique = FALSE
	DEMON_DB["Barong"] = _dd9

	// Anubis (Avatar, Lv 76)
	var/datum/demon_data/_dd10 = new /datum/demon_data()
	_dd10.demon_name = "Anubis"
	_dd10.demon_race = "Avatar"
	_dd10.demon_lvl = 76
	_dd10.demon_str = 30
	_dd10.demon_for = 29
	_dd10.demon_end = 18
	_dd10.demon_spd = 15
	_dd10.demon_off = 15
	_dd10.demon_def = 9
	_dd10.demon_skills = list("Samarecarm")
	_dd10.demon_unique = TRUE
	DEMON_DB["Anubis"] = _dd10

	// Itsumade (Avian, Lv 8)
	var/datum/demon_data/_dd11 = new /datum/demon_data()
	_dd11.demon_name = "Itsumade"
	_dd11.demon_race = "Avian"
	_dd11.demon_lvl = 8
	_dd11.demon_str = 5
	_dd11.demon_for = 7
	_dd11.demon_end = 3
	_dd11.demon_spd = 9
	_dd11.demon_off = 3
	_dd11.demon_def = 2
	_dd11.demon_skills = list("Extra Cancel")
	_dd11.demon_unique = FALSE
	_dd11.demon_icon = 'Icons/DevilSummoner/Itsumade.dmi'
	DEMON_DB["Itsumade"] = _dd11

	// Moh Shuvuu (Avian, Lv 16)
	var/datum/demon_data/_dd12 = new /datum/demon_data()
	_dd12.demon_name = "Moh Shuvuu"
	_dd12.demon_race = "Avian"
	_dd12.demon_lvl = 16
	_dd12.demon_str = 9
	_dd12.demon_for = 6
	_dd12.demon_end = 7
	_dd12.demon_spd = 10
	_dd12.demon_off = 5
	_dd12.demon_def = 4
	_dd12.demon_skills = list("Bufu")
	_dd12.demon_unique = FALSE
	_dd12.demon_icon = 'Icons/DevilSummoner/Moh Shuvuu.dmi'
	DEMON_DB["Moh Shuvuu"] = _dd12

	// Hamsa (Avian, Lv 24)
	var/datum/demon_data/_dd13 = new /datum/demon_data()
	_dd13.demon_name = "Hamsa"
	_dd13.demon_race = "Avian"
	_dd13.demon_lvl = 24
	_dd13.demon_str = 9
	_dd13.demon_for = 6
	_dd13.demon_end = 10
	_dd13.demon_spd = 15
	_dd13.demon_off = 5
	_dd13.demon_def = 5
	_dd13.demon_skills = list("Diarama")
	_dd13.demon_unique = FALSE
	_dd13.demon_icon = 'Icons/DevilSummoner/Hamsa.dmi'
	DEMON_DB["Hamsa"] = _dd13

	// Suparna (Avian, Lv 31)
	var/datum/demon_data/_dd14 = new /datum/demon_data()
	_dd14.demon_name = "Suparna"
	_dd14.demon_race = "Avian"
	_dd14.demon_lvl = 31
	_dd14.demon_str = 9
	_dd14.demon_for = 13
	_dd14.demon_end = 10
	_dd14.demon_spd = 15
	_dd14.demon_off = 5
	_dd14.demon_def = 5
	_dd14.demon_skills = list("Force Dance")
	_dd14.demon_unique = FALSE
	DEMON_DB["Suparna"] = _dd14

	// Vidofnir (Avian, Lv 39)
	var/datum/demon_data/_dd15 = new /datum/demon_data()
	_dd15.demon_name = "Vidofnir"
	_dd15.demon_race = "Avian"
	_dd15.demon_lvl = 39
	_dd15.demon_str = 16
	_dd15.demon_for = 11
	_dd15.demon_end = 10
	_dd15.demon_spd = 18
	_dd15.demon_off = 8
	_dd15.demon_def = 5
	_dd15.demon_skills = list("Drain")
	_dd15.demon_unique = FALSE
	DEMON_DB["Vidofnir"] = _dd15

	// Badb Catha (Avian, Lv 46)
	var/datum/demon_data/_dd16 = new /datum/demon_data()
	_dd16.demon_name = "Badb Catha"
	_dd16.demon_race = "Avian"
	_dd16.demon_lvl = 46
	_dd16.demon_str = 18
	_dd16.demon_for = 12
	_dd16.demon_end = 18
	_dd16.demon_spd = 14
	_dd16.demon_off = 9
	_dd16.demon_def = 9
	_dd16.demon_skills = list("Mazandyne")
	_dd16.demon_unique = FALSE
	_dd16.demon_icon = 'Icons/DevilSummoner/Babd Catha.dmi'
	DEMON_DB["Badb Catha"] = _dd16

	// Anzu (Avian, Lv 54)
	var/datum/demon_data/_dd17 = new /datum/demon_data()
	_dd17.demon_name = "Anzu"
	_dd17.demon_race = "Avian"
	_dd17.demon_lvl = 54
	_dd17.demon_str = 20
	_dd17.demon_for = 13
	_dd17.demon_end = 15
	_dd17.demon_spd = 22
	_dd17.demon_off = 10
	_dd17.demon_def = 8
	_dd17.demon_skills = list("Makarakarn")
	_dd17.demon_unique = FALSE
	_dd17.demon_icon = 'Icons/DevilSummoner/Anzu.dmi'
	DEMON_DB["Anzu"] = _dd17

	// Feng Huang (Avian, Lv 62)
	var/datum/demon_data/_dd18 = new /datum/demon_data()
	_dd18.demon_name = "Feng Huang"
	_dd18.demon_race = "Avian"
	_dd18.demon_lvl = 62
	_dd18.demon_str = 16
	_dd18.demon_for = 20
	_dd18.demon_end = 15
	_dd18.demon_spd = 27
	_dd18.demon_off = 8
	_dd18.demon_def = 8
	_dd18.demon_skills = list("Agidyne")
	_dd18.demon_unique = FALSE
	DEMON_DB["Feng Huang"] = _dd18

	// Garuda (Avian, Lv 69)
	var/datum/demon_data/_dd19 = new /datum/demon_data()
	_dd19.demon_name = "Garuda"
	_dd19.demon_race = "Avian"
	_dd19.demon_lvl = 69
	_dd19.demon_str = 26
	_dd19.demon_for = 15
	_dd19.demon_end = 17
	_dd19.demon_spd = 27
	_dd19.demon_off = 13
	_dd19.demon_def = 9
	_dd19.demon_skills = list("Megidolaon")
	_dd19.demon_unique = FALSE
	DEMON_DB["Garuda"] = _dd19

	// Da Peng (Avian, Lv 77)
	var/datum/demon_data/_dd20 = new /datum/demon_data()
	_dd20.demon_name = "Da Peng"
	_dd20.demon_race = "Avian"
	_dd20.demon_lvl = 77
	_dd20.demon_str = 28
	_dd20.demon_for = 16
	_dd20.demon_end = 19
	_dd20.demon_spd = 30
	_dd20.demon_off = 14
	_dd20.demon_def = 10
	_dd20.demon_skills = list("Mediarahan")
	_dd20.demon_unique = FALSE
	DEMON_DB["Da Peng"] = _dd20

	// Kabuso (Beast, Lv 2)
	var/datum/demon_data/_dd21 = new /datum/demon_data()
	_dd21.demon_name = "Kabuso"
	_dd21.demon_race = "Beast"
	_dd21.demon_lvl = 2
	_dd21.demon_str = 4
	_dd21.demon_for = 6
	_dd21.demon_end = 4
	_dd21.demon_spd = 4
	_dd21.demon_off = 2
	_dd21.demon_def = 2
	_dd21.demon_skills = list("Agi")
	_dd21.demon_unique = FALSE
	_dd21.demon_icon = 'Icons/DevilSummoner/Kabuso.dmi'
	DEMON_DB["Kabuso"] = _dd21

	// Hairy Jack (Beast, Lv 10)
	var/datum/demon_data/_dd22 = new /datum/demon_data()
	_dd22.demon_name = "Hairy Jack"
	_dd22.demon_race = "Beast"
	_dd22.demon_lvl = 10
	_dd22.demon_str = 7
	_dd22.demon_for = 5
	_dd22.demon_end = 5
	_dd22.demon_spd = 9
	_dd22.demon_off = 4
	_dd22.demon_def = 3
	_dd22.demon_skills = list("Anger Hit")
	_dd22.demon_unique = FALSE
	DEMON_DB["Hairy Jack"] = _dd22

	// Nekomata (Beast, Lv 19)
	var/datum/demon_data/_dd23 = new /datum/demon_data()
	_dd23.demon_name = "Nekomata"
	_dd23.demon_race = "Beast"
	_dd23.demon_lvl = 19
	_dd23.demon_str = 10
	_dd23.demon_for = 4
	_dd23.demon_end = 9
	_dd23.demon_spd = 12
	_dd23.demon_off = 5
	_dd23.demon_def = 5
	_dd23.demon_skills = list("Media")
	_dd23.demon_unique = FALSE
	_dd23.demon_icon = 'Icons/DevilSummoner/Nekomata.dmi'
	DEMON_DB["Nekomata"] = _dd23

	// Orthrus (Beast, Lv 27)
	var/datum/demon_data/_dd24 = new /datum/demon_data()
	_dd24.demon_name = "Orthrus"
	_dd24.demon_race = "Beast"
	_dd24.demon_lvl = 27
	_dd24.demon_str = 14
	_dd24.demon_for = 7
	_dd24.demon_end = 12
	_dd24.demon_spd = 10
	_dd24.demon_off = 7
	_dd24.demon_def = 6
	_dd24.demon_skills = list("Berserk")
	_dd24.demon_unique = FALSE
	DEMON_DB["Orthrus"] = _dd24

	// Cait Sith (Beast, Lv 35)
	var/datum/demon_data/_dd25 = new /datum/demon_data()
	_dd25.demon_name = "Cait Sith"
	_dd25.demon_race = "Beast"
	_dd25.demon_lvl = 35
	_dd25.demon_str = 10
	_dd25.demon_for = 15
	_dd25.demon_end = 11
	_dd25.demon_spd = 15
	_dd25.demon_off = 5
	_dd25.demon_def = 6
	_dd25.demon_skills = list("Mabufu")
	_dd25.demon_unique = FALSE
	_dd25.demon_icon = 'Icons/DevilSummoner/Cait Sith.dmi'
	DEMON_DB["Cait Sith"] = _dd25

	// Nue (Beast, Lv 42)
	var/datum/demon_data/_dd26 = new /datum/demon_data()
	_dd26.demon_name = "Nue"
	_dd26.demon_race = "Beast"
	_dd26.demon_lvl = 42
	_dd26.demon_str = 19
	_dd26.demon_for = 12
	_dd26.demon_end = 15
	_dd26.demon_spd = 12
	_dd26.demon_off = 10
	_dd26.demon_def = 8
	_dd26.demon_skills = list("Berserk")
	_dd26.demon_unique = FALSE
	_dd26.demon_icon = 'Icons/DevilSummoner/Nue.dmi'
	DEMON_DB["Nue"] = _dd26

	// Myrmecolion (Beast, Lv 50)
	var/datum/demon_data/_dd27 = new /datum/demon_data()
	_dd27.demon_name = "Myrmecolion"
	_dd27.demon_race = "Beast"
	_dd27.demon_lvl = 50
	_dd27.demon_str = 22
	_dd27.demon_for = 15
	_dd27.demon_end = 10
	_dd27.demon_spd = 19
	_dd27.demon_off = 11
	_dd27.demon_def = 5
	_dd27.demon_skills = list("Agidyne")
	_dd27.demon_unique = FALSE
	DEMON_DB["Myrmecolion"] = _dd27

	// Cerberus (Beast, Lv 58)
	var/datum/demon_data/_dd28 = new /datum/demon_data()
	_dd28.demon_name = "Cerberus"
	_dd28.demon_race = "Beast"
	_dd28.demon_lvl = 58
	_dd28.demon_str = 25
	_dd28.demon_for = 11
	_dd28.demon_end = 17
	_dd28.demon_spd = 21
	_dd28.demon_off = 13
	_dd28.demon_def = 9
	_dd28.demon_skills = list("Agidyne")
	_dd28.demon_unique = FALSE
	_dd28.demon_icon = 'Icons/DevilSummoner/Cerberus.dmi'
	DEMON_DB["Cerberus"] = _dd28

	// Fenrir (Beast, Lv 66)
	var/datum/demon_data/_dd29 = new /datum/demon_data()
	_dd29.demon_name = "Fenrir"
	_dd29.demon_race = "Beast"
	_dd29.demon_lvl = 66
	_dd29.demon_str = 22
	_dd29.demon_for = 23
	_dd29.demon_end = 12
	_dd29.demon_spd = 25
	_dd29.demon_off = 11
	_dd29.demon_def = 6
	_dd29.demon_skills = list("Piercing Hit")
	_dd29.demon_unique = FALSE
	DEMON_DB["Fenrir"] = _dd29

	// Mahakala (Deity, Lv 22)
	var/datum/demon_data/_dd30 = new /datum/demon_data()
	_dd30.demon_name = "Mahakala"
	_dd30.demon_race = "Deity"
	_dd30.demon_lvl = 22
	_dd30.demon_str = 11
	_dd30.demon_for = 11
	_dd30.demon_end = 9
	_dd30.demon_spd = 7
	_dd30.demon_off = 6
	_dd30.demon_def = 5
	_dd30.demon_skills = list("None")
	_dd30.demon_unique = FALSE
	DEMON_DB["Mahakala"] = _dd30

	// Thor (Deity, Lv 29)
	var/datum/demon_data/_dd31 = new /datum/demon_data()
	_dd31.demon_name = "Thor"
	_dd31.demon_race = "Deity"
	_dd31.demon_lvl = 29
	_dd31.demon_str = 21
	_dd31.demon_for = 5
	_dd31.demon_end = 16
	_dd31.demon_spd = 3
	_dd31.demon_off = 11
	_dd31.demon_def = 8
	_dd31.demon_skills = list("Mazio")
	_dd31.demon_unique = TRUE
	DEMON_DB["Thor"] = _dd31

	// Arahabaki (Deity, Lv 33)
	var/datum/demon_data/_dd32 = new /datum/demon_data()
	_dd32.demon_name = "Arahabaki"
	_dd32.demon_race = "Deity"
	_dd32.demon_lvl = 33
	_dd32.demon_str = 18
	_dd32.demon_for = 13
	_dd32.demon_end = 12
	_dd32.demon_spd = 6
	_dd32.demon_off = 9
	_dd32.demon_def = 6
	_dd32.demon_skills = list("Bufudyne")
	_dd32.demon_unique = TRUE
	DEMON_DB["Arahabaki"] = _dd32

	// Odin (Deity, Lv 37)
	var/datum/demon_data/_dd33 = new /datum/demon_data()
	_dd33.demon_name = "Odin"
	_dd33.demon_race = "Deity"
	_dd33.demon_lvl = 37
	_dd33.demon_str = 13
	_dd33.demon_for = 20
	_dd33.demon_end = 11
	_dd33.demon_spd = 9
	_dd33.demon_off = 7
	_dd33.demon_def = 6
	_dd33.demon_skills = list("Ziodyne")
	_dd33.demon_unique = TRUE
	DEMON_DB["Odin"] = _dd33

	// Yama (Deity, Lv 41)
	var/datum/demon_data/_dd34 = new /datum/demon_data()
	_dd34.demon_name = "Yama"
	_dd34.demon_race = "Deity"
	_dd34.demon_lvl = 41
	_dd34.demon_str = 20
	_dd34.demon_for = 15
	_dd34.demon_end = 12
	_dd34.demon_spd = 10
	_dd34.demon_off = 10
	_dd34.demon_def = 6
	_dd34.demon_skills = list("Agidyne")
	_dd34.demon_unique = TRUE
	_dd34.demon_icon = 'Icons/DevilSummoner/Yama.dmi'
	DEMON_DB["Yama"] = _dd34

	// Inti (Deity, Lv 45)
	var/datum/demon_data/_dd35 = new /datum/demon_data()
	_dd35.demon_name = "Inti"
	_dd35.demon_race = "Deity"
	_dd35.demon_lvl = 45
	_dd35.demon_str = 20
	_dd35.demon_for = 20
	_dd35.demon_end = 10
	_dd35.demon_spd = 11
	_dd35.demon_off = 10
	_dd35.demon_def = 5
	_dd35.demon_skills = list("Zandyne")
	_dd35.demon_unique = TRUE
	DEMON_DB["Inti"] = _dd35

	// Mithra (Deity, Lv 49)
	var/datum/demon_data/_dd36 = new /datum/demon_data()
	_dd36.demon_name = "Mithra"
	_dd36.demon_race = "Deity"
	_dd36.demon_lvl = 49
	_dd36.demon_str = 15
	_dd36.demon_for = 26
	_dd36.demon_end = 15
	_dd36.demon_spd = 9
	_dd36.demon_off = 8
	_dd36.demon_def = 8
	_dd36.demon_skills = list("Megido")
	_dd36.demon_unique = TRUE
	DEMON_DB["Mithra"] = _dd36

	// Osiris (Deity, Lv 53)
	var/datum/demon_data/_dd37 = new /datum/demon_data()
	_dd37.demon_name = "Osiris"
	_dd37.demon_race = "Deity"
	_dd37.demon_lvl = 53
	_dd37.demon_str = 21
	_dd37.demon_for = 19
	_dd37.demon_end = 17
	_dd37.demon_spd = 12
	_dd37.demon_off = 11
	_dd37.demon_def = 9
	_dd37.demon_skills = list("Makarakarn")
	_dd37.demon_unique = TRUE
	DEMON_DB["Osiris"] = _dd37

	// Lugh (Deity, Lv 57)
	var/datum/demon_data/_dd38 = new /datum/demon_data()
	_dd38.demon_name = "Lugh"
	_dd38.demon_race = "Deity"
	_dd38.demon_lvl = 57
	_dd38.demon_str = 22
	_dd38.demon_for = 22
	_dd38.demon_end = 15
	_dd38.demon_spd = 14
	_dd38.demon_off = 11
	_dd38.demon_def = 8
	_dd38.demon_skills = list("Deathbound")
	_dd38.demon_unique = TRUE
	_dd38.demon_icon = 'Icons/DevilSummoner/Lugh.dmi'
	DEMON_DB["Lugh"] = _dd38

	// Alilat (Deity, Lv 61)
	var/datum/demon_data/_dd39 = new /datum/demon_data()
	_dd39.demon_name = "Alilat"
	_dd39.demon_race = "Deity"
	_dd39.demon_lvl = 61
	_dd39.demon_str = 24
	_dd39.demon_for = 25
	_dd39.demon_end = 14
	_dd39.demon_spd = 14
	_dd39.demon_off = 12
	_dd39.demon_def = 7
	_dd39.demon_skills = list("Megidolaon")
	_dd39.demon_unique = TRUE
	DEMON_DB["Alilat"] = _dd39

	// Baal (Deity, Lv 65)
	var/datum/demon_data/_dd40 = new /datum/demon_data()
	_dd40.demon_name = "Baal"
	_dd40.demon_race = "Deity"
	_dd40.demon_lvl = 65
	_dd40.demon_str = 23
	_dd40.demon_for = 29
	_dd40.demon_end = 14
	_dd40.demon_spd = 15
	_dd40.demon_off = 12
	_dd40.demon_def = 7
	_dd40.demon_skills = list("None")
	_dd40.demon_unique = TRUE
	DEMON_DB["Baal"] = _dd40

	// Lord Nan Dou (Deity, Lv 70)
	var/datum/demon_data/_dd41 = new /datum/demon_data()
	_dd41.demon_name = "Lord Nan Dou"
	_dd41.demon_race = "Deity"
	_dd41.demon_lvl = 70
	_dd41.demon_str = 20
	_dd41.demon_for = 28
	_dd41.demon_end = 23
	_dd41.demon_spd = 15
	_dd41.demon_off = 10
	_dd41.demon_def = 12
	_dd41.demon_skills = list("Samarecarm")
	_dd41.demon_unique = TRUE
	DEMON_DB["Lord Nan Dou"] = _dd41

	// Asura (Deity, Lv 77)
	var/datum/demon_data/_dd42 = new /datum/demon_data()
	_dd42.demon_name = "Asura"
	_dd42.demon_race = "Deity"
	_dd42.demon_lvl = 77
	_dd42.demon_str = 27
	_dd42.demon_for = 23
	_dd42.demon_end = 23
	_dd42.demon_spd = 20
	_dd42.demon_off = 14
	_dd42.demon_def = 12
	_dd42.demon_skills = list("Inferno")
	_dd42.demon_unique = TRUE
	DEMON_DB["Asura"] = _dd42

	// Angel (Divine, Lv 15)
	var/datum/demon_data/_dd43 = new /datum/demon_data()
	_dd43.demon_name = "Angel"
	_dd43.demon_race = "Divine"
	_dd43.demon_lvl = 15
	_dd43.demon_str = 7
	_dd43.demon_for = 10
	_dd43.demon_end = 7
	_dd43.demon_spd = 7
	_dd43.demon_off = 4
	_dd43.demon_def = 4
	_dd43.demon_skills = list("Dia")
	_dd43.demon_unique = FALSE
	DEMON_DB["Angel"] = _dd43

	// Power (Divine, Lv 24)
	var/datum/demon_data/_dd44 = new /datum/demon_data()
	_dd44.demon_name = "Power"
	_dd44.demon_race = "Divine"
	_dd44.demon_lvl = 24
	_dd44.demon_str = 15
	_dd44.demon_for = 7
	_dd44.demon_end = 13
	_dd44.demon_spd = 5
	_dd44.demon_off = 8
	_dd44.demon_def = 7
	_dd44.demon_skills = list("Extra Cancel")
	_dd44.demon_unique = FALSE
	_dd44.demon_icon = 'Icons/DevilSummoner/Power.dmi'
	DEMON_DB["Power"] = _dd44

	// Lailah (Divine, Lv 32)
	var/datum/demon_data/_dd45 = new /datum/demon_data()
	_dd45.demon_name = "Lailah"
	_dd45.demon_race = "Divine"
	_dd45.demon_lvl = 32
	_dd45.demon_str = 12
	_dd45.demon_for = 16
	_dd45.demon_end = 9
	_dd45.demon_spd = 11
	_dd45.demon_off = 6
	_dd45.demon_def = 5
	_dd45.demon_skills = list("Mabufu")
	_dd45.demon_unique = FALSE
	DEMON_DB["Lailah"] = _dd45

	// Aniel (Divine, Lv 42)
	var/datum/demon_data/_dd46 = new /datum/demon_data()
	_dd46.demon_name = "Aniel"
	_dd46.demon_race = "Divine"
	_dd46.demon_lvl = 42
	_dd46.demon_str = 19
	_dd46.demon_for = 10
	_dd46.demon_end = 17
	_dd46.demon_spd = 12
	_dd46.demon_off = 10
	_dd46.demon_def = 9
	_dd46.demon_skills = list("Drain")
	_dd46.demon_unique = FALSE
	_dd46.demon_icon = 'Icons/DevilSummoner/Aniel.dmi'
	DEMON_DB["Aniel"] = _dd46

	// Kazfiel (Divine, Lv 50)
	var/datum/demon_data/_dd47 = new /datum/demon_data()
	_dd47.demon_name = "Kazfiel"
	_dd47.demon_race = "Divine"
	_dd47.demon_lvl = 50
	_dd47.demon_str = 21
	_dd47.demon_for = 16
	_dd47.demon_end = 18
	_dd47.demon_spd = 11
	_dd47.demon_off = 11
	_dd47.demon_def = 9
	_dd47.demon_skills = list("Judgement")
	_dd47.demon_unique = FALSE
	_dd47.demon_icon = 'Icons/DevilSummoner/Kazfiel.dmi'
	DEMON_DB["Kazfiel"] = _dd47

	// Remiel (Divine, Lv 59)
	var/datum/demon_data/_dd48 = new /datum/demon_data()
	_dd48.demon_name = "Remiel"
	_dd48.demon_race = "Divine"
	_dd48.demon_lvl = 59
	_dd48.demon_str = 22
	_dd48.demon_for = 21
	_dd48.demon_end = 16
	_dd48.demon_spd = 16
	_dd48.demon_off = 11
	_dd48.demon_def = 8
	_dd48.demon_skills = list("Samarecarm")
	_dd48.demon_unique = TRUE
	DEMON_DB["Remiel"] = _dd48

	// Metatron (Divine, Lv 74)
	var/datum/demon_data/_dd49 = new /datum/demon_data()
	_dd49.demon_name = "Metatron"
	_dd49.demon_race = "Divine"
	_dd49.demon_lvl = 74
	_dd49.demon_str = 24
	_dd49.demon_for = 26
	_dd49.demon_end = 22
	_dd49.demon_spd = 18
	_dd49.demon_off = 12
	_dd49.demon_def = 11
	_dd49.demon_skills = list("None")
	_dd49.demon_unique = TRUE
	DEMON_DB["Metatron"] = _dd49

	// Toubyou (Dragon, Lv 12)
	var/datum/demon_data/_dd50 = new /datum/demon_data()
	_dd50.demon_name = "Toubyou"
	_dd50.demon_race = "Dragon"
	_dd50.demon_lvl = 12
	_dd50.demon_str = 7
	_dd50.demon_for = 8
	_dd50.demon_end = 5
	_dd50.demon_spd = 8
	_dd50.demon_off = 4
	_dd50.demon_def = 3
	_dd50.demon_skills = list("Elec Dance")
	_dd50.demon_unique = FALSE
	_dd50.demon_icon = 'Icons/DevilSummoner/Toubyou.dmi'
	DEMON_DB["Toubyou"] = _dd50

	// Bai Suzhen (Dragon, Lv 20)
	var/datum/demon_data/_dd51 = new /datum/demon_data()
	_dd51.demon_name = "Bai Suzhen"
	_dd51.demon_race = "Dragon"
	_dd51.demon_lvl = 20
	_dd51.demon_str = 10
	_dd51.demon_for = 9
	_dd51.demon_end = 7
	_dd51.demon_spd = 10
	_dd51.demon_off = 5
	_dd51.demon_def = 4
	_dd51.demon_skills = list("Diarama")
	_dd51.demon_unique = FALSE
	_dd51.demon_icon = 'Icons/DevilSummoner/Bai Suzhen.dmi'
	DEMON_DB["Bai Suzhen"] = _dd51

	// Basilisk (Dragon, Lv 28)
	var/datum/demon_data/_dd52 = new /datum/demon_data()
	_dd52.demon_name = "Basilisk"
	_dd52.demon_race = "Dragon"
	_dd52.demon_lvl = 28
	_dd52.demon_str = 13
	_dd52.demon_for = 13
	_dd52.demon_end = 10
	_dd52.demon_spd = 8
	_dd52.demon_off = 7
	_dd52.demon_def = 5
	_dd52.demon_skills = list("Fire Dance")
	_dd52.demon_unique = FALSE
	DEMON_DB["Basilisk"] = _dd52

	// Asp (Dragon, Lv 36)
	var/datum/demon_data/_dd53 = new /datum/demon_data()
	_dd53.demon_name = "Asp"
	_dd53.demon_race = "Dragon"
	_dd53.demon_lvl = 36
	_dd53.demon_str = 9
	_dd53.demon_for = 15
	_dd53.demon_end = 11
	_dd53.demon_spd = 17
	_dd53.demon_off = 5
	_dd53.demon_def = 6
	_dd53.demon_skills = list("Life Drain")
	_dd53.demon_unique = FALSE
	DEMON_DB["Asp"] = _dd53

	// Ym (Dragon, Lv 44)
	var/datum/demon_data/_dd54 = new /datum/demon_data()
	_dd54.demon_name = "Ym"
	_dd54.demon_race = "Dragon"
	_dd54.demon_lvl = 44
	_dd54.demon_str = 14
	_dd54.demon_for = 18
	_dd54.demon_end = 11
	_dd54.demon_spd = 17
	_dd54.demon_off = 7
	_dd54.demon_def = 6
	_dd54.demon_skills = list("Holy Dance")
	_dd54.demon_unique = FALSE
	DEMON_DB["Ym"] = _dd54

	// Python (Dragon, Lv 51)
	var/datum/demon_data/_dd55 = new /datum/demon_data()
	_dd55.demon_name = "Python"
	_dd55.demon_race = "Dragon"
	_dd55.demon_lvl = 51
	_dd55.demon_str = 13
	_dd55.demon_for = 25
	_dd55.demon_end = 12
	_dd55.demon_spd = 17
	_dd55.demon_off = 7
	_dd55.demon_def = 6
	_dd55.demon_skills = list("Agidyne")
	_dd55.demon_unique = FALSE
	DEMON_DB["Python"] = _dd55

	// Culebre (Dragon, Lv 58)
	var/datum/demon_data/_dd56 = new /datum/demon_data()
	_dd56.demon_name = "Culebre"
	_dd56.demon_race = "Dragon"
	_dd56.demon_lvl = 58
	_dd56.demon_str = 18
	_dd56.demon_for = 23
	_dd56.demon_end = 15
	_dd56.demon_spd = 18
	_dd56.demon_off = 9
	_dd56.demon_def = 8
	_dd56.demon_skills = list("Bufudyne")
	_dd56.demon_unique = FALSE
	DEMON_DB["Culebre"] = _dd56

	// Vritra (Dragon, Lv 65)
	var/datum/demon_data/_dd57 = new /datum/demon_data()
	_dd57.demon_name = "Vritra"
	_dd57.demon_race = "Dragon"
	_dd57.demon_lvl = 65
	_dd57.demon_str = 30
	_dd57.demon_for = 16
	_dd57.demon_end = 22
	_dd57.demon_spd = 13
	_dd57.demon_off = 15
	_dd57.demon_def = 11
	_dd57.demon_skills = list("Maziodyne")
	_dd57.demon_unique = FALSE
	_dd57.demon_icon = 'Icons/DevilSummoner/Vritra.dmi'
	DEMON_DB["Vritra"] = _dd57

	// Vasuki (Dragon, Lv 73)
	var/datum/demon_data/_dd58 = new /datum/demon_data()
	_dd58.demon_name = "Vasuki"
	_dd58.demon_race = "Dragon"
	_dd58.demon_lvl = 73
	_dd58.demon_str = 30
	_dd58.demon_for = 18
	_dd58.demon_end = 24
	_dd58.demon_spd = 17
	_dd58.demon_off = 15
	_dd58.demon_def = 12
	_dd58.demon_skills = list("None")
	_dd58.demon_unique = TRUE
	DEMON_DB["Vasuki"] = _dd58

	// Erthys (Element, Lv 7)
	var/datum/demon_data/_dd59 = new /datum/demon_data()
	_dd59.demon_name = "Erthys"
	_dd59.demon_race = "Element"
	_dd59.demon_lvl = 7
	_dd59.demon_str = 6
	_dd59.demon_for = 5
	_dd59.demon_end = 8
	_dd59.demon_spd = 4
	_dd59.demon_off = 3
	_dd59.demon_def = 4
	_dd59.demon_skills = list("Amrita")
	_dd59.demon_unique = FALSE
	DEMON_DB["Erthys"] = _dd59

	// Aeros (Element, Lv 12)
	var/datum/demon_data/_dd60 = new /datum/demon_data()
	_dd60.demon_name = "Aeros"
	_dd60.demon_race = "Element"
	_dd60.demon_lvl = 12
	_dd60.demon_str = 5
	_dd60.demon_for = 8
	_dd60.demon_end = 6
	_dd60.demon_spd = 9
	_dd60.demon_off = 3
	_dd60.demon_def = 3
	_dd60.demon_skills = list("Zio")
	_dd60.demon_unique = FALSE
	DEMON_DB["Aeros"] = _dd60

	// Aquans (Element, Lv 17)
	var/datum/demon_data/_dd61 = new /datum/demon_data()
	_dd61.demon_name = "Aquans"
	_dd61.demon_race = "Element"
	_dd61.demon_lvl = 17
	_dd61.demon_str = 7
	_dd61.demon_for = 11
	_dd61.demon_end = 7
	_dd61.demon_spd = 8
	_dd61.demon_off = 4
	_dd61.demon_def = 4
	_dd61.demon_skills = list("Ice Dance")
	_dd61.demon_unique = FALSE
	DEMON_DB["Aquans"] = _dd61

	// Flaemis (Element, Lv 22)
	var/datum/demon_data/_dd62 = new /datum/demon_data()
	_dd62.demon_name = "Flaemis"
	_dd62.demon_race = "Element"
	_dd62.demon_lvl = 22
	_dd62.demon_str = 9
	_dd62.demon_for = 13
	_dd62.demon_end = 8
	_dd62.demon_spd = 8
	_dd62.demon_off = 5
	_dd62.demon_def = 4
	_dd62.demon_skills = list("Maragi")
	_dd62.demon_unique = FALSE
	DEMON_DB["Flaemis"] = _dd62

	// Pixie (Fairy, Lv 2)
	var/datum/demon_data/_dd63 = new /datum/demon_data()
	_dd63.demon_name = "Pixie"
	_dd63.demon_race = "Fairy"
	_dd63.demon_lvl = 2
	_dd63.demon_str = 3
	_dd63.demon_for = 7
	_dd63.demon_end = 4
	_dd63.demon_spd = 4
	_dd63.demon_off = 2
	_dd63.demon_def = 2
	_dd63.demon_skills = list("Bufu")
	_dd63.demon_unique = FALSE
	_dd63.demon_icon = 'Icons/DevilSummoner/Pixie.dmi'
	DEMON_DB["Pixie"] = _dd63

	// Knocker (Fairy, Lv 7)
	var/datum/demon_data/_dd64 = new /datum/demon_data()
	_dd64.demon_name = "Knocker"
	_dd64.demon_race = "Fairy"
	_dd64.demon_lvl = 7
	_dd64.demon_str = 7
	_dd64.demon_for = 4
	_dd64.demon_end = 8
	_dd64.demon_spd = 4
	_dd64.demon_off = 4
	_dd64.demon_def = 4
	_dd64.demon_skills = list("Dia")
	_dd64.demon_unique = FALSE
	DEMON_DB["Knocker"] = _dd64

	// Kijimuna (Fairy, Lv 14)
	var/datum/demon_data/_dd65 = new /datum/demon_data()
	_dd65.demon_name = "Kijimuna"
	_dd65.demon_race = "Fairy"
	_dd65.demon_lvl = 14
	_dd65.demon_str = 6
	_dd65.demon_for = 8
	_dd65.demon_end = 6
	_dd65.demon_spd = 10
	_dd65.demon_off = 3
	_dd65.demon_def = 3
	_dd65.demon_skills = list("Force Dance")
	_dd65.demon_unique = FALSE
	DEMON_DB["Kijimuna"] = _dd65

	// Jack Frost (Fairy, Lv 21)
	var/datum/demon_data/_dd66 = new /datum/demon_data()
	_dd66.demon_name = "Jack Frost"
	_dd66.demon_race = "Fairy"
	_dd66.demon_lvl = 21
	_dd66.demon_str = 9
	_dd66.demon_for = 12
	_dd66.demon_end = 10
	_dd66.demon_spd = 6
	_dd66.demon_off = 5
	_dd66.demon_def = 5
	_dd66.demon_skills = list("Diarama")
	_dd66.demon_unique = FALSE
	_dd66.demon_icon = 'Icons/DevilSummoner/Jack Frost.dmi'
	DEMON_DB["Jack Frost"] = _dd66

	// Pyro Jack (Fairy, Lv 29)
	var/datum/demon_data/_dd67 = new /datum/demon_data()
	_dd67.demon_name = "Pyro Jack"
	_dd67.demon_race = "Fairy"
	_dd67.demon_lvl = 29
	_dd67.demon_str = 10
	_dd67.demon_for = 14
	_dd67.demon_end = 12
	_dd67.demon_spd = 9
	_dd67.demon_off = 5
	_dd67.demon_def = 6
	_dd67.demon_skills = list("Agidyne")
	_dd67.demon_unique = FALSE
	_dd67.demon_icon = 'Icons/DevilSummoner/Pyro Jack.dmi'
	DEMON_DB["Pyro Jack"] = _dd67

	// Lorelei (Fairy, Lv 37)
	var/datum/demon_data/_dd68 = new /datum/demon_data()
	_dd68.demon_name = "Lorelei"
	_dd68.demon_race = "Fairy"
	_dd68.demon_lvl = 37
	_dd68.demon_str = 9
	_dd68.demon_for = 19
	_dd68.demon_end = 10
	_dd68.demon_spd = 15
	_dd68.demon_off = 5
	_dd68.demon_def = 5
	_dd68.demon_skills = list("Diarahan")
	_dd68.demon_unique = FALSE
	DEMON_DB["Lorelei"] = _dd68

	// Silky (Fairy, Lv 44)
	var/datum/demon_data/_dd69 = new /datum/demon_data()
	_dd69.demon_name = "Silky"
	_dd69.demon_race = "Fairy"
	_dd69.demon_lvl = 44
	_dd69.demon_str = 12
	_dd69.demon_for = 23
	_dd69.demon_end = 13
	_dd69.demon_spd = 12
	_dd69.demon_off = 6
	_dd69.demon_def = 7
	_dd69.demon_skills = list("Bufudyne")
	_dd69.demon_unique = FALSE
	DEMON_DB["Silky"] = _dd69

	// Vivian (Fairy, Lv 52)
	var/datum/demon_data/_dd70 = new /datum/demon_data()
	_dd70.demon_name = "Vivian"
	_dd70.demon_race = "Fairy"
	_dd70.demon_lvl = 52
	_dd70.demon_str = 11
	_dd70.demon_for = 26
	_dd70.demon_end = 15
	_dd70.demon_spd = 16
	_dd70.demon_off = 6
	_dd70.demon_def = 8
	_dd70.demon_skills = list("Drain")
	_dd70.demon_unique = FALSE
	DEMON_DB["Vivian"] = _dd70

	// Titania (Fairy, Lv 58)
	var/datum/demon_data/_dd71 = new /datum/demon_data()
	_dd71.demon_name = "Titania"
	_dd71.demon_race = "Fairy"
	_dd71.demon_lvl = 58
	_dd71.demon_str = 16
	_dd71.demon_for = 27
	_dd71.demon_end = 17
	_dd71.demon_spd = 14
	_dd71.demon_off = 8
	_dd71.demon_def = 9
	_dd71.demon_skills = list("Recarmloss")
	_dd71.demon_unique = TRUE
	DEMON_DB["Titania"] = _dd71

	// Oberon (Fairy, Lv 62)
	var/datum/demon_data/_dd72 = new /datum/demon_data()
	_dd72.demon_name = "Oberon"
	_dd72.demon_race = "Fairy"
	_dd72.demon_lvl = 62
	_dd72.demon_str = 23
	_dd72.demon_for = 24
	_dd72.demon_end = 18
	_dd72.demon_spd = 13
	_dd72.demon_off = 12
	_dd72.demon_def = 9
	_dd72.demon_skills = list("Samarecarm")
	_dd72.demon_unique = TRUE
	DEMON_DB["Oberon"] = _dd72

	// Gagyson (Fallen, Lv 11)
	var/datum/demon_data/_dd73 = new /datum/demon_data()
	_dd73.demon_name = "Gagyson"
	_dd73.demon_race = "Fallen"
	_dd73.demon_lvl = 11
	_dd73.demon_str = 6
	_dd73.demon_for = 8
	_dd73.demon_end = 6
	_dd73.demon_spd = 7
	_dd73.demon_off = 3
	_dd73.demon_def = 3
	_dd73.demon_skills = list("Anger Hit")
	_dd73.demon_unique = FALSE
	_dd73.demon_icon = 'Icons/DevilSummoner/Gagyson.dmi'
	DEMON_DB["Gagyson"] = _dd73

	// Abraxas (Fallen, Lv 19)
	var/datum/demon_data/_dd74 = new /datum/demon_data()
	_dd74.demon_name = "Abraxas"
	_dd74.demon_race = "Fallen"
	_dd74.demon_lvl = 19
	_dd74.demon_str = 11
	_dd74.demon_for = 11
	_dd74.demon_end = 5
	_dd74.demon_spd = 8
	_dd74.demon_off = 6
	_dd74.demon_def = 3
	_dd74.demon_skills = list("Force Dance")
	_dd74.demon_unique = FALSE
	_dd74.demon_icon = 'Icons/DevilSummoner/Abraxas.dmi'
	DEMON_DB["Abraxas"] = _dd74

	// Flauros (Fallen, Lv 26)
	var/datum/demon_data/_dd75 = new /datum/demon_data()
	_dd75.demon_name = "Flauros"
	_dd75.demon_race = "Fallen"
	_dd75.demon_lvl = 26
	_dd75.demon_str = 14
	_dd75.demon_for = 9
	_dd75.demon_end = 11
	_dd75.demon_spd = 8
	_dd75.demon_off = 7
	_dd75.demon_def = 6
	_dd75.demon_skills = list("Maragi")
	_dd75.demon_unique = FALSE
	DEMON_DB["Flauros"] = _dd75

	// Barbatos (Fallen, Lv 33)
	var/datum/demon_data/_dd76 = new /datum/demon_data()
	_dd76.demon_name = "Barbatos"
	_dd76.demon_race = "Fallen"
	_dd76.demon_lvl = 33
	_dd76.demon_str = 11
	_dd76.demon_for = 13
	_dd76.demon_end = 10
	_dd76.demon_spd = 15
	_dd76.demon_off = 6
	_dd76.demon_def = 5
	_dd76.demon_skills = list("Mighty Hit")
	_dd76.demon_unique = FALSE
	DEMON_DB["Barbatos"] = _dd76

	// Botis (Fallen, Lv 37)
	var/datum/demon_data/_dd77 = new /datum/demon_data()
	_dd77.demon_name = "Botis"
	_dd77.demon_race = "Fallen"
	_dd77.demon_lvl = 37
	_dd77.demon_str = 13
	_dd77.demon_for = 14
	_dd77.demon_end = 18
	_dd77.demon_spd = 8
	_dd77.demon_off = 7
	_dd77.demon_def = 9
	_dd77.demon_skills = list("Shield All")
	_dd77.demon_unique = TRUE
	_dd77.demon_icon = 'Icons/DevilSummoner/Botis.dmi'
	DEMON_DB["Botis"] = _dd77

	// Nisroc (Fallen, Lv 41)
	var/datum/demon_data/_dd78 = new /datum/demon_data()
	_dd78.demon_name = "Nisroc"
	_dd78.demon_race = "Fallen"
	_dd78.demon_lvl = 41
	_dd78.demon_str = 14
	_dd78.demon_for = 18
	_dd78.demon_end = 10
	_dd78.demon_spd = 15
	_dd78.demon_off = 7
	_dd78.demon_def = 5
	_dd78.demon_skills = list("Agidyne")
	_dd78.demon_unique = FALSE
	DEMON_DB["Nisroc"] = _dd78

	// Bifrons (Fallen, Lv 45)
	var/datum/demon_data/_dd79 = new /datum/demon_data()
	_dd79.demon_name = "Bifrons"
	_dd79.demon_race = "Fallen"
	_dd79.demon_lvl = 45
	_dd79.demon_str = 16
	_dd79.demon_for = 20
	_dd79.demon_end = 15
	_dd79.demon_spd = 10
	_dd79.demon_off = 8
	_dd79.demon_def = 8
	_dd79.demon_skills = list("Agidyne")
	_dd79.demon_unique = TRUE
	_dd79.demon_icon = 'Icons/DevilSummoner/Bifrons.dmi'
	DEMON_DB["Bifrons"] = _dd79

	// Orobas (Fallen, Lv 49)
	var/datum/demon_data/_dd80 = new /datum/demon_data()
	_dd80.demon_name = "Orobas"
	_dd80.demon_race = "Fallen"
	_dd80.demon_lvl = 49
	_dd80.demon_str = 13
	_dd80.demon_for = 21
	_dd80.demon_end = 14
	_dd80.demon_spd = 17
	_dd80.demon_off = 7
	_dd80.demon_def = 7
	_dd80.demon_skills = list("Makarakarn")
	_dd80.demon_unique = FALSE
	_dd80.demon_icon = 'Icons/DevilSummoner/Orobas.dmi'
	DEMON_DB["Orobas"] = _dd80

	// Decarabia (Fallen, Lv 56)
	var/datum/demon_data/_dd81 = new /datum/demon_data()
	_dd81.demon_name = "Decarabia"
	_dd81.demon_race = "Fallen"
	_dd81.demon_lvl = 56
	_dd81.demon_str = 18
	_dd81.demon_for = 22
	_dd81.demon_end = 12
	_dd81.demon_spd = 20
	_dd81.demon_off = 9
	_dd81.demon_def = 6
	_dd81.demon_skills = list("Maragidyne")
	_dd81.demon_unique = FALSE
	_dd81.demon_icon = 'Icons/DevilSummoner/Decarabia.dmi'
	DEMON_DB["Decarabia"] = _dd81

	// Murmur (Fallen, Lv 64)
	var/datum/demon_data/_dd82 = new /datum/demon_data()
	_dd82.demon_name = "Murmur"
	_dd82.demon_race = "Fallen"
	_dd82.demon_lvl = 64
	_dd82.demon_str = 24
	_dd82.demon_for = 23
	_dd82.demon_end = 16
	_dd82.demon_spd = 17
	_dd82.demon_off = 12
	_dd82.demon_def = 8
	_dd82.demon_skills = list("Death Call")
	_dd82.demon_unique = FALSE
	_dd82.demon_icon = 'Icons/DevilSummoner/Murmur.dmi'
	DEMON_DB["Murmur"] = _dd82

	// Agares (Fallen, Lv 71)
	var/datum/demon_data/_dd83 = new /datum/demon_data()
	_dd83.demon_name = "Agares"
	_dd83.demon_race = "Fallen"
	_dd83.demon_lvl = 71
	_dd83.demon_str = 25
	_dd83.demon_for = 25
	_dd83.demon_end = 16
	_dd83.demon_spd = 21
	_dd83.demon_off = 13
	_dd83.demon_def = 8
	_dd83.demon_skills = list("Gigajama")
	_dd83.demon_unique = FALSE
	DEMON_DB["Agares"] = _dd83

	// Nebiros (Fallen, Lv 86)
	var/datum/demon_data/_dd84 = new /datum/demon_data()
	_dd84.demon_name = "Nebiros"
	_dd84.demon_race = "Fallen"
	_dd84.demon_lvl = 86
	_dd84.demon_str = 19
	_dd84.demon_for = 30
	_dd84.demon_end = 25
	_dd84.demon_spd = 28
	_dd84.demon_off = 10
	_dd84.demon_def = 13
	_dd84.demon_skills = list("None")
	_dd84.demon_unique = FALSE
	_dd84.demon_icon = 'Icons/DevilSummoner/Nebiros.dmi'
	DEMON_DB["Nebiros"] = _dd84

	// Satan (Fallen, Lv 99)
	var/datum/demon_data/_dd85 = new /datum/demon_data()
	_dd85.demon_name = "Satan"
	_dd85.demon_race = "Fallen"
	_dd85.demon_lvl = 99
	_dd85.demon_str = 32
	_dd85.demon_for = 28
	_dd85.demon_end = 27
	_dd85.demon_spd = 28
	_dd85.demon_off = 16
	_dd85.demon_def = 14
	_dd85.demon_skills = list("None")
	_dd85.demon_unique = TRUE
	DEMON_DB["Satan"] = _dd85

	// Kikimora (Femme, Lv 9)
	var/datum/demon_data/_dd86 = new /datum/demon_data()
	_dd86.demon_name = "Kikimora"
	_dd86.demon_race = "Femme"
	_dd86.demon_lvl = 9
	_dd86.demon_str = 5
	_dd86.demon_for = 9
	_dd86.demon_end = 5
	_dd86.demon_spd = 6
	_dd86.demon_off = 3
	_dd86.demon_def = 3
	_dd86.demon_skills = list("Dia")
	_dd86.demon_unique = FALSE
	DEMON_DB["Kikimora"] = _dd86

	// Lilim (Femme, Lv 18)
	var/datum/demon_data/_dd87 = new /datum/demon_data()
	_dd87.demon_name = "Lilim"
	_dd87.demon_race = "Femme"
	_dd87.demon_lvl = 18
	_dd87.demon_str = 8
	_dd87.demon_for = 11
	_dd87.demon_end = 8
	_dd87.demon_spd = 7
	_dd87.demon_off = 4
	_dd87.demon_def = 4
	_dd87.demon_skills = list("Elec Dance")
	_dd87.demon_unique = FALSE
	_dd87.demon_icon = 'Icons/DevilSummoner/Lilim.dmi'
	DEMON_DB["Lilim"] = _dd87

	// Leanan Sidhe (Femme, Lv 26)
	var/datum/demon_data/_dd88 = new /datum/demon_data()
	_dd88.demon_name = "Leanan Sidhe"
	_dd88.demon_race = "Femme"
	_dd88.demon_lvl = 26
	_dd88.demon_str = 8
	_dd88.demon_for = 16
	_dd88.demon_end = 8
	_dd88.demon_spd = 10
	_dd88.demon_off = 4
	_dd88.demon_def = 4
	_dd88.demon_skills = list("Bufudyne")
	_dd88.demon_unique = FALSE
	DEMON_DB["Leanan Sidhe"] = _dd88

	// Yuki Jyorou (Femme, Lv 34)
	var/datum/demon_data/_dd89 = new /datum/demon_data()
	_dd89.demon_name = "Yuki Jyorou"
	_dd89.demon_race = "Femme"
	_dd89.demon_lvl = 34
	_dd89.demon_str = 9
	_dd89.demon_for = 17
	_dd89.demon_end = 10
	_dd89.demon_spd = 14
	_dd89.demon_off = 5
	_dd89.demon_def = 5
	_dd89.demon_skills = list("Drain")
	_dd89.demon_unique = FALSE
	_dd89.demon_icon = 'Icons/DevilSummoner/Yuki Jyorou.dmi'
	DEMON_DB["Yuki Jyorou"] = _dd89

	// Peri (Femme, Lv 38)
	var/datum/demon_data/_dd90 = new /datum/demon_data()
	_dd90.demon_name = "Peri"
	_dd90.demon_race = "Femme"
	_dd90.demon_lvl = 38
	_dd90.demon_str = 8
	_dd90.demon_for = 22
	_dd90.demon_end = 10
	_dd90.demon_spd = 14
	_dd90.demon_off = 4
	_dd90.demon_def = 5
	_dd90.demon_skills = list("Ziodyne")
	_dd90.demon_unique = TRUE
	DEMON_DB["Peri"] = _dd90

	// Ixtab (Femme, Lv 42)
	var/datum/demon_data/_dd91 = new /datum/demon_data()
	_dd91.demon_name = "Ixtab"
	_dd91.demon_race = "Femme"
	_dd91.demon_lvl = 42
	_dd91.demon_str = 14
	_dd91.demon_for = 20
	_dd91.demon_end = 15
	_dd91.demon_spd = 9
	_dd91.demon_off = 7
	_dd91.demon_def = 8
	_dd91.demon_skills = list("Death Call")
	_dd91.demon_unique = FALSE
	DEMON_DB["Ixtab"] = _dd91

	// Hariti (Femme, Lv 46)
	var/datum/demon_data/_dd92 = new /datum/demon_data()
	_dd92.demon_name = "Hariti"
	_dd92.demon_race = "Femme"
	_dd92.demon_lvl = 46
	_dd92.demon_str = 22
	_dd92.demon_for = 17
	_dd92.demon_end = 14
	_dd92.demon_spd = 9
	_dd92.demon_off = 11
	_dd92.demon_def = 7
	_dd92.demon_skills = list("Maziodyne")
	_dd92.demon_unique = TRUE
	DEMON_DB["Hariti"] = _dd92

	// Dzelarhons (Femme, Lv 50)
	var/datum/demon_data/_dd93 = new /datum/demon_data()
	_dd93.demon_name = "Dzelarhons"
	_dd93.demon_race = "Femme"
	_dd93.demon_lvl = 50
	_dd93.demon_str = 21
	_dd93.demon_for = 20
	_dd93.demon_end = 13
	_dd93.demon_spd = 12
	_dd93.demon_off = 11
	_dd93.demon_def = 7
	_dd93.demon_skills = list("Tetrakarn")
	_dd93.demon_unique = TRUE
	DEMON_DB["Dzelarhons"] = _dd93

	// Rangda (Femme, Lv 58)
	var/datum/demon_data/_dd94 = new /datum/demon_data()
	_dd94.demon_name = "Rangda"
	_dd94.demon_race = "Femme"
	_dd94.demon_lvl = 58
	_dd94.demon_str = 23
	_dd94.demon_for = 15
	_dd94.demon_end = 18
	_dd94.demon_spd = 18
	_dd94.demon_off = 12
	_dd94.demon_def = 9
	_dd94.demon_skills = list("Assassinate")
	_dd94.demon_unique = FALSE
	_dd94.demon_icon = 'Icons/DevilSummoner/Rangda.dmi'
	DEMON_DB["Rangda"] = _dd94

	// Anat (Femme, Lv 66)
	var/datum/demon_data/_dd95 = new /datum/demon_data()
	_dd95.demon_name = "Anat"
	_dd95.demon_race = "Femme"
	_dd95.demon_lvl = 66
	_dd95.demon_str = 18
	_dd95.demon_for = 30
	_dd95.demon_end = 22
	_dd95.demon_spd = 12
	_dd95.demon_off = 9
	_dd95.demon_def = 11
	_dd95.demon_skills = list("Recarmloss")
	_dd95.demon_unique = TRUE
	DEMON_DB["Anat"] = _dd95

	// Kali (Femme, Lv 74)
	var/datum/demon_data/_dd96 = new /datum/demon_data()
	_dd96.demon_name = "Kali"
	_dd96.demon_race = "Femme"
	_dd96.demon_lvl = 74
	_dd96.demon_str = 29
	_dd96.demon_for = 20
	_dd96.demon_end = 23
	_dd96.demon_spd = 18
	_dd96.demon_off = 15
	_dd96.demon_def = 12
	_dd96.demon_skills = list("Prayer")
	_dd96.demon_unique = TRUE
	DEMON_DB["Kali"] = _dd96

	// Lilith (Femme, Lv 83)
	var/datum/demon_data/_dd97 = new /datum/demon_data()
	_dd97.demon_name = "Lilith"
	_dd97.demon_race = "Femme"
	_dd97.demon_lvl = 83
	_dd97.demon_str = 26
	_dd97.demon_for = 31
	_dd97.demon_end = 24
	_dd97.demon_spd = 18
	_dd97.demon_off = 13
	_dd97.demon_def = 12
	_dd97.demon_skills = list("None")
	_dd97.demon_unique = TRUE
	_dd97.demon_icon = 'Icons/DevilSummoner/Lilith.dmi'
	DEMON_DB["Lilith"] = _dd97

	// Ghost Q (Fiend, Lv 26)
	var/datum/demon_data/_dd98 = new /datum/demon_data()
	_dd98.demon_name = "Ghost Q"
	_dd98.demon_race = "Fiend"
	_dd98.demon_lvl = 26
	_dd98.demon_str = 9
	_dd98.demon_for = 11
	_dd98.demon_end = 10
	_dd98.demon_spd = 12
	_dd98.demon_off = 5
	_dd98.demon_def = 5
	_dd98.demon_skills = list("Berserk")
	_dd98.demon_unique = TRUE
	_dd98.demon_icon = 'Icons/DevilSummoner/Ghost Q.dmi'
	DEMON_DB["Ghost Q"] = _dd98

	// Sage of Time (Fiend, Lv 41)
	var/datum/demon_data/_dd99 = new /datum/demon_data()
	_dd99.demon_name = "Sage of Time"
	_dd99.demon_race = "Fiend"
	_dd99.demon_lvl = 41
	_dd99.demon_str = 9
	_dd99.demon_for = 25
	_dd99.demon_end = 12
	_dd99.demon_spd = 11
	_dd99.demon_off = 5
	_dd99.demon_def = 6
	_dd99.demon_skills = list("Death Call")
	_dd99.demon_unique = TRUE
	_dd99.demon_icon = 'Icons/DevilSummoner/Sage of Time.dmi'
	DEMON_DB["Sage of Time"] = _dd99

	// Billiken (Fiend, Lv 50)
	var/datum/demon_data/_dd100 = new /datum/demon_data()
	_dd100.demon_name = "Billiken"
	_dd100.demon_race = "Fiend"
	_dd100.demon_lvl = 50
	_dd100.demon_str = 15
	_dd100.demon_for = 21
	_dd100.demon_end = 16
	_dd100.demon_spd = 14
	_dd100.demon_off = 8
	_dd100.demon_def = 8
	_dd100.demon_skills = list("Life Drain")
	_dd100.demon_unique = TRUE
	_dd100.demon_icon = 'Icons/DevilSummoner/Billiken.dmi'
	DEMON_DB["Billiken"] = _dd100

	// Trumpeter (Fiend, Lv 63)
	var/datum/demon_data/_dd101 = new /datum/demon_data()
	_dd101.demon_name = "Trumpeter"
	_dd101.demon_race = "Fiend"
	_dd101.demon_lvl = 63
	_dd101.demon_str = 16
	_dd101.demon_for = 27
	_dd101.demon_end = 16
	_dd101.demon_spd = 20
	_dd101.demon_off = 8
	_dd101.demon_def = 8
	_dd101.demon_skills = list("Judgement")
	_dd101.demon_unique = TRUE
	DEMON_DB["Trumpeter"] = _dd101

	// Alice (Fiend, Lv 88)
	var/datum/demon_data/_dd102 = new /datum/demon_data()
	_dd102.demon_name = "Alice"
	_dd102.demon_race = "Fiend"
	_dd102.demon_lvl = 88
	_dd102.demon_str = 24
	_dd102.demon_for = 32
	_dd102.demon_end = 24
	_dd102.demon_spd = 24
	_dd102.demon_off = 12
	_dd102.demon_def = 12
	_dd102.demon_skills = list("None")
	_dd102.demon_unique = TRUE
	_dd102.demon_icon = 'Icons/DevilSummoner/Alice.dmi'
	DEMON_DB["Alice"] = _dd102

	// Tam Lin (Genma, Lv 6)
	var/datum/demon_data/_dd103 = new /datum/demon_data()
	_dd103.demon_name = "Tam Lin"
	_dd103.demon_race = "Genma"
	_dd103.demon_lvl = 6
	_dd103.demon_str = 9
	_dd103.demon_for = 2
	_dd103.demon_end = 5
	_dd103.demon_spd = 6
	_dd103.demon_off = 5
	_dd103.demon_def = 3
	_dd103.demon_skills = list("Anger Hit")
	_dd103.demon_unique = TRUE
	DEMON_DB["Tam Lin"] = _dd103

	// Jambavan (Genma, Lv 13)
	var/datum/demon_data/_dd104 = new /datum/demon_data()
	_dd104.demon_name = "Jambavan"
	_dd104.demon_race = "Genma"
	_dd104.demon_lvl = 13
	_dd104.demon_str = 11
	_dd104.demon_for = 4
	_dd104.demon_end = 10
	_dd104.demon_spd = 4
	_dd104.demon_off = 6
	_dd104.demon_def = 5
	_dd104.demon_skills = list("Agi")
	_dd104.demon_unique = FALSE
	DEMON_DB["Jambavan"] = _dd104

	// Ictinike (Genma, Lv 21)
	var/datum/demon_data/_dd105 = new /datum/demon_data()
	_dd105.demon_name = "Ictinike"
	_dd105.demon_race = "Genma"
	_dd105.demon_lvl = 21
	_dd105.demon_str = 12
	_dd105.demon_for = 10
	_dd105.demon_end = 6
	_dd105.demon_spd = 9
	_dd105.demon_off = 6
	_dd105.demon_def = 3
	_dd105.demon_skills = list("Elec Dance")
	_dd105.demon_unique = FALSE
	_dd105.demon_icon = 'Icons/DevilSummoner/Ictinike.dmi'
	DEMON_DB["Ictinike"] = _dd105

	// Tlaloc (Genma, Lv 28)
	var/datum/demon_data/_dd106 = new /datum/demon_data()
	_dd106.demon_name = "Tlaloc"
	_dd106.demon_race = "Genma"
	_dd106.demon_lvl = 28
	_dd106.demon_str = 14
	_dd106.demon_for = 14
	_dd106.demon_end = 8
	_dd106.demon_spd = 8
	_dd106.demon_off = 7
	_dd106.demon_def = 4
	_dd106.demon_skills = list("Maragi")
	_dd106.demon_unique = FALSE
	DEMON_DB["Tlaloc"] = _dd106

	// Hanuman (Genma, Lv 33)
	var/datum/demon_data/_dd107 = new /datum/demon_data()
	_dd107.demon_name = "Hanuman"
	_dd107.demon_race = "Genma"
	_dd107.demon_lvl = 33
	_dd107.demon_str = 13
	_dd107.demon_for = 9
	_dd107.demon_end = 10
	_dd107.demon_spd = 17
	_dd107.demon_off = 7
	_dd107.demon_def = 5
	_dd107.demon_skills = list("Berserk")
	_dd107.demon_unique = FALSE
	DEMON_DB["Hanuman"] = _dd107

	// Cu Chulainn (Genma, Lv 37)
	var/datum/demon_data/_dd108 = new /datum/demon_data()
	_dd108.demon_name = "Cu Chulainn"
	_dd108.demon_race = "Genma"
	_dd108.demon_lvl = 37
	_dd108.demon_str = 21
	_dd108.demon_for = 9
	_dd108.demon_end = 12
	_dd108.demon_spd = 11
	_dd108.demon_off = 11
	_dd108.demon_def = 6
	_dd108.demon_skills = list("Mazio")
	_dd108.demon_unique = TRUE
	_dd108.demon_icon = 'Icons/DevilSummoner/Cu Chulainn.dmi'
	DEMON_DB["Cu Chulainn"] = _dd108

	// Kama (Genma, Lv 42)
	var/datum/demon_data/_dd109 = new /datum/demon_data()
	_dd109.demon_name = "Kama"
	_dd109.demon_race = "Genma"
	_dd109.demon_lvl = 42
	_dd109.demon_str = 14
	_dd109.demon_for = 18
	_dd109.demon_end = 11
	_dd109.demon_spd = 15
	_dd109.demon_off = 7
	_dd109.demon_def = 6
	_dd109.demon_skills = list("Marin Karin")
	_dd109.demon_unique = TRUE
	DEMON_DB["Kama"] = _dd109

	// Kresnik (Genma, Lv 46)
	var/datum/demon_data/_dd110 = new /datum/demon_data()
	_dd110.demon_name = "Kresnik"
	_dd110.demon_race = "Genma"
	_dd110.demon_lvl = 46
	_dd110.demon_str = 23
	_dd110.demon_for = 14
	_dd110.demon_end = 11
	_dd110.demon_spd = 14
	_dd110.demon_off = 12
	_dd110.demon_def = 6
	_dd110.demon_skills = list("Agidyne")
	_dd110.demon_unique = TRUE
	DEMON_DB["Kresnik"] = _dd110

	// Kangiten (Genma, Lv 54)
	var/datum/demon_data/_dd111 = new /datum/demon_data()
	_dd111.demon_name = "Kangiten"
	_dd111.demon_race = "Genma"
	_dd111.demon_lvl = 54
	_dd111.demon_str = 20
	_dd111.demon_for = 22
	_dd111.demon_end = 14
	_dd111.demon_spd = 14
	_dd111.demon_off = 10
	_dd111.demon_def = 7
	_dd111.demon_skills = list("Mediarahan")
	_dd111.demon_unique = TRUE
	DEMON_DB["Kangiten"] = _dd111

	// Ganesha (Genma, Lv 61)
	var/datum/demon_data/_dd112 = new /datum/demon_data()
	_dd112.demon_name = "Ganesha"
	_dd112.demon_race = "Genma"
	_dd112.demon_lvl = 61
	_dd112.demon_str = 26
	_dd112.demon_for = 21
	_dd112.demon_end = 26
	_dd112.demon_spd = 4
	_dd112.demon_off = 13
	_dd112.demon_def = 13
	_dd112.demon_skills = list("Deathbound")
	_dd112.demon_unique = FALSE
	DEMON_DB["Ganesha"] = _dd112

	// Jarilo (Genma, Lv 68)
	var/datum/demon_data/_dd113 = new /datum/demon_data()
	_dd113.demon_name = "Jarilo"
	_dd113.demon_race = "Genma"
	_dd113.demon_lvl = 68
	_dd113.demon_str = 20
	_dd113.demon_for = 21
	_dd113.demon_end = 16
	_dd113.demon_spd = 27
	_dd113.demon_off = 10
	_dd113.demon_def = 8
	_dd113.demon_skills = list("Holy Strike")
	_dd113.demon_unique = TRUE
	DEMON_DB["Jarilo"] = _dd113

	// Heimdall (Genma, Lv 75)
	var/datum/demon_data/_dd114 = new /datum/demon_data()
	_dd114.demon_name = "Heimdall"
	_dd114.demon_race = "Genma"
	_dd114.demon_lvl = 75
	_dd114.demon_str = 24
	_dd114.demon_for = 22
	_dd114.demon_end = 18
	_dd114.demon_spd = 27
	_dd114.demon_off = 12
	_dd114.demon_def = 9
	_dd114.demon_skills = list("Taunt")
	_dd114.demon_unique = TRUE
	DEMON_DB["Heimdall"] = _dd114

	// Poltergeist (Ghost, Lv 1)
	var/datum/demon_data/_dd115 = new /datum/demon_data()
	_dd115.demon_name = "Poltergeist"
	_dd115.demon_race = "Ghost"
	_dd115.demon_lvl = 1
	_dd115.demon_str = 4
	_dd115.demon_for = 5
	_dd115.demon_end = 4
	_dd115.demon_spd = 4
	_dd115.demon_off = 2
	_dd115.demon_def = 2
	_dd115.demon_skills = list("Agi")
	_dd115.demon_unique = FALSE
	_dd115.demon_icon = 'Icons/DevilSummoner/Poltergeist.dmi'
	DEMON_DB["Poltergeist"] = _dd115

	// Agathion (Ghost, Lv 6)
	var/datum/demon_data/_dd116 = new /datum/demon_data()
	_dd116.demon_name = "Agathion"
	_dd116.demon_race = "Ghost"
	_dd116.demon_lvl = 6
	_dd116.demon_str = 5
	_dd116.demon_for = 7
	_dd116.demon_end = 5
	_dd116.demon_spd = 5
	_dd116.demon_off = 3
	_dd116.demon_def = 3
	_dd116.demon_skills = list("Agi")
	_dd116.demon_unique = FALSE
	_dd116.demon_icon = 'Icons/DevilSummoner/Agathion.dmi'
	DEMON_DB["Agathion"] = _dd116

	// Tenong Cut (Ghost, Lv 16)
	var/datum/demon_data/_dd117 = new /datum/demon_data()
	_dd117.demon_name = "Tenong Cut"
	_dd117.demon_race = "Ghost"
	_dd117.demon_lvl = 16
	_dd117.demon_str = 7
	_dd117.demon_for = 10
	_dd117.demon_end = 10
	_dd117.demon_spd = 5
	_dd117.demon_off = 4
	_dd117.demon_def = 5
	_dd117.demon_skills = list("Berserk")
	_dd117.demon_unique = FALSE
	_dd117.demon_icon = 'Icons/DevilSummoner/Tenong Cut.dmi'
	DEMON_DB["Tenong Cut"] = _dd117

	// Kumbhanda (Ghost, Lv 25)
	var/datum/demon_data/_dd118 = new /datum/demon_data()
	_dd118.demon_name = "Kumbhanda"
	_dd118.demon_race = "Ghost"
	_dd118.demon_lvl = 25
	_dd118.demon_str = 11
	_dd118.demon_for = 10
	_dd118.demon_end = 7
	_dd118.demon_spd = 13
	_dd118.demon_off = 6
	_dd118.demon_def = 4
	_dd118.demon_skills = list("Assassinate")
	_dd118.demon_unique = FALSE
	DEMON_DB["Kumbhanda"] = _dd118

	// Loa (Ghost, Lv 34)
	var/datum/demon_data/_dd119 = new /datum/demon_data()
	_dd119.demon_name = "Loa"
	_dd119.demon_race = "Ghost"
	_dd119.demon_lvl = 34
	_dd119.demon_str = 12
	_dd119.demon_for = 18
	_dd119.demon_end = 13
	_dd119.demon_spd = 7
	_dd119.demon_off = 6
	_dd119.demon_def = 7
	_dd119.demon_skills = list("Extra Cancel")
	_dd119.demon_unique = FALSE
	_dd119.demon_icon = 'Icons/DevilSummoner/Loa.dmi'
	DEMON_DB["Loa"] = _dd119

	// Pisaca (Ghost, Lv 41)
	var/datum/demon_data/_dd120 = new /datum/demon_data()
	_dd120.demon_name = "Pisaca"
	_dd120.demon_race = "Ghost"
	_dd120.demon_lvl = 41
	_dd120.demon_str = 12
	_dd120.demon_for = 13
	_dd120.demon_end = 22
	_dd120.demon_spd = 10
	_dd120.demon_off = 6
	_dd120.demon_def = 11
	_dd120.demon_skills = list("Desperation")
	_dd120.demon_unique = FALSE
	DEMON_DB["Pisaca"] = _dd120

	// Kudlak (Ghost, Lv 50)
	var/datum/demon_data/_dd121 = new /datum/demon_data()
	_dd121.demon_name = "Kudlak"
	_dd121.demon_race = "Ghost"
	_dd121.demon_lvl = 50
	_dd121.demon_str = 20
	_dd121.demon_for = 12
	_dd121.demon_end = 18
	_dd121.demon_spd = 16
	_dd121.demon_off = 10
	_dd121.demon_def = 9
	_dd121.demon_skills = list("Bufudyne")
	_dd121.demon_unique = TRUE
	_dd121.demon_icon = 'Icons/DevilSummoner/Kudlak.dmi'
	DEMON_DB["Kudlak"] = _dd121

	// Purple Mirror (Ghost, Lv 61)
	var/datum/demon_data/_dd122 = new /datum/demon_data()
	_dd122.demon_name = "Purple Mirror"
	_dd122.demon_race = "Ghost"
	_dd122.demon_lvl = 61
	_dd122.demon_str = 16
	_dd122.demon_for = 26
	_dd122.demon_end = 22
	_dd122.demon_spd = 13
	_dd122.demon_off = 8
	_dd122.demon_def = 11
	_dd122.demon_skills = list("Judgement")
	_dd122.demon_unique = TRUE
	DEMON_DB["Purple Mirror"] = _dd122

	// Neko Shogun (Hero, Lv 31)
	var/datum/demon_data/_dd123 = new /datum/demon_data()
	_dd123.demon_name = "Neko Shogun"
	_dd123.demon_race = "Hero"
	_dd123.demon_lvl = 31
	_dd123.demon_str = 11
	_dd123.demon_for = 17
	_dd123.demon_end = 8
	_dd123.demon_spd = 11
	_dd123.demon_off = 6
	_dd123.demon_def = 4
	_dd123.demon_skills = list("Mow Down")
	_dd123.demon_unique = TRUE
	_dd123.demon_icon = 'Icons/DevilSummoner/Neko Shogun.dmi'
	DEMON_DB["Neko Shogun"] = _dd123

	// Hagen (Hero, Lv 39)
	var/datum/demon_data/_dd124 = new /datum/demon_data()
	_dd124.demon_name = "Hagen"
	_dd124.demon_race = "Hero"
	_dd124.demon_lvl = 39
	_dd124.demon_str = 18
	_dd124.demon_for = 10
	_dd124.demon_end = 14
	_dd124.demon_spd = 13
	_dd124.demon_off = 9
	_dd124.demon_def = 7
	_dd124.demon_skills = list("Assassinate")
	_dd124.demon_unique = TRUE
	DEMON_DB["Hagen"] = _dd124

	// Jeanne D'Arc (Hero, Lv 50)
	var/datum/demon_data/_dd125 = new /datum/demon_data()
	_dd125.demon_name = "Jeanne D'Arc"
	_dd125.demon_race = "Hero"
	_dd125.demon_lvl = 50
	_dd125.demon_str = 23
	_dd125.demon_for = 12
	_dd125.demon_end = 18
	_dd125.demon_spd = 13
	_dd125.demon_off = 12
	_dd125.demon_def = 9
	_dd125.demon_skills = list("Hassohappa")
	_dd125.demon_unique = TRUE
	DEMON_DB["Jeanne D'Arc"] = _dd125

	// Yoshitsune (Hero, Lv 57)
	var/datum/demon_data/_dd126 = new /datum/demon_data()
	_dd126.demon_name = "Yoshitsune"
	_dd126.demon_race = "Hero"
	_dd126.demon_lvl = 57
	_dd126.demon_str = 22
	_dd126.demon_for = 16
	_dd126.demon_end = 12
	_dd126.demon_spd = 23
	_dd126.demon_off = 11
	_dd126.demon_def = 6
	_dd126.demon_skills = list("Hassohappa")
	_dd126.demon_unique = TRUE
	DEMON_DB["Yoshitsune"] = _dd126

	// Guan Yu (Hero, Lv 70)
	var/datum/demon_data/_dd127 = new /datum/demon_data()
	_dd127.demon_name = "Guan Yu"
	_dd127.demon_race = "Hero"
	_dd127.demon_lvl = 70
	_dd127.demon_str = 25
	_dd127.demon_for = 26
	_dd127.demon_end = 22
	_dd127.demon_spd = 13
	_dd127.demon_off = 13
	_dd127.demon_def = 11
	_dd127.demon_skills = list("Holy Strike")
	_dd127.demon_unique = TRUE
	DEMON_DB["Guan Yu"] = _dd127

	// Masakado (Hero, Lv 82)
	var/datum/demon_data/_dd128 = new /datum/demon_data()
	_dd128.demon_name = "Masakado"
	_dd128.demon_race = "Hero"
	_dd128.demon_lvl = 82
	_dd128.demon_str = 26
	_dd128.demon_for = 24
	_dd128.demon_end = 24
	_dd128.demon_spd = 24
	_dd128.demon_off = 13
	_dd128.demon_def = 12
	_dd128.demon_skills = list("None")
	_dd128.demon_unique = TRUE
	DEMON_DB["Masakado"] = _dd128

	// Obariyon (Jaki, Lv 3)
	var/datum/demon_data/_dd129 = new /datum/demon_data()
	_dd129.demon_name = "Obariyon"
	_dd129.demon_race = "Jaki"
	_dd129.demon_lvl = 3
	_dd129.demon_str = 6
	_dd129.demon_for = 4
	_dd129.demon_end = 5
	_dd129.demon_spd = 4
	_dd129.demon_off = 3
	_dd129.demon_def = 3
	_dd129.demon_skills = list("Dia")
	_dd129.demon_unique = FALSE
	_dd129.demon_icon = 'Icons/DevilSummoner/Obariyon.dmi'
	DEMON_DB["Obariyon"] = _dd129

	// Ogre (Jaki, Lv 8)
	var/datum/demon_data/_dd130 = new /datum/demon_data()
	_dd130.demon_name = "Ogre"
	_dd130.demon_race = "Jaki"
	_dd130.demon_lvl = 8
	_dd130.demon_str = 10
	_dd130.demon_for = 5
	_dd130.demon_end = 6
	_dd130.demon_spd = 3
	_dd130.demon_off = 5
	_dd130.demon_def = 3
	_dd130.demon_skills = list("Anger Hit")
	_dd130.demon_unique = FALSE
	DEMON_DB["Ogre"] = _dd130

	// Mokoi (Jaki, Lv 15)
	var/datum/demon_data/_dd131 = new /datum/demon_data()
	_dd131.demon_name = "Mokoi"
	_dd131.demon_race = "Jaki"
	_dd131.demon_lvl = 15
	_dd131.demon_str = 9
	_dd131.demon_for = 7
	_dd131.demon_end = 9
	_dd131.demon_spd = 6
	_dd131.demon_off = 5
	_dd131.demon_def = 5
	_dd131.demon_skills = list("Berserk")
	_dd131.demon_unique = FALSE
	DEMON_DB["Mokoi"] = _dd131

	// Ogun (Jaki, Lv 23)
	var/datum/demon_data/_dd132 = new /datum/demon_data()
	_dd132.demon_name = "Ogun"
	_dd132.demon_race = "Jaki"
	_dd132.demon_lvl = 23
	_dd132.demon_str = 15
	_dd132.demon_for = 6
	_dd132.demon_end = 9
	_dd132.demon_spd = 9
	_dd132.demon_off = 8
	_dd132.demon_def = 5
	_dd132.demon_skills = list("Brutal Hit")
	_dd132.demon_unique = FALSE
	DEMON_DB["Ogun"] = _dd132

	// Wendigo (Jaki, Lv 31)
	var/datum/demon_data/_dd133 = new /datum/demon_data()
	_dd133.demon_name = "Wendigo"
	_dd133.demon_race = "Jaki"
	_dd133.demon_lvl = 31
	_dd133.demon_str = 15
	_dd133.demon_for = 7
	_dd133.demon_end = 12
	_dd133.demon_spd = 13
	_dd133.demon_off = 8
	_dd133.demon_def = 6
	_dd133.demon_skills = list("Brutal Hit")
	_dd133.demon_unique = FALSE
	_dd133.demon_icon = 'Icons/DevilSummoner/Wendigo.dmi'
	DEMON_DB["Wendigo"] = _dd133

	// Legion (Jaki, Lv 39)
	var/datum/demon_data/_dd134 = new /datum/demon_data()
	_dd134.demon_name = "Legion"
	_dd134.demon_race = "Jaki"
	_dd134.demon_lvl = 39
	_dd134.demon_str = 10
	_dd134.demon_for = 17
	_dd134.demon_end = 19
	_dd134.demon_spd = 9
	_dd134.demon_off = 5
	_dd134.demon_def = 10
	_dd134.demon_skills = list("Bufudyne")
	_dd134.demon_unique = FALSE
	_dd134.demon_icon = 'Icons/DevilSummoner/Legion.dmi'
	DEMON_DB["Legion"] = _dd134

	// Girimehkala (Jaki, Lv 47)
	var/datum/demon_data/_dd135 = new /datum/demon_data()
	_dd135.demon_name = "Girimehkala"
	_dd135.demon_race = "Jaki"
	_dd135.demon_lvl = 47
	_dd135.demon_str = 20
	_dd135.demon_for = 14
	_dd135.demon_end = 19
	_dd135.demon_spd = 10
	_dd135.demon_off = 10
	_dd135.demon_def = 10
	_dd135.demon_skills = list("Bufudyne")
	_dd135.demon_unique = FALSE
	DEMON_DB["Girimehkala"] = _dd135

	// Rakshasa (Jaki, Lv 55)
	var/datum/demon_data/_dd136 = new /datum/demon_data()
	_dd136.demon_name = "Rakshasa"
	_dd136.demon_race = "Jaki"
	_dd136.demon_lvl = 55
	_dd136.demon_str = 23
	_dd136.demon_for = 12
	_dd136.demon_end = 16
	_dd136.demon_spd = 20
	_dd136.demon_off = 12
	_dd136.demon_def = 8
	_dd136.demon_skills = list("Deathbound")
	_dd136.demon_unique = FALSE
	_dd136.demon_icon = 'Icons/DevilSummoner/Rakshasa.dmi'
	DEMON_DB["Rakshasa"] = _dd136

	// Grendel (Jaki, Lv 64)
	var/datum/demon_data/_dd137 = new /datum/demon_data()
	_dd137.demon_name = "Grendel"
	_dd137.demon_race = "Jaki"
	_dd137.demon_lvl = 64
	_dd137.demon_str = 27
	_dd137.demon_for = 14
	_dd137.demon_end = 23
	_dd137.demon_spd = 16
	_dd137.demon_off = 14
	_dd137.demon_def = 12
	_dd137.demon_skills = list("Tetrakarn")
	_dd137.demon_unique = TRUE
	DEMON_DB["Grendel"] = _dd137

	// Black Frost (Jaki, Lv 80)
	var/datum/demon_data/_dd138 = new /datum/demon_data()
	_dd138.demon_name = "Black Frost"
	_dd138.demon_race = "Jaki"
	_dd138.demon_lvl = 80
	_dd138.demon_str = 27
	_dd138.demon_for = 27
	_dd138.demon_end = 22
	_dd138.demon_spd = 20
	_dd138.demon_off = 14
	_dd138.demon_def = 11
	_dd138.demon_skills = list("Mabufudyne")
	_dd138.demon_unique = TRUE
	_dd138.demon_icon = 'Icons/DevilSummoner/Black Frost.dmi'
	DEMON_DB["Black Frost"] = _dd138

	// Ubelluris (Kishin, Lv 20)
	var/datum/demon_data/_dd139 = new /datum/demon_data()
	_dd139.demon_name = "Ubelluris"
	_dd139.demon_race = "Kishin"
	_dd139.demon_lvl = 20
	_dd139.demon_str = 14
	_dd139.demon_for = 4
	_dd139.demon_end = 12
	_dd139.demon_spd = 6
	_dd139.demon_off = 7
	_dd139.demon_def = 6
	_dd139.demon_skills = list("Berserk")
	_dd139.demon_unique = FALSE
	DEMON_DB["Ubelluris"] = _dd139

	// Nalagiri (Kishin, Lv 28)
	var/datum/demon_data/_dd140 = new /datum/demon_data()
	_dd140.demon_name = "Nalagiri"
	_dd140.demon_race = "Kishin"
	_dd140.demon_lvl = 28
	_dd140.demon_str = 14
	_dd140.demon_for = 7
	_dd140.demon_end = 14
	_dd140.demon_spd = 9
	_dd140.demon_off = 7
	_dd140.demon_def = 7
	_dd140.demon_skills = list("Power Hit")
	_dd140.demon_unique = FALSE
	DEMON_DB["Nalagiri"] = _dd140

	// Hitokotonusi (Kishin, Lv 36)
	var/datum/demon_data/_dd141 = new /datum/demon_data()
	_dd141.demon_name = "Hitokotonusi"
	_dd141.demon_race = "Kishin"
	_dd141.demon_lvl = 36
	_dd141.demon_str = 17
	_dd141.demon_for = 8
	_dd141.demon_end = 15
	_dd141.demon_spd = 12
	_dd141.demon_off = 9
	_dd141.demon_def = 8
	_dd141.demon_skills = list("Might Call")
	_dd141.demon_unique = TRUE
	_dd141.demon_icon = 'Icons/DevilSummoner/Hitokotonusi.dmi'
	DEMON_DB["Hitokotonusi"] = _dd141

	// Take-Mikazuchi (Kishin, Lv 43)
	var/datum/demon_data/_dd142 = new /datum/demon_data()
	_dd142.demon_name = "Take-Mikazuchi"
	_dd142.demon_race = "Kishin"
	_dd142.demon_lvl = 43
	_dd142.demon_str = 23
	_dd142.demon_for = 10
	_dd142.demon_end = 15
	_dd142.demon_spd = 11
	_dd142.demon_off = 12
	_dd142.demon_def = 8
	_dd142.demon_skills = list("Mazio")
	_dd142.demon_unique = TRUE
	_dd142.demon_icon = 'Icons/DevilSummoner/Take-Mikazuchi.dmi'
	DEMON_DB["Take-Mikazuchi"] = _dd142

	// Zouchouten (Kishin, Lv 50)
	var/datum/demon_data/_dd143 = new /datum/demon_data()
	_dd143.demon_name = "Zouchouten"
	_dd143.demon_race = "Kishin"
	_dd143.demon_lvl = 50
	_dd143.demon_str = 22
	_dd143.demon_for = 15
	_dd143.demon_end = 17
	_dd143.demon_spd = 12
	_dd143.demon_off = 11
	_dd143.demon_def = 9
	_dd143.demon_skills = list("Agidyne")
	_dd143.demon_unique = TRUE
	_dd143.demon_icon = 'Icons/DevilSummoner/Zouchouten.dmi'
	DEMON_DB["Zouchouten"] = _dd143

	// Jikokuten (Kishin, Lv 57)
	var/datum/demon_data/_dd144 = new /datum/demon_data()
	_dd144.demon_name = "Jikokuten"
	_dd144.demon_race = "Kishin"
	_dd144.demon_lvl = 57
	_dd144.demon_str = 24
	_dd144.demon_for = 16
	_dd144.demon_end = 22
	_dd144.demon_spd = 11
	_dd144.demon_off = 12
	_dd144.demon_def = 11
	_dd144.demon_skills = list("Ziodyne")
	_dd144.demon_unique = TRUE
	_dd144.demon_icon = 'Icons/DevilSummoner/Jikokuten.dmi'
	DEMON_DB["Jikokuten"] = _dd144

	// Koumoukuten (Kishin, Lv 64)
	var/datum/demon_data/_dd145 = new /datum/demon_data()
	_dd145.demon_name = "Koumoukuten"
	_dd145.demon_race = "Kishin"
	_dd145.demon_lvl = 64
	_dd145.demon_str = 25
	_dd145.demon_for = 17
	_dd145.demon_end = 23
	_dd145.demon_spd = 15
	_dd145.demon_off = 13
	_dd145.demon_def = 12
	_dd145.demon_skills = list("Mazandyne")
	_dd145.demon_unique = TRUE
	_dd145.demon_icon = 'Icons/DevilSummoner/Koumokuten.dmi'
	DEMON_DB["Koumoukuten"] = _dd145

	// Bishamonten (Kishin, Lv 71)
	var/datum/demon_data/_dd146 = new /datum/demon_data()
	_dd146.demon_name = "Bishamonten"
	_dd146.demon_race = "Kishin"
	_dd146.demon_lvl = 71
	_dd146.demon_str = 29
	_dd146.demon_for = 15
	_dd146.demon_end = 26
	_dd146.demon_spd = 17
	_dd146.demon_off = 15
	_dd146.demon_def = 13
	_dd146.demon_skills = list("Hassohappa")
	_dd146.demon_unique = TRUE
	_dd146.demon_icon = 'Icons/DevilSummoner/Bishamonten.dmi'
	DEMON_DB["Bishamonten"] = _dd146

	// Ometeotl (Kishin, Lv 75)
	var/datum/demon_data/_dd147 = new /datum/demon_data()
	_dd147.demon_name = "Ometeotl"
	_dd147.demon_race = "Kishin"
	_dd147.demon_lvl = 75
	_dd147.demon_str = 28
	_dd147.demon_for = 28
	_dd147.demon_end = 20
	_dd147.demon_spd = 15
	_dd147.demon_off = 14
	_dd147.demon_def = 10
	_dd147.demon_skills = list("None")
	_dd147.demon_unique = TRUE
	DEMON_DB["Ometeotl"] = _dd147

	// Zaou-Gongen (Kishin, Lv 93)
	var/datum/demon_data/_dd148 = new /datum/demon_data()
	_dd148.demon_name = "Zaou-Gongen"
	_dd148.demon_race = "Kishin"
	_dd148.demon_lvl = 93
	_dd148.demon_str = 28
	_dd148.demon_for = 31
	_dd148.demon_end = 24
	_dd148.demon_spd = 26
	_dd148.demon_off = 14
	_dd148.demon_def = 12
	_dd148.demon_skills = list("None")
	_dd148.demon_unique = TRUE
	DEMON_DB["Zaou-Gongen"] = _dd148

	// Sarasvati (Megami, Lv 19)
	var/datum/demon_data/_dd149 = new /datum/demon_data()
	_dd149.demon_name = "Sarasvati"
	_dd149.demon_race = "Megami"
	_dd149.demon_lvl = 19
	_dd149.demon_str = 6
	_dd149.demon_for = 14
	_dd149.demon_end = 8
	_dd149.demon_spd = 7
	_dd149.demon_off = 3
	_dd149.demon_def = 4
	_dd149.demon_skills = list("Diarama")
	_dd149.demon_unique = FALSE
	DEMON_DB["Sarasvati"] = _dd149

	// Kikuri-Hime (Megami, Lv 27)
	var/datum/demon_data/_dd150 = new /datum/demon_data()
	_dd150.demon_name = "Kikuri-Hime"
	_dd150.demon_race = "Megami"
	_dd150.demon_lvl = 27
	_dd150.demon_str = 9
	_dd150.demon_for = 15
	_dd150.demon_end = 12
	_dd150.demon_spd = 7
	_dd150.demon_off = 5
	_dd150.demon_def = 6
	_dd150.demon_skills = list("Media")
	_dd150.demon_unique = FALSE
	DEMON_DB["Kikuri-Hime"] = _dd150

	// Hathor (Megami, Lv 31)
	var/datum/demon_data/_dd151 = new /datum/demon_data()
	_dd151.demon_name = "Hathor"
	_dd151.demon_race = "Megami"
	_dd151.demon_lvl = 31
	_dd151.demon_str = 10
	_dd151.demon_for = 18
	_dd151.demon_end = 9
	_dd151.demon_spd = 10
	_dd151.demon_off = 5
	_dd151.demon_def = 5
	_dd151.demon_skills = list("Recarm")
	_dd151.demon_unique = TRUE
	DEMON_DB["Hathor"] = _dd151

	// Brigid (Megami, Lv 35)
	var/datum/demon_data/_dd152 = new /datum/demon_data()
	_dd152.demon_name = "Brigid"
	_dd152.demon_race = "Megami"
	_dd152.demon_lvl = 35
	_dd152.demon_str = 10
	_dd152.demon_for = 18
	_dd152.demon_end = 10
	_dd152.demon_spd = 13
	_dd152.demon_off = 5
	_dd152.demon_def = 5
	_dd152.demon_skills = list("Media")
	_dd152.demon_unique = FALSE
	_dd152.demon_icon = 'Icons/DevilSummoner/Brigid.dmi'
	DEMON_DB["Brigid"] = _dd152

	// Scathach (Megami, Lv 43)
	var/datum/demon_data/_dd153 = new /datum/demon_data()
	_dd153.demon_name = "Scathach"
	_dd153.demon_race = "Megami"
	_dd153.demon_lvl = 43
	_dd153.demon_str = 18
	_dd153.demon_for = 19
	_dd153.demon_end = 11
	_dd153.demon_spd = 11
	_dd153.demon_off = 9
	_dd153.demon_def = 6
	_dd153.demon_skills = list("Recarm")
	_dd153.demon_unique = TRUE
	_dd153.demon_icon = 'Icons/DevilSummoner/Scathach.dmi'
	DEMON_DB["Scathach"] = _dd153

	// Laksmi (Megami, Lv 51)
	var/datum/demon_data/_dd154 = new /datum/demon_data()
	_dd154.demon_name = "Laksmi"
	_dd154.demon_race = "Megami"
	_dd154.demon_lvl = 51
	_dd154.demon_str = 14
	_dd154.demon_for = 22
	_dd154.demon_end = 15
	_dd154.demon_spd = 16
	_dd154.demon_off = 7
	_dd154.demon_def = 8
	_dd154.demon_skills = list("Mediarahan")
	_dd154.demon_unique = FALSE
	_dd154.demon_icon = 'Icons/DevilSummoner/Laksmi.dmi'
	DEMON_DB["Laksmi"] = _dd154

	// Isis (Megami, Lv 55)
	var/datum/demon_data/_dd155 = new /datum/demon_data()
	_dd155.demon_name = "Isis"
	_dd155.demon_race = "Megami"
	_dd155.demon_lvl = 55
	_dd155.demon_str = 16
	_dd155.demon_for = 27
	_dd155.demon_end = 15
	_dd155.demon_spd = 13
	_dd155.demon_off = 8
	_dd155.demon_def = 8
	_dd155.demon_skills = list("Mediarahan")
	_dd155.demon_unique = TRUE
	DEMON_DB["Isis"] = _dd155

	// Parvati (Megami, Lv 59)
	var/datum/demon_data/_dd156 = new /datum/demon_data()
	_dd156.demon_name = "Parvati"
	_dd156.demon_race = "Megami"
	_dd156.demon_lvl = 59
	_dd156.demon_str = 12
	_dd156.demon_for = 27
	_dd156.demon_end = 20
	_dd156.demon_spd = 16
	_dd156.demon_off = 6
	_dd156.demon_def = 10
	_dd156.demon_skills = list("Mediarahan")
	_dd156.demon_unique = TRUE
	DEMON_DB["Parvati"] = _dd156

	// Norn (Megami, Lv 64)
	var/datum/demon_data/_dd157 = new /datum/demon_data()
	_dd157.demon_name = "Norn"
	_dd157.demon_race = "Megami"
	_dd157.demon_lvl = 64
	_dd157.demon_str = 19
	_dd157.demon_for = 25
	_dd157.demon_end = 16
	_dd157.demon_spd = 20
	_dd157.demon_off = 10
	_dd157.demon_def = 8
	_dd157.demon_skills = list("Prayer")
	_dd157.demon_unique = TRUE
	_dd157.demon_icon = 'Icons/DevilSummoner/Norn.dmi'
	DEMON_DB["Norn"] = _dd157

	// Pallas Athena (Megami, Lv 69)
	var/datum/demon_data/_dd158 = new /datum/demon_data()
	_dd158.demon_name = "Pallas Athena"
	_dd158.demon_race = "Megami"
	_dd158.demon_lvl = 69
	_dd158.demon_str = 25
	_dd158.demon_for = 20
	_dd158.demon_end = 24
	_dd158.demon_spd = 16
	_dd158.demon_off = 13
	_dd158.demon_def = 12
	_dd158.demon_skills = list("Prayer")
	_dd158.demon_unique = TRUE
	DEMON_DB["Pallas Athena"] = _dd158

	// Amaterasu (Megami, Lv 77)
	var/datum/demon_data/_dd159 = new /datum/demon_data()
	_dd159.demon_name = "Amaterasu"
	_dd159.demon_race = "Megami"
	_dd159.demon_lvl = 77
	_dd159.demon_str = 22
	_dd159.demon_for = 31
	_dd159.demon_end = 21
	_dd159.demon_spd = 19
	_dd159.demon_off = 11
	_dd159.demon_def = 11
	_dd159.demon_skills = list("Prayer")
	_dd159.demon_unique = TRUE
	DEMON_DB["Amaterasu"] = _dd159

	// Saki Mitama (Mitama, Lv 35)
	var/datum/demon_data/_dd160 = new /datum/demon_data()
	_dd160.demon_name = "Saki Mitama"
	_dd160.demon_race = "Mitama"
	_dd160.demon_lvl = 35
	_dd160.demon_str = 10
	_dd160.demon_for = 10
	_dd160.demon_end = 21
	_dd160.demon_spd = 10
	_dd160.demon_off = 5
	_dd160.demon_def = 11
	_dd160.demon_skills = list("None")
	_dd160.demon_unique = FALSE
	DEMON_DB["Saki Mitama"] = _dd160

	// Kusi Mitama (Mitama, Lv 40)
	var/datum/demon_data/_dd161 = new /datum/demon_data()
	_dd161.demon_name = "Kusi Mitama"
	_dd161.demon_race = "Mitama"
	_dd161.demon_lvl = 40
	_dd161.demon_str = 11
	_dd161.demon_for = 11
	_dd161.demon_end = 11
	_dd161.demon_spd = 23
	_dd161.demon_off = 6
	_dd161.demon_def = 6
	_dd161.demon_skills = list("None")
	_dd161.demon_unique = FALSE
	DEMON_DB["Kusi Mitama"] = _dd161

	// Ara Mitama (Mitama, Lv 45)
	var/datum/demon_data/_dd162 = new /datum/demon_data()
	_dd162.demon_name = "Ara Mitama"
	_dd162.demon_race = "Mitama"
	_dd162.demon_lvl = 45
	_dd162.demon_str = 22
	_dd162.demon_for = 13
	_dd162.demon_end = 13
	_dd162.demon_spd = 13
	_dd162.demon_off = 11
	_dd162.demon_def = 7
	_dd162.demon_skills = list("None")
	_dd162.demon_unique = FALSE
	DEMON_DB["Ara Mitama"] = _dd162

	// Nigi Mitama (Mitama, Lv 49)
	var/datum/demon_data/_dd163 = new /datum/demon_data()
	_dd163.demon_name = "Nigi Mitama"
	_dd163.demon_race = "Mitama"
	_dd163.demon_lvl = 49
	_dd163.demon_str = 14
	_dd163.demon_for = 23
	_dd163.demon_end = 14
	_dd163.demon_spd = 14
	_dd163.demon_off = 7
	_dd163.demon_def = 7
	_dd163.demon_skills = list("None")
	_dd163.demon_unique = FALSE
	DEMON_DB["Nigi Mitama"] = _dd163

	// Tonatiuh (Omega, Lv 34)
	var/datum/demon_data/_dd164 = new /datum/demon_data()
	_dd164.demon_name = "Tonatiuh"
	_dd164.demon_race = "Omega"
	_dd164.demon_lvl = 34
	_dd164.demon_str = 18
	_dd164.demon_for = 9
	_dd164.demon_end = 12
	_dd164.demon_spd = 11
	_dd164.demon_off = 9
	_dd164.demon_def = 6
	_dd164.demon_skills = list("Might Call")
	_dd164.demon_unique = TRUE
	DEMON_DB["Tonatiuh"] = _dd164

	// Chernobog (Omega, Lv 43)
	var/datum/demon_data/_dd165 = new /datum/demon_data()
	_dd165.demon_name = "Chernobog"
	_dd165.demon_race = "Omega"
	_dd165.demon_lvl = 43
	_dd165.demon_str = 20
	_dd165.demon_for = 14
	_dd165.demon_end = 15
	_dd165.demon_spd = 10
	_dd165.demon_off = 10
	_dd165.demon_def = 8
	_dd165.demon_skills = list("Gigajama")
	_dd165.demon_unique = TRUE
	DEMON_DB["Chernobog"] = _dd165

	// Wu Kong (Omega, Lv 52)
	var/datum/demon_data/_dd166 = new /datum/demon_data()
	_dd166.demon_name = "Wu Kong"
	_dd166.demon_race = "Omega"
	_dd166.demon_lvl = 52
	_dd166.demon_str = 23
	_dd166.demon_for = 10
	_dd166.demon_end = 14
	_dd166.demon_spd = 21
	_dd166.demon_off = 12
	_dd166.demon_def = 7
	_dd166.demon_skills = list("Multi-Strike")
	_dd166.demon_unique = TRUE
	DEMON_DB["Wu Kong"] = _dd166

	// Kartikeya (Omega, Lv 56)
	var/datum/demon_data/_dd167 = new /datum/demon_data()
	_dd167.demon_name = "Kartikeya"
	_dd167.demon_race = "Omega"
	_dd167.demon_lvl = 56
	_dd167.demon_str = 19
	_dd167.demon_for = 15
	_dd167.demon_end = 12
	_dd167.demon_spd = 26
	_dd167.demon_off = 10
	_dd167.demon_def = 6
	_dd167.demon_skills = list("Megido")
	_dd167.demon_unique = TRUE
	DEMON_DB["Kartikeya"] = _dd167

	// Susano-o (Omega, Lv 60)
	var/datum/demon_data/_dd168 = new /datum/demon_data()
	_dd168.demon_name = "Susano-o"
	_dd168.demon_race = "Omega"
	_dd168.demon_lvl = 60
	_dd168.demon_str = 26
	_dd168.demon_for = 19
	_dd168.demon_end = 19
	_dd168.demon_spd = 12
	_dd168.demon_off = 13
	_dd168.demon_def = 10
	_dd168.demon_skills = list("Mazandyne")
	_dd168.demon_unique = TRUE
	DEMON_DB["Susano-o"] = _dd168

	// Beiji-Weng (Omega, Lv 70)
	var/datum/demon_data/_dd169 = new /datum/demon_data()
	_dd169.demon_name = "Beiji-Weng"
	_dd169.demon_race = "Omega"
	_dd169.demon_lvl = 70
	_dd169.demon_str = 28
	_dd169.demon_for = 20
	_dd169.demon_end = 15
	_dd169.demon_spd = 23
	_dd169.demon_off = 14
	_dd169.demon_def = 8
	_dd169.demon_skills = list("Megidolaon")
	_dd169.demon_unique = TRUE
	DEMON_DB["Beiji-Weng"] = _dd169

	// Shiva (Omega, Lv 76)
	var/datum/demon_data/_dd170 = new /datum/demon_data()
	_dd170.demon_name = "Shiva"
	_dd170.demon_race = "Omega"
	_dd170.demon_lvl = 76
	_dd170.demon_str = 25
	_dd170.demon_for = 22
	_dd170.demon_end = 25
	_dd170.demon_spd = 20
	_dd170.demon_off = 13
	_dd170.demon_def = 13
	_dd170.demon_skills = list("None")
	_dd170.demon_unique = TRUE
	_dd170.demon_icon = 'Icons/DevilSummoner/Shiva.dmi'
	DEMON_DB["Shiva"] = _dd170

	// Makara (Snake, Lv 14)
	var/datum/demon_data/_dd171 = new /datum/demon_data()
	_dd171.demon_name = "Makara"
	_dd171.demon_race = "Snake"
	_dd171.demon_lvl = 14
	_dd171.demon_str = 7
	_dd171.demon_for = 8
	_dd171.demon_end = 6
	_dd171.demon_spd = 9
	_dd171.demon_off = 4
	_dd171.demon_def = 3
	_dd171.demon_skills = list("Dia")
	_dd171.demon_unique = FALSE
	DEMON_DB["Makara"] = _dd171

	// Nozuchi (Snake, Lv 23)
	var/datum/demon_data/_dd172 = new /datum/demon_data()
	_dd172.demon_name = "Nozuchi"
	_dd172.demon_race = "Snake"
	_dd172.demon_lvl = 23
	_dd172.demon_str = 13
	_dd172.demon_for = 7
	_dd172.demon_end = 14
	_dd172.demon_spd = 5
	_dd172.demon_off = 7
	_dd172.demon_def = 7
	_dd172.demon_skills = list("Assassinate")
	_dd172.demon_unique = FALSE
	_dd172.demon_icon = 'Icons/DevilSummoner/Nozuchi.dmi'
	DEMON_DB["Nozuchi"] = _dd172

	// Pendragon (Snake, Lv 30)
	var/datum/demon_data/_dd173 = new /datum/demon_data()
	_dd173.demon_name = "Pendragon"
	_dd173.demon_race = "Snake"
	_dd173.demon_lvl = 30
	_dd173.demon_str = 22
	_dd173.demon_for = 7
	_dd173.demon_end = 11
	_dd173.demon_spd = 6
	_dd173.demon_off = 11
	_dd173.demon_def = 6
	_dd173.demon_skills = list("Fatal Strike")
	_dd173.demon_unique = FALSE
	DEMON_DB["Pendragon"] = _dd173

	// Gui Xian (Snake, Lv 38)
	var/datum/demon_data/_dd174 = new /datum/demon_data()
	_dd174.demon_name = "Gui Xian"
	_dd174.demon_race = "Snake"
	_dd174.demon_lvl = 38
	_dd174.demon_str = 12
	_dd174.demon_for = 14
	_dd174.demon_end = 22
	_dd174.demon_spd = 6
	_dd174.demon_off = 6
	_dd174.demon_def = 11
	_dd174.demon_skills = list("Mighty Hit")
	_dd174.demon_unique = FALSE
	DEMON_DB["Gui Xian"] = _dd174

	// Quetzalcoatl (Snake, Lv 44)
	var/datum/demon_data/_dd175 = new /datum/demon_data()
	_dd175.demon_name = "Quetzalcoatl"
	_dd175.demon_race = "Snake"
	_dd175.demon_lvl = 44
	_dd175.demon_str = 16
	_dd175.demon_for = 10
	_dd175.demon_end = 27
	_dd175.demon_spd = 7
	_dd175.demon_off = 8
	_dd175.demon_def = 14
	_dd175.demon_skills = list("Mabufu")
	_dd175.demon_unique = FALSE
	DEMON_DB["Quetzalcoatl"] = _dd175

	// Seiryuu (Snake, Lv 51)
	var/datum/demon_data/_dd176 = new /datum/demon_data()
	_dd176.demon_name = "Seiryuu"
	_dd176.demon_race = "Snake"
	_dd176.demon_lvl = 51
	_dd176.demon_str = 21
	_dd176.demon_for = 13
	_dd176.demon_end = 15
	_dd176.demon_spd = 18
	_dd176.demon_off = 11
	_dd176.demon_def = 8
	_dd176.demon_skills = list("Deathbound")
	_dd176.demon_unique = FALSE
	DEMON_DB["Seiryuu"] = _dd176

	// Gucumatz (Snake, Lv 58)
	var/datum/demon_data/_dd177 = new /datum/demon_data()
	_dd177.demon_name = "Gucumatz"
	_dd177.demon_race = "Snake"
	_dd177.demon_lvl = 58
	_dd177.demon_str = 20
	_dd177.demon_for = 13
	_dd177.demon_end = 22
	_dd177.demon_spd = 19
	_dd177.demon_off = 10
	_dd177.demon_def = 11
	_dd177.demon_skills = list("Shield All")
	_dd177.demon_unique = FALSE
	DEMON_DB["Gucumatz"] = _dd177

	// Orochi (Snake, Lv 66)
	var/datum/demon_data/_dd178 = new /datum/demon_data()
	_dd178.demon_name = "Orochi"
	_dd178.demon_race = "Snake"
	_dd178.demon_lvl = 66
	_dd178.demon_str = 30
	_dd178.demon_for = 13
	_dd178.demon_end = 26
	_dd178.demon_spd = 13
	_dd178.demon_off = 15
	_dd178.demon_def = 13
	_dd178.demon_skills = list("Hassohappa")
	_dd178.demon_unique = FALSE
	_dd178.demon_icon = 'Icons/DevilSummoner/Yamata no Orochi.dmi'
	DEMON_DB["Orochi"] = _dd178

	// Ananta (Snake, Lv 72)
	var/datum/demon_data/_dd179 = new /datum/demon_data()
	_dd179.demon_name = "Ananta"
	_dd179.demon_race = "Snake"
	_dd179.demon_lvl = 72
	_dd179.demon_str = 31
	_dd179.demon_for = 18
	_dd179.demon_end = 26
	_dd179.demon_spd = 13
	_dd179.demon_off = 16
	_dd179.demon_def = 13
	_dd179.demon_skills = list("Makarakarn")
	_dd179.demon_unique = FALSE
	DEMON_DB["Ananta"] = _dd179

	// Hoyau Kamui (Snake, Lv 80)
	var/datum/demon_data/_dd180 = new /datum/demon_data()
	_dd180.demon_name = "Hoyau Kamui"
	_dd180.demon_race = "Snake"
	_dd180.demon_lvl = 80
	_dd180.demon_str = 29
	_dd180.demon_for = 19
	_dd180.demon_end = 26
	_dd180.demon_spd = 22
	_dd180.demon_off = 15
	_dd180.demon_def = 13
	_dd180.demon_skills = list("None")
	_dd180.demon_unique = TRUE
	DEMON_DB["Hoyau Kamui"] = _dd180

	// Kobold (Touki, Lv 3)
	var/datum/demon_data/_dd181 = new /datum/demon_data()
	_dd181.demon_name = "Kobold"
	_dd181.demon_race = "Touki"
	_dd181.demon_lvl = 3
	_dd181.demon_str = 4
	_dd181.demon_for = 3
	_dd181.demon_end = 5
	_dd181.demon_spd = 7
	_dd181.demon_off = 2
	_dd181.demon_def = 3
	_dd181.demon_skills = list("Anger Hit")
	_dd181.demon_unique = FALSE
	_dd181.demon_icon = 'Icons/DevilSummoner/Kobold.dmi'
	DEMON_DB["Kobold"] = _dd181

	// Bilwis (Touki, Lv 10)
	var/datum/demon_data/_dd182 = new /datum/demon_data()
	_dd182.demon_name = "Bilwis"
	_dd182.demon_race = "Touki"
	_dd182.demon_lvl = 10
	_dd182.demon_str = 8
	_dd182.demon_for = 4
	_dd182.demon_end = 7
	_dd182.demon_spd = 7
	_dd182.demon_off = 4
	_dd182.demon_def = 4
	_dd182.demon_skills = list("Fatal Strike")
	_dd182.demon_unique = FALSE
	_dd182.demon_icon = 'Icons/DevilSummoner/Bilwis.dmi'
	DEMON_DB["Bilwis"] = _dd182

	// Gozuki (Touki, Lv 18)
	var/datum/demon_data/_dd183 = new /datum/demon_data()
	_dd183.demon_name = "Gozuki"
	_dd183.demon_race = "Touki"
	_dd183.demon_lvl = 18
	_dd183.demon_str = 13
	_dd183.demon_for = 4
	_dd183.demon_end = 11
	_dd183.demon_spd = 6
	_dd183.demon_off = 7
	_dd183.demon_def = 6
	_dd183.demon_skills = list("Berserk")
	_dd183.demon_unique = FALSE
	DEMON_DB["Gozuki"] = _dd183

	// Mezuki (Touki, Lv 25)
	var/datum/demon_data/_dd184 = new /datum/demon_data()
	_dd184.demon_name = "Mezuki"
	_dd184.demon_race = "Touki"
	_dd184.demon_lvl = 25
	_dd184.demon_str = 11
	_dd184.demon_for = 12
	_dd184.demon_end = 9
	_dd184.demon_spd = 9
	_dd184.demon_off = 6
	_dd184.demon_def = 5
	_dd184.demon_skills = list("Mazio")
	_dd184.demon_unique = FALSE
	DEMON_DB["Mezuki"] = _dd184

	// Ikusa (Touki, Lv 33)
	var/datum/demon_data/_dd185 = new /datum/demon_data()
	_dd185.demon_name = "Ikusa"
	_dd185.demon_race = "Touki"
	_dd185.demon_lvl = 33
	_dd185.demon_str = 17
	_dd185.demon_for = 12
	_dd185.demon_end = 11
	_dd185.demon_spd = 9
	_dd185.demon_off = 9
	_dd185.demon_def = 6
	_dd185.demon_skills = list("Assassinate")
	_dd185.demon_unique = FALSE
	_dd185.demon_icon = 'Icons/DevilSummoner/Ikusa.dmi'
	DEMON_DB["Ikusa"] = _dd185

	// Berserker (Touki, Lv 38)
	var/datum/demon_data/_dd186 = new /datum/demon_data()
	_dd186.demon_name = "Berserker"
	_dd186.demon_race = "Touki"
	_dd186.demon_lvl = 38
	_dd186.demon_str = 25
	_dd186.demon_for = 5
	_dd186.demon_end = 15
	_dd186.demon_spd = 9
	_dd186.demon_off = 13
	_dd186.demon_def = 8
	_dd186.demon_skills = list("None")
	_dd186.demon_unique = TRUE
	DEMON_DB["Berserker"] = _dd186

	// Lham Dearg (Touki, Lv 43)
	var/datum/demon_data/_dd187 = new /datum/demon_data()
	_dd187.demon_name = "Lham Dearg"
	_dd187.demon_race = "Touki"
	_dd187.demon_lvl = 43
	_dd187.demon_str = 21
	_dd187.demon_for = 9
	_dd187.demon_end = 18
	_dd187.demon_spd = 11
	_dd187.demon_off = 11
	_dd187.demon_def = 9
	_dd187.demon_skills = list("Mighty Hit")
	_dd187.demon_unique = FALSE
	DEMON_DB["Lham Dearg"] = _dd187

	// Yaksa (Touki, Lv 51)
	var/datum/demon_data/_dd188 = new /datum/demon_data()
	_dd188.demon_name = "Yaksa"
	_dd188.demon_race = "Touki"
	_dd188.demon_lvl = 51
	_dd188.demon_str = 24
	_dd188.demon_for = 11
	_dd188.demon_end = 14
	_dd188.demon_spd = 18
	_dd188.demon_off = 12
	_dd188.demon_def = 7
	_dd188.demon_skills = list("Deathbound")
	_dd188.demon_unique = FALSE
	_dd188.demon_icon = 'Icons/DevilSummoner/Yaksa.dmi'
	DEMON_DB["Yaksa"] = _dd188

	// Nata Taishi (Touki, Lv 59)
	var/datum/demon_data/_dd189 = new /datum/demon_data()
	_dd189.demon_name = "Nata Taishi"
	_dd189.demon_race = "Touki"
	_dd189.demon_lvl = 59
	_dd189.demon_str = 22
	_dd189.demon_for = 16
	_dd189.demon_end = 17
	_dd189.demon_spd = 20
	_dd189.demon_off = 11
	_dd189.demon_def = 9
	_dd189.demon_skills = list("Deathbound")
	_dd189.demon_unique = TRUE
	DEMON_DB["Nata Taishi"] = _dd189

	// Oumitsunu (Touki, Lv 67)
	var/datum/demon_data/_dd190 = new /datum/demon_data()
	_dd190.demon_name = "Oumitsunu"
	_dd190.demon_race = "Touki"
	_dd190.demon_lvl = 67
	_dd190.demon_str = 32
	_dd190.demon_for = 6
	_dd190.demon_end = 29
	_dd190.demon_spd = 16
	_dd190.demon_off = 16
	_dd190.demon_def = 15
	_dd190.demon_skills = list("None")
	_dd190.demon_unique = TRUE
	DEMON_DB["Oumitsunu"] = _dd190

	// King Frost (Tyrant, Lv 26)
	var/datum/demon_data/_dd191 = new /datum/demon_data()
	_dd191.demon_name = "King Frost"
	_dd191.demon_race = "Tyrant"
	_dd191.demon_lvl = 26
	_dd191.demon_str = 14
	_dd191.demon_for = 11
	_dd191.demon_end = 10
	_dd191.demon_spd = 7
	_dd191.demon_off = 7
	_dd191.demon_def = 5
	_dd191.demon_skills = list("Mabufu")
	_dd191.demon_unique = TRUE
	DEMON_DB["King Frost"] = _dd191

	// Moloch (Tyrant, Lv 33)
	var/datum/demon_data/_dd192 = new /datum/demon_data()
	_dd192.demon_name = "Moloch"
	_dd192.demon_race = "Tyrant"
	_dd192.demon_lvl = 33
	_dd192.demon_str = 19
	_dd192.demon_for = 12
	_dd192.demon_end = 10
	_dd192.demon_spd = 8
	_dd192.demon_off = 10
	_dd192.demon_def = 5
	_dd192.demon_skills = list("None")
	_dd192.demon_unique = TRUE
	DEMON_DB["Moloch"] = _dd192

	// Balor (Tyrant, Lv 40)
	var/datum/demon_data/_dd193 = new /datum/demon_data()
	_dd193.demon_name = "Balor"
	_dd193.demon_race = "Tyrant"
	_dd193.demon_lvl = 40
	_dd193.demon_str = 16
	_dd193.demon_for = 19
	_dd193.demon_end = 11
	_dd193.demon_spd = 10
	_dd193.demon_off = 8
	_dd193.demon_def = 6
	_dd193.demon_skills = list("Death Call")
	_dd193.demon_unique = TRUE
	DEMON_DB["Balor"] = _dd193

	// Hecate (Tyrant, Lv 47)
	var/datum/demon_data/_dd194 = new /datum/demon_data()
	_dd194.demon_name = "Hecate"
	_dd194.demon_race = "Tyrant"
	_dd194.demon_lvl = 47
	_dd194.demon_str = 15
	_dd194.demon_for = 24
	_dd194.demon_end = 12
	_dd194.demon_spd = 12
	_dd194.demon_off = 8
	_dd194.demon_def = 6
	_dd194.demon_skills = list("Diarahan")
	_dd194.demon_unique = TRUE
	DEMON_DB["Hecate"] = _dd194

	// Tzitzimitl (Tyrant, Lv 54)
	var/datum/demon_data/_dd195 = new /datum/demon_data()
	_dd195.demon_name = "Tzitzimitl"
	_dd195.demon_race = "Tyrant"
	_dd195.demon_lvl = 54
	_dd195.demon_str = 20
	_dd195.demon_for = 25
	_dd195.demon_end = 15
	_dd195.demon_spd = 10
	_dd195.demon_off = 10
	_dd195.demon_def = 8
	_dd195.demon_skills = list("Maziodyne")
	_dd195.demon_unique = TRUE
	DEMON_DB["Tzitzimitl"] = _dd195

	// Loki (Tyrant, Lv 61)
	var/datum/demon_data/_dd196 = new /datum/demon_data()
	_dd196.demon_name = "Loki"
	_dd196.demon_race = "Tyrant"
	_dd196.demon_lvl = 61
	_dd196.demon_str = 17
	_dd196.demon_for = 23
	_dd196.demon_end = 22
	_dd196.demon_spd = 15
	_dd196.demon_off = 9
	_dd196.demon_def = 11
	_dd196.demon_skills = list("Megidolaon")
	_dd196.demon_unique = TRUE
	_dd196.demon_icon = 'Icons/DevilSummoner/Loki.dmi'
	DEMON_DB["Loki"] = _dd196

	// Mot (Tyrant, Lv 68)
	var/datum/demon_data/_dd197 = new /datum/demon_data()
	_dd197.demon_name = "Mot"
	_dd197.demon_race = "Tyrant"
	_dd197.demon_lvl = 68
	_dd197.demon_str = 20
	_dd197.demon_for = 31
	_dd197.demon_end = 25
	_dd197.demon_spd = 8
	_dd197.demon_off = 10
	_dd197.demon_def = 13
	_dd197.demon_skills = list("None")
	_dd197.demon_unique = TRUE
	DEMON_DB["Mot"] = _dd197

	// Astaroth (Tyrant, Lv 75)
	var/datum/demon_data/_dd198 = new /datum/demon_data()
	_dd198.demon_name = "Astaroth"
	_dd198.demon_race = "Tyrant"
	_dd198.demon_lvl = 75
	_dd198.demon_str = 32
	_dd198.demon_for = 25
	_dd198.demon_end = 15
	_dd198.demon_spd = 19
	_dd198.demon_off = 16
	_dd198.demon_def = 8
	_dd198.demon_skills = list("Deathbound")
	_dd198.demon_unique = TRUE
	DEMON_DB["Astaroth"] = _dd198

	// Nergal (Tyrant, Lv 81)
	var/datum/demon_data/_dd199 = new /datum/demon_data()
	_dd199.demon_name = "Nergal"
	_dd199.demon_race = "Tyrant"
	_dd199.demon_lvl = 81
	_dd199.demon_str = 26
	_dd199.demon_for = 28
	_dd199.demon_end = 20
	_dd199.demon_spd = 23
	_dd199.demon_off = 13
	_dd199.demon_def = 10
	_dd199.demon_skills = list("None")
	_dd199.demon_unique = TRUE
	DEMON_DB["Nergal"] = _dd199

	// Belial (Tyrant, Lv 86)
	var/datum/demon_data/_dd200 = new /datum/demon_data()
	_dd200.demon_name = "Belial"
	_dd200.demon_race = "Tyrant"
	_dd200.demon_lvl = 86
	_dd200.demon_str = 30
	_dd200.demon_for = 24
	_dd200.demon_end = 29
	_dd200.demon_spd = 19
	_dd200.demon_off = 15
	_dd200.demon_def = 15
	_dd200.demon_skills = list("None")
	_dd200.demon_unique = TRUE
	_dd200.demon_icon = 'Icons/DevilSummoner/Belial.dmi'
	DEMON_DB["Belial"] = _dd200

	// Beelzebub (Tyrant, Lv 91)
	var/datum/demon_data/_dd201 = new /datum/demon_data()
	_dd201.demon_name = "Beelzebub"
	_dd201.demon_race = "Tyrant"
	_dd201.demon_lvl = 91
	_dd201.demon_str = 33
	_dd201.demon_for = 26
	_dd201.demon_end = 22
	_dd201.demon_spd = 26
	_dd201.demon_off = 17
	_dd201.demon_def = 11
	_dd201.demon_skills = list("None")
	_dd201.demon_unique = TRUE
	_dd201.demon_icon = 'Icons/DevilSummoner/Beelzebub.dmi'
	DEMON_DB["Beelzebub"] = _dd201

	// Lucifer (Tyrant, Lv 99)
	var/datum/demon_data/_dd202 = new /datum/demon_data()
	_dd202.demon_name = "Lucifer"
	_dd202.demon_race = "Tyrant"
	_dd202.demon_lvl = 99
	_dd202.demon_str = 29
	_dd202.demon_for = 30
	_dd202.demon_end = 28
	_dd202.demon_spd = 28
	_dd202.demon_off = 15
	_dd202.demon_def = 14
	_dd202.demon_skills = list("None")
	_dd202.demon_unique = TRUE
	_dd202.demon_icon = 'Icons/DevilSummoner/Lucifer.dmi'
	DEMON_DB["Lucifer"] = _dd202

	// Orcus (Vile, Lv 23)
	var/datum/demon_data/_dd203 = new /datum/demon_data()
	_dd203.demon_name = "Orcus"
	_dd203.demon_race = "Vile"
	_dd203.demon_lvl = 23
	_dd203.demon_str = 18
	_dd203.demon_for = 3
	_dd203.demon_end = 12
	_dd203.demon_spd = 6
	_dd203.demon_off = 9
	_dd203.demon_def = 6
	_dd203.demon_skills = list("Brutal Hit")
	_dd203.demon_unique = FALSE
	DEMON_DB["Orcus"] = _dd203

	// Baphomet (Vile, Lv 32)
	var/datum/demon_data/_dd204 = new /datum/demon_data()
	_dd204.demon_name = "Baphomet"
	_dd204.demon_race = "Vile"
	_dd204.demon_lvl = 32
	_dd204.demon_str = 9
	_dd204.demon_for = 18
	_dd204.demon_end = 9
	_dd204.demon_spd = 12
	_dd204.demon_off = 5
	_dd204.demon_def = 5
	_dd204.demon_skills = list("Drain")
	_dd204.demon_unique = FALSE
	DEMON_DB["Baphomet"] = _dd204

	// Pazuzu (Vile, Lv 40)
	var/datum/demon_data/_dd205 = new /datum/demon_data()
	_dd205.demon_name = "Pazuzu"
	_dd205.demon_race = "Vile"
	_dd205.demon_lvl = 40
	_dd205.demon_str = 13
	_dd205.demon_for = 17
	_dd205.demon_end = 17
	_dd205.demon_spd = 9
	_dd205.demon_off = 7
	_dd205.demon_def = 9
	_dd205.demon_skills = list("Holy Dance")
	_dd205.demon_unique = TRUE
	_dd205.demon_icon = 'Icons/DevilSummoner/Pazuzu.dmi'
	DEMON_DB["Pazuzu"] = _dd205

	// Abaddon (Vile, Lv 48)
	var/datum/demon_data/_dd206 = new /datum/demon_data()
	_dd206.demon_name = "Abaddon"
	_dd206.demon_race = "Vile"
	_dd206.demon_lvl = 48
	_dd206.demon_str = 17
	_dd206.demon_for = 18
	_dd206.demon_end = 17
	_dd206.demon_spd = 12
	_dd206.demon_off = 9
	_dd206.demon_def = 9
	_dd206.demon_skills = list("Bufudyne")
	_dd206.demon_unique = FALSE
	_dd206.demon_icon = 'Icons/DevilSummoner/Abaddon.dmi'
	DEMON_DB["Abaddon"] = _dd206

	// Arioch (Vile, Lv 56)
	var/datum/demon_data/_dd207 = new /datum/demon_data()
	_dd207.demon_name = "Arioch"
	_dd207.demon_race = "Vile"
	_dd207.demon_lvl = 56
	_dd207.demon_str = 24
	_dd207.demon_for = 14
	_dd207.demon_end = 18
	_dd207.demon_spd = 16
	_dd207.demon_off = 12
	_dd207.demon_def = 9
	_dd207.demon_skills = list("Deathbound")
	_dd207.demon_unique = TRUE
	_dd207.demon_icon = 'Icons/DevilSummoner/Arioch.dmi'
	DEMON_DB["Arioch"] = _dd207

	// Tao Tie (Vile, Lv 62)
	var/datum/demon_data/_dd208 = new /datum/demon_data()
	_dd208.demon_name = "Tao Tie"
	_dd208.demon_race = "Vile"
	_dd208.demon_lvl = 62
	_dd208.demon_str = 20
	_dd208.demon_for = 27
	_dd208.demon_end = 16
	_dd208.demon_spd = 15
	_dd208.demon_off = 10
	_dd208.demon_def = 8
	_dd208.demon_skills = list("Megidolaon")
	_dd208.demon_unique = TRUE
	DEMON_DB["Tao Tie"] = _dd208

	// Tezcatlipoca (Vile, Lv 68)
	var/datum/demon_data/_dd209 = new /datum/demon_data()
	_dd209.demon_name = "Tezcatlipoca"
	_dd209.demon_race = "Vile"
	_dd209.demon_lvl = 68
	_dd209.demon_str = 26
	_dd209.demon_for = 25
	_dd209.demon_end = 19
	_dd209.demon_spd = 14
	_dd209.demon_off = 13
	_dd209.demon_def = 10
	_dd209.demon_skills = list("Gigajama")
	_dd209.demon_unique = TRUE
	DEMON_DB["Tezcatlipoca"] = _dd209

	// Nyarlathotep (Vile, Lv 80)
	var/datum/demon_data/_dd210 = new /datum/demon_data()
	_dd210.demon_name = "Nyarlathotep"
	_dd210.demon_race = "Vile"
	_dd210.demon_lvl = 80
	_dd210.demon_str = 30
	_dd210.demon_for = 22
	_dd210.demon_end = 19
	_dd210.demon_spd = 25
	_dd210.demon_off = 15
	_dd210.demon_def = 10
	_dd210.demon_skills = list("None")
	_dd210.demon_unique = TRUE
	DEMON_DB["Nyarlathotep"] = _dd210

	// Hare of Inaba (Wilder, Lv 9)
	var/datum/demon_data/_dd211 = new /datum/demon_data()
	_dd211.demon_name = "Hare of Inaba"
	_dd211.demon_race = "Wilder"
	_dd211.demon_lvl = 9
	_dd211.demon_str = 5
	_dd211.demon_for = 6
	_dd211.demon_end = 5
	_dd211.demon_spd = 9
	_dd211.demon_off = 3
	_dd211.demon_def = 3
	_dd211.demon_skills = list("Amrita")
	_dd211.demon_unique = FALSE
	_dd211.demon_icon = 'Icons/DevilSummoner/Hare of Inaba.dmi'
	DEMON_DB["Hare of Inaba"] = _dd211

	// Waira (Wilder, Lv 17)
	var/datum/demon_data/_dd212 = new /datum/demon_data()
	_dd212.demon_name = "Waira"
	_dd212.demon_race = "Wilder"
	_dd212.demon_lvl = 17
	_dd212.demon_str = 9
	_dd212.demon_for = 10
	_dd212.demon_end = 6
	_dd212.demon_spd = 8
	_dd212.demon_off = 5
	_dd212.demon_def = 3
	_dd212.demon_skills = list("Berserk")
	_dd212.demon_unique = FALSE
	_dd212.demon_icon = 'Icons/DevilSummoner/Waira.dmi'
	DEMON_DB["Waira"] = _dd212

	// Garm (Wilder, Lv 25)
	var/datum/demon_data/_dd213 = new /datum/demon_data()
	_dd213.demon_name = "Garm"
	_dd213.demon_race = "Wilder"
	_dd213.demon_lvl = 25
	_dd213.demon_str = 15
	_dd213.demon_for = 5
	_dd213.demon_end = 10
	_dd213.demon_spd = 11
	_dd213.demon_off = 8
	_dd213.demon_def = 5
	_dd213.demon_skills = list("Berserk")
	_dd213.demon_unique = FALSE
	DEMON_DB["Garm"] = _dd213

	// Afanc (Wilder, Lv 33)
	var/datum/demon_data/_dd214 = new /datum/demon_data()
	_dd214.demon_name = "Afanc"
	_dd214.demon_race = "Wilder"
	_dd214.demon_lvl = 33
	_dd214.demon_str = 13
	_dd214.demon_for = 8
	_dd214.demon_end = 14
	_dd214.demon_spd = 14
	_dd214.demon_off = 7
	_dd214.demon_def = 7
	_dd214.demon_skills = list("Mighty Hit")
	_dd214.demon_unique = FALSE
	DEMON_DB["Afanc"] = _dd214

	// Xiezhai (Wilder, Lv 37)
	var/datum/demon_data/_dd215 = new /datum/demon_data()
	_dd215.demon_name = "Xiezhai"
	_dd215.demon_race = "Wilder"
	_dd215.demon_lvl = 37
	_dd215.demon_str = 7
	_dd215.demon_for = 22
	_dd215.demon_end = 11
	_dd215.demon_spd = 13
	_dd215.demon_off = 4
	_dd215.demon_def = 6
	_dd215.demon_skills = list("Nigayomogi")
	_dd215.demon_unique = TRUE
	DEMON_DB["Xiezhai"] = _dd215

	// Mothman (Wilder, Lv 43)
	var/datum/demon_data/_dd216 = new /datum/demon_data()
	_dd216.demon_name = "Mothman"
	_dd216.demon_race = "Wilder"
	_dd216.demon_lvl = 43
	_dd216.demon_str = 14
	_dd216.demon_for = 21
	_dd216.demon_end = 17
	_dd216.demon_spd = 7
	_dd216.demon_off = 7
	_dd216.demon_def = 9
	_dd216.demon_skills = list("Mazan")
	_dd216.demon_unique = FALSE
	_dd216.demon_icon = 'Icons/DevilSummoner/Mothman.dmi'
	DEMON_DB["Mothman"] = _dd216

	// Taown (Wilder, Lv 50)
	var/datum/demon_data/_dd217 = new /datum/demon_data()
	_dd217.demon_name = "Taown"
	_dd217.demon_race = "Wilder"
	_dd217.demon_lvl = 50
	_dd217.demon_str = 22
	_dd217.demon_for = 17
	_dd217.demon_end = 11
	_dd217.demon_spd = 16
	_dd217.demon_off = 11
	_dd217.demon_def = 6
	_dd217.demon_skills = list("Death Call")
	_dd217.demon_unique = FALSE
	DEMON_DB["Taown"] = _dd217

	// Sleipnir (Wilder, Lv 57)
	var/datum/demon_data/_dd218 = new /datum/demon_data()
	_dd218.demon_name = "Sleipnir"
	_dd218.demon_race = "Wilder"
	_dd218.demon_lvl = 57
	_dd218.demon_str = 21
	_dd218.demon_for = 12
	_dd218.demon_end = 16
	_dd218.demon_spd = 24
	_dd218.demon_off = 11
	_dd218.demon_def = 8
	_dd218.demon_skills = list("None")
	_dd218.demon_unique = FALSE
	DEMON_DB["Sleipnir"] = _dd218

	// Behemoth (Wilder, Lv 65)
	var/datum/demon_data/_dd219 = new /datum/demon_data()
	_dd219.demon_name = "Behemoth"
	_dd219.demon_race = "Wilder"
	_dd219.demon_lvl = 65
	_dd219.demon_str = 33
	_dd219.demon_for = 10
	_dd219.demon_end = 29
	_dd219.demon_spd = 9
	_dd219.demon_off = 17
	_dd219.demon_def = 15
	_dd219.demon_skills = list("Deathbound")
	_dd219.demon_unique = FALSE
	DEMON_DB["Behemoth"] = _dd219

	// Ammut (Wilder, Lv 73)
	var/datum/demon_data/_dd220 = new /datum/demon_data()
	_dd220.demon_name = "Ammut"
	_dd220.demon_race = "Wilder"
	_dd220.demon_lvl = 73
	_dd220.demon_str = 32
	_dd220.demon_for = 16
	_dd220.demon_end = 26
	_dd220.demon_spd = 15
	_dd220.demon_off = 16
	_dd220.demon_def = 13
	_dd220.demon_skills = list("Deathbound")
	_dd220.demon_unique = TRUE
	DEMON_DB["Ammut"] = _dd220
