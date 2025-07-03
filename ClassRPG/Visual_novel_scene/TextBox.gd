extends Label

@onready var timer = $Timer
var inputText = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.02

signal finished_displaying

func display_text(text_to_display: String):
	inputText = text_to_display
	letter_index = 0
	text = ""
	
	_display_letter()
	
func _display_letter():
	text += inputText[letter_index]
	
	letter_index += 1
	if letter_index >= inputText.length():
		timer.stop()
		finished_displaying.emit()
		return
	else:
		match inputText[letter_index]:
			"!",".",",","?":
				timer.start(punctuation_time)
			" ":
				timer.start(space_time)
			_:
				timer.start(letter_time)
				
func advance_full_text():
	text = inputText
	timer.stop()

func _on_timer_timeout():
	_display_letter()
