extends Popup

# This class was never fully implemented due to time constraints. Code is left as
# a scaffold to build on if the project is later continued.


var saveFile = "user://Player.save"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	save_game()
	print("Game Saved!")

func save_game():
	var file = File.new()
	file.open(saveFile, File.WRITE)
	file.store_var(PlayerVariables.winCons)
	file.store_var(PlayerVariables.currentLocation)
	file.close()
	
func load_game():
	var file = File.new()
	if file.file_exists(saveFile):
		file.open(saveFile, File.READ)
		PlayerVariables.winCons = file.get_var()
		file.close()


func _on_Button2_pressed():
	pass # Replace with function body.
