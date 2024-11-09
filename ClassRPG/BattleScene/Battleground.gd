extends Node3D

var current_unit = null : set = _set_current_unit, get = _get_current_unit

@onready var attackerPos = $AttackerPos

func _set_current_unit(unit):
	current_unit = unit
	
func _get_current_unit():
	return current_unit
	
func get_attacker_pos():
	return attackerPos
	
func remove_current_unit():
	current_unit = null

func set_current_unit_position():
	current_unit.position = global_position
