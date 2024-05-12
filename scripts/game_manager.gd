extends Node

var score = 0

@onready var hud: CanvasLayer = $HUD

func start_game():
	new_game()
	hud.show()
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
func add_point():
	score += 1
	hud.update_score(score)

func _on_hud_start_game():
	new_game()

func new_game():
	hud.update_score(0)
	
func game_over():
	score = 0
	hud.update_score(score)
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
