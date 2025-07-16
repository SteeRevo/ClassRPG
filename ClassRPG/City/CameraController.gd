extends Node3D

@export var player:Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera3D.look_at(player.global_transform.origin, Vector3.UP)



func _on_area_3d_body_entered(body):
	if body.name == "PhyllisCollision" and $Camera3D.current != true:
		$Camera3D.current = true
		body.set_current_camera($Camera3D)
		print("entered area")


func _on_area_3d_body_exited(body):
	if body.name == "PhyllisCollision" and $Camera3D.current == true:
		$Camera3D.current = false
		print("exit area")
