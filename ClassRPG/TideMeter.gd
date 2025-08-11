extends Control

var default_tide = 50
var current_tide
var next_tide

# Called when the node enters the scene tree for the first time.
func _ready():
	current_tide = 95
	next_tide = default_tide
	
		
func _process(delta):
	if current_tide < next_tide:
		$TextureProgressBar.value += 1
		current_tide += 1
	elif current_tide > next_tide:
		$TextureProgressBar.value -= 1
		current_tide -= 1

func update_tide(val):
	next_tide += val

func _on_texture_progress_bar_value_changed(value):
	if value > current_tide:
		$TextureProgressBar/ColorRect.position.y -= 18.5
	elif value < current_tide:
		$TextureProgressBar/ColorRect.position.y += 18.5
