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
		if host.BGF != host.current_unit.get_BG():
			if last_action == "Attack":
				print("rotating")
				return "completeAction"
			else:
				host.enemySelector.visible = true
				host.current_selected_BG = host.BGF
				print("selected " + host.current_selected_BG.name)
				host.enemySelector.set_BG_position(host.BGF)
				print("double tap to select")
				last_action = "Attack"
		else:
			print("selecting current bg")
	elif event.is_action_pressed("Rotate"):
		if host.BGB != host.current_unit.get_BG():
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
			print("no enemy here")
	elif event.is_action_pressed("Guard"):
		if host.BGR != host.current_unit.get_BG():
			if last_action == "Guard":
				print("rotating")
				return "completeAction"
			else:
				host.enemySelector.visible = true
				host.current_selected_BG = host.BGR
				print("selected " + host.current_selected_BG.name)
				host.enemySelector.set_BG_position(host.BGR)
				print("double tap to select")
				last_action = "Guard"
		else:
			print("no enemy here")
	elif event.is_action_pressed("Item"):
		if host.BGT != host.current_unit.get_BG():
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
			print("no enemy here")
			
func set_active_camera(host, camera):
	camera.move_to(host.selectBGcam.global_position)
	camera.rotate_to(host.selectBGcam.rotation)

func exit(host):
	last_action = null
