extends Panel


@export var spirit: Spirit

func set_sprite():
	$Sprite2D.texture = spirit.texture
