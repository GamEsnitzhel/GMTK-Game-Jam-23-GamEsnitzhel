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
var currentPlayer: Player = null;


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
func SetPlayer(new: Player) -> void:
	_currentControl = _ControlEnum.PLAYER;
	currentPlayer = new;

func GetInputPlayer() -> ActorInput:
	var input: ActorInput = ActorInput.new();
	# If it's the player's control, then get their input
	if IsControlPlayer(): return GetInput();
	# If it's enemy control then just go right
	elif IsControlEnemy():
		input.xInput = 0.2;
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
