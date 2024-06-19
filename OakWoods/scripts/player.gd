extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false

@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_axis("run_left", "run_right")
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("jump")
	elif direction:
		velocity.x = direction * SPEED

		if is_on_floor():
			animated_sprite_2d.play("run")

		if direction < 0:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		# only play idle animation if not moving and run animation is playing (looping)
		if animated_sprite_2d.animation == "run":
			animated_sprite_2d.play("idle")

	move_and_slide()
