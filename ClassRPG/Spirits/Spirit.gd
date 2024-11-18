extends Resource
class_name Spirit
var spirit_name: String
var input_atk_bonus: int
var input_tech_bonus: int
var input_defense_bonus: int
var bg_atk_bonus: int
var bg_tech_bonus: int
var bg_defense_bonus: int
var attached_unit

func _init(name = ''):
	spirit_name = name
	input_atk_bonus = Databases.SpiritDatabase[name]["input_attack_boost"]
	input_tech_bonus = Databases.SpiritDatabase[name]["input_tech_boost"]
	input_defense_bonus = Databases.SpiritDatabase[name]["input_defense_boost"]
	bg_atk_bonus = Databases.SpiritDatabase[name]["bg_attack_boost"]
	bg_tech_bonus = Databases.SpiritDatabase[name]["bg_tech_boost"]
	bg_defense_bonus = Databases.SpiritDatabase[name]["bg_defense_boost"]
	
func input_effect():
	return
	
func bg_effect():
	return

func get_input_atk_bonus():
	return input_atk_bonus
