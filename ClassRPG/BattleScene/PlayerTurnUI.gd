extends Control

@onready var leftSam = $Arrows/LeftArrow/LeftArrowSam
@onready var rightSam = $Arrows/RightArrow/RightArrowSam
@onready var upSam = $Arrows/UpArrow/UpArrowSam
@onready var downSam = $Arrows/DownArrow/DownArrowSam

@onready var leftBB = $Arrows/LeftArrow/LeftArrowBB
@onready var rightBB = $Arrows/RightArrow/RightArrowBB
@onready var upBB = $Arrows/UpArrow/UpArrowBB
@onready var downBB = $Arrows/DownArrow/DownArrowBB
 
@onready var leftPhil = $Arrows/LeftArrow/LeftArrowPhyliss
@onready var rightPhil = $Arrows/RightArrow/RightArrowPhyliss
@onready var upPhil = $Arrows/UpArrow/UpArrowPhyliss
@onready var downPhil = $Arrows/DownArrow/DownArrowPhyliss

@onready var philHealthbar = $Control/HealthBarPhil
@onready var samHealthbar = $Control/HealthBarSam
@onready var bbHealthbar = $Control/HealthBarBB


var samArrows
var bbArrows
var philArrows

func _ready():
	samArrows = [leftSam, rightSam, upSam, downSam]
	bbArrows = [leftBB, rightBB, upBB, downBB]
	philArrows = [leftPhil, rightPhil, upPhil, downPhil]
	#play_exit_anim()
	
func update_health(unit):
	var current_hp = unit._get_health()
	var max_hp = unit.get_max_health()
	match unit.name:
		"Phyllis":
			philHealthbar.max_value = max_hp
			philHealthbar.value = current_hp
		"Sam":
			samHealthbar.max_value = max_hp
			samHealthbar.value = current_hp
		"BB":
			bbHealthbar.max_value = max_hp
			bbHealthbar.value = current_hp
	


func set_arrow_outline(unit_name, arrow):
	clear_all_arrows()
	match unit_name:
		"Sam":
			match arrow:
				"Left":
					leftSam.visible = true
				"Right":
					rightSam.visible = true
				"Up":
					upSam.visible = true
				"Down":
					downSam.visible = true
		"BB":
			match arrow:
				"Left":
					leftBB.visible = true
				"Right":
					rightBB.visible = true
				"Up":
					upBB.visible = true
				"Down":
					downBB.visible = true
		"Phyllis":
			match arrow:
				"Left":
					leftPhil.visible = true
				"Right":
					rightPhil.visible = true
				"Up":
					upPhil.visible = true
				"Down":
					downPhil.visible = true


func clear_all_arrows():
	for arr in samArrows:
		arr.visible = false
	for arr in bbArrows:
		arr.visible = false
	for arr in philArrows:
		arr.visible = false
		
func play_enter_anim():
	visible = true
	$AnimationPlayer.play("Enter")
	
func play_exit_anim():
	$AnimationPlayer.play("Exit")
	
	
	
func play_enter_health():
	$AnimationPlayer.play("Health_enter")

func _on_animation_player_animation_finished(anim_name):
	pass
