extends States

func enter(host):
	print("Player inputs skills")
	host.stateName.set_state_name("Inputting Skills")
	set_active_camera(host, host.mainBattleCamera)
	host.enemySelector.visible = false

func handle_input(host, event):
	
	if host.skill_stack.size() == 5:
		if event.is_action_pressed("Attack"):
			print("moving to skills attacks")
			return 'completeAction'
		elif event.is_action_pressed("Cancel"):
			host.skill_stack.pop_back()
			print(host.skill_stack)
			
	elif event.is_action_pressed("Cancel"):
		if host.skill_stack.is_empty():
			return 'previous'
		else:
			host.skill_stack.pop_back()
			print(host.skill_stack)
	
	elif host.skill_stack.size() < 5: 
		if event.is_action_pressed("Attack"):
			host.skill_stack.append("Right")
			print(host.skill_stack)
			
		elif event.is_action_pressed("Rotate"):
			host.skill_stack.append("Down")
			print(host.skill_stack)
			
		elif event.is_action_pressed("Guard"):
			host.skill_stack.append("Left")
			print(host.skill_stack)
			
		elif event.is_action_pressed("Item"):
			host.skill_stack.append("Up")
			print(host.skill_stack)
		
		if host.skill_stack.size() == 5:
			print("Confirm?")
		
func set_active_camera(host, camera):
	camera.move_to(host.current_unit.get_unit_cam().global_position)
	camera.rotate_to(host.current_unit.get_unit_cam().rotation)
