extends States

func enter(host):
	print("Main Menu")
	host.play_menu_animation("MenuBase")
	
func exit(host):
	return
	
func handle_input(host, event):
	if event.is_action_pressed("Rotate"):
		host.set_menu_pointer("Down")
	elif event.is_action_pressed("Item"):
		host.set_menu_pointer("Up")

func update(host, delta):
	return
