@tool
extends Control


var deadline: int = 1688922000

func _process(delta):
	var time: int = deadline - Time.get_unix_time_from_system()
	var days: int = floor(time / (3600 * 24))
	var timeStr: String = Time.get_time_string_from_unix_time(time)

	self.text = "Time Remaining: %2d:%s" % [days, timeStr]
