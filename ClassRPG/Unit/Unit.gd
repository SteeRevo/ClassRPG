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

var unitTween
var skill_tree


var turn_order = 100 : set = _set_turn_order, get = _get_turn_order

signal attack_finished
signal rotate_finished

@export var startingBG : int = battleGrounds.F


func move_towards(target_pos):
	unitTween = get_tree().create_tween().tween_property(self, "position", target_pos, 1)

func attack_unit(target_unit):
	pass
	
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
	


func calc_turn_order(action_weight):
	_set_turn_order(action_weight - speed)
	return _get_turn_order()
