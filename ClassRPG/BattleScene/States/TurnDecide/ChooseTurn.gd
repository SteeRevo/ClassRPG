extends States

var current_selected_enemy


func enter(host):
	if host.start_of_battle:
		start_battle(host)
	host.current_turn = choose_turn(host)

func start_battle(host):
	host.start_of_battle = false
	print(host.name)
	set_all_units_position(host)
	print(host.BGF._get_current_unit())
	current_selected_enemy = null
	print(host.player_units)
	print(host.enemy_units)
	get_all_units(host)
	
func get_all_units(host):
	for unit in host.player_units_path.get_children():
		host.player_units.append(unit)
		host.unit_list.append(unit)
	for unit in host.enemy_units_path.get_children():
		host.enemy_units.append(unit)
		host.unit_list.append(unit)

func set_all_units_position(host):
	for bg in host.battleGrounds.get_children():
		host.bgs.append(bg)
	for bg in host.enemybattleGrounds.get_children():
		host.enemy_bgs.append(bg)
	for unit in host.player_units_path.get_children():
		host.bgs[unit.startingBG]._set_current_unit(unit)
		unit._set_BG(host.bgs[unit.startingBG])
	for unit in host.enemy_units_path.get_children():
		host.enemy_bgs[unit.startingBG]._set_current_unit(unit)
		unit._set_BG(host.enemy_bgs[unit.startingBG])
		
	print(host.enemy_bgs)

func choose_turn(host):
	for unit in host.player_units:
		if unit.available == true:
			host.current_unit = null
			return 'selectAlly'
	for unit in host.enemy_units:
		if unit.available == true:
			host.current_unit = unit
			return 'enemyturn'

func calc_turn_advance(host):
	var turn_advance = host.current_unit._get_turn_order()
	host.current_unit._set_turn_order(0)
	for unit in host.player_units:
		unit._set_turn_order(unit._get_turn_order() - turn_advance)
		print()
	for unit in host.enemy_units:
		unit._set_turn_order(unit._get_turn_order() - turn_advance)
		

