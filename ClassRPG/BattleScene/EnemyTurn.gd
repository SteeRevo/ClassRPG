extends States


func enter(host):
	host.stateName.set_state_name("Enemy Turn")
	print("============Enemy turn=============")
	host.current_unit.available = false
	host.end_turn()
