extends PathFollow3D

@export var path_prog:int 
@export var is_enemy = false

@export var unit: Unit

func _ready():
	progress = path_prog
	
func reset_progress():
	progress = path_prog
	print("camera progress " + str(progress))
	
func _process(delta):
	if unit.name == "Sam":
		look_at(unit.global_position + Vector3(0, 2, 0), Vector3(0, 1, 0))
	else:
		look_at(unit.global_position + Vector3(0, 3, 0), Vector3(0, 1, 0))



func _input(event):
	if event.is_action("ScrollLeft"):
		progress += 0.5
	elif event.is_action("ScrollRight"):
		progress -= 0.5

