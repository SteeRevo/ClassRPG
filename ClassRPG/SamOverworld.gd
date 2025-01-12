extends CharacterBody3D


const SPEED = 2
@export var camera : Camera3D
var in_dialogue

func _ready():
	self.rotation.y = camera.rotation.y
	SignalBus.connect("in_dialogue", enter_dialogue)

func _physics_process(delta):
	# Add the gravity.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	

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
	
func play_idle():
	$Phyllis/AnimationPlayer.play("OverworldIdle")

func play_walk():
	$Phyllis/AnimationPlayer.play("Walk")

func enter_dialogue(status):
	in_dialogue = status
	print(status)
