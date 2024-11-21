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

@onready var enemySelector = $UI3d/EnemySelector
@onready var skillNameDisplay = $Control/Skillname
@onready var mainBattleCamera = $Cameras/MainBattleCamera
@onready var cameraPointBG1 = $CameraPaths/BG1Path/PathFollow3D
@onready var cameraPointBG2 = $CameraPaths/BG2Path/PathFollow3D
@onready var cameraPointBG3 = $CameraPaths/BG3Path/PathFollow3D
@onready var cameraPointBG4 = $CameraPaths/BG4Path/PathFollow3D
@onready var selectEBGcam = $CameraPoints/SelectEBGcam
@onready var mainOverviewCam = $CameraPoints/MainOverview
@onready var selectBGcam = $CameraPoints/SelectBGcam


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

func _ready():
	add_cameras()
	states_stack.push_front($States/ChooseTurn)
	current_state = states_stack[0]
	_change_state('chooseturn')
	_change_state(current_turn)
	

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
	current_state.enter(self)

	emit_signal('state_changed', states_stack)
	
func insert_sort(lst, unit, action_weight):
	unit.calc_turn_order(action_weight)
	for i in range(len(lst)):
		if lst[i]._get_turn_order() > unit._get_turn_order():
			lst.insert(i, unit)
			return lst
	lst.append(unit)
	return lst

		
func _input(event):
	
	var new_state = current_state.handle_input(self, event)
	if new_state:
		_change_state(new_state)
		
func _process(delta):
	current_state.update(self, delta)

func end_turn():
	
	print("changing turn")
	for unit in unit_list:
		if unit.available == true:
			_change_state('chooseturn')
			_change_state(current_turn)
			return
	for unit in unit_list:
		unit.available = true
		unit.is_guarding = false
	_change_state('chooseturn')
	_change_state(current_turn)

func add_cameras():
	camera_list.append(mainBattleCamera)
	active_camera = mainBattleCamera
		


func update_skill_name(skill):
	skillNameDisplay.set_skill_name(skill.skillname) 
	
func update_skill_damage(damage):
	pass

func _on_unit_turn_finished(action_weight):
	player_units.erase(current_unit)
	insert_sort(player_units, current_unit, action_weight)
	battleState = BATTLESTATE.CHOOSE_TURN
	#choose_turn()

