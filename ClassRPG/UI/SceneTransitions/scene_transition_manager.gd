extends Control

signal transition_started
signal transition_finished

func play_battle_entry():
	$AnimationPlayer.play("BattleEntry")
	
func play_battle_exit():
	$AnimationPlayer.play("BattleExit")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "BattleEntry":
		transition_started.emit()
	if anim_name == "BattleExit":
		transition_finished.emit()
