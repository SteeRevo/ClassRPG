extends States

func enter(host):
	print("Spirit Selection")
	if host.current_move == "Base":
		host.battlegroundSpirit.visible = true
	else:
		host.inputSpirit.visible = true
	host.spiritAttach.visible = true
	host.menuCursor.set_cursor_from_index(0)

func handle_input(host, event):
	if event.is_action_pressed("Rotate"):
		host.menuCursor.set_cursor_from_index(host.menuCursor.cursor_index + 1 * host.menuCursor.menu_parent.columns)
	elif event.is_action_pressed("Item"):
		host.menuCursor.set_cursor_from_index(host.menuCursor.cursor_index - 1 * host.menuCursor.menu_parent.columns)
	elif event.is_action_pressed("Attack") :
		host.menuCursor.set_cursor_from_index(host.menuCursor.cursor_index + 1)
	elif event.is_action_pressed("Guard"):
		host.menuCursor.set_cursor_from_index(host.menuCursor.cursor_index - 1)
	elif event.is_action_pressed("Cancel"):
		return "previous"
	
	elif event.is_action_pressed("Interact"):
		#print(host.current_unit)
		var currentSpirit = host.spiritAttach.get_spirit(host.menuCursor.cursor_index)
		#print(host.current_move)
		if host.current_move != "Base":
			host.spiritAttach.remove_spirit(currentSpirit)
			var returnSpirit = BattleSettings.attach_spirit(host.current_unit, currentSpirit, host.current_move)
			if returnSpirit != null:
				host.spiritAttach.add_spirit(returnSpirit)
			host.spiritAttach.set_equipped_spirit(host.current_unit, host.current_move)

func exit(host):
	host.spiritAttach.visible = false
	host.battlegroundSpirit.visible = false
	host.inputSpirit.visible = false
