extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const JUMP_ROTATION = -PI/2 - 1
const MAX_FALL_ROTATION = PI/2

var gravity_base = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = 0

var started = false

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

func _on_ready():
	animation_player.play("Idle")
	gravity = 0

func _physics_process(delta):
	if started:
		handle_gravity(delta)
		handle_flap()
		move_and_slide()

func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_flap():
	print(sprite_2d.rotation)
	
	if Input.is_action_just_pressed("Flap"):
		velocity.y = JUMP_VELOCITY
		sprite_2d.rotate(JUMP_ROTATION)
	else:
		if sprite_2d.rotation <= MAX_FALL_ROTATION:
			sprite_2d.rotate(0.05)

func _on_button_pressed():
	started = true
	animation_player.play("Flap")
	gravity = gravity_base
	$"../Button".hide()
