extends MeshInstance3D


func set_BG_position(bg):
	global_position = Vector3(bg.global_position.x, bg.global_position.y + 3, bg.global_position.z)
