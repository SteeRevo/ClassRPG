extends Control

@onready var mode = $Mode

func set_mode(direction):
	mode.text = direction
