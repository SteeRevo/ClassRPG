extends States

var last_action = null

func enter(host):
	print("=====player turn=========")
	if host.current_unit.name == "Sam":
		host.current_unit.play_idle()
	for unit in host.player_units:
		print(unit.name + ": current turn_order = " + str(unit._get_turn_order()))
	for unit in host.enemy_units:
		print(unit.name + ": current turn_order = " + str(unit._get_turn_order()))
	print("Current Unit is: " + host.current_unit.name)
	print("Press D to attack, A to Guard, W for Skill, S for Rotate.")
	
func handle_input(host, event):
	if event.is_action_pressed("Attack"):
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
	elif event.is_action_pressed("Skill"):
		print("Skill")
		if last_action == "Skill":
			host.current_action = "Skill"
			print("confirm skill") #_on_attack_pressed()
		else:
			last_action = "Skill"
	#	_on_skill_pressed()
