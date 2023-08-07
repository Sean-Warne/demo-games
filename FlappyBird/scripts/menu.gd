extends CanvasLayer

signal start_game

@onready var start_message = $StartMenu/StartMessage
@onready var game_over_menu = $GameOverMenu
@onready var score_label = $GameOverMenu/ScoresBox/ScoreLabel
@onready var high_score_label = $GameOverMenu/ScoresBox/HighScoreLabel

var started = false

func _input(event):
	if event.is_action_pressed("Flap") && not started:
		started = true
		start_game.emit()
		
		var tween = create_tween()
		tween.tween_property(start_message, "modulate:a", 0, 0.5)
		tween.play()

func show_game_over(score, high_score):
	score_label.text      = "SCORE: " + str(score)
	high_score_label.text = "BEST:  " + str(high_score)
	game_over_menu.visible = true

func hide_game_over():
	game_over_menu.visible = false

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
