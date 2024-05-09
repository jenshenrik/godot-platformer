extends Control

@onready var play_button: Button = $VBoxContainer/PlayButton

func _ready():
	play_button.grab_focus()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
