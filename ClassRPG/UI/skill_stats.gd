extends Resource

class_name Skill

@export var skillname: String
@export var delay: int
@export var damage: int
@export var inputs: PackedStringArray
@export var is_active: bool
@export var active_position: String
@export var position_swap = []

func _init(name = "skill", _delay = 0, _damage = 0, _inputs = [], _active_position = '', _position_swap = []):
	skillname = name;
	delay = _delay
	damage = _damage
	inputs = _inputs
	is_active = false
	active_position = _active_position
	position_swap = _position_swap
	
	
	
func compare_inputs(arr):
	var i = 0; var j = 0;
	var l1 = len(arr)
	var l2 = len(inputs)
	
	if l1 < l2:
		return false

	while i < l1 and j < l2:
		if arr[i] == inputs[j]:
			i+=1
			j+=1
			
			if j == l2:
				return true
	
		else:
			return false
	return false
	
func substring_exists(arr):
	var i = 0; var j = 0;
	var l1 = len(inputs)
	var l2 = len(arr)
	
	if l1 < l2:
		return false

	while i < l1 and j < l2:
		if inputs[i] == arr[j]:
			i+=1
			j+=1
			
			if j == l2:
				return true
	
		else:
			return false
	return false
