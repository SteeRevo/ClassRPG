extends Node3D

var origin

var start_rotate = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Camera3D.current:
		rotation.y += 0.2 * delta
	else:
		reset_position()

func _ready():
	origin = global_position

func reset_position():
	global_position = origin
	

