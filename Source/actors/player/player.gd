extends CharacterBody2D;

class_name Player;


enum MovementStates {
	IDLE,
	WALK,
	JUMP,
	AIR,
	LAND,
	DEAD,
	
	MAX
}



# Variables for referencing
@onready var sprite: AnimatedSprite2D = $sprite;

const animationFromStates: Array[String] = [
	"idle",
	"walk",
	"jump",
	"air",
	"jump",
	"die"
];



func _physics_process(delta) -> void:
	var input: Controller.ActorInput = Controller.GetInputPlayer()
