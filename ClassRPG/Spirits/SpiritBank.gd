extends Node

@export var currentBank = []

@export var allSpirits = {
	"Monk" : "res://Spirits/monk.tres"
}

func add(name):
	currentBank.append(allSpirits[name])
