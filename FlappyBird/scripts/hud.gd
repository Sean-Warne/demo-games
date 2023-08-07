extends CanvasLayer

@onready var score = $Score

func update_score(new_score):
	score.text = str(new_score)
