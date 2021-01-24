extends Node

# This is the superclass for playable levels to promote code reuse.
# Each level has to connect it's own objects based on their position in that level's
# unique tree structure.

func playDialogue(Item):
	# If the item has a JSON script to load for dialogue, make a copy of the data
	# and pass it to the UI. It gets copied because we then pop that data as we play it.
	if Item.complexDialogue != null:
		$UI/DialoguePopup.complexText = Item.complexDialogue.complexTextArray.duplicate()
		
	# Else if they just use strings for simple dialogue, process and display it.
	elif Item.interactionText != "":
		$UI/DialoguePopup.process_text(Item.interactionText)
		

	# No text, no need to open the UI.
	else:
		return
	
	# Set the item's display name	
	if Item.itemName != "":
		$"UI/DialoguePopup/ColorRect/Character Name".text = Item.itemName
	else:
		$"UI/DialoguePopup/ColorRect/Character Name".text = "???"
		
	# Open the popup and begin dialogue.
	$UI/DialoguePopup.openPopup()

func change_level(path, spawn):
	get_tree().change_scene(path)
	PlayerVariables.sceneChanged = true
	PlayerVariables.spawnPoint = spawn
	
func check_spawn_change(Player):
	# If the player came in from another level (outside), put them at
	# the spawn point for this scene.
	if PlayerVariables.sceneChanged:
		Player.position = PlayerVariables.spawnPoint
		PlayerVariables.sceneChanged = false
		return true
	return false

