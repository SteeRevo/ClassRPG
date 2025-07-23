extends PathFollow3D

var start_path = false
@export var path_prog = 0.0
@export var is_enemy = false

func _ready():
	progress = path_prog
	
func reset_progress():
	progress = path_prog
	start_path = false

func _process(delta):
	if start_path:
		progress += 0.01

func start():
	start_path = true
