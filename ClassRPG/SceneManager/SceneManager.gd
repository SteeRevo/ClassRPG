extends Node

@onready var root = get_node("/root")
var previous_scene
var scene_to_change
var curr_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	SceneTransitionManager.connect("transition_started", Callable(self, "complete_change"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_scene(current_scene, new_scene):
	SceneTransitionManager.visible = true
	SceneTransitionManager.play_battle_entry()
	
	curr_scene = current_scene
	scene_to_change = new_scene
	
	

func change_to_previous():
	call_deferred("_deferred_scene_switch_prev")
	
func _deferred_scene_switch_prev():
	var current_scene = root.get_child(root.get_child_count() - 1)
	root.remove_child(current_scene)
	root.add_child(previous_scene)
	current_scene.free()
	
func complete_change():
	previous_scene = curr_scene
	root.remove_child(curr_scene)
	root.add_child(scene_to_change)
	SceneTransitionManager.play_battle_exit()
