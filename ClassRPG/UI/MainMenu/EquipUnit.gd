extends States
@export var bbCamEquip:Node
@export var samCamEquip:Node
var current_state

func enter(host):
	print("Equip Unit")
	print(host.current_unit)
	host.equipUnit.visible = true
	play_menu_animation(host, host.current_unit, "Middle")
	current_state = "Middle"
	
func exit(host):
	host.equipUnit.visible = false
	host.sam_anim_noplay = true
	
func handle_input(host, event):
	if event.is_action_pressed("Rotate") and current_state != "Down":
		play_menu_animation(host, host.current_unit, "Down")
		current_state = "Down"
	elif event.is_action_pressed("Item") and current_state != "Up":
		play_menu_animation(host, host.current_unit, "Up")
		current_state = "Up"
	elif event.is_action_pressed("Guard") and current_state != "Right":
		play_menu_animation(host, host.current_unit, "Right")
		current_state = "Right"
	elif event.is_action_pressed("Attack") and current_state != "Left":
		play_menu_animation(host, host.current_unit, "Left")
		current_state = "Left"
	elif event.is_action_pressed("Cancel") and current_state == "Middle":
		return "previous"
	elif event.is_action_pressed("Cancel"):
		play_menu_animation(host, host.current_unit, "Middle")
		current_state = "Middle"
	
	
func update(host, delta):
	return

func play_menu_animation(host, character, direction):
	
	match character:
		"Sam":
			host.Sam.stop()
			match direction:
				"Middle":
					host.Sam.play("EquipMiddleStart")
					host.Sam.queue("EquipMiddleLoop")
				"Left":
					host.Sam.play("EquipLeftStart")
					host.Sam.queue("EquipLeftLoop")
				"Right":
					host.Sam.play("EquipRightStart")
					host.Sam.queue("EquipRightLoop")
				"Down":
					host.Sam.play("EquipDownStart")
					host.Sam.queue("EquipDownLoop")
				"Up":
					host.Sam.play("EquipUpStart")
					host.Sam.queue("EquipUpLoop")
			host.menuCam.move_to(samCamEquip.get_direction(direction).global_position)
			host.menuCam.rotate_to(samCamEquip.get_direction(direction).rotation)
		"BB":
			host.BB.stop()
			match direction:
				"Middle":
					host.BB.play("EquipMiddleStart")
					host.BB.queue("EquipMiddleLoop")
				"Left":
					host.BB.play("EquipLeftStart")
					host.BB.queue("EquipLeftLoop")
				"Right":
					host.BB.play("EquipRightStart")
					host.BB.queue("EquipRightLoop")
				"Down":
					host.BB.play("EquipDownStart")
					host.BB.queue("EquipDownLoop")
				"Up":
					host.BB.play("EquipUpStart")
					host.BB.queue("EquipUpLoop")
			host.menuCam.move_to(bbCamEquip.get_direction(direction).global_position)
			host.menuCam.rotate_to(bbCamEquip.get_direction(direction).rotation)
		"Phyllis":
			host.Phyllis.stop()
			host.Phyllis.play("EquipSpirit")
			host.Phyllis.queue("EquipSelected")
			host.menuCam.move_to(host.PhilEquipCamera.global_position)
			host.menuCam.rotate_to(host.PhilEquipCamera.rotation)
			host.Sam.play_backwards("EquipSpirit")
