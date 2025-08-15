extends Node3D

enum BG {V, TW, BW, S}

var current_unit = null : set = _set_current_unit, get = _get_current_unit
@export var bgType = BG.V

@onready var attackerPos = $AttackerPos
@export var attack_boost = 0
@export var health_regen = 0
@export var defense_boost = 0
@export var tech_boost = 0
var added_health = false


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
	
func add_attack_boost():
	current_unit.set_bg_attack_buff(attack_boost)
	
func add_defense_boost():
	current_unit.set_bg_defense_buff(defense_boost)
	
func add_tech_boost():
	current_unit.set_bg_tech_buff(tech_boost)
	
func regen_health():
	if !added_health:
		current_unit.add_health(health_regen)
		added_health = true

	
func add_buffs():
	add_attack_boost()
	add_defense_boost()
	add_tech_boost()
	regen_health()

func reset_buffs():
	current_unit.reset_attack()
	current_unit.reset_defense()
	current_unit.reset_tech()
	
func reset_health_sp():
	added_health = false

	
