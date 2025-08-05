extends Node

@export var currentBank = {}

@export var allSpirits = {
	"Null" : null,
	"Monk" : "res://Spirits/monk.tres",
	
}

func add(name):
	currentBank[name] = allSpirits[name]
