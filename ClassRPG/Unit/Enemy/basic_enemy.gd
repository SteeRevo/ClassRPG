extends "res://Unit/Unit.gd"

@export var height = 0
signal anim_finished

func _ready():
	_set_base_skills()
	$CameraPath/PathFollow3D.is_enemy = true
	play_battle_idle()
	

func get_enemy_action():
	"""var decision = randi() % 2
	if decision == 1:
		return("Rotate")
	else:"""
	return("Attack")

func get_attack_stack():
	return ["Attack"]
	
	

func on_tween_finished():
	tween_finished.emit()
	
func _set_base_skills():
	active_skills.append(Skill.new("Attack", 4, 5, [""]))
	
func get_skill(skill_name):
	for skill in active_skills:
		if skill.skillname == skill_name:
			return skill
	return "No move found"


func _on_animation_player_animation_finished(anim_name):
	print("anim signal emitted")
	anim_finished.emit(anim_name)
