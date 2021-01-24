extends Control

# This tracks the current image that is being displayed
var imageIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connecting the UI to the relevant functions to handle json flags.
	$UI/DialoguePopup.connect("imageChange", self, "change_image")
	$UI/DialoguePopup.connect("endDialogue", self, "scene_change")
	
	# Initialize the intro text and play it.
	$UI/DialoguePopup.complexText = $ComplexDialogue.complexTextArray.duplicate()
	$UI/DialoguePopup.openPopup()

# Plays when we need to display a different image.
func change_image():
	imageIndex += 1
	
	# Sprites are drawn on top of each other in order,
	# no need to set visible to false.
	match imageIndex:
		1: $B1.visible = true
		2: $B2.visible = true
		3: $B3.visible = true
		4: $B4.visible = true
		5: $B5.visible = true

# Transition to the first level.		
func scene_change():
	get_tree().change_scene("res://Scenes/Main.tscn")
