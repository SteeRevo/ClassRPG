extends "../Unit/Unit.gd"


@onready var unit_cam = $UnitCam


signal anim_finished
signal tween_finished



# Called when the node enters the scene tree for the first time.
func _ready():
	_set_base_skills()
	var skill = Skill.new()
	skill.skillname = "Pitch"
	skill.damage = 5
	skill.cost = 1
	skill.inputs = PackedStringArray(["Up", "Up", "Left"])
	
	skillList.append(skill)

#skill tree fixed later
	skill_tree = TreeSkill.new()
	skill_tree.move_name = "Root"
	
	#Left start
	skill_tree.up = TreeSkill.new()
	skill_tree.up.up = TreeSkill.new()
	skill_tree.up.up.left = TreeSkill.new()
	skill_tree.up.up.left.move_name = "Pitch"

	
	set_skill_active("Pitch")
	

func move_towards(target_pos):
	unitTween = get_tree().create_tween()
	ap.play("Rotate")
	unitTween.connect("finished", on_tween_finished)
	unitTween.tween_property(self, "position", target_pos, 1)
	

func on_tween_finished():
	tween_finished.emit()
	

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
	ap.play("BattleIdle")

func play_skill(skillname):
	ap.play("Skill")

func play_left():
	ap.play("Left")

func play_right():
	ap.play("Right")
	
func play_up():
	ap.play("Up")
	
func play_down():
	ap.play("Down")
	
func set_guard():
	is_guarding = true
	ap.play("Guard")

func get_unit_cam():
	return unit_cam


	
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
	

	
