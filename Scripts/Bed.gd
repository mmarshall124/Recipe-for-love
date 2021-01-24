extends "res://Scripts/StaticInteractable.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	# This is declared in ready because the superclass already declares complexDialogue
	complexDialogue = $ComplexDialogue


# The bed is used to end the game (you brought your wife breakfast), so it checks
# for each win condition and emits a winConMet signal if they're all true.
func interact():
	for condition in PlayerVariables.winCons:
		if not condition:
			return
	
	complexDialogue = $"End Text"
