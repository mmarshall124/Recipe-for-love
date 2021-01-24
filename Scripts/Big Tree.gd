extends "res://Scripts/StaticInteractable.gd"

func _ready():
	$AudioStreamPlayer.stream.loop = false

func interact():
	if PlayerVariables.checkItem("egg"):
		interactionText = "I've already robbed these poor, not at all innocent hell birds of their child. I shouldn't take any more or I'll go to super hell."
	else:
		$AudioStreamPlayer.play()
		PlayerVariables.getItem("egg")
	
