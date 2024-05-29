extends Resource

class_name Skill

@export var skillname: String
@export var cost: int
@export var damage: int

func _init(name = "skill", _cost = 0, _damage = 0):
	skillname = name;
	cost = _cost
	damage = _damage
	
