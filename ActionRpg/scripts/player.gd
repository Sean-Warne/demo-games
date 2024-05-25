extends CharacterBody2D

const MAX_SPEED = 100.0
const ACCELERATION = 700
const FRICTION = 1000

func get_input(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction:
		velocity += direction * ACCELERATION * delta
		velocity = velocity.limit_length(MAX_SPEED)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

func _physics_process(delta):
	get_input(delta)
	move_and_slide()
