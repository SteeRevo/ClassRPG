extends States

var last_action = null
var cam_look_at = false
var current_cam

func enter(host):
	cam_look_at = false
	host.stateName.set_state_name("Player Turn")
	host.playerTurnUI.visible = true
	print("=====player turn=========")
	print("Current Unit is: " + host.current_unit.name)
	print("Press D to attack, A to Guard, W for Item, S for Rotate.")
	set_active_camera(host, host.mainBattleCamera)
	host.enemySelector.visible = false
	host.current_unit.get_BG().add_buffs()
	host.current_unit.is_guarding = false
	host.current_unit.play_idle()
	print("Health: ", host.current_unit._get_health())
	print("Attack: " , host.current_unit.get_attack())
	print("Defense: ", host.current_unit.get_defense())
	print("Technique: ", host.current_unit.get_technique())
	#host.playerTurnUI.update_health(host.current_unit)
	host.playerTurnUI.play_enter_anim()
	host.inputMoves.add_all_active_skills(host.current_unit)
	
	host.mainBattleCamera.rotate_tween_finished.connect(enable_cam_look_at)
	
	
func update(host, delta):
	
	if cam_look_at:
		current_cam.move_to(host.current_unit.get_camera_path().global_position, 0.5)
		if host.current_unit.name == "Sam":
			current_cam.look_at(host.current_unit.global_position + Vector3(0, 2, 0), Vector3(0, 1, 0))
		else:
			current_cam.look_at(host.current_unit.global_position + Vector3(0, 3, 0), Vector3(0, 1, 0))
	
func handle_input(host, event):
	if event.is_action_pressed("Attack"):
		print("Attack")
		if last_action == "Attack":
			host.current_action = "Attack"
			print("confirm attack") #_on_attack_pressed()
			return 'selectEBG'
		else:
			host.reset_delay()
			host.playerTurnUI.set_arrow_outline(host.current_unit.name, "Right")
			last_action = "Attack"
	elif event.is_action_pressed("Rotate"):
		print("Rotate")
		if last_action == "Rotate":
			host.current_action = "Rotate"
			print("confirm rotate")
			return 'selectABG'
		else:
			host.playerTurnUI.set_arrow_outline(host.current_unit.name, "Down")
			last_action = "Rotate"
			host.reset_delay()
			host.get_total_delay(['Rotate'])
			host.delay_turn_tracker()
	#	_on_rotate_pressed()
	elif event.is_action_pressed("Guard"):
		print("Guard")
		if last_action == "Guard":
			host.current_action = "Guard"
			return 'completeAction' #_on_attack_pressed()
		else:
			host.playerTurnUI.set_arrow_outline(host.current_unit.name, "Left")
			last_action = "Guard"
			host.reset_delay()
			host.get_total_delay(['Guard'])
			host.delay_turn_tracker()
	elif event.is_action_pressed("Item"):
		print("Item")
		if last_action == "Item":
			host.current_action = "Item"
			print("confirm Item") #_on_attack_pressed()
		else:
			host.playerTurnUI.set_arrow_outline(host.current_unit.name, "Up")
			last_action = "Item"
			host.reset_delay()
			host.get_total_delay(['Item'])
			host.delay_turn_tracker()
	#	_on_skill_pressed()

func exit(host):
	host.mainBattleCamera.rotate_tween_finished.disconnect(enable_cam_look_at)
	host.playerTurnUI.clear_all_arrows()
	host.current_unit.camera_path.reset_progress()
	host.playerTurnUI.play_exit_anim()
	last_action = null
	cam_look_at = false
	
	
func set_active_camera(host, camera):
	
	current_cam = camera
	host.current_unit.get_camera_path().reset_progress()
	camera.move_to(host.current_unit.get_camera_path().global_position)
	current_cam.rotate_to(host.current_unit.playerTurnCam.global_rotation)
	
	
func enable_cam_look_at():
	cam_look_at = true
