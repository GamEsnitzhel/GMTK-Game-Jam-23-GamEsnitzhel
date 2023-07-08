extends Camera2D



func _process(_delta) -> void:
	var z: float = 0.75 - (1 - Engine.time_scale) / 3
	zoom = Vector2(z, z)
