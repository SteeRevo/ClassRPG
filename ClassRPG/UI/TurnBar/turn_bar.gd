extends Sprite2D
@onready var startPoint = $StartPoint
@onready var endPoint = $Endpoint
@onready var step = 0.5
@onready var samTurnTracker = $SamTurnTracker
@onready var bbTurnTracker = $BBTurnTracker
@onready var philTurnTracker = $PhilTurnTracker
signal choose_turn
var waiting = true


# Called when the node enters the scene tree for the first time.
func _ready():
	samTurnTracker.global_position = startPoint.global_position
	bbTurnTracker.global_position = startPoint.global_position
	philTurnTracker.global_position = startPoint.global_position

func _process(delta):
	if waiting == true:
		update_all()


func update_all():
	if samTurnTracker.global_position.x < endPoint.global_position.x:
		samTurnTracker.take_step(step)
		return null
	elif samTurnTracker.global_position.x >= endPoint.global_position.x:
		emit_signal("choose_turn", samTurnTracker.unit)
		waiting = false
