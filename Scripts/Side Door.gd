extends "res://Scripts/StaticInteractable.gd"

var open = false

func interact():
	if not open:
		$AnimationPlayer.play("Open")
		
	else:
		$AnimationPlayer.play("Close")
		
func ready():
	$OpenCollider.disabled = false
	$CollisionShape2D.disabled = true
		
		
	

# Names on collider's got reversed here because the direction changed but otherwise
# everything is identical to the forward door.
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Open":
		$CollisionShape2D.disabled = false
		$OpenCollider.disabled = true
		open = true
	elif anim_name == "Close":
		$CollisionShape2D.disabled = true
		$OpenCollider.disabled = false
		open = false
