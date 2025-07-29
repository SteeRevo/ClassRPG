extends States

var current_selected_enemy
var waiting = true

func enter(host):
	host.stateName.set_state_name("Choose turn")
	
	set_active_camera(host, host.mainBattleCamera)
	host.current_unit = null
	if host.start_of_battle:
		start_battle(host)
	for unit in host.player_units:
		if unit.is_guarding == false:
			print(unit.name)
			unit.play_idle()
	for unit in host.enemy_units:
		if unit.is_guarding == false:
			print(unit.name)
			unit.play_battle_idle()
	host.start_turn_tracker()

func start_battle(host):
	host.start_of_battle = false
	print(host.name)
	get_all_units(host)
	set_all_units_position(host)
	print(host.BGF._get_current_unit())
	current_selected_enemy = null
	print(host.player_units)
	print(host.enemy_units)
	
	
func get_all_units(host):
	host.set_player_turn_tracker()
	for unit in host.player_units_path.get_children():
		host.player_units.append(unit)
		host.unit_list.append(unit)
		host.inputMoves.add_all_active_skills(unit)
		unit.set_all_stats()
	for unit in host.enemy_units_path.get_children():
		host.enemy_units.append(unit)
		host.unit_list.append(unit)
		host.set_enemy_turn_tracker(unit)
		unit.set_all_stats()

func set_all_units_position(host):
	for bg in host.battleGrounds.get_children():
		host.bgs.append(bg)
	for bg in host.enemybattleGrounds.get_children():
		host.enemy_bgs.append(bg)
	for unit in host.player_units_path.get_children():
		print(unit.name)
		print(unit.startingBG)
		host.bgs[unit.startingBG]._set_current_unit(unit)
		host.bgs[unit.startingBG].set_current_unit_position()
		unit._set_BG(host.bgs[unit.startingBG])
	for unit in host.enemy_units_path.get_children():
		host.enemy_bgs[unit.startingBG]._set_current_unit(unit)
		host.enemy_bgs[unit.startingBG].set_current_unit_position()
		unit._set_BG(host.enemy_bgs[unit.startingBG])
		
	print(host.enemy_bgs)

func choose_turn(host):
	if len(host.enemy_units) == 0:
		return 'end_fight'
	for unit in host.player_units:
		if unit.available == true:
			host.current_unit = null
			return 'selectAlly'
	for unit in host.enemy_units:
		if unit.available == true:
			host.current_unit = unit
			return 'enemyturn'
			
func update(host, delta):
	"""if waiting:
		var unit = host.update_turn()
		if unit != null:
			host.current_turn = "playerturn"
			host.choose_turn()"""
	pass

func set_active_camera(host, camera):
	host.active_camera.current = false
	camera.current = true
	host.active_camera = camera
	camera.move_to(host.mainOverviewCam.global_position)
	camera.rotate_to(host.mainOverviewCam.rotation)
