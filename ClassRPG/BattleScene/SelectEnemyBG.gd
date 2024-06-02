extends States

var last_action = null

func enter(host):
	print("Player selects unit to attack")
	for unit in host.enemy_units:
		print(unit.name)

func handle_input(host, event):
	if event.is_action_pressed("Cancel"):
		return 'previous'
	
	elif event.is_action_pressed("Attack"):
		if host.EBGR._get_current_unit():
			if last_action == "Attack":
				print("attacking")
				return "completeAction"
			else:
				host.current_selected_enemy = host.EBGR._get_current_unit()
				print("selected " + host.current_selected_enemy.name + host.current_selected_enemy._get_BG().name)
				host.enemySelector.set_BG_position(host.EBGR)
				print("double tap to select")
				last_action = "Attack"
		else:
			print("no enemy here")
	elif event.is_action_pressed("Rotate"):
		if host.EBGB._get_current_unit():
			if last_action == "Rotate":
				print("attacking")
				return "completeAction"
			else:
				host.current_selected_enemy = host.EBGB._get_current_unit()
				print("selected " + host.current_selected_enemy.name + host.current_selected_enemy._get_BG().name)
				host.enemySelector.set_BG_position(host.EBGB)
				print("double tap to select")
				last_action = "Rotate"
		else:
			print("no enemy here")
	elif event.is_action_pressed("Guard"):
		if host.EBGF._get_current_unit():
			if last_action == "Guard":
				print("attacking")
				return "completeAction"
			else:
				host.current_selected_enemy = host.EBGF._get_current_unit()
				print("selected " + host.current_selected_enemy.name + host.current_selected_enemy._get_BG().name)
				host.enemySelector.set_BG_position(host.EBGF)
				print("double tap to select")
				last_action = "Guard"
		else:
			print("no enemy here")
	elif event.is_action_pressed("Skill"):
		if host.EBGT._get_current_unit():
			if last_action == "Skill":
				print("attacking")
				return "completeAction"
			else:
				host.current_selected_enemy = host.EBGT._get_current_unit()
				print("selected " + host.current_selected_enemy.name + host.current_selected_enemy._get_BG().name)
				host.enemySelector.set_BG_position(host.EBGT)
				print("double tap to select")
				last_action = "Skill"
		else:
			print("no enemy here")
