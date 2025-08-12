extends Label

var base_damage = 0

func _add_skill_damage(damage):
	base_damage += damage
	
func _reset_damage():
	base_damage = 0
	update_text()

func update_text():
	text = str(base_damage)
	
func set_skill_name(skillname):
	$Label.text = skillname
