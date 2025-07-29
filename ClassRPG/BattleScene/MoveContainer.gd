extends Panel


@onready var move_name = $MoveName
@onready var arrow_container = $HBoxContainer

var move_arrow = preload("res://UI/InputMoves/move_arrow.tscn")

func set_move_name(_name):
	move_name.text = _name


func add_arrow(direction):
	var _move_arrow = move_arrow.instantiate()
	arrow_container.add_child(_move_arrow)
	_move_arrow.set_arrow(direction)
	
