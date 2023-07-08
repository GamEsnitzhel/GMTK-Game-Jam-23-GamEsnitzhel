extends Node2D

@onready var theme_intro = $tb2
@onready var theme_body = $tb

@onready var sound_win = $winnshiz/AudioStreamPlayer

func _ready():
	theme_intro.play()

func introfinished():
	theme_body.play()

func PlayerWin() -> void:
	theme_intro.stream_paused = true
	theme_body.stream_paused = true
	sound_win.play();
	await sound_win.finished
	theme_intro.stream_paused = false
	theme_body.stream_paused = false
	
