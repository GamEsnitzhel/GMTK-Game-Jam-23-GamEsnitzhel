extends Area2D


func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _on_body_entered(body):
	if body is Player or body is Enemy:
		if body.state == body.MovementStates.DEAD or body.state == body.MovementStates.MAX: return;
		Stats.CollectPurpleCoin();
		Audio.PurpleCoin();
		queue_free();
