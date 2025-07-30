extends TextureRect

@export var menu_parent_path:NodePath

@onready var menu_parent := get_node(menu_parent_path)

var cursor_index: int = 0

func get_menu_item_at_index(index: int) -> Control:
	if menu_parent == null:
		return null
		
	if index >= menu_parent.get_child_count() or index < 0:
		return null
		
	return menu_parent.get_child(index)
	
func set_cursor_from_index(index: int) -> void:
	var menu_item := get_menu_item_at_index(index)
	
	if menu_item == null:
		return
	
	var pos = menu_item.global_position
	
	global_position = Vector2(pos.x - 20, pos.y - 10)
	
	
	
	cursor_index = index
