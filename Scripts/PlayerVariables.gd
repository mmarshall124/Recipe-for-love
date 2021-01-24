extends Node

# This script is a singleton to allow for easy data transfer across scenes.

# Win conditions! If true then you've collected that item or done that task.
var winCons = [false,false,false,false,false,false]


# These are used to handle proper transitions from level to level.
var sceneChanged = false
var spawnPoint = Vector2.ZERO

var currentLocation = "house"


# This function connects to each win con item. Once it's triggered it will set
# the corresponding winCon to true. Once all six are true, the bed can be used to win.
func getItem(ItemName):
	match ItemName:
		"strawberry":
			winCons[0] = true
		"waffle_mix":
			winCons[1] = true
		"egg":
			winCons[2] = true
		"orange":
			winCons[3] = true
		"bacon":
			winCons[4] = true
		"used_stove":
			winCons[5] = true
			
func checkItem(ItemName):
	match ItemName:
		"strawberry":
			return winCons[0]
		"waffle_mix":
			return winCons[1]
		"egg":
			return winCons[2]
		"orange":
			return winCons[3]
		"bacon":
			return winCons[4]
		"used_stove":
			return winCons[5]
