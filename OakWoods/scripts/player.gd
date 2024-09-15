extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

enum {
	MOVE,
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
	# gravity/fall
	if not is_on_floor():
		velocity.y += gravity * delta
	
	match state:
		# mayhaps move move code into _physics process then
		# use only jump and fall states
		MOVE:
			move_state()
		JUMP:
			jump_state(delta)
		FALL:
			fall_state(delta)

func move_state():
	var direction = Input.get_axis("run_left", "run_right")
	
	if direction:
		velocity.x = direction * SPEED
		
		if direction < 0:
			sprite_2d.flip_h = true
		else:
			sprite_2d.flip_h = false
		
		animation_state.travel("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation_state.travel("idle")
	
	if Input.is_action_just_pressed("jump"):
		state = JUMP
	
	move_and_slide()

func jump_dir():
	var direction = Input.get_axis("run_left", "run_right")
	
	if direction:
		if direction < 0:
			sprite_2d.flip_h = true
		else:
			sprite_2d.flip_h = false

func jump_state(delta):
	jump_dir()
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	else:
		if velocity.y < 0:
			animation_state.travel("jump")
		else:
			state = FALL
		
	move_and_slide()

func fall_state(delta):
	jump_dir()
	if velocity.y > 0:
		animation_state.travel("fall")
	move_and_slide()

func fall_finished():
	state = MOVE
