obj/Skills/Buffs/SlotlessBuffs/Starwalker
	Starwalker
		IconTransform = 'Starwalker.dmi'
		ActiveMessage="will also <font color='FFF200'>join</font color>"
		OffMessage="will no longer <font color='FFF200'>join</font color>"
		verb/The_Original_Starwalker()
			set name="Star                    walker"
			set category="Starwalker"
			if(usr.Target.party)
				if(usr.party)
					usr.party.remove_member(usr)
				usr.Target.party.add_member(usr)
			src.Trigger(usr)