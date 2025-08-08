extends States

var current_selected_enemy
var waiting = true

func enter(host):
	host.stateName.set_state_name("Choose turn")
	set_active_camera(host, host.mainBattleCamera)
	host.current_unit = null
	for unit in host.player_units:
		if unit.is_guarding == false:
			print(unit.name)
			unit.play_idle()
	for unit in host.enemy_units:
		if unit.is_guarding == false:
			print(unit.name)
			unit.play_battle_idle()
	host.start_turn_tracker()


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
