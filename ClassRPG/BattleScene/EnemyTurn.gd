extends States

var current_cam
var timer
var cam_look_at = 0
@onready var host_ref = %BattleManager

func enter(host):
	host.mainBattleCamera.kill_tween()
	cam_look_at = 0
	host.stateName.set_state_name("Enemy Turn")
	print("============Enemy turn=============")
	print(host.current_unit)
	#host.mainBattleCamera.rotate_tween_finished.connect(enable_cam_look_at)
	#host.mainBattleCamera.cam_tween_finished.connect(enable_cam_look_at)
	set_active_camera(host, host.mainBattleCamera)
	timer = host.enemy_timer
	timer.start()
	
	
func update(host, delta):
	pass

func set_active_camera(host, camera):
	current_cam = camera
	host.current_unit.get_camera_path().reset_progress()
	current_cam.move_to_once(host.current_unit.turn_cam.global_position)
	current_cam.rotate_to(host.current_unit.turn_cam.global_rotation)

func exit(host):
	#host.mainBattleCamera.rotate_tween_finished.disconnect(enable_cam_look_at)
	#host.mainBattleCamera.cam_tween_finished.disconnect(enable_cam_look_at)
	host.mainBattleCamera.kill_tween()

func _on_enemy_timer_timeout():
	print("getting enemy action")
	timer.stop()
	host_ref.current_action = host_ref.current_unit.get_enemy_action()
	print(host_ref.current_action)
	if host_ref.current_action == "Attack":
		host_ref.skill_stack = host_ref.current_unit.get_attack_stack()
		host_ref.current_selected_enemy = host_ref.BGV._get_current_unit()
	host_ref.get_total_delay(host_ref.skill_stack)
	host_ref.delay_turn_tracker()
	host_ref.complete_enemy_action()

