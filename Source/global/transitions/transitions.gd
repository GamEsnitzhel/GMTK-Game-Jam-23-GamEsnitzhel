extends Control

@onready var anim: AnimationPlayer = $anim

var isTransitioning: bool = false;

func ChangeSceneToPacked(next: PackedScene) -> void:
	if isTransitioning: return
	anim.play("trans")
	await anim.animation_finished
	get_tree().change_scene_to_packed(next)
	anim.play_backwards("trans")
	await anim.animation_finished
	isTransitioning = false

func ChangeSceneToFile(next: String) -> void:
	if isTransitioning: return
	anim.play("trans")
	await anim.animation_finished
	get_tree().change_scene_to_file(next)
	anim.play_backwards("trans")
	await anim.animation_finished
	isTransitioning = false
