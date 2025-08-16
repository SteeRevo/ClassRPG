extends Sprite2D

@onready var step = 0.5
@onready var samTurnTracker = $PlayerPath/SamPathFollow2D
@onready var bbTurnTracker = $PlayerPath/BBPathFollow2D
@onready var philTurnTracker = $PlayerPath/PhilPathFollow2D
@onready var enemytt1 = $EnemyPath/EnemyPathFollow2D
@onready var enemytt2 = $EnemyPath/EnemyPathFollow2D2
@onready var enemytt3 = $EnemyPath/EnemyPathFollow2D3
@onready var enemytt4 = $EnemyPath/EnemyPathFollow2D4

@onready var playerPath = $PlayerPath

var enemyTurnTrackers = []
signal choose_turn
signal choose_enemy_turn
@onready var waiting = false

var turnTrackers = []

var current_tt = null


# Called when the node enters the scene tree for the first time.
func _ready():
	samTurnTracker.progress_ratio = 0
	bbTurnTracker.progress_ratio = 0
	philTurnTracker.progress_ratio = 0
	enemyTurnTrackers = [enemytt1, enemytt2, enemytt3, enemytt4]
	for tt in enemyTurnTrackers:
		tt.progress_ratio = 0
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
				if tt.progress_ratio >= 1 :
					emit_signal("choose_turn", tt.unit)
					waiting = false
					if current_tt != null:
						current_tt.z_index = 0
					current_tt = tt
					current_tt.z_index = 1
					return
				else:
					tt.take_step()
		for tt in enemyTurnTrackers:
			if tt.active:
				if tt.progress_ratio >= 1:
					emit_signal("choose_enemy_turn", tt.unit)
					waiting = false
					current_tt = tt
					return
				else:
					tt.take_step()

func remove_enemy_turn_tracker(unit):
	for tt in enemyTurnTrackers:
		if tt.unit == unit:
			tt.set_inactive()

func delay_tt(delay):
	print(current_tt.progress_ratio)
	print(delay)
	current_tt.progress_ratio -= (delay * .1) * 2
	
func reset_to_start():
	current_tt.progress_ratio = 1
