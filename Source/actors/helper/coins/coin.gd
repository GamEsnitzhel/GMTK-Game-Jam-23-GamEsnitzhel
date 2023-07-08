extends Area2D


func _on_body_entered(body):
	#$playerchecker._on_body_entered(body)
	Controller.PlayerSlowdown(0.5, 3)
	if body is Player: queue_free()
