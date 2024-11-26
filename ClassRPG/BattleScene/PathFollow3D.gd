extends PathFollow3D

var start_path = false
@export var path_prog = 0
var is_enemy = false

func _ready():
	progress = path_prog
	
func reset_progress():
	progress = path_prog
	start_path = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_path:
		if !is_enemy:
			progress += 0.01
		else:
			progress -= 0.01
		
	
func start():
	start_path = true
