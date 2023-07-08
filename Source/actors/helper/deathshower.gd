@tool

extends Node2D

@onready var plane: ColorRect = $ColorRect

func _ready():
	plane.global_position.y = 270 + plane.size.y
	plane.global_position.x = -(plane.size.x / 2)
	
