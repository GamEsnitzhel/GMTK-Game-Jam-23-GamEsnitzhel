extends Node2D


func _ready():
	Trans.ChangeSceneToFile("res://scenes/tutorial/tutorial.tscn");
	Trans.ResetTime();
	Trans.ResumeTime();
