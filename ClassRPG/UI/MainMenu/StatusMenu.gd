extends ColorRect

@onready var unitName = $UnitName
@onready var HPNum = $NormalStats/HPNum
@onready var ATKNum = $NormalStats/ATKNum
@onready var DEFNum = $NormalStats/DEFNum
@onready var SPDNum = $NormalStats/SPDNum
@onready var TECNum = $NormalStats/TECNum
@onready var BonusHP = $BonusStats/HPNum
@onready var BonusATK = $BonusStats/ATKNum
@onready var BonusDEF = $BonusStats/DEFNum
@onready var BonusSPD = $BonusStats/SPDNum
@onready var BonusTEC = $BonusStats/TECNum
@onready var BaseHP = $BaseStats/HPNum
@onready var BaseATK = $BaseStats/ATKNum
@onready var BaseDEF = $BaseStats/DEFNum
@onready var BaseSPD = $BaseStats/SPDNum
@onready var BaseTECH = $BaseStats/TECNum 
var samColor = Color(0.84, 0.99, 0.09, 1)
var philColor = Color(0.6, 0.08, 0.99, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_all_stats(unit: String):
	unitName.text = unit
	HPNum.text = str(BattleSettings.calc_total_base_stat(unit, "HP"))
	ATKNum.text = str(BattleSettings.calc_total_base_stat(unit, "Attack"))
	DEFNum.text = str(BattleSettings.calc_total_base_stat(unit, "Defense"))
	SPDNum.text = str(BattleSettings.calc_total_base_stat(unit, "Speed"))
	TECNum.text = str(BattleSettings.calc_total_base_stat(unit, "Technique"))
	BonusHP.text = "(+" + str(BattleSettings.calc_bonus(unit, "HP")) + ")"
	BonusATK.text = "(+" + str(BattleSettings.calc_bonus(unit, "Attack")) + ")" 
	BonusDEF.text = "(+" + str(BattleSettings.calc_bonus(unit, "Defense")) + ")"
	BonusSPD.text = "(+" + str(BattleSettings.calc_bonus(unit, "Speed")) + ")" 
	BonusTEC.text = "(+" + str(BattleSettings.calc_bonus(unit, "Technique")) + ")"
	BaseHP.text = str(BattleSettings.get_base_stats(unit, "HP"))
	BaseATK.text = str(BattleSettings.get_base_stats(unit, "Attack"))
	BaseDEF.text = str(BattleSettings.get_base_stats(unit, "Defense"))
	BaseSPD.text = str(BattleSettings.get_base_stats(unit, "Speed"))
	BaseTECH.text = str(BattleSettings.get_base_stats(unit, "Technique"))
	
	if unit == "Sam":
		for label in $NormalStats.get_children():
			label.add_theme_color_override("font_color", samColor)
			label.add_theme_color_override("font_outline_color", Color.BLACK)
		unitName.add_theme_color_override("font_color", samColor)
		unitName.add_theme_color_override("font_outline_color", Color.BLACK)
	elif unit == "BB":
		for label in $NormalStats.get_children():
			label.add_theme_color_override("font_color", Color.BLACK)
			label.add_theme_color_override("font_outline_color", Color.WHITE)
		unitName.add_theme_color_override("font_color", Color.BLACK)
		unitName.add_theme_color_override("font_outline_color", Color.WHITE)
	elif unit == "Phyllis":
		for label in $NormalStats.get_children():
			label.add_theme_color_override("font_color", philColor)
			label.add_theme_color_override("font_outline_color", Color.BLACK)
		unitName.add_theme_color_override("font_color", philColor)
		unitName.add_theme_color_override("font_outline_color", Color.BLACK)
	
			


	
