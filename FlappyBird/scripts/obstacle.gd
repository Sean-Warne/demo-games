extends Node2D

signal score
signal collide

const SPEED = -170

@onready var score_audio = $ScoreAudio

var obstacle_hit = false

func _physics_process(delta):
	position.x += SPEED * delta
	if global_position.x <= -100:
		queue_free()

func _on_obstacle_body_entered(_body):
	obstacle_hit = true
	collide.emit()

func _on_score_zone_body_exited(_body):
	if not obstacle_hit:
		score_audio.play()
		score.emit()
