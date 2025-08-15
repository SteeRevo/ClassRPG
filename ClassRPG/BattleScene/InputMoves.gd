extends Control

var move_container = preload("res://UI/InputMoves/move_container.tscn")
var arrow_holder = preload("res://UI/InputMoves/arrow_holder.tscn")

@onready var mlc_sam = $MoveListContainerSam/VBoxContainer
@onready var mlc_bb = $MoveListContainerBB/VBoxContainer
@onready var mlc_phyllis = $MoveListContainerPhyllis/VBoxContainer
@onready var inputtedMoves = $InputtedMoves

var basic_skills = ["Left", "Right", "Up", "Down"]

func _ready():
	visible = false
	add_arrow_holders()

func add_all_active_skills(unit):
	for child in mlc_bb.get_children():
		child.queue_free()
	for child in mlc_phyllis.get_children():
		child.queue_free()
	for child in mlc_sam.get_children():
		child.queue_free()
	for skill in unit.active_skills:
		print(skill.skillname)
		print(skill.active_positions)
		if !basic_skills.has(skill.skillname) and unit.get_BG().bgType in skill.active_positions:
			if unit.name == "Sam":
				add_move_container(mlc_sam, skill)
			elif unit.name == "BB":
				add_move_container(mlc_bb, skill)
			elif unit.name == "Phyllis":
				add_move_container(mlc_phyllis, skill)
			print(skill.skillname)

func add_move_container(mlc, skill):
	var move_con = move_container.instantiate()
	mlc.add_child(move_con)
	move_con.set_move_name(skill.skillname)
	for input in skill.inputs:
		move_con.add_arrow(input)

func set_active_unit_movelist_visible(unit):
	mlc_sam.visible = false
	mlc_bb.visible = false
	mlc_phyllis.visible = false
	match unit.name:
		"Sam":
			mlc_sam.visible = true
		"BB":
			mlc_bb.visible = true
		"Phyllis":
			mlc_phyllis.visible = true

func add_arrow_holders():
	for i in range(BattleSettings.inputs_allowed):
		var _arrow_holder = arrow_holder.instantiate()
		inputtedMoves.add_child(_arrow_holder)
	inputtedMoves.add_arrow_to_holder()
