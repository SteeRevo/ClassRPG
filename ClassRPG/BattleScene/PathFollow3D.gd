extends PathFollow3D

var start_path = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_path:
		progress += 0.01
		
	
func start():
	start_path = true
