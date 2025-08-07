extends States

var StatusSelectMenu = ["BB", "Sam", "Phyllis"]

func enter(host):
	print("Status")
	host.statusMenu.visible = true
	host.statusMenu.set_all_stats("BB")
	play_menu_animation(host, host.current_unit)
	host.current_unit = "BB"
	host.current_status = 0
	
func exit(host):
	host.statusMenu.visible = false
	
func handle_input(host, event):
	if event.is_action_pressed("Rotate"):
		if(host.current_status < StatusSelectMenu.size() - 1):
			host.current_status = min(StatusSelectMenu.size() - 1, host.current_status + 1)
			host.statusMenu.set_all_stats(StatusSelectMenu[host.current_status])
			play_menu_animation(host, StatusSelectMenu[host.current_status])
	elif event.is_action_pressed("Item"):
		if(host.current_status > 0):
			host.current_status = max(0, host.current_status - 1)
			host.statusMenu.set_all_stats(StatusSelectMenu[host.current_status])
			play_menu_animation(host, StatusSelectMenu[host.current_status])
	elif event.is_action_pressed("Cancel"):
		return "previous"


func play_menu_animation(host, character):
	
	match character:
		"Sam":
			host.Sam.play("StatusEntry")
			host.menuCam.move_to(host.SamEquipCamera.global_position)
			host.menuCam.rotate_to(host.SamEquipCamera.rotation)
			host.Sam.queue("StatusLoop")
		"BB":
			host.menuCam.move_to(host.BBEquipCamera.global_position)
			host.menuCam.rotate_to(host.BBEquipCamera.rotation)
		"Phyllis":
			host.menuCam.move_to(host.PhilEquipCamera.global_position)
			host.menuCam.rotate_to(host.PhilEquipCamera.rotation)
