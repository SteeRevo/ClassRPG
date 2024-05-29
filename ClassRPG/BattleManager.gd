extends Node

enum BATTLESTATE {PLAYER_TURN_START, SELECT_BG, BG_SELECTED, CHOOSE_TURN, SELECT_ENEMY, ENEMY_SELECTED, ENEMY_TURN}

var battleState = BATTLESTATE.CHOOSE_TURN

var player_units = []
var enemy_units = []
var unit_list = []
var bgs = []
var enemy_bgs = []
var current_selected_enemy 
var current_selected_BG

signal end_player_turn
signal end_enemy_turn
signal selected
signal rotate_finished
signal skill_confirmed

@onready var current_unit = $PlayerUnits/Sam
@onready var BGF = $Battlegrounds/Battleground
@onready var BGT = $Battlegrounds/Battleground2
@onready var BGB = $Battlegrounds/Battleground3
@onready var BGR = $Battlegrounds/Battleground4

@onready var EBGF = $EnemyBGs/Battleground
@onready var EBGT = $EnemyBGs/Battleground2
@onready var EBGB = $EnemyBGs/Battleground3
@onready var EBGR = $EnemyBGs/Battleground4
@onready var skillPoints = $Control/Skillpoints

@onready var enemySelector = $UI3d/EnemySelector
@onready var skillNameDisplay = $Control/Skillname



func _ready():
	$PlayerUnits/Sam.play_idle()
	
	#BGF._set_current_unit($PlayerUnits/Unit)
	set_all_units_position()
	print(BGF._get_current_unit())
	#$PlayerUnits/Unit._set_BG(BGF)
	#print(current_unit._get_BG())
	
	#BGT._set_current_unit($PlayerUnits/Unit2)
	#$PlayerUnits/Unit._set_BG(BGT)
	
	current_selected_enemy = $EnemyUnits/Enemy1
	
	
	
	get_all_units()
	
	print(player_units)
	print(enemy_units)
	
	choose_turn()
	
func insert_sort(lst, unit, action_weight):
	unit.calc_turn_order(action_weight)
	for i in range(len(lst)):
		if lst[i]._get_turn_order() > unit._get_turn_order():
			lst.insert(i, unit)
			return lst
	lst.append(unit)
	return lst
		

func set_all_units_position():
	for bg in $Battlegrounds.get_children():
		bgs.append(bg)
	for bg in $EnemyBGs.get_children():
		enemy_bgs.append(bg)
	for unit in $PlayerUnits.get_children():
		bgs[unit.startingBG]._set_current_unit(unit)
		unit._set_BG(bgs[unit.startingBG])
	for unit in $EnemyUnits.get_children():
		enemy_bgs[unit.startingBG]._set_current_unit(unit)
		unit._set_BG(enemy_bgs[unit.startingBG])
		
	print(enemy_bgs)	
	pass
	
	
func get_all_units():
	for unit in $PlayerUnits.get_children():
		insert_sort(player_units, unit, 100)
		unit_list.append(unit)
	for unit in $EnemyUnits.get_children():
		insert_sort(enemy_units, unit, 100)
		unit_list.append(unit)

func choose_turn():
	set_current_unit()
	
	
func set_current_unit():
	if player_units[0]._get_turn_order() <= enemy_units[0]._get_turn_order():
		current_unit = player_units[0]
		calc_turn_advance()
		battleState = BATTLESTATE.PLAYER_TURN_START
		on_player_turn_started()
	else:
		current_unit = enemy_units[0]
		calc_turn_advance()
		battleState = BATTLESTATE.ENEMY_TURN
		start_enemy_turn()

func on_player_turn_started():
	print("=====player turn=========")
	for unit in player_units:
		print(unit.name + ": current turn_order = " + str(unit._get_turn_order()))
	for unit in enemy_units:
		print(unit.name + ": current turn_order = " + str(unit._get_turn_order()))
	print("Current Unit is: " + current_unit.name)
	print("Press D to attack, A to Guard, W for Skill, S for Rotate.")

