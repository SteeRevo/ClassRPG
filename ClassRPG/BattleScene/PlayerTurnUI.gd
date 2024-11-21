extends Control

@onready var leftSam = $LeftArrow/LeftArrowSam
@onready var rightSam = $RightArrow/RightArrowSam
@onready var upSam = $UpArrow/UpArrowSam
@onready var downSam = $DownArrow/DownArrowSam

@onready var leftBB = $LeftArrow/LeftArrowBB
@onready var rightBB = $RightArrow/RightArrowBB
@onready var upBB = $UpArrow/UpArrowBB
@onready var downBB = $DownArrow/DownArrowBB
 
@onready var leftPhil = $LeftArrow/LeftArrowPhyliss
@onready var rightPhil = $RightArrow/RightArrowPhyliss
@onready var upPhil = $UpArrow/UpArrowPhyliss
@onready var downPhil = $DownArrow/DownArrowPhyliss

@onready var playerHealthbar = $Control/HealthBar
@onready var playerSoulbar = $Control/SpBar
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
	
func update_health(unit):
	var current_hp = unit._get_health()
	var max_hp = unit.get_max_health()
	healthNumber.text = str(current_hp)
	playerHealthbar.max_value = max_hp
	playerHealthbar.value = current_hp
	
	
func update_sp(unit):
	var current_sp = unit.get_sp()
	var max_sp = unit.get_max_sp()
	spNumber.text = str(current_sp)
	playerSoulbar.max_value = max_sp
	playerSoulbar.value = current_sp

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
