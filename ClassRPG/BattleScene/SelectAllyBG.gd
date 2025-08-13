extends States

var last_action = null

func enter(host):
	set_active_camera(host, host.mainBattleCamera)
	host.stateName.set_state_name("Select Ally BG")
	print("Player selects unit to rotate")
	for unit in host.player_units:
		print(unit.name)
	host.enemySelector.visible = false

func handle_input(host, event):
	if event.is_action_pressed("Cancel"):
		host.current_action = null
		return 'previous'
	
	elif event.is_action_pressed("Attack"):
		if host.BGV != host.current_unit.get_BG():
			if host.current_unit.get_BG() != host.BGS:
				if last_action == "Attack":
					print("rotating")
					return "completeAction"
				else:
					host.enemySelector.visible = true
					host.current_selected_BG = host.BGV
					print("selected " + host.current_selected_BG.name)
					host.enemySelector.set_BG_position(host.BGV)
					print("double tap to select")
					last_action = "Attack"
			else:
				print("Cant rotate from the back to the front")
		else:
			print("selecting current bg")
	elif event.is_action_pressed("Rotate"):
		if host.BGB != host.current_unit.get_BG():
			if host.current_unit.get_BG() != host.BGT:
				if last_action == "Rotate":
					print("Rotating")
					return "completeAction"
				else:
					host.enemySelector.visible = true
					host.current_selected_BG = host.BGB
					print("selected " + host.current_selected_BG.name)
					host.enemySelector.set_BG_position(host.BGB)
					print("double tap to select")
					last_action = "Rotate"
			else:
				print("Cant rotate from the wings")
		else:
			print("no enemy here")
	elif event.is_action_pressed("Guard"):
		if host.BGS != host.current_unit.get_BG():
			if host.current_unit.get_BG() != host.BGV:
				if last_action == "Guard":
					print("rotating")
					return "completeAction"
				else:
					host.enemySelector.visible = true
					host.current_selected_BG = host.BGS
					print("selected " + host.current_selected_BG.name)
					host.enemySelector.set_BG_position(host.BGS)
					print("double tap to select")
					last_action = "Guard"
			else:
				print("cant shift from back to front")
		else:
			print("no enemy here")
	elif event.is_action_pressed("Item"):
		if host.BGT != host.current_unit.get_BG():
			if host.current_unit.get_BG() != host.BGB:
				if last_action == "Item":
					print("rotating")
					return "completeAction"
				else:
					host.enemySelector.visible = true
					host.current_selected_BG = host.BGT
					print("selected " + host.current_selected_BG.name)
					host.enemySelector.set_BG_position(host.BGT)
					print("double tap to select")
					last_action = "Item"
			else:
				print("cant shift from the wings")
		else:
			print("no enemy here")
			
func set_active_camera(host, camera):
	camera.move_to(host.selectBGcam.global_position)
	camera.rotate_to(host.selectBGcam.rotation)

func exit(host):
	last_action = null
