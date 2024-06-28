extends "../Unit/Unit.gd"

var skillList = []
var active_skills = []

@onready var ap = $Sam/AnimationPlayer

signal anim_finished

# Called when the node enters the scene tree for the first time.
func _ready():

	var skill = Skill.new()
	skill.skillname = "Wind: Zephyr"
	skill.damage = 5
	skill.cost = 1
	skill.inputs = PackedStringArray(["Left", "Down", "Right"])
	
	var skill2 = Skill.new()
	skill2.skillname = "Dragon: Rend"
	skill2.damage = "10"
	skill2.cost = 5
	skill2.inputs = PackedStringArray(["Left", "Left", "Right"])
	
	var skill3 = Skill.new()
	skill3.skillname = "Water: Lull"
	skill3.damage = 0
	skill3.cost = 3 
	skill3.inputs = PackedStringArray(["Down", "Down", "Up"])
	
	var skill4 = Skill.new()
	skill4.skillname = "Dragon: Sunder"
	skill4.damage = "10"
	skill4.cost = 5
	skill4.inputs = PackedStringArray(["Left", "Left", "Right", "Right"])
	
	skillList.append(skill)
	skillList.append(skill2)
	skillList.append(skill3)
	skillList.append(skill4)
	
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
