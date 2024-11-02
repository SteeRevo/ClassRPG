extends CharacterBody3D


const SPEED = 2.5
@onready var camera = $Camera3D


func _physics_process(delta):
	# Add the gravity.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var cam_basis = camera.global_transform.basis
	cam_basis = cam_basis.rotated(cam_basis.x, -cam_basis.get_euler().x)
	direction = cam_basis * direction
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		play_walk()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		play_idle()

	move_and_slide()
	
func play_idle():
	pass#$Sam/AnimationPlayer.play("idle")

func play_walk():
	pass#$Sam/AnimationPlayer.play("walk")

