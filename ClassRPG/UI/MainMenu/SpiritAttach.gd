extends States

func enter(host):
	print("Spirit Selection")
	host.spiritAttach.visible = true


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
		print("attaching spirit")

func exit(host):
	host.spiritAttach.visible = false
