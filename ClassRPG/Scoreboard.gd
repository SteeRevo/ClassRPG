extends Sprite2D

@onready var strikes = [$StrikePoint1, $StrikePoint2]
@onready var outs = [$Out1, $Out2]
@onready var score = $Score
var current_score = 0
var current_strikes = 0
var current_outs = 0

var struckout = false
var allout = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for strike in strikes:
		strike.visible = false
	for out in outs:
		out.visible = false
	$Score.text = str(current_score)
	

func increase_score():
	current_score += 1
	$Score.text = str(current_score)

func increase_strike():
	current_strikes += 1
	if current_strikes < 2:
		strikes[current_strikes - 1].visible = true
	else:
		struckout = true
		for strike in strikes:
			strike.visible = false
		current_strikes = 0
		increase_outs()

func increase_outs():
	current_outs += 1
	if current_outs < 2:
		outs[current_outs - 1].visible = true
	else:
		allout = true
		for out in outs:
			out.visible = false
		current_outs = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
