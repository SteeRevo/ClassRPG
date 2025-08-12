extends "../PlayerUnit.gd"


@onready var unit_cam = $UnitCam

signal anim_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	unit_stats = BattleSettings.samStats
	
	set_unit_spirits(unit_stats)
	
	var zodiac_array = []

	var skill = Skill.new()
	skill.skillname = "Rabbit: Bounce"
	skill.damage = 5
	skill.delay = 1
	skill.inputs = PackedStringArray(["Left", "Down", "Right"])

	var skill2 = Skill.new()
	skill2.skillname = "Snake: Whip"
	skill2.damage = "10"
	skill2.delay = 5
	skill2.inputs = PackedStringArray(["Left", "Left", "Right"])
	

	var skill3 = Skill.new()
	skill3.skillname = "Rooster: Flame"
	skill3.damage = 0
	skill3.delay = 3 
	skill3.inputs = PackedStringArray(["Down", "Down", "Up"])
	
	var skill4 = Skill.new()
	skill4.skillname = "Ox: Crush"
	skill4.damage = "10"
	skill4.delay = 5
	skill4.inputs = PackedStringArray(["Left", "Left", "Right", "Right"])
	
	skillList.append(skill)
	skillList.append(skill2)
	skillList.append(skill3)
	skillList.append(skill4)
	
#skill tree fixed later
	for _skill in skillList:
		set_skill(_skill)
		
	set_skill_active("Rooster: Flame")
	#set_skill_active("Rabbit: Bounce")
	set_skill_active("Snake: Whip")
	#set_skill_active("Ox: Crush")
	
	_set_base_skills()
	


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
	
func set_guard():
	is_guarding = true
	ap.play("Guard")
	
func get_unit_cam():
	return unit_cam
	
func play_skill(attack_name):
	match attack_name:
		"Left", "Right", "Up", "Down":
			ap.play(attack_name)
		"Snake: Whip":
			ap.play("SnakeWhip")
		_:
			ap.play("Skill")
	
	
func set_skill_active(skill_name):
	for skill in skillList:
		if skill.skillname == skill_name:
			skill.is_active = true
			active_skills.push_back(skill)
			return skill

func get_skill(skill_name):
	for skill in active_skills:
		if skill.skillname == skill_name:
			return skill
	return null

func _on_animation_player_animation_finished(anim_name):
	print("anim signal emitted")
	anim_finished.emit(anim_name)
