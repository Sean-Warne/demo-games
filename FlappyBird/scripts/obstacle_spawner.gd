extends Node2D

signal obstacle_created(obstacle)

@onready var obstacle = preload("res://scenes/obstacle.tscn")
@onready var timer = $Timer

func _ready():
	randomize()

func spawn_obstacle():
	# create instance of the obstacle scene
	var obstacle_instance = obstacle.instantiate()

	# set the position
	obstacle_instance.position.y = randi_range(150, 550)
	
	# add to the scene
	add_child(obstacle_instance)
	
	# emit the obstacle creation signal
	obstacle_created.emit(obstacle_instance)

func start():
	timer.start()

func stop():
	timer.stop()

func _on_timer_timeout():
	spawn_obstacle()
