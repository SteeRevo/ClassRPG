extends States

var current_cam
var timer
@onready var host_ref = %BattleManager

func enter(host):
	host.stateName.set_state_name("Enemy Turn")
	print("============Enemy turn=============")
	print(host.current_unit)
	set_active_camera(host, host.mainBattleCamera)
	timer = host.enemy_timer
	timer.start()
	
func update(host, delta):
	current_cam.move_to(host.current_unit.get_camera_path().global_position)
	current_cam.look_at(host.current_unit.global_position + Vector3(0, 2, 0), Vector3(0, 1, 0))

func set_active_camera(host, camera):
	current_cam = camera
	camera.move_to(host.current_unit.get_camera_path().global_position)
	host.current_unit.get_camera_path().start()


func _on_enemy_timer_timeout():
	print("getting enemy action")
	timer.stop()
	host_ref.current_action = host_ref.current_unit.get_enemy_action()
	print(host_ref.current_action)
	if host_ref.current_action == "Attack":
		host_ref.skill_stack = host_ref.current_unit.get_attack_stack()
		host_ref.current_selected_enemy = host_ref.BGF._get_current_unit()
	host_ref.complete_enemy_action()
