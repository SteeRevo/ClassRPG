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

func attach_spirit(unitName, spirit, move):
	match unitName:
		"Sam":
			var spiritReturn = null
			if samStats.spirits[move] != null:
				spiritReturn = samStats.spirits[move]
			samStats.spirits[move] = spirit
			return spiritReturn
		"BB":
			var spiritReturn = null
			if samStats.spirits[move] != null:
				spiritReturn = samStats.spirits[move]
			bbStats.spirits[move] = spirit
			return spiritReturn
		"Phyllis":
			var spiritReturn = null
			if samStats.spirits[move] != null:
				spiritReturn = samStats.spirits[move]
			philStats.spirits[move] = spirit
			return spiritReturn

func calc_bonus(unit, stat):
	var unit_stat = null
	match unit:
		"Sam":
			unit_stat = samStats
		"BB":
			unit_stat = bbStats
		"Phyllis":
			unit_stat = philStats
	var bonus = 0
	for spirit in unit_stat.spirits:
		var spirit_stats = unit_stat.spirits[spirit]
		match stat:
			"HP":
				bonus += spirit_stats.input_hp_bonus
			"Attack":
				bonus += spirit_stats.input_atk_bonus
			"Defense":
				bonus += spirit_stats.input_def_bonus
			"Speed":
				bonus += spirit_stats.input_spd_bonus
			"Technique":
				bonus += spirit_stats.input_tech_bonus
	return bonus

func calc_total_base_stat(unit, stat):
	var unit_stat = null
	match unit:
		"Sam":
			unit_stat = samStats
		"BB":
			unit_stat = bbStats
		"Phyllis":
			unit_stat = philStats
	var total = 0
	match stat:
		"HP":
			total += unit_stat.max_health + calc_bonus(unit, stat)
		"Attack":
			total += unit_stat.attack + calc_bonus(unit, stat)
		"Defense":
			total += unit_stat.defense + calc_bonus(unit, stat)
		"Speed":
			total += unit_stat.speed + calc_bonus(unit, stat)
		"Technique":
			total += unit_stat.technique + calc_bonus(unit, stat)
	return total

func get_base_stats(unit, stat):
	var unit_stat = null
	match unit:
		"Sam":
			unit_stat = samStats
		"BB":
			unit_stat = bbStats
		"Phyllis":
			unit_stat = philStats
	match stat:
		"HP":
			return unit_stat.max_health
		"Attack":
			return unit_stat.attack
		"Defense":
			return unit_stat.defense
		"Speed":
			return unit_stat.speed
		"Technique":
			return unit_stat.technique
