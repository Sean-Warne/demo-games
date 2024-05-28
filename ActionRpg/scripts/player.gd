extends CharacterBody2D

const MAX_SPEED = 80.0
const ACCELERATION = 500
const FRICTION = 700

@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	motion_mode = MOTION_MODE_FLOATING

func get_input(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction:
		animation_tree.set("parameters/Idle/blend_position", direction)
		animation_tree.set("parameters/Run/blend_position", direction)
		animation_state.travel("Run")
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

func _physics_process(delta):
	get_input(delta)
	move_and_slide()
