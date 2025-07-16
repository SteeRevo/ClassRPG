extends CharacterBody3D


const SPEED = 2
@export var forwardDir:Node3D
@export var camera:Camera3D
var in_dialogue
@export var movementType: String

func _ready():
	SignalBus.connect("in_dialogue", enter_dialogue)

func _physics_process(delta):
	if movementType == "Town":
		var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		
		var forward = camera.global_transform.basis.z
		var right = camera.global_transform.basis.x
		
		var direction = forward * input_dir.y + right * input_dir.x
		direction.y = 0.0
		direction = direction.normalized()
		
		if !in_dialogue:
			if direction:
				velocity.x = direction.x * SPEED
				velocity.z = direction.z * SPEED
				$Phyllis.look_at(global_position + direction, Vector3.UP)
				play_walk()
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				velocity.z = move_toward(velocity.z, 0, SPEED)
				play_idle()

			move_and_slide()
		
	elif movementType == "Dungeon":
		var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
		

		
	else:
		print("No movement type selected")
	
func play_idle():
	$Phyllis/AnimationPlayer.play("OverworldIdle")

func play_walk():
	$Phyllis/AnimationPlayer.play("Walk")

func enter_dialogue(status):
	in_dialogue = status
	print(status)
	
func set_current_camera(_camera):
	camera = _camera
	#self.rotation.y = camera.rotation.y
	#self.rotation.x = camera.rotation.x
