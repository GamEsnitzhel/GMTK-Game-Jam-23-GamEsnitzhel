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

var lastVelocity: Vector2 = Vector2.ZERO


const mult: float = 1.1;
const speed: Vector2 = Vector2(400 * mult, 300 * mult);
const jumpSpeed: float = -400 * mult;

var hasLetGo: bool = true

# Variables for referencing
@onready var sprite: AnimatedSprite2D = $sprite;
@onready var active: AnimatedSprite2D = $active;

@onready var audio_jump: AudioStreamPlayer2D = $jump;
@onready var audio_walk: AudioStreamPlayer2D = $walk;
@onready var audio_die:  AudioStreamPlayer2D = $ded;
@onready var audio_hit:  AudioStreamPlayer2D = $kil;

const animationFromStates: Array[String] = [
	"walk",
	"walk",
	"jump",
	"air",
	"jump",
	"die",
	"na"
];


func _process(_delta) -> void:
	UpdateMoveState();
	UpdateAnimation();
	UpdateWalkAudio();
	if global_position.y >= 270: die();

func _input(_event):
	if Input.is_action_just_pressed("reset"): die();


func _physics_process(delta) -> void:
	# Get last vel
	lastVelocity = velocity;
	# Schmovement Vars
	var input: Controller.ActorInput = Controller.GetInputPlayer();
	if state == MovementStates.DEAD:
		input.xInput = 0;
		input.isJumping = false;
	var targetVel: Vector2 = Vector2(input.xInput, velocity.y + speed.y);
	if velocity.y < 0 && hasLetGo && Controller.IsControlPlayer():
		velocity.y += speed.y * 0.5 * delta;
	# Get the new velocity (and set it)
	targetVel.x *= speed.x
	velocity = lerp(velocity, targetVel, delta);
	# Do jumping
	if (input.isJumping && is_on_floor()):
		velocity.y = jumpSpeed * clamp((abs(velocity.x) * 1.5 + 50) / speed.x, 0.75, 1);
		audio_jump.play();
		hasLetGo = false;
	if Input.is_action_just_released("ui_up") && Controller.IsControlPlayer() && velocity.y < 0 && not hasLetGo:
		velocity.y *= 0.75;
		hasLetGo = true;
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
				if (velocity.y <= 0):
					state = MovementStates.JUMP;
				else:
					state = MovementStates.AIR;
					sprite.stop()
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
					Trans.ReloadScene()
					state = MovementStates.MAX
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
	active.visible = Controller.IsControlPlayer();
	if !active.is_playing(): active.play("default")


func BodyEntered(body):
	if body is Enemy:
		if lastVelocity.y > 1:
			body.die();
			sprite.play("jump")
			velocity.y = jumpSpeed;
			audio_hit.play()
		else: die()
	elif body is Spike:
		die();

func die():
	if state != MovementStates.DEAD and state != MovementStates.MAX:
		audio_die.play()
		sprite.play("die");
		state = MovementStates.DEAD;
		velocity.y = 0;

func UpdateWalkAudio() -> void:
	if sprite.animation != "walk": return;
	if sprite.frame in [1, 5]: audio_walk.play()
