extends Camera3D

var camTween
signal cam_tween_finished
signal one_time_finished
signal rotate_tween_finished
@onready var animator = $AnimationPlayer

func move_to(target_pos, time=0.5):
	camTween = get_tree().create_tween()
	camTween.connect("finished", on_tween_finished)
	camTween.tween_property(self, "position", target_pos, time)
	
func move_to_once(target_pos, time=0.5):
	camTween = get_tree().create_tween()
	camTween.connect("finished", on_tween_finished_once)
	camTween.tween_property(self, "position", target_pos, time)
	
func move_to_loop(target_pos, time=0.5):
	camTween = get_tree().create_tween()
	#camTween.connect("finished", on_tween_finished)
	camTween.tween_property(self, "position", target_pos, time)
	
func rotate_to(target_rot, time=0.5):
	camTween = get_tree().create_tween()
	camTween.connect("finished", on_rotate_tween_finished)
	camTween.tween_property(self, "rotation", target_rot, time)

func rotate_to_once(target_rot, time=0.5):
	camTween = get_tree().create_tween()
	camTween.connect("finished", on_rotate_tween_finished)
	camTween.tween_property(self, "rotation", target_rot, time)

func on_tween_finished():
	cam_tween_finished.emit()
	
func on_tween_finished_once():
	one_time_finished.emit()
	
func kill_tween():
	camTween.kill()
	
func on_rotate_tween_finished():
	rotate_tween_finished.emit()
