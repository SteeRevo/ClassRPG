extends 'Unit.gd'

func set_unit_spirits(unit_stats):
	for move in attached_spirits:
		attached_spirits[move] = unit_stats.spirits[move]
