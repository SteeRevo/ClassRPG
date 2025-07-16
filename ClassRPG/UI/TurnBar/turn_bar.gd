extends Sprite2D
@onready var startPoint = $StartPoint
@onready var enemyStartPoint = $EnemyStartPoint
@onready var endPoint = $Endpoint
@onready var step = 0.5
@onready var samTurnTracker = $SamTurnTracker
@onready var bbTurnTracker = $BBTurnTracker
@onready var philTurnTracker = $PhilTurnTracker
@onready var enemytt1 = $EnemyTurnTracker
@onready var enemytt2 = $EnemyTurnTracker2
@onready var enemytt3 = $EnemyTurnTracker3
@onready var enemytt4 = $EnemyTurnTracker4
var enemyTurnTrackers = []
signal choose_turn
signal choose_enemy_turn
var waiting = true

var turnTrackers = []

var current_tt = null


# Called when the node enters the scene tree for the first time.
func _ready():
	samTurnTracker.global_position = startPoint.global_position
	bbTurnTracker.global_position = startPoint.global_position
	philTurnTracker.global_position = startPoint.global_position
	enemyTurnTrackers = [enemytt1, enemytt2, enemytt3, enemytt4]
	for tt in enemyTurnTrackers:
		tt.global_position = enemyStartPoint.global_position
	turnTrackers.append(samTurnTracker)
	turnTrackers.append(bbTurnTracker)
	turnTrackers.append(philTurnTracker)

func _process(delta):
	if waiting == true:
		update_all()


func update_all():
	if waiting:
		for tt in turnTrackers:
			if tt.active:
				if tt.global_position.x >= endPoint.global_position.x :
					emit_signal("choose_turn", tt.unit)
					waiting = false
					current_tt = tt
				else:
					tt.take_step()
		for tt in enemyTurnTrackers:
			if tt.active:
				if tt.global_position.x >= endPoint.global_position.x:
					emit_signal("choose_enemy_turn", tt.unit)
					waiting = false
					current_tt = tt
				else:
					tt.take_step()

func remove_enemy_turn_tracker(unit):
	for tt in enemyTurnTrackers:
		if tt.unit == unit:
			tt.set_inactive()

func delay_tt(delay):
	current_tt.global_position.x -= delay * 50
	current_tt.global_position.x = max(current_tt.global_position.x,startPoint.global_position.x)
	
