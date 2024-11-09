extends Node3D
var player_
var currentBattleGround : set = _set_BG, get = get_BG

enum battleGrounds {F, TW, BW, B}

@export var max_health = 1 : set = _set_health, get = _get_health
@export var current_health = 1
@export var attack = 0
@export var defense = 0
@export var speed = 0
@export var is_dead = false
@export var enemy_unit = false
@export var available = true

var unitTween
var skill_tree
var skillList = []
var active_skills = []
var base_skills = []


var turn_order = 100 : set = _set_turn_order, get = _get_turn_order

signal attack_finished
signal rotate_finished

@export var startingBG : int = battleGrounds.F

func _set_base_skills():
	active_skills.append(Skill.new("Left", 0, 1, ["Left"]))
	active_skills.append(Skill.new("Right", 0, 1, ["Right"]))
	active_skills.append(Skill.new("Up", 0, 1, ["Up"]))
	active_skills.append(Skill.new("Down", 0, 1, ["Down"]))


#func move_towards(target_pos):
#	unitTween = get_tree().create_tween().tween_property(self, "position", target_pos, 1)

func attack_unit(target_unit, skill):
	var skill_stats = null
	for _skill in active_skills:
		if _skill.skillname == skill:
			skill_stats = _skill
	if skill_stats == null:
		printerr("skill not found")
		return
	var total_attack = attack + skill_stats.damage
	target_unit._set_health(target_unit._get_health() - total_attack)
	print("used ", skill_stats.skillname)
	print("did ", total_attack, " to ", target_unit.name)
	print(target_unit.name, " current health is ", target_unit._get_health())
	return total_attack
	
func _set_health(_health):
	if(_health <= max_health):
		current_health = _health
	if current_health < 0:
		print("Unit is dead")
		is_dead = true

func _get_health():
	return current_health

func _get_speed():
	return speed
	
func _set_turn_order(turn_ord):
	if(turn_ord < 0):
		turn_order = 0
	else:
		turn_order = turn_ord

func _get_turn_order():
	return turn_order
	
func _set_BG(BG):
	currentBattleGround = BG
	
func get_BG():
	return currentBattleGround
	
func get_BG_attacker_pos():
	var attacker_pos = Vector3(currentBattleGround.get_attacker_pos().global_position.x, self.global_position.y, currentBattleGround.get_attacker_pos().global_position.z)
	return attacker_pos
	
func get_death():
	return is_dead
	
func kill_self():
	queue_free()


func calc_turn_order(action_weight):
	_set_turn_order(action_weight - speed)
	return _get_turn_order()
