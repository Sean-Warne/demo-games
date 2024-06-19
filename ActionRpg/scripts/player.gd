extends CharacterBody2D

const ACCELERATION = 500.0
const FRICTION = 600.0

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

var player_collide = false

enum {
	MOVE,
	ROLL,
	ATTACK
}

var speed = 80.0
var state = MOVE

func _ready():
	motion_mode = MOTION_MODE_FLOATING
	animation_tree.active = true

func move_state(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	print(player_collide)

	if direction:
		animation_tree.set("parameters/Idle/blend_position", direction)
		animation_tree.set("parameters/Run/blend_position", direction)
		animation_tree.set("parameters/Attack/blend_position", direction)
		animation_tree.set("parameters/Roll/blend_position", direction)
		animation_state.travel("Run")
		velocity = velocity.move_toward(direction * speed, ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	if Input.is_action_pressed("sprint"):
		speed = 120.0
	else:
		speed = 80.0

	# changing states
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

	if Input.is_action_just_pressed("roll") and direction != Vector2.ZERO:
		state = ROLL

	player_collide = move_and_slide()

func roll_state():
	animation_state.travel("Roll")
	velocity = velocity 
	move_and_slide()

func attack_state(delta):
	animation_state.travel("Attack")
	velocity = velocity.move_toward(Vector2.ZERO, 300 * delta)
	move_and_slide()

func attack_finished():
	state = MOVE

func roll_finished():
	state = MOVE

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state()
		ATTACK:
			attack_state(delta)
	
