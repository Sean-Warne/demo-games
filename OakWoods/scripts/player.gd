extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

enum {
	RUN,
	JUMP,
	FALL
}

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var state = FALL

@onready var sprite_2d = $Sprite2D
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# movement
	move(delta)
	
	match state:
		RUN:
			run_state()
		JUMP:
			jump_state()
		FALL:
			fall_state()

func move(delta):
	# gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = Input.get_axis("run_left", "run_right")
	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			sprite_2d.flip_h = true
		else:
			sprite_2d.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("jump"):
		state = JUMP
	
	move_and_slide()

func run_state():
	if velocity.x:
		animation_state.travel("run")
	else:
		animation_state.travel("idle")

func jump_state():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	else:
		if velocity.y < 0:
			animation_state.travel("jump")
		else:
			state = FALL

func fall_state():
	if velocity.y > 0:
		animation_state.travel("fall")
	
	if is_on_floor():
		state = RUN
