extends States

var current_selected_enemy

func enter(host):
	print(host.name)
	set_all_units_position(host)
	print(host.BGV._get_current_unit())
	current_selected_enemy = null
	host.get_all_units()
	print(host.player_units)
	print(host.enemy_units)
	set_current_unit(host)

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
	set_current_unit(host)

func calc_turn_advance(host):
	var turn_advance = host.current_unit._get_turn_order()
	host.current_unit._set_turn_order(0)
	for unit in host.player_units:
		unit._set_turn_order(unit._get_turn_order() - turn_advance)
		print()
	for unit in host.enemy_units:
		unit._set_turn_order(unit._get_turn_order() - turn_advance)
		
	
func set_current_unit(host):
	if host.player_units[0]._get_turn_order() <= host.enemy_units[0]._get_turn_order():
		host.current_unit = host.player_units[0]
		calc_turn_advance(host)
		host._change_state('playerturn')
		host.battleState = BATTLESTATE.PLAYER_TURN_START
		on_player_turn_started()
	else:
		current_unit = enemy_units[0]
		calc_turn_advance(host)
		host._change_state('enemyturn')
		host.battleState = BATTLESTATE.ENEMY_TURN
		start_enemy_turn()
