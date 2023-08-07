extends Node2D

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

func _ready():
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
	menu.show_game_over(self.score)

func player_score():
	self.score += 1

func _on_obstacle_created(obstacle):
	obstacle.score.connect(player_score)
	obstacle.collide.connect(end_game)
