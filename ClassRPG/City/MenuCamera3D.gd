extends Camera3D

var camTween
signal cam_tween_finished
@onready var animator = $AnimationPlayer

func move_to(target_pos):
	print(target_pos)
	print(global_position)
	camTween = get_parent().create_tween()
	camTween.connect("finished", on_tween_finished)
	camTween.tween_property(self, "position", target_pos, 0.5)
	
func rotate_to(target_rot):
	camTween = get_parent().create_tween()
	camTween.connect("finished", on_tween_finished)
	camTween.tween_property(self, "rotation", target_rot, 0.5)

func on_tween_finished():
	cam_tween_finished.emit()
	print("tween finished")
