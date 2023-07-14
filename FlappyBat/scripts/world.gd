extends Node2D

var SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/viewport_height")

func _process(delta):
	$Camera2D.position.x = $player.position.x

	if $player.position.y > SCREEN_HEIGHT or $player.position.y < 0:
		game_over()

func game_over():
	pass
