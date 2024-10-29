extends States

var last_action = null

func enter(host):
	print("Player selects Unit to control")
	for unit in host.player_units:
		print(unit.name)

func handle_input(host, event):
	if event.is_action_pressed("Cancel"):
		host.current_action = null
		return 'previous'
	
	elif event.is_action_pressed("Attack"):
		if host.current_unit == null and host.BGF._get_current_unit():
			if last_action == "Attack":
				host.current_unit = host.BGF._get_current_unit()
				print(host.current_unit)
				return 'playerturn'
			else:
				print("selected " + host.BGF._get_current_unit().name)
				host.enemySelector.set_BG_position(host.BGF)
				print("double tap to select")
				last_action = "Attack"
		else:
			print("no ally here")
	elif event.is_action_pressed("Rotate"):
		if host.current_unit == null and host.BGB._get_current_unit():
			if last_action == "Rotate":
				host.current_unit = host.BGB._get_current_unit()
				print(host.current_unit)
				return 'playerturn'
			else:
				print("selected " + host.BGB._get_current_unit().name)
				host.enemySelector.set_BG_position(host.BGB)
				print("double tap to select")
				last_action = "Rotate"
		else:
			print("no ally here")
	elif event.is_action_pressed("Guard"):
		if host.current_unit == null and host.BGR._get_current_unit():
			if last_action == "Guard":
				host.current_unit = host.BGR._get_current_unit()
				print(host.current_unit)
				return 'playerturn'
			else:
				print("selected " + host.BGR._get_current_unit().name)
				host.enemySelector.set_BG_position(host.BGR)
				print("double tap to select")
				last_action = "Guard"
		else:
			print("no ally here")
	elif event.is_action_pressed("Item"):
		if host.current_unit == null and host.BGT._get_current_unit():
			if last_action == "Item":
				host.current_unit = host.BGT._get_current_unit()
				print(host.current_unit)
				return 'playerturn'
			else:
				print("selected " + host.BGT._get_current_unit().name)
				host.enemySelector.set_BG_position(host.BGT)
				print("double tap to select")
				last_action = "Item"
		else:
			print("no ally here")
			

func exit(host):
	last_action = null
