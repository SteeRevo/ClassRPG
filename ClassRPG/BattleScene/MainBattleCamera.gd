extends Camera3D

var camTween
signal cam_tween_finished
@onready var animator = $AnimationPlayer

func move_to(target_pos):
	camTween = get_tree().create_tween()
	camTween.connect("finished", on_tween_finished)
	camTween.tween_property(self, "position", target_pos, 0.5)
	

func on_tween_finished():
	cam_tween_finished.emit()
