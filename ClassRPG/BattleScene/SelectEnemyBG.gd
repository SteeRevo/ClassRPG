extends States

var last_action = null

func enter(host):
	host.stateName.set_state_name("Select enemy")
	print("Player selects unit to attack")
	for unit in host.enemy_units:
		print(unit.name)
	set_active_camera(host, host.mainBattleCamera)
	host.enemySelector.visible = false

func handle_input(host, event):
	if event.is_action_pressed("Cancel"):
		return 'previous'
	
	elif event.is_action_pressed("Attack"):
		if host.EBGR._get_current_unit():
			if !host.EBGB._get_current_unit() and !host.EBGT._get_current_unit():
				if last_action == "Attack":
					print("attacking")
					return "skillInputs"
				else:
					host.enemySelector.visible = true
					host.current_selected_enemy = host.EBGR._get_current_unit()
					print("selected " + host.current_selected_enemy.name + host.current_selected_enemy.get_BG().name)
					host.enemySelector.set_BG_position(host.EBGR)
					print("double tap to select")
					last_action = "Attack"
			else: 
				print("enemy in Bottom or Top")
		else:
			print("no enemy here")
	elif event.is_action_pressed("Rotate"):
		if host.EBGB._get_current_unit():
			if !host.EBGF._get_current_unit():
				if last_action == "Rotate":
					print("attacking")
					return "skillInputs"
				else:
					host.enemySelector.visible = true
					host.current_selected_enemy = host.EBGB._get_current_unit()
					print("selected " + host.current_selected_enemy.name + host.current_selected_enemy.get_BG().name)
					host.enemySelector.set_BG_position(host.EBGB)
					print("double tap to select")
					last_action = "Rotate"
			else:
				print("enemy in front")
		else:
			print("no enemy here")
	elif event.is_action_pressed("Guard"):
		if host.EBGF._get_current_unit():
			if last_action == "Guard":
				print("attacking")
				return "skillInputs"
			else:
				host.enemySelector.visible = true
				host.current_selected_enemy = host.EBGF._get_current_unit()
				print("selected " + host.current_selected_enemy.name + host.current_selected_enemy.get_BG().name)
				host.enemySelector.set_BG_position(host.EBGF)
				print("double tap to select")
				last_action = "Guard"
		else:
			print("no enemy here")
	elif event.is_action_pressed("Item"):
		if host.EBGT._get_current_unit():
			if !host.EBGF._get_current_unit():
				if last_action == "Item":
					print("attacking")
					return "skillInputs"
				else:
					host.enemySelector.visible = true
					host.current_selected_enemy = host.EBGT._get_current_unit()
					print("selected " + host.current_selected_enemy.name + host.current_selected_enemy.get_BG().name)
					host.enemySelector.set_BG_position(host.EBGT)
					print("double tap to select")
					last_action = "Item"
			else:
				print("enemy in front")
		else:
			print("no enemy here")
			
func set_active_camera(host, camera):
	camera.move_to(host.selectEBGcam.global_position)
	camera.rotate_to(host.selectEBGcam.rotation)
			

func exit(host):
	last_action = null
