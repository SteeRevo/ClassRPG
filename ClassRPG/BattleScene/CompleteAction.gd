extends States

@onready var host_ref = %BattleManager
var input_arr = []
var current_action
var moved_to_enemy = false
var current_position
var current_enemy = null
var current_ally = null
var current_unit = null
var tweened = 0
var uses_sp = false
var not_attack = ["Rotate", "0tpose", "Guard"]

func enter(host):
	host.enemySelector.visible = false
	host.stateName.set_state_name("completing action")
	current_unit = host.current_unit
	host.current_unit.available = false
	host.current_unit.anim_finished.connect(_on_animation_finished)
	host.current_unit.tween_finished.connect(_on_tween_finished)
	host.current_unit.attack_hit.connect(_on_attack_hit)
	current_action = host.current_action
	current_enemy = host.current_selected_enemy
	#host.current_unit.unitTween.connect("finished", _on_tween_finished)
	if host.current_action == "Attack":
		if host.current_unit.enemy_unit:
			play_enemy_attack(host)
		else:
			check_skill_inputs(host)
		set_active_camera(host, host.current_unit.get_attack_cam())
	elif host.current_action == "Rotate":
		host.current_selected_ally = host.current_selected_BG._get_current_unit()
		current_ally = host.current_selected_ally
		complete_rotation(host)
	elif host.current_action == "Item":
		pass
	elif host.current_action == "Guard":
		guard(host)
		
		

func complete_rotation(host):
	rotate_units(host.current_unit, host.current_selected_ally, host.current_unit.get_BG(), host.current_selected_BG)
	
func _on_unit_turn_finished(host): 
	host.current_unit.available = false
	host.end_turn()
	
func _on_animation_finished(anim_name):
	print(anim_name)
	if anim_name == "Guard":
		host_ref.end_turn()
	if !not_attack.has(anim_name):
		if input_arr.size() > 0:
			play_animation(host_ref)
			pass
		else:
			check_enemy_death(current_enemy)
			if len(host_ref.enemy_units) != 0:
				host_ref.current_unit.move_towards(current_position)
					

func _on_tween_finished():
	print("tweened")
	if current_action == "Rotate":
		if current_ally:
			if current_ally.is_guarding:
				current_ally.set_guard()
		host_ref.end_turn()
	elif current_action == "Attack" and !moved_to_enemy:
		moved_to_enemy = true
		play_animation(host_ref)
	elif current_action == "Attack" and moved_to_enemy:
		host_ref.end_turn()
		
func _on_attack_hit():
	current_enemy.play_getting_hit()
	print(current_enemy.name)
	
func exit(host):
	if host.current_unit.tween_finished.is_connected(_on_tween_finished):
		host.current_unit.tween_finished.disconnect(_on_tween_finished)
	if host.current_unit.anim_finished.is_connected(_on_animation_finished):
		host.current_unit.anim_finished.disconnect(_on_animation_finished)
	if host.current_unit.attack_hit.is_connected(_on_attack_hit):
		host.current_unit.attack_hit.disconnect(_on_attack_hit)
	if host.current_selected_ally != null:
		if host.current_selected_ally.tween_finished.is_connected(_on_tween_finished):
			host.current_selected_ally.tween_finished.disconnect(_on_tween_finished)
		if host.current_selected_ally.anim_finished.is_connected(_on_animation_finished):
			host.current_selected_ally.anim_finished.disconnect(_on_animation_finished)
	set_active_camera(host, host.mainBattleCamera)
	host.delay_turn_tracker()
	host.BGR.reset_health_sp()
	host.current_unit = null
	host.current_action = null
	host.current_selected_BG = null
	host.current_selected_ally = null
	host.skill_stack = []
	host.skillDamage._reset_damage()
	moved_to_enemy = false
	current_unit = null
	tweened = 0
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
	input_arr = []
	var possible_skills = []
	var final_skill = []
	var latest_skill
	var counter = 0
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
			latest_skill = null
	if latest_skill != null:
		input_arr.append(latest_skill)
		latest_skill = null
	print(input_arr)
	
	#calc attack damage here/go to attack animation
	current_position = host.current_unit.global_position
	host.current_unit.move_towards(host.current_selected_enemy.get_BG_attacker_pos())
	host.get_total_delay(input_arr)
	

func check_enemy_death(enemy):
	if enemy:
		if enemy.get_death():
			enemy.get_BG()._set_current_unit(null)
			host_ref.enemy_units.erase(enemy)
			host_ref.unit_list.erase(enemy)
			host_ref.remove_enemy_tt(enemy)
			enemy.kill_self()
	if len(host_ref.enemy_units) == 0:
		host_ref.end_turn()

func play_animation(host):
	var move = input_arr.pop_front()
	match move:
		"Left":
			host.current_unit.play_left()
			uses_sp = false
		"Right":
			host.current_unit.play_right()
			uses_sp = false
		"Up":
			host.current_unit.play_up()
			uses_sp = false
		"Down":
			host.current_unit.play_down()
			uses_sp = false
		_:
			uses_sp = true
	calc_damage(host, move)

func calc_damage(host, skill):
	if host.current_unit.enemy_unit == false:
		if uses_sp == false:
			var damage = host.current_unit.attack_unit(host.current_selected_enemy, skill)
			host.skillDamage._add_skill_damage(damage)
		else:
			var current_skill = host.current_unit.get_skill(skill)
			var useable = host.current_unit.use_sp(current_skill.delay)
			if useable:
				host.current_unit.play_skill(current_skill.skillname)
				var damage = host.current_unit.attack_unit(host.current_selected_enemy, skill)
				host.skillDamage._add_skill_damage(damage)
			else:
				print("Not enough SP")
				_on_animation_finished("Fail")
	else:
		print(skill)
		var damage = host.current_unit.attack_unit(host.current_selected_enemy, skill)
		host.current_unit.play_skill(skill)
	
func set_active_camera(host, camera):
	host.active_camera.current = false
	camera.current = true
	host.active_camera = camera
	
func guard(host):
	host.current_unit.set_guard()

func play_enemy_attack(host):
	current_position = host.current_unit.global_position
	host.current_unit.move_towards(host.current_selected_enemy.get_BG_attacker_pos())
	input_arr = host.skill_stack
	host.get_total_delay(input_arr)
