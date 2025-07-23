extends States


var EquipSelectMenu = ["BB", "Sam", "Phyllis"]
var firstEnter = true

func enter(host):
	print("Equip Sprit")
	host.equipMenu.visible = true
	host.current_move = null
	
	host.equipMenu.set_option(host.current_unit)
	play_menu_animation(host, host.current_unit)
	host.sam_anim_noplay = false
	
func exit(host):
	firstEnter = true
	host.equipMenu.visible = false
	
func handle_input(host, event):
	if event.is_action_pressed("Rotate"):
		if(host.current_option < EquipSelectMenu.size() - 1):
			host.current_option = min(EquipSelectMenu.size() - 1, host.current_option + 1)
			host.equipMenu.set_option(EquipSelectMenu[host.current_option])
			play_menu_animation(host, EquipSelectMenu[host.current_option])
	elif event.is_action_pressed("Item"):
		if(host.current_option > 0):
			host.current_option = max(0, host.current_option - 1)
			host.equipMenu.set_option(EquipSelectMenu[host.current_option])
			play_menu_animation(host, EquipSelectMenu[host.current_option])
	elif event.is_action_pressed("Interact"):
		host.current_unit = EquipSelectMenu[host.current_option]
		return 'equipUnit'
	elif event.is_action_pressed("Cancel"):
		return "previous"
	
	
func update(host, delta):
	return

func play_menu_animation(host, character):
	
	match character:
		"Sam":
			host.Sam.stop()
			if !host.sam_anim_noplay:
				host.Sam.play("EquipSpirit")
			else:
				host.Sam.play_backwards("EquipMiddleStart")
			host.Sam.queue("EquipSelected")
			host.menuCam.move_to(host.SamEquipCamera.global_position)
			host.menuCam.rotate_to(host.SamEquipCamera.rotation)
			host.BB.play_backwards("EquipSpirit")
			host.Phyllis.play_backwards("EquipSpirit")
		"BB":
			host.BB.stop()
			host.BB.play("EquipSpirit")
			host.BB.queue("EquipSelected")
			host.menuCam.move_to(host.BBEquipCamera.global_position)
			host.menuCam.rotate_to(host.BBEquipCamera.rotation)
			if firstEnter == false:
				host.Sam.play_backwards("EquipSpirit")
			else:
				firstEnter = false
		"Phyllis":
			host.Phyllis.stop()
			if !host.sam_anim_noplay:
				host.Phyllis.play("EquipSpirit")
			else:
				host.Phyllis.play_backwards("EquipMiddleStart")
			host.Phyllis.queue("EquipSelected")
			host.menuCam.move_to(host.PhilEquipCamera.global_position)
			host.menuCam.rotate_to(host.PhilEquipCamera.rotation)
			host.Sam.play_backwards("EquipSpirit")
	host.BB.queue("MenuBase")
	host.Sam.queue("MenuBase")
	host.Phyllis.queue("MenuBase")
