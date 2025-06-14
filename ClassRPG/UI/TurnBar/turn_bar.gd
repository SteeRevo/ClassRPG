extends Sprite2D
@onready var startPoint = $StartPoint
@onready var endPoint = $Endpoint
@onready var step = 1
@onready var samTurnTracker = $SamTurnTracker
@onready var bbTurnTracker = $BBTurnTracker
@onready var philTurnTracker = $PhilTurnTracker


# Called when the node enters the scene tree for the first time.
func _ready():
	samTurnTracker.global_position = startPoint.global_position
	bbTurnTracker.global_position = startPoint.global_position
	philTurnTracker.global_position = startPoint.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if samTurnTracker.global_position.x < endPoint.global_position.x:
		samTurnTracker.take_step(step*2)
	if bbTurnTracker.global_position.x < endPoint.global_position.x:
		bbTurnTracker.take_step(step*1.1)
	if philTurnTracker.global_position.x < endPoint.global_position.x:
		philTurnTracker.take_step(step*1.3)
