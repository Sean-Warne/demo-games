extends Node2D

const SPEED = -170

func _on_ready():
	pass

func _physics_process(delta):
	move(delta)

func move(delta):
	print(position.x)
	position.x += SPEED * delta
	if global_position.x <= -200:
		self.queue_free()

func _on_obstacle_body_entered(body):
	print("OBSTACLE HIT")
	print(body)

func _on_score_zone_body_exited(body):
	print("SCORE!")
