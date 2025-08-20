extends Resource

class_name Skill

enum BG {BattlegroundVanguard, BattlegroundTopwing, BattlegroundBottomWing, BattlegroundSupport}
@export var skillname: String
@export var delay: int
@export var damage: int
@export var inputs: PackedStringArray
@export var is_active: bool
@export var active_positions: Array[BG]
@export var position_swap = []
@export var effect: Effect

func _init(name = "skill", _delay = 0, _damage = 0, _inputs = [], _position_swap = [], _effect = Attack.new()):
	skillname = name;
	delay = _delay
	damage = _damage
	inputs = _inputs
	is_active = false
	position_swap = _position_swap
	effect = _effect
	
	
	
	
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
