extends States

var last_action = null

var current_cam

func enter(host):
	host.stateName.set_state_name("Player Turn")
	print("=====player turn=========")
	print("Current Unit is: " + host.current_unit.name)
	print("Press D to attack, A to Guard, W for Item, S for Rotate.")
	set_active_camera(host, host.mainBattleCamera)
	host.enemySelector.visible = false
	host.current_unit.get_BG().add_buffs()
	print("Health: ", host.current_unit._get_health())
	print("Mana: ", host.current_unit.get_mana())
	print("Attack: " , host.current_unit.get_attack())
	print("Defense: ", host.current_unit.get_defense())
	print("Technique: ", host.current_unit.get_technique())
	
	
func update(host, delta):
	match(host.current_unit_bg):
		"Battleground":
			current_cam.move_to(host.cameraPointBG1.global_position)
		"Battleground2":
			current_cam.move_to(host.cameraPointBG2.global_position)
		"Battleground3":
			current_cam.move_to(host.cameraPointBG3.global_position)
		"Battleground4":
			current_cam.move_to(host.cameraPointBG4.global_position)
	current_cam.look_at(host.current_unit.global_position + Vector3(0, 2, 0), Vector3(0, 1, 0))
	
func handle_input(host, event):
	if event.is_action_pressed("Cancel"):
		host.current_action = null
		host.current_unit.get_BG().reset_buffs()
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
			return 'completeAction' #_on_attack_pressed()
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
	
	current_cam = camera
	host.current_unit_bg = host.current_unit.get_BG().name
	match(host.current_unit_bg):
		"Battleground":
			camera.move_to(host.cameraPointBG1.global_position)
			host.cameraPointBG1.start()
		"Battleground2":
			camera.move_to(host.cameraPointBG2.global_position)
			host.cameraPointBG2.start()
		"Battleground3":
			camera.move_to(host.cameraPointBG3.global_position)
			host.cameraPointBG3.start()
		"Battleground4":
			camera.move_to(host.cameraPointBG4.global_position)
			host.cameraPointBG4.start()
	
	
