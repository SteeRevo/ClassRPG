extends 'Unit.gd'

func _ready():
	skill_tree = TreeSkill.new()
	skill_tree.move_name = "Root"

func set_unit_spirits(unit_stats):
	for move in attached_spirits:
		attached_spirits[move] = unit_stats.spirits[move]

func set_skill(skill: Skill):
	var curr = skill_tree
	for input in skill.inputs:
		match input:
			"Left":
				if curr.left == null:
					curr.left = TreeSkill.new()
				curr = curr.left
			"Right":
				if curr.right == null:
					curr.right = TreeSkill.new()
				curr = curr.right
			"Up":
				if curr.up == null:
					curr.up = TreeSkill.new()
				curr = curr.up
			"Down":
				if curr.down == null:
					curr.down = TreeSkill.new()
				curr = curr.down
	curr.move_name = skill.skillname
