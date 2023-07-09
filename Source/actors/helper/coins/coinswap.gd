extends Area2D


func _on_body_entered(body):
	#$playerchecker._on_body_entered(body)
	Controller.PlayerSwitch()
	if body is Player:
		Stats.CollectPurpleCoin();
		queue_free()
