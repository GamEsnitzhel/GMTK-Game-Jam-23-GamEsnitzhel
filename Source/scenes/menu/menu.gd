extends Control


func _ready() -> void:
	$AnimationPlayer.play("new_animation")




func startgame():
	Trans.ChangeSceneToFile("res://scenes/tutorial/tutorial.tscn");
	Trans.ResetTime();
	Trans.ResumeTime();

func settings() -> void:
	pass

func _on_play_mouse_entered():
	print("WOO")


class button extends RefCounted:
	var tex: TextureRect;
	var function: Callable;
	var _hovered: bool = false
	
	static func create(texture: TextureRect, fc: Callable) -> button:
		var toReturn: button = button.new()
		toReturn.tex = texture;
		toReturn.function = fc;
		return toReturn;
	
	func MousePressed() -> void:
		if _hovered:
			function.call();
			tex.texture.current_frame = 1;
	
	func Update(mPos: Vector2) -> void:
		if _check(mPos, tex):
			if !_hovered:
				_hovered = true;
				tex.texture.current_frame = 2;
		else:
			if _hovered:
				_hovered = false;
				tex.texture.current_frame = 0;
	
	func _check(pos: Vector2, button: TextureRect) -> bool:
		if pos.x < button.position.x: return false;
		if pos.x > button.position.x + button.size.x: return false;
		if pos.y < button.position.y: return false;
		if pos.y > button.position.y + button.size.y: return false;
		return true;

func _input(event):
	if !event is InputEventMouseButton: return;
	if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		playButton.MousePressed();
		settingsButtn.MousePressed();


@onready var playButton: button = button.create($TextureRect, startgame)
@onready var settingsButtn: button = button.create($TextureRect2, settings)


func _process(_delta):
	var mousePos = get_global_mouse_position();
	playButton.Update(mousePos)
	settingsButtn.Update(mousePos)
