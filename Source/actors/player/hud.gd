extends Control



@onready var playerplayer = $what/player/player
@onready var playerenemy = $what/player/enemy

@onready var enemydirection = $what/enemy/direction
@onready var enemydirectionleft = $what/enemy/direction/left
@onready var enemydirectionright = $what/enemy/direction/left2

@onready var enemyspeedone = $what/enemy/direction2/left
@onready var enemyspeedtwo = $what/enemy/direction2/left2
@onready var enemyspeedthree = $what/enemy/direction2/left3

func _process(_delta):
	playerplayer.visible = Controller.IsControlPlayer();
	playerenemy.visible = Controller.IsControlEnemy();

	enemydirectionleft.visible = Controller.stats.currentPlayerDir < 0;
	enemydirectionright.visible = Controller.stats.currentPlayerDir > 0;

	var speed: float = Controller.stats.currentPlayerSpeed;
	enemyspeedone.visible = speed < 0.33;
	enemyspeedtwo.visible = speed > 0.33 && speed < 0.66;
	enemyspeedthree.visible = speed > 0.66;

	
