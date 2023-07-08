extends Area2D

@export var NextLevel: PackedScene = null;

func _ready():
	assert(NextLevel, "The Next Level is NULL")

func GoToNextLevel() -> void:
	Trans.ChangeSceneToPacked(NextLevel);

func overlap(body) -> void:
	if body is Player:
		GoToNextLevel();
