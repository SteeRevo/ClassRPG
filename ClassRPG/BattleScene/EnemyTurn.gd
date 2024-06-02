extends States


func enter(host):
	print("============Enemy turn=============")
	host.enemy_units.erase(host.current_unit)
	host.insert_sort(host.enemy_units, host.current_unit, 30)
	host.end_turn()
