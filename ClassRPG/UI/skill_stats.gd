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
	
