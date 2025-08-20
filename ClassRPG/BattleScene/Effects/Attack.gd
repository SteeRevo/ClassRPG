extends Effect

class_name Attack

static func do_effect(current_unit: Unit, allies: Array[Unit], enemy: Unit, skill: Skill):
	var spirit_bonus = 0
	if skill.skillname in current_unit.attached_spirits:
		spirit_bonus = current_unit.attached_spirits[skill.skillname].get_input_atk_bonus()
	print(skill.damage)
	print(spirit_bonus)
	print(enemy.get_defense())
	var total_attack = (current_unit.attack + skill.damage + spirit_bonus) - enemy.get_defense()
	if total_attack <= 0:
		total_attack = 1
	enemy._set_health(enemy._get_health() - total_attack)
	print("used ", skill.skillname)
	print("did ", total_attack, " to ", enemy.name)
	print(enemy.name, " current health is ", enemy._get_health())
	return total_attack
