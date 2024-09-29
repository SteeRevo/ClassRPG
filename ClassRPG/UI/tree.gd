extends Resource

class_name TreeSkill

@export var left : TreeSkill
@export var up : TreeSkill
@export var right : TreeSkill
@export var down : TreeSkill
@export var move_name : String

'''func set_skill_active(input):
	if input == "left":
		left = TreeSkill.new()
	elif input == "right":
		right = TreeSkill.new()
	elif input == "down":
		down = TreeSkill.new()
	elif input == "up":
		up = TreeSkill.new()'''
		
func _init():
	self.left = null
	self.right = null
	self.down = null
	self.up = null
	self.move_name = ""


	
