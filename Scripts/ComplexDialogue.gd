extends Node2D

# This is an array to store dictionaries describing a single text box of dialogue
# Each dictionary should have key:value pairs for text (the text to be displayed)
# and speaker (who's saying it)
var complexTextArray = []
export var path = "res://Dialogue/test.json"

# Once the object is loaded in, open the relevant json file and parse it to
# complexTextArray. That array will then be loaded by the UI when needed.
func _ready():
	var file = File.new()
	var error = file.open(path, File.READ)
	if error:
		print(error)
	var jsonFile = file.get_as_text()
	complexTextArray = JSON.parse(jsonFile).result

