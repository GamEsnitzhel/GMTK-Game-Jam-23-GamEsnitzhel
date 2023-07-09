extends Area2D


func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _on_body_entered(body):
	if body is Player or body is Enemy:
		Stats.CollectPurpleCoin();
		Audio.PurpleCoin();
		queue_free();
