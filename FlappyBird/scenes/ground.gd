extends StaticBody2D

const SPEED = -170

@onready var sprite_2d = $Sprite2D
@onready var sprite_2d_2 = $Sprite2D2

func _process(delta):
	if position.x <= -500:
		position.x = 0
	else:
		position.x += SPEED * delta
