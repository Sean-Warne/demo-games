extends CharacterBody2D


const SPEED = 7000.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = null

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer


func _ready():
	sprite_2d.rotate(0.5)
	gravity = 0
	animation_player.play("Idle")


func _physics_process(delta):
	if gravity == 0 and Input.is_action_just_pressed("jump"):
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	
	print(animation_player.current_animation)
	
	handle_gravity(delta)
	handle_jump()
	handle_movement(delta)
	handle_animation()
	move_and_slide()


func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta


func handle_jump():
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		sprite_2d.rotate(-0.5)
	
	if Input.is_action_just_released("jump"):
		sprite_2d.rotate(0.5)
	
	if Input.is_action_just_released("jump") and velocity.y < JUMP_VELOCITY / 2:
		velocity.y = JUMP_VELOCITY / 2


func handle_movement(delta):
	velocity.x = SPEED * delta


func handle_animation():
	if gravity != 0:
		if velocity.y < 0:
			animation_player.play("Up")
		else:
			animation_player.play("Down")