func calc_turn_advance():
	var turn_advance = current_unit._get_turn_order()
	current_unit._set_turn_order(0)
	for unit in player_units:
		unit._set_turn_order(unit._get_turn_order() - turn_advance)
		print()
	for unit in enemy_units:
		unit._set_turn_order(unit._get_turn_order() - turn_advance)
		
		
func _input(event):
	
	if battleState == BATTLESTATE.PLAYER_TURN_START:
		if event.is_action_pressed("Attack") :
			print("Attack")
			_on_attack_pressed()
		if event.is_action_pressed("Rotate"):
			print("Rotate")
			_on_rotate_pressed()
		if event.is_action_pressed("Guard"):
			print("Guard")
		if event.is_action_pressed("Skill"):
			print("Skill")
			_on_skill_pressed()
	elif battleState == BATTLESTATE.SELECT_BG:
		select_ally_BG(event)
		
	elif battleState == BATTLESTATE.SELECT_ENEMY:
		select_enemy_unit(event)
		
	elif battleState == BATTLESTATE.BG_SELECTED:
		confirm_BG(event)
		
	elif battleState == BATTLESTATE.ENEMY_SELECTED:
		confirm_enemy(event)
		

		
func select_enemy_unit(event):
	if event.is_action_pressed("Attack") :
			if EBGR._get_current_unit():
				current_selected_enemy = EBGR._get_current_unit()
				print("selected " + current_selected_enemy.name + current_selected_enemy._get_BG().name)
				enemySelector.set_BG_position(EBGR)
				battleState = BATTLESTATE.ENEMY_SELECTED
				print("double tap to select")
			else:
				print("no enemy here")
	elif event.is_action_pressed("Rotate"):
		if EBGB._get_current_unit():
			current_selected_enemy = EBGB._get_current_unit()
			print("selected " + current_selected_enemy.name + current_selected_enemy._get_BG().name)
			enemySelector.set_BG_position(EBGB)
			battleState = BATTLESTATE.ENEMY_SELECTED
			print("double tap to select")
		else:
			print("no enemy here")
	elif event.is_action_pressed("Guard"):
		if EBGF._get_current_unit():
			current_selected_enemy = EBGF._get_current_unit()
			print("selected " + current_selected_enemy.name + current_selected_enemy._get_BG().name)
			enemySelector.set_BG_position(EBGF)
			battleState = BATTLESTATE.ENEMY_SELECTED
			print("double tap to select")
		else:
			print("no enemy here")
	elif event.is_action_pressed("Skill"):
		if EBGT._get_current_unit():
			current_selected_enemy = EBGT._get_current_unit()
			print("selected " + current_selected_enemy.name + current_selected_enemy._get_BG().name)
			enemySelector.set_BG_position(EBGT)
			battleState = BATTLESTATE.ENEMY_SELECTED
			print("double tap to select")
		else:
			print("no enemy here")
			
func select_ally_BG(event):
	if event.is_action_pressed("Attack") and BGF != current_unit._get_BG():
		current_selected_BG = BGF
		#print("selected " + current_selected_ally.name + current_selected_ally._get_BG().name)
		enemySelector.set_BG_position(BGF)
		battleState = BATTLESTATE.BG_SELECTED
		print("double tap to select")

	elif event.is_action_pressed("Rotate") and BGB != current_unit._get_BG():
		current_selected_BG = BGB
		#print("selected " + current_selected_ally.name + current_selected_ally._get_BG().name)
		enemySelector.set_BG_position(BGB)
		battleState = BATTLESTATE.BG_SELECTED
		print("double tap to select")

	elif event.is_action_pressed("Guard") and BGR != current_unit._get_BG():
		current_selected_BG = BGR
		#print("selected " + current_selected_ally.name + current_selected_ally._get_BG().name)
		enemySelector.set_BG_position(BGR)
		battleState = BATTLESTATE.BG_SELECTED
		print("double tap to select")
		
	elif event.is_action_pressed("Skill") and BGT != current_unit._get_BG():
		current_selected_BG = BGT
		#print("selected " + current_selected_ally.name + current_selected_ally._get_BG().name)
		enemySelector.set_BG_position(BGT)
		battleState = BATTLESTATE.BG_SELECTED
		print("double tap to select")
			
