extends "res://Unit/Unit.gd"

@export var height = 0
signal anim_finished
signal tween_finished

func _ready():
	_set_base_skills()
	$CameraPath/PathFollow3D.is_enemy = true

func get_enemy_action():
	"""var decision = randi() % 2
	if decision == 1:
		return("Rotate")
	else:"""
	return("Attack")

func get_attack_stack():
	return ["Attack"]
	
func play_attack(attack_name):
	ap.play(attack_name)
	
func move_towards(target_pos):
	unitTween = get_tree().create_tween()
	ap.play("Rotate")
	unitTween.connect("finished", on_tween_finished)
	unitTween.tween_property(self, "position", target_pos, 1)
	

func on_tween_finished():
	tween_finished.emit()
	
func _set_base_skills():
	active_skills.append(Skill.new("Attack", 1, 1, [""]))


func _on_animation_player_animation_finished(anim_name):
	print("anim signal emitted")
	anim_finished.emit(anim_name)
