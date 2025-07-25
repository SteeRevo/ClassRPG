extends Node3D
class_name Unit
var player_
var currentBattleGround : set = _set_BG, get = get_BG
@onready var ap = $AnimationPlayer

enum battleGrounds {F, TW, BW, B}

@export var max_health = 1
@export var current_health = 1
@export var current_sp = 1
@export var max_sp = 1
@export var attack = 0
@export var defense = 0
@export var technique = 0
@export var speed = 1
@export var is_dead = false
@export var enemy_unit = false
@export var available = true
@onready var camera_path = $CameraPath/PathFollow3D
@onready var attack_cam = $AttackCam
@onready var attack_cam_base_position = attack_cam.global_position
@onready var attack_cam_base_rotation = attack_cam.rotation
@onready var moveSpeed = 15

signal tween_finished

var is_guarding = false
var attack_bonus = 0
var defense_bonus = 0
var tech_bonus = 0
var speed_bonus = 0
var bg_attack_bonus = 0
var bg_defense_bonus = 0
var bg_tech_bonus = 0
var bg_speed_bonus  = 0
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
signal attack_hit

@export var startingBG : int = battleGrounds.F

func _set_base_skills():
	active_skills.append(Skill.new("Left", 1, 1, ["Left"]))
	active_skills.append(Skill.new("Right", 1, 1, ["Right"]))
	active_skills.append(Skill.new("Up", 1, 1, ["Up"]))
	active_skills.append(Skill.new("Down", 1, 1, ["Down"]))


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
	if attached_spirits.find_key(skill_stats.skillname):
		spirit_bonus = attached_spirits[skill_stats.skillname].get_input_atk_bonus()
	print(attack)
	print(skill_stats.damage)
	print(spirit_bonus)
	print(target_unit.get_defense())
	var total_attack = (attack + skill_stats.damage + spirit_bonus) - target_unit.get_defense()
	if total_attack <= 0:
		total_attack = 1
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
		
func use_sp(cost):
	if current_sp < cost:
		return false
	else:
		current_sp -= cost
		print("current sp: ", current_sp)
		return true
		
func set_sp(_sp):
	if(_sp <= max_sp):
		current_sp = _sp
	else:
		current_sp = max_sp
		
func get_sp():
	return current_sp

func get_max_sp():
	return max_sp

func _get_health():
	return current_health
	
func get_max_health():
	return max_health

func get_technique():
	return technique + bg_tech_bonus + tech_bonus
	
func add_tech_buff(boost):
	tech_bonus += boost
	
func set_bg_tech_buff(boost):
	bg_tech_bonus = boost
	
func get_speed():
	return speed + bg_speed_bonus + speed_bonus
	
func add_speed_buff(boost):
	speed_bonus += boost
	
func set_bg_speed_buff(boost):
	bg_speed_bonus = boost
		
func get_defense():
	return defense + bg_defense_bonus + defense_bonus

func add_defense_buff(boost):
	defense_bonus += boost
	
func set_bg_defense_buff(boost):
	bg_defense_bonus = boost
	
func get_attack():
	return attack + bg_attack_bonus + attack_bonus
	
func add_attack_buff(boost):
	attack += boost

func set_bg_attack_buff(boost):
	bg_attack_bonus = boost

func add_health(boost):
	_set_health(current_health + boost)

func add_sp(boost):
	set_sp(current_sp + boost)
	
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
	
func play_getting_hit():
	ap.play("getting_hit")
	ap.queue("BattleIdle")
	
func attack_hits():
	attack_hit.emit()
	
func get_camera_path():
	return camera_path
	
func get_attack_cam():
	return attack_cam
	
func play_skill(attack_name):
	ap.play(attack_name)
	
func play_battle_idle():
	ap.play("BattleIdle")
	
func reset_attack_cam():
	attack_cam.global_position = attack_cam_base_position
	attack_cam.rotation = attack_cam_base_rotation
	
func move_towards(target_pos):
	unitTween = get_tree().create_tween()
	ap.play("Rotate")
	unitTween.connect("finished", on_tween_finished)
	unitTween.tween_property(self, "position", target_pos, get_move_time(target_pos))
	
func on_tween_finished():
	tween_finished.emit()
	
func attach_spirit(spirit_name):
	var new_spirit = Spirit.new(spirit_name)
	attached_spirits["Left"] = new_spirit
	print(attached_spirits)

func get_move_time(target_pos):
	var distance = global_position.distance_to(target_pos)
	return distance/moveSpeed
