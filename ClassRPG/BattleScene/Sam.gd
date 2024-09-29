extends "../Unit/Unit.gd"

var skillList = []
var active_skills = []

@onready var ap = $Sam/AnimationPlayer

signal anim_finished

# Called when the node enters the scene tree for the first time.
func _ready():

	var skill = Skill.new()
	skill.skillname = "Rabbit: Bounce"
	skill.damage = 5
	skill.cost = 1
	skill.inputs = PackedStringArray(["Left", "Down", "Right"])

	var skill2 = Skill.new()
	skill2.skillname = "Snake: Whip"
	skill2.damage = "10"
	skill2.cost = 5
	skill2.inputs = PackedStringArray(["Left", "Left", "Right"])
	
	var skill3 = Skill.new()
	skill3.skillname = "Rooster: Flame"
	skill3.damage = 0
	skill3.cost = 3 
	skill3.inputs = PackedStringArray(["Down", "Down", "Up"])
	
	var skill4 = Skill.new()
	skill4.skillname = "Ox: Crush"
	skill4.damage = "10"
	skill4.cost = 5
	skill4.inputs = PackedStringArray(["Left", "Left", "Right", "Right"])
	
	skillList.append(skill)
	skillList.append(skill2)
	skillList.append(skill3)
	skillList.append(skill4)
	
	skill_tree = TreeSkill.new()
	skill_tree.move_name = "Root"
	
	#Left start
	skill_tree.left = TreeSkill.new()
	skill_tree.left.down = TreeSkill.new()
	skill_tree.left.down.right = TreeSkill.new()
	skill_tree.left.down.right.move_name = "Rabbit: Bounce"
	
	skill_tree.left.left = TreeSkill.new()
	skill_tree.left.left.right = TreeSkill.new()
	skill_tree.left.left.right.move_name = "Snake: Whip"
	skill_tree.left.left.right.right = TreeSkill.new()
	skill_tree.left.left.right.right.move_name = "Ox: Crush" 
	
	#Down Start
	skill_tree.down = TreeSkill.new()
	skill_tree.down.down = TreeSkill.new()
	skill_tree.down.down.up = TreeSkill.new()
	skill_tree.down.down.up.move_name = "Rooster: Flame"
	
	'''var skill_tree_2 = TreeSkill.new()
	skill_tree_2.left = TreeSkill.new()
	skill_tree_2.left.move_name = "Hello"
	skill_tree_2.right = TreeSkill.new()
	skill_tree_2.right.move_name = "World"
	skill_tree_2.right.left = TreeSkill.new()
	skill_tree_2.right.left.move_name = "There"'''
	
	var arr = ["Left", "Left", "Left", "Right"]
	check_skill(arr, skill_tree)
	
	
	
func move_towards(target_pos):
	unitTween = get_tree().create_tween()
	unitTween.tween_property(self, "position", target_pos, 1)
	$Sam/AnimationPlayer.play("walk")
	unitTween.connect("finished", on_tween_finished)

func on_tween_finished():
	$Sam/AnimationPlayer.stop()
	anim_finished.emit("walk")
	

func get_skill_list():
	return skillList
	
func check_skill(skill_arr, root):
	var input = skill_arr[0]
	skill_arr.pop_front()
	if root == null:
		print("No move found")
		return
	elif len(skill_arr) == 0:
		print(root.move_name)
		return
		
	if root.left != null:
		check_skill(skill_arr, root.left)
	if root.right != null:
		check_skill(skill_arr, root.right)
	if root.down != null:
		check_skill(skill_arr, root.down)
	if root.up != null:
		check_skill(skill_arr, root.up) 
	

func play_idle():
	$Sam/AnimationPlayer.play("idle")
	
func play_attack():
	$Sam/AnimationPlayer.play("attack")
	
func set_skill_active(name):
	for skill in skillList:
		if skill.name == name:
			skill.is_active = true
			active_skills.push_back(skill)
			return

func _on_animation_player_animation_finished(anim_name):
	print("anim signal emitted")
	anim_finished.emit(anim_name)
