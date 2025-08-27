extends 'Unit.gd'

@onready var playerTurnCam = $CameraPath/TurnCamPosition

func _ready():

	skill_tree = TreeSkill.new()
	skill_tree.move_name = "Root"
	
	for _skill in preSkillList:
		var new_skill = Skill.new()
		new_skill.skillname = _skill.skillname
		new_skill.damage = _skill.damage
		new_skill.delay = _skill.delay
		new_skill.inputs = _skill.inputs
		new_skill.active_positions = _skill.active_positions
		new_skill.is_active = _skill.is_active
		new_skill.effect = _skill.effect
		skillList.append(new_skill)
		if new_skill.is_active:
			print("adding to active skills")
			set_skill_active(new_skill)
		set_skill(new_skill)

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

func set_skill_active(skill):
	skill.is_active = true
	active_skills.push_back(skill)
