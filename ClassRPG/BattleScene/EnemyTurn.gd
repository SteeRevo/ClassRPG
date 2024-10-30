extends States


func enter(host):
	print("============Enemy turn=============")
	host.current_unit.available = false
	host.end_turn()
