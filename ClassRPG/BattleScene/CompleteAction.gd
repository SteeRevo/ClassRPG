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
