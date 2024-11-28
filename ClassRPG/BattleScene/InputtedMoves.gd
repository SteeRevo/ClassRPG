extends HBoxContainer

var arrow_holders = []
var arrow_index = 0

func add_arrow_to_holder():
	for child in get_children():
		arrow_holders.append(child)
		

func set_arrow_direction(direction):
	arrow_holders[arrow_index].set_arrow(direction)
	arrow_index += 1

func reset_arrow():
	arrow_index -= 1
	arrow_holders[arrow_index].arrow_sprite.visible = false
	
func clear_all_arrows():
	for arrow in arrow_holders:
		arrow.arrow_sprite.visible = false
	arrow_index = 0
