extends CanvasLayer

@export_file("*.json") var scene_text_file

var scene_text = {}
var selected_text = []
var in_progress = false


@onready var background = $Background
@onready var text_label = $TextLabel

func _ready():
	pass
