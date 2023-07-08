extends BaseControl;

class_name Enemy;

var hasMouse: bool = false;

const speed: Vector2 = Vector2(500, 200);
const jumpSpeed: float = -250;

# Variables for referencing
@onready var sprite: AnimatedSprite2D = $sprite;

func _ready():
	sprite.play("default")

func _input(event: InputEvent):
	if !hasMouse: return;
	if !event is InputEventMouseButton: return;
	if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		Controller.SetEnemy(self);

func _physics_process(delta) -> void:
	# Schmovement Vars
	var input: Controller.ActorInput = Controller.GetInputEnemy(self);
	var targetVel: Vector2 = Vector2(input.xInput, velocity.y + speed.y);
	# Get the new velocity (and set it)
	targetVel.x *= speed.x
	velocity = lerp(velocity, targetVel, delta);
	# Do jumping
	if (input.isJumping && is_on_floor()): velocity.y = jumpSpeed;
	# Move
	move_and_slide();


func _on_mouse_entered(): hasMouse = true;
func _on_mouse_exited(): hasMouse = false;


