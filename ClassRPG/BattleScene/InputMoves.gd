extends Control

var move_container = preload("res://UI/InputMoves/move_container.tscn")

@onready var mlc_sam = $MoveListContainerSam/VBoxContainer
@onready var mlc_bb = $MoveListContainerBB/VBoxContainer
@onready var mlc_phyllis = $MoveListContainerPhyllis/VBoxContainer

var basic_skills = ["Left", "Right", "Up", "Down"]

func _ready():
	visible = false

func add_all_active_skills(unit):
	for skill in unit.active_skills:
		if !basic_skills.has(skill.skillname):
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
	move_con.set_sp_cost(skill.cost)
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
