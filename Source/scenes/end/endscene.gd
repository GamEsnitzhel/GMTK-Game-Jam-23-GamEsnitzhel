extends Control


func _ready() -> void:
	$Label2.text = Stats.GetStatsString();
