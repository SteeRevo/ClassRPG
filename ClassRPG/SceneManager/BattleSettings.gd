extends Node

var base_player_units = ["Sam", "Phyllis", "BB"]
var enemy_units = []
var current_player_units = base_player_units
var inputs_allowed = 3


func add_enemy(enemy_list):
	enemy_units.clear()
	for enemy in enemy_list:
		enemy_units.append(enemy)
	print(enemy_list)
		
func remove_ally(ally):
	current_player_units.erase(ally)
	
