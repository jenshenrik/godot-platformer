extends Node

var score = 0
@onready var hud = %HUD

func add_point():
	score += 1
	hud.update_score(score)

func _on_hud_start_game():
	new_game()

func new_game():
	hud.update_score(0)
	
func game_over():
	pass
