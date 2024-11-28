extends States

func enter(host):
	print("Player inputs skills")
	host.stateName.set_state_name("Inputting Skills")
	set_active_camera(host, host.mainBattleCamera)
	host.enemySelector.visible = false
	host.inputMoves.visible = true
	host.inputMoves.set_active_unit_movelist_visible(host.current_unit)
	host.playerTurnUI.set_name_visible(host.current_unit.name)
	host.playerTurnUI.update_health(host.current_unit)
	host.playerTurnUI.update_sp(host.current_unit)
	host.playerTurnUI.play_enter_health()

func handle_input(host, event):
	
	if host.skill_stack.size() == BattleSettings.inputs_allowed:
		if event.is_action_pressed("Attack"):
			print("moving to skills attacks")
			return 'completeAction'
		elif event.is_action_pressed("Cancel"):
			host.skill_stack.pop_back()
			host.inputMoves.inputtedMoves.reset_arrow()
			print(host.skill_stack)
			
	elif event.is_action_pressed("Cancel"):
		if host.skill_stack.is_empty():
			return 'previous'
		else:
			host.skill_stack.pop_back()
			print(host.skill_stack)
			host.inputMoves.inputtedMoves.reset_arrow()
	
	elif host.skill_stack.size() < BattleSettings.inputs_allowed: 
		if event.is_action_pressed("Attack"):
			host.skill_stack.append("Right")
			host.inputMoves.inputtedMoves.set_arrow_direction("Right")
			print(host.skill_stack)
			
		elif event.is_action_pressed("Rotate"):
			host.skill_stack.append("Down")
			host.inputMoves.inputtedMoves.set_arrow_direction("Down")
			print(host.skill_stack)
			
		elif event.is_action_pressed("Guard"):
			host.skill_stack.append("Left")
			host.inputMoves.inputtedMoves.set_arrow_direction("Left")
			print(host.skill_stack)
			
		elif event.is_action_pressed("Item"):
			host.skill_stack.append("Up")
			host.inputMoves.inputtedMoves.set_arrow_direction("Up")
			print(host.skill_stack)
		
		if host.skill_stack.size() == BattleSettings.inputs_allowed:
			print("Confirm?")
		
func set_active_camera(host, camera):
	camera.move_to(host.current_unit.get_unit_cam().global_position)
	camera.rotate_to(host.current_unit.get_unit_cam().rotation)
	
func exit(host):
	host.inputMoves.visible = false
	host.playerTurnUI.play_exit_health()
	host.inputMoves.inputtedMoves.clear_all_arrows()
