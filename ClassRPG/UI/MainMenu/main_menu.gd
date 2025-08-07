extends CanvasLayer

var states_stack = []
var current_state = null

signal state_changed

@onready var BB = $MenuBackground/BBMenu/AnimationPlayer
@onready var Phyllis = $MenuBackground/PhyllisMenu/AnimationPlayer
@onready var Sam = $MenuBackground/SamMenu/AnimationPlayer
@onready var EquipPointerPos = $Control/MarginContainer/BaseMenuContainer/EquipSpirit/PointerPos
@onready var JournalPointerPos = $Control/MarginContainer/BaseMenuContainer/Journal/PointerPos
@onready var StatusPointerPos = $Control/MarginContainer/BaseMenuContainer/Status/PointerPos
@onready var PositionPointerPos = $Control/MarginContainer/BaseMenuContainer/Position/PointerPos
@onready var subviewportContainer = $MenuBackground/SubViewportContainer
@onready var baseMenu = $Control/MarginContainer/BaseMenuContainer
@onready var menu = $Control
@onready var background = $MenuBackground
@onready var menuEnvir = $MenuBackground/SubViewportContainer/SubViewport/Camera3D/MenuWorldEnvironment
@onready var menuCam = $MenuBackground/SubViewportContainer/SubViewport/Camera3D

@onready var equipUnit = $Control/MarginContainer/EquipUnit
@onready var equipMenu = $Control/MarginContainer/EquipSpiritContainer
@onready var spiritAttach = $Control/SpiritAttach
@onready var inputSpirit = $Control/SpiritAttach/EquippedSpirit
@onready var battlegroundSpirit = $Control/SpiritAttach/BattlegroundSpirits
@onready var statusMenu = $Control/StatusMenu

@onready var menuCursor = $Control/SpiritAttach/MenuCursor

@onready var menuEnviron = preload("res://UI/MainMenu/main_menu_environment.tres")

@onready var SamEquipCamera = $MenuBackground/SubViewportContainer/SubViewport/SamEquipCameraPoint
@onready var BBEquipCamera = $MenuBackground/SubViewportContainer/SubViewport/BBEquipCameraPoint
@onready var PhilEquipCamera = $MenuBackground/SubViewportContainer/SubViewport/PhilEquipCameraPoint
@onready var MenuBaseCamera = $MenuBackground/SubViewportContainer/SubViewport/MenuBaseCameraPoint



var currentOption = null

var menuOptions = []

var current_unit = null
var current_option = 0
var sam_anim_noplay = false

var current_move = null
var selected_spirit = null

var current_status = 0


@export var current_environMat:Environment
@export var current_environ:WorldEnvironment

@onready var states_map = {
	'base': $States/MenuBase,
	'equip': $States/EquipSpirit,
	'equipUnit': $States/EquipUnit,
	'spiritAttach': $States/SpiritAttach,
	'status': $States/Status
}


# Called when the node enters the scene tree for the first time.
func _ready():
	#set_invisible()
	SpiritBank.add("Monk")
	spiritAttach.set_current_spirit_bank()
	menuOptions = [EquipPointerPos, JournalPointerPos, StatusPointerPos, PositionPointerPos]
	currentOption = 0
	set_menu_pointer_pos()
	states_stack.push_front($States/MenuBase)
	current_state = states_stack[0]
	_change_state('base')

func _change_state(state_name):
	current_state.exit(self)
	if state_name == 'previous':
		states_stack.pop_front()
	elif state_name in ['equip', 'equipUnit', 'spiritAttach', 'status']:
		states_stack.push_front(states_map[state_name])
	else:
		var new_state = states_map[state_name]
		states_stack[0] = new_state

	current_state = states_stack[0]
	current_state.enter(self)

	emit_signal('state_changed', states_stack)
	
func _input(event):
	var new_state = current_state.handle_input(self, event)
	if new_state:
		_change_state(new_state)

func _process(delta):
	current_state.update(self, delta)
		
	
func stop_menu_animation():
	BB.stop()
	Phyllis.stop()
	Sam.stop()
	
func set_menu_pointer(direction):
	menuOptions[currentOption].visible = false
	if direction == "Up":
		currentOption = max(0, currentOption - 1)
	elif direction == "Down":
		currentOption = min(menuOptions.size() - 1, currentOption + 1)
	set_menu_pointer_pos()
		
func set_menu_pointer_pos():
	menuOptions[currentOption].visible = true
	
func set_invisible():
	subviewportContainer.visible = false
	menu.visible = false
	background.visible = false
	current_environ.environment = current_environMat
	get_tree().paused = false
	get_parent().visible = true
	stop_menu_animation()
	
	
func set_viewable():
	subviewportContainer.visible = true
	menu.visible = true
	background.visible = true
	_change_state('base')
	current_environ.environment = menuEnviron
	get_tree().paused = true
	get_parent().visible = false
	
	
