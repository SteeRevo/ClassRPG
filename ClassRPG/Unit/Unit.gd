extends Node3D
var player_
var currentBattleGround : set = _set_BG, get = get_BG

enum battleGrounds {F, TW, BW, B}

@export var max_health = 1
@export var current_health = 1
@export var current_mana = 1
@export var max_mana = 1
@export var attack = 0
@export var defense = 0
@export var technique = 0
@export var is_dead = false
@export var enemy_unit = false
@export var available = true

var is_guarding = false
var attack_bonus = 0
var defense_bonus = 0
var tech_bonus = 0
var bg_attack_bonus = 0
var bg_defense_bonus = 0
var bg_tech_bonus = 0
var temp_health = 0
var unitTween
var skill_tree
var skillList = []
var active_skills = []
var base_skills = []
var attached_spirits = {
	"Left": null,
	"Right": null,
	"Up": null,
	"Down": null
}


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
	var spirit_bonus = 0
	for _skill in active_skills:
		if _skill.skillname == skill:
			skill_stats = _skill
	if skill_stats == null:
		printerr("skill not found")
		return
	if attached_spirits[skill_stats.skillname]:
		spirit_bonus = attached_spirits[skill_stats.skillname].get_input_atk_bonus()
	var total_attack = (attack + skill_stats.damage + spirit_bonus) - target_unit.get_defense()
	target_unit._set_health(target_unit._get_health() - total_attack)
	print("used ", skill_stats.skillname)
	print("did ", total_attack, " to ", target_unit.name)
	print(target_unit.name, " current health is ", target_unit._get_health())
	return total_attack
	
func _set_health(_health):
	if(_health <= max_health):
		current_health = _health
	else:
		current_health = max_health
	if current_health <= 0:
		print("Unit is dead")
		is_dead = true
		
func use_mana(cost):
	if current_mana < cost:
		return false
	else:
		current_mana -= cost
		print("current mana: ", current_mana)
		return true
		
func set_mana(_mana):
	if(_mana <= max_mana):
		current_mana = _mana
	else:
		current_mana = max_mana
		
func get_mana():
	return current_mana

func _get_health():
	return current_health

func get_technique():
	return technique + bg_tech_bonus 
	
func add_tech_buff(boost):
	tech_bonus += boost
	
func set_bg_tech_buff(boost):
	bg_tech_bonus = boost
	
func get_defense():
	return defense + bg_defense_bonus

func add_defense_buff(boost):
	defense_bonus += boost
	
func set_bg_defense_buff(boost):
	bg_defense_bonus = boost
	
func get_attack():
	return attack + bg_attack_bonus
	
func add_attack_buff(boost):
	attack += boost

func set_bg_attack_buff(boost):
	bg_attack_bonus = boost

func add_health(boost):
	_set_health(current_health + boost)

func add_mana(boost):
	set_mana(current_mana + boost)
	
func reset_attack():
	attack_bonus = 0
	
func reset_defense():
	defense_bonus = 0

func reset_tech():
	tech_bonus = 0
	
	
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
	
func set_guard():
	is_guarding = true
	
func end_guard():
	is_guarding = false
	
func attach_spirit(spirit_name):
	var new_spirit = Spirit.new(spirit_name)
	attached_spirits["Left"] = new_spirit
	print(attached_spirits)
