extends Node

@onready var root = get_node("/root")
var previous_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_scene(current_scene, new_scene):
	previous_scene = current_scene
	root.remove_child(current_scene)
	root.add_child(new_scene)

func change_to_previous():
	call_deferred("_deferred_scene_switch_prev")
	
func _deferred_scene_switch_prev():
	var current_scene = root.get_child(root.get_child_count() - 1)
	root.remove_child(current_scene)
	root.add_child(previous_scene)
	current_scene.free()
