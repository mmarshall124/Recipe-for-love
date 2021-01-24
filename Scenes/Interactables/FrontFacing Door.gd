extends "res://Scripts/StaticInteractable.gd"

var open = false

func _ready():
	$AudioStreamPlayer.stream.loop = false

func interact():
	if not open:
		$AnimationPlayer.play("Open")
		
	else:
		$AnimationPlayer.play("Close")
		

# Once the animation finishes, set the collision shapes to the proper configuration
# for that state.
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Open":
		$CollisionShape2D.disabled = true
		$OpenCollider.disabled = false
		$AudioStreamPlayer.play()
		open = true
	elif anim_name == "Close":
		$CollisionShape2D.disabled = false
		$OpenCollider.disabled = true
		$AudioStreamPlayer.play()
		open = false
