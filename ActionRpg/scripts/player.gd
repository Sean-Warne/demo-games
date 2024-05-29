extends CharacterBody2D

const ACCELERATION = 500.0
const FRICTION = 700.0

@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

var speed = 80.0

func _ready():
	motion_mode = MOTION_MODE_FLOATING

func get_input(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if Input.is_action_pressed("sprint"):
		speed = 120.0
	else:
		speed = 80.0
	
	if direction:
		animation_tree.set("parameters/Idle/blend_position", direction)
		animation_tree.set("parameters/Run/blend_position", direction)
		animation_state.travel("Run")
		velocity = velocity.move_toward(direction * speed, ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

func _physics_process(delta):
	get_input(delta)
	move_and_slide()
