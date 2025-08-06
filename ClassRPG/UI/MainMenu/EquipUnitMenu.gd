extends Control

@onready var mode = $Mode

func set_mode(direction):
	if direction == "Base":
		mode.text = "Choose Direction"
		return
	mode.text = direction
