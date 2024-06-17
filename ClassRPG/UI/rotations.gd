extends Resource

class_name Rotation

var rotations = []

func add_rotation(bgStart, bgEnd, type):
	rotations.push_back([bgStart, bgEnd])
	rotations.push_back(type)
