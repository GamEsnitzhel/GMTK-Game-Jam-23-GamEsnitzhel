extends Control


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

@onready var toMenu: button = button.create($TextureRect, switchToMenu);


func _ready() -> void:
	$Label2.text = Stats.GetStatsString();
	Audio.YouWinYay();

func _input(event):
	if !event is InputEventMouseButton: return;
	if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		toMenu.MousePressed();

func _process(_delta) -> void:
	toMenu.Update();

func switchToMenu() -> void:
	Audio.BackToMenu();
	Trans.ChangeSceneToFile("res://scenes/menu/menu.tscn")

