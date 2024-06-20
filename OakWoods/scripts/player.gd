extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false

@onready var sprite_2d = $Sprite2D
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	var direction = Input.get_axis("run_left", "run_right")
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
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
	
	move_and_slide()
