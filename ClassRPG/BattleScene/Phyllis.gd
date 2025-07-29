extends "../Unit/Unit.gd"


@onready var unit_cam = $UnitCam

signal anim_finished



# Called when the node enters the scene tree for the first time.
func _ready():
	unit_stats = BattleSettings.philStats
	
	_set_base_skills()
	var skill = Skill.new()
	skill.skillname = "Absorb"
	skill.damage = 3
	skill.delay = 1
	skill.inputs = PackedStringArray(["Down", "Down", "Right"])
	
	skillList.append(skill)

#skill tree fixed later
	skill_tree = TreeSkill.new()
	skill_tree.move_name = "Root"
	
	#Left start
	skill_tree.down = TreeSkill.new()
	skill_tree.down.down = TreeSkill.new()
	skill_tree.down.down.right = TreeSkill.new()
	skill_tree.down.down.right.move_name = "Absorb"

	
	set_skill_active("Absorb")
	
	

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


func play_left():
	ap.play("Left")

func play_right():
	ap.play("Right")
	
func play_up():
	ap.play("Up")
	
func play_down():
	ap.play("Down")
	
func get_unit_cam():
	return unit_cam
	
	
func set_guard():
	is_guarding = true
	ap.play("Guard")
	
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
