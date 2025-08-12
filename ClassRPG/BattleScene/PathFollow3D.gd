extends PathFollow3D

@export var path_prog:int 
@export var is_enemy = false

func _ready():
	progress = path_prog
	
func reset_progress():
	progress = path_prog
	print("camera progress " + str(progress))


func _input(event):
	if event.is_action("ScrollLeft"):
		progress += 0.5
	elif event.is_action("ScrollRight"):
		progress -= 0.5

