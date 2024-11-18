extends States

var last_action = null

func enter(host):
	set_active_camera(host, host.mainBattleCamera)
	host.stateName.set_state_name("Select Ally to control")
	host.current_unit = null
	print("Player selects Unit to control")
	for unit in host.player_units:
		print(unit.name)
		unit.play_idle()
	host.enemySelector.visible = false
	

func handle_input(host, event):
	
	if event.is_action_pressed("Attack"):
		if host.current_unit == null and host.BGF._get_current_unit():
			if host.BGF._get_current_unit().available == true:
				if last_action == "Attack":
					host.current_unit = host.BGF._get_current_unit()
					print(host.current_unit)
					return 'playerturn'
				else:
					host.enemySelector.visible = true
					print("selected " + host.BGF._get_current_unit().name)
					host.enemySelector.set_BG_position(host.BGF)
					print("double tap to select")
					last_action = "Attack"
			else:
				print("ally already gone")
		else:
			print("no ally here")
	elif event.is_action_pressed("Rotate"):
		if host.current_unit == null and host.BGB._get_current_unit():
			if host.BGB._get_current_unit().available == true:
				if last_action == "Rotate":
					host.current_unit = host.BGB._get_current_unit()
					print(host.current_unit)
					return 'playerturn'
				else:
					host.enemySelector.visible = true
					print("selected " + host.BGB._get_current_unit().name)
					host.enemySelector.set_BG_position(host.BGB)
					print("double tap to select")
					last_action = "Rotate"
			else:
				print("ally already gone")
		else:
			print("no ally here")
	elif event.is_action_pressed("Guard"):
		if host.current_unit == null and host.BGR._get_current_unit():
			if host.BGR._get_current_unit().available == true:
				if last_action == "Guard":
					host.current_unit = host.BGR._get_current_unit()
					print(host.current_unit)
					return 'playerturn'
				else:
					host.enemySelector.visible = true
					print("selected " + host.BGR._get_current_unit().name)
					host.enemySelector.set_BG_position(host.BGR)
					print("double tap to select")
					last_action = "Guard"
			else:
				print("ally already gone")
		else:
			print("no ally here")
	elif event.is_action_pressed("Item"):
		if host.current_unit == null and host.BGT._get_current_unit():
			if host.BGT._get_current_unit().available == true:
				if last_action == "Item":
					host.current_unit = host.BGT._get_current_unit()
					print(host.current_unit)
					return 'playerturn'
				else:
					host.enemySelector.visible = true
					print("selected " + host.BGT._get_current_unit().name)
					host.enemySelector.set_BG_position(host.BGT)
					print("double tap to select")
					last_action = "Item"
			else:
				print("ally already gone")
		else:
			print("no ally here")

func update(host, delta):
	return
	
func set_active_camera(host, camera):
	host.active_camera.current = false
	camera.current = true
	host.active_camera = camera
	camera.move_to(host.mainOverviewCam.global_position)
	camera.rotate_to(host.mainOverviewCam.rotation)
			

func exit(host):
	last_action = null
