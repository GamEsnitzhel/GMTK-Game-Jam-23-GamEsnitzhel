extends Area2D


@export var path: String = ""

var over: bool = false

func _ready() -> void:
	assert(!path.is_empty(), "Next scene's path is empty.")

func _on_body_entered(body):
	if over: return
	if body is Player:
		if body.state == body.MovementStates.DEAD or body.state == body.MovementStates.MAX: return;
		body.canDie = false;
		over = true
		await Audio.PlayerWin()
		Trans.ChangeSceneToFile(path)
		Stats.LevelComplete()
