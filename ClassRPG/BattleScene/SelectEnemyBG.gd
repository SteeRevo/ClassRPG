extends States

var last_action = null

func enter(host):
	print("Player selects unit to attack")
	for unit in host.enemy_units:
		print(unit.name)
	set_active_camera(host, host.mainBattleCamera)

func handle_input(host, event):
	if event.is_action_pressed("Cancel"):
		host.current_action = null
		return 'previous'
	
	elif event.is_action_pressed("Attack"):
		if host.EBGR._get_current_unit():
			if last_action == "Attack":
				print("attacking")
				return "skillInputs"
			else:
				host.current_selected_enemy = host.EBGR._get_current_unit()
				print("selected " + host.current_selected_enemy.name + host.current_selected_enemy.get_BG().name)
				host.enemySelector.set_BG_position(host.EBGR)
				print("double tap to select")
				last_action = "Attack"
		else:
			print("no enemy here")
	elif event.is_action_pressed("Rotate"):
		if host.EBGB._get_current_unit():
			if last_action == "Rotate":
				print("attacking")
				return "skillInputs"
			else:
				host.current_selected_enemy = host.EBGB._get_current_unit()
				print("selected " + host.current_selected_enemy.name + host.current_selected_enemy.get_BG().name)
				host.enemySelector.set_BG_position(host.EBGB)
				print("double tap to select")
				last_action = "Rotate"
		else:
			print("no enemy here")
	elif event.is_action_pressed("Guard"):
		if host.EBGF._get_current_unit():
			if last_action == "Guard":
				print("attacking")
				return "skillInputs"
			else:
				host.current_selected_enemy = host.EBGF._get_current_unit()
				print("selected " + host.current_selected_enemy.name + host.current_selected_enemy.get_BG().name)
				host.enemySelector.set_BG_position(host.EBGF)
				print("double tap to select")
				last_action = "Guard"
		else:
			print("no enemy here")
	elif event.is_action_pressed("Item"):
		if host.EBGT._get_current_unit():
			if last_action == "Item":
				print("attacking")
				return "skillInputs"
			else:
				host.current_selected_enemy = host.EBGT._get_current_unit()
				print("selected " + host.current_selected_enemy.name + host.current_selected_enemy.get_BG().name)
				host.enemySelector.set_BG_position(host.EBGT)
				print("double tap to select")
				last_action = "Item"
		else:
			print("no enemy here")
			

func exit(host):
	last_action = null
