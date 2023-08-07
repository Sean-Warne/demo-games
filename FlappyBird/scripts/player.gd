extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_FALL_ROTATION = PI/2
const JUMP_ROTATION = -MAX_FALL_ROTATION + 1

var gravity_base = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = 0

var started = false
var dead = false

func _on_ready():
	animation_player.play("Idle")
	gravity = 0

func start():
	started = true
	dead = false
	
	animation_player.play("Flap")
	gravity = gravity_base

func stop():
	if not dead:
		dead = true
		animation_player.stop()

func _physics_process(delta):
	if started:
		if not dead:
			handle_flap()
		handle_gravity(delta)
		handle_rotation()
		move_and_slide()

func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_flap():
	if Input.is_action_just_pressed("Flap"):
		velocity.y = JUMP_VELOCITY

func handle_rotation():
	if velocity.y < 0:
		sprite_2d.rotate(-sprite_2d.rotation)
		sprite_2d.rotate(JUMP_ROTATION)
	else:
		if sprite_2d.rotation <= MAX_FALL_ROTATION:
			sprite_2d.rotate(0.05)
