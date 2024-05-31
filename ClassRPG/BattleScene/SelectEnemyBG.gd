extends States

func enter(host):
	print("Player selects unit to attack")
	for unit in host.enemy_units:
		print(unit.name)

func handle_input(host, event):
	if event.is_action_pressed("Cancel"):
		return 'previous'
