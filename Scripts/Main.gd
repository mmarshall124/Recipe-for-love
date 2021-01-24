extends "res://Scripts/Level.gd"


onready var Player = $ViewportContainer/Viewport/House/YSort/Player

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Hooks the player's interactions to the UI through the superclass 
	# playDialogue function.
	Player.connect("interactedWith", self, "playDialogue")
	
	# Check to see if the player came in from another level, if so their spawn
	# point is different than the initial one.
	if not check_spawn_change(Player):
		$UI/DialoguePopup.complexText = $ComplexDialogue.complexTextArray.duplicate()
		$UI/DialoguePopup.openPopup()
	else:
		$UI/DialoguePopup.complexText = $ReturnText.complexTextArray.duplicate()
		$UI/DialoguePopup.openPopup()
	
	# Connecting win condition items with the UI
	# Connecting exits to changing levels
	$"ViewportContainer/Viewport/House/Exit".connect("sceneChange", self, "change_level")
	$UI/DialoguePopup.connect("winConMet", self, "winTransition")
	
func winTransition():
	get_tree().change_scene("res://Scenes/Outro.tscn")
