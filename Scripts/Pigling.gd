extends KinematicBody2D

export var itemName = ""
export var interactionText = ""

onready var complexDialogue = $ComplexDialogue
onready var animationState = $AnimationTree.get("parameters/playback")

var MAX_SPEED = 80
var input_vector = Vector2.ZERO

func _ready():
	randomize()
	$WalkTimer.start()
	$AudioStreamPlayer.stream.loop = false
	animationState.travel("Run")

# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	move_and_slide(input_vector * MAX_SPEED)
	


func _on_WalkTimer_timeout():
	input_vector.x = rand_range(-1.0,1.0)
	input_vector.y = rand_range(-1.0,1.0)
	input_vector = input_vector.normalized()
	
	$AnimationTree.set("parameters/Run/blend_position", input_vector)
	animationState.travel("Run")
	$WalkTimer.start()
	

func interact():
	if PlayerVariables.checkItem("bacon"):
		complexDialogue = null
		interactionText = "It can only grow bacon back so fast. Let's not press our luck."
	else:
		$AudioStreamPlayer.play()
		PlayerVariables.getItem("bacon")
	animationState.travel("IdleForward")
	
