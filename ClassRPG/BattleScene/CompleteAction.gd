extends States

var host_ref

func enter(host):
	host_ref = host
	host.current_unit.anim_finished.connect(_on_animation_finished)
	#host.current_unit.unitTween.connect("finished", _on_tween_finished)
	if host.current_action == "Attack":
		complete_attack(host)
	elif host.current_action == "Rotate":
		complete_rotation(host)
	elif host.current_action == "Skill":
		print(host.skill_stack)
		var counter = 0
		check_skill_inputs(host)
				

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
	for input in host.skill_stack:
		input_arr.push_back(input)
		print(input_arr)
		var sub_found = 0
		for skill in host.current_unit.skillList:
			print(skill.skillname)
			#print(skill.inputs)
			if skill.substring_exists(input_arr):
				print("sub found")
				sub_found += 1
				if skill.compare_inputs(input_arr) and !(possible_skills.has(skill)):
					print(!(possible_skills.has(skill)))
					print("adding " + skill.skillname)
					possible_skills.push_back(skill)
					#print(possible_skills)
				else:
					print("skill not found")
					#if not_found == len(host.current_unit.skillList):
					#	final_skill = final_skill + input_arr
					#print(possible_skills)
			else:
				print("sub not found")
		print("sub found:" + str(sub_found))
		if len(possible_skills) >= 1 and sub_found == 0:
			print("reseting skills")
			var remove = len(possible_skills[-1].inputs)
			for i in range(remove):
				input_arr.pop_front()
			#print(input_arr)
			final_skill.push_back(possible_skills[-1].skillname)
			possible_skills = []
		elif sub_found == 0:
			print("no matches")
			print(input_arr)
			final_skill += input_arr
			input_arr = []
			sub_found = 0
		
			
	if len(input_arr) > 0:
		final_skill = final_skill + input_arr
	print(final_skill)

