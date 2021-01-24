extends "res://Scripts/StaticInteractable.gd"


func _ready():
	$AudioStreamPlayer.stream.loop = false

func interact():
	if PlayerVariables.checkItem("orange"):
		interactionText = "No more ingredients in the fridge. We should really go shopping soon."
	else:
		$AudioStreamPlayer.play()
		PlayerVariables.getItem("orange")
	
