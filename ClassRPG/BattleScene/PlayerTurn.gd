extends States

var last_action = null

func enter(host):
	host.stateName.set_state_name("Player Turn")
	print("=====player turn=========")
	if host.current_unit.name == "Sam":
		host.current_unit.play_idle()
		#host.current_unit.set_skill_active("Wind: Zephyr")
	for unit in host.player_units:
		print(unit.name + ": current turn_order = " + str(unit._get_turn_order()))
	for unit in host.enemy_units:
		print(unit.name + ": current turn_order = " + str(unit._get_turn_order()))
	print("Current Unit is: " + host.current_unit.name)
	print("Press D to attack, A to Guard, W for Item, S for Rotate.")
	set_active_camera(host, host.mainBattleCamera)
	
func handle_input(host, event):
	if event.is_action_pressed("Cancel"):
		host.current_action = null
		return 'previous'
		
	elif event.is_action_pressed("Attack"):
		print("Attack")
		if last_action == "Attack":
			host.current_action = "Attack"
			print("confirm attack") #_on_attack_pressed()
			return 'selectEBG'
		else:
			last_action = "Attack"
	elif event.is_action_pressed("Rotate"):
		print("Rotate")
		if last_action == "Rotate":
			host.current_action = "Rotate"
			print("confirm rotate")
			return 'selectABG'
		else:
			last_action = "Rotate"
	#	_on_rotate_pressed()
	elif event.is_action_pressed("Guard"):
		print("Guard")
		if last_action == "Guard":
			host.current_action = "Guard"
			print("confirm guard") #_on_attack_pressed()
		else:
			last_action = "Guard"
	elif event.is_action_pressed("Item"):
		print("Item")
		if last_action == "Item":
			host.current_action = "Item"
			print("confirm Item") #_on_attack_pressed()
		else:
			last_action = "Item"
	#	_on_skill_pressed()

func exit(host):
	last_action = null
	
func set_active_camera(host, camera):
	camera.move_to(host.cameraPointBG1.global_position)
