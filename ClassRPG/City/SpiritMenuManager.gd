extends Control

var spiritSlots = []

var spiritSlot = preload("res://UI/MainMenu/spirit_slot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func set_current_spirit_bank():
	print(spiritSlots)
	for spirits in SpiritBank.currentBank:
		var new_spirit_slot = spiritSlot.instantiate()
		new_spirit_slot.spirit = load(SpiritBank.currentBank[spirits]) 
		new_spirit_slot.set_sprite()
		$ScrollContainer/GridContainer.add_child(new_spirit_slot)
	spiritSlots = $ScrollContainer/GridContainer.get_children()
	
func add_spirit(spirit):
	var new_spirit_slot = spiritSlot.instantiate()
	new_spirit_slot.spirit = spirit
	new_spirit_slot.set_sprite()
	$ScrollContainer/GridContainer.add_child(new_spirit_slot)
	spiritSlots = $ScrollContainer/GridContainer.get_children()
	
func remove_spirit(spirit):
	for slot in spiritSlots:
		if slot.spirit == spirit:
			slot.queue_free()
			
func set_equipped_spirit(unit, move):
	var spiritToDisplay
	match unit:
		"Sam": 
			spiritToDisplay = BattleSettings.samStats.spirits[move]
		"BB":
			spiritToDisplay = BattleSettings.bbStats.spirits[move]
		"Phyllis":
			spiritToDisplay = BattleSettings.philStats.spirits[move]
			
	$EquippedSpirit.spirit = spiritToDisplay
	$EquippedSpirit.set_sprite()
	
func get_spirit(index):
	return(spiritSlots[index].spirit)
	

