extends BaseControl;

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

var state: MovementStates = MovementStates.IDLE;


const speed: Vector2 = Vector2(500, 200);
const jumpSpeed: float = -250;


# Variables for referencing
@onready var sprite: AnimatedSprite2D = $sprite;

const animationFromStates: Array[String] = [
	"walk",
	"walk",
	"jump",
	"air",
	"jump",
	"die"
];


func _process(_delta) -> void:
	UpdateMoveState();
	UpdateAnimation();

func _physics_process(delta) -> void:
	# Schmovement Vars
	var input: Controller.ActorInput = Controller.GetInputPlayer();
	if state == MovementStates.DEAD:
		input.xInput = 0;
		input.isJumping = false;
	var targetVel: Vector2 = Vector2(input.xInput, velocity.y + speed.y);
	# Get the new velocity (and set it)
	targetVel.x *= speed.x
	velocity = lerp(velocity, targetVel, delta);
	# Do jumping
	if (input.isJumping && is_on_floor()): velocity.y = jumpSpeed;
	# Move
	move_and_slide();


func UpdateMoveState() -> void:
	match state:
		MovementStates.IDLE:
			if abs(velocity.x) >= 10:
				state = MovementStates.WALK;
			if (!is_on_floor()):
				state = MovementStates.JUMP;
		MovementStates.WALK:
			if abs(velocity.x) < 10:
				state = MovementStates.IDLE;
			if (!is_on_floor()):
				state = MovementStates.JUMP;
		MovementStates.JUMP:
			if sprite.animation_finished:
				state = MovementStates.AIR;
		MovementStates.AIR:
			if is_on_floor():
				state = MovementStates.LAND
		MovementStates.LAND:
			if sprite.animation_finished:
				state = MovementStates.WALK
		MovementStates.DEAD:
			if sprite.animation == "die":
				var sf: SpriteFrames = sprite.sprite_frames;
				var fc: int = sf.get_frame_count("die") - 1;
				if sprite.frame == fc:
					get_tree().reload_current_scene()
		_:
			pass;

func UpdateAnimation() -> void:
	sprite.flip_h = velocity.x < 0;
	match state:
		MovementStates.JUMP:
			sprite.play("jump")
		MovementStates.LAND:
			sprite.play_backwards("jump")
		MovementStates.IDLE:
			sprite.play_backwards("idle")
		MovementStates.WALK:
			if sprite.animation == "idle" || !sprite.is_playing():
				sprite.play("walk")
		_:
			if !sprite.is_playing():
				sprite.play(animationFromStates[state])


func BodyEntered(body):
	if !body is Enemy: return;
	if velocity.y > 10:
		body.die();
		sprite.play("jump")
		velocity.y = jumpSpeed;
	else: die()

func die():
	if state != MovementStates.DEAD:
		sprite.play("die");
		state = MovementStates.DEAD;
		velocity.y = 0;
