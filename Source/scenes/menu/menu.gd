extends Control


func _ready() -> void:
	$AnimationPlayer.play("new_animation")

func play():
	Trans.ChangeSceneToFile("res://scenes/tutorial/tutorial.tscn");
	Trans.ResetTime();
	Trans.ResumeTime();


func _on_play_mouse_entered():
	print("WOO")
