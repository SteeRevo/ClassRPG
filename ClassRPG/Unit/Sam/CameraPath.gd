extends Path3D

@export var unit: Unit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$TurnCamPosition.global_position = $PathFollow3D.global_position
	if unit.name == "Sam":
		$TurnCamPosition.look_at(unit.global_position + Vector3(0, 2, 0), Vector3(0, 1, 0))
	else: 
		$TurnCamPosition.look_at(unit.global_position + Vector3(0, 3, 0), Vector3(0, 1, 0))
