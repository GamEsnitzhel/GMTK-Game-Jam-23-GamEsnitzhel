extends Area2D


func _on_body_entered(body):
	#$playerchecker._on_body_entered(body)
	Controller.PlayerSwitch()
	if body is Player:
		if body.state == body.MovementStates.DEAD or body.state == body.MovementStates.MAX: return;
		queue_free()
