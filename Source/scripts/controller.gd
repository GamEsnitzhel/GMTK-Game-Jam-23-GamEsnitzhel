extends Node;

class ActorInput extends RefCounted:
	var xInput: float = 0.0;
	var isJumping: bool = false;


class PlayerStats extends RefCounted:
	var playerJump: bool = false;
	var currentPlayerDir: float = 1;
	var currentPlayerSpeed: float = 0.5;

enum _ControlEnum {
	NULLPTR,
	PLAYER,
	ENEMY,
	
	MAX
}


var currentEnemy: Enemy = null;

var stats: PlayerStats = PlayerStats.new()


var _currentControl: _ControlEnum = _ControlEnum.PLAYER;

func IsControlValid() -> bool: return _currentControl != _ControlEnum.NULLPTR;
func IsControlPlayer() -> bool: return _currentControl == _ControlEnum.PLAYER;
func IsControlEnemy() -> bool: return _currentControl == _ControlEnum.ENEMY;

func SetControlInvalid() -> void: _currentControl = _ControlEnum.NULLPTR;
func SetControlPlayer() -> void: _currentControl = _ControlEnum.PLAYER;
func SetControlEnemy() -> void: _currentControl = _ControlEnum.ENEMY;


func IsCurrentEnemy(test: Enemy) -> bool:
	return IsControlEnemy() && currentEnemy == test;

func SetEnemy(new: Enemy) -> void:
	_currentControl = _ControlEnum.ENEMY;
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
		_currentControl = new;
	else:
		if _currentControl == _ControlEnum.PLAYER: _currentControl = _ControlEnum.ENEMY;
		elif _currentControl == _ControlEnum.ENEMY: _currentControl = _ControlEnum.PLAYER;

func PlayerDir(new: float) -> void:
	stats.currentPlayerDir = new;

func PlayerReverse() -> void:
	stats.currentPlayerDir *= -1;

func PlayerJump() -> void:
	stats.playerJump = true;

func PlayerSpeed(new: float) -> void:
	stats.currentPlayerSpeed = new;
