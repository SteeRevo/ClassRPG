extends Node3D

@onready var mainMenu = $MainMenu
@onready var menuBackground = $MainMenu/MenuBackground
@onready var worldEnvironment = $WorldEnvironment
@onready var worldMat = preload("res://City/city_environment.tres")

func _ready():
	mainMenu.set_invisible()

func _input(event):
	pass
