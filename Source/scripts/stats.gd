extends Node


var deaths: int = 0;
var enemies_killed: int = 0;
var purple_coins_collected: int = 0;
var purple_coins_saved: int = 0;
var time: float = 0.0;

var _coins_in_limbo: int = 0;

func ResetStats() -> void:
	deaths = 0;
	enemies_killed = 0;
	purple_coins_collected = 0;
	purple_coins_saved = 0;
	time = 0.0;
	_coins_in_limbo = 0;
	Trans.time = 0.0;

func CollectPurpleCoin() -> void:
	_coins_in_limbo += 1;

func PlayerDied() -> void:
	deaths += 1;
	purple_coins_collected += _coins_in_limbo;
	_coins_in_limbo = 0;
	print(GetStatsString())

func LevelComplete() -> void:
	purple_coins_saved += _coins_in_limbo;
	_coins_in_limbo = 0;
	print(GetStatsString())

func EnemyKilled() -> void:
	enemies_killed += 1;


func GetStatsString() -> String:
	var toReturn: String = ""
	
	time = Trans.time;
	
	toReturn += "Time Taken: " + Time.get_time_string_from_unix_time(int(Trans.time)) +\
		".%02d" % [int(fmod(time, 1) * 100)];
	
	toReturn += "\nPlayer Deaths: " + str(deaths);
	toReturn += "\nEnemies Killed: " + str(enemies_killed);
	toReturn += "\nPurple Coins Lost: " + str(purple_coins_collected);
	toReturn += "\nPurple Coins Captured: " + str(purple_coins_saved);

	return toReturn
