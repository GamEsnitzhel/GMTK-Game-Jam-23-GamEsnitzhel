extends Area2D


@export var path: String = ""

var over: bool = false

func _ready() -> void:
	assert(!path.is_empty(), "Next scene's path is empty.")

func _on_body_entered(body):
	if over: return
	if body is Player:
		over = true
		await Audio.PlayerWin()
		Trans.ChangeSceneToFile(path)
		Stats.LevelComplete()
