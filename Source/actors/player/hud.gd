extends Control


@onready var circleplaya := $what/player/background
@onready var circleenemy := $what/enemy/direction/background
@onready var circlenemy2 := $what/enemy/direction2/background

@onready var playerplayer = $what/player/player
@onready var playerenemy = $what/player/enemy

@onready var enemydirection = $what/enemy/direction
@onready var enemydirectionleft = $what/enemy/direction/left
@onready var enemydirectionright = $what/enemy/direction/left2

@onready var enemyspeedone = $what/enemy/direction2/left
@onready var enemyspeedtwo = $what/enemy/direction2/left2
@onready var enemyspeedthree = $what/enemy/direction2/left3


func _ready() -> void:
	circleplaya.texture.current_frame = 0;
	circleenemy.texture.current_frame = 1;
	circlenemy2.texture.current_frame = 2;

func _process(delta):
	playerplayer.visible = Controller.IsControlPlayer();
	playerenemy.visible = Controller.IsControlEnemy();

	enemydirectionleft.visible = Controller.stats.currentPlayerDir < 0;
	enemydirectionright.visible = Controller.stats.currentPlayerDir > 0;

	var speed: float = Controller.stats.currentPlayerSpeed;
	enemyspeedone.visible = speed < 0.33;
	enemyspeedtwo.visible = speed > 0.33 && speed < 0.66;
	enemyspeedthree.visible = speed > 0.66;

	
	if Controller.IsControlPlayer():
		$what/enemy.scale = lerp($what/enemy.scale, Vector2(0.75, 0.75), delta * 10)
		$what/enemy.modulate = lerp($what/enemy.modulate, Color(0.75, 0.75, 0.75, 0.75), delta * 10)
	else:
		$what/enemy.scale = lerp($what/enemy.scale, Vector2.ONE, delta * 10)
		$what/enemy.modulate = lerp($what/enemy.modulate, Color.WHITE, delta * 10)
