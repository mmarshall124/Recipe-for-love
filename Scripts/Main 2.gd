extends "res://Scripts/Level.gd"

onready var Player = $ViewportContainer/Viewport/Outside/YSort/Player

func _ready():
	Player.connect("interactedWith", self, "playDialogue")
	$AudioStreamPlayer.play()
	
	# Check to see if the player came in from another level, if so their spawn
	# point is different than the initial one.
	check_spawn_change(Player)
		
	# Setting camera limits so the player can't see off the screen.
	Player.camera.set_limit(MARGIN_BOTTOM, 736)
	Player.camera.set_limit(MARGIN_RIGHT, 960)
	Player.camera.set_limit(MARGIN_TOP, 0)
	Player.camera.set_limit(MARGIN_LEFT, 0)
	
	# Connecting the exit to the house level.
	$"ViewportContainer/Viewport/Outside/YSort/Exit".connect("sceneChange", self, "change_level")

