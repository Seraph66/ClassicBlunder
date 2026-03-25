/obj/Skills/Buffs/SlotlessBuffs/Autonomous/Racial/Nobody/Lunar_Wrath
    passives = list("Unrelenting Wrath" = 1, "Godspeed" = 1, "Skimming" = 1)
    TextColor=rgb(255, 0, 0)
    Cooldown=-1
    ActiveMessage="unleashes the anger they keep locked in a cage!"
    OffMessage="calms their yasai rage..."

    adjust(mob/p)

/obj/Skills/Buffs/SlotlessBuffs/Racial
	Void_Blade
		MakesSword=1
		SpecialSlot=0
		Slotless=1
		SwordName="Void Blade"
		SwordIcon='KATANA SILVER.dmi'
		SwordX=-8
		SwordY=-4
		SwordElement="Void"
		verb/Transfigure_Void_Blade()
			set category="Utility"
			var/Choice
			if(!usr.BuffOn(src))
				var/modify_sword_num = 1
				if((locate(/obj/Skills/Buffs/NuStyle/SwordStyle/Nito_Ichi_Style) in src) || (locate(/obj/Skills/Buffs/NuStyle/SwordStyle/Santoryu) in src))
					var/list/options = list("Primary","Secondary")
					if((locate(/obj/Skills/Buffs/NuStyle/SwordStyle/Santoryu) in src)) options += "Tertiary"
					switch(input("Which sword would you like to modify?") in options)
						if("Secondary") modify_sword_num=2
						if("Tertiary") modify_sword_num=3
				var/Lock=alert(usr, "Do you wish to alter the icon used?", "Weapon Icon", "No", "Yes")
				if(Lock=="Yes")
					switch(modify_sword_num)
						if(1)
							src.SwordIcon=input(usr, "What icon will your Void Blade use?", "Void Blade Icon") as icon|null
							src.SwordX=input(usr, "Pixel X offset.", "Void Blade Icon") as num
							src.SwordY=input(usr, "Pixel Y offset.", "Void Blade Icon") as num
						if(2)
							src.SwordIconSecond=input(usr, "What icon will your Void Blade use?", "Void Blade Icon") as icon|null
							src.SwordXSecond=input(usr, "Pixel X offset.", "Void Blade Icon") as num
							src.SwordYSecond=input(usr, "Pixel Y offset.", "Void Blade Icon") as num
						if(3)
							src.SwordIconThird=input(usr, "What icon will your Void Blade use?", "Void Blade Icon") as icon|null
							src.SwordXThird=input(usr, "Pixel X offset.", "Void Blade Icon") as num
							src.SwordYThird=input(usr, "Pixel Y offset.", "Void Blade Icon") as num
				Choice=input(usr, "What class of blade do you want your Void Blade to be?", "Transfigure Void Blade") in list("Blunt", "Saber", "Longsword", "Greatsword")
				switch(Choice)
					if("Blunt")
						switch(modify_sword_num)
							if(1) src.SwordClass="Wooden"
							if(2) src.SwordClassSecond="Wooden"
							if(3) src.SwordClassThird="Wooden"
					if("Saber")
						switch(modify_sword_num)
							if(1) src.SwordClass="Light"
							if(2) src.SwordClassSecond="Light"
							if(3) src.SwordClassThird="Light"
					if("Longsword")
						switch(modify_sword_num)
							if(1) src.SwordClass="Medium"
							if(2) src.SwordClassSecond="Medium"
							if(3) src.SwordClassThird="Medium"
					if("Greatsword")
						switch(modify_sword_num)
							if(1) src.SwordClass="Heavy"
							if(2) src.SwordClassSecond="Heavy"
							if(3) src.SwordClassThird="Heavy"
				usr << "Void Blade class set as [Choice]!"
			else
				usr << "You can't set this while using Void Blade."
		verb/Void_Blade()
			set category="Skills"
			adjust(usr)
			src.Trigger(usr)