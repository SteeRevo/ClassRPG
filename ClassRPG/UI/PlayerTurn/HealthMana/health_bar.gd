extends TextureProgressBar

@onready var timer = $Timer
@onready var damageBar = $DamageBar
@onready var healthNumber = $HealthNumber
@onready var overhealthbar = $OverhealthBar

var health = 0 : set = _set_health
var max_health = 0
var overhealth = 0 : set = _set_overhealth

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	$HealthNumber.text = str(health)
	
	if health < prev_health:
		timer.start()
	else:
		damageBar.value = health * 10
		
func _set_overhealth(overhealth):
	if overhealth > max_value:
		overhealth = max_value
	overhealthbar.value = overhealth


func init_health(curr_health, max_health):
	max_value = max_health
	health = curr_health
	value = health
	damageBar.max_value = max_health * 10
	damageBar.value = health * 10
	$HealthNumber.text = str(health)
	overhealthbar.value = 0
	overhealthbar.max_value = max_health
	


func _on_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property(damageBar, "value", health, 1).set_trans(Tween.TRANS_LINEAR)
