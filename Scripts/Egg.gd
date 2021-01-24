extends Area2D

var itemName = "Egg"
var interactionText = "Yo fucker, you just picked me up!"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Egg_body_entered(body):
	body.interactables.append(self)



func _on_Egg_body_exited(body):
	var index = body.interactables.find(self)
	body.interactables.remove(index)

func interact():
	queue_free()
