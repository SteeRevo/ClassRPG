extends CanvasLayer

var states_stack = []
var current_state = null

signal state_changed

@onready var BB = $MenuBackground/BBMenu/AnimationPlayer
@onready var Phyllis = $MenuBackground/PhyllisMenu/AnimationPlayer
@onready var Sam = $MenuBackground/SamMenu/AnimationPlayer
@onready var EquipPointerPos = $Control/MarginContainer/HBoxContainer/VBoxContainer/EquipSpirit/PointerPos
@onready var JournalPointerPos = $Control/MarginContainer/HBoxContainer/VBoxContainer/Journal/PointerPos
@onready var subviewportContainer = $MenuBackground/SubViewportContainer
@onready var menu = $Control
@onready var background = $MenuBackground
@onready var menuEnvir = $MenuBackground/SubViewportContainer/SubViewport/Camera3D/MenuWorldEnvironment
@onready var menuEnviron = preload("res://UI/MainMenu/main_menu_environment.tres")

var currentOption = null

var menuOptions = []

@onready var states_map = {
	'base': $States/MenuBase
}


# Called when the node enters the scene tree for the first time.
func _ready():
	set_invisible()
	menuOptions = [EquipPointerPos, JournalPointerPos]
	currentOption = 0
	set_menu_pointer_pos()
	states_stack.push_front($States/MenuBase)
	current_state = states_stack[0]
	_change_state('base')

func _change_state(state_name):
	current_state.exit(self)
	if state_name == 'previous':
		states_stack.pop_front()
	elif state_name in []:
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
	
func play_menu_animation(anim_name):
	BB.play(anim_name)
	Phyllis.play(anim_name)
	Sam.play(anim_name)
	
func set_menu_pointer(direction):
	menuOptions[currentOption].visible = false
	if direction == "Up":
		currentOption = min(0, currentOption)
	elif direction == "Down":
		currentOption = min(menuOptions.size() - 1, currentOption + 1)
	set_menu_pointer_pos()
		
func set_menu_pointer_pos():
	menuOptions[currentOption].visible = true
	
func set_invisible(worldEnvir, envir_mat):
	subviewportContainer.visible = false
	menu.visible = false
	background.visible = false
	
func set_viewable(worldEnvir):
	subviewportContainer.visible = true
	menu.visible = true
	background.visible = true
	_change_state('base')
	worldEnvir.environment = menuEnviron
	
