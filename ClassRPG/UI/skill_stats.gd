extends Resource

class_name Skill

@export var skillname: String
@export var cost: int
@export var damage: int
@export var inputs: PackedStringArray
@export var is_active: bool

func _init(name = "skill", _cost = 0, _damage = 0, _inputs = []):
	skillname = name;
	cost = _cost
	damage = _damage
	inputs = _inputs
	is_active = false
	
func compare_inputs(arr):
	var i = 0; var j = 0;
	var l1 = len(inputs)
	var l2 = len(arr)
	
	if l1 < l2:
		return false
		
	var startpoint
	while i < l1 and j < l2:
		if inputs[i] == arr[j]:
			if j == 0:
				return true
			i+=1
			j+=1
			
			if j == l2:
				return startpoint
	
		else:
			i = i - j + 1
			j = 0
	return false
	
