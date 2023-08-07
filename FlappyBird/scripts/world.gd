extends Node2D

const SAVE_FILE_PATH = "user://savedata.tres"

@onready var menu = $Menu
@onready var hud = $HUD
@onready var player = $Player
@onready var obstacle_spawner = $ObstacleSpawner
@onready var ground = $Ground

var score:
	set(new_score):
		score = new_score
		hud.update_score(score)
	get:
		return score

var high_score = 0

func _ready():
	load_score()
	obstacle_spawner.obstacle_created.connect(_on_obstacle_created)
	ground.collide.connect(end_game)
	menu.start_game.connect(start_game)
	ground.start()
	
func start_game():
	self.score = 0
	player.start()
	obstacle_spawner.start()

func end_game():
	player.stop()
	ground.stop()
	obstacle_spawner.stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	
	# set the high score
	if score > high_score:
		high_score = score
		save_score(high_score)
	
	menu.show_game_over(score, high_score)

func player_score():
	self.score += 1

func save_score(new_score):
	var save_game = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	save_game.store_64(new_score)
	save_game.close()

func load_score():
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return # no file to load
	
	var save_game = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	high_score = save_game.get_64()
	save_game.close()

func _on_obstacle_created(obstacle):
	obstacle.score.connect(player_score)
	obstacle.collide.connect(end_game)
