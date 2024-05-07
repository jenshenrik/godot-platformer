extends CanvasLayer

@onready var score_label = $ScoreLabel

func update_score(score):
	score_label.text = str(score)
