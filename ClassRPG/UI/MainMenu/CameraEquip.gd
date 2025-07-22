extends Node


func get_direction(direction):
	match direction:
		"Middle":
			return $Middle
		"Right":
			return $Right
		"Left":
			return $Left
		"Down":
			return $Down
		"Up":
			return $Up
