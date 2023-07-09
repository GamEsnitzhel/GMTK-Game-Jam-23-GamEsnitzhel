extends Control


func _ready() -> void:
	$AnimationPlayer.play("new_animation")
	closeSettings();




func startgame():
	Trans.ChangeSceneToFile("res://scenes/tutorial/tutorial.tscn");
	Trans.ResetTime();
	Trans.ResumeTime();


class button extends RefCounted:
	var tex: TextureRect;
	var function: Callable;
	var disabled: bool = false;
	
	var _hovered: bool = false;
	
	func Hide() -> void: tex.hide();
	func Show() -> void: tex.show();
	
	func DisHide() -> void:
		Hide();
		disabled = true;
	
	func EnaShow() -> void:
		Show();
		disabled = false;
	
	static func create(texture: TextureRect, fc: Callable) -> button:
		var toReturn: button = button.new()
		toReturn.tex = texture;
		toReturn.function = fc;
		return toReturn;
	
	func MousePressed() -> void:
		if _hovered:
			function.call();
			tex.texture.current_frame = 1;
	
	func Update() -> void:
		if disabled:
			_hovered = false;
			tex.texture.current_frame = 0;
			return;
		if _check(tex.get_global_mouse_position(), tex):
			if !_hovered:
				_hovered = true;
				tex.texture.current_frame = 2;
		else:
			if _hovered:
				_hovered = false;
				tex.texture.current_frame = 0;
	
	func _check(pos: Vector2, button: TextureRect) -> bool:
		if pos.x < button.global_position.x: return false;
		if pos.x > button.global_position.x + button.size.x: return false;
		if pos.y < button.global_position.y: return false;
		if pos.y > button.global_position.y + button.size.y: return false;
		return true;

func _input(event):
	if !event is InputEventMouseButton: return;
	if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		for b in menuButtons: b.MousePressed();
		for b in settingsButtons: b.MousePressed();


# Base menu buttons
@onready var playButton: button = button.create($TextureRect, startgame)
@onready var settingsButtn: button = button.create($TextureRect2, settings)

@onready var setting_toggleMusic: button = button.create($togglemusic, toggleMusic)
@onready var setting_closeSettings: button = button.create($back, closeSettings)


@onready var menuButtons: Array[button] = [playButton, settingsButtn]
@onready var settingsButtons: Array[button] = [setting_toggleMusic, setting_closeSettings]

func _process(_delta):
	for b in menuButtons: b.Update();
	for b in settingsButtons: b.Update();

func settings() -> void:
	for b in menuButtons: b.DisHide();
	for b in settingsButtons: b.EnaShow();

func closeSettings() -> void:
	for b in menuButtons: b.EnaShow();
	for b in settingsButtons: b.DisHide();

func toggleMusic() -> void:
	Audio.ToggleMusic()
