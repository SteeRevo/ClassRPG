extends Panel

@onready var arrow_sprite = $Arrow

func set_arrow(direction):
	arrow_sprite.visible = true
	match direction:
		"Left":
			arrow_sprite.rotation_degrees = 90.0
			arrow_sprite.flip_v = true
		"Right":
			arrow_sprite.rotation_degrees = 90.0
			arrow_sprite.flip_v = false
		"Down":
			arrow_sprite.rotation_degrees = 0.0
			arrow_sprite.flip_v = true
		"Up":
			arrow_sprite.rotation_degrees = 0.0
			arrow_sprite.flip_v = false
		_:
			printerr("error")
