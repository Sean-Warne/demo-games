extends Node2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		var grass_effect = load("res://scenes/grass_effect.tscn").instantiate()
		
		get_parent().add_child(grass_effect)
		grass_effect.position = self.position
		
		queue_free()
