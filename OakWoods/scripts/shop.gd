extends Node2D

@onready var shop_animated_sprite_2d = $ShopAnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	shop_animated_sprite_2d.play()
