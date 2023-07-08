extends Node;

class ActorInput extends RefCounted:
	var xInput: float = 0.0;
	var isJumping: bool = false;

enum _ControlEnum {
	NULLPTR,
	PLAYER,
	ENEMY,
	
	MAX
}


var currentEnemy: Enemy = null;

var _playerJump: bool = false;
var _currentPlayerDir: float = 1;
var _currentPlayerSpeed: float = 0.2;


var _currentControl: _ControlEnum = _ControlEnum.PLAYER;

func IsControlValid() -> bool: return _currentControl != _ControlEnum.NULLPTR;
func IsControlPlayer() -> bool: return _currentControl == _ControlEnum.PLAYER;
func IsControlEnemy() -> bool: return _currentControl == _ControlEnum.ENEMY;

func SetControlInvalid() -> void: _currentControl = _ControlEnum.NULLPTR;
func SetControlPlayer() -> void: _currentControl = _ControlEnum.PLAYER;
func SetControlEnemy() -> void: _currentControl = _ControlEnum.ENEMY;

func SetEnemy(new: Enemy) -> void:
	_currentControl = _ControlEnum.ENEMY;
	currentEnemy = new;

func GetInputPlayer() -> ActorInput:
	var input: ActorInput = ActorInput.new();
	# If it's the player's control, then get their input
	if IsControlPlayer(): input = GetInput();
	# If it's enemy control then just go right
	elif IsControlEnemy():
		input.xInput = _currentPlayerSpeed * _currentPlayerDir;
	# *always*
	if !input.isJumping:
		input.isJumping = _playerJump;
	_playerJump = false;
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
	_currentPlayerDir = new;

func PlayerReverse() -> void:
	_currentPlayerDir *= -1;

func PlayerJump() -> void:
	_playerJump = true;

func PlayerSpeed(new: float) -> void:
	_currentPlayerSpeed = new;
