extends StaticBody2D

signal collide

const SPEED = -170

@onready var sprite_2d = $Sprite2D
@onready var sprite_2d_2 = $Sprite2D2

var started = true

func _process(delta):
	if started:
		if position.x <= -500:
			position.x = 0
		else:
			position.x += SPEED * delta

func start():
	started = true

func stop():
	started = false

func _on_area_2d_body_entered(body):
	collide.emit()
