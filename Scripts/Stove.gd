extends "res://Scripts/StaticInteractable.gd"

func _ready():
	$AudioStreamPlayer.stream.loop = false

func interact():
	if PlayerVariables.checkItem("used_stove"):
		interactionText = "Breakfast is finished! Time to bring it to Ginger!"
	else:
		if PlayerVariables.winCons[0] and PlayerVariables.winCons[1] and PlayerVariables.winCons[2] and PlayerVariables.winCons[3] and PlayerVariables.winCons[4]:
			interactionText = "I have all the ingredients I need! Time to get cooking!"
			$AudioStreamPlayer.play()
			PlayerVariables.getItem("used_stove")
	
