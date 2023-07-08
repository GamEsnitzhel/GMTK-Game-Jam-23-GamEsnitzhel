extends Node;

class ActorInput extends RefCounted:
	var xInput: float = 0.0;
	var isJumping: bool = false;


class PlayerStats extends RefCounted:
	enum Direction {
		LEFT = -1,
		NULL,
		RIGHT = 1
	}
	enum WhoControls {
		NULLPTR,
		PLAYER,
		ENEMY,
	
		MAX
	}
	var playerJump: bool = false;
	var currentPlayerDir: float = 1;
	var currentPlayerSpeed: float = 0.6;
	var currentControl = WhoControls.PLAYER;




var currentEnemy: Enemy = null;

var stats: PlayerStats = PlayerStats.new()


func IsControlValid() -> bool: return stats.currentControl != stats.WhoControls.NULLPTR;
func IsControlPlayer() -> bool: return stats.currentControl == stats.WhoControls.PLAYER;
func IsControlEnemy() -> bool: return stats.currentControl == stats.WhoControls.ENEMY;

func SetControlInvalid() -> void: stats.currentControl = stats.WhoControls.NULLPTR;
func SetControlPlayer() -> void: stats.currentControl = stats.WhoControls.PLAYER;
func SetControlEnemy() -> void: stats.currentControl = stats.WhoControls.ENEMY;


func IsCurrentEnemy(test: Enemy) -> bool:
	return IsControlEnemy() && currentEnemy == test;

func SetEnemy(new: Enemy) -> void:
	currentEnemy = new;


func GetInputPlayer() -> ActorInput:
	var input: ActorInput = ActorInput.new();
	# If it's the player's control, then get their input
	if IsControlPlayer(): input = GetInput();
	# If it's enemy control then just go right
	elif IsControlEnemy():
		input.xInput = stats.currentPlayerSpeed * stats.currentPlayerDir;
	# *always*
	if !input.isJumping:
		input.isJumping = stats.playerJump;
	stats.playerJump = false;
	# Return the generated input
	return input;

func GetInputEnemy(enemyPtr: Enemy) -> ActorInput:
	assert(enemyPtr, "enemyPtr passed into GetInputEnemy is null");
	# If it's the player's control, then get their input
	if IsControlEnemy() && currentEnemy == enemyPtr: return GetInput();
	# Return the generated input
	return ActorInput.new();


func GetInput() -> ActorInput:
	var input: ActorInput = ActorInput.new();
	input.xInput = Input.get_axis("ui_left", "ui_right");
	input.isJumping = Input.is_action_pressed("ui_up");
	return input;


func EnemyDied(enemy: Enemy) -> void:
	if enemy == currentEnemy: currentEnemy = null;










func PlayerSwitch(new = null) -> void:
	if new != null:
		stats.currentControl = new;
	else:
		if stats.currentControl == stats.WhoControls.PLAYER: stats.currentControl = stats.WhoControls.ENEMY;
		elif stats.currentControl == stats.WhoControls.ENEMY: stats.currentControl = stats.WhoControls.PLAYER;
	currentEnemy = null;

func PlayerDir(new: float) -> void:
	stats.currentPlayerDir = new;

func PlayerReverse() -> void:
	stats.currentPlayerDir *= -1;

func PlayerJump() -> void:
	stats.playerJump = true;

func PlayerSpeed(new: float) -> void:
	stats.currentPlayerSpeed = new;
