extends Control


# On start, go to the intro.
func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Intro.tscn")


func _on_Background_Theme_finished():
	# Background music file doesn't seem to have a loop property for some reason.
	# Quick fix.
	$"Background Theme".play()



# Color isn't a property of the label itself and is annoying to change, so instead
# there's two labels in different colors that we switch between.
func _on_Start_mouse_entered():
	$CanvasLayer/Background/Start/Pink.visible = false
	$CanvasLayer/Background/Start/White.visible = true


func _on_Start_mouse_exited():
	$CanvasLayer/Background/Start/Pink.visible = true
	$CanvasLayer/Background/Start/White.visible = false


func _on_Exit_mouse_entered():
	$CanvasLayer/Background/Exit/Pink.visible = false
	$CanvasLayer/Background/Exit/White.visible = true


func _on_Exit_mouse_exited():
	$CanvasLayer/Background/Exit/Pink.visible = true
	$CanvasLayer/Background/Exit/White.visible = false


# Quit the game.
func _on_Exit_pressed():
	get_tree().quit()
