extends Object;

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


var _currentControl: _ControlEnum = _ControlEnum.NULLPTR;

func IsControlValid() -> bool: return _currentControl != _ControlEnum.NULLPTR;
func IsControlPlayer() -> bool: return _currentControl == _ControlEnum.PLAYER;
func IsControlEnemy() -> bool: return _currentControl == _ControlEnum.ENEMY;

func SetControlInvalid() -> void: _currentControl = _ControlEnum.NULLPTR;
func SetControlPlayer() -> void: _currentControl = _ControlEnum.PLAYER;
func SetControlEnemy() -> void: _currentControl = _ControlEnum.ENEMY;

func GetInputPlayer() -> ActorInput:
	var input: ActorInput = ActorInput.new();
	# If it's the player's control, then get their input
	if IsControlPlayer():
		input.xInput = Input.get_axis("ui_left", "ui_right");
		input.isJumping = Input.is_action_pressed("ui_up");
	# If it's enemy control then just go right
	elif IsControlEnemy():
		input.xInput = 1.0;
	# Return the generated input
	return input;
