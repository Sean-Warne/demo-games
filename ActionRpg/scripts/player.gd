extends CharacterBody2D

const SPEED = 140.0

func get_input(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	
	velocity.normalized()

func _physics_process(delta):
	get_input(delta)
	move_and_slide()