func confirm_enemy(event):
	#if double clicked selects enemy
	if event.is_action_pressed("Attack") && current_selected_enemy._get_BG() == EBGR:
		emit_signal("selected")
		
	elif event.is_action_pressed("Guard") && current_selected_enemy._get_BG() == EBGF:
		emit_signal("selected")
		
	elif event.is_action_pressed("Rotate") && current_selected_enemy._get_BG() == EBGB:
		emit_signal("selected")
		
	elif event.is_action_pressed("Skill") && current_selected_enemy._get_BG() == EBGT:
		emit_signal("selected")
		
	elif event.is_action_pressed("Attack") or event.is_action_pressed("Rotate") or event.is_action_pressed("Skill") or event.is_action_pressed("Guard"):
		battleState = BATTLESTATE.SELECT_ENEMY
		select_enemy_unit(event)

func confirm_BG(event):
	#if double clicked selects enemy
	if event.is_action_pressed("Attack") && current_selected_BG == BGF:
		emit_signal("selected")
		
	elif event.is_action_pressed("Guard") && current_selected_BG == BGR:
		emit_signal("selected")
		
	elif event.is_action_pressed("Rotate") && current_selected_BG == BGB:
		emit_signal("selected")
		
	elif event.is_action_pressed("Skill") && current_selected_BG == BGT:
		emit_signal("selected")
		
	elif event.is_action_pressed("Attack") or event.is_action_pressed("Rotate") or event.is_action_pressed("Skill") or event.is_action_pressed("Guard"):
		battleState = BATTLESTATE.SELECT_BG
		select_ally_BG(event)
		
func rotate_units(unit1, unit2, BG1, BG2):
	print("rotating")
	print(unit1.name)
	print(unit2.name)
	print(BG1.name)
	print(BG2.name)
	unit1.move_towards(BG2.global_position)
	set_BG_unit_position(unit1, BG2)
	if(unit2 != null):
		unit2.move_towards(BG1.global_position)
		print("moved")
	set_BG_unit_position(unit2, BG1)
	
func start_enemy_turn():
	print("============Enemy turn=============")
	enemy_units.erase(current_unit)
	insert_sort(enemy_units, current_unit, 30)
	battleState = BATTLESTATE.CHOOSE_TURN
	choose_turn()

func set_BG_unit_position(unit, bg):
	if unit != null:
		unit._set_BG(bg)
	bg._set_current_unit(unit)
	
func _on_attack_pressed():
	print("Player selects unit to attack")
	for unit in enemy_units:
		print(unit.name)
	battleState = BATTLESTATE.SELECT_ENEMY
	await selected
	print("signal received")
	battleState = BATTLESTATE.ENEMY_TURN
	skillPoints._add_skill_points(1)
	print("do attack")
	if current_unit.name == "Sam":
		current_unit.play_attack()
	_on_unit_turn_finished(40)
	
func _on_rotate_pressed():
	print("Player select ally to rotate")
	battleState = BATTLESTATE.SELECT_BG
	await selected
	rotate_units(current_unit, current_selected_BG._get_current_unit(), current_unit._get_BG(), current_selected_BG)
	await current_unit.unitTween.finished
	_on_unit_turn_finished(30)
	
func _on_skill_pressed():
	var current_skills = current_unit.get_skill_list()
	for skills in current_skills:
		print(skills.skillname)
	var selected_skill = current_skills[0]
	update_skill_name(selected_skill)
	await skill_confirmed

func update_skill_name(skill):
	skillNameDisplay.set_skill_name(skill.skillname) 

func _on_unit_turn_finished(action_weight):
	player_units.erase(current_unit)
	insert_sort(player_units, current_unit, action_weight)
	battleState = BATTLESTATE.CHOOSE_TURN
	choose_turn()
