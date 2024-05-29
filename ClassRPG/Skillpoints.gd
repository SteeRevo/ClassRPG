extends TextEdit

@export var skillPoints = 5
@export var maxSkillPoints = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _add_skill_points(points):
	skillPoints += points
	if skillPoints > maxSkillPoints:
		skillPoints = maxSkillPoints
	_update_text()

func _subtract_skill_points(points):
	skillPoints -= points
	if skillPoints < 0:
		skillPoints = 0
		
func _get_skill_points():
	return skillPoints;
	
func _update_text():
	text = "Skill Points: " + str(skillPoints)
