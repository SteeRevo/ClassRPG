extends States

func enter(host):
	print("Main Menu")
	play_menu_animation(host)
	host.baseMenu.visible = true
	host.current_unit = "BB"
	host.current_option = 0
	
func exit(host):
	host.baseMenu.visible = false
	
func handle_input(host, event):
	if get_tree().paused == true:
		if event.is_action_pressed("Rotate"):
			host.set_menu_pointer("Down")
		elif event.is_action_pressed("Item"):
			host.set_menu_pointer("Up")
		elif event.is_action_pressed("Cancel"):
			host.set_invisible()
		elif event.is_action_pressed("Interact"):
			var option = select_current_option(host)
			return option
	elif event.is_action_pressed("Cancel") and get_tree().paused == false:
		host.set_viewable()

func update(host, delta):
	return

func select_current_option(host):
	var option = host.menuOptions[host.currentOption].get_parent().name
	if option == "EquipSpirit":
		return "equip"
	if option == "Status":
		return "status"

func play_menu_animation(host):
	host.BB.play("MenuBase")
	host.Phyllis.play("MenuBase")
	host.Sam.play("MenuBase")
	host.menuCam.move_to(host.MenuBaseCamera.global_position)
	host.menuCam.rotate_to(host.MenuBaseCamera.rotation)
