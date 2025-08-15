extends States

@onready var host_ref = %BattleManager

var current_action
var moved_to_enemy = false
var current_position
var current_enemy = null
var current_ally = null
var current_unit = null
var tweened = 0
var not_attack = ["Rotate", "0tpose", "Guard"]
var basic = ["Left", "Right", "Up", "Down"]
var total_damage = 0
var current_cam = null
var skill_cam = false
var usingSkill = false

func enter(host):
	host.enemySelector.visible = false
	host.stateName.set_state_name("completing action")
	current_unit = host.current_unit
	total_damage = 0
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
		usingSkill = false
		change_attack_cam(host_ref, host_ref.mainBattleCamera)
		if host_ref.skill_sequence.size() > 0:
			play_animation(host_ref)
			pass
		else:
			check_enemy_death(current_enemy)
			if len(host_ref.enemy_units) != 0:
				if host_ref.current_unit.get_BG() == host_ref.BGS:
					host_ref.end_turn()
					return
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
		if host_ref.current_unit.enemy_unit == false:
			host_ref.baseballField.batter_run()
		elif host_ref.current_unit.enemy_unit:
			host_ref.tidemeter.update_tide(total_damage * 10)
		host_ref.end_turn()
		
func _on_attack_hit():
	host_ref.skillDamage.visible = true
	current_enemy.play_getting_hit()
	host_ref.skillDamage.update_text()
	for unit in host_ref.player_units:
		host_ref.playerTurnUI.update_health(unit)
	print(current_enemy.name)
	
func update(host, delta):
	if !usingSkill and host.current_action == "Attack":
		host.active_camera.move_to(current_cam.global_position, 0.1)
		host.active_camera.rotate_to(current_cam.rotation, 0.1)
	
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
	#host.delay_turn_tracker()
	host.BGS.reset_health_sp()
	host.current_unit = null
	host.current_action = null
	host.current_selected_BG = null
	host.current_selected_ally = null
	host.skill_stack = []
	host.skillDamage._reset_damage()
	host_ref.skillDamage.visible = false
	host.skill_sequence.clear()
	moved_to_enemy = false
	current_unit = null
	tweened = 0
	usingSkill = false
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
	
	
	#calc attack damage here/go to attack animation
	current_position = host.current_unit.global_position
	if host.current_unit.get_BG() != host.BGS and !host.current_unit.enemy_unit:
		host.current_unit.move_towards(host.current_selected_enemy.get_BG_attacker_pos())
	else:
		play_animation(host)
	#host.get_total_delay(input_arr)
	

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
	var move = host.skill_sequence.pop_front()
	calc_damage(host, move)

func calc_damage(host, skill):
	#check if enemy or normal unit attacking
	if host.current_unit.enemy_unit == false:
		#checks if skill has been activated
		var current_skill = host.current_unit.get_skill(skill)
		if current_skill != null:
			if current_skill.skillname not in basic:
				usingSkill = true
				change_attack_cam(host, host.current_unit.get_skill_cam())
			host.current_unit.play_skill(current_skill.skillname)
			var damage = host.current_unit.attack_unit(host.current_selected_enemy, skill)
			host_ref.skillDamage._add_skill_damage(damage)
			host_ref.skillDamage.set_skill_name(skill)
			total_damage += damage
		else:
			print("New skill unlocked")
			current_skill = host.current_unit.set_skill_active(skill)
			host.current_unit.play_skill(current_skill.skillname)
			var damage = host.current_unit.attack_unit(host.current_selected_enemy, skill)
	else:
		print(skill)
		var damage = host.current_unit.attack_unit(host.current_selected_enemy, skill)
		total_damage = damage
		host.current_unit.play_skill(skill)
		host_ref.skillDamage._add_skill_damage(damage)
		host_ref.skillDamage.set_skill_name(skill)
	
func set_active_camera(host, camera):
	#host.active_camera.current = false
	#camera.current = true
	#host.active_camera = camera
	current_cam = camera
	
func change_attack_cam(host, camera):
	host.active_camera.current = false
	camera.current = true
	host.active_camera = camera
	
func guard(host):
	host.current_unit.set_guard()

func play_enemy_attack(host):
	current_position = host.current_unit.global_position
	host.current_unit.move_towards(host.current_selected_enemy.get_BG_attacker_pos())
	host.skill_sequence = host.skill_stack
	host.get_total_delay(host.skill_sequence)
