extends Node3D
@export var player:Node3D
@onready var camera = $Camera3D

@export var stage_dimension:Vector2
@export var limit1: Node3D
@export var limit2: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	print(global_position)
	print(limit1.global_position)
	print(limit2.global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position = lerp(global_position, player.global_transform.origin, delta*10.0)
	global_position.x = clampf(global_position.x, limit1.global_position.x, limit2.global_position.x)
	global_position.z = clampf(global_position.z, limit1.global_position.z, limit2.global_position.z)
	print(global_position)
	print(player.global_transform.origin)
	print(limit1.global_position)
	print(limit2.global_position)
	
	#position.x = clamp(position.x, -stage_dimension.x/2, stage_dimension.x/2)
	#position.z = clamp(position.z, -stage_dimension.y/2, stage_dimension.y/2)
	
	camera.look_at((player.global_transform.origin + global_position)/2, Vector3.UP)
	
	$MeshInstance3D.global_position = player.global_transform.origin
