extends States

var host_ref

func enter(host):
	host_ref = host
	host.current_unit.anim_finished.connect(_on_animation_finished)
	if host.current_action == "Attack":
		complete_attack(host)

func complete_attack(host):
	host.skillPoints._add_skill_points(1)
	print("do attack")
	if host.current_unit.name == "Sam":
		host.current_unit.play_attack()
	
	
func _on_unit_turn_finished(host, action_weight): 
	host.player_units.erase(host.current_unit)
	host.insert_sort(host.player_units, host.current_unit, action_weight)
	host.end_turn()
	
func _on_animation_finished(anim_name):
	if(anim_name == 'attack'):
		host_ref.current_unit.play_idle()
		_on_unit_turn_finished(host_ref, 40)
	
