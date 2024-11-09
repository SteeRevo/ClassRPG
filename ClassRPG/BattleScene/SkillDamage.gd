extends TextEdit

var base_damage = 0

func _add_skill_damage(damage):
	base_damage += damage
	_update_text()
	
func _reset_damage():
	base_damage = 0
	_update_text()

func _update_text():
	text = "Damage: " + str(base_damage)
