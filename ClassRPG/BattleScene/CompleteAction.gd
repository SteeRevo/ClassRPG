extends States

var host_ref

func enter(host):
	host_ref = host
	host.current_unit.anim_finished.connect(_on_animation_finished)
	#host.current_unit.unitTween.connect("finished", _on_tween_finished)
	if host.current_action == "Attack":
		check_skill_inputs(host)
	elif host.current_action == "Rotate":
		complete_rotation(host)
	elif host.current_action == "Item":
		pass
		
				

func complete_attack(host):
	host.skillPoints._add_skill_points(1)
	print("do attack")
	if host.current_unit.name == "Sam":
		host.current_unit.play_attack()

func complete_rotation(host):
	rotate_units(host.current_unit, host.current_selected_BG._get_current_unit(), host.current_unit.get_BG(), host.current_selected_BG)
	
func _on_unit_turn_finished(host, action_weight): 
	host.player_units.erase(host.current_unit)
	host.insert_sort(host.player_units, host.current_unit, action_weight)
	host.end_turn()
	
func _on_animation_finished(anim_name):
	if anim_name == 'attack' or anim_name == 'walk':
		host_ref.current_unit.play_idle()
		_on_unit_turn_finished(host_ref, 40)

func _on_tween_finished():
	host_ref.current_unit.play_idle()
	_on_unit_turn_finished(host_ref, 20)
	
func exit(host):
	set_active_camera(host, host.mainBattleCamera)
	host.current_action = null
	return

func rotate_units(unit1, unit2, BG1, BG2):
	print("rotating")
	unit1.move_towards(Vector3(BG2.global_position.x, unit1.global_position.y, BG2.global_position.z))
	set_BG_unit_position(unit1, BG2)
	if(unit2 != null):
		unit2.move_towards(Vector3(BG1.global_position.x, unit2.global_position.y, BG1.global_position.z))
		print("moved")
	set_BG_unit_position(unit2, BG1)
	
func set_BG_unit_position(unit, bg):
	if unit != null:
		unit._set_BG(bg)
	bg._set_current_unit(unit)
	
func check_skill_inputs(host):
	var input_arr = []
	var possible_skills = []
	var final_skill = []
	var latest_skill
	for input in host.skill_stack:
		input_arr.push_back(input)
		print(input_arr)
		
		var skill_name
		if len(input_arr) > 3:
			var sub_arr = input_arr
			while len(sub_arr) >= 3:
				skill_name = host.current_unit.check_skill(sub_arr, host.current_unit.skill_tree)
				if skill_name != null or skill_name != "":
					break
				sub_arr = sub_arr.slice(1)
		else:
			skill_name = host.current_unit.check_skill(input_arr, host.current_unit.skill_tree)
		print(skill_name)
		
		if skill_name != null and skill_name != "":
			latest_skill = skill_name
			print("latest_skill set")
		
		if len(input_arr) == len(host.skill_stack) and latest_skill != null:
			var skill_inputs = host.current_unit.get_skill(latest_skill).inputs
			var remove = len(skill_inputs)
			for i in range(remove):
				input_arr.pop_back()
			input_arr.append(skill_name)
		elif (skill_name == null or skill_name == "") and latest_skill != null:
			var skill_inputs = host.current_unit.get_skill(latest_skill).inputs
			input_arr.insert(len(input_arr) - 1, latest_skill)
			print(input_arr)
			var remove = len(skill_inputs)
			for i in range(remove):
				input_arr.remove_at(len(input_arr) - 3)
			print(input_arr)
			latest_skill = null
		
	print(input_arr)
	host.end_turn()

