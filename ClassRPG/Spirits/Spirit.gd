extends Resource
class_name Spirit
@export var spirit_name: String
@export var input_atk_bonus: int
@export var input_tech_bonus: int
@export var input_defense_bonus: int
@export var bg_atk_bonus: int
@export var bg_tech_bonus: int
@export var bg_defense_bonus: int
@export var attached_unit: Unit
@export var texture: Texture2D

@export var bgEffects = []
@export var inputEffect = []
	
func input_effect():
	return
	
func bg_effect():
	return

func get_input_atk_bonus():
	return input_atk_bonus

