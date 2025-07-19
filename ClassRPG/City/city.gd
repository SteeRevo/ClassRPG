extends Node3D

@onready var mainMenu = $MainMenu
@onready var menuBackground = $MainMenu/MenuBackground
@onready var worldEnvironment = $WorldEnvironment


func _input(event):
	if event.is_action_pressed("Cancel"):
		
		get_tree().paused = true
		mainMenu.visible = true
		print("paused")
		visible = false
		mainMenu.set_viewable(worldEnvironment)
		
		
