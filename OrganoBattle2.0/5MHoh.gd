extends TextureRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ContinueButton_pressed():
	global.currentChemical = "5-methyl-1-hexanol"
	get_tree().change_scene("res://FinalSynthesisWindow.tscn")
