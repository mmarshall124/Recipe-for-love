extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/DialoguePopup.complexText = $ComplexDialogue.complexTextArray.duplicate()
	$UI/DialoguePopup.openPopup()
	$UI/DialoguePopup.connect("endDialogue", self, "quit")


func quit():
	get_tree().change_scene("res://Scenes/Credits.tscn")
