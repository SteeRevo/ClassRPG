extends PathFollow2D

@export var unit : Unit
@onready var sprite = $Sprite2D
var speed
var active = false
var speed_ratio = 0.0002

func set_active():
	active = true
	sprite.visible = true
	
func set_inactive():
	active = false
	sprite.visible = false
	
func take_step():
	speed = calc_speed(unit.get_speed())
	progress_ratio += speed

func calc_speed(speed):
	return (speed * speed_ratio)
