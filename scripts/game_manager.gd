extends Node

var score = 0
@onready var score_label: Label = $"../Labels/ScoreLabel"

func add_point():
	score += 1
	score_label.text = "You have collected " + str(score) + " coins"
