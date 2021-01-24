extends Control
var index = 0

func _ready():
	$AudioStreamPlayer.play()

func _input(event):
	if event.is_action_pressed("ui_textForward") and index < 7:
		index += 1
		update_screen()
	elif event.is_action_pressed("ui_textBackward") and index > 0:
		index -= 1
		update_screen()
		
func update_screen():
	match index:
		0:
			$Sprite.visible = true
			$Sprite2.visible = false
		1:
			$Sprite2.visible = true
			$Sprite.visible = false
			$Sprite3.visible = false
		2:
			$Sprite3.visible = true
			$Sprite2.visible = false
			$Sprite4.visible = false
		3:
			$Sprite4.visible = true
			$Sprite3.visible = false
			$Sprite5.visible = false
		4:
			$Sprite5.visible = true
			$Sprite4.visible = false
			$Sprite6.visible = false
		5:
			$Sprite6.visible = true
			$Sprite5.visible = false
		6:
			get_tree().change_scene("res://Scenes/Main Menu.tscn")
