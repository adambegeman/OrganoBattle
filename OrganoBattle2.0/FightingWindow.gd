extends TextureRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var attack_popup
var defense_popup
# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_node("PlayerPowerBar").value = global.power
	get_node("OpponentHealthBar").value = global.enemyHealth
	get_node("PlayerHealthBar").value = global.health
	
	if (global.isComputerTurn) :
		get_node("AttackButton").hide()
		#get_node("DefenseButton").hide()
		get_node("OpponentTurn").show()
		
	if (global.isEnemyEffect) :
		if (global.enemyEffect == "fire") :
			var t = Timer.new()
			t.set_wait_time(3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			get_node("FlameAttack").show()
			get_node("Scientist").hide()
			get_node("FlameAttack").play()
			yield(t, "timeout")
			t.queue_free()
			get_node("FlameAttack").hide()
			get_node("Scientist").show()
		elif (global.enemyEffect == "corrosive") :
			var t = Timer.new()
			t.set_wait_time(5)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			get_node("CorrosiveAttack").show()
			get_node("Scientist").hide()
			get_node("CorrosiveAttack").play()
			yield(t, "timeout")
			t.queue_free()
			get_node("CorrosiveAttack").hide()
			get_node("Scientist").show()
		elif (global.enemyEffect == "oral") :
			var t = Timer.new()
			t.set_wait_time(3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			get_node("OralToxicityAttack").show()
			get_node("Scientist").hide()
			get_node("OralToxicityAttack").play()
			yield(t, "timeout")
			t.queue_free()
			get_node("OralToxicityAttack").hide()
			get_node("Scientist").show()
		else :
			var t = Timer.new()
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			get_node("PowerUp").show()
			global.power += 10
			get_node("PlayerPowerBar").value = global.power
			yield(t, "timeout")
			t.queue_free()
			get_node("PowerUp").hide()
			
	global.isEnemyEffect = false
	
	if (global.health <= 0) :
		global.isGameOver = true
		global.reset()
		get_tree().change_scene("MainMenu.tscn")
	if (global.isComputerTurn) :
		var t = Timer.new()
		t.set_wait_time(5)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		global.health -= 10
		global.isComputerTurn = false
		get_node("OpponentTurn").hide()
		get_node("AttackButton").show()
		#get_node("DefenseButton").show()
	else :
		get_node("AttackButton").show()
		#get_node("DefenseButton").show()
	
	get_node("PlayerHealthBar").value = global.health

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AttackPopupMenu_id_pressed(ID):
	if (ID == 0) :
		global.startingChemical = "3MB"
		global.enemyEffect = "fire"
		global.targetChemical = global.flammableAttack[randi()%global.flammableAttack.size()]
		get_tree().change_scene("res://BattleWindow.tscn")
		print(global.targetChemical)
	elif (ID == 1) :
		global.startingChemical = "3MB"
		global.enemyEffect = "corrosive"
		global.targetChemical = global.corrosiveAttack[randi()%global.corrosiveAttack.size()]
		get_tree().change_scene("res://BattleWindow.tscn")
		print(global.targetChemical)
	elif (ID == 2) :
		global.startingChemical = "3MB"
		global.enemyEffect = "none"
		global.targetChemical = global.basicAttack[randi()%global.basicAttack.size()]
		get_tree().change_scene("res://BattleWindow.tscn")
		print(global.targetChemical)
	elif (ID == 3) :
		global.startingChemical = "3MB"
		global.enemyEffect = "oral"
		global.targetChemical = global.oralToxicityAttack[randi()%global.oralToxicityAttack.size()]
		get_tree().change_scene("res://BattleWindow.tscn")
		print(global.targetChemical)
	

func _on_DefensePopupMenu_id_pressed(ID):
	get_tree().change_scene("res://BattleWindow.tscn")


func _on_AttackButton_toggled(button_pressed):
	if(button_pressed):
		attack_popup = get_node("AttackPopupMenu")
		attack_popup.show()
	else:
		attack_popup = get_node("AttackPopupMenu")
		attack_popup.hide()
		
func _on_DefenseButton_toggled(button_pressed):
	if(button_pressed):
		defense_popup = get_node("DefensePopupMenu")
		defense_popup.show()
	else:
		defense_popup = get_node("DefensePopupMenu")
		defense_popup.hide()
