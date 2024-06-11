extends "../Unit/Unit.gd"

var skillList = []

@onready var ap = $Sam/AnimationPlayer

signal anim_finished

# Called when the node enters the scene tree for the first time.
func _ready():

	var skill = Skill.new()
	skill.skillname = "Wind: Zephyr"
	skill.damage = 10
	skill.cost = 1
	
	var skill2 = Skill.new()
	skill2.skillname = "Dragon: Rend"
	skill.damage = "30"
	skill.cost = 5
	
	var skill3 = Skill.new()
	skill3.skillname = "Water: Lull"
	skill3.damage = 0
	skill.cost = 3 
	
	skillList.append(skill)
	skillList.append(skill2)
	skillList.append(skill3)
	
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

func _on_animation_player_animation_finished(anim_name):
	print("anim signal emitted")
	anim_finished.emit(anim_name)
