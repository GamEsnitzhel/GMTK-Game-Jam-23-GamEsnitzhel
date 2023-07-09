extends Control

@onready var anim: AnimationPlayer = $anim

var isTransitioning: bool = false;

func ChangeSceneToPacked(next: PackedScene) -> void:
	_change([next], "change_scene_to_packed")

func ChangeSceneToFile(next: String) -> void:
	_change([next], "change_scene_to_file")

func ReloadScene() -> void:
	_change([], "reload_current_scene")

func _change(next: Array, funcPtr: StringName):
	if isTransitioning: return;
	_localpause = 0.0;
	anim.play("trans");
	await anim.animation_finished;
	get_tree().callv(funcPtr, next);
	await get_tree().process_frame;
	Stats.SceneStarted();
	anim.play_backwards("trans");
	await anim.animation_finished;
	isTransitioning = false;
	_localpause = 1.0;



var time: float = 0.0;
var multiplier: float = 1.0;
var _localpause: float = 1.0;

func _process(delta) -> void:
	time += delta * multiplier * _localpause;

func ResetTime() -> void: time = 0.0;
func GetTime() -> float: return time;
func PauseTime() -> void: multiplier = 0.0;
func ResumeTime() -> void: multiplier = 1.0;

