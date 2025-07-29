extends Node

var base_player_units = ["Sam", "Phyllis", "BB"]
var enemy_units = []
var current_player_units = base_player_units
var inputs_allowed = 3
var samStats = preload("res://Unit/Sam/sam_stats.tres")
var bbStats = preload("res://Unit/BB/bb_stats.tres")
var philStats = preload("res://Unit/Phyllis/phil_stats.tres")

func add_enemy(enemy_list):
	enemy_units.clear()
	for enemy in enemy_list:
		enemy_units.append(enemy)
	print(enemy_list)

func remove_ally(ally):
	current_player_units.erase(ally)


