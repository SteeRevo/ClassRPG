extends Camera3D


@onready var animator = $AnimationPlayer

func start_anim():
	animator.play('idle')
