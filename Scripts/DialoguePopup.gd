extends Popup

onready var animation = $AnimationPlayer


# Used to track where we are in dialogue to go back or forward.
var textIndex = 0

# This signal is used to indicate to the intro and outro scenes when to change the picture
signal imageChange()

# This signal indicates when dialogue has finished and the popup is closed.
signal endDialogue()


# Transitions to outro.
signal winConMet()

# textArray holds text imported from an interactable item's interactionText variable.
# It has to be imported through the process_text function.
var textArray = []

# complexText holds text imported from a json file. It contains flags for more
# detailed conversations with multiple speakers, sprites, image changes, etc.
var complexText = []


# process_input is usually set to false so this doesn't have to run every tick.
func _input(event):
	if event.is_action("ui_textForward") and visible:
		if textIndex < complexText.size():
			play_complex()
		
		elif textIndex < textArray.size():
			play_simple()
		else:
			# If there's no more text to read then you can close the popup.
			close()
	elif event.is_action_pressed("hide"):
		visible = !visible
		
	elif event.is_action_pressed("ui_textBackward") and visible:
		if textIndex > 1:
			textIndex -= 2
			if textIndex < complexText.size():
				play_complex()
			
			elif textIndex < textArray.size():
				play_simple()
			
			

func openPopup():
	if complexText.size() > 0:
		play_complex()
	else:
		play_simple()
		
	# Pause the current scene while dialogue is playing
	get_tree().paused = true
	popup()
	
func close():
	# Unpause
	get_tree().paused = false
	
	# Don't take user input
	set_process_input(false)
	
	textIndex = 0
	textArray = []
	complexText = []
	
	
	# Hide all sprites
	$Wife.visible = false
	$MC.visible = false
	$Jenkins.visible = false
	$Pigling.visible = false
	
	# Hide the textbox
	hide()
	
	# Signal you finished
	emit_signal("endDialogue")

# Handles text imported as a string from the object itself.
func play_simple():
	$ColorRect/Dialogue.text = textArray[textIndex]
	set_process_input(false)
	animation.play("showDialogue")
	textIndex += 1
	
# Handles text imported from a complexDialogue node.
func play_complex():
	# Current text box
	var current = complexText[textIndex]
	
	# Setting the text and dialogue boxes to the imported data.
	$ColorRect/Dialogue.text = current["text"]
	$"ColorRect/Character Name".text = current["speaker"]
	
	# Displaying sprites.
	if current["speaker"] == "Wife":
		$Wife.visible = true
	elif current["speaker"] == "Melissa":
		$MC.visible = true
	elif current["speaker"] == "Jenkins":
		$Jenkins.visible = true
	elif current["speaker"] == "Pigling":
		$Pigling.visible = true
		
	# Handles changing images for the intro and outro.
	if current.has("imageChange"):
		emit_signal("imageChange")
		
	if current.has("END"):
		emit_signal("winConMet")
		
	# Disable player input and play the text scroll animation.
	set_process_input(false)
	animation.play("showDialogue")
	
	textIndex += 1

# When the text scroll animation finishes you can receive input.
func _on_AnimationPlayer_animation_finished(_anim_name):
	set_process_input(true)
	
# This function takes a string and formats it so it doesn't overflow the textbox.
# This has to be run first to display simple text.
# Note that it splits the middle of words sometimes. This could be fixed by splitting
# the text into words and adding up their length.
func process_text(text):
	var words = text.split(" ")
	
	var length = 0
	var newLength = 0
	
	for word in words:
		newLength = length
		newLength += word.length() + 1 # + 1 for spaces
		if newLength > 80:
			break
		else:
			length = newLength
	
	length -= 1 # To remove the trailing space.
	
	if text.length() > 80:
		var leftText = text.substr(0,newLength)
		leftText = leftText + "..."
		textArray.append(leftText)
		
		var rightText = text.substr(newLength)
		if rightText.length() > 80:
			process_text(rightText)
		else:
			textArray.append(rightText)
			
	else:
		textArray.append(text)
