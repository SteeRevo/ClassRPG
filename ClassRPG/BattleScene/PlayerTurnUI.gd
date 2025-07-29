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

@onready var playerHealthbar = $Control/HealthBar
@onready var healthNumber = $Control/HealthNumber
@onready var spNumber = $Control/SpNumber
@onready var samName = $Control/SamName
@onready var bbName = $Control/BBName
@onready var philName = $Control/PhylissName

var samArrows
var bbArrows
var philArrows

func _ready():
	samArrows = [leftSam, rightSam, upSam, downSam]
	bbArrows = [leftBB, rightBB, upBB, downBB]
	philArrows = [leftPhil, rightPhil, upPhil, downPhil]
	visible = false
	play_exit_anim()
	
func update_health(unit):
	var current_hp = unit._get_health()
	var max_hp = unit.get_max_health()
	healthNumber.text = str(current_hp)
	playerHealthbar.max_value = max_hp
	playerHealthbar.value = current_hp
	


func set_name_visible(name):
	match name:
		"Sam":
			samName.visible = true
		"BB":
			bbName.visible = true
		"Phyllis":
			philName.visible = true
			
func reset_names():
	samName.visible = false
	bbName.visible = false
	philName.visible = false


func set_arrow_outline(name, arrow):
	clear_all_arrows()
	match name:
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
	
	
func play_exit_health():
	$AnimationPlayer.play_backwards("Health_enter")
	
func play_enter_health():
	$AnimationPlayer.play("Health_enter")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Exit":
		reset_names()
