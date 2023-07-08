extends Node2D

class_name Level

var playerStats: Controller.PlayerStats = Controller.PlayerStats.new()

@export_category("Player Stats")
@export var playerDirection: float = 1;
@export var playerSpeed: float = 0.6;
@export var whoControls: Controller.PlayerStats.WhoControls = Controller.PlayerStats.WhoControls.PLAYER

func _ready() -> void:
	playerStats.currentPlayerDir = playerDirection;
	playerStats.currentPlayerSpeed = playerSpeed;
	Controller.stats = playerStats;
