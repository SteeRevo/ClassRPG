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
		new_spirit_slot.spirit = load(spirits) 
		new_spirit_slot.set_sprite()
		$ScrollContainer/GridContainer.add_child(new_spirit_slot)
	spiritSlots = $ScrollContainer/GridContainer.get_children()
	
func add_spirit(name):
	print(SpiritBank.currentBank[0])
	var newSpirit = load(SpiritBank.currentBank[0])
	$ScrollContainer/GridContainer/SpiritSlot.spirit = newSpirit
	$ScrollContainer/GridContainer/SpiritSlot.set_sprite()
	
func get_spirit(index):
	return(spiritSlots[index].spirit)
	

