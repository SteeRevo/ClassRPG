extends Node2D
@export var unit : Unit
@onready var sprite = $Sprite2D
var speed
var active = false

func set_active():
	active = true
	sprite.visible = true
	
func set_inactive():
	active = false
	sprite.visible = false
	
func take_step():
	speed = calc_speed(unit.get_speed())
	global_position.x += speed

func calc_speed(speed):
	return (speed * 0.05) + 0.1
