"""
Base interface for all states, ensure right arguments are passed
"""

extends Node

func enter(host):
	return
	
func exit(host):
	return
	
func handle_input(host, event):
	return

func update(host, delta):
	return

func _on_animation_finished(anim_name):
	return

func set_active_camera(host, camera):
	host.active_camera.current = false
	camera.current = true
	host.active_camera = camera
	host.active_camera.start_anim()
