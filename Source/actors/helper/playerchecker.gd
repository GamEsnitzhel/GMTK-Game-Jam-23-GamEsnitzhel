extends Area2D

@export_category("Function")
@export var function: String = "Jump"
@export var args: Array = []

@export_category("CollisionPoints")
@export var pointA: Vector2 = Vector2.ZERO;
@export var pointB: Vector2 = Vector2(0, -10);

func _ready():
	$coll.shape.a = pointA;
	$coll.shape.b = pointB;
	function[0] = function[0].to_upper()


func _on_body_entered(body):
	if !body is Player: return;
	if args.size(): Controller.callv("Player" + function, args);
	else: Controller.call("Player" + function);
