extends Node2D

@onready var player = $Player
@onready var button = $Button

func _ready():
	pass

func _process(delta):
	pass


func _on_button_pressed():
	player.start()
	button.hide()
