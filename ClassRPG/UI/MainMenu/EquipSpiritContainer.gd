extends VBoxContainer

var samColor = Color(0.84, 0.99, 0.09, 1)
var philColor = Color(0.6, 0.08, 0.99, 1)

func set_option(character):
	$Sam.add_theme_color_override("font_color", Color.WHITE)
	$Phyllis.add_theme_color_override("font_color", Color.WHITE)
	$BB.add_theme_color_override("font_color", Color.WHITE)
	$BB.add_theme_color_override("font_outline_color", Color.BLACK)
	match character:
		"Sam":
			$Sam.add_theme_color_override("font_color", samColor)
		"BB":
			$BB.add_theme_color_override("font_color", Color.BLACK)
			$BB.add_theme_color_override("font_outline_color", Color.WHITE)
		"Phyllis":
			$Phyllis.add_theme_color_override("font_color", philColor)
		
	
