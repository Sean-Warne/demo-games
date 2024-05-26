extends CharacterBody2D

const MAX_SPEED = 80.0
const ACCELERATION = 500
const FRICTION = 700

func _ready():
	motion_mode = MOTION_MODE_FLOATING

func get_input(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	print(direction)
	
	if direction:
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

func _physics_process(delta):
	get_input(delta)
	move_and_slide()
