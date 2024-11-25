extends PathFollow3D

var start_path = false
@export var path_prog = 0

func _ready():
	progress = path_prog

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_path:
		progress += 0.01
		
	
func start():
	start_path = true
