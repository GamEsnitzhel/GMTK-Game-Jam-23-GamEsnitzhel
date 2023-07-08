extends Area2D

class_name PlayerChecker


enum PCTypes {
	NULL = -1,
	JUMP,
	SWITCH,
	SPEED,
	DIR,
	LEFT,
	RIGHT,
	
	MAX
}

var PCFunctions: Array[String] = [
	"",
	"jump",
	"switch",
	"speed",
	"reverse",
	"dir",
	"dir",
	
	""
]


@export_category("Auto-Create")
@export var type: PCTypes = PCTypes.NULL;
@export var data: Array = []

@export_category("Function")
@export var function: String = "Jump"
@export var args: Array = []
@export var force_sprite: bool = false

@export_category("CollisionPoints")
@export var pointA: Vector2 = Vector2.ZERO;
@export var pointB: Vector2 = Vector2(0, -50);

func _ready():
	$coll.shape.a = pointA;
	$coll.shape.b = pointB;
	if type != PCTypes.NULL:
		function = PCFunctions[type];
		$AnimatedSprite2D.frame = type;
		if !data.size():
			match type:
				PCTypes.LEFT:
					data = [-1]
				PCTypes.RIGHT:
					data = [1]
				_:
					pass
		args = data;
	else: $AnimatedSprite2D.visible = force_sprite;
	if function.length(): function[0] = function[0].to_upper()


func _on_body_entered(body):
	if !body is Player: return;
	if args.size(): Controller.callv("Player" + function, args);
	else: Controller.call("Player" + function);
