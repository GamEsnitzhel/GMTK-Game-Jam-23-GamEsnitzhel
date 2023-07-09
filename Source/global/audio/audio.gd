extends Node2D

@onready var theme_intro: AudioStreamPlayer = $tb2
@onready var theme_body: AudioStreamPlayer = $tb

var toggleAudio = 0;

@onready var sound_win: AudioStreamPlayer = $winnshiz/AudioStreamPlayer
@onready var sound_coin: AudioStreamPlayer = $winnshiz/AudioStreamPlayer2
@onready var sound_switch: AudioStreamPlayer = $winnshiz/AudioStreamPlayer3

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

func ToggleMusic() -> void:
	var db = [0, -80];
	toggleAudio += 1;
	toggleAudio %= 2;
	theme_intro.volume_db = db[toggleAudio]
	theme_body.volume_db = db[toggleAudio]

func PurpleCoin() -> void:
	sound_coin.play();

func Switch() -> void:
	sound_switch.play();
