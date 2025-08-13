extends States

var isConfirming = false

func enter(host):
	print("Player inputs skills")
	host.stateName.set_state_name("Inputting Skills")
	set_active_camera(host, host.mainBattleCamera)
	host.enemySelector.visible = false
	host.inputMoves.visible = true
	host.inputMoves.set_active_unit_movelist_visible(host.current_unit)
	host.skill_sequence.clear()
	isConfirming = false

func handle_input(host, event):

	if host.skill_stack.size() == BattleSettings.inputs_allowed:
		if event.is_action_pressed("Confirm"):
			print("moving to skills attacks")
			return 'completeAction'
		elif event.is_action_pressed("Cancel"):
			host.skill_stack.pop_back()
			host.inputMoves.inputtedMoves.reset_arrow()
			print(host.skill_stack)
			host.skill_sequence = check_skill_inputs(host)
			print(host.skill_sequence)
			host.reset_delay()
			host.get_total_delay(host.skill_sequence)
			host.delay_turn_tracker()
			
	elif event.is_action_pressed("Confirm"):
		if host.skill_stack.size() == 0:
			print("No skills inputted")
		elif !isConfirming:
			print("Confirm?")
			isConfirming = true
		else:
			print("moving to skills attacks")
			return 'completeAction'
	
	elif event.is_action_pressed("Cancel"):
		if host.skill_stack.is_empty():
			host.reset_delay()
			return 'previous'
		else:
			host.skill_stack.pop_back()
			print(host.skill_stack)
			host.inputMoves.inputtedMoves.reset_arrow()
			host.skill_sequence = check_skill_inputs(host)
			print(host.skill_sequence)
			host.reset_delay()
			host.get_total_delay(host.skill_sequence)
			host.delay_turn_tracker()
	
	elif host.skill_stack.size() < BattleSettings.inputs_allowed: 
		if event.is_action_pressed("Attack"):
			host.skill_stack.append("Right")
			host.inputMoves.inputtedMoves.set_arrow_direction("Right")
			host.skill_sequence = check_skill_inputs(host)
			print(host.skill_sequence)
			host.reset_delay()
			host.get_total_delay(host.skill_sequence)
			host.delay_turn_tracker()
			
		elif event.is_action_pressed("Rotate"):
			host.skill_stack.append("Down")
			host.inputMoves.inputtedMoves.set_arrow_direction("Down")
			host.skill_sequence = check_skill_inputs(host)
			print(host.skill_sequence)
			host.reset_delay()
			host.get_total_delay(host.skill_sequence)
			host.delay_turn_tracker()
			
		elif event.is_action_pressed("Guard"):
			host.skill_stack.append("Left")
			host.inputMoves.inputtedMoves.set_arrow_direction("Left")
			host.skill_sequence = check_skill_inputs(host)
			print(host.skill_sequence)
			host.reset_delay()
			host.get_total_delay(host.skill_sequence)
			host.delay_turn_tracker()
			
		elif event.is_action_pressed("Item"):
			host.skill_stack.append("Up")
			host.inputMoves.inputtedMoves.set_arrow_direction("Up")
			host.skill_sequence = check_skill_inputs(host)
			print(host.skill_sequence)
			host.reset_delay()
			host.get_total_delay(host.skill_sequence)
			host.delay_turn_tracker()
		
		if host.skill_stack.size() == BattleSettings.inputs_allowed:
			print("Confirm?")
		
func set_active_camera(host, camera):
	camera.move_to(host.current_unit.get_unit_cam().global_position)
	camera.rotate_to(host.current_unit.get_unit_cam().rotation)
	
func check_skill_inputs(host):
	var input_arr = []
	var possible_skills = []
	var final_skill = []
	var latest_skill
	var counter = 0
	var only_skills = []
	for input in host.skill_stack:
		counter += 1
		input_arr.push_back(input)
		print(input_arr)
		print(len(input_arr))
		var skill_name
		if len(input_arr) >= 3:
			var sub_arr = input_arr
			while len(sub_arr) >= 3:
				skill_name = host.current_unit.check_skill(sub_arr, host.current_unit.skill_tree)
				if skill_name != null and skill_name != "" and skill_name != latest_skill:
					break
				sub_arr = sub_arr.slice(1)
				print(sub_arr)
		else:
			skill_name = host.current_unit.check_skill(input_arr, host.current_unit.skill_tree)
		print(skill_name)
		
		if skill_name != null and skill_name != "":
			latest_skill = skill_name
			print("latest_skill set")
			
		if (skill_name == null or skill_name == "") and latest_skill != null:
			input_arr.insert(len(input_arr) - 1, latest_skill)
			only_skills.append(latest_skill)
			latest_skill = null
	if latest_skill != null:
		input_arr.append(latest_skill)
		only_skills.append(latest_skill)
		latest_skill = null
	if host.current_unit.get_BG().name == "Battleground4":
		print(only_skills)
		return only_skills
	return input_arr

func exit(host):
	host.inputMoves.visible = false
	host.inputMoves.inputtedMoves.clear_all_arrows()
