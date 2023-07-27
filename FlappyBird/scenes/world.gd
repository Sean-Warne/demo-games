extends Node2D

@onready var player = $Player
@onready var button = $Button

@onready var obstacle = preload("res://scenes/obstacle.tscn")

const OBSTACLE_MAX_HEIGHT = 720
const OBSTACLE_MIN_HEIGHT = 100
const OBSTACLE_DISTANCE   = 200
const OBSTACLE_START_POS  = 500
const MAX_OBSTACLES = 3

func _ready():
	var obstacles = 0

func _process(delta):
	pass

func _on_button_pressed():
	player.start()
	button.hide()
	
	spawn_obstacles()

func spawn_obstacles():
	var i = 0
	
	if i < 1:
		var obstacle_instance = obstacle.instantiate()
		add_child(obstacle_instance)
		obstacle_instance.position.x = 600
		i += 1
