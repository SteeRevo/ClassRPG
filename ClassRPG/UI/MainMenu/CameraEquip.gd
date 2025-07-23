extends Node


func get_direction(direction):
	match direction:
		"Base":
			return $Middle
		"Right":
			return $Right
		"Left":
			return $Left
		"Down":
			return $Down
		"Up":
			return $Up
