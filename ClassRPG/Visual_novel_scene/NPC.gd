extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if(name == "BBNPC"):
		$BB/AnimationPlayer.play("Investigating")
	elif(name == "samNPC"):
		$Sam/AnimationPlayer.play("Relax")
