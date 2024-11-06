extends "../Unit/Unit.gd"


@onready var ap = $Sam2/AnimationPlayer

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
	
#skill tree fixed later
	skill_tree = TreeSkill.new()
	skill_tree.move_name = "Root"
	
	#Left start
	skill_tree.left = TreeSkill.new()
	skill_tree.left.down = TreeSkill.new()
	skill_tree.left.down.right = TreeSkill.new()
	skill_tree.left.down.right.move_name = "Rabbit: Bounce"
	
	skill_tree.left.left = TreeSkill.new()
	skill_tree.left.left.right = TreeSkill.new()
	#skill_tree.left.left.right.move_name = "Snake: Whip"
	skill_tree.left.left.right.right = TreeSkill.new()
	skill_tree.left.left.right.right.move_name = "Ox: Crush" 
	
	#Down Start
	skill_tree.down = TreeSkill.new()
	skill_tree.down.down = TreeSkill.new()
	skill_tree.down.down.up = TreeSkill.new()
	skill_tree.down.down.up.move_name = "Rooster: Flame"
	
	set_skill_active("Rooster: Flame")
	set_skill_active("Rabbit: Bounce")
	#set_skill_active("Snake: Whip")
	set_skill_active("Ox: Crush")
	
	var arr = ["Left", "Left", "Right", "Right"]
	print(check_skill(arr, skill_tree))
	
	
	
	
func move_towards(target_pos):
	unitTween = get_tree().create_tween()
	unitTween.tween_property(self, "position", target_pos, 1)
	ap.play("Rotate")
	unitTween.connect("finished", on_tween_finished)

func on_tween_finished():
	ap.stop()
	anim_finished.emit("walk")
	

func get_skill_list():
	return skillList
	
func check_skill(skill_arr, root):
	if root == null:
		print("No move found")
		return
	elif len(skill_arr) == 0:
		return root.move_name
	
	var input = skill_arr[0]
		
	if root.left != null and input == "Left":
		return check_skill(skill_arr.slice(1), root.left)
	if root.right != null and input == "Right":
		return check_skill(skill_arr.slice(1), root.right)
	if root.down != null and input == "Down":
		return check_skill(skill_arr.slice(1), root.down)
	if root.up != null and input == "Up":
		return check_skill(skill_arr.slice(1), root.up)
	

func play_idle():
	print("playing idle for Sam")
	pass#$Sam/AnimationPlayer.play("idle")
	
func play_attack():
	pass#$Sam/AnimationPlayer.play("attack")
	
func play_left():
	ap.play("Left")

func play_right():
	ap.play("Right")
	
func play_up():
	ap.play("Up")
	
func play_down():
	ap.play("Down")
	
func set_skill_active(name):
	for skill in skillList:
		if skill.skillname == name:
			skill.is_active = true
			active_skills.push_back(skill)
			return

func get_skill(skill_name):
	for skill in active_skills:
		if skill.skillname == skill_name:
			return skill
	return "No move found"

func _on_animation_player_animation_finished(anim_name):
	print("anim signal emitted")
	anim_finished.emit(anim_name)
