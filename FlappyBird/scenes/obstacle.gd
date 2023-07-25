extends Node2D

const SPEED = -170

func _physics_process(delta):
	position.x += SPEED * delta
	
	if global_position.x <= -200:
		global_position.x = 600
		global_position.y = randi_range(210, 470)


func _on_obstacle_body_entered(body):
	print("OBSTACLE HIT")
	print(body)


func _on_score_zone_body_exited(body):
	print("SCORE!")
