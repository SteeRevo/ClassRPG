extends Control

@onready var bases = [$HomeBase, $FirstBase, $SecondBase, $ThirdBase]

@export var current_base = 3
signal batter_finished
var score_increased = false

func _ready():
	$Batter.position = bases[current_base].position

func batter_run():
	current_base += 1
	if current_base > 3:
		current_base = 0
		score_increased = true
	var batterTween = get_parent().create_tween()
	batterTween.connect("finished", on_tween_finished)
	batterTween.tween_property($Batter, "position", bases[current_base].position, 0.5)
	print(bases[current_base])

func on_tween_finished():
	if score_increased:
		$Scoreboard.increase_score()
		score_increased = false
	batter_finished.emit()
