extends Area3D

@export var new_scene = preload("res://BattleScene/BattleScene.tscn").instantiate()
@export var enemy_arr = []

func _on_body_entered(body):
	if body.name == "SamOverworld":
		var current_scene = get_node("/root/Visual Novel Scene")
		BattleSettings.add_enemy(enemy_arr)
		SceneManager.change_scene(current_scene, new_scene)
		
