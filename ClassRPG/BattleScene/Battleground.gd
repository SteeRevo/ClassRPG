extends Node3D

var currentUnit = null : set = _set_current_unit, get = _get_current_unit

func _set_current_unit(unit):
	currentUnit = unit
	
func _get_current_unit():
	return currentUnit
	

func set_current_unit_position():
	currentUnit.position = global_position
