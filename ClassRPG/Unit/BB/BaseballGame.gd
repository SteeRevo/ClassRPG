extends Resource

class_name BaseballGame

var bases = ["First", "Second", "Third", "Home"]
var current_base = 0
var score = 0

func advance_base():
	current_base += 1
	if current_base % 4 == 0:
		add_score()
		current_base /= 4
	return bases[current_base]
	
func add_score():
	score += 1
