extends Area2D

signal sceneChange(path)
export var newScenePath = ""

export var spawnPoint = Vector2.ZERO



func _on_Exit_body_entered(_body):
	emit_signal("sceneChange", newScenePath, spawnPoint)
