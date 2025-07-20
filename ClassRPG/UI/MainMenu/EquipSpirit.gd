extends Node

var current_option = 0
var EquipSelectMenu = ["BB", "Sam", "Phyllis"]
var firstEnter = true

func enter(host):
	print("Equip Sprit")
	
	host.equipMenu.visible = true
	host.baseMenu.visible = false
	
	host.equipMenu.set_option("BB")
	play_menu_animation(host, "BB")
	
func exit(host):
	firstEnter = true
	host.equipMenu.visible = false
	host.baseMenu.visible = true
	
func handle_input(host, event):
	if event.is_action_pressed("Rotate"):
		if(current_option < EquipSelectMenu.size() - 1):
			current_option = min(EquipSelectMenu.size() - 1, current_option + 1)
			host.equipMenu.set_option(EquipSelectMenu[current_option])
			play_menu_animation(host, EquipSelectMenu[current_option])
	elif event.is_action_pressed("Item"):
		if(current_option > 0):
			current_option = max(0, current_option - 1)
			host.equipMenu.set_option(EquipSelectMenu[current_option])
			play_menu_animation(host, EquipSelectMenu[current_option])
	elif event.is_action_pressed("Cancel"):
		return "previous"
	
	
func update(host, delta):
	return

func play_menu_animation(host, character):
	
	match character:
		"Sam":
			host.Sam.stop()
			host.Sam.play("EquipSpirit")
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
			host.Phyllis.play("EquipSpirit")
			host.Phyllis.queue("EquipSelected")
			host.menuCam.move_to(host.PhilEquipCamera.global_position)
			host.menuCam.rotate_to(host.PhilEquipCamera.rotation)
			host.Sam.play_backwards("EquipSpirit")
	host.BB.queue("MenuBase")
	host.Sam.queue("MenuBase")
	host.Phyllis.queue("MenuBase")
