extends "res://Scripts/StaticInteractable.gd"


func _ready():
	$AudioStreamPlayer.stream.loop = false

func interact():
	if PlayerVariables.checkItem("strawberry"):
		interactionText = "I've already picked enough strawberries for the waffles! Cute plant though."
	else:
		$AudioStreamPlayer.play()
		PlayerVariables.getItem("strawberry")
	
