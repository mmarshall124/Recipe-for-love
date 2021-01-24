extends KinematicBody2D

signal interactedWith(Item)

# Movement variables
export var MAX_SPEED = 100

onready var camera = $Camera2D
onready var animationPlayer = $AnimationPlayer
onready var animationState = $AnimationTree.get("parameters/playback")
# This ray lets us know if the player is standing within one tile of an interactable
# object.
onready var interactionRay = $"Interaction Ray"
# This timer stops the player from spamming multiple interact requests too quickly.
onready var interactionTimer = $Timer

# An array of objects that the interaction ray has already collided with. This
# exists so we don't fill the interactables array with the same object.
var rayCollisions = []

# A array that stores the list of items you can interact with from your current
# position. Is effectively used as a queue.
var interactables = []


func _physics_process(_delta):
	
	# Weighs the strength of our movement directions against each other, normalizes it,
	# and stores it in an input vector for use with movement and animation.
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	# Uses the direction of our input vector to choose the animation to play.
	animate(input_vector)
	
	# Point the interaction ray in the direction we're moving.
	point_ray(input_vector)
	
	# Move in the direction of the input vector.
	move_and_slide(input_vector * MAX_SPEED)
	
	# Moves all the items the interaction ray is hitting into the interactables queue.
	ray_to_interactables()
			
	
func _input(event):
	if event.is_action("grab"):
		interact()


func interact():
	if interactionTimer.is_stopped():
		if interactables.size() > 0:
			interactionTimer.start()
			var item = interactables.pop_front()
			# Use the item specific interaction code.
			animationState.travel("Idle")
			item.interact()
			emit_signal("interactedWith", item)
		

# Sets the blend positions and updates our animation based on our input vector
func animate(input_vector):
	if input_vector != Vector2.ZERO:
		$AnimationTree.set("parameters/Idle/blend_position", input_vector)
		$AnimationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
	else:
		animationState.travel("Idle")
		

# Points our interaction ray in the direction of our movement vector.
func point_ray(input_vector):
	if input_vector != Vector2.ZERO:
		interactionRay.set_cast_to(input_vector * 8)


# This function sees if our interaction ray is colliding with anything and if so
# adds them to the list of interactable objects once. If it's not colliding with
# anything it removes the previous objects from the list of interactables.		
func ray_to_interactables():
	var rayCollision = interactionRay.get_collider()
	if rayCollision != null:
		if not rayCollision in rayCollisions:
			rayCollisions.append(rayCollision)
		if not rayCollision in interactables:
			interactables.append(rayCollision)
	else:
		for ray in rayCollisions:
			var index = interactables.find(ray)
			if index != -1:
				interactables.remove(index)
		rayCollisions = []

# The timer was having issues stopping so we make sure to stop it on timeout.
func _on_Timer_timeout():
	interactionTimer.stop()

# These functions cause objects on the transparency layer to become see through
# when we walk behind them.
func _on_Transparency_Bubble_body_entered(body):
	body.modulate = Color(1,1,1,0.4)
func _on_Transparency_Bubble_body_exited(body):
	body.modulate = Color(1,1,1,1)
