extends Panel

@onready var arrow_sprite = $Arrow

func set_arrow(direction):
	match direction:
		"Left":
			arrow_sprite.rotation_degrees = 90.0
			arrow_sprite.flip_v = true
		"Right":
			arrow_sprite.rotation_degrees = 90.0
		"Down":
			arrow_sprite.flip_v = true
		_:
			pass
