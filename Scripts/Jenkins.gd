extends "res://Scripts/StaticInteractable.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	# This is declared in ready because the superclass already declares complexDialogue
	complexDialogue = $ComplexDialogue
	$AnimationPlayer.play("Rockin'")

func interact():
	if PlayerVariables.checkItem("waffle_mix"):
		complexDialogue = $JenkinsStory
	else:
		$AudioStreamPlayer.play()
		PlayerVariables.getItem("waffle_mix")
	
