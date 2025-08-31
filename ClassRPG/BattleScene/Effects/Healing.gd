extends Effect

class_name Healing

static func do_effect(current_unit: Unit, allies: Array[Unit], enemy: Unit, skill: Skill):
	print("healing")
	for ally in allies:
		if ally.name != current_unit.name:
			if ally.current_health + skill.damage > ally.max_health:
				ally.set_overhealth(ally.current_health + skill.damage - ally.max_health)
			print(ally.current_health + skill.damage)
			ally._set_health(ally.current_health + skill.damage)
			
	return skill.damage
