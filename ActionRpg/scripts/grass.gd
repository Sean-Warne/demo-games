extends Node2D

func create_grass_effect():
	var grass_effect = load("res://scenes/grass_effect.tscn").instantiate()
	
	get_parent().add_child(grass_effect)
	grass_effect.position = self.position

func _on_hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
