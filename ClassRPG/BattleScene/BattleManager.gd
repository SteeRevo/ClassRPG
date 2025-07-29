extends Node

enum BATTLESTATE {PLAYER_TURN_START, SELECT_BG, BG_SELECTED, CHOOSE_TURN, SELECT_ENEMY, ENEMY_SELECTED, ENEMY_TURN}

var battleState = BATTLESTATE.CHOOSE_TURN

var player_units = []
var enemy_units = []
var unit_list = []
var bgs = []
var enemy_bgs = []
var current_selected_enemy 
var current_selected_BG
var current_selected_ally
var current_unit_bg

signal end_player_turn
signal end_enemy_turn
signal selected
signal rotate_finished
signal skill_confirmed
signal state_changed
@onready var player_units_path = $PlayerUnits
@onready var enemy_units_path = $EnemyUnits

var current_unit
@onready var battleGrounds = $Battlegrounds
@onready var BGF = $Battlegrounds/Battleground
@onready var BGT = $Battlegrounds/Battleground2
@onready var BGB = $Battlegrounds/Battleground3
@onready var BGR = $Battlegrounds/Battleground4

@onready var enemybattleGrounds = $EnemyBGs
@onready var EBGF = $EnemyBGs/Battleground
@onready var EBGT = $EnemyBGs/Battleground2
@onready var EBGB = $EnemyBGs/Battleground3
@onready var EBGR = $EnemyBGs/Battleground4

@onready var skillDamage = $Control/SkillDamage
@onready var stateName = $Control/CurrentState
@onready var playerTurnUI = $Control/PlayerTurnUI
@onready var inputMoves = $Control/InputMoves

@onready var enemySelector = $UI3d/EnemySelector
@onready var skillNameDisplay = $Control/Skillname
@onready var mainBattleCamera = $Cameras/MainBattleCamera

@onready var selectEBGcam = $CameraPoints/SelectEBGcam
@onready var mainOverviewCam = $CameraPoints/MainOverview
@onready var selectBGcam = $CameraPoints/SelectBGcam
@onready var enemy_timer = $EnemyTimer

@onready var turnBar = $Control/TurnBar

@onready var states_map = {
	'playerturn': $States/PlayerTurn,
	'chooseturn': $States/ChooseTurn,
	'enemyturn': $States/EnemyTurn,
	'selectEBG': $States/SelectEnemyBG,
	'selectABG': $States/SelectAllyBG,
	'selectAlly': $States/SelectAlly,
	'completeAction': $States/CompleteAction,
	'skillInputs': $States/SkillInputs,
	'end_fight': $States/EndFight
}

var states_stack = []
var current_state = null
var current_turn = null
var active_camera

var start_of_battle = true

var current_action = null
var camera_list = []

var skill_stack = []

var total_delay = 0

func _ready():
	add_cameras()
	get_battle_data()
	states_stack.push_front($States/ChooseTurn)
	current_state = states_stack[0]
	_change_state('chooseturn')

	

func _change_state(state_name):
	current_state.exit(self)
	if state_name == 'previous':
		states_stack.pop_front()
	elif state_name in ['selectEBG', 'selectABG', 'skillInputs', 'playerturn']:
		states_stack.push_front(states_map[state_name])
	else:
		var new_state = states_map[state_name]
		states_stack[0] = new_state
		
	current_state = states_stack[0]
	print(current_state)
	current_state.enter(self)

	emit_signal('state_changed', states_stack)
	

		
func _input(event):
	
	var new_state = current_state.handle_input(self, event)
	if new_state:
		_change_state(new_state)
		
func _process(delta):
	current_state.update(self, delta)

func end_turn():	
	print("changing turn")
	if len(enemy_units) == 0:
		print_debug("Battle end")
		SceneManager.change_to_previous()
		return
	start_turn_tracker()
	_change_state('chooseturn')

func complete_enemy_action():
	_change_state('completeAction')

func add_cameras():
	camera_list.append(mainBattleCamera)
	active_camera = mainBattleCamera
		


func update_skill_name(skill):
	skillNameDisplay.set_skill_name(skill.skillname) 
	
func update_skill_damage(damage):
	pass

func _on_unit_turn_finished(action_weight):
	player_units.erase(current_unit)
	battleState = BATTLESTATE.CHOOSE_TURN
	#choose_turn()

func get_battle_data():
	var counter = 0
	for unit in player_units_path.get_children():
		
		if BattleSettings.current_player_units.find(unit.name) == -1:
			player_units_path.remove_child(unit)
	for enemy in BattleSettings.enemy_units:
		var enemy_unit = enemy.instantiate()
		enemy_units_path.add_child(enemy_unit)
		enemy_unit.set_all_stats()
		enemy_unit.startingBG = counter
		print(counter)
		counter += 1

func set_player_turn_tracker():
	for tt in turnBar.turnTrackers:
		tt.set_active()

func set_enemy_turn_tracker(unit):
	for tt in turnBar.enemyTurnTrackers:
			if tt.active == false:
				tt.set_active()
				tt.unit = unit
				return

func update_turn():
	turnBar.update_all()
	
func start_turn_tracker():
	turnBar.waiting = true

func delay_turn_tracker():
	turnBar.delay_tt(total_delay)
	total_delay = 0
	
func reset_delay():
	turnBar.reset_to_start()

func _on_turn_bar_choose_turn(unit):
	current_unit = unit
	_change_state("playerturn")

func _on_turn_bar_choose_enemy_turn(unit):
	current_unit = unit
	_change_state("enemyturn")

func remove_enemy_tt(unit):
	turnBar.remove_enemy_turn_tracker(unit)
	
func get_total_delay(input_arr):
	for skill in input_arr:
		var current_skill = current_unit.get_skill(skill)
		if current_skill != null:
			total_delay += current_skill.delay
	print("total delay = " + str(total_delay))
